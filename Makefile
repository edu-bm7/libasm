AS = nasm
CC = gcc
NAME = libasm.a
CFLAGS = -g -Wall -Wextra -pedantic -Werror
LDFLAGS = -L. -lasm
ASFLAGS = -g -F dwarf -Werror
ALL_ASFLAGS = -f elf64
ALL_LDFLAGS = -pie -Wl,--fatal-warnings
SRCS_DIR = ./
BONUS_DIR = ./
ALL_CFLAGS += -fPIE -m64 $(CFLAGS)
ALL_LDFLAGS += $(LDFLAGS)
ALL_ASFLAGS += $(ASFLAGS)
SRCS = $(addprefix $(SRCS_DIR), ft_strlen.s\
				ft_strcpy.s\
				ft_strcmp.s\
				ft_write.s\
				ft_read.s\
				ft_strdup.s\
				)
BONUS_SRCS = $(addprefix $(BONUS_DIR), ft_atoi_base_bonus.s\
	     			ft_list_push_front_bonus.s\
				ft_list_size_bonus.s\
				ft_list_sort_bonus.s\
				ft_list_remove_if_bonus.s\
	     					)

C_OBJS = $(patsubst %.c, %.o, $(wildcard *.c))
AS_OBJS = $(patsubst %.s, %.o, $(SRCS))
AS_BONUS_OBJS = $(patsubst %.s, %.o, $(BONUS_SRCS))

CC_CMD = $(CC) $(ALL_CFLAGS) -c -o $@ $<

$(NAME): $(AS_OBJS)
	@ar rcs $(NAME) $?
	@echo "--------------------------"
	@echo "Libasm created and indexed."
	@echo "--------------------------"

all: $(NAME)

bonus: $(NAME) $(AS_BONUS_OBJS)
	@ar rcs $(NAME) $?
	@echo "--------------------------------------"
	@echo "Libasm with bonus created and indexed."
	@echo "--------------------------------------"


tests: bonus $(C_OBJS)
	$(CC) $(ALL_CFLAGS) $(C_OBJS) -o $@ $(ALL_LDFLAGS)

%.o: %.s
	$(AS) $(ALL_ASFLAGS) -o $@ $<

%.o: %.c
	$(CC_CMD)

clean:
	rm -f *.o

fclean: clean
	rm -f tests libasm.a

re: fclean bonus tests

.PHONY: all clean fclean

