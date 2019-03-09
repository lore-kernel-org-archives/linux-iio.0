Return-Path: <SRS0=9Bew=RM=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4E6C43381
	for <linux-iio@archiver.kernel.org>; Sat,  9 Mar 2019 18:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C1820815
	for <linux-iio@archiver.kernel.org>; Sat,  9 Mar 2019 18:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552154559;
	bh=LcYDTQ4ja3K50ZKzlI95JZ3KOc6+lAjBrkxJb3Dw09o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=eRTnnTnEIZSLQCvOXxoF3S0JsnbscS7iyn5gm600y0mH4CsGktERyYvZVJLdGxBd6
	 rEOyk9lyxhdREMk0QALXLtIHEI7XlrvyEfUme/XRclRWr7/TnVVXdFGnzj+vhNw7TM
	 8G8Uvj7RPgNkW3TE0skLhylt98bvVbTxxye3ZTaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfCISCj (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 9 Mar 2019 13:02:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:36844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbfCISCi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Mar 2019 13:02:38 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AEF720645;
        Sat,  9 Mar 2019 18:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552154557;
        bh=LcYDTQ4ja3K50ZKzlI95JZ3KOc6+lAjBrkxJb3Dw09o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f+22JB3jd3j0ROROIrmimLEBPn6OY5mydT1GJB2CjCNNc4mX4Vid2pxukRlEdjHnw
         RIdyBR0sn8xGzwpeVhDuKBG4e6MleTYF/l3prKEc0U2kcxWFsKamrrCOD8/Nh0YSTq
         HbEePeJAuge1wXeTLU2FTRPYJ/r9ozi064sd6Ouk=
Date:   Sat, 9 Mar 2019 18:02:26 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1] iio: buffer: Switch to bitmap_zalloc()
Message-ID: <20190309180226.5920462a@archlinux>
In-Reply-To: <20190304085540.87775-1-andriy.shevchenko@linux.intel.com>
References: <20190304085540.87775-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  4 Mar 2019 10:55:40 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Switch to bitmap_zalloc() to show clearly what we are allocating.
> Besides that it returns pointer of bitmap type instead of opaque void *.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Nice. Didn't realise that one existed.

