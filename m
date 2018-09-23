Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46354 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbeIWVPV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Sep 2018 17:15:21 -0400
Date: Sun, 23 Sep 2018 23:17:22 +0800
From: Song Qiang <songqiang1304521@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: Add support for PNI RM3100 9-axis
 magnetometer
Message-ID: <20180923151722.GA17711@Eros>
References: <20180920131340.6699-1-songqiang1304521@gmail.com>
 <20180922111409.597126fd@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180922111409.597126fd@archlinux>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Sep 22, 2018 at 11:14:09AM +0100, Jonathan Cameron wrote:
> On Thu, 20 Sep 2018 21:13:40 +0800
> Song Qiang <songqiang1304521@gmail.com> wrote:
> 

...

> > +const struct regmap_access_table rm3100_volatile_table = {
> > +		.yes_ranges = rm3100_volatile_ranges,
> > +		.n_yes_ranges = ARRAY_SIZE(rm3100_volatile_ranges),
> > +};
> > +
> > +static irqreturn_t rm3100_measurement_irq_handler(int irq, void *d)
> 
> Silly question: Does the chip have two interrupt lines?  (if so they
> should be in the binding). If not, then this is the irq handler
> for everything so why have the measurement in it's name?
> 

Hi Jonathan

Ah, always some other things need to care, I didn't put enough focus on
this naming and thought it looks like ok. So I should throw these
unnecessary information in names away!

> > +{
> > +	struct rm3100_data *data = d;
> > +
> > +	complete(&data->measuring_done);
> > +
> > +	return IRQ_HANDLED;
> > +}

... 

> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* 3sec more wait time. */
> > +	ret = regmap_read(data->regmap, RM_REG_TMRC, &tmp);
> > +	data->conversion_time = rm3100_samp_rates[tmp-RM_TMRC_OFFSET][2] + 3000;
> > +
> > +	/* Starting all channels' conversion. */
> > +	ret = regmap_write(regmap, RM_REG_CMM,
> > +		RM_CMM_PMX | RM_CMM_PMY | RM_CMM_PMZ | RM_CMM_START);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return devm_iio_device_register(dev, indio_dev);
> Nope.  Can't do this without having a race condition.   You need
> to ensure the userspace and in kernel interfaces are removed 'before'.
> you do that RM_REG_CMM write in remove.
> 
> One option is to use devm_add_action to add a custom unwind function
> to the automatic handling. The other is to not use devm for everything 
> after the write above and do the device_unregister manually.
> 

I've already handled some of those problems, and most of them are not a 
big deal, except this one and the locking problems, about how should I 
deal with locks properly. I'm already reading the lockdep conventions and
some articles about it.
Autobuilder are complaining about my locks, seems like a mess it is!

> > +}
> > +EXPORT_SYMBOL(rm3100_common_probe);
> > +
> > +int rm3100_common_remove(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > +	struct rm3100_data *data = iio_priv(indio_dev);
> > +	struct regmap *regmap = data->regmap;
> > +
> > +	regmap_write(regmap, RM_REG_CMM, 0x00);
> > +
> > +	return 0;
> No real point in returning int if you are always going to put 0 in
> in it.  Should probably check the regmap_write though and output
> a log message if it fails (as no other way of telling).
> 
> > +}
> > +EXPORT_SYMBOL(rm3100_common_remove);
> > +

...

> > +struct rm3100_data {
> > +	struct device *dev;
> > +	struct regmap *regmap;
> > +	struct completion measuring_done;
> > +	bool use_interrupt;
> > +
> > +	int conversion_time;
> > +
> > +	/* To protect consistency of every measurement and sampling
> 
> /*
>  * To protect
>  */
> (common format to most of the kernel other than those 'crazy' :)
> people in net and a few other corners.
> 

Actually, I've been wondering why the perl scripts didn't find this out,
and not only this one, many other problems like too many indents, 
parameters in open brackets are not aligned can be detected.
I don't know perl, but this has drawn my attention. Is there any
particular reason these problems still can not be detected? or I think
we can work some patch out! Make reviewing code like mine easier!

yours,
Song Qiang

> > +	 * frequency change operations.
> > +	 */
> > +	struct mutex lock;
> > +};
> > +
> > +extern const struct regmap_access_table rm3100_readable_table;
> > +extern const struct regmap_access_table rm3100_writable_table;
> > +extern const struct regmap_access_table rm3100_volatile_table;
> > +
> > +int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq);
> > +int rm3100_common_remove(struct device *dev);
> > +
> > +#endif /* RM3100_CORE_H */
> 
