Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49545 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932140AbcIRKxM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Sep 2016 06:53:12 -0400
Subject: Re: [PATCH] iio: accel: sca3000_core: Fix superfluous indent white
 space
To: Alison Schofield <amsfield22@gmail.com>, daniel.baluta@gmail.com
References: <20160909174414.31002-1-ico@pruts.nl>
 <95f27ba9-d54c-3dad-6b33-217010ce55bd@kernel.org>
 <1473522932-sup-4169@pruts.nl>
 <50ce9913-92cc-8e1b-f8eb-2faec769622a@kernel.org>
 <1473530764-sup-9251@pruts.nl>
 <bf8b4602-e470-60e4-c378-e2bbe22a4c88@kernel.org>
 <20160913192229.GA3846@d830.WORKGROUP>
Cc: Ico Doornekamp <ico@pruts.nl>,
        linux-iio <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <dea17b69-e830-51df-8648-a52972a53ded@kernel.org>
Date: Sun, 18 Sep 2016 11:53:09 +0100
MIME-Version: 1.0
In-Reply-To: <20160913192229.GA3846@d830.WORKGROUP>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/09/16 20:22, Alison Schofield wrote:
> On Tue, Sep 13, 2016 at 06:37:17PM +0100, Jonathan Cameron wrote:
>> On 10/09/16 19:16, Ico Doornekamp wrote:
>>> * On 2016-09-10 18:26:45 +0200, Jonathan Cameron wrote:
>>>  
>>>> Another good one is to find things in staging drivers that we now
>>>> have IIO_INFO_* elements for.
>>>>
>>>> For example in sca3000 I see there is an explicit attribute defined that
>>>> could be replaced by IIO_INFO_SAMPLING_FREQUENCY being added in the
>>>> relevant masks and appropriate sections added to the read_raw
>>>> and write_raw callbacks.
>>>>
>>>> Not a trivial job, but not too hard to figure out perhaps?
> 
> Not trying to hijack Ico's work ;) but wondering if this task, applied to
> staging drivers, would be good to offer to this round of Outreachy
> applicants as a small coding task?
There are probably other cases still out there.  Wouldn't guarantee they
are all in staging either!

Commenting out the relevant macros in include/linux/iio/sysfs.h is
a good way to find these.  The whole shared_by_... stuff is
'relatively recent' so quite a few drivers predate it.

Good to get them cleaned up and it's not a bad step up from
white space fixes (as Ico has just demonstrated ;)

Thanks,

Jonathan

> 
> alisons
> 
>>>
>>> Not too hard, although I'm not able to actually run and test due to lack
>>> of hardware.
>> That's fine. This one is my driver (rather needing some care and attention)
>> and I have the hardware still.  It's somewhat of a pain to fire up so
>> I might do this one just on review but we'll see how busy I am at the weekend.
>>>
>>>> + a good step up from white space patches.
>>>
>>> I do hope the Little Penguin agrees on this :)
>> Should do!
>>>
>>>> Guess maybe that needs to be a bit later if you are ploughing through
>>>> the eudyptula-challenge (though that didn't exist when I got started
>>>> so I don't know what order they do stuff in!)
>>>
>>> I have no clue: I'm trying to stick to the steps and not peek ahead.
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

