Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37364 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbbHEMNb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Aug 2015 08:13:31 -0400
From: Sanchayan Maity <maitysanchayan@gmail.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: stefan@agner.ch, B38611@freescale.com, hofrat@osadl.org,
	sanjeev_sharma@mentor.com, fabio.estevam@freescale.com,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	antoine.tenart@free-electrons.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sanchayan Maity <maitysanchayan@gmail.com>
Subject: [PATCH v2] Add continuous sampling with IIO buffers for Vybrid
Date: Wed,  5 Aug 2015 17:40:18 +0530
Message-Id: <cover.1438775572.git.maitysanchayan@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

This patch adds support for continuous sampling provided by the
ADC block on Vybrid by leveraging the IIO triggered buffer and
IIO sysfs trigger infrastructure.

The patch has been tested on Colibri VF50 and VF61 on shawn's
tree for-next branch with the patches [1] and [2] applied.

The below script was used for testing.

#!/bin/sh
echo 0 > /sys/bus/iio/devices/iio:device0/scan_elements/in_voltage8_en
echo 0 > /sys/bus/iio/devices/iio:device0/scan_elements/in_voltage9_en
echo 1 > /sys/bus/iio/devices/iio:device0/scan_elements/in_temp_en
echo 1 > /sys/bus/iio/devices/iio:device0/scan_elements/in_timestamp_en
echo 0 > /sys/bus/iio/devices/iio_sysfs_trigger/add_trigger
/home/root/generic_buffer -n 4003b000.adc -t sysfstrig0 -l 512 -c 10
echo 0 > /sys/bus/iio/devices/iio:device0/scan_elements/in_timestamp_en
echo 0 > /sys/bus/iio/devices/iio:device0/scan_elements/in_temp_en
echo 0 > /sys/bus/iio/devices/iio:device0/scan_elements/in_voltage8_en
echo 0 > /sys/bus/iio/devices/iio:device0/scan_elements/in_voltage9_en

Feedback and comments are most welcome.

Changes since v2:
1. Use a fixed size buffer instead of kmalloc allocated during update
scan mode
2. Remove a write to read only register ADC_HS (COCO bit)

Version 1 patch can be found here
http://www.spinics.net/lists/linux-iio/msg20053.html

[1]. https://lkml.org/lkml/2015/5/27/350
[2]. https://lkml.org/lkml/2015/7/14/395

Had some additional queries.

On shawn's tree, using imx_v6_v7_defconfig and running the above
script on VF50 gives me the following trace:

