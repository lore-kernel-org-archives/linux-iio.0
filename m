Return-Path: <ukl@pengutronix.de>
Date: Tue, 17 Feb 2015 20:14:38 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	linux-iio@vger.kernel.org, Kumar Gala <galak@codeaurora.org>,
	Denis Carikli <denis@eukrea.com>, Rob Herring <robh+dt@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>, linux-input@vger.kernel.org,
	Lee Jones <lee.jones@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 1/6] mfd: fsl imx25 Touchscreen ADC driver
Message-ID: <20150217191438.GF19388@pengutronix.de>
References: <1422108103-15052-1-git-send-email-mpa@pengutronix.de>
 <1422108103-15052-2-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1422108103-15052-2-git-send-email-mpa@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>

Hello Markus,

On Sat, Jan 24, 2015 at 03:01:38PM +0100, Markus Pargmann wrote:
> +config MFD_MX25_TSADC
> +	tristate "Freescale i.MX25 integrated Touchscreen and ADC unit"
> +	select REGMAP_MMIO
> +	depends on SOC_IMX25
Can you make that:

	depends on SOC_IMX25 || COMPILE_TEST

?

> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
Which version of the GPL is your code licensed under?

> +static int mx25_tsadc_setup_irq(struct platform_device *pdev,
> +				struct mx25_tsadc *tsadc)
> [...]
> +	irq_set_chained_handler(irq, mx25_tsadc_irq_handler);
> +	irq_set_handler_data(irq, tsadc);
Do you need to reverse the order of these two calls to prevent the
handler being called while handler_data is still unset?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
