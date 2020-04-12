Return-Path: <SRS0=GqNd=54=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE7EC2BA2B
	for <linux-iio@archiver.kernel.org>; Sun, 12 Apr 2020 13:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA79020708
	for <linux-iio@archiver.kernel.org>; Sun, 12 Apr 2020 13:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586696425;
	bh=ollfsvnlFYeQf0DEcXjahLhgJYIHtleZy323hYBFpuo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=2hOsbh7+QtOn2t24vFs/oT+9HTRTY/JRt6DtRtwMk+2sEQ3J5zrGWRk3d8p8j0tc1
	 AQuN9+jerrUE8oy1Tce6QM0aABm1o2LASQ09K1244SfdzKnziWDivA55bN0jFneMwv
	 r0kcjJEnfCYCGp9v23HOX3EKFWWF1cIxGKHm+bsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgDLNAY (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 12 Apr 2020 09:00:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgDLNAY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Apr 2020 09:00:24 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A53520705;
        Sun, 12 Apr 2020 13:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586696423;
        bh=ollfsvnlFYeQf0DEcXjahLhgJYIHtleZy323hYBFpuo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uL/UVklTDbnRDgX6k2lJHXRaJA3CyPHYas7hM7Rl9cxHI7Y7qi3MbyUJFRPHHwrt5
         85YGtVXFDt/sdVzzD2CzkQPpusUVKJAZ8LfSMJDgcVrZ2D2XObk/wKk5tPmexjDFj2
         KdrJmVB/oOxygy2NB9+hwTBzuM9cg1XV9RZhx49c=
Date:   Sun, 12 Apr 2020 14:00:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/8] iio: buffer: drop devm_iio_hw_consumer_free() API
 call
Message-ID: <20200412140020.4e726f4f@archlinux>
In-Reply-To: <20200227135227.12433-7-alexandru.ardelean@analog.com>
References: <20200227135227.12433-1-alexandru.ardelean@analog.com>
        <20200227135227.12433-7-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 27 Feb 2020 15:52:26 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> It's unused so far, so it can't be removed. Also makes sense to remove it
> to discourage weird uses of this call during review.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied thanks.

Though just notice you have a can't where it should be can in the patch
description.   Will fix that up.

Thanks,

Jonathan

> ---
>  drivers/iio/buffer/industrialio-hw-consumer.c | 31 -------------------
>  include/linux/iio/hw-consumer.h               |  1 -
>  2 files changed, 32 deletions(-)
> 
> diff --git a/drivers/iio/buffer/industrialio-hw-consumer.c b/drivers/iio/buffer/industrialio-hw-consumer.c
> index 95165697d8ae..f2d27788f666 100644
> --- a/drivers/iio/buffer/industrialio-hw-consumer.c
> +++ b/drivers/iio/buffer/industrialio-hw-consumer.c
> @@ -142,17 +142,6 @@ static void devm_iio_hw_consumer_release(struct device *dev, void *res)
>  	iio_hw_consumer_free(*(struct iio_hw_consumer **)res);
>  }
>  
> -static int devm_iio_hw_consumer_match(struct device *dev, void *res, void *data)
> -{
> -	struct iio_hw_consumer **r = res;
> -
> -	if (!r || !*r) {
> -		WARN_ON(!r || !*r);
> -		return 0;
> -	}
> -	return *r == data;
> -}
> -
>  /**
>   * devm_iio_hw_consumer_alloc - Resource-managed iio_hw_consumer_alloc()
>   * @dev: Pointer to consumer device.
> @@ -160,9 +149,6 @@ static int devm_iio_hw_consumer_match(struct device *dev, void *res, void *data)
>   * Managed iio_hw_consumer_alloc. iio_hw_consumer allocated with this function
>   * is automatically freed on driver detach.
>   *
> - * If an iio_hw_consumer allocated with this function needs to be freed
> - * separately, devm_iio_hw_consumer_free() must be used.
> - *
>   * returns pointer to allocated iio_hw_consumer on success, NULL on failure.
>   */
>  struct iio_hw_consumer *devm_iio_hw_consumer_alloc(struct device *dev)
> @@ -186,23 +172,6 @@ struct iio_hw_consumer *devm_iio_hw_consumer_alloc(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(devm_iio_hw_consumer_alloc);
>  
> -/**
> - * devm_iio_hw_consumer_free - Resource-managed iio_hw_consumer_free()
> - * @dev: Pointer to consumer device.
> - * @hwc: iio_hw_consumer to free.
> - *
> - * Free iio_hw_consumer allocated with devm_iio_hw_consumer_alloc().
> - */
> -void devm_iio_hw_consumer_free(struct device *dev, struct iio_hw_consumer *hwc)
> -{
> -	int rc;
> -
> -	rc = devres_release(dev, devm_iio_hw_consumer_release,
> -			    devm_iio_hw_consumer_match, hwc);
> -	WARN_ON(rc);
> -}
> -EXPORT_SYMBOL_GPL(devm_iio_hw_consumer_free);
> -
>  /**
>   * iio_hw_consumer_enable() - Enable IIO hardware consumer
>   * @hwc: iio_hw_consumer to enable.
> diff --git a/include/linux/iio/hw-consumer.h b/include/linux/iio/hw-consumer.h
> index 44d48bb1d39f..e8255c2e33bc 100644
> --- a/include/linux/iio/hw-consumer.h
> +++ b/include/linux/iio/hw-consumer.h
> @@ -14,7 +14,6 @@ struct iio_hw_consumer;
>  struct iio_hw_consumer *iio_hw_consumer_alloc(struct device *dev);
>  void iio_hw_consumer_free(struct iio_hw_consumer *hwc);
>  struct iio_hw_consumer *devm_iio_hw_consumer_alloc(struct device *dev);
> -void devm_iio_hw_consumer_free(struct device *dev, struct iio_hw_consumer *hwc);
>  int iio_hw_consumer_enable(struct iio_hw_consumer *hwc);
>  void iio_hw_consumer_disable(struct iio_hw_consumer *hwc);
>  

