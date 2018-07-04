Return-Path: <SRS0=fuJB=JU=linaro.org=lee.jones@kernel.org>
Date: Wed, 4 Jul 2018 08:39:01 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Vignesh R <vigneshr@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 3/5] mfd: ti_am335x_tscadc: Keep ADC interface on if
 child is wakeup capable
Message-ID: <20180704073901.GM20176@dell>
References: <20180630103318.25355-1-vigneshr@ti.com>
 <20180630103318.25355-4-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180630103318.25355-4-vigneshr@ti.com>
List-ID: <linux-iio@vger.kernel.org>

On Sat, 30 Jun 2018, Vignesh R wrote:

> If a child device like touchscreen is wakeup capable, then keep ADC
> interface on, so that a touching resistive screen will generate wakeup
> event to the system.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/mfd/ti_am335x_tscadc.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
