Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4163 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbcFCMAj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2016 08:00:39 -0400
Message-ID: <57516E71.8080506@nvidia.com>
Date: Fri, 3 Jun 2016 17:18:01 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>
CC: <corbet@lwn.net>, <lars@metafoo.de>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: adc: ina3221: Add DT binding details
References: <1464784454-7988-1-git-send-email-ldewangan@nvidia.com> <20160603020759.GA23947@rob-hp-laptop> <433b182c-fe43-df5c-ac6a-20a024630514@kernel.org>
In-Reply-To: <433b182c-fe43-df5c-ac6a-20a024630514@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On Friday 03 June 2016 03:49 PM, Jonathan Cameron wrote:
> On 03/06/16 03:07, Rob Herring wrote:
>> On Wed, Jun 01, 2016 at 06:04:12PM +0530, Laxman Dewangan wrote:
>>> +
>>> +Optional properties:
>>> +------------------
>>> +one-shot-average-sample:	Integer, Number of sample to average before
>>> +				putting in the registers in oneshot mode.
> Pick a sensible default in the driver then leave this to userspace to
> control.

>>> +
>>> +one-shot-vbus-conv-time-us:	Integer in microseconds, ADC conversion time for
>>> +				bus voltage reading in oneshot mode.
> Hmm. This one is a little non obvious. It's really controlling the noise
> level more than anything else.  Kind of integration time I guess though
> not described as such in the datasheet.

Yes the conversion time and average time help to reduce noise on 
conversion and efefctively tune the conversion delay per channel based 
on system need.

 From data sheet:
The INA3221 has programmable conversion times for both the shunt and bus 
voltage measurements. The conversion times for these measurements can be 
selected from 140 µs to 8.244 ms. The conversion time settings, along 
with the programmable averaging mode, enable the INA3221 to be 
configured to optimize available timing requirements in a given 
application. For example, if a system requires data to be read every 2 
ms with all three channels monitored, the INA3221 can be configured with 
the conversion times for the shunt and bus voltage measurements set to 
332 µs. The INA3221 can also be configured with a different conversion 
time setting for the shunt and bus voltage measurements. This approach 
is common in applications where the bus voltage tends to be relatively 
stable. This situation allows for the time focused on the bus voltage 
measurement to be reduced relative to the shunt voltage measurement. For 
example, the shunt voltage conversion time can be set to 4.156 ms with 
the bus voltage conversion time set to 588 µs for a 5-ms update time.
There are trade-offs associated with conversion time settings and the 
averaging mode used. The averaging feature can significantly improve the 
measurement accuracy by effectively filtering the signal. This approach 
allows the INA3221 to reduce the amount of noise in the measurement that 
may be caused by noise coupling into the signal. A greater number of 
averages allows the INA3221 to be more effective in reducing the 
measurement noise component. The trade-off to this noise reduction is 
that the averaged value has a longer response time to input signal 
changes. This aspect of the averaging feature is mitigated to some 
extent with the critical alert feature that compares each single 
conversion to determine if a measured signal (with its noise component) 
has exceeded the maximum acceptable level.



We have different values for these parameters for oneshot and continuous 
mode.


>
> Again, I don't think this is really device tree material.
> However, you could argue the right decision on this is hardware dependant
> as it really depends on ripple in the voltages? Not how it's described in
> the datasheet though.

The tuning is done on platform specific and hence it is from the device 
tree here.


>>> +
>>> +one-shot-shunt-conv-time-us:	Integer in microseconds, ADC conversion time for
>>> +				shunt voltage reading in oneshot mode.
>>> +
>>> +continuous-average-sample:	Integer, Number of sample to average before
>>> +				putting in the registers in continuous mode.
> Classic oversampling - not device tree material as it may well want
> runtime configuration.

Yaah, it is oversampling.


>>> +
>>> +continuous-vbus-conv-time-us:	Integer in microseconds, ADC conversion time for
>>> +				bus voltage reading in continuous mode.
> Why should these be different from the one-shot versions?  Might be
> separately controlled (though I don't think they are).  If one setting
> makes sense fo the hardware in oneshot mode, surely the same setting makes
> sense in continuous mode.

The oneshot and continuous mode get change in run time. We have 
different configuration for the continuous mode and one shot mode for 
the oversampling.

>>> +
>>> +continuous-shunt-conv-time-us:	Integer in microseconds, ADC conversion time for
>>> +				shunt voltage reading in continuous mode.
>> These all need vendor prefix and need to state the valid range of
>> values.
>>
>>> +
>>> +enable-power-monitor:		Boolean, Enable power monitoring of the device.
> Is this the power good stuff?  description should be more detailed.

If there is no shunt resistance then we can not enable power monitor on 
that rail. Device does not mandate to have shunt and so this is based on 
platforms.



>>> +
>>> +enable-continuous-mode:		Boolean. Device support oneshot and continuous
>>> +				mode for the channel data conversion. Presence
>>> +				of this property will enable the continuous
>>> +				mode from boot.
> Is the difference between driver load time and the point where usespace can
> set it up significant enough to justify this?

We change the mode dynamically. If we have more core then goto the 
continuous mode so that we can apply throttling if power consumption is 
going more than requirement. If we are running single core then change 
to oneshot mode.


