Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46535 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbbKOMZS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Nov 2015 07:25:18 -0500
Subject: Re: [PATCH] Staging: iio: iio_simple_dummy_buffer: Typo in comments
 area
To: Nizam Haider <nizamhaider786@gmail.com>
References: <1447469041-5751-1-git-send-email-nizamhaider786@gmail.com>
 <5646FEC7.5050600@metafoo.de> <56476DAC.6030903@kernel.org>
 <20151115113503.GA18884@suse.site>
Cc: Lars-Peter Clausen <lars@metafoo.de>, knaack.h@gmx.de,
	pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, Nizam Haider <nijamh@cdac.in>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <564879AB.3050501@kernel.org>
Date: Sun, 15 Nov 2015 12:25:15 +0000
MIME-Version: 1.0
In-Reply-To: <20151115113503.GA18884@suse.site>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/11/15 11:35, Nizam Haider wrote:
> On Sat, Nov 14, 2015 at 05:21:48PM +0000, Jonathan Cameron wrote:
>> On 14/11/15 09:28, Lars-Peter Clausen wrote:
>>> On 11/14/2015 03:44 AM, Nizam Haider wrote:
>>>> Fix simple typo in comments
>>>>
>>>> Signed-off-by: Nizam Haider <nijamh@cdac.in>
>>>
>>> Thanks for the patch.
>>>
>>>> ---
>>>>  drivers/staging/iio/iio_simple_dummy_buffer.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
>>>> index cf44a6f..c8f889b 100644
>>>> --- a/drivers/staging/iio/iio_simple_dummy_buffer.c
>>>> +++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
>>>> @@ -64,7 +64,7 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
>>>>  		 * software scans: can be considered to be random access
>>>>  		 *   so efficient reading is just a case of minimal bus
>>>>  		 *   transactions.
>>>> -		 * software culled hardware scans:
>>>> +		 * software called hardware scans:
>>>
>>> I don't think that's a typo. The non-patched version makes a lot more sense
>>> then the patched vesion.
>> Yup, that's me using some 'more unusual' English terminology, Perhaps the word
>> 'dropped' would be clearer.
>>
>> Also, that comment is now a little misleading as it is unusual / undesirable
> Yes it is misleading now, non-patched version makes a lot more sense then patched
> version.
> but because of unusual english, should i use dropped and to send new patch or to just
> leave it.
> (it would be bit easy to understand in first shot with "dropped".)
I'd drop that whole section of the comment (software culled hardware scans:)
(and amend the first line to say Two common options here:
However, we should have a mention of the fact that the core will cut them down
by dropping unwanted channels.

Perhaps add a note to the 'hardware scans:' section along the lines of.

Note, the hardware scan may contain additional channels not requested by
a given buffer interface.  The IIO core will peform the necessary
demultiplexing operations to deliver data for only those channels requested
for the buffered interface (typically by userspace).

Feel free to rewrite that for clarity!


> 
> Nizam
>> to now do this in an individual driver.  The core demux code should take care
>> of it.
>>
>> Hmm.. I'll make a note to reread the comments in that driver and see if any
>> others could do with a refresh.
>>
>> Jonathan
>>>
>>>>  		 *   occasionally a driver may process the nearest hardware
>>>>  		 *   scan to avoid storing elements that are not desired. This
>>>>  		 *   is the fiddliest option by far.
>>>>
>>>
>>

