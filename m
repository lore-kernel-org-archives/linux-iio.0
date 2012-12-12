Return-Path: <holler@ahsoftware.de>
Message-ID: <50C8F273.4010404@ahsoftware.de>
Date: Wed, 12 Dec 2012 22:09:07 +0100
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Denis Ciocca <denis.ciocca@gmail.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Jonathan Cameron <jic23@kernel.org>
Subject: Re: question about driver for different sensors in the same ASIC
References: <3BE6D37A-6EDA-4E4C-808F-1DEAEDE86DA3@gmail.com>	<50C8DECC.7010706@metafoo.de> <CAEE_umopjN7C_jXhozc5r+uyCbO32E3NoLF=REvwtvPXYaR54w@mail.gmail.com> <50C8E7A7.2030901@metafoo.de>
In-Reply-To: <50C8E7A7.2030901@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Am 12.12.2012 21:23, schrieb Lars-Peter Clausen:
> On 12/12/2012 08:49 PM, Denis Ciocca wrote:
>>> Usually you'd want to be able to sample both the accelerometer and gyro
>> sensors
>>> at the same time, so just one driver should be fine.
>>>
>>> Or have the gyro and accelerometer sensors completely separated register
>> maps
>>> and don't share any functionality?
>>
>> Some sensors doesn't share any functionality, simply share the same
>> interface or better the control registers for single sensor are separated.
>> I test this with the current driver but the second proble doesn't start!
>> Only one probe is mandatory?
>
> You can only have one device per I2C address and only one probe call per
> device. If you really want to use two separated drivers you could create a mfd
> device and one subdevice for the gyro and accelerometer.

There are patches for a driver to use HID over i2c on lkml. Might be 
need some effort to implement that on devices, but maybe it's a solution.

Regards,

Alexander
