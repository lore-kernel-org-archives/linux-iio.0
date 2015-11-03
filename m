Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:37175 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562AbbKCP0P (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 3 Nov 2015 10:26:15 -0500
Received: by igbhv6 with SMTP id hv6so14674692igb.0
        for <linux-iio@vger.kernel.org>; Tue, 03 Nov 2015 07:26:15 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 3 Nov 2015 13:26:14 -0200
Message-ID: <CAOMZO5BxwngKrpHf4F_vVAgAskKABDEr4m7TtuZN2LSt-JJSQA@mail.gmail.com>
Subject: vf610_adc: Division by zero
From: Fabio Estevam <festevam@gmail.com>
To: Duan Fugang-B38611 <B38611@freescale.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Andy,

Enabling vf610-adc in a imx6sx dts file causes the following error:

[    2.196814] Hardware name: Freescale i.MX6 SoloX (Device Tree)
[    2.202652] Backtrace:
[    2.205156] [<c0013600>] (dump_backtrace) from [<c001379c>]
(show_stack+0x18/0x1c)
[    2.212730]  r6:ef138410 r5:00000000 r4:00000000 r3:00000000
[    2.218494] [<c0013784>] (show_stack) from [<c02d8220>]
(dump_stack+0x88/0xa4)
[    2.225756] [<c02d8198>] (dump_stack) from [<c001346c>] (__div0+0x18/0x20)
[    2.232636]  r5:00000001 r4:eeb0a800
[    2.236286] [<c0013454>] (__div0) from [<c02d6be4>] (Ldiv0+0x8/0x10)
[    2.242657] [<c0574574>] (vf610_adc_probe) from [<c03c9274>]
(platform_drv_probe+0x58/0xb4)
[    2.251038]  r10:00000000 r9:000000d8 r8:00000000 r7:c0b39ea4
r6:fffffdfb r5:ef138410
[    2.258980]  r4:fffffffe
[    2.261541] [<c03c921c>] (platform_drv_probe) from [<c03c7a30>]
(driver_probe_device+0x1e4/0x2b0)
[    2.270446]  r7:c0b39ea4 r6:00000000 r5:ef138410 r4:c13592f0
[    2.276211] [<c03c784c>] (driver_probe_device) from [<c03c7b98>]
(__driver_attach+0x9c/0xa0)
[    2.284677]  r8:c0ab91a0 r7:00000000 r6:ef138444 r5:c0b39ea4
r4:ef138410 r3:00000000
[    2.292517] [<c03c7afc>] (__driver_attach) from [<c03c5f4c>]
(bus_for_each_dev+0x5c/0x90)
[    2.300723]  r6:c03c7afc r5:c0b39ea4 r4:00000000 r3:ef11b55c
[    2.306486] [<c03c5ef0>] (bus_for_each_dev) from [<c03c730c>]
(driver_attach+0x20/0x28)
[    2.314519]  r6:c0b0e920 r5:eeaf8f80 r4:c0b39ea4
[    2.319199] [<c03c72ec>] (driver_attach) from [<c03c7070>]
(bus_add_driver+0xec/0x1fc)
[    2.327150] [<c03c6f84>] (bus_add_driver) from [<c03c842c>]
(driver_register+0x80/0xfc)
[    2.335182]  r7:c0ac884c r6:eeafb580 r5:c0ae5c58 r4:c0b39ea4
[    2.340919] [<c03c83ac>] (driver_register) from [<c03c9100>]
(__platform_driver_register+0x38/0x4c)
[    2.349993]  r5:c0ae5c58 r4:c0ae5c58
[    2.353639] [<c03c90c8>] (__platform_driver_register) from
[<c0ab91b8>] (vf610_adc_driver_init+0x18/0x20)
[    2.363243] [<c0ab91a0>] (vf610_adc_driver_init) from [<c00098bc>]
(do_one_initcall+0x88/0x1e4)
[    2.371956] [<c0009834>] (do_one_initcall) from [<c0a6ee64>]
(kernel_init_freeable+0x11c/0x1f0)
[    2.380682]  r10:c0ac8858 r9:000000d8 r8:00000000 r7:c0ac884c
r6:c0b50000 r5:00000006
[    2.388624]  r4:c0adac2c
[    2.391190] [<c0a6ed48>] (kernel_init_freeable) from [<c07b24fc>]
(kernel_init+0x10/0xf4)
[    2.399399]  r10:00000000 r9:00000000 r8:00000000 r7:00000000
r6:00000000 r5:c07b24ec
[    2.407344]  r4:00000000
[    2.409908] [<c07b24ec>] (kernel_init) from [<c000fe30>]
(ret_from_fork+0x14/0x24)
[    2.417507]  r4:00000000 r3:00000000

The problem is taht adck_rate is 0 and there is no protection for
calculating adck_period:


    if (adck_rate) {
        /* calculate clk divider which is within specification */
        divisor = ipg_rate / adck_rate;
        adc_feature->clk_div = 1 << fls(divisor + 1);
    } else {
        /* fall-back value using a safe divisor */
        adc_feature->clk_div = 8;
    }

    /*
     * Determine the long sample time adder value to be used based
     * on the default minimum sample time provided.
     */
    adck_period = NSEC_PER_SEC / adck_rate;


What would be the correct fix here?
