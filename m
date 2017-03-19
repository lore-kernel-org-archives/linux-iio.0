Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48623 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751596AbdCSLKz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Mar 2017 07:10:55 -0400
Subject: Re: [PATCH v15 0/5] mxs-lradc: Split driver into MFD
To: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel@vger.kernel.org
References: <cover.1489666428.git.ksenija.stanojevic@gmail.com>
Cc: lee.jones@linaro.org, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, marex@denx.de, linux-iio@vger.kernel.org,
        harald@ccbib.org, stefan.wahren@i2se.com,
        fabio.estevam@freescale.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <833dd944-f64e-b796-d957-c6a637535a12@kernel.org>
Date: Sun, 19 Mar 2017 11:10:51 +0000
MIME-Version: 1.0
In-Reply-To: <cover.1489666428.git.ksenija.stanojevic@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/03/17 12:27, Ksenija Stanojevic wrote:
> Split existing driver mxs-lradc into MFD with touchscreen and
> IIO part.
> 
> Tested on I.MX28
Lee, I've been assuming you will take this one as an immutable branch
in mfd, but let me know if you want it to go another route.

Jonathan
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
>  drivers/input/touchscreen/mxs-lradc-ts.c           |  714 ++++++++
>  drivers/mfd/Kconfig                                |   17 +
>  drivers/mfd/Makefile                               |    1 +
>  drivers/mfd/mxs-lradc.c                            |  267 +++
>  include/linux/mfd/mxs-lradc.h                      |  187 +++
>  12 files changed, 2054 insertions(+), 1765 deletions(-)
>  rename Documentation/devicetree/bindings/{iio/adc => mfd}/mxs-lradc.txt (100%)
>  create mode 100644 drivers/iio/adc/mxs-lradc-adc.c
>  delete mode 100644 drivers/iio/adc/mxs-lradc.c
>  create mode 100644 drivers/input/touchscreen/mxs-lradc-ts.c
>  create mode 100644 drivers/mfd/mxs-lradc.c
>  create mode 100644 include/linux/mfd/mxs-lradc.h
> 

