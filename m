Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:63982 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262AbbBARVf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 1 Feb 2015 12:21:35 -0500
Date: Sun, 1 Feb 2015 18:21:29 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
Reply-To: Stefan Wahren <stefan.wahren@i2se.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: pmeerw@pmeerw.net, robert.hodaszi@digi.com, knaack.h@gmx.de,
	lars@metafoo.de, alexandre.belloni@free-electrons.com,
	fabio.estevam@freescale.com, linux-iio@vger.kernel.org,
	marex@denx.de
Message-ID: <855108935.196657.1422811289692.JavaMail.open-xchange@oxbaltgw05.schlund.de>
In-Reply-To: <54CDFCA3.5050203@kernel.org>
References: <1420317252-19761-1-git-send-email-stefan.wahren@i2se.com> <54A91E2C.7070109@kernel.org> <1818754820.704464.1420371563334.JavaMail.open-xchange@oxbaltgw01.schlund.de> <54CDFCA3.5050203@kernel.org>
Subject: Re: [PATCH V2] iio: mxs-lradc: fix iio channel map regression
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> Jonathan Cameron <jic23@kernel.org> hat am 1. Februar 2015 um 11:14
> geschrieben:
>
>
> On 04/01/15 11:39, Stefan Wahren wrote:
> > Hi Jonathan,
> >
> >> Jonathan Cameron <jic23@kernel.org> hat am 4. Januar 2015 um 12:04
> >> geschrieben:
> >>
> >>
> >> On 03/01/15 20:34, Stefan Wahren wrote:
> >>> Since commit c8231a9af8147f8a ("iio: mxs-lradc: compute temperature
> >>> from channel 8 and 9") with the removal of adc channel 9 there is
> >>> no 1-1 mapping in the channel spec.
> >>>
> >>> All hwmon channel values above 9 are accessible via there index minus
> >>> one. So add a hidden iio channel 9 to fix this issue.
> >>>
> >>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> >> I'll have to hold this for a bit. I'm running rather behind with
> >> pull requests so my fixes tree is still pre the last release and
> >> hence doesn't have the patch that caused the problem yet...
> >>
> >> Should unwind that this week.
> >
> > i forgot to mention this patch in version 2 is the solution of this old
> > discussion:
> >
> > https://lkml.org/lkml/2014/6/14/69
> >
> > So the problem should be in your fixes tree. Sorry for the confusion.
> >
> > Stefan
> Being totally useless I seem to have forgotten to apply this. Given
> timing the fastest route now will be to send it out just after the coming
> merge window marked for stable. Applied to the fixes-togreg branch of
> iio.git
>
> Thanks and sorry for the delay,
>
> Jonathan
 
Thanks

Stefan
