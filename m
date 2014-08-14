Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38781 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbaHNRKM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 14 Aug 2014 13:10:12 -0400
Message-ID: <53ECED6C.30305@kernel.org>
Date: Thu, 14 Aug 2014 18:10:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Martin Fuzzey <mfuzzey@parkeon.com>
CC: linux-iio@vger.kernel.org, pmeerw@pmeerw.net
Subject: Re: [PATCH V2 7/8] iio: mma8452: add an attribute to enable the highpass
 filter
References: <20140729090128.4618.92936.stgit@localhost> <20140729090143.4618.9179.stgit@localhost> <53E3A9A3.8030103@kernel.org> <53E3B921.6050203@parkeon.com>
In-Reply-To: <53E3B921.6050203@parkeon.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/08/14 18:36, Martin Fuzzey wrote:
> On 07/08/14 18:30, Jonathan Cameron wrote:
>> On 29/07/14 10:01, Martin Fuzzey wrote:
>>> The hardware contains a single configurable highpass filter which
>>> is normally used for transient detection (event).
>>>
>>> However it is also possible to enable this filter for normal channel
>>> reading. Add a new attribute in_accel_high_pass_filter_en to do this.
>>>
>>> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
>> The obvious answer to this would be to set the cuttoff to 0.
>> Presumably the complexity here is there  is only one high pass filter
>> implementation, both for the data and for the event?
> Yes exactly
> 
>> If so I would probably still prefer it was done via the 3db point
>> setting, just that you have two attributes to access that - one for
>> the channel and one for the event.  Setting the channel version to
>> non zero would change both.  Setting the event one to any value
>> would change both only if the channel version is not zero.
> But I don't think that would handle the use case of
> * No filter for channel data
> * Filter for event
That was what the nasty bit (which I also don't like!) in my suggestion
was meant to handle.  Any time the channel version is 0 then a write
to the event one doesn't change it.  If it is non zero then it does.
(uggly use of 0 to specify that we have disabled the filter).
> 
> The hardware has
> 1) A register to set the filter frequency (one of 4 possible values, with the allowed set depending on the current
> sampling frequency)
> 2) A bit to enable the filter for value readings  (default disabled)
> 3) A bit to disable the filter for transient detection (default enabled)
> 
> My current patchset does not support 3) - the filter is always enabled for transient events
Ah. In that case perhaps a slight extension of the above:

Again two filter setting attributes, one for the event and one for the channel.
Both default to off
event : 0, channel : 0
write event version with value A

event : A, channel : 0

write channel version with value B
event : B, channel : B

write event version with value C

event : C, channel : C

write event version with 0

event : 0, channel : C

write event version with D

event : D, channel : D

write channel version with 0 to disable

event : D, channel : 0

write event version with 0 to disable

event : 0, channel 0 - no filters on.

Should be relatively easy to implement.  When you get a write simply check if the
other cached value is currently 0.  If it is, don't update it.  If it isn't then
do.  Unless a 0 is being written, in which case only disable which ever one has
been written to.

Mind you this logic will get interesting for low pass filters as setting the
cut off to 0 will end up letting through everything (somewhat counterintuitive!)


> 
>> It's a little fiddly, perhaps having an enable on a filter is
>> the way to go... Anyone else have any thought on this?
>>
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
