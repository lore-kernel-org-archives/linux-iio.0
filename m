Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33403 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751345AbcEENLT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 5 May 2016 09:11:19 -0400
MIME-Version: 1.0
In-Reply-To: <3e520787-1dc4-b703-9a44-1c3ac2200f25@intel.com>
References: <cover.1461953982.git.leonard.crestez@intel.com>
 <4aeaced7c1c8e222996df4c1b4b71e505ab256f7.1461953982.git.leonard.crestez@intel.com>
 <7168c23b-8b82-5e57-42fd-b164bee9fa85@kernel.org> <3e520787-1dc4-b703-9a44-1c3ac2200f25@intel.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 5 May 2016 08:10:50 -0500
Message-ID: <CAL_JsqKXv3vY_rce18jm4fcYBArc8V_o_1cpuUFYbJFgt2-QOA@mail.gmail.com>
Subject: Re: [RFC 5/7] iio: inv_mpu6050: Add support for auxiliary I2C master
To: Crestez Dan Leonard <leonard.crestez@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Ge Gao <GGao@invensense.com>, Peter Rosin <peda@axentia.se>,
	Linux I2C <linux-i2c@vger.kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Matt Ranostay <matt.ranostay@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, May 5, 2016 at 7:38 AM, Crestez Dan Leonard
<leonard.crestez@intel.com> wrote:
> On 05/01/2016 08:27 PM, Jonathan Cameron wrote:
>> On 29/04/16 20:02, Crestez Dan Leonard wrote:
>>> --- a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
>>> +++ b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
>>> @@ -1,16 +1,27 @@
>>>  InvenSense MPU-6050 Six-Axis (Gyro + Accelerometer) MEMS MotionTracking Device
>>>
>>> -http://www.invensense.com/mems/gyro/mpu6050.html
>> If this is invalid, please add an up to date link if possible.
>>> -
>>>  Required properties:
>>> - - compatible : should be "invensense,mpu6050"
>>> - - reg : the I2C address of the sensor
>>> + - compatible : should be "invensense,mpuXXXX"
>> List them all explicitly here rather than wild cards.
>>
> But the list is a bit long. I'll just write "see below for valid
> compatible strings".

No, please list here. 4 is not long. A note of which ones are SPI
would be good too.

Can you add 9250 as well as it is commonly available for maker h/w.

>
>>> + - reg : the I2C or SPI address of the sensor
>>>   - interrupt-parent : should be the phandle for the interrupt controller
>>>   - interrupts : interrupt mapping for GPIO IRQ
>>>
>>>  Optional properties:
>>>   - mount-matrix: an optional 3x3 mounting rotation matrix
>>> + - inv,i2c-aux-master: operate aux i2c in "master mode" (default is mux).
>>> +
>>> +Valid compatible strings:
>> Vendor prefix? These will work for historical reasons, but now vendor
>> prefix should definitely be there as well.
>>> + - mpu6000
>>> + - mpu6050
>>> + - mpu6500
>>> + - mpu9150
>>
> The driver currently only lists i2c_device_id and this will work
> ignoring the vendor string. I can prefix all these valid strings with
> the vendor prefix but this is not actually a requirement. That would
> require a separate unrelated patch adding of_device_id tables.

What the driver happens to do is irrelevant to the binding. From a
binding standpoint, the vendor prefix is always required.

Rob
