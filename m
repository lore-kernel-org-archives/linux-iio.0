Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37706 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161982AbcFHPgS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 8 Jun 2016 11:36:18 -0400
Received: by mail-wm0-f51.google.com with SMTP id k204so22682893wmk.0
        for <linux-iio@vger.kernel.org>; Wed, 08 Jun 2016 08:36:17 -0700 (PDT)
Date: Wed, 8 Jun 2016 16:36:42 +0100
From: Lee Jones <lee.jones@linaro.org>
To: "Andrew F. Davis" <afd@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dave Gerlach <d-gerlach@ti.com>, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] TI AM335x TSC/ADC cleanup
Message-ID: <20160608153642.GW14888@dell>
References: <20160531170013.2649-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20160531170013.2649-1-afd@ti.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 31 May 2016, Andrew F. Davis wrote:

> Hello all,
> 
> This series is a group of non-functional changes I would
> like to get in this cycle to prepare some regmap based
> changes I would like to make next cycle. Hopefully the
> churn can be seen as more useful in that case.

Once you've finished spell checking all of your commits, please submit
with the Acks you have collected.

> Andrew F. Davis (8):
>   mfd: ti_am335x_tscadc: Use SIMPLE_DEV_PM_OPS helper macro
>   iio: adc: ti_am335x_adc: use SIMPLE_DEV_PM_OPS helper macro
>   mfd: ti_am335x_tscadc: Remove use of single line functions
>   mfd: ti_am335x_tscadc: Unify variable naming when refrencing
>     ti_tscadc_dev
>   mfd: ti_am335x_tscadc: Rename regmap_tscadc to regmap
>   mfd: ti_am335x_tscadc: use variable name for sizeof() operator
>   iio: adc: ti_am335x_adc: use variable names for sizeof() operator
>   Input: ti_am335x_tsc - use variable name for sizeof() operator
> 
>  drivers/iio/adc/ti_am335x_adc.c           |  22 ++---
>  drivers/input/touchscreen/ti_am335x_tsc.c |   2 +-
>  drivers/mfd/ti_am335x_tscadc.c            | 135 +++++++++++++-----------------
>  include/linux/mfd/ti_am335x_tscadc.h      |   2 +-
>  4 files changed, 64 insertions(+), 97 deletions(-)
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
