Return-Path: <jonathan.cameron@huawei.com>
Date: Mon, 21 Aug 2017 13:38:22 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        <linux-iio@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        "Peter
 Meerwald-Stadler" <pmeerw@pmeerw.net>
Subject: Re: [PATCH V2 00/45] IIO: Drop manual assignment of THIS_MODULE
Message-ID: <20170821133822.0000053f@huawei.com>
In-Reply-To: <b018b734-bda5-8a9f-0c0b-eb379ec2c2df@metafoo.de>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
	<20170820161301.1d4570db@archlinux>
	<b018b734-bda5-8a9f-0c0b-eb379ec2c2df@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-ID: <linux-iio@vger.kernel.org>

On Mon, 21 Aug 2017 09:42:01 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 08/20/2017 05:13 PM, Jonathan Cameron wrote:
> > 
> > Hi All,
> > 
> > If anyone has time to look over this set that would be great.
> > 
> > The ancient problem for maintainers, who is the reviewer of last
> > resort? Oh me... That doesn't work for my patches :)
> > 
> > No actual rush though - don't mind if these sit until next cycle -
> > would just get irritating if they sit until the one after and I have
> > to rebase them again...  
> 
> Sorry, for the delay. Whole series
> 
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> (I didn't actually review each of the individual '-.driver_module =
> THIS_MODULE', but I assume coccinelle did the right thing based on the
> spatch script).

I did a couple of the new ones by hand but they look the same so should
be fine!

Thanks for review.

I'll drop the coccinelle patch I think as the field will have gone away
so it won't be possible to set it wrong in future.

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
