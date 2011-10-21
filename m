Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:54640 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373Ab1JUOJO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 21 Oct 2011 10:09:14 -0400
Message-ID: <4EA17D0E.3010106@cam.ac.uk>
Date: Fri, 21 Oct 2011 15:09:18 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [RFC 1/2] staging:iio: Do not use bitmasks for channel info addresses
References: <1319199855-24834-1-git-send-email-lars@metafoo.de> <4EA17297.2040700@cam.ac.uk> <4EA178AB.2080000@metafoo.de>
In-Reply-To: <4EA178AB.2080000@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/21/11 14:50, Lars-Peter Clausen wrote:
> On 10/21/2011 03:24 PM, Jonathan Cameron wrote:
>> On 10/21/11 13:24, Lars-Peter Clausen wrote:
>>> Currently the iio framework uses bitmasks for the address field of channel info
>>> attributes. This is for historical reasons and no longer required since it will
>>> only ever query a single info attribute at once. This patch changes the code to
>>> use the non-shifted iio_chan_info_enum values for the info attribute address.
>>>
>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>>>
>>> ---
>>> Runtime tested for some of th DACs. Others only compile tested.
>>>
>>> I did not change the read_raw, write_raw and write_raw_get_fmt callbacks to
>>> use iio_chan_info_enum as the type for the mask attribute in this patch. But we
>>> probably want to do this at some point.
>> Agreed.  Should probably stop calling it mask as well :)
>>
>> Still that can validly be a follow up patch if you don't want to
>> do it in here.
>>
>> I have vaguely wondered in those functions whether it makes
>> sense to mash the shared and separate variants together
>> in the handling.  Other than lazy coding I can't actually
>> see when this would hurt and it would make the kernel query
>> interface simpler.  Hence your MASK macro in the next patch would
>> take the enum value and double it + add one or not to say if
>> it is shared or not.
>>
>> One for a follow up patch I think.  Fiddly bit will be verifying
>> every driver does the right thing.  I suspect I for one may
>> have take advantage of the separation of these in a few
>> drivers.
>>
> 
> Sounds like a good idea. I had a quick look at the drivers and it seems
> there are a few ADCs and also the dummy driver which use this to
> differentiate between different channels. But if we do an automatic
> conversion the compiler will luckily complain if we use the same value in
> different case statements, so we'll know which drivers need a manual fixup.
I'll put a quick patch together for this then.  Will use a variant on your
macros so lets drop that one and do it all in one go.
> 
> 
>> Can't conceive of any reason what you have here could cause
>> any issues in drivers. Let us push this out asap.  I've just pulled
>> it into the github master branch.
>>
>> I've tested on everything I have wired up today. max1363 (couple
>> of parts), tsl2563 and lis3l02dq.
>>
>> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
>>
>> Nice work cleanup.  Got to love the stupid code you can end up
>> with as it evolves sometimes.
>>
>> Jonathan
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

