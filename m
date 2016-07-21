Return-Path: <pmeerw@pmeerw.net>
Date: Fri, 22 Jul 2016 00:14:45 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Pratik Prajapati <pratik.prajapati12@gmail.com>
cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
    Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: vcnl4000: Add IR current adjust support
In-Reply-To: <CAHNg1SoH-vVD9e62aEyN1J+_RDDjS5_zoO8hXLytAitWxkGAgA@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1607220013240.6041@pmeerw.net>
References: <1468850968-19523-1-git-send-email-pratik.prajapati12@gmail.com> <alpine.DEB.2.02.1607190016030.25263@pmeerw.net> <CAHNg1SoUfZvit9DCU8jt2=V4H7JgbAbBbPEAPyUV30_xXH-k4w@mail.gmail.com> <alpine.DEB.2.02.1607190820560.762@pmeerw.net>
 <CAHNg1SoH-vVD9e62aEyN1J+_RDDjS5_zoO8hXLytAitWxkGAgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


> > > > comments below; nice addition
> > > >
> > > > it seems this patch clashes with the recent changes to this driver in
> > > > iio-testing; can you rebase on top please?
> > >
> > > Where is iio-testing? I couldn't found it in linux.
> >
> > https://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/log/?h=testing
> 
> Means we have to do development here and this testing branch will get
> merged to main branch later.

yes, Jonathan will queue up stuff in testing, then send to GregHK, and 
then to mainline

p.

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
