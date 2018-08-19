Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbeHST0X (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Aug 2018 15:26:23 -0400
Date: Sun, 19 Aug 2018 17:14:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: David Frey <dpfrey@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 7/7] iio: chemical: bme680: simplify oversampling
 handling
Message-ID: <20180819171422.6d45a5b2@archlinux>
In-Reply-To: <20180818111750.GH24920@himanshu-Vostro-3559>
References: <20180817190319.13119-1-dpfrey@gmail.com>
        <20180817190319.13119-8-dpfrey@gmail.com>
        <20180818111750.GH24920@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 18 Aug 2018 16:47:50 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> On Fri, Aug 17, 2018 at 12:03:19PM -0700, David Frey wrote:
> > Temperature, pressure and humidity all expose and oversampling setting
> > that works in the same way.  Provide common handling for the
> > oversampling sysfs attributes.
> > 
> > Signed-off-by: David Frey <dpfrey@gmail.com>  
> 
> Reviewed-by: Himanshu Jha <himanshujha199640@gmail.com>
> Tested-by: Himanshu Jha <himanshujha199640@gmail.com>
> 
> Also, 0-day tested with build success!
> 
> Thanks
> 
> With this I don't think my patch:
> https://lore.kernel.org/lkml/20180811102636.6171-1-himanshujha199640@gmail.com/
> is useful any more since bme680_is_valid_oversampling()
> does the work pehaps.
I don't think it does unfortunately as it doesn't check val2 at all.
So we need a new version of your patch unless I'm missing something.

> 
> The best part of this patch is supplying direct values and removes
> the amiguity around ilog2(), especially at probe, when supplying
> default values.
> 
> Thanks David for the series.

Indeed.  Some nice tidying up.  Thanks,

Jonathan
> 
