Return-Path: <SRS0=fXK8=7K=perches.com=joe@kernel.org>
Message-ID: <1502207564.2219.35.camel@perches.com>
Subject: Re: [PATCH] iio: adc: Fix coding style violations
From: Joe Perches <joe@perches.com>
To: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org,
	monstr@monstr.eu
Cc: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
 =?ISO-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
 linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter
 Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Jonathan Cameron <jic23@kernel.org>,  linux-arm-kernel@lists.infradead.org
Date: Tue, 08 Aug 2017 08:52:44 -0700
In-Reply-To: <d310ac06b13cf803bd3a2a6bcfb92169445f929c.1502193860.git.michal.simek@xilinx.com>
References: 
	<d310ac06b13cf803bd3a2a6bcfb92169445f929c.1502193860.git.michal.simek@xilinx.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Tue, 2017-08-08 at 14:04 +0200, Michal Simek wrote:
> From: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
[]
> diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
[]
> @@ -76,7 +76,7 @@ struct xadc_ops {
>  	int (*setup)(struct platform_device *pdev, struct iio_dev *indio_dev,
>  			int irq);
>  	void (*update_alarm)(struct xadc *, unsigned int);
> -	unsigned long (*get_dclk_rate)(struct xadc *);
> +	unsigned long (*get_dclk_rate)(struct xadc *xadc);
>  	irqreturn_t (*interrupt_handler)(int, void *);

Doesn't it seem odd to you that the lines above and below
have the same form?

checkpatch is an imperfect tool.
It will always be imperfect.
Please use your eyes and mind too.
