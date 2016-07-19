Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:58571 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752490AbcGSGVN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 19 Jul 2016 02:21:13 -0400
Date: Tue, 19 Jul 2016 08:21:10 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Pratik Prajapati <pratik.prajapati12@gmail.com>
cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: vcnl4000: Add IR current adjust support
In-Reply-To: <CAHNg1SoUfZvit9DCU8jt2=V4H7JgbAbBbPEAPyUV30_xXH-k4w@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1607190820560.762@pmeerw.net>
References: <1468850968-19523-1-git-send-email-pratik.prajapati12@gmail.com> <alpine.DEB.2.02.1607190016030.25263@pmeerw.net> <CAHNg1SoUfZvit9DCU8jt2=V4H7JgbAbBbPEAPyUV30_xXH-k4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> > comments below; nice addition
> >
> > it seems this patch clashes with the recent changes to this driver in
> > iio-testing; can you rebase on top please?
> 
> Where is iio-testing? I couldn't found it in linux.

https://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/log/?h=testing

p. 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
