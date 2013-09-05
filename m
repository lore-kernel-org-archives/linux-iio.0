Return-Path: <pawel.moll@arm.com>
Message-ID: <1378381209.24019.21.camel@hornet>
Subject: Re: [PATCH] Documentation: dt: i2c: Add LPS001WP to the Trivial
 Devices list
From: Pawel Moll <pawel.moll@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Lee Jones <lee.jones@linaro.org>, "sa@the-dreams.de" <sa@the-dreams.de>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jic23@cam.ac.uk" <jic23@cam.ac.uk>,  "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "swarren@wwwdotorg.org"
 <swarren@wwwdotorg.org>,  "ian.campbell@citrix.com"
 <ian.campbell@citrix.com>, "grant.likely@linaro.org"
 <grant.likely@linaro.org>,  "tomasz.figa@gmail.com"
 <tomasz.figa@gmail.com>, "rob.herring@calxeda.com"
 <rob.herring@calxeda.com>,  "galak@codeaurora.org" <galak@codeaurora.org>
Date: Thu, 05 Sep 2013 12:40:09 +0100
In-Reply-To: <20130905113001.GR18206@e106331-lin.cambridge.arm.com>
References: <1378302655-13258-1-git-send-email-lee.jones@linaro.org>
	 <20130904142422.GM18206@e106331-lin.cambridge.arm.com>
	 <20130904151159.GA8980@lee--X1>
	 <20130905113001.GR18206@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, 2013-09-05 at 12:30 +0100, Mark Rutland wrote:
> I also note that the device can also be attached to SPI. Do we have any
> other devices which may be attached to either? Do we handle that, and if
> so, how (do we have the same compatible string for both interfaces?)?

Theoretically you don't need anything to make it work - nodes being a
children of a I2C master will instantiate i2c_clients, offspring of a
SPI master will become spi_devices. Then you register two drivers - I2C
and SPI ones, probably sharing most of the code - both matching the same
compatible value. The I2C one will be bound only with the I2C nodes, the
same applies to SPI.

I hope :-)

Pawe=C5=82
