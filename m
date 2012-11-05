Return-Path: <dan.carpenter@oracle.com>
Date: Mon, 5 Nov 2012 09:38:23 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: walter harms <wharms@bfs.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [patch] iio:dac:ad5449: unlock on error path
Message-ID: <20121105063823.GA11515@mwanda>
References: <20121024071307.GC2536@elgon.mountain>
 <5087A55C.6010202@metafoo.de>
 <5093A93D.70302@kernel.org>
 <5093FA4A.2010006@bfs.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5093FA4A.2010006@bfs.de>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Nov 02, 2012 at 05:52:26PM +0100, walter harms wrote:
> if i understand the code correct you can simply the flow
> by turning the check on its head.
> 
> ret = spi_sync(st->spi, &msg);
> if (ret>=0)
>     *val = be16_to_cpu(st->data[1]);
> mutex_unlock(&indio_dev->mlock);
> return ret;

It's better to always treat errors as the special case and success
as the normal case.  It makes the code more readable if every check
is consistent.

regards,
dan carpenter
