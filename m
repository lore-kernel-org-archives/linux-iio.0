Return-Path: <antoine.tenart@free-electrons.com>
Date: Tue, 5 May 2015 11:16:35 +0200
From: Antoine Tenart <antoine.tenart@free-electrons.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>,
	sebastian.hesselbarth@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, zmxu@marvell.com, jszhang@marvell.com,
	yrliao@marvell.com, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iio: adc: add support for Berlin
Message-ID: <20150505091635.GF11312@kwain>
References: <1430730384-11318-1-git-send-email-antoine.tenart@free-electrons.com>
 <1430730384-11318-2-git-send-email-antoine.tenart@free-electrons.com>
 <55479C77.4070305@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <55479C77.4070305@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Jonathan,

On Mon, May 04, 2015 at 05:21:11PM +0100, Jonathan Cameron wrote:
> On 04/05/15 10:06, Antoine Tenart wrote:

[...]

> Also, I'm travelling and without internet so can't look it up directly.
> So.. On the basis I'll forget to check later..  What is the status
> of the two series you say this is based upon?

These two series haven't been taken yet, but they should be merged in
the next merge window (at least that's what we aim). Sebastian may have
more information on this matter.

> 
> There are also some overly long lines where spitting them would not
> significantly hurt readability so clean those up as well to avoid
> the inevitable code style fix patch from someone with too much time on
> their hands!

I'll have a look.

> > diff --git a/drivers/iio/adc/berlin2-adc.c b/drivers/iio/adc/berlin2-adc.c
> > new file mode 100644
> > index 000000000000..0adfef035d79
> > --- /dev/null
> > +++ b/drivers/iio/adc/berlin2-adc.c

[...]

> > +
> > +struct berlin2_adc_priv {
> > +	struct regmap		*regmap;
> > +	struct mutex		lock;
> > +	wait_queue_head_t	wq;
> > +	int			irq;
> > +	int			tsen_irq;
> tsen_irq and irq are only used in one function I think. If so just use local
> variables rather than cluttering up this structure.

Sure.

[...]

> > +
> > +	regmap_update_bits(priv->regmap, BERLIN2_SM_CTRL,
> > +			BERLIN2_SM_CTRL_ADC_START, 0);
> > +
> > +	data = priv->data;
> > +	priv->data = -1;
> Is setting data = -1 not overkill with data_available there as well?

It is, we can remove this line.

[...]

> > +
> > +		temp = berlin2_adc_tsen_read(indio_dev);
> > +		if (temp < 0)
> > +			return temp;
> > +
> > +		if (temp > 2047)
> > +			temp = -(4096 - temp);
> > +
> > +		/* Convert to Celsius */
> Just to check... Celsius or milli degrees celsius?
> (which is the ABI units - matched with hwmon)

Celsuis, I'll update to return milli Celsius.

Thanks!

Antoine

-- 
Antoine Ténart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