Applied to the togreg branch of iio.git and pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/buffer/industrialio-buffer-cb.c | 10 ++++-----
>  drivers/iio/industrialio-buffer.c           | 24 +++++++++------------
>  2 files changed, 15 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/buffer/industrialio-buffer-cb.c b/drivers/iio/buffer/industrialio-buffer-cb.c
> index ea63c838eeae..df21e7dbec40 100644
> --- a/drivers/iio/buffer/industrialio-buffer-cb.c
> +++ b/drivers/iio/buffer/industrialio-buffer-cb.c
> @@ -36,7 +36,8 @@ static int iio_buffer_cb_store_to(struct iio_buffer *buffer, const void *data)
>  static void iio_buffer_cb_release(struct iio_buffer *buffer)
>  {
>  	struct iio_cb_buffer *cb_buff = buffer_to_cb_buffer(buffer);
> -	kfree(cb_buff->buffer.scan_mask);
> +
> +	bitmap_free(cb_buff->buffer.scan_mask);
>  	kfree(cb_buff);
>  }
>  
> @@ -74,9 +75,8 @@ struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
>  	}
>  
>  	cb_buff->indio_dev = cb_buff->channels[0].indio_dev;
> -	cb_buff->buffer.scan_mask
> -		= kcalloc(BITS_TO_LONGS(cb_buff->indio_dev->masklength),
> -			  sizeof(long), GFP_KERNEL);
> +	cb_buff->buffer.scan_mask = bitmap_zalloc(cb_buff->indio_dev->masklength,
> +						  GFP_KERNEL);
>  	if (cb_buff->buffer.scan_mask == NULL) {
>  		ret = -ENOMEM;
>  		goto error_release_channels;
> @@ -95,7 +95,7 @@ struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
>  	return cb_buff;
>  
>  error_free_scan_mask:
> -	kfree(cb_buff->buffer.scan_mask);
> +	bitmap_free(cb_buff->buffer.scan_mask);
>  error_release_channels:
>  	iio_channel_release_all(cb_buff->channels);
>  error_free_cb_buff:
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index cd5bfe39591b..3c7e7380d1c3 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -320,9 +320,7 @@ static int iio_scan_mask_set(struct iio_dev *indio_dev,
>  	const unsigned long *mask;
>  	unsigned long *trialmask;
>  
> -	trialmask = kmalloc_array(BITS_TO_LONGS(indio_dev->masklength),
> -				  sizeof(*trialmask),
> -				  GFP_KERNEL);
> +	trialmask = bitmap_alloc(indio_dev->masklength, GFP_KERNEL);
>  	if (trialmask == NULL)
>  		return -ENOMEM;
>  	if (!indio_dev->masklength) {
> @@ -344,12 +342,12 @@ static int iio_scan_mask_set(struct iio_dev *indio_dev,
>  	}
>  	bitmap_copy(buffer->scan_mask, trialmask, indio_dev->masklength);
>  
> -	kfree(trialmask);
> +	bitmap_free(trialmask);
>  
>  	return 0;
>  
>  err_invalid_mask:
> -	kfree(trialmask);
> +	bitmap_free(trialmask);
>  	return -EINVAL;
>  }
>  
> @@ -666,7 +664,7 @@ static void iio_free_scan_mask(struct iio_dev *indio_dev,
>  {
>  	/* If the mask is dynamically allocated free it, otherwise do nothing */
>  	if (!indio_dev->available_scan_masks)
> -		kfree(mask);
> +		bitmap_free(mask);
>  }
>  
>  struct iio_device_config {
> @@ -736,8 +734,7 @@ static int iio_verify_update(struct iio_dev *indio_dev,
>  	}
>  
>  	/* What scan mask do we actually have? */
> -	compound_mask = kcalloc(BITS_TO_LONGS(indio_dev->masklength),
> -				sizeof(long), GFP_KERNEL);
> +	compound_mask = bitmap_zalloc(indio_dev->masklength, GFP_KERNEL);
>  	if (compound_mask == NULL)
>  		return -ENOMEM;
>  
> @@ -762,7 +759,7 @@ static int iio_verify_update(struct iio_dev *indio_dev,
>  				    indio_dev->masklength,
>  				    compound_mask,
>  				    strict_scanmask);
> -		kfree(compound_mask);
> +		bitmap_free(compound_mask);
>  		if (scan_mask == NULL)
>  			return -EINVAL;
>  	} else {
> @@ -1303,9 +1300,8 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>  					channels[i].scan_index;
>  		}
>  		if (indio_dev->masklength && buffer->scan_mask == NULL) {
> -			buffer->scan_mask = kcalloc(BITS_TO_LONGS(indio_dev->masklength),
> -						    sizeof(*buffer->scan_mask),
> -						    GFP_KERNEL);
> +			buffer->scan_mask = bitmap_zalloc(indio_dev->masklength,
> +							  GFP_KERNEL);
>  			if (buffer->scan_mask == NULL) {
>  				ret = -ENOMEM;
>  				goto error_cleanup_dynamic;
> @@ -1334,7 +1330,7 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>  	return 0;
>  
>  error_free_scan_mask:
> -	kfree(buffer->scan_mask);
> +	bitmap_free(buffer->scan_mask);
>  error_cleanup_dynamic:
>  	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
>  	kfree(indio_dev->buffer->buffer_group.attrs);
> @@ -1347,7 +1343,7 @@ void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
>  	if (!indio_dev->buffer)
>  		return;
>  
> -	kfree(indio_dev->buffer->scan_mask);
> +	bitmap_free(indio_dev->buffer->scan_mask);
>  	kfree(indio_dev->buffer->buffer_group.attrs);
>  	kfree(indio_dev->buffer->scan_el_group.attrs);
>  	iio_free_chan_devattr_list(&indio_dev->buffer->scan_el_dev_attr_list);

