Return-Path: <randy.dunlap@oracle.com>
Date: Wed, 11 May 2011 16:40:58 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Cameron
 <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
        driverdevel
 <devel@driverdev.osuosl.org>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Grant
 Likely <grant.likely@secretlab.ca>,
        Michael Hennerich
 <hennerich@blackfin.uclinux.org>
Subject: Re: linux-next: Tree for May 11 (staging/iio/adc + gpio)
Message-Id: <20110511164058.5b562771.randy.dunlap@oracle.com>
In-Reply-To: <20110511152508.0d5d5aa6.sfr@canb.auug.org.au>
References: <20110511152508.0d5d5aa6.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Wed, 11 May 2011 15:25:08 +1000 Stephen Rothwell wrote:

> Hi all,
> 
> Changes since 20110510:


When GPIOLIB is not enabled and GENERIC_GPIO is not enabled: (not a new problem)

drivers/staging/iio/adc/ad7780.c:247: error: 'GPIOF_OUT_INIT_LOW' undeclared (first use in this function)

Its Kconfig entry says:

config AD7780
	tristate "Analog Devices AD7780 AD7781 ADC driver"
	depends on SPI

but surely it should depend on (or select) some GPIO kconfig symbol.


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
