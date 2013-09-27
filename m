Return-Path: <groeck7@gmail.com>
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 27 Sep 2013 09:12:14 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mark Brown <broonie@kernel.org>, Jean Delvare <khali@linux-fr.org>,
	Jonathan Cameron <jic23@kernel.org>, lm-sensors@lm-sensors.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/3] hwmon: (adt7310) Use spi_w8r16be() instead
 spi_w8r16()
Message-ID: <20130927161214.GA10392@roeck-us.net>
References: <1380292469-17347-1-git-send-email-lars@metafoo.de>
 <1380292469-17347-2-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380292469-17347-2-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Sep 27, 2013 at 04:34:28PM +0200, Lars-Peter Clausen wrote:
> Using spi_w8r16be() instead of spi_w8r16() in this driver makes a code a bit
> shorter and cleaner.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Acked-by: Guenter Roeck <linux@roeck-us.net>

Would this patch go through the SPI tree ?

Thanks,
Guenter
