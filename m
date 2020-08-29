Return-Path: <SRS0=A9f8=CH=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91550C433E6
	for <linux-iio@archiver.kernel.org>; Sat, 29 Aug 2020 15:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E59B208A9
	for <linux-iio@archiver.kernel.org>; Sat, 29 Aug 2020 15:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598715339;
	bh=j6jFQQI+S+Zc7jamxDk6P8xUa9APlinfotS8wBG/sfk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Pb89qWU71t9df0uft1aztLmjqBhfpt+k9fup1K/oPtx0c0nem/md2hgo/ND9dVRSC
	 uJGSccBklt3FhGFKHWN1pKzOLPOvvDXF4n/qR3OsY0KiDhuc7fD/bQy8xwm850CmGc
	 8vd+Zsy6sq9Zz9TkXo2weQf9vFlHVZ4p0/YOzX2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgH2Pfi (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 29 Aug 2020 11:35:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728196AbgH2Pfh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 11:35:37 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E78A20791;
        Sat, 29 Aug 2020 15:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598715336;
        bh=j6jFQQI+S+Zc7jamxDk6P8xUa9APlinfotS8wBG/sfk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wpIg/pDqJxnbPmrrbN1zZncs991Ja7La9/uqYE+vERNp9t2NTt8pGZ1kOyR83X74u
         78rmSPTS+Db4laeDkbSXUDcWd80n93w8Mb05gl4x62qhu9RxeGbK7T6mXJi6mV45mO
         tJCv208M99yZI6Rb3BB2ec6O+l/LCRH+hzPGYLTk=
Date:   Sat, 29 Aug 2020 16:35:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kgene@kernel.org>, <krzk@kernel.org>,
        "Sergiu Cuciurean" <sergiu.cuciurean@analog.com>
Subject: Re: [PATCH] iio: adc: exynos_adc: Replace indio_dev->mlock with own
 device lock
Message-ID: <20200829163532.4d38d591@archlinux>
In-Reply-To: <20200826132203.236748-1-alexandru.ardelean@analog.com>
References: <20200826132203.236748-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 26 Aug 2020 16:22:03 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> As part of the general cleanup of indio_dev->mlock, this change replaces
> it with a local lock, to protect potential concurrent access to the
> completion callback during a conversion.
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Same comment as the other one about needing lock scope to be documented.

Otherwise looks good.  I thought we only had complicated uses of this
left, but clearly not :)

Jonathan

> ---
>  drivers/iio/adc/exynos_adc.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> index 7d23b6c33284..6a49f8dfab22 100644
> --- a/drivers/iio/adc/exynos_adc.c
> +++ b/drivers/iio/adc/exynos_adc.c
> @@ -132,6 +132,8 @@ struct exynos_adc {
>  
>  	struct completion	completion;
>  
> +	struct mutex		lock;
> +
>  	u32			value;
>  	unsigned int            version;
>  
> @@ -542,7 +544,7 @@ static int exynos_read_raw(struct iio_dev *indio_dev,
>  		return -EINVAL;
>  	}
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&info->lock);
>  	reinit_completion(&info->completion);
>  
>  	/* Select the channel to be used and Trigger conversion */
> @@ -562,7 +564,7 @@ static int exynos_read_raw(struct iio_dev *indio_dev,
>  		ret = IIO_VAL_INT;
>  	}
>  
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&info->lock);
>  
>  	return ret;
>  }
> @@ -573,7 +575,7 @@ static int exynos_read_s3c64xx_ts(struct iio_dev *indio_dev, int *x, int *y)
>  	unsigned long timeout;
>  	int ret;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&info->lock);
>  	info->read_ts = true;
>  
>  	reinit_completion(&info->completion);
> @@ -598,7 +600,7 @@ static int exynos_read_s3c64xx_ts(struct iio_dev *indio_dev, int *x, int *y)
>  	}
>  
>  	info->read_ts = false;
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&info->lock);
>  
>  	return ret;
>  }
> @@ -872,6 +874,8 @@ static int exynos_adc_probe(struct platform_device *pdev)
>  	indio_dev->channels = exynos_adc_iio_channels;
>  	indio_dev->num_channels = info->data->num_channels;
>  
> +	mutex_init(&info->lock);
> +
>  	ret = request_irq(info->irq, exynos_adc_isr,
>  					0, dev_name(&pdev->dev), info);
>  	if (ret < 0) {

