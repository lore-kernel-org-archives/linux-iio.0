Return-Path: <SRS0=3C4c=M5=oracle.com=dan.carpenter@kernel.org>
Date: Wed, 17 Oct 2018 22:56:32 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Nishad Kamdar <nishadkamdar@gmail.com>, devel@driverdev.osuosl.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2] staging: iio: ad7816: Switch to the gpio descriptor
 interface
Message-ID: <20181017195632.xqxevygukhat6hkh@mwanda>
References: <20181017144716.GA11485@nishad>
 <20181017145823.GC135013@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181017145823.GC135013@sasha-vm>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Oct 17, 2018 at 10:58:23AM -0400, Sasha Levin wrote:
> On Wed, Oct 17, 2018 at 08:17:20PM +0530, Nishad Kamdar wrote:
> > +	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_IN);
> > +	if (IS_ERR(chip->rdwr_pin)) {
> > +		ret = PTR_ERR(chip->rdwr_pin);
> > +		dev_err(&spi_dev->dev, "Failed to request rdwr GPIO: %d\n",
> > +			ret);
> > 		return ret;
> > 	}
> > -	gpio_direction_input(chip->rdwr_pin);
> > -	ret = devm_gpio_request(&spi_dev->dev, chip->convert_pin,
> > -				spi_get_device_id(spi_dev)->name);
> > -	if (ret) {
> > -		dev_err(&spi_dev->dev, "Fail to request convert gpio PIN %d.\n",
> > -			chip->convert_pin);
> > +	chip->convert_pin = devm_gpiod_get(&spi_dev->dev, "convert", GPIOD_IN);
> > +	if (IS_ERR(chip->convert_pin)) {
> > +		ret = PTR_ERR(chip->convert_pin);
> > +		dev_err(&spi_dev->dev, "Failed to request convert GPIO: %d\n",
> > +			ret);
> > 		return ret;
> > 	}
> > -	gpio_direction_input(chip->convert_pin);
> > -	ret = devm_gpio_request(&spi_dev->dev, chip->busy_pin,
> > -				spi_get_device_id(spi_dev)->name);
> > -	if (ret) {
> > -		dev_err(&spi_dev->dev, "Fail to request busy gpio PIN %d.\n",
> > -			chip->busy_pin);
> > +	chip->busy_pin = devm_gpiod_get(&spi_dev->dev, "busy", GPIOD_IN);
> > +	if (IS_ERR(chip->busy_pin)) {
> > +		ret = PTR_ERR(chip->busy_pin);
> > +		dev_err(&spi_dev->dev, "Failed to request busy GPIO: %d\n",
> > +			ret);
> > 		return ret;
> > 	}
> 
> Hm, from what I can tell devm_gpio_request() is allocating some memory,
> which makes this a series of 4 allocations.
> 
> What happens if the fourth allocation fails? Do we leak the first three?

These are devm_ allocations.  They are freed when &spi_dev->dev is
released.

regards,
dan carpenter
