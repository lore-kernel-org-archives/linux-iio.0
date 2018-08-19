Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbeHSWUy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Aug 2018 18:20:54 -0400
Date: Sun, 19 Aug 2018 20:08:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: dpfrey@gmail.com, daniel.baluta@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: bme680: Add check for val2 in the
 write_raw function
Message-ID: <20180819200820.3ad2252a@archlinux>
In-Reply-To: <20180819171014.GA13175@himanshu-Vostro-3559>
References: <20180811102636.6171-1-himanshujha199640@gmail.com>
        <20180819172514.370d34fb@archlinux>
        <20180819171014.GA13175@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 19 Aug 2018 22:40:14 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> On Sun, Aug 19, 2018 at 05:25:14PM +0100, Jonathan Cameron wrote:
> > On Sat, 11 Aug 2018 15:56:36 +0530
> > Himanshu Jha <himanshujha199640@gmail.com> wrote:
> >   
> > > val2 is responsible for the floating part of the number to be
> > > written to the device. We don't need the floating part
> > > while writing the oversampling ratio for BME680 since the
> > > available oversampling ratios are pure natural numbers.
> > > 
> > > So, add a sanity check to make sure val2 is 0.
> > > 
> > > Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>  
> > 
> > As discussed in David's patch series v3, I think this is still relevant
> > but now needs an update to cover the new code.  
> 
> I already had informed David to reabse his series on top of my patch
> and he rebased this patch series.
> 
> So, it should apply cleanly without any further effort.
> 
> If it doesn't, then ping me.

Meh, was only some trivial fuzz. I thought things had changed more than that
as hadn't noticed you just applied it at the top of write_raw as all the
things that can be written in this driver are integers.

Anyhow, applied now.  Thanks,

Jonathan
> 
