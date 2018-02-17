Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750980AbeBQMTS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Feb 2018 07:19:18 -0500
Date: Sat, 17 Feb 2018 12:19:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org, 21cnbao@gmail.com,
        linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de
Subject: Re: [PATCH 2/4] staging: iio: accel: Remove unnecessary comments
 and add suitable suffix
Message-ID: <20180217121912.6b7cb5ae@archlinux>
In-Reply-To: <20180212194604.GB15335@himanshu-Vostro-3559>
References: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
        <1518436499-8584-3-git-send-email-himanshujha199640@gmail.com>
        <20180212125312.cjo76spuu6agjawc@mwanda>
        <20180212143522.GA12142@himanshu-Vostro-3559>
        <20180212145731.kws25sjinzqq6ax6@mwanda>
        <20180212194604.GB15335@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 13 Feb 2018 01:16:05 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> On Mon, Feb 12, 2018 at 05:57:31PM +0300, Dan Carpenter wrote:
> > On Mon, Feb 12, 2018 at 08:05:22PM +0530, Himanshu Jha wrote:  
> > > But these should be done when we have *more* instances.
> > > 
> > > For eg: 
> > > I added a tab space in function static int adis16201_read_raw() argument
> > > to match open parentheses in this patch. But I also added tabs while
> > > removing and adding suitable suffix to the macros. So, should it also be
> > > done in a separate patch ?  
> > 
> > If you're changing a line of code and you fix a white space issue on
> > that same line, then that's fine.  If it's just in the same function,
> > then do it in a separate patch.  In other words, adding tabs when you're
> > moving around macros is fine, but adding it to the arguments is
> > unrelated.  
> 
> I will try and divide my patches next time :)
> 
> > This patch was honestly pretty tricky to review.  
> 
> I am sorry for that. Might be easy for IIO reviewers ;)
> 
> > Jonathan assumes reviewers have the datasheet in front of them and I
> > assume that that they don't.  He's probably right...  But especially
> > comments like this:
> > 
> > 		*val2 = 220000; /* 1.22 mV */  
> 
> They are pretty obvious as you can see from the return statements
> just below that which is :
> 
> 		return IIO_VAL_INT_PLUS_MICRO;
> 
> These comments are obvious because we know 'val1' will be responsible
> for Integer part(1.0) and 'val2' for the Micro part(220000 * 10^-6 = 0.22).
> Isn't it ?
> 
> Although I am new to IIO please correct if I'm wrong.
> 
The oddity here is that the base units (here mV) are inconsistent due
to some ancient attempts to align with other subsystems.

Dan is perhaps correct in that the comment might be helpful for that reason.
If so I would prefer to see it made clear what is going on.

/* Voltage base units are mV hence 1.22 mV */
Also should definitely have it's own line rather than being associated
with just the val2 line like it currently is.

Jonathan
