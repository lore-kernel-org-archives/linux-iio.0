Return-Path: <SRS0=X7gK=AM=huawei.com=jonathan.cameron@kernel.org>
Date: Mon, 11 Sep 2017 09:41:05 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Lukas Wunner <lukas@wunner.de>
CC: Jonathan Cameron <jic23@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "Daniel Mack" <daniel@zonque.org>, Hartmut Knaack <knaack.h@gmx.de>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>,
        "Andrew F. Davis" <afd@ti.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/2] drivers: misc: ti_dac7512: Remove duplicate driver
Message-ID: <20170911094105.00006173@huawei.com>
In-Reply-To: <20170910184315.GA13239@wunner.de>
References: <be82f31ef2f0f39c7893b42dfe46c7235ea6144a.1504604178.git.lukas@wunner.de>
	<d5a12cb12480235e05315e9c8fa6e8b5f5a3dfb6.1504604178.git.lukas@wunner.de>
	<CAK8P3a2L+wOER7LwXApD_YrVA7Zi9D96FZC5zAm_+aSy+qG0rg@mail.gmail.com>
	<20170905101144.GA23808@wunner.de>
	<524a1c8e-93c1-d905-dc39-b154290beb86@zonque.org>
	<CAK8P3a1XQBLsSmkKK75P1y6h8925L3K68v_5ARoBbEyLu3q_Fw@mail.gmail.com>
	<20170910161928.2b49d134@archlinux>
	<20170910184315.GA13239@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-ID: <linux-iio@vger.kernel.org>

On Sun, 10 Sep 2017 20:43:15 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> On Sun, Sep 10, 2017 at 04:19:28PM +0100, Jonathan Cameron wrote:
> > On Tue, 5 Sep 2017 15:01:08 +0200 Arnd Bergmann <arnd@arndb.de> wrote:  
> > > On Tue, Sep 5, 2017 at 12:28 PM, Daniel Mack <daniel@zonque.org> wrote:  
> > > > That's true, but the devices that do are EOL for a long time, and they
> > > > don't use mainline kernels anyway, for multiple reasons. So that
> > > > shouldn't constrain us, and I'm all for replacing that driver with
> > > > something that has a real infrastructure.
> > > >
> > > >   Acked-by: Daniel Mack <daniel@zonque.org>    
> > > 
> > > Ok, thanks for the confirmation. That's probably good enough to apply the
> > > patch for 4.15. If someone else uses the driver without you knowing, they
> > > can always complain later on and we revert the patch or think of an
> > > alternative, but that seems unlikely.  
> > 
> > Sounds good to me.  I'll pick it up through IIO given the small changes
> > there and the fact you are happy with it.  Shout if you would prefer
> > a different route. Given timing I won't be pushing this out on a non
> > rebasing tree for a week or so anyway.
> > 
> > Applied to the togreg branch of iio.git and pushed out as testing for
> > autobuilders to play with it.  
> 
> Thank you Daniel, Arnd & Jonathan!
> 
> A minor note, the commit as pushed to iio.git/testing is missing Arnd's
> Acked-by.  Also, the Cc: to Daniel is redundant given his ack.

Thanks!  I checked Arnd's last email but missed the Ack in the earlier
one.  Will tidy that up when I'm next on the right PC.

Jonathan

> 
> Have a pleasant week,
> 
> Lukas
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
