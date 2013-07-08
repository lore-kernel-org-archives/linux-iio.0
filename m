Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Hector Palacios <hector.palacios@digi.com>
Subject: Re: [PATCH 3/4] iio: mxs-lradc: add scale_available file to channels
Date: Mon, 8 Jul 2013 15:05:21 +0200
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "alexandre.belloni@free-electrons.com" <alexandre.belloni@free-electrons.com>,
 "lars@metafoo.de" <lars@metafoo.de>,
 "jic23@kernel.org" <jic23@kernel.org>,
 "fabio.estevam@freescale.com" <fabio.estevam@freescale.com>
References: <1373013039-19461-1-git-send-email-hector.palacios@digi.com> <201307051346.03825.marex@denx.de> <51DA7DA3.3050207@digi.com>
In-Reply-To: <51DA7DA3.3050207@digi.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201307081505.21904.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Dear Hector Palacios,

> Dear Marek,
> 
> On 07/05/2013 01:46 PM, Marek Vasut wrote:
> [...]
> 
> >> +	/* Populate available ADC input ranges */
> >> +	for (i = 0; i < LRADC_MAX_TOTAL_CHANS; i++) {
> >> +		for (s = 0; s < ARRAY_SIZE(lradc->scale_avail[i]); s++) {
> >> +			/*
> >> +			 * [0] = optional divider by two disabled (default)
> >> +			 * [1] = optional divider by two enabled
> >> +			 *
> >> +			 * The scale is calculated by doing:
> >> +			 *   Vref >> (realbits - s)
> >> +			 * which multiplies by two on the second component
> >> +			 * of the array.
> >> +			 */
> >> +			scale_uv = ((u64)lradc->vref_mv[i] * 100000000) >>
> >> +				   (iio->channels[i].scan_type.realbits - s);
> > 
> > Given that you do have a table of values already, can this table not be
> > computed at compile-time as well?
> 
> Yes and no. On one hand, it would be a little redundant and ugly to have
> two tables (one computed out of the other). Considering there are two
> CPUs, it would force you to maintain four tables.
> On the other hand the formula uses the 'realbits' (yeah, well it won't
> change, but still). I copied the code from ad7192.c. The operation is only
> done during probe() so I don't think the time penalty is worth the effort
> of having another table.

Ok. I suspect we should wait how the discussion in DT-discuss turns out too.

> >> +			lradc->scale_avail[i][s][1] = do_div(scale_uv,
> >> +							     100000000) * 10;
> >> +			lradc->scale_avail[i][s][0] = scale_uv;
> > 
> > Is this correct? Why is one set to "scale_uv" and the other set to
> > scale_uv / 100000000 ? Maybe I just don't understand what each of the
> > fields in the array stand for.
> 
> The [0] component is the integer (volts) part of the scale. The [1]
> component is the nanoV part.
> To be honest, after some unsuccessful tries of doing my own math here, I
> just copied the one from ad7192.c. It is a bit unintelligible because it
> is doing 64bit math operations, but it works. Remember do_div() modifies
> the first parameter (scale_uv) during the operation, apart from returning
> a value. That may have fooled you.

I'd vouch for cleaning this up so it's readable ;-)

Best regards,
Marek Vasut
