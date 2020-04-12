Return-Path: <SRS0=GqNd=54=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C622FC2BA2B
	for <linux-iio@archiver.kernel.org>; Sun, 12 Apr 2020 13:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9831920709
	for <linux-iio@archiver.kernel.org>; Sun, 12 Apr 2020 13:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586696469;
	bh=8lEq43mVTnv5gBR+gJ9XIkZyLjfNuczQB0NMtpyiYzU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=OrUljuB+aknp6N2WWI5vlBVRFu616FtUkvGo2HpLnIrk3HI+VHmPRrNyvdiirSbEx
	 WJLP9T//PGdJwDHZPDPKmF91zsN0jdI41+pq6F5vabeHqA6KEyvTTHh3dO0CnCbRhk
	 jeXNf5jcjuct28mSgBvqwMHUYAeV+SOGzUIc+vCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgDLNBI (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 12 Apr 2020 09:01:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgDLNBI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Apr 2020 09:01:08 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5453720705;
        Sun, 12 Apr 2020 13:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586696468;
        bh=8lEq43mVTnv5gBR+gJ9XIkZyLjfNuczQB0NMtpyiYzU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PIFecLOE1/LxlhXqEyUFzFnhvvfXRFvaZBQpiBVglpiMTOMkNxRdBEPFE7jdvFWs4
         y7+D2WifRzQ7Zqul459pYRMorMEMOpO+QHAA1yLMYsg4vm+ToYubtF9erA0lUOKkTr
         YsuTItGPaF0+y7mgTKJ4CsS52GCYUGunTU43togI=
Date:   Sun, 12 Apr 2020 14:01:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 8/8] iio: buffer: drop devm_iio_kfifo_free() API call
Message-ID: <20200412140104.0f30a475@archlinux>
In-Reply-To: <20200227135227.12433-8-alexandru.ardelean@analog.com>
References: <20200227135227.12433-1-alexandru.ardelean@analog.com>
        <20200227135227.12433-8-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 27 Feb 2020 15:52:27 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> It's unused so far, so it can't be removed. Also makes sense to remove it
> to discourage weird uses of this call during review.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied with the can't -> can above fixed up.

Thanks,

Jonathan

> ---
>  .../driver-api/driver-model/devres.rst        |  1 -
>  drivers/iio/buffer/kfifo_buf.c                | 22 -------------------
>  include/linux/iio/kfifo_buf.h                 |  1 -
>  3 files changed, 24 deletions(-)
> 
> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
> index 10ccebe9f7c1..91b0b8e5556c 100644
> --- a/Documentation/driver-api/driver-model/devres.rst
> +++ b/Documentation/driver-api/driver-model/devres.rst
> @@ -286,7 +286,6 @@ IIO
>    devm_iio_device_alloc()
>    devm_iio_device_register()
>    devm_iio_kfifo_allocate()
> -  devm_iio_kfifo_free()
>    devm_iio_triggered_buffer_setup()
>    devm_iio_trigger_alloc()
>    devm_iio_trigger_register()
> diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfifo_buf.c
> index 3150f8ab984b..1359abed3b31 100644
> --- a/drivers/iio/buffer/kfifo_buf.c
> +++ b/drivers/iio/buffer/kfifo_buf.c
> @@ -179,16 +179,6 @@ static void devm_iio_kfifo_release(struct device *dev, void *res)
>  	iio_kfifo_free(*(struct iio_buffer **)res);
>  }
>  
> -static int devm_iio_kfifo_match(struct device *dev, void *res, void *data)
> -{
> -	struct iio_buffer **r = res;
> -
> -	if (WARN_ON(!r || !*r))
> -		return 0;
> -
> -	return *r == data;
> -}
> -
>  /**
>   * devm_iio_fifo_allocate - Resource-managed iio_kfifo_allocate()
>   * @dev:		Device to allocate kfifo buffer for
> @@ -216,16 +206,4 @@ struct iio_buffer *devm_iio_kfifo_allocate(struct device *dev)
>  }
>  EXPORT_SYMBOL(devm_iio_kfifo_allocate);
>  
> -/**
> - * devm_iio_fifo_free - Resource-managed iio_kfifo_free()
> - * @dev:		Device the buffer belongs to
> - * @r:			The buffer associated with the device
> - */
> -void devm_iio_kfifo_free(struct device *dev, struct iio_buffer *r)
> -{
> -	WARN_ON(devres_release(dev, devm_iio_kfifo_release,
> -			       devm_iio_kfifo_match, r));
> -}
> -EXPORT_SYMBOL(devm_iio_kfifo_free);
> -
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/iio/kfifo_buf.h b/include/linux/iio/kfifo_buf.h
> index 764659e01b68..1fc1efa7799d 100644
> --- a/include/linux/iio/kfifo_buf.h
> +++ b/include/linux/iio/kfifo_buf.h
> @@ -9,6 +9,5 @@ struct iio_buffer *iio_kfifo_allocate(void);
>  void iio_kfifo_free(struct iio_buffer *r);
>  
>  struct iio_buffer *devm_iio_kfifo_allocate(struct device *dev);
> -void devm_iio_kfifo_free(struct device *dev, struct iio_buffer *r);
>  
>  #endif

