Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:55395 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbdA2Xzk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Jan 2017 18:55:40 -0500
Date: Mon, 30 Jan 2017 00:55:09 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Cc: lee.jones@linaro.org, linux-input@vger.kernel.org,
        pmeerw@pmeerw.net, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, linux-kernel@vger.kernel.org,
        dmitry.torokhov@gmail.com, harald@ccbib.org,
        fabio.estevam@freescale.com, linux-iio@vger.kernel.org,
        marex@denx.de
Message-ID: <1332233362.76422.1485734109212@email.1und1.de>
In-Reply-To: <d18975ff97a8855e9221b0a180b3664a0d04348c.1485711797.git.ksenija.stanojevic@gmail.com>
References: <cover.1485711797.git.ksenija.stanojevic@gmail.com>
 <d18975ff97a8855e9221b0a180b3664a0d04348c.1485711797.git.ksenija.stanojevic@gmail.com>
Subject: Re: [PATCH v13 3/5] input: touchscreen: mxs-lradc: Add support for
 touchscreen
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Ksenija,

> Ksenija Stanojevic <ksenija.stanojevic@gmail.com> hat am 29. Januar 2017 um 19:04 geschrieben:
> 
> 
> Add 4-wire/5-wire touchscreen controller.

i compiled all 3 driver as a module and kept the devicetree for the Olinuxino iMX233 [1] as it is (no touchscreen). After booting all 3 driver are loaded:

Module                  Size  Used by
mxs_lradc_adc          11000  0
industrialio_triggered_buffer     2628  1 mxs_lradc_adc
kfifo_buf               3337  1 industrialio_triggered_buffer
mxs_lradc_ts            4192  0
mxs_lradc               4402  0
mfd_core                4612  1 mxs_lradc

But the touchscreen driver threw this error:

[  427.230000] mxs-lradc-ts: probe of mxs-lradc-ts failed with error -22

I didn't expect this behavior. I expect that the touchscreen driver notice that there isn't a touchscreen property and abort probing silently. Also i didn't expected that the driver is still loaded in case of a probe error.

Btw shouldn't be the mxs_lradc_adc "Used by" mxs_lradc?

Because "modprobe -r mxs_lradc" doesn't unload mxs_lradc_adc.

[1] - http://lxr.free-electrons.com/source/arch/arm/boot/dts/imx23-olinuxino.dts
