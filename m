Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:42122 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601Ab1BWLBu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 23 Feb 2011 06:01:50 -0500
Message-ID: <4D64E93B.1030509@cam.ac.uk>
Date: Wed, 23 Feb 2011 11:02:19 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Drivers <Drivers@analog.com>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH] IIO: ADC: New driver for the AD7298 8-channel SPI ADC
References: <1297692220-30306-1-git-send-email-michael.hennerich@analog.com> <4D63C965.8030309@cam.ac.uk> <4D6426ED.3090101@analog.com>
In-Reply-To: <4D6426ED.3090101@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/22/11 21:13, Michael Hennerich wrote:
> On 02/22/2011 03:34 PM, Jonathan Cameron wrote:
>> On 02/14/11 14:03, michael.hennerich@analog.com wrote:
>>   
>>> From: Michael Hennerich <michael.hennerich@analog.com>
>>>
>>> This patch adds support for the
>>> AD7298:  8-Channel, 1MSPS, 12-Bit SAR ADC with Temperature Sensor
>>> via SPI bus.
>>>
>>> This patch replaces the existing ad7298.c driver completely.
>>> It was necessary since, the old driver did not comply with the
>>> IIO ABI for such devices.
>>>     
>> Guess that's one approach to fixing up a driver!
>> Anyhow, it's nice and clean now.
>>   
> Rewrite is sometimes easier than fix ;-)
> 
>> Couple of trivial points inline.  You may need some locking
>> in the temperature read function, fix that or explain what
>> I'm missing before sending on to Greg, the other bits are up
>> to you.
>>   
> Good point.
>> I see the original driver used a busy pin. For the record, could you
>> also explain any disadvantages in this new one not doing that?
>>   
> Well the busy pin is only used to for on-die temperature measurements.
> The busy time is pretty deterministic, wasting a GPIO or interrupt line
> is pointless!
> Sleep for at least 100us, does the job. I see no point what this task
> could do useful otherwise,
> since it would also result in a sleep.
> 
> Last but not least - this is a 8-Channel ADC, the temperature diode is
> only the hard wired 9th channel,
> with pretty limited use. The busy pin might be useful for none OS 8-bit
> micro systems, but here
> we simply put the task asleep.
Good, that gives us a clean explanation to refer people to if they ask
this question in the future.  Thanks for clearing that up.

...
