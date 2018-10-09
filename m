Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33936 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbeJIRqq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Oct 2018 13:46:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id l6-v6so810228wrt.1
        for <linux-iio@vger.kernel.org>; Tue, 09 Oct 2018 03:30:30 -0700 (PDT)
Date: Tue, 9 Oct 2018 11:30:27 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Vignesh R <vigneshr@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 5/5] Input: ti_am335x_tsc: Mark IRQ as wakeup capable
Message-ID: <20181009103027.GQ4939@dell>
References: <20180630103318.25355-1-vigneshr@ti.com>
 <20180630103318.25355-6-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180630103318.25355-6-vigneshr@ti.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 30 Jun 2018, Vignesh R wrote:

> On AM335x, ti_am335x_tsc can wake up the system from suspend, mark the
> IRQ as wakeup capable, so that device irq is not disabled during system
> suspend.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/input/touchscreen/ti_am335x_tsc.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
