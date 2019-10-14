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
    xilinxcorelib_ver_m_00000000001358910285_3743172433_init();
    xilinxcorelib_ver_m_00000000001687936702_2444198090_init();
    xilinxcorelib_ver_m_00000000000277421008_4131857178_init();
    xilinxcorelib_ver_m_00000000001603977570_1414621552_init();
    work_m_00000000002489990758_1726253906_init();
    work_m_00000000003336508896_2253889944_init();
    work_m_00000000002696599448_1224297479_init();
    work_m_00000000004134447467_2073120511_init();


    xsi_register_tops("work_m_00000000002696599448_1224297479");
    xsi_register_tops("work_m_00000000004134447467_2073120511");


    return xsi_run_simulation(argc, argv);

}
