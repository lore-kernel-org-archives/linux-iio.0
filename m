Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:60617 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753500AbcLHXDf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Dec 2016 18:03:35 -0500
Subject: Re: [PATCH v11 0/5] mxs-lradc: Split driver into MFD
To: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel@vger.kernel.org
References: <cover.1481234322.git.ksenija.stanojevic@gmail.com>
Cc: lee.jones@linaro.org, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        harald@ccbib.org, stefan.wahren@i2se.com,
        fabio.estevam@freescale.com
From: Marek Vasut <marex@denx.de>
Message-ID: <51d581e9-a99a-cec4-efe9-3e5c896780da@denx.de>
Date: Fri, 9 Dec 2016 00:02:04 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1481234322.git.ksenija.stanojevic@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/08/2016 11:27 PM, Ksenija Stanojevic wrote:
> Split existing driver mxs-lradc into MFD with touchscreen and
> IIO part.
> 
> Tested on I.MX28
> 
> Ksenija Stanojevic (5):
>   mfd: mxs-lradc: Add support for mxs-lradc MFD
>   iio: adc: mxs-lradc: Add support for adc driver
>   input: touchscreen: mxs-lradc: Add support for touchscreen
>   iio: adc: mxs-lradc: Remove driver
>   mfd: Move binding document
> 
>  .../bindings/{iio/adc => mfd}/mxs-lradc.txt        |    0
>  drivers/iio/adc/Kconfig                            |   27 +-
>  drivers/iio/adc/Makefile                           |    2 +-
>  drivers/iio/adc/mxs-lradc-adc.c                    |  843 ++++++++++
>  drivers/iio/adc/mxs-lradc.c                        | 1750 --------------------
>  drivers/input/touchscreen/Kconfig                  |   10 +
>  drivers/input/touchscreen/Makefile                 |    1 +
>  drivers/input/touchscreen/mxs-lradc-ts.c           |  739 +++++++++
>  drivers/mfd/Kconfig                                |   17 +
>  drivers/mfd/Makefile                               |    1 +
>  drivers/mfd/mxs-lradc.c                            |  264 +++
>  include/linux/mfd/mxs-lradc.h                      |  187 +++
>  12 files changed, 2076 insertions(+), 1765 deletions(-)
>  rename Documentation/devicetree/bindings/{iio/adc => mfd}/mxs-lradc.txt (100%)
>  create mode 100644 drivers/iio/adc/mxs-lradc-adc.c
>  delete mode 100644 drivers/iio/adc/mxs-lradc.c
>  create mode 100644 drivers/input/touchscreen/mxs-lradc-ts.c
>  create mode 100644 drivers/mfd/mxs-lradc.c
>  create mode 100644 include/linux/mfd/mxs-lradc.h
> 

Except minor nit in 1/5, the whole series is:

Reviewed-by: Marek Vasut <marex@denx.de>

-- 
Best regards,
Marek Vasut
