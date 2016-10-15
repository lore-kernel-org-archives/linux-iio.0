Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:60790 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752646AbcJOQlm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Oct 2016 12:41:42 -0400
Date: Sat, 15 Oct 2016 18:41:14 +0200 (CEST)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, linux-input@vger.kernel.org,
        pmeerw@pmeerw.net, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, dmitry.torokhov@gmail.com, harald@ccbib.org,
        fabio.estevam@freescale.com, linux-iio@vger.kernel.org,
        marex@denx.de
Message-ID: <417434821.363505.2bd73c71-f221-4323-833d-b752e7c41a53.open-xchange@email.1und1.de>
In-Reply-To: <cover.1475416202.git.ksenija.stanojevic@gmail.com>
References: <cover.1475416202.git.ksenija.stanojevic@gmail.com>
Subject: Re: [PATCH v7 0/5] mxs-lradc: Split driver into MFD
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Ksenija,

> Ksenija Stanojevic <ksenija.stanojevic@gmail.com> hat am 2. Oktober 2016 um
> 16:15 geschrieben:
> 
> 
> Split existing driver mxs-lradc into MFD with touchscreen and
> IIO part.

i'm back from holidays and wanted to test your patch series. Unfortunately patch
1-3 looks broken to me. Maybe you should wait for 4.9rc-1 and then resend the
patch series.

Stefan

> 
> Tested on I.MX28.
> 
> Ksenija Stanojevic (5):
>   mfd: mxs-lradc: Add support for mxs-lradc MFD
>   iio: adc: mxs-lradc: Add support for adc driver
>   input: touchscreen: mxs-lradc: Add support for touchscreen
>   iio: adc: mxs-lradc: Remove driver
>   mfd: Move binding document
> 
>  .../devicetree/bindings/iio/adc/mxs-lradc.txt      |   47 -
>  .../devicetree/bindings/mfd/mxs-lradc.txt          |   47 +
>  drivers/iio/adc/Kconfig                            |   27 +-
>  drivers/iio/adc/Makefile                           |    2 +-
>  drivers/iio/adc/mxs-lradc.c                        | 1750
> --------------------
>  drivers/input/touchscreen/Kconfig                  |   10 +
>  drivers/input/touchscreen/Makefile                 |    1 +
>  drivers/mfd/Kconfig                                |   17 +
>  drivers/mfd/Makefile                               |    1 +
>  9 files changed, 90 insertions(+), 1812 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/mxs-lradc.txt
>  delete mode 100644 drivers/iio/adc/mxs-lradc.c
> 
> -- 
> 1.9.1
>
