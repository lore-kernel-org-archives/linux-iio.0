Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53981 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbcGWKz7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Jul 2016 06:55:59 -0400
Subject: Re: [PATCH 1/1] iio: vcnl4000: Add IR current adjust support
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Pratik Prajapati <pratik.prajapati12@gmail.com>
References: <1468850968-19523-1-git-send-email-pratik.prajapati12@gmail.com>
 <alpine.DEB.2.02.1607190016030.25263@pmeerw.net>
 <CAHNg1SoUfZvit9DCU8jt2=V4H7JgbAbBbPEAPyUV30_xXH-k4w@mail.gmail.com>
 <alpine.DEB.2.02.1607190820560.762@pmeerw.net>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d5cec15f-1fd8-de61-8198-0005715697ca@kernel.org>
Date: Sat, 23 Jul 2016 09:29:15 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1607190820560.762@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/07/16 08:21, Peter Meerwald-Stadler wrote:
> 
>>> comments below; nice addition
>>>
>>> it seems this patch clashes with the recent changes to this driver in
>>> iio-testing; can you rebase on top please?
>>
>> Where is iio-testing? I couldn't found it in linux.
> 
> https://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/log/?h=testing
> 
In theory stuff only stays in testing (alone) until I get the autobuilder
responses on it.  I've had a bit of an 'interesting' few weeks however
so haven't done the usual which is to push it out as togreg (which is the
non rebasing tree) in as timely a fashion as I should.

Worth checking testing to see if there is anything very recent, but better
to base new work on top of togreg.

Thanks 

Jonathan
> p. 
> 

