Return-Path: <lars@metafoo.de>
Subject: Re: [PATCH V2 00/45] IIO: Drop manual assignment of THIS_MODULE
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
 <20170820161301.1d4570db@archlinux>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <b018b734-bda5-8a9f-0c0b-eb379ec2c2df@metafoo.de>
Date: Mon, 21 Aug 2017 09:42:01 +0200
MIME-Version: 1.0
In-Reply-To: <20170820161301.1d4570db@archlinux>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 08/20/2017 05:13 PM, Jonathan Cameron wrote:
> 
> Hi All,
> 
> If anyone has time to look over this set that would be great.
> 
> The ancient problem for maintainers, who is the reviewer of last
> resort? Oh me... That doesn't work for my patches :)
> 
> No actual rush though - don't mind if these sit until next cycle -
> would just get irritating if they sit until the one after and I have
> to rebase them again...

Sorry, for the delay. Whole series

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

(I didn't actually review each of the individual '-.driver_module =
THIS_MODULE', but I assume coccinelle did the right thing based on the
spatch script).
