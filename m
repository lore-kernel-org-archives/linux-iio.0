Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43523 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148AbbCINtF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2015 09:49:05 -0400
Message-ID: <54FDA4CE.5070500@kernel.org>
Date: Mon, 09 Mar 2015 13:49:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	abhijit <abhijitnaik27@gmail.com>, linux-iio@vger.kernel.org,
	Patrick Vasseur <patrick.vasseur@c-s.fr>,
	Michael Hennerich <hennerich@blackfin.uclinux.org>
Subject: IIO Channel Sequencer Handling.  was Re: AD7923 sequencer functionality
 implementation in Kernel
References: <54FD2F9A.2070502@gmail.com> <54FD9CD9.3080306@kernel.org> <54FDA14D.3010803@metafoo.de>
In-Reply-To: <54FDA14D.3010803@metafoo.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/03/15 13:34, Lars-Peter Clausen wrote:
> On 03/09/2015 02:15 PM, Jonathan Cameron wrote:
>> On 09/03/15 05:28, abhijit wrote:
>>> Hi All,
>>>
>>> We are using AD7923 driver as reference for one of our customer's ADC IP
>>>
>>> The ADC that we are using, has sequencer functionality. In current state of AD7923 driver, there is no support for sequencer functionality.
>>>
>>> Can you please let me know whether the IIO driver team is coming up with design for sequencer functionality of the device.
>> Cc'd Lars, Michael and Patrick.  Looks like a fairly standard sequencer.
>> Just a question of whether anyone has already looked at it.
> 
> I've been tormenting my head now for a while how to properly model
> sequencers in IIO, but haven't come to a conclusion yet.
> 
> The problem is you have one physical channel but a configurable
> amount of logical channels. The ADC will cycle through the selected
> channels one after another.
Ah I'd failed to register we don't have a convenient hardware buffer like
the Maxim parts do.  On those you are cycling but the driver can read
them all at the same time. Obviously the timestamps are less than
great as a result.
> 
> IIO on the other hand expects that all channels that are selected are
> actually converted at the same time. E.g. you have to supply all the
> selected channels at the same time to iio_buffer_push_data() and also
> metadata, like the timestamps, is expected to be supplied only once
> for every set of samples and not for every individual logical
> channel.
Hmm. Could add some more info to the timestamp to let us associate
it with a channel I suppose..  Bit fiddly though.

Not ideal. 
> 
> Furthermore things like the output data rate of each channel depend
> on the number of selected channels. So if you configure the sample
> rate and then change the number of selected channels you potentially
> end up with a different sample rate than initially selected.
For that we can rely on the standard ABI statement that a write to any
attribute can change the value read from any other and just report
the change via the sampling_frequency attribute.  I know that approach
is ugly, but we can't hope to have a coherent way of coping with all
the weird interactions we see on devices.

Short of adding lots of meta data, I guess the easiest would be to
fake what we do in the maxim drivers (with their sequencers feeding
into a fifo) and construct a 'scan' of whatever channels we are reading
with a rather fuzzy timestamp.

We could specify known offsets from the timestamp for the individual
channels.  These ought to be well specified.  Thus a single timestamp
could be used to specify all the individual elements of the scans
timing and have userspace reconstruct whatever timing info it wants.

This functionality would also be useful for clock equipped devices
where we timestamp on the dataready.  Clearly the sample and hold
is usually at least a few ADC clocks before the interrupt.

So would a new infomask element called *_timestampoffset
(positive or negative depending on whether we timestamp on a trigger
 of the sequence or at the end of it) solve that issue?

(just thinking as a type so may well have missed something vital
and haven't written a terribly coherent argument.
> 
> - Lars

