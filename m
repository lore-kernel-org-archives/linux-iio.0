Return-Path: <Hector.Palacios@digi.com>
Message-ID: <51DA588A.5050609@digi.com>
Date: Mon, 8 Jul 2013 08:13:30 +0200
From: Hector Palacios <hector.palacios@digi.com>
MIME-Version: 1.0
To: <devicetree-discuss@lists.ozlabs.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"jic23@kernel.org" <jic23@kernel.org>, Marek Vasut <marex@denx.de>,
	"fabio.estevam@freescale.com" <fabio.estevam@freescale.com>, "Alexandre
 Belloni" <alexandre.belloni@free-electrons.com>, Lars-Peter Clausen
	<lars@metafoo.de>
Subject: Reference voltages for ADC channels
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Greetings,

The other day at linux-iio@vger.kernel.org we discussed the possibility of having ADC 
channels voltage references moved to the DT [1].

In Freescale's i.MX28 and i.MX23, at least, the CPU has 16 ADC channels some of which 
are dedicated to measure internal stuff, like CPU temperature and voltages. Some 
channels have different fixed divisors and so different reference voltages.
These reference voltages (in mV) are needed to calculate the scale to show through the 
sysfs IIO interface, so that a user can easily compute the real measured voltage out 
of the sampled data.

The proposed DT entry also appears at [1].
We would love to here opinions about it.

[1] http://www.spinics.net/lists/linux-iio/msg08973.html

Best regards,
--
Hector Palacios
