Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbeJ2Do5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Oct 2018 23:44:57 -0400
Date: Sun, 28 Oct 2018 18:59:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Slawomir Stepien <sst@poczta.fm>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/1] staging: iio: adc: ad7280a: don't cast type inside
 switch expression
Message-ID: <20181028185921.732e8ce0@archlinux>
In-Reply-To: <20181026165310.16545-1-sst@poczta.fm>
References: <20181026165310.16545-1-sst@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 26 Oct 2018 18:53:10 +0200
Slawomir Stepien <sst@poczta.fm> wrote:

> The type promotion will kick in, so the comparison will work.
> 
> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
Looks good to me.  Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/adc/ad7280a.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index b736275c10f5..7de6be4f0c27 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -610,7 +610,7 @@ static ssize_t ad7280_read_channel_config(struct device *dev,
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  	unsigned int val;
>  
> -	switch ((u32)this_attr->address) {
> +	switch (this_attr->address) {
>  	case AD7280A_CELL_OVERVOLTAGE:
>  		val = 1000 + (st->cell_threshhigh * 1568) / 100;
>  		break;
> @@ -646,7 +646,7 @@ static ssize_t ad7280_write_channel_config(struct device *dev,
>  	if (ret)
>  		return ret;
>  
> -	switch ((u32)this_attr->address) {
> +	switch (this_attr->address) {
>  	case AD7280A_CELL_OVERVOLTAGE:
>  	case AD7280A_CELL_UNDERVOLTAGE:
>  		val = ((val - 1000) * 100) / 1568; /* LSB 15.68mV */
> @@ -662,7 +662,7 @@ static ssize_t ad7280_write_channel_config(struct device *dev,
>  	val = clamp(val, 0L, 0xFFL);
>  
>  	mutex_lock(&st->lock);
> -	switch ((u32)this_attr->address) {
> +	switch (this_attr->address) {
>  	case AD7280A_CELL_OVERVOLTAGE:
>  		st->cell_threshhigh = val;
>  		break;