[  199.976662] INFO: rcu_sched self-detected stall on CPU
[  199.982015]  0: (2600 ticks this GP) idle=181/140000000000002/0 softirq=14591/14591 fqs=0
[  199.990406]   (t=2600 jiffies g=11024 c=11023 q=20)
[  199.995430] rcu_sched kthread starved for 2600 jiffies! g11024 c11023 f0x0
[  200.002523] Task dump for CPU 0:
[  200.005830] generic_buffer  R running      0   414    413 0x00000002
[  200.012370] Backtrace:
[  200.014974] [<80013708>] (dump_backtrace) from [<800138fc>] (show_stack+0x18/0x1c)
[  200.022665]  r7:80ae0f40 r6:80b374e8 r5:0000019d r4:85fdd080
[  200.028578] [<800138e4>] (show_stack) from [<800557bc>] (sched_show_task+0x11c/0x22c)
[  200.036555] [<800556a0>] (sched_show_task) from [<80057efc>] (dump_cpu_task+0x34/0x44)
[  200.044596]  r6:80000193 r5:80ae0f40 r4:00000000
[  200.049432] [<80057ec8>] (dump_cpu_task) from [<800820f8>] (rcu_dump_cpu_stacks+0x8c/0xd0)
[  200.057821]  r5:80ae0f40 r4:00000000
[  200.061563] [<8008206c>] (rcu_dump_cpu_stacks) from [<80085b88>] (rcu_check_callbacks+0x4dc/0x854)
[  200.070655]  r9:80ae0f40 r8:0720b000 r7:80ad09cc r6:80ae0f40 r5:80acd600 r4:87cd8600
[  200.078701] [<800856ac>] (rcu_check_callbacks) from [<80088820>] (update_process_times+0x40/0x6c)
[  200.087699]  r10:87cd5fc0 r9:8009a180 r8:80aedb80 r7:0000002e r6:8764c12d r5:00000000
[  200.095800]  r4:85fdd080
[  200.098462] [<800887e0>] (update_process_times) from [<8009a17c>] (tick_sched_handle.isra.19+0x4c/0x50)
[  200.108049]  r5:85e85d40 r4:87cd5fc0
[  200.111822] [<8009a130>] (tick_sched_handle.isra.19) from [<8009a1e4>] (tick_sched_timer+0x64/0xb0)
[  200.121098] [<8009a180>] (tick_sched_timer) from [<80089220>] (__hrtimer_run_queues+0xc4/0x1cc)
[  200.129989]  r7:0000002e r6:87649b3a r5:87cd5d00 r4:87cd5c80
[  200.135915] [<8008915c>] (__hrtimer_run_queues) from [<80089950>] (hrtimer_interrupt+0xc8/0x21c)
[  200.144898]  r10:87cd5d38 r9:87cd5d58 r8:87cd5c80 r7:87cd5cc0 r6:ffffffff r5:7fffffff
[  200.153061]  r4:00000003
[  200.155752] [<80089888>] (hrtimer_interrupt) from [<8054dcd0>] (gt_clockevent_interrupt+0x48/0x74)
[  200.164905]  r10:85e85f80 r9:87806000 r8:00000010 r7:87817b40 r6:87808100 r5:87cdab40
[  200.173082]  r4:00000001
[  200.175758] [<8054dc88>] (gt_clockevent_interrupt) from [<8007cab0>] (handle_percpu_devid_irq+0x8c/0xac)
[  200.185442]  r5:80aedd20 r4:87cdab40
[  200.189215] [<8007ca24>] (handle_percpu_devid_irq) from [<800786e4>] (generic_handle_irq+0x30/0x44)
[  200.198460]  r9:87806000 r8:00000001 r7:85e85e30 r6:80ad0b30 r5:00000010 r4:00000010
[  200.206567] [<800786b4>] (generic_handle_irq) from [<80078a08>] (__handle_domain_irq+0x6c/0xe8)
[  200.215455]  r5:00000010 r4:80acb5fc
[  200.219219] [<8007899c>] (__handle_domain_irq) from [<80009560>] (gic_handle_irq+0x28/0x68)
[  200.227759]  r9:87806000 r8:00000001 r7:88002100 r6:80ad0ca8 r5:8800210c r4:85e85d40
[  200.235861] [<80009538>] (gic_handle_irq) from [<80014564>] (__irq_svc+0x44/0x5c)
[  200.243526] Exception stack(0x85e85d40 to 0x85e85d88)
[  200.248720] 5d40: 00000001 85fdd548 00000000 85fdd080 00000202 00000000 80ad0b30 80ad0080
[  200.257104] 5d60: 00000001 87806000 85e85f80 85e85dcc 80c9f5d0 85e85d88 8006b5a0 8002ff80
[  200.265468] 5d80: 60000113 ffffffff
[  200.269056]  r7:85e85d74 r6:ffffffff r5:60000113 r4:8002ff80
[  200.274995] [<8002fec8>] (__do_softirq) from [<800304c8>] (irq_exit+0xc4/0x138)
[  200.282486]  r10:85e85f80 r9:87806000 r8:00000001 r7:00000000 r6:80ad0b30 r5:00000000
[  200.290660]  r4:80acb5fc
[  200.293345] [<80030404>] (irq_exit) from [<80078a10>] (__handle_domain_irq+0x74/0xe8)
[  200.301367]  r5:00000000 r4:80acb5fc
[  200.305135] [<8007899c>] (__handle_domain_irq) from [<80009560>] (gic_handle_irq+0x28/0x68)
[  200.313680]  r9:85efc60c r8:85e4bc00 r7:88002100 r6:80ad0ca8 r5:8800210c r4:85e85e30
[  200.321777] [<80009538>] (gic_handle_irq) from [<80014564>] (__irq_svc+0x44/0x5c)
[  200.329442] Exception stack(0x85e85e30 to 0x85e85e78)
[  200.334628] 5e20:                                     00000001 85fdd548 00000000 85fdd080
[  200.343010] 5e40: 00000001 803ce7c8 85e4bc00 00000000 85e4bc00 85efc60c 85e85f80 85e85e84
[  200.351384] 5e60: 80c9f5d0 85e85e78 8006b5a0 803ce7e8 60000013 ffffffff
[  200.358131]  r7:85e85e64 r6:ffffffff r5:60000013 r4:803ce7e8
[  200.364087] [<803ce7c8>] (dev_attr_store) from [<801739a0>] (sysfs_kf_write+0x54/0x58)
[  200.372217] [<8017394c>] (sysfs_kf_write) from [<80172b60>] (kernfs_fop_write+0xc4/0x1a8)
[  200.380579]  r7:00000000 r6:00000000 r5:00000001 r4:85efc600
[  200.386518] [<80172a9c>] (kernfs_fop_write) from [<80104f10>] (__vfs_write+0x2c/0xe0)
[  200.394535]  r10:00000000 r9:85e84000 r8:8000fc84 r7:85e85f80 r6:76fa3000 r5:85e85f80
[  200.402696]  r4:85fb2500
[  200.405376] [<80104ee4>] (__vfs_write) from [<801057b4>] (vfs_write+0x98/0x16c)
[  200.412865]  r8:8000fc84 r7:85e85f80 r6:76fa3000 r5:00000001 r4:85fb2500
[  200.419878] [<8010571c>] (vfs_write) from [<80106028>] (SyS_write+0x4c/0xa8)
[  200.427072]  r8:8000fc84 r7:00000001 r6:76fa3000 r5:85fb2500 r4:85fb2500
[  200.434099] [<80105fdc>] (SyS_write) from [<8000faa0>] (ret_fast_syscall+0x0/0x54)
[  200.441848]  r7:00000004 r6:76fa3000 r5:00000001 r4:002be960

