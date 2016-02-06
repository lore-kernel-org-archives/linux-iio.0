Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40966 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891AbcBFSB6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 6 Feb 2016 13:01:58 -0500
Subject: Re: [RFC PATCH 1/2] iio: hmc5843 Add channel attribute for bias
 configuration
To: Lars-Peter Clausen <lars@metafoo.de>,
	Cristina Moraru <cristina.moraru09@gmail.com>, knaack.h@gmx.de,
	pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	cristina.opriceana@gmail.com, marek@goldelico.com,
	sdliyong@gmail.com, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	octavian.purdila@intel.com, daniel.baluta@intel.com
References: <1454597413-5298-1-git-send-email-cristina.moraru09@gmail.com>
 <56B38E29.8040300@metafoo.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56B63514.90907@kernel.org>
Date: Sat, 6 Feb 2016 18:01:56 +0000
MIME-Version: 1.0
In-Reply-To: <56B38E29.8040300@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/02/16 17:45, Lars-Peter Clausen wrote:
> On 02/04/2016 03:50 PM, Cristina Moraru wrote:
>> Replace non standard meas_conf attribute with the standard IIO
>> calibbias attribute.
>>
>> API for setting bias measurement configuration:
>>
>> 0 - Normal measurement configuration (default): In normal measurement
>>     configuration the device follows normal measurement flow. Pins BP
>>     and BN are left floating and high impedance.
>>
>> 1 - Positive bias configuration: In positive bias configuration, a
>>     positive current is forced across the resistive load on pins BP
>>     and BN.
>>
>> 2 - Negative bias configuration. In negative bias configuration, a
>>     negative current is forced across the resistive load on pins BP
>>     and BN.
>>
>> 3 - Only available on HMC5983. Magnetic sensor is disabled.
>>     Temperature sensor is enabled.
>>
>> With this in place, we can think of moving this driver out of staging.
> 
> Using a standard attribute, but overloading it with custom semantics doesn't
> do any good either. calibbias is supposed to be a integer that gets added to
> measurements internally in the device (unit is device specific though).
> 
> This attribute seems to do something else. In that case it might be better
> to stay with a custom attribute (as long as it is documented) or come up
> with a better way to map the device configuration onto standard attributes.
> 
Agree with Lars on this.  Only consistent way that this 'could' (it's not a good idea!)
be supported would be to make this an explicit output channel in a similar way
to we have debated doing with LED drivers in some of the proximity devices.

If it was meant to be a refined compensation of the measured output (perhaps
to correct for some other local field) then perhaps we could argue it as
an analog correction for which calibbias etc would be just about applicable.
Here it's really about self test I think...  One option would be to write
a sane self test entirely in the driver and run that on probe, similar to
we do for some other devices.  Then you could remove this attribute entirely.

Mind you it's not entirely obvious to me what steps the self test would actually
have so perhaps best to leave this to userspace (at least for now!)

Jonathan
