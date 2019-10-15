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

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    work_m_00000000003183930105_2797236329_init();
    work_m_00000000000623393872_2192503009_init();
    xilinxcorelib_ver_m_00000000001358910285_3743172433_init();
    xilinxcorelib_ver_m_00000000001687936702_2444198090_init();
    xilinxcorelib_ver_m_00000000000277421008_0557569482_init();
    xilinxcorelib_ver_m_00000000001603977570_3260926842_init();
    work_m_00000000002489990758_4293778152_init();
    work_m_00000000003336508896_2253889944_init();
    work_m_00000000002447534190_0507028321_init();
    work_m_00000000000981183661_1520693549_init();
    xilinxcorelib_ver_m_00000000001358910285_3904265986_init();
    xilinxcorelib_ver_m_00000000001358910285_1465237985_init();
    xilinxcorelib_ver_m_00000000001687936702_0984770168_init();
    xilinxcorelib_ver_m_00000000000277421008_0758667565_init();
    xilinxcorelib_ver_m_00000000001603977570_0100217787_init();
    work_m_00000000003869038185_1720460815_init();
    work_m_00000000002605914569_1555137562_init();
    work_m_00000000002306794187_2247834001_init();
    work_m_00000000003866293691_2553114302_init();
    work_m_00000000002258057630_3515808994_init();
    work_m_00000000000056902171_2793982751_init();
    work_m_00000000004134447467_2073120511_init();


    xsi_register_tops("work_m_00000000000056902171_2793982751");
    xsi_register_tops("work_m_00000000004134447467_2073120511");


    return xsi_run_simulation(argc, argv);

}
