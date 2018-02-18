Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751292AbeBRMvp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Feb 2018 07:51:45 -0500
Date: Sun, 18 Feb 2018 12:51:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Shreeya Patel <shreeya.patel23498@gmail.com>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        daniel.baluta@nxp.com, Himanshu Jha <himanshujha199640@gmail.com>
Subject: Re: [PATCH 1/3] Staging: iio: adis16209: Use SPDX identifier
Message-ID: <20180218125140.5638f15f@archlinux>
In-Reply-To: <a8786cbf-8e3b-a2af-6be0-7413ae2b13c4@metafoo.de>
References: <cover.1518883035.git.shreeya.patel23498@gmail.com>
        <6771b95bbfb8301724086dba4d92df6a6b11d6f7.1518883035.git.shreeya.patel23498@gmail.com>
        <20180218113138.GA4039@himanshu-Vostro-3559>
        <1518953877.19751.3.camel@gmail.com>
        <20180218120243.298bdcdd@archlinux>
        <c81d519c-a0a7-d369-92d6-668e0ace81a6@metafoo.de>
        <a8786cbf-8e3b-a2af-6be0-7413ae2b13c4@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 18 Feb 2018 13:14:27 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 02/18/2018 01:08 PM, Lars-Peter Clausen wrote:
> > On 02/18/2018 01:02 PM, Jonathan Cameron wrote:  
> >> On Sun, 18 Feb 2018 17:07:57 +0530
> >> Shreeya Patel <shreeya.patel23498@gmail.com> wrote:
> >>  
> >>> On Sun, 2018-02-18 at 17:01 +0530, Himanshu Jha wrote:  
> >>>> Hi Shreeya,
> >>>>     
> >>> Hi Himanshu,
> >>>  
> >>>> On Sat, Feb 17, 2018 at 09:34:56PM +0530, Shreeya Patel wrote:    
> >>>>>
> >>>>> Use SPDX identifier format instead of GPLv2. Also rearrange the
> >>>>> headers in alphabetical order.
> >>>>>
> >>>>> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> >>>>> ---
> >>>>>  drivers/staging/iio/accel/adis16209.c | 7 +++----
> >>>>>  1 file changed, 3 insertions(+), 4 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/staging/iio/accel/adis16209.c
> >>>>> b/drivers/staging/iio/accel/adis16209.c
> >>>>> index 7fcef9a..e3d9f80 100644
> >>>>> --- a/drivers/staging/iio/accel/adis16209.c
> >>>>> +++ b/drivers/staging/iio/accel/adis16209.c
> >>>>> @@ -1,19 +1,18 @@
> >>>>> +// SPDX-License-Identifier: GPL-2.0+
> >>>>>  /*
> >>>>>   * ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer
> >>>>>   *
> >>>>>   * Copyright 2010 Analog Devices Inc.
> >>>>> - *
> >>>>> - * Licensed under the GPL-2 or later.    
> >>>> I see that you too are doing similar cleanup which I did a while ago
> >>>> https://lkml.org/lkml/2018/2/12/255    
> >>>
> >>> Yes, Jonathan suggested me to work on adis16209.
> >>> Your patches were quite useful for me :)
> >>>  
> >>>> where I got some update suggestions for the patch series. It would be
> >>>> great if you could update this patch series consistent with the
> >>>> reviewers.
> >>>>
> >>>> For eg: in this patch you changed 
> >>>>
> >>>> +// SPDX-License-Identifier: GPL-2.0+
> >>>>
> >>>> and therefore
> >>>>
> >>>> MODULE_LICENSE("GPL v2");
> >>>>
> >>>> should also be changed to 
> >>>>
> >>>> MODULE_LICENSE("GPL"); 
> >>>>
> >>>> as explained by	Philippe Ombredanne to me in my patch series.    
> >>>  
> >> I'm not sure that was exactly what Philippe was suggesting.
> >> He was making the point that the licensing was inconsistent without
> >> saying which option should be chosen.
> >>
> >> We will need to seek clarification from Analog Devices
> >> on what their opinion on this is.
> >>
> >> Lars / Michael, any clarification on the right way to resolve this
> >> inconsistency?  
> > 
> > I can't speak for the intended license for code I wasn't involved in.
> > 
> > But I'd in general if there are conflicting licensing information and you
> > want to be on the safe side choose the more restrictive license. E.g. GPL2+
> > is compatible with GPL2, but GPL2 is not compatible with GPL2+. So to be
> > compatible with both choose GPL2.  
> 
> This is not legal advice btw.
> 
> I personally would stay away from messing with the licenses of code I do not
> own. Not everybody seems to agree yet that a SPDX tag is equivalent to a
> explicit licensing statement.
> 
OK, in that case let's not do the spdx conversions for these drivers.
We probably need to fix the inconsistency however between the text and the
module license tag.  Doesn't need to be part of moving it out of staging however.

Jonathan



