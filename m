Return-Path: <Hector.Palacios@digi.com>
Message-ID: <51E00131.7080909@digi.com>
Date: Fri, 12 Jul 2013 15:14:25 +0200
From: Hector Palacios <hector.palacios@digi.com>
MIME-Version: 1.0
To: <devicetree-discuss@lists.ozlabs.org>
CC: "fabio.estevam@freescale.com" <fabio.estevam@freescale.com>, Marek Vasut
	<marex@denx.de>, Lars-Peter Clausen <lars@metafoo.de>, "jic23@kernel.org"
	<jic23@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Reference voltages for ADC channels
References: <51DA588A.5050609@digi.com>
In-Reply-To: <51DA588A.5050609@digi.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hello,

On 07/08/2013 08:13 AM, Hector Palacios wrote:
> Greetings,
>
> The other day at linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org we discussed the
> possibility of having ADC channels voltage references moved to the DT [1].
>
> In Freescale's i.MX28 and i.MX23, at least, the CPU has 16 ADC channels some of which
> are dedicated to measure internal stuff, like CPU temperature and voltages. Some
> channels have different fixed divisors and so different reference voltages.
> These reference voltages (in mV) are needed to calculate the scale to show through the
> sysfs IIO interface, so that a user can easily compute the real measured voltage out
> of the sampled data.
>
> The proposed DT entry also appears at [1].
> We would love to here opinions about it.
>
> [1] http://www.spinics.net/lists/linux-iio/msg08973.html

Any opinion about the suggestion of moving ADC reference voltages into the device tree?

Thanks
-- 
Héctor Palacios
