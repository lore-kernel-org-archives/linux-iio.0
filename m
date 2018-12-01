Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbeLBDsW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Dec 2018 22:48:22 -0500
Date: Sat, 1 Dec 2018 16:35:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Joe Perches <joe@perches.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] staging: iio: adc: ad7280a: check for
 devm_kasprint() failure
Message-ID: <20181201163523.52a84b47@archlinux>
In-Reply-To: <1543338304-892-1-git-send-email-hofrat@osadl.org>
References: <1543338304-892-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 27 Nov 2018 18:05:04 +0100
Nicholas Mc Guire <hofrat@osadl.org> wrote:

> devm_kasprintf() may return NULL on failure of internal allocation thus
> the assignments to  attr.name  are not safe if not checked. On error
> ad7280_attr_init() returns a negative return so -ENOMEM should be
> OK here (passed on as return value of the probe function). To make the
> error case more readable a temporary  iio_attr  is introduced and the code
> refactored.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: 2051f25d2a26 ("iio: adc: New driver for AD7280A Lithium Ion Battery Monitoring System2")

Hmm. If this had been other than to a staging driver I think I would
have asked you to split this into a rework patch doing the local variable
change, then one actually making the fix.  Good result though,
so as it's in staging we'll go with this :)

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> 
> V2: use a tmp pointer to iio_attr to make the error check more readable
>     as proposed by Dan Carpenter <dan.carpenter@oracle.com>
> 
> Problem located with an experimental coccinelle script
> 
> Patch was compile tested with: x86_64_defconfig + STAGING=y
> SPI=y, IIO=y, AD7280=m
> 
> Patch is against 4.20-rc4 (localversion-next is next-20181127)
> 
>  drivers/staging/iio/adc/ad7280a.c | 43 +++++++++++++++++++--------------------
>  1 file changed, 21 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index 0bb9ab1..7a0ba26 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -561,6 +561,7 @@ static int ad7280_attr_init(struct ad7280_state *st)
>  {
>  	int dev, ch, cnt;
>  	unsigned int index;
> +	struct iio_dev_attr *iio_attr;
>  
>  	st->iio_attr = devm_kcalloc(&st->spi->dev, 2, sizeof(*st->iio_attr) *
>  				    (st->slave_num + 1) * AD7280A_CELLS_PER_DEV,
> @@ -571,37 +572,35 @@ static int ad7280_attr_init(struct ad7280_state *st)
>  	for (dev = 0, cnt = 0; dev <= st->slave_num; dev++)
>  		for (ch = AD7280A_CELL_VOLTAGE_1; ch <= AD7280A_CELL_VOLTAGE_6;
>  			ch++, cnt++) {
> +			iio_attr = &st->iio_attr[cnt];
>  			index = dev * AD7280A_CELLS_PER_DEV + ch;
> -			st->iio_attr[cnt].address =
> -				ad7280a_devaddr(dev) << 8 | ch;
> -			st->iio_attr[cnt].dev_attr.attr.mode =
> -				0644;
> -			st->iio_attr[cnt].dev_attr.show =
> -				ad7280_show_balance_sw;
> -			st->iio_attr[cnt].dev_attr.store =
> -				ad7280_store_balance_sw;
> -			st->iio_attr[cnt].dev_attr.attr.name =
> +			iio_attr->address = ad7280a_devaddr(dev) << 8 | ch;
> +			iio_attr->dev_attr.attr.mode = 0644;
> +			iio_attr->dev_attr.show = ad7280_show_balance_sw;
> +			iio_attr->dev_attr.store = ad7280_store_balance_sw;
> +			iio_attr->dev_attr.attr.name =
>  				devm_kasprintf(&st->spi->dev, GFP_KERNEL,
>  					       "in%d-in%d_balance_switch_en",
>  					       index, index + 1);
> -			ad7280_attributes[cnt] =
> -				&st->iio_attr[cnt].dev_attr.attr;
> +			if (!iio_attr->dev_attr.attr.name)
> +				return -ENOMEM;
> +
> +			ad7280_attributes[cnt] = &iio_attr->dev_attr.attr;
>  			cnt++;
> -			st->iio_attr[cnt].address =
> -				ad7280a_devaddr(dev) << 8 |
> +			iio_attr = &st->iio_attr[cnt];
> +			iio_attr->address = ad7280a_devaddr(dev) << 8 |
>  				(AD7280A_CB1_TIMER + ch);
> -			st->iio_attr[cnt].dev_attr.attr.mode =
> -				0644;
> -			st->iio_attr[cnt].dev_attr.show =
> -				ad7280_show_balance_timer;
> -			st->iio_attr[cnt].dev_attr.store =
> -				ad7280_store_balance_timer;
> -			st->iio_attr[cnt].dev_attr.attr.name =
> +			iio_attr->dev_attr.attr.mode = 0644;
> +			iio_attr->dev_attr.show = ad7280_show_balance_timer;
> +			iio_attr->dev_attr.store = ad7280_store_balance_timer;
> +			iio_attr->dev_attr.attr.name =
>  				devm_kasprintf(&st->spi->dev, GFP_KERNEL,
>  					       "in%d-in%d_balance_timer",
>  					       index, index + 1);
> -			ad7280_attributes[cnt] =
> -				&st->iio_attr[cnt].dev_attr.attr;
> +			if (!iio_attr->dev_attr.attr.name)
> +				return -ENOMEM;
> +
> +			ad7280_attributes[cnt] = &iio_attr->dev_attr.attr;
>  		}
>  
>  	ad7280_attributes[cnt] = NULL;
