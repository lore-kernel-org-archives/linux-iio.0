Return-Path: <sashal@kernel.org>
Date: Wed, 17 Oct 2018 10:58:23 -0400
From: Sasha Levin <sashal@kernel.org>
To: Nishad Kamdar <nishadkamdar@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [PATCH v2] staging: iio: ad7816: Switch to the gpio descriptor
 interface
Message-ID: <20181017145823.GC135013@sasha-vm>
References: <20181017144716.GA11485@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <20181017144716.GA11485@nishad>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Oct 17, 2018 at 08:17:20PM +0530, Nishad Kamdar wrote:
>+	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_IN);
>+	if (IS_ERR(chip->rdwr_pin)) {
>+		ret = PTR_ERR(chip->rdwr_pin);
>+		dev_err(&spi_dev->dev, "Failed to request rdwr GPIO: %d\n",
>+			ret);
> 		return ret;
> 	}
>-	gpio_direction_input(chip->rdwr_pin);
>-	ret = devm_gpio_request(&spi_dev->dev, chip->convert_pin,
>-				spi_get_device_id(spi_dev)->name);
>-	if (ret) {
>-		dev_err(&spi_dev->dev, "Fail to request convert gpio PIN %d.\n",
>-			chip->convert_pin);
>+	chip->convert_pin = devm_gpiod_get(&spi_dev->dev, "convert", GPIOD_IN);
>+	if (IS_ERR(chip->convert_pin)) {
>+		ret = PTR_ERR(chip->convert_pin);
>+		dev_err(&spi_dev->dev, "Failed to request convert GPIO: %d\n",
>+			ret);
> 		return ret;
> 	}
>-	gpio_direction_input(chip->convert_pin);
>-	ret = devm_gpio_request(&spi_dev->dev, chip->busy_pin,
>-				spi_get_device_id(spi_dev)->name);
>-	if (ret) {
>-		dev_err(&spi_dev->dev, "Fail to request busy gpio PIN %d.\n",
>-			chip->busy_pin);
>+	chip->busy_pin = devm_gpiod_get(&spi_dev->dev, "busy", GPIOD_IN);
>+	if (IS_ERR(chip->busy_pin)) {
>+		ret = PTR_ERR(chip->busy_pin);
>+		dev_err(&spi_dev->dev, "Failed to request busy GPIO: %d\n",
>+			ret);
> 		return ret;
> 	}

Hm, from what I can tell devm_gpio_request() is allocating some memory,
which makes this a series of 4 allocations.

What happens if the fourth allocation fails? Do we leak the first three?

--
Thanks,
Sasha
