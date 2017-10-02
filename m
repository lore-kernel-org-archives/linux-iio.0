Return-Path: <SRS0=gFMz=BB=huawei.com=jonathan.cameron@kernel.org>
Date: Mon, 2 Oct 2017 11:35:10 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Martin Kepplinger <martink@posteo.de>
CC: Jonathan Cameron <jic23@kernel.org>,
        Harinath Nampally
	<harinath922@gmail.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <amsfield22@gmail.com>
Subject: Re: [PATCH v3 1/3] iio: accel: mma8452: Rename structs holding
 event configuration registers to more appropriate names.
Message-ID: <20171002113510.00002392@huawei.com>
In-Reply-To: <3dac943e-5c50-363c-2e5b-77b2921e9e91@posteo.de>
References: <1506336008-4480-1-git-send-email-harinath922@gmail.com>
	<1506336008-4480-2-git-send-email-harinath922@gmail.com>
	<768af6828fe70f4a0bd7ef402073d9f3@posteo.de>
	<20170930185913.4a2c85e3@archlinux>
	<3dac943e-5c50-363c-2e5b-77b2921e9e91@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-ID: <linux-iio@vger.kernel.org>

On Sun, 1 Oct 2017 20:10:49 +0200
Martin Kepplinger <martink@posteo.de> wrote:

> On 2017-09-30 19:59, Jonathan Cameron wrote:
> > On Wed, 27 Sep 2017 08:52:54 +0200
> > Martin Kepplinger <martink@posteo.de> wrote:
> >   
> >> Am 25.09.2017 12:40 schrieb Harinath Nampally:  
> >>> Improves code readability, no impact on functionality.
> >>>
> >>> Signed-off-by: Harinath Nampally <harinath922@gmail.com>
> >>> ---    
> >>
> >> I'd prefer a shorter subject line here too, see patch 2/3  
> > 
> > Agreed.  I'm unconvinced the change helps.  Perhaps that is
> > because I don't fully understand why you are making the change?
> >   
> 
> It's understandable for me. It simply uses "transient" and "ff_mt" in
> order to describe sets of device-registers instead of "rising" and
> "falling". That's more appropriate. I'd apply this if possible.
> 
> Even though it should be clear after reading the data sheet, this
> particular issue sometimes gets confusing for people. Maybe a short
> descriptive comment, pointing to the data sheet, would make sense?
> 

With the addition of some description, this should be fine.

Thanks,

Jonathan

>                       martin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
