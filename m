Return-Path: <kristina.martsenko@gmail.com>
Message-ID: <54BD6319.8080103@gmail.com>
Date: Mon, 19 Jan 2015 22:03:37 +0200
From: =?windows-1252?Q?Kristina_Mart=9Aenko?=
 <kristina.martsenko@gmail.com>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>, Juergen Borleis <jbe@pengutronix.de>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald <pmeerw@pmeerw.net>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Fabio Estevam <fabio.estevam@freescale.com>,
 Stefan Wahren <stefan.wahren@i2se.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH 3/4] iio: mxs-lradc: make ADC reads not unschedule touchscreen
 conversions
References: <1421454131-3501-1-git-send-email-kristina.martsenko@gmail.com> <1421454131-3501-4-git-send-email-kristina.martsenko@gmail.com> <201501190820.32090.jbe@pengutronix.de> <201501190857.50107.marex@denx.de>
In-Reply-To: <201501190857.50107.marex@denx.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 19/01/15 09:57, Marek Vasut wrote:
> On Monday, January 19, 2015 at 08:20:31 AM, Juergen Borleis wrote:
>> On Saturday 17 January 2015 01:22:10 Kristina Martšenko wrote:
>>> Reading a channel through sysfs, or starting a buffered capture, can
>>> occasionally turn off the touchscreen.
>>> [...]
>>
>> I have my old ChumbyOne around (i.MX23). How to test this buffered capture
>> while using the touchscreen part of the ADC (I have never used the IIO
>> before).

That's great, thanks for offering to test this.

> Last time I checked there was drivers/staging/iio/Documentation/generic_buffer.c 
> , but you can also wait for a more precise advice from Kristina . Hope it helps
> at least a bit ;-)

Yeah, I used generic_buffer.c for testing.

You can enable some channels like this:

echo 1 >/sys/bus/iio/devices/iio\:device0/scan_elements/in_voltage7_en
echo 1 >/sys/bus/iio/devices/iio\:device0/scan_elements/in_voltage10_en
echo 1 >/sys/bus/iio/devices/iio\:device0/scan_elements/in_voltage12_en
echo 1 >/sys/bus/iio/devices/iio\:device0/scan_elements/in_voltage13_en
echo 1 >/sys/bus/iio/devices/iio\:device0/scan_elements/in_voltage14_en
echo 1 >/sys/bus/iio/devices/iio\:device0/scan_elements/in_voltage15_en

And then start the capture and read 10 samples with generic_buffer:

./generic_buffer -n 80050000.lradc -c 10

And using the touchscreen at the same time should work now. Let me know
if it doesn't :)

Kristina
