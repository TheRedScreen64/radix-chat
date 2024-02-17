/// collection of ansi escape codes
/// those are used to interact with the terminal appl
/// extracted from https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797
/// @author Noah Nagel

#ifndef ANSI_H
#define ANSI_H

#ifdef __cplusplus
extern "C"
{
#endif

/* Cursor Controls */
#define AC_CURSOR_HOME "\e[H"
#define AC_CURSOR_MOVE(line, column) "\e[" #line ";" #column "H"
#define AC_CURSOR_UP(lines) "\e[" #lines "A"
#define AC_CURSOR_DOWN(lines) "\e[" #lines "B"
#define AC_CURSOR_RIGHT(columns) "\e[" #columns "C"
#define AC_CURSOR_LEFT(columns) "\e[" #columns "D"
#define AC_CURSOR_NEXT_LINE(lines) "\e[" #lines "E"
#define AC_CURSOR_PREV_LINE(lines) "\e[" #lines "F"
#define AC_CURSOR_SET_COLUMN(column) "\e[" #column "G"
#define AC_CURSOR_REPORT_POSITION "\e[6n"
#define AC_CURSOR_SCROLL_UP "\e M"
#define AC_CURSOR_SAVE_POSITION "\e 7"
#define AC_CURSOR_RESTORE_POSITION "\e 8"
#define AC_CURSOR_SAVE_POSITION_SCO "\e[s"
#define AC_CURSOR_RESTORE_POSITION_SCO "\e[u"

/* Erase Functions */ 
#define AC_ERASE_DISPLAY "\e[J"
#define AC_ERASE_DISPLAY_CURSOR_END "\e[0J"
#define AC_ERASE_DISPLAY_START_CURSOR "\e[1J"
#define AC_ERASE_ENTIRE_SCREEN "\e[2J"
#define AC_ERASE_SAVED_LINES "\e[3J"
#define AC_ERASE_LINE "\e[K"
#define AC_ERASE_LINE_CURSOR_END "\e[0K"
#define AC_ERASE_LINE_START_CURSOR "\e[1K"
#define AC_ERASE_ENTIRE_LINE "\e[2K"

/* Colors / Graphics Mode */
#define AC_SET_GRAPHICS_MODE(...) "\e[1;34;" #__VA_ARGS__ "m"
#define AC_RESET_GRAPHICS_MODE "\e[0m"
#define AC_SET_BOLD_MODE "\e[1m"
#define AC_RESET_BOLD_MODE "\e[22m"
#define AC_SET_DIM_MODE "\e[2m"
#define AC_RESET_DIM_MODE "\e[22m"
#define AC_SET_ITALIC_MODE "\e[3m"
#define AC_RESET_ITALIC_MODE "\e[23m"
#define AC_SET_UNDERLINE_MODE "\e[4m"
#define AC_RESET_UNDERLINE_MODE "\e[24m"
#define AC_SET_BLINKING_MODE "\e[5m"
#define AC_RESET_BLINKING_MODE "\e[25m"
#define AC_SET_INVERSE_MODE "\e[7m"
#define AC_RESET_INVERSE_MODE "\e[27m"
#define AC_SET_HIDDEN_MODE "\e[8m"
#define AC_RESET_HIDDEN_MODE "\e[28m"
#define AC_SET_STRIKETHROUGH_MODE "\e[9m"
#define AC_RESET_STRIKETHROUGH_MODE "\e[29m"

/* Color codes */
#define AC_SET_COLOR(fg, bg) "\e[" #fg ";" #bg "m"

#define AC_BOLD AC_SET_BOLD_MODE
#define AC_ITALIC AC_SET_ITALIC_MODE
#define AC_BLINKING AC_SET_BLINKING_MODE
#define AC_UNDERLINE AC_SET_UNDERLINE_MODE

#define AC_BLACK "\e[30m" /* set text color to BLACK */
#define AC_RED "\e[31m" /* set text color to RED */
#define AC_GREEN "\e[32m" /* set text color to GREEN */
#define AC_YELLOW "\e[33m" /* set text color to YELLOW */
#define AC_BLUE "\e[34m" /* set text color to BLUE */
#define AC_MAGENTA "\e[35m" /* set text color to MAGENTA */
#define AC_CYAN "\e[36m" /* set text color to CYAN */
#define AC_WHITE "\e[37m" /* set text color to WHITE */
#define AC_DEFAULT "\e[39m" /* set text color to DEFAULT */

#define AC_R AC_RESET_GRAPHICS_MODE /* reset color */
#define AC_RESET AC_RESET_GRAPHICS_MODE

/* Bright (Bold) Colors */
#define AC_BRIGHTBLACK "\e[1;30m"
#define AC_BRIGHTRED "\e[1;31m"
#define AC_BRIGHTGREEN "\e[1;32m"
#define AC_BRIGHTYELLOW "\e[1;33m"
#define AC_BRIGHTBLUE "\e[1;34m"
#define AC_BRIGHTMAGENTA "\e[1;35m"
#define AC_BRIGHTCYAN "\e[1;36m"
#define AC_BRIGHTWHITE "\e[1;37m"

/* RGB Colors */
#define AC_FROM_RGB(r, g, b) "\e[38;2;" #r ";" #g ";" #b "m" /* set color from r g b code */

/* Screen Modes */
#define AC_SET_SCREEN_MODE(value) "\e[=" #value "h"
#define AC_RESET_SCREEN_MODE(value) "\e[=" #value "l"

/* Common Private Modes */
#define AC_MAKE_CURSOR_INVISIBLE "\e[?25l"
#define AC_MAKE_CURSOR_VISIBLE "\e[?25h"
#define AC_RESTORE_SCREEN "\e[?47l"
#define AC_SAVE_SCREEN "\e[?47h"
#define AC_ENABLE_ALTERNATIVE_BUFFER "\e[?1049h"
#define AC_DISABLE_ALTERNATIVE_BUFFER "\e[?1049l"

/* utility */
#define _AC_ERRORTEXT_ " [" AC_RED AC_BOLD "ERROR" AC_RESET "] "
#define AC_ERRORTEXT_ "[" AC_RED AC_BOLD "ERROR" AC_RESET "] "
#define AC_ERRORTEXT "[" AC_RED AC_BOLD "ERROR" AC_RESET "]"

#ifdef __cplusplus
}
#endif
#endif