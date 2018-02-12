Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37973 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932629AbeBLOh7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Feb 2018 09:37:59 -0500
Date: Mon, 12 Feb 2018 20:07:50 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Philippe Ombredanne <pombredanne@nexb.com>
Cc: 21cnbao@gmail.com, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael.Hennerich@analog.com, Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] staging: iio: accel: Move adis16201 driver out of
 staging
Message-ID: <20180212143750.GB12142@himanshu-Vostro-3559>
References: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
 <1518436499-8584-5-git-send-email-himanshujha199640@gmail.com>
 <CAOFm3uFOy+Rea8yz798sEoCGRfavsR9gwY9-d_RQ75K5yoq1=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOFm3uFOy+Rea8yz798sEoCGRfavsR9gwY9-d_RQ75K5yoq1=g@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Feb 12, 2018 at 03:10:56PM +0100, Philippe Ombredanne wrote:
> On Mon, Feb 12, 2018 at 12:54 PM, Himanshu Jha
> <himanshujha199640@gmail.com> wrote:
> > Move the adis16201 driver out of staging directory and merge to the
> > mainline IIO directory.
> >
> > Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> 
> <snip>
> > --- /dev/null
> > +++ b/drivers/iio/accel/adis16201.c
> > @@ -0,0 +1,315 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> 
> <snip>
> 
> > +MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> > +MODULE_DESCRIPTION("Analog Devices ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_ALIAS("spi:adis16201");
> 
> Your MODULE_LICENSE does not match your SPDX license id.
> MODULE_LICENSE("GPL v2"); means SPDX GPL-2.0
> MODULE_LICENSE("GPL"); means SPDX GPL-2.0+
> 

I didn't knew about that! Thanks for pointing.

-- 
Thanks
Himanshu Jha
