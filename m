Return-Path: <linux@roeck-us.net>
Subject: Re: [PATCH 2/3] iio: adc: ina3221: Add support for IIO ADC driver for
 TI INA3221
To: Jonathan Cameron <jic23@kernel.org>,
 Laxman Dewangan <ldewangan@nvidia.com>, robh+dt@kernel.org, corbet@lwn.net,
 lars@metafoo.de
References: <1464784454-7988-1-git-send-email-ldewangan@nvidia.com>
 <1464784454-7988-2-git-send-email-ldewangan@nvidia.com>
 <44e28639-67b6-7586-5e6d-c0180ccded79@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Jean Delvare <khali@linux-fr.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5751863E.907@roeck-us.net>
Date: Fri, 3 Jun 2016 06:29:34 -0700
MIME-Version: 1.0
In-Reply-To: <44e28639-67b6-7586-5e6d-c0180ccded79@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 06/03/2016 03:06 AM, Jonathan Cameron wrote:
> On 01/06/16 13:34, Laxman Dewangan wrote:
>> The INA3221 is a three-channel, high-side current and bus voltage monitor
>> with an I2C interface from Texas Instruments. The INA3221 monitors both
>> shunt voltage drops and bus supply voltages in addition to having
>> programmable conversion times and averaging modes for these signals.
>> The INA3221 offers both critical and warning alerts to detect multiple
>> programmable out-of-range conditions for each channel.
>>
>> Add support for INA3221 SW driver via IIO ADC interface. The device is
>> register as iio-device and provides interface for voltage/current and power
>> monitor. Also provide interface for setting oneshot/continuous mode and
>> critical/warning threshold for the shunt voltage drop.
>>
>> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Hi Laxman,
>
> As ever with any driver lying on the border of IIO and hwmon, please include
> a short justification of why you need an IIO driver and also cc the
> hwmon list + maintainers. (cc'd on this reply).
>
> I simply won't take a driver where the hwmon maintainers aren't happy.
> As it stands I'm not seeing obvious reasons in the code for why this
> should be an IIO device.
>

Me not either.

I have a hwmon driver for the same chip pending from Andrew Davis (TI)
which I am just about to accept. We had directed Andrew back in April
to write a hwmon driver for the chip, which he did.

Guenter
