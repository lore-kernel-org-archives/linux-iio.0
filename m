Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751312AbeBRMCr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Feb 2018 07:02:47 -0500
Date: Sun, 18 Feb 2018 12:02:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: Himanshu Jha <himanshujha199640@gmail.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        daniel.baluta@nxp.com
Subject: Re: [PATCH 1/3] Staging: iio: adis16209: Use SPDX identifier
Message-ID: <20180218120243.298bdcdd@archlinux>
In-Reply-To: <1518953877.19751.3.camel@gmail.com>
References: <cover.1518883035.git.shreeya.patel23498@gmail.com>
        <6771b95bbfb8301724086dba4d92df6a6b11d6f7.1518883035.git.shreeya.patel23498@gmail.com>
        <20180218113138.GA4039@himanshu-Vostro-3559>
        <1518953877.19751.3.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 18 Feb 2018 17:07:57 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> On Sun, 2018-02-18 at 17:01 +0530, Himanshu Jha wrote:
> > Hi Shreeya,
> >   
> Hi Himanshu,
> 
> > On Sat, Feb 17, 2018 at 09:34:56PM +0530, Shreeya Patel wrote:  
> > > 
> > > Use SPDX identifier format instead of GPLv2. Also rearrange the
> > > headers in alphabetical order.
> > > 
> > > Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> > > ---
> > >  drivers/staging/iio/accel/adis16209.c | 7 +++----
> > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/staging/iio/accel/adis16209.c
> > > b/drivers/staging/iio/accel/adis16209.c
> > > index 7fcef9a..e3d9f80 100644
> > > --- a/drivers/staging/iio/accel/adis16209.c
> > > +++ b/drivers/staging/iio/accel/adis16209.c
> > > @@ -1,19 +1,18 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > >  /*
> > >   * ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer
> > >   *
> > >   * Copyright 2010 Analog Devices Inc.
> > > - *
> > > - * Licensed under the GPL-2 or later.  
> > I see that you too are doing similar cleanup which I did a while ago
> > https://lkml.org/lkml/2018/2/12/255  
> 
> Yes, Jonathan suggested me to work on adis16209.
> Your patches were quite useful for me :)
> 
> > where I got some update suggestions for the patch series. It would be
> > great if you could update this patch series consistent with the
> > reviewers.
> > 
> > For eg: in this patch you changed 
> > 
> > +// SPDX-License-Identifier: GPL-2.0+
> > 
> > and therefore
> > 
> > MODULE_LICENSE("GPL v2");
> > 
> > should also be changed to 
> > 
> > MODULE_LICENSE("GPL"); 
> > 
> > as explained by	Philippe Ombredanne to me in my patch series.  
> 
I'm not sure that was exactly what Philippe was suggesting.
He was making the point that the licensing was inconsistent without
saying which option should be chosen.

We will need to seek clarification from Analog Devices
on what their opinion on this is.

Lars / Michael, any clarification on the right way to resolve this
inconsistency?

> Great.
> I'll make the necessary changes.
> 
> > 
> > I am not sure if you're subscribed to the IIO mailing list but you
> > can find
> > all the update suggestions from the above link. :)  
> 
> Thanks for your suggestions 
> >   
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

