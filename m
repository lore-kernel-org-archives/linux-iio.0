Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932121AbeCJPFX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Mar 2018 10:05:23 -0500
Date: Sat, 10 Mar 2018 15:05:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, daniel.baluta@gmail.com
Subject: Re: [PATCH 10/11] Staging: iio: accel: Add comments about units in
 data read function
Message-ID: <20180310150517.08a57a17@archlinux>
In-Reply-To: <20180308072819.GA24090@himanshu-Vostro-3559>
References: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
        <1520236170-14668-11-git-send-email-himanshujha199640@gmail.com>
        <20180307205030.11fff428@archlinux>
        <20180308072819.GA24090@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 8 Mar 2018 12:58:19 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> On Wed, Mar 07, 2018 at 08:50:30PM +0000, Jonathan Cameron wrote:
> > On Mon,  5 Mar 2018 13:19:29 +0530
> > Himanshu Jha <himanshujha199640@gmail.com> wrote:
> >   
> > > Clarify the conversion and formation of resultant data in the
> > > adis16201_read_raw() with sufficient comments.
> > > 
> > > Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>  
> > This is fine but it needs to be in the original comment changing patch
> > rather than removing the comments first then a few patches later putting
> > back a different version.
> > 
> > So good change but in the wrong place in the series.  Learning to reorder
> > a series and merge down multiple patches into one is very useful when
> > working with git.  
> 
> I will send v2 with all the updates!
> 
> What about sign_extend32 & reverse christmas ordering patch ? Will you
> pick that up or shall I send them again ?
Please repost anything not yet applied in V2 of the series.

Makes it much easier for me to avoid missing patches!

Thanks,

Jonathan

> 

