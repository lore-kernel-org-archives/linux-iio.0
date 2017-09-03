Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr10122.outbound.protection.outlook.com ([40.107.1.122]:47424
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752806AbdICNgB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Sep 2017 09:36:01 -0400
Subject: Re: [PATCH V2 00/45] IIO: Drop manual assignment of THIS_MODULE
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
 <20170820161301.1d4570db@archlinux>
 <b018b734-bda5-8a9f-0c0b-eb379ec2c2df@metafoo.de>
 <20170821133822.0000053f@huawei.com> <20170822221929.0ce921ce@archlinux>
 <20170903122314.324d286f@archlinux>
From: Peter Rosin <peda@axentia.se>
Message-ID: <0b9a2569-e7f9-9420-c2d1-732049efae5f@axentia.se>
Date: Sun, 3 Sep 2017 15:35:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170903122314.324d286f@archlinux>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-09-03 13:23, Jonathan Cameron wrote:
> On Tue, 22 Aug 2017 22:19:29 +0100
> Jonathan Cameron <jic23@jic23.retrosnub.co.uk> wrote:
>> Series minus the coccinelle script applied to the togreg branch of iio.git
>> and pushed out as testing.
>>
> 
> Testing picked up on the fact we have have an iio_dev in 
> the mux subsystem that I'd forgotten about.
> 
> Peter, do you mind if I just pop in an additional patch such as:
> 
> diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
> index 37ba007f8dca..92495d309193 100644
> --- a/drivers/iio/multiplexer/iio-mux.c
> +++ b/drivers/iio/multiplexer/iio-mux.c
> @@ -173,7 +173,6 @@ static const struct iio_info mux_info = {
>         .read_raw = mux_read_raw,
>         .read_avail = mux_read_avail,
>         .write_raw = mux_write_raw,
> -       .driver_module = THIS_MODULE,
>  };
> 
> Towards the end of this series?

No problem, just go ahead.

Cheers,
Peter
