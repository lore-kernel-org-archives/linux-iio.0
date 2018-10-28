Return-Path: <SRS0=Jd6c=NI=gmail.com=nishadkamdar@kernel.org>
Date: Sun, 28 Oct 2018 11:43:48 +0530
From: Nishad Kamdar <nishadkamdar@gmail.com>
To: Slawomir Stepien <sst@poczta.fm>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] staging: iio: ad2s1210: Add device tree support.
Message-ID: <20181028061346.GA5696@nishad>
References: <cover.1540489369.git.nishadkamdar@gmail.com>
 <1dc6fdf4626e7cf1ca4933fe3008cb3cd267149b.1540489369.git.nishadkamdar@gmail.com>
 <20181027154903.GA1582@x220.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20181027154903.GA1582@x220.localdomain>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Oct 27, 2018 at 05:49:03PM +0200, Slawomir Stepien wrote:
> Hi
> 
> On paź 26, 2018 18:55, Nishad Kamdar wrote:
> > Add device tree table for matching vendor ID
> > and support for retrieving platform data
> > from device tree.
> 
> So maybe you should make 2 commits?
>
Ok. I'll do that.
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> >  drivers/staging/iio/resolver/ad2s1210.c | 43 ++++++++++++++++++++++++-
> >  1 file changed, 42 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> > index 93c3c70ce62e..9fd5461c4ed0 100644
> > --- a/drivers/staging/iio/resolver/ad2s1210.c
> > +++ b/drivers/staging/iio/resolver/ad2s1210.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/gpio/consumer.h>
> >  #include <linux/module.h>
> > +#include <linux/of.h>
> >  
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> > @@ -669,6 +670,27 @@ static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
> >  	return 0;
> >  }
> >  
> > +#ifdef CONFIG_OF
> > +static struct ad2s1210_platform_data *ad2s1210_parse_dt(struct device *dev)
> > +{
> > +	struct device_node *np = dev->of_node;
> > +	struct ad2s1210_platform_data *pdata;
> > +
> > +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> > +	if (!pdata)
> > +		return NULL;
> > +
> > +	pdata->gpioin = of_property_read_bool(np, "adi,gpioin");
> 
> Why here you are adding "adi", but you are not adding it to the gpios in prev
> commit?
> 
> I've also seen this: https://patchwork.kernel.org/patch/10355839/. However I do
> not understand why adding vendor id to props is needed...
>
> > +
> > +	return pdata;
> > +}
> > +#else
> > +static struct ad2s1210_platform_data *ad2s1210_parse_dt(struct device *dev)
> > +{
> > +	return NULL;
> > +}
> > +#endif
> > +
> >  static int ad2s1210_probe(struct spi_device *spi)
> >  {
> >  	struct iio_dev *indio_dev;
> > @@ -682,7 +704,19 @@ static int ad2s1210_probe(struct spi_device *spi)
> >  	if (!indio_dev)
> >  		return -ENOMEM;
> >  	st = iio_priv(indio_dev);
> > -	st->pdata = spi->dev.platform_data;
> > +	if (spi->dev.of_node) {
> > +		st->pdata = ad2s1210_parse_dt(&spi->dev);
> > +		if (!st->pdata)
> > +			return -EINVAL;
> > +	} else {
> > +		st->pdata = spi->dev.platform_data;
> > +	}
> > +
> > +	if (!st->pdata) {
> > +		dev_err(&spi->dev, "ad2s1210: no platform data supplied\n");
> > +		return -EINVAL;
> > +	}
> > +
> 
> Why not just use only device-tree here? The ad2s1210_platform_data has now only
> one entry... In that case remember to add "depends on OF" in Kconfig.
>

Ok. I'll do that.
> >  	ret = ad2s1210_setup_gpios(st);
> >  	if (ret < 0)
> >  		return ret;
> > @@ -724,6 +758,12 @@ static int ad2s1210_remove(struct spi_device *spi)
> >  	return 0;
> >  }
> >  
> > +static const struct of_device_id ad2s1210_of_match[] = {
> > +	{ .compatible = "adi,ad2s1210", },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, ad2s1210_of_match);
> > +
> >  static const struct spi_device_id ad2s1210_id[] = {
> >  	{ "ad2s1210" },
> >  	{}
> > @@ -733,6 +773,7 @@ MODULE_DEVICE_TABLE(spi, ad2s1210_id);
> >  static struct spi_driver ad2s1210_driver = {
> >  	.driver = {
> >  		.name = DRV_NAME,
> > +		.of_match_table = of_match_ptr(ad2s1210_of_match),
> >  	},
> >  	.probe = ad2s1210_probe,
> >  	.remove = ad2s1210_remove,
> 
> -- 
> Slawomir Stepien

Thanks for the review.

Regards,
Nishad
