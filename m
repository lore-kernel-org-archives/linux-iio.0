Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36224 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751290AbdHVVTd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Aug 2017 17:19:33 -0400
Date: Tue, 22 Aug 2017 22:19:29 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>
Subject: Re: [PATCH V2 00/45] IIO: Drop manual assignment of THIS_MODULE
Message-ID: <20170822221929.0ce921ce@archlinux>
In-Reply-To: <20170821133822.0000053f@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
        <20170820161301.1d4570db@archlinux>
        <b018b734-bda5-8a9f-0c0b-eb379ec2c2df@metafoo.de>
        <20170821133822.0000053f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 21 Aug 2017 13:38:22 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Mon, 21 Aug 2017 09:42:01 +0200
> Lars-Peter Clausen <lars@metafoo.de> wrote:
> 
> > On 08/20/2017 05:13 PM, Jonathan Cameron wrote:  
> > > 
> > > Hi All,
> > > 
> > > If anyone has time to look over this set that would be great.
> > > 
> > > The ancient problem for maintainers, who is the reviewer of last
> > > resort? Oh me... That doesn't work for my patches :)
> > > 
> > > No actual rush though - don't mind if these sit until next cycle -
> > > would just get irritating if they sit until the one after and I have
> > > to rebase them again...    
> > 
> > Sorry, for the delay. Whole series
> > 
> > Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
> > 
> > (I didn't actually review each of the individual '-.driver_module =
> > THIS_MODULE', but I assume coccinelle did the right thing based on the
> > spatch script).  
> 
> I did a couple of the new ones by hand but they look the same so should
> be fine!
> 
> Thanks for review.
> 
> I'll drop the coccinelle patch I think as the field will have gone away
> so it won't be possible to set it wrong in future.
> 
Series minus the coccinelle script applied to the togreg branch of iio.git
and pushed out as testing.

Thanks,

Jonathan

> Jonathan
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html  
> 

