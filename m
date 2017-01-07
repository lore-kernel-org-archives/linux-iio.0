Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39438 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941508AbdAGRzN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Jan 2017 12:55:13 -0500
Subject: Re: [PATCH] iio: max5481: Add support for Maxim digital
 potentiometers
To: Slawomir Stepien <sst@poczta.fm>,
        Matthew Weber <matthew.weber@rockwellcollins.com>
References: <1481136052-1660-1-git-send-email-matthew.weber@rockwellcollins.com>
 <alpine.DEB.2.02.1612071958050.32025@pmeerw.net>
 <CANQCQpZdo3KQyTcMx_RPbjkFhj=E7uuaayJr4n1Vh6QTaH1VHw@mail.gmail.com>
 <20170107172815.GA1845@x220.localdomain>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, cristina.moraru09@gmail.com,
        Maury Anderson <maury.anderson@rockwellcollins.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <20ca54ce-f6c7-3359-06f4-69f463f52c17@kernel.org>
Date: Sat, 7 Jan 2017 12:55:10 -0500
MIME-Version: 1.0
In-Reply-To: <20170107172815.GA1845@x220.localdomain>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/01/17 12:28, Slawomir Stepien wrote:
> On Jan 03, 2017 11:37, Matthew Weber wrote:
>> Thanks for the review.  At this time we aren't in a position to spend
>> time on updates but just wanted to share what we pulled together for
>> others to start from.  I'll mark this as rejected.
> 
> In that case I would like to continue in resubmitting this driver. 
> I do not have the chip on me, but I will try to do my best to analyze it on my
> signal analyzer ;)
Excellent.
> 
> Any hints for me regarding resubmitting drivers created by someone else
> (copyright, authors, etc issues)?
> 
Basically you keep the From and initial sign off as per the original submission then
add your own sign off afterwards.  If the changes you make are significant then it is
fair enough to add your own copyright notice (maintaining any already in place as well).

Easiest thing is to apply the original patch then just make changes using git commit --amend
as that will keep everything correct.

Looking forward to updated driver.  I'm could take this into drivers/staging/iio but
as you are working on it there is probably little point and it would be cleaner to take
it directly into drivers/iio.

Thanks,

Jonathan
