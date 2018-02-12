Return-Path: <SRS0=sxJY=FG=gmail.com=himanshujha199640@kernel.org>
Date: Mon, 12 Feb 2018 20:11:57 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: 21cnbao@gmail.com, jic23@kernel.org, devel@driverdev.osuosl.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de
Subject: Re: [PATCH 4/4] staging: iio: accel: Move adis16201 driver out of
 staging
Message-ID: <20180212144157.GC12142@himanshu-Vostro-3559>
References: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
 <1518436499-8584-5-git-send-email-himanshujha199640@gmail.com>
 <20180212131826.ebazvmp6iv7i5fav@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180212131826.ebazvmp6iv7i5fav@mwanda>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Feb 12, 2018 at 04:18:26PM +0300, Dan Carpenter wrote:
> I think -M is prefered for these types of diffs?  Not sure.

I wrote about that in the cover letter if you missed. :)

> On Mon, Feb 12, 2018 at 05:24:59PM +0530, Himanshu Jha wrote:
> > +static int adis16201_probe(struct spi_device *spi)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct adis *st;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	st = iio_priv(indio_dev);
> > +	spi_set_drvdata(spi, indio_dev);
> > +
> > +	indio_dev->name = spi->dev.driver->name;
> > +	indio_dev->dev.parent = &spi->dev;
> > +	indio_dev->info = &adis16201_info;
> > +
> > +	indio_dev->channels = adis16201_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(adis16201_channels);
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +
> > +	ret = adis_init(st, indio_dev, spi, &adis16201_data);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
> > +	if (ret)
> > +		return ret;
> 
> We should clean up the IRQ which we enabled in adis_init() instead of
> returning directly.

I'm not sure about how to do that.

-- 
Thanks
Himanshu Jha
