Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:34860 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755516Ab2CVKAC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 22 Mar 2012 06:00:02 -0400
Message-ID: <4F6AF81F.3040907@cam.ac.uk>
Date: Thu, 22 Mar 2012 09:59:59 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	Drivers <Drivers@analog.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] iio: amplifiers: New driver for AD8366 Dual-Digital Variable
 Gain Amplifier
References: <1329914182-5428-1-git-send-email-michael.hennerich@analog.com> <4F6A2D2B.9050400@kernel.org> <4F6AE844.7020102@analog.com> <4F6AEC83.8010009@cam.ac.uk> <4F6AF68A.40306@analog.com>
In-Reply-To: <4F6AF68A.40306@analog.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 3/22/2012 9:53 AM, Michael Hennerich wrote:
> On 03/22/2012 10:10 AM, Jonathan Cameron wrote:
>> On 3/22/2012 8:52 AM, Michael Hennerich wrote:
>>> On 03/21/2012 08:34 PM, Jonathan Cameron wrote:
>>>> On 02/22/2012 12:36 PM, michael.hennerich@analog.com wrote:
>>>>> From: Michael Hennerich<michael.hennerich@analog.com>
>>>> Sorry for the slow response on this one. Been off sick...
>>>>
>>>> Anyhow, I'm still not sure what the right interface for this type
>>>> of device is.
>>>>
>>>> The obvious options are:
>>>>
>>>> 1) Make gain an IIO type (doesn't make much sense as gain is only 
>>>> going
>>>> to be of one particular existing type).
>>>> 2) Have it as an IIO_ALTVOLTAGE channel as you have here and use 
>>>> extend
>>>> name.  Any real reason for picking altvoltage rather than voltage?
>>> I'm open for advice. Since I made the amplifier being an OUT type 
>>> device
>>> I chose IIO_ALTVOLTAGE analogous to our DDS/PLL drivers.
>>> Some VGAs/PGAs work from DC, but typically VGAs are HF devices.
>> Hmm.. Don't suppose it really matters but we ought to aim for 
>> consistency
>> (by review) at least.  This particular part is DC through to 600MHz.
>>>> Clearly gain has the same meaning in either case (assuming it's 
>>>> linear).
>>>> 3) Make a change to core to allow a channel to have elements in
>>>> info_mask but not actually to have a raw access.  Not entirely sure
>>>> how we will do that cleanly.  Also it's not clear whether the gain
>>>> would be an IN or an OUT channel type!
>>> Well - having the ability for channels without raw access element
>>> would be of interest.
>> True enough.  Cleanest way to do this that I can think of is to make 
>> a tree
>> wide change to add the raw element to the info_mask.  We could allow for
>> a zero info_mask value actually being the equivalent of having only a 
>> raw
>> channel.  It's invasive but if we agreee it should be done now is
>> probably the
>> best time to do it (just post merge window etc).
> Well - to make the change less invasive - we could use reversed logic
> add a new info_mask element IIO_CHAN_INFO_NO_RAW=0.
> We already reserve 0...
I wondered about doing exactly that as well.
Less invasive but then we have a rather illogical setup...  If we were 
out of staging
then we'd probably go with that hack, but given we still have scope to 
make wholesale
changes, lets do it properly...  Almost every channel should have an 
info_mask set
anyway (only exception is processed channels where nothing is 
controllable) an there
are very very few of them.

I'll do this change if we go with it as I have some patches clearling 
out IIO_CHAN
macro usage once and for all and this is sure as heck going to clash!
>
>> Whilst here, we clearly need way of destinguishing values in DB from 
>> linear
>> gains.  Could add a new return type for read_raw callbacks?
> That should work. ... and the core adds dB to the string?
That's what I was thinking.  Not ideal, but it's still reasonably 
machine readable and
should work fine with in kernel users as well as long as the reader / 
writer is expecting
it (or the boiler plate code is).


