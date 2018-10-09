Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36307 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeJIRqJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Oct 2018 13:46:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id a8-v6so1361479wmf.1
        for <linux-iio@vger.kernel.org>; Tue, 09 Oct 2018 03:29:53 -0700 (PDT)
Date: Tue, 9 Oct 2018 11:29:49 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Vignesh R <vigneshr@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 1/5] mfd: ti_am335x_tscadc: Don't mark TSCADC MFD as
 wakeup capable
Message-ID: <20181009102949.GM4939@dell>
References: <20180630103318.25355-1-vigneshr@ti.com>
 <20180630103318.25355-2-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180630103318.25355-2-vigneshr@ti.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 30 Jun 2018, Vignesh R wrote:

> Currently tscadc MFD is marked as wakeup capable which incorrect
> because, its actually touch event by child TSC device that wakes up the
> system. Therefore, remove device_init_wakeup() call that marks TSCADC
> device as wakeup capable in favor of moving to mark TSC input device as
> wakeup capable later.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/mfd/ti_am335x_tscadc.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
