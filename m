Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:35621 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958Ab2LMIsG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 13 Dec 2012 03:48:06 -0500
Message-ID: <50C99640.7020901@jic23.retrosnub.co.uk>
Date: Thu, 13 Dec 2012 08:48:00 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Denis Ciocca <denis.ciocca@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: question about driver for different sensors in the same ASIC
References: <3BE6D37A-6EDA-4E4C-808F-1DEAEDE86DA3@gmail.com>	<50C8DECC.7010706@metafoo.de> <CAEE_umopjN7C_jXhozc5r+uyCbO32E3NoLF=REvwtvPXYaR54w@mail.gmail.com> <50C8E7A7.2030901@metafoo.de> <50C99192.6060707@jic23.retrosnub.co.uk>
In-Reply-To: <50C99192.6060707@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/12/12 08:28, Jonathan Cameron wrote:
> On 12/12/12 20:23, Lars-Peter Clausen wrote:
>> On 12/12/2012 08:49 PM, Denis Ciocca wrote:
>>>> Usually you'd want to be able to sample both the accelerometer and gyro
>>> sensors
>>>> at the same time, so just one driver should be fine.
>>>>
>>>> Or have the gyro and accelerometer sensors completely separated
>>>> register
>>> maps
>>>> and don't share any functionality?
>>>
>>> Some sensors doesn't share any functionality, simply share the same
>>> interface or better the control registers for single sensor are
>>> separated.
>>> I test this with the current driver but the second proble doesn't start!
>>> Only one probe is mandatory?
>>
>> You can only have one device per I2C address and only one probe call per
>> device. If you really want to use two separated drivers you could
>> create a mfd
>> device and one subdevice for the gyro and accelerometer.
>>
>> - Lars
> Agreed, not much else you can do other than refactor the driver to
> handle them as two 'instances' of the iio bits called from a single
> probe function with callbacks to make the shared i2c element work
> reasonably...  Fiddly, but its got to be that or a fall blown mfd
> (not sure if the mfd side of things will bring enough benefits here...)
>
Just to give us some real basis for this discussion, which part number 
is it that does this?  The only ones I can immediately find (lsm330)
use different i2c addresses for the two parts.

Obviously if we are discussing a part for which docs are not available,
we'll be pestering you for more information as we can't get it from
the datasheet :)
