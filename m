Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57239 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753560AbcLCOlx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Dec 2016 09:41:53 -0500
Subject: Re: [PATCH] staging: iio: replace symbolic permission
To: kushwaha.a@samsung.com
References: <CGME20161130152410epcms5p156ead39cb7b0dd842448360a87fbc0e7@epcms5p1>
 <20161130152410epcms5p156ead39cb7b0dd842448360a87fbc0e7@epcms5p1>
Cc: "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ee3b57ac-ff90-4cfd-dbdb-5d7067e114d5@kernel.org>
Date: Sat, 3 Dec 2016 10:26:36 +0000
MIME-Version: 1.0
In-Reply-To: <20161130152410epcms5p156ead39cb7b0dd842448360a87fbc0e7@epcms5p1>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/11/16 15:24, Amit Kumar Kushwaha wrote:
> This patch fixes the following checkpatch.pl warning in ad7150.c
> WARNING: Symbolic permissions 'S_IRUGO | S_IWUSR' are not preferred
> Occured during build.
> 
> Signed-off-by: Amit Kushwaha <kushwaha.a@samsung.com>
I'm not overly fussed about these (and generally believe the churn isn't
worth the 'really minor' improvement in readability...)

Also for some reason it didn't apply.  I've done it manually...
Anyhow, applied to the togreg branch of iio.git just so I don't get any
more emails about it...

Jonathan
> ---
>  drivers/staging/iio/cdc/ad7150.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
> index 5578a07..9ab00c0 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -414,7 +414,7 @@ static ssize_t ad7150_store_timeout(struct device *dev,
>  
>  #define AD7150_TIMEOUT(chan, type, dir, ev_type, ev_dir)		\
>  	IIO_DEVICE_ATTR(in_capacitance##chan##_##type##_##dir##_timeout, \
> -		S_IRUGO | S_IWUSR,					\
> +		0644,					\
>  		&ad7150_show_timeout,					\
>  		&ad7150_store_timeout,					\
>  		IIO_UNMOD_EVENT_CODE(IIO_CAPACITANCE,			\
> 

