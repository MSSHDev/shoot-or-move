#include <termios.h>
#include <unistd.h>
#include <stdio.h>

static struct termios oldt;
static int raw_mode_active = 0;

static void enable_raw_mode(void) {
    struct termios newt;
    tcgetattr(STDIN_FILENO, &oldt);
    newt = oldt;
    newt.c_lflag &= ~(ICANON | ECHO);
    tcsetattr(STDIN_FILENO, TCSANOW, &newt);
    raw_mode_active = 1;
}

static void disable_raw_mode(void) {
    if (raw_mode_active) {
        tcsetattr(STDIN_FILENO, TCSANOW, &oldt);
        raw_mode_active = 0;
    }
}

int getch(void) {
    enable_raw_mode();

    int c = getchar();

    if (c == 27) {
        int c2 = getchar();
        if (c2 == '[') {
            int c3 = getchar();
            disable_raw_mode();
            if (c3 == 'A') return 72;
            if (c3 == 'B') return 80;
            if (c3 == 'C') return 77;
            if (c3 == 'D') return 75;
            return 0;
        }
        disable_raw_mode();
        return 27;
    }

    disable_raw_mode();
    return c;
}