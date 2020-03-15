/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x8ef4fb42 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "D:/MUTProject/KC705/PartialReconfigWithout9B/FPAdder/AddSubB/BShifter23_Left.vhd";
extern char *IEEE_P_2592010699;



static void work_a_0661085492_1516540902_p_0(char *t0)
{
    char t15[16];
    char t17[16];
    char *t1;
    char *t2;
    int t3;
    unsigned int t4;
    unsigned int t5;
    unsigned int t6;
    unsigned char t7;
    unsigned char t8;
    char *t9;
    char *t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    char *t14;
    char *t16;
    char *t18;
    char *t19;
    int t20;
    unsigned int t21;
    unsigned char t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;

LAB0:    xsi_set_current_line(41, ng0);
    t1 = (t0 + 684U);
    t2 = *((char **)t1);
    t3 = (0 - 4);
    t4 = (t3 * -1);
    t5 = (1U * t4);
    t6 = (0 + t5);
    t1 = (t2 + t6);
    t7 = *((unsigned char *)t1);
    t8 = (t7 == (unsigned char)3);
    if (t8 != 0)
        goto LAB3;

LAB4:
LAB7:    t27 = (t0 + 592U);
    t28 = *((char **)t27);
    t27 = (t0 + 2896);
    t29 = (t27 + 32U);
    t30 = *((char **)t29);
    t31 = (t30 + 40U);
    t32 = *((char **)t31);
    memcpy(t32, t28, 23U);
    xsi_driver_first_trans_fast(t27);

LAB2:    t33 = (t0 + 2812);
    *((int *)t33) = 1;

LAB1:    return;
LAB3:    t9 = (t0 + 592U);
    t10 = *((char **)t9);
    t11 = (22 - 21);
    t12 = (t11 * 1U);
    t13 = (0 + t12);
    t9 = (t10 + t13);
    t16 = ((IEEE_P_2592010699) + 2332);
    t18 = (t17 + 0U);
    t19 = (t18 + 0U);
    *((int *)t19) = 21;
    t19 = (t18 + 4U);
    *((int *)t19) = 0;
    t19 = (t18 + 8U);
    *((int *)t19) = -1;
    t20 = (0 - 21);
    t21 = (t20 * -1);
    t21 = (t21 + 1);
    t19 = (t18 + 12U);
    *((unsigned int *)t19) = t21;
    t14 = xsi_base_array_concat(t14, t15, t16, (char)97, t9, t17, (char)99, (unsigned char)2, (char)101);
    t21 = (22U + 1U);
    t22 = (23U != t21);
    if (t22 == 1)
        goto LAB5;

LAB6:    t19 = (t0 + 2896);
    t23 = (t19 + 32U);
    t24 = *((char **)t23);
    t25 = (t24 + 40U);
    t26 = *((char **)t25);
    memcpy(t26, t14, 23U);
    xsi_driver_first_trans_fast(t19);
    goto LAB2;

LAB5:    xsi_size_not_matching(23U, t21, 0);
    goto LAB6;

LAB8:    goto LAB2;

}

static void work_a_0661085492_1516540902_p_1(char *t0)
{
    char t17[16];
    char t19[16];
    char t24[16];
    char *t1;
    char *t2;
    int t3;
    unsigned int t4;
    unsigned int t5;
    unsigned int t6;
    unsigned char t7;
    unsigned char t8;
    char *t9;
    char *t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    char *t14;
    char *t16;
    char *t18;
    char *t20;
    char *t21;
    int t22;
    unsigned int t23;
    char *t25;
    int t26;
    unsigned char t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;

LAB0:    xsi_set_current_line(43, ng0);
    t1 = (t0 + 684U);
    t2 = *((char **)t1);
    t3 = (1 - 4);
    t4 = (t3 * -1);
    t5 = (1U * t4);
    t6 = (0 + t5);
    t1 = (t2 + t6);
    t7 = *((unsigned char *)t1);
    t8 = (t7 == (unsigned char)3);
    if (t8 != 0)
        goto LAB3;

LAB4:
LAB7:    t32 = (t0 + 868U);
    t33 = *((char **)t32);
    t32 = (t0 + 2932);
    t34 = (t32 + 32U);
    t35 = *((char **)t34);
    t36 = (t35 + 40U);
    t37 = *((char **)t36);
    memcpy(t37, t33, 23U);
    xsi_driver_first_trans_fast(t32);

LAB2:    t38 = (t0 + 2820);
    *((int *)t38) = 1;

LAB1:    return;
LAB3:    t9 = (t0 + 868U);
    t10 = *((char **)t9);
    t11 = (22 - 20);
    t12 = (t11 * 1U);
    t13 = (0 + t12);
    t9 = (t10 + t13);
    t14 = (t0 + 5447);
    t18 = ((IEEE_P_2592010699) + 2332);
    t20 = (t19 + 0U);
    t21 = (t20 + 0U);
    *((int *)t21) = 20;
    t21 = (t20 + 4U);
    *((int *)t21) = 0;
    t21 = (t20 + 8U);
    *((int *)t21) = -1;
    t22 = (0 - 20);
    t23 = (t22 * -1);
    t23 = (t23 + 1);
    t21 = (t20 + 12U);
    *((unsigned int *)t21) = t23;
    t21 = (t24 + 0U);
    t25 = (t21 + 0U);
    *((int *)t25) = 0;
    t25 = (t21 + 4U);
    *((int *)t25) = 1;
    t25 = (t21 + 8U);
    *((int *)t25) = 1;
    t26 = (1 - 0);
    t23 = (t26 * 1);
    t23 = (t23 + 1);
    t25 = (t21 + 12U);
    *((unsigned int *)t25) = t23;
    t16 = xsi_base_array_concat(t16, t17, t18, (char)97, t9, t19, (char)97, t14, t24, (char)101);
    t23 = (21U + 2U);
    t27 = (23U != t23);
    if (t27 == 1)
        goto LAB5;

LAB6:    t25 = (t0 + 2932);
    t28 = (t25 + 32U);
    t29 = *((char **)t28);
    t30 = (t29 + 40U);
    t31 = *((char **)t30);
    memcpy(t31, t16, 23U);
    xsi_driver_first_trans_fast(t25);
    goto LAB2;

LAB5:    xsi_size_not_matching(23U, t23, 0);
    goto LAB6;

LAB8:    goto LAB2;

}

static void work_a_0661085492_1516540902_p_2(char *t0)
{
    char t17[16];
    char t19[16];
    char t24[16];
    char *t1;
    char *t2;
    int t3;
    unsigned int t4;
    unsigned int t5;
    unsigned int t6;
    unsigned char t7;
    unsigned char t8;
    char *t9;
    char *t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    char *t14;
    char *t16;
    char *t18;
    char *t20;
    char *t21;
    int t22;
    unsigned int t23;
    char *t25;
    int t26;
    unsigned char t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;

LAB0:    xsi_set_current_line(45, ng0);
    t1 = (t0 + 684U);
    t2 = *((char **)t1);
    t3 = (2 - 4);
    t4 = (t3 * -1);
    t5 = (1U * t4);
    t6 = (0 + t5);
    t1 = (t2 + t6);
    t7 = *((unsigned char *)t1);
    t8 = (t7 == (unsigned char)3);
    if (t8 != 0)
        goto LAB3;

LAB4:
LAB7:    t32 = (t0 + 960U);
    t33 = *((char **)t32);
    t32 = (t0 + 2968);
    t34 = (t32 + 32U);
    t35 = *((char **)t34);
    t36 = (t35 + 40U);
    t37 = *((char **)t36);
    memcpy(t37, t33, 23U);
    xsi_driver_first_trans_fast(t32);

LAB2:    t38 = (t0 + 2828);
    *((int *)t38) = 1;

LAB1:    return;
LAB3:    t9 = (t0 + 960U);
    t10 = *((char **)t9);
    t11 = (22 - 18);
    t12 = (t11 * 1U);
    t13 = (0 + t12);
    t9 = (t10 + t13);
    t14 = (t0 + 5449);
    t18 = ((IEEE_P_2592010699) + 2332);
    t20 = (t19 + 0U);
    t21 = (t20 + 0U);
    *((int *)t21) = 18;
    t21 = (t20 + 4U);
    *((int *)t21) = 0;
    t21 = (t20 + 8U);
    *((int *)t21) = -1;
    t22 = (0 - 18);
    t23 = (t22 * -1);
    t23 = (t23 + 1);
    t21 = (t20 + 12U);
    *((unsigned int *)t21) = t23;
    t21 = (t24 + 0U);
    t25 = (t21 + 0U);
    *((int *)t25) = 0;
    t25 = (t21 + 4U);
    *((int *)t25) = 3;
    t25 = (t21 + 8U);
    *((int *)t25) = 1;
    t26 = (3 - 0);
    t23 = (t26 * 1);
    t23 = (t23 + 1);
    t25 = (t21 + 12U);
    *((unsigned int *)t25) = t23;
    t16 = xsi_base_array_concat(t16, t17, t18, (char)97, t9, t19, (char)97, t14, t24, (char)101);
    t23 = (19U + 4U);
    t27 = (23U != t23);
    if (t27 == 1)
        goto LAB5;

LAB6:    t25 = (t0 + 2968);
    t28 = (t25 + 32U);
    t29 = *((char **)t28);
    t30 = (t29 + 40U);
    t31 = *((char **)t30);
    memcpy(t31, t16, 23U);
    xsi_driver_first_trans_fast(t25);
    goto LAB2;

LAB5:    xsi_size_not_matching(23U, t23, 0);
    goto LAB6;

LAB8:    goto LAB2;

}

static void work_a_0661085492_1516540902_p_3(char *t0)
{
    char t17[16];
    char t19[16];
    char t24[16];
    char *t1;
    char *t2;
    int t3;
    unsigned int t4;
    unsigned int t5;
    unsigned int t6;
    unsigned char t7;
    unsigned char t8;
    char *t9;
    char *t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    char *t14;
    char *t16;
    char *t18;
    char *t20;
    char *t21;
    int t22;
    unsigned int t23;
    char *t25;
    int t26;
    unsigned char t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;

LAB0:    xsi_set_current_line(47, ng0);
    t1 = (t0 + 684U);
    t2 = *((char **)t1);
    t3 = (3 - 4);
    t4 = (t3 * -1);
    t5 = (1U * t4);
    t6 = (0 + t5);
    t1 = (t2 + t6);
    t7 = *((unsigned char *)t1);
    t8 = (t7 == (unsigned char)3);
    if (t8 != 0)
        goto LAB3;

LAB4:
LAB7:    t32 = (t0 + 1052U);
    t33 = *((char **)t32);
    t32 = (t0 + 3004);
    t34 = (t32 + 32U);
    t35 = *((char **)t34);
    t36 = (t35 + 40U);
    t37 = *((char **)t36);
    memcpy(t37, t33, 23U);
    xsi_driver_first_trans_fast(t32);

LAB2:    t38 = (t0 + 2836);
    *((int *)t38) = 1;

LAB1:    return;
LAB3:    t9 = (t0 + 1052U);
    t10 = *((char **)t9);
    t11 = (22 - 14);
    t12 = (t11 * 1U);
    t13 = (0 + t12);
    t9 = (t10 + t13);
    t14 = (t0 + 5453);
    t18 = ((IEEE_P_2592010699) + 2332);
    t20 = (t19 + 0U);
    t21 = (t20 + 0U);
    *((int *)t21) = 14;
    t21 = (t20 + 4U);
    *((int *)t21) = 0;
    t21 = (t20 + 8U);
    *((int *)t21) = -1;
    t22 = (0 - 14);
    t23 = (t22 * -1);
    t23 = (t23 + 1);
    t21 = (t20 + 12U);
    *((unsigned int *)t21) = t23;
    t21 = (t24 + 0U);
    t25 = (t21 + 0U);
    *((int *)t25) = 0;
    t25 = (t21 + 4U);
    *((int *)t25) = 7;
    t25 = (t21 + 8U);
    *((int *)t25) = 1;
    t26 = (7 - 0);
    t23 = (t26 * 1);
    t23 = (t23 + 1);
    t25 = (t21 + 12U);
    *((unsigned int *)t25) = t23;
    t16 = xsi_base_array_concat(t16, t17, t18, (char)97, t9, t19, (char)97, t14, t24, (char)101);
    t23 = (15U + 8U);
    t27 = (23U != t23);
    if (t27 == 1)
        goto LAB5;

LAB6:    t25 = (t0 + 3004);
    t28 = (t25 + 32U);
    t29 = *((char **)t28);
    t30 = (t29 + 40U);
    t31 = *((char **)t30);
    memcpy(t31, t16, 23U);
    xsi_driver_first_trans_fast(t25);
    goto LAB2;

LAB5:    xsi_size_not_matching(23U, t23, 0);
    goto LAB6;

LAB8:    goto LAB2;

}

static void work_a_0661085492_1516540902_p_4(char *t0)
{
    char t17[16];
    char t19[16];
    char t24[16];
    char *t1;
    char *t2;
    int t3;
    unsigned int t4;
    unsigned int t5;
    unsigned int t6;
    unsigned char t7;
    unsigned char t8;
    char *t9;
    char *t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    char *t14;
    char *t16;
    char *t18;
    char *t20;
    char *t21;
    int t22;
    unsigned int t23;
    char *t25;
    int t26;
    unsigned char t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;

LAB0:    xsi_set_current_line(49, ng0);
    t1 = (t0 + 684U);
    t2 = *((char **)t1);
    t3 = (4 - 4);
    t4 = (t3 * -1);
    t5 = (1U * t4);
    t6 = (0 + t5);
    t1 = (t2 + t6);
    t7 = *((unsigned char *)t1);
    t8 = (t7 == (unsigned char)3);
    if (t8 != 0)
        goto LAB3;

LAB4:
LAB7:    t32 = (t0 + 1144U);
    t33 = *((char **)t32);
    t32 = (t0 + 3040);
    t34 = (t32 + 32U);
    t35 = *((char **)t34);
    t36 = (t35 + 40U);
    t37 = *((char **)t36);
    memcpy(t37, t33, 23U);
    xsi_driver_first_trans_fast(t32);

LAB2:    t38 = (t0 + 2844);
    *((int *)t38) = 1;

LAB1:    return;
LAB3:    t9 = (t0 + 1144U);
    t10 = *((char **)t9);
    t11 = (22 - 6);
    t12 = (t11 * 1U);
    t13 = (0 + t12);
    t9 = (t10 + t13);
    t14 = (t0 + 5461);
    t18 = ((IEEE_P_2592010699) + 2332);
    t20 = (t19 + 0U);
    t21 = (t20 + 0U);
    *((int *)t21) = 6;
    t21 = (t20 + 4U);
    *((int *)t21) = 0;
    t21 = (t20 + 8U);
    *((int *)t21) = -1;
    t22 = (0 - 6);
    t23 = (t22 * -1);
    t23 = (t23 + 1);
    t21 = (t20 + 12U);
    *((unsigned int *)t21) = t23;
    t21 = (t24 + 0U);
    t25 = (t21 + 0U);
    *((int *)t25) = 0;
    t25 = (t21 + 4U);
    *((int *)t25) = 15;
    t25 = (t21 + 8U);
    *((int *)t25) = 1;
    t26 = (15 - 0);
    t23 = (t26 * 1);
    t23 = (t23 + 1);
    t25 = (t21 + 12U);
    *((unsigned int *)t25) = t23;
    t16 = xsi_base_array_concat(t16, t17, t18, (char)97, t9, t19, (char)97, t14, t24, (char)101);
    t23 = (7U + 16U);
    t27 = (23U != t23);
    if (t27 == 1)
        goto LAB5;

LAB6:    t25 = (t0 + 3040);
    t28 = (t25 + 32U);
    t29 = *((char **)t28);
    t30 = (t29 + 40U);
    t31 = *((char **)t30);
    memcpy(t31, t16, 23U);
    xsi_driver_first_trans_fast(t25);
    goto LAB2;

LAB5:    xsi_size_not_matching(23U, t23, 0);
    goto LAB6;

LAB8:    goto LAB2;

}

static void work_a_0661085492_1516540902_p_5(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(51, ng0);

LAB3:    t1 = (t0 + 1236U);
    t2 = *((char **)t1);
    t1 = (t0 + 3076);
    t3 = (t1 + 32U);
    t4 = *((char **)t3);
    t5 = (t4 + 40U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 23U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 2852);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_0661085492_1516540902_init()
{
	static char *pe[] = {(void *)work_a_0661085492_1516540902_p_0,(void *)work_a_0661085492_1516540902_p_1,(void *)work_a_0661085492_1516540902_p_2,(void *)work_a_0661085492_1516540902_p_3,(void *)work_a_0661085492_1516540902_p_4,(void *)work_a_0661085492_1516540902_p_5};
	xsi_register_didat("work_a_0661085492_1516540902", "isim/tb_fpadder_isim_beh.exe.sim/work/a_0661085492_1516540902.didat");
	xsi_register_executes(pe);
}
