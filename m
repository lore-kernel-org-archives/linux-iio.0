Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 2/2] iio: mxs-lradc: check ranges of ts properties
Date: Wed, 24 Dec 2014 01:35:21 +0100
Cc: kristina.martsenko@gmail.com,
 kernel@pengutronix.de,
 jic23@kernel.org,
 pawel.moll@arm.com,
 knaack.h@gmx.de,
 ijc+devicetree@hellion.org.uk,
 robh+dt@kernel.org,
 galak@codeaurora.org,
 festevam@gmail.com,
 mark.rutland@arm.com,
 linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
References: <1419250476-2393-1-git-send-email-stefan.wahren@i2se.com> <201412231437.22809.marex@denx.de> <1197201553.616296.1419374759245.JavaMail.open-xchange@oxbaltgw02.schlund.de>
In-Reply-To: <1197201553.616296.1419374759245.JavaMail.open-xchange@oxbaltgw02.schlund.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201412240135.21244.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

On Tuesday, December 23, 2014 at 11:45:59 PM, Stefan Wahren wrote:
> Hi Marek,

Hi!

> > Marek Vasut <marex@denx.de> hat am 23. Dezember 2014 um 14:37
> > geschrieben:
> > 
> > 
> > On Monday, December 22, 2014 at 01:14:36 PM, Stefan Wahren wrote:
> > [...]
> > 
> > Very minor coding style flub in this comment above. Multi-line comments
> > should start with /* and a newline after that ;-)
> 
> Thanks for your advice.

Sure, it's really a minor thing.

> > > + * from the datasheet:
> > > + * "The DELAY fields in HW_LRADC_DELAY0, HW_LRADC_DELAY1,
> > > + * HW_LRADC_DELAY2, and HW_LRADC_DELAY3 must be non-zero; otherwise,
> > > + * the LRADC will not trigger the delay group."
> > > + */
> > > mxs_lradc_reg_wrt(lradc, LRADC_DELAY_TRIGGER(1 << ch) |
> > > LRADC_DELAY_TRIGGER_DELAYS(0) |
> > > LRADC_DELAY_LOOP(lradc->over_sample_cnt - 1) |
> > > @@ -1495,20 +1501,38 @@ static int mxs_lradc_probe_touchscreen(struct
> > > mxs_lradc *lradc, return -EINVAL;
> > > }
> > > 
> > > - lradc->over_sample_cnt = 4;
> > > - ret = of_property_read_u32(lradc_node, "fsl,ave-ctrl", &adapt);
> > > - if (ret == 0)
> > > + if (of_property_read_u32(lradc_node, "fsl,ave-ctrl", &adapt)) {
> > > + lradc->over_sample_cnt = 4;
> > > + } else {
> > > + if (adapt < 1 || adapt > 32) {
> > 
> > This is just an idea, but do we not have some kind of a
> > "of_property_read_u32_range()" thingie, which would include this kind of
> > range checking ? Would it be worth implementing such thing ? What do you
> > think please ?
> 
> I never heard of such a function. I think it's not the best idea of mixing
> dt parsing and range checking in a general function.

It was just an idea, since it would trim down the code duplication a bit.

> But this code does nearly the same thing 3 times. How about defining an
> array of property range structures:
> 
> static const struct property_value_range mxs_lradc_properties[] = {
> 	{
> 		.name = "fsl,ave-ctrl",
> 		.min_value = 1,
> 		.max_value = 32,
> 		.default_value = 4,
> 	},
> 	{
> 		.name = "fsl,ave-delay",
> 		.min_value = 2,
> 		.max_value = LRADC_DELAY_DELAY_MASK+1,
> 		.default_value = 2,
> 	},
> 	{
> 		.name = "fsl,settling",
> 		.min_value = 1,
> 		.max_value = LRADC_DELAY_DELAY_MASK,
> 		.default_value = 10,
> 	},
> };
> 
> and a local validate function for these optional parameters.

That's becoming a bit too complex for such a simple task. I cannot tell right 
now, so I'd prefer of others chimed in.

Have a nice holiday!
