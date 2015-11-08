Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43633 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbbKHPLA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Nov 2015 10:11:00 -0500
Subject: Re: [PATCH] iio:dac: fix i2c_master_send return code misuse
To: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
References: <1445963139-2158-1-git-send-email-jeff.dagenais@gmail.com>
 <1445963139-2158-2-git-send-email-jeff.dagenais@gmail.com>
 <5638C45E.8010209@metafoo.de> <20151104011026.GA39311@dtor-ws>
 <563F4E1A.2020201@kernel.org>
 <DA5D8A05-2B37-441E-804B-C73BCBE8628C@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
	Michael.Hennerich@analog.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <563F6601.2030309@kernel.org>
Date: Sun, 8 Nov 2015 15:10:57 +0000
MIME-Version: 1.0
In-Reply-To: <DA5D8A05-2B37-441E-804B-C73BCBE8628C@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/11/15 14:10, Jean-Francois Dagenais wrote:
> 
>> On Nov 8, 2015, at 8:28 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>>
>>> Fell through the cracks I'm afraid. I think facility like this is still
>>> needed as majority of the drivers do not care about short reads in the
>>> slightest.
>>>
>> Would be great to pick it up again if you have the time!
>>
> 
> Certainly, the i2c chips handled by ad5446.c do no function at all with the
> current state of the driver!
> 
> I can resubmit a patch only for ad5446.c or wait for Dmitry's patch to be
> applied, then make the proper change in ad5446.c.
> 
> For now, our own tree contains my original patch, so we're good... thank you
> open source!
Where things are actually broken we'll want the fix in stable kernel
trees so ideally we'll have the following:

1) Your current fix applied asap marked for stable.
2) Dmitry's patch resurfaces and allows us to follow up in a cycle or so with
cleanups that move every case over to that, hopefully avoiding any further repeats
of this problem!

If you can role a response to the point Lars raised and send an updated series
that would be great.  Next set of fixes to head towards mainline will be next
weekend at the earliest anyway so we have a bit of time to tidy up!

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

