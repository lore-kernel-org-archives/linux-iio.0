Return-Path: <jeff.dagenais@gmail.com>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH] iio:dac: fix i2c_master_send return code misuse
From: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
In-Reply-To: <563F4E1A.2020201@kernel.org>
Date: Sun, 8 Nov 2015 09:10:39 -0500
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org,
 knaack.h@gmx.de,
 pmeerw@pmeerw.net,
 Michael.Hennerich@analog.com
Message-Id: <DA5D8A05-2B37-441E-804B-C73BCBE8628C@gmail.com>
References: <1445963139-2158-1-git-send-email-jeff.dagenais@gmail.com> <1445963139-2158-2-git-send-email-jeff.dagenais@gmail.com> <5638C45E.8010209@metafoo.de> <20151104011026.GA39311@dtor-ws> <563F4E1A.2020201@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>


> On Nov 8, 2015, at 8:28 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> 
>> Fell through the cracks I'm afraid. I think facility like this is still
>> needed as majority of the drivers do not care about short reads in the
>> slightest.
>> 
> Would be great to pick it up again if you have the time!
> 

Certainly, the i2c chips handled by ad5446.c do no function at all with the
current state of the driver!

I can resubmit a patch only for ad5446.c or wait for Dmitry's patch to be
applied, then make the proper change in ad5446.c.

For now, our own tree contains my original patch, so we're good... thank you
open source!