On shawn's tree, using our own defconfig it all works fine.

The RCU related configs in imx_v6_v7_defconfig are:
# RCU Subsystem
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
# CONFIG_TASKS_RCU is not set
CONFIG_RCU_STALL_COMMON=y
# CONFIG_TREE_RCU_TRACE is not set
# CONFIG_RCU_NOCB_CPU is not set
# CONFIG_RCU_EXPEDITE_BOOT is not set
# RCU Debugging
CONFIG_PROVE_RCU=y
# CONFIG_PROVE_RCU_REPEATEDLY is not set
# CONFIG_SPARSE_RCU_POINTER is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_CPU_STALL_INFO=y
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set

The RCU related configs in our own defconfig are:
# RCU Subsystem
CONFIG_TINY_RCU=y
CONFIG_SRCU=y
# CONFIG_TASKS_RCU is not set
# CONFIG_RCU_STALL_COMMON is not set
# CONFIG_TREE_RCU_TRACE is not set
CONFIG_RCU_KTHREAD_PRIO=0
# RCU Debugging
# CONFIG_SPARSE_RCU_POINTER is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_TRACE is not set

With the above second set of configs I do not encounter any problems.

I do not have any knowledge on the RCU front, can someone also comment
with regards to that? Am I doing something wrong in the driver?
My guess would be those RCU STALL configs?

Thanks & Regards,
Sanchayan Maity.

Sanchayan Maity (1):
  iio: adc: vf610: Add IIO buffer support for Vybrid ADC

 drivers/iio/adc/Kconfig     |   4 ++
 drivers/iio/adc/vf610_adc.c | 107 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 105 insertions(+), 6 deletions(-)

-- 
2.5.0

