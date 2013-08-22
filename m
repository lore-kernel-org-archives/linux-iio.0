Return-Path: <pawel.moll@arm.com>
Message-ID: <1377190224.2626.7.camel@hornet>
Subject: Re: [PATCH v3 2/5] ARM: dts: add reference voltage property for MXS
 LRADC
From: Pawel Moll <pawel.moll@arm.com>
To: Hector Palacios <hector.palacios@digi.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Jonathan
 Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org"
 <devicetree-discuss@lists.ozlabs.org>, "lars@metafoo.de" <lars@metafoo.de>,
  "fabio.estevam@freescale.com" <fabio.estevam@freescale.com>,
 "marex@denx.de" <marex@denx.de>,  "rob.herring@calxeda.com"
 <rob.herring@calxeda.com>, Mark Rutland <Mark.Rutland@arm.com>, Stephen
 Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>
Date: Thu, 22 Aug 2013 17:50:24 +0100
In-Reply-To: <5215C64D.3040004@digi.com>
References: <1374501843-19651-1-git-send-email-hector.palacios@digi.com>
	 <1374501843-19651-3-git-send-email-hector.palacios@digi.com>
	 <520AA3CD.1040008@kernel.org> <1376491467.18617.41.camel@hornet>
	 <52153B8E.7050309@free-electrons.com> <5215C64D.3040004@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, 2013-08-22 at 09:05 +0100, Hector Palacios wrote:
> This was what I originally submitted but it then looked like it would bet=
ter fit in=20
> the DeviceTree. The spear-adc seemed to use a similar approach:

I'm not sure if it's the best example... I much more prefer the AD7303's
way:

Documentation/devicetree/bindings/iio/dac/ad7303.txt

Optional properties:
        - REF-supply: Phandle to the external reference voltage supply. Thi=
s should
          only be set if there is an external reference voltage connected t=
o the REF
          pin. If the property is not set Vdd/2 is used as the reference vo=
ltage.

Pawe=C5=82
