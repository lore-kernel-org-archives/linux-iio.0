Return-Path: <joe@perches.com>
Message-ID: <1414034597.15751.3.camel@perches.com>
Subject: Re: [PATCH v2] Staging: iio: adc: fix line over 80 characters
From: Joe Perches <joe@perches.com>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Brian Vandre
 <bvandre@gmail.com>, gregkh@linuxfoundation.org, jic23@kernel.org,
 alexandre.belloni@free-electrons.com, linux-iio@vger.kernel.org,
 marex@denx.de,  linux-kernel@vger.kernel.org
Date: Wed, 22 Oct 2014 20:23:17 -0700
In-Reply-To: <54484219.5000708@gmx.de>
References: <cover.1413858979.git.bvandre@gmail.com>
	 <cover.1413931615.git.bvandre@gmail.com>
	 <ec4b497827f6c7615f6b5eef5669144f8c68d034.1413931615.git.bvandre@gmail.com>
	 <20141022042115.GA2530@sudip-PC> <54484219.5000708@gmx.de>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Thu, 2014-10-23 at 01:47 +0200, Hartmut Knaack wrote:
> Sudip Mukherjee schrieb am 22.10.2014 06:21:
> > On Tue, Oct 21, 2014 at 05:56:47PM -0500, Brian Vandre wrote:
> >> This fixes the 2 checkpatch.pl warnings:
> >> WARNING: line over 80 characters
> >>
> > please check your patch with --strict option of checkpatch.pl , and you will get :
> > "Alignment should match open parenthesis" .
> > 
> Good point, but what solution would you propose?

> >> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c

> >> @@ -455,7 +455,8 @@ static void mxs_lradc_setup_ts_channel(struct mxs_lradc *lradc, unsigned ch)
> >>  	 * SoC's delay unit and start the conversion later
> >>  	 * and automatically.
> >>  	 */
> >> -	mxs_lradc_reg_wrt(lradc, LRADC_DELAY_TRIGGER(0) | /* don't trigger ADC */
> >> +	mxs_lradc_reg_wrt(lradc,
> >> +		LRADC_DELAY_TRIGGER(0) | /* don't trigger ADC */
> >>  		LRADC_DELAY_TRIGGER_DELAYS(1 << 3) | /* trigger DELAY unit#3 */
> >>  		LRADC_DELAY_KICK |
> >>  		LRADC_DELAY_DELAY(lradc->settling_delay),

Maybe something like:

	mxs_lradc_reg_wrt(lradc,
			  LRADC_DELAY_TRIGGER(0) |
						/* don't trigger ADC */
			  LRADC_DELAY_TRIGGER_DELAYS(1 << 3) |
						/* trigger DELAY unit#3 */
			  LRADC_DELAY_KICK |
			  LRADC_DELAY_DELAY(lradc->settling_delay),
