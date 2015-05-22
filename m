Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45316 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945931AbbEVR6F (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 22 May 2015 13:58:05 -0400
Message-ID: <555F6E2B.5060904@kernel.org>
Date: Fri, 22 May 2015 18:58:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Martin Fuzzey <mfuzzey@parkeon.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH V4 6/7] iio: mma8452: Add highpass filter configuration.
References: <20150513102635.27803.99054.stgit@localhost> <20150513102648.27803.92023.stgit@localhost> <555863FF.1040203@kernel.org> <5559A020.9020105@parkeon.com>
In-Reply-To: <5559A020.9020105@parkeon.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/05/15 09:17, Martin Fuzzey wrote:
> On 17/05/15 11:48, Jonathan Cameron wrote:
>> On 13/05/15 11:26, Martin Fuzzey wrote:
>>> Allow the cutoff frequency of the high pass filter to be configured.
>>>
>>> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
>> Oops, I missed in patch 4 that you'd added the event_spec entry for the highpass
>> filter but not the support to actually read it (which is here).
> Ah true, good catch
> 
>> I'll back out back to patch 4.  Could you repost with that sorted out.
> ok
> 
>> Also, if (as I think is happening here) we have a filter applied to all
>> the data that is read from a channel (including it's events) then we normally
>> only have the attribute for the iio_chan_spec rather than the event spec
>> as well.
>>
>> Anything that is in the parent directory is also assumed to apply to the
>> event directory if not overridden (by it being in both) as we could have
>> a pipeline in the device with seperate filters for the event detector and
>> the main data flow (not true here?)
>>
>> Hence, please drop the event version unless I have missunderstood what
>> you are doing with the hardware.
>>
>> It's fine to leave the abi docs in place however as they are correct even
>> if we don't normally introduced them until there is a driver using them.
> 
> The hardware has one filter and two enable bits (one for the data and one for the event)
> It is thus possible to read unfiltered data but have the filter applied for the events.
> 
> We discussed this in revision 2 of the series.
> https://www.marc.info/?l=linux-iio&m=140803621414813&w=2
> 
> I thought we agreed in the above discussion to represent this as two 3db frequencies with 0 meaning disable.
> I did that for V3 of the series.
> 
Hmm.  thought I'd replied to this from my phone the other day..
Just in case that never went anywhere, this is fine and just
my memory failing me!  

Jonathan

