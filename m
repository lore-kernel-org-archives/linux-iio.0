Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55493 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbeJIRqg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Oct 2018 13:46:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id 206-v6so1300621wmb.5
        for <linux-iio@vger.kernel.org>; Tue, 09 Oct 2018 03:30:20 -0700 (PDT)
Date: Tue, 9 Oct 2018 11:30:17 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Vignesh R <vigneshr@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 4/5] iio: adc: ti_am335x_adc: Disable ADC during suspend
 unconditionally
Message-ID: <20181009103017.GP4939@dell>
References: <20180630103318.25355-1-vigneshr@ti.com>
 <20180630103318.25355-5-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180630103318.25355-5-vigneshr@ti.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 30 Jun 2018, Vignesh R wrote:

> Parent MFD device takes care of enabling ADC interface whenever
> touchscreen is marked wakeup capable. Therefore, unconditionally disable
> ADC interface during system suspend to save power in case of system with
> just ADC and no TSC.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/iio/adc/ti_am335x_adc.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
