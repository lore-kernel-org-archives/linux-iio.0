Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34604 "EHLO
	mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990AbcGUOrL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jul 2016 10:47:11 -0400
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1607190820560.762@pmeerw.net>
References: <1468850968-19523-1-git-send-email-pratik.prajapati12@gmail.com>
 <alpine.DEB.2.02.1607190016030.25263@pmeerw.net> <CAHNg1SoUfZvit9DCU8jt2=V4H7JgbAbBbPEAPyUV30_xXH-k4w@mail.gmail.com>
 <alpine.DEB.2.02.1607190820560.762@pmeerw.net>
From: Pratik Prajapati <pratik.prajapati12@gmail.com>
Date: Thu, 21 Jul 2016 20:17:10 +0530
Message-ID: <CAHNg1SoH-vVD9e62aEyN1J+_RDDjS5_zoO8hXLytAitWxkGAgA@mail.gmail.com>
Subject: Re: [PATCH 1/1] iio: vcnl4000: Add IR current adjust support
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jul 19, 2016 at 11:51 AM, Peter Meerwald-Stadler
<pmeerw@pmeerw.net> wrote:
>
>
> > > comments below; nice addition
> > >
> > > it seems this patch clashes with the recent changes to this driver in
> > > iio-testing; can you rebase on top please?
> >
> > Where is iio-testing? I couldn't found it in linux.
>
> https://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/log/?h=testing

Means we have to do development here and this testing branch will get
merged to main branch later.
