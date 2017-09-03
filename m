Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47892 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753123AbdICRKi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 Sep 2017 13:10:38 -0400
Date: Sun, 3 Sep 2017 18:10:36 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Peter Rosin <peda@axentia.se>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH V2 00/45] IIO: Drop manual assignment of THIS_MODULE
Message-ID: <20170903181036.79b21086@archlinux>
In-Reply-To: <0b9a2569-e7f9-9420-c2d1-732049efae5f@axentia.se>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
        <20170820161301.1d4570db@archlinux>
        <b018b734-bda5-8a9f-0c0b-eb379ec2c2df@metafoo.de>
        <20170821133822.0000053f@huawei.com>
        <20170822221929.0ce921ce@archlinux>
        <20170903122314.324d286f@archlinux>
        <0b9a2569-e7f9-9420-c2d1-732049efae5f@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 3 Sep 2017 15:35:52 +0200
Peter Rosin <peda@axentia.se> wrote:

> On 2017-09-03 13:23, Jonathan Cameron wrote:
> > On Tue, 22 Aug 2017 22:19:29 +0100
> > Jonathan Cameron <jic23@jic23.retrosnub.co.uk> wrote:  
> >> Series minus the coccinelle script applied to the togreg branch of iio.git
> >> and pushed out as testing.
> >>  
> > 
> > Testing picked up on the fact we have have an iio_dev in 
> > the mux subsystem that I'd forgotten about.
> > 
> > Peter, do you mind if I just pop in an additional patch such as:
> > 
> > diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
> > index 37ba007f8dca..92495d309193 100644
> > --- a/drivers/iio/multiplexer/iio-mux.c
> > +++ b/drivers/iio/multiplexer/iio-mux.c
> > @@ -173,7 +173,6 @@ static const struct iio_info mux_info = {
> >         .read_raw = mux_read_raw,
> >         .read_avail = mux_read_avail,
> >         .write_raw = mux_write_raw,
> > -       .driver_module = THIS_MODULE,
> >  };
> > 
> > Towards the end of this series?  
> 
> No problem, just go ahead.
> 
Thanks, I took that as an Ack - shout if you would rather I didn't.

Now I won't get more pesky autobuilder warnings ;)

Jonathan
> Cheers,
> Peter
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

