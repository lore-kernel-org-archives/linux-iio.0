Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53985 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415AbcGWK4A (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Jul 2016 06:56:00 -0400
Subject: Re: [PATCH 1/1] iio: vcnl4000: Add IR current adjust support
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Pratik Prajapati <pratik.prajapati12@gmail.com>
References: <1468850968-19523-1-git-send-email-pratik.prajapati12@gmail.com>
 <alpine.DEB.2.02.1607190016030.25263@pmeerw.net>
 <CAHNg1SoUfZvit9DCU8jt2=V4H7JgbAbBbPEAPyUV30_xXH-k4w@mail.gmail.com>
 <alpine.DEB.2.02.1607190820560.762@pmeerw.net>
 <CAHNg1SoH-vVD9e62aEyN1J+_RDDjS5_zoO8hXLytAitWxkGAgA@mail.gmail.com>
 <alpine.DEB.2.02.1607220013240.6041@pmeerw.net>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <9d0f4395-b82f-5942-1e4c-29ba6ba84d16@kernel.org>
Date: Sat, 23 Jul 2016 09:30:14 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1607220013240.6041@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/07/16 00:14, Peter Meerwald-Stadler wrote:
> 
>>>>> comments below; nice addition
>>>>>
>>>>> it seems this patch clashes with the recent changes to this driver in
>>>>> iio-testing; can you rebase on top please?
>>>>
>>>> Where is iio-testing? I couldn't found it in linux.
>>>
>>> https://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/log/?h=testing
>>
>> Means we have to do development here and this testing branch will get
>> merged to main branch later.
> 
> yes, Jonathan will queue up stuff in testing, then send to GregHK, and 
> then to mainline
Testing is a special branch for the autobuilders.  Except when I'm being
useless, the right branch to use is togreg as that 'never' rebases.

Jonathan
> 
> p.
> 

