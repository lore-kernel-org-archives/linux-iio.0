Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbeHATqE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 1 Aug 2018 15:46:04 -0400
Date: Wed, 1 Aug 2018 18:59:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Maxime =?UTF-8?B?Um91c3Npbi1Cw6lsYW5nZXI=?=
        <maxime.roussinbelanger@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: light: si1133: fix an && vs || typo
Message-ID: <20180801185907.3dd0cc81@archlinux>
In-Reply-To: <20180731181134.rp57ywlshwqm4onu@kili.mountain>
References: <20180731181134.rp57ywlshwqm4onu@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 31 Jul 2018 21:11:34 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The "val" variable can't be both 0 and 1 at the same time so this will
> always return -EINVAL.
> 
> Fixes: e01e7eaf37d8 ("iio: light: introduce si1133")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Thanks.  This time Colin King beat you to it.

Jonathan

> 
> diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
> index d3fbeb3bc463..5ac22c46da1f 100644
> --- a/drivers/iio/light/si1133.c
> +++ b/drivers/iio/light/si1133.c
> @@ -838,7 +838,7 @@ static int si1133_write_raw(struct iio_dev *iio_dev,
>  		switch (chan->type) {
>  		case IIO_INTENSITY:
>  		case IIO_UVINDEX:
> -			if (val != 0 || val != 1)
> +			if (val != 0 && val != 1)
>  				return -EINVAL;
>  
>  			return si1133_update_adcsens(data,

