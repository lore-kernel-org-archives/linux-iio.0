Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45456 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbeHSUa6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Aug 2018 16:30:58 -0400
Received: by mail-pl0-f68.google.com with SMTP id j8-v6so5923647pll.12
        for <linux-iio@vger.kernel.org>; Sun, 19 Aug 2018 10:18:49 -0700 (PDT)
Date: Sun, 19 Aug 2018 22:48:42 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Frey <dpfrey@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/7] iio: chemical: bme680: cleanup bme680_read_calib
 formatting
Message-ID: <20180819171842.GB13175@himanshu-Vostro-3559>
References: <20180817190319.13119-1-dpfrey@gmail.com>
 <20180817190319.13119-3-dpfrey@gmail.com>
 <20180818110655.GC24920@himanshu-Vostro-3559>
 <20180819165421.77b693ed@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180819165421.77b693ed@archlinux>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Aug 19, 2018 at 04:54:21PM +0100, Jonathan Cameron wrote:
> On Sat, 18 Aug 2018 16:36:55 +0530
> Himanshu Jha <himanshujha199640@gmail.com> wrote:
> 
> > On Fri, Aug 17, 2018 at 12:03:14PM -0700, David Frey wrote:
> > > Signed-off-by: David Frey <dpfrey@gmail.com>  
> > 
> > Reviewed-by: Himanshu Jha <himanshujha199640@gmail.com>
> > Tested-by: Himanshu Jha <himanshujha199640@gmail.com>
> > 
> > Also, 0-day tested with build success!
> > 
> > Thanks
> > 
> > One minor comment below.
> > 
> > Maybe Jonathan would fix while applying, so don't need a
> > new version for this.
> I've fixed them up.
> 
> I would have liked to see a little more detail in the description of what
> was being changed and why though...

Indeed!
AFAIK Greg never takes any patch with empty commit log
but I've seen patches with empty log in IIO.

Point noted!
Now, I'll poke each and everyone if I find such a case
in future.

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
