Return-Path: <pawel.moll@arm.com>
Message-ID: <1377171844.10707.32.camel@hornet>
Subject: Re: passing two interrupts two an I2C driver
From: Pawel Moll <pawel.moll@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>, Mark Rutland
 <Mark.Rutland@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron
 <jic23@kernel.org>,  "maxime.ripard@free-electrons.com"
 <maxime.ripard@free-electrons.com>, "lars@metafoo.de" <lars@metafoo.de>,
 "l.czerwinski@samsung.com" <l.czerwinski@samsung.com>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "ian.campbell@citrix.com" <ian.campbell@citrix.com>,
 "s.nawrocki@samsung.com" <s.nawrocki@samsung.com>,  Wolfram Sang
 <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Date: Thu, 22 Aug 2013 12:44:04 +0100
In-Reply-To: <20130822112619.GD26118@sirena.org.uk>
References: <520E3B8F.9010800@samsung.com> <520E7417.3090606@wwwdotorg.org>
	 <20130819084227.GC3719@e106331-lin.cambridge.arm.com>
	 <5214AA52.2060209@samsung.com> <1377088624.10707.23.camel@hornet>
	 <20130821175446.GI26118@sirena.org.uk> <1377163408.10707.29.camel@hornet>
	 <20130822112619.GD26118@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, 2013-08-22 at 12:26 +0100, Mark Brown wrote:
> On Thu, Aug 22, 2013 at 10:23:28AM +0100, Pawel Moll wrote:
>=20
> > If the platform data used to carry the (custom) irq data, the DT-powere=
d
> > driver could interrogate the DT on is own, couldn't it? Of course there
> > should be some helper available, maybe something of that sort? (warning=
,
> > untested)
>=20
> Yes, that's probably the most straightforward thing - we'd need to
> either have the bindings specify which interrupt must be first for
> reading i2c->irq or just have the drivers always do a name based lookup
> if there's more than one interrupt.

... or make sure that of_i2c_register_devices() does *not* set i2c->irq
(or rather: set it to 0) when there is more than one interrupt in the
tree...

Pawe=C5=82
