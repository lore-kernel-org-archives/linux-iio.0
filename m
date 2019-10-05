Return-Path: <SRS0=SkP8=X6=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2930DC4740A
	for <linux-iio@archiver.kernel.org>; Sat,  5 Oct 2019 15:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA972222CA
	for <linux-iio@archiver.kernel.org>; Sat,  5 Oct 2019 15:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570288676;
	bh=acFRSYlfO8Qkpbi/YuIPYx0Ljkx8HyJ+idpXxnPv9OY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wWwFVsmO5VdTRZ9uLAIavF2/nanad55AjhRfU8uxTwBsfH9/e89CS/8Bpw3/CUoIX
	 Qvu0hnuft7QrChbEKiEUmSBUNM6F1A3UtkGPGQHwaQmiJt2yHNz2FqJoLqHPAp5pi3
	 FC36eGfLpgKccYpVu2v/Lnsuu9KZ/oGN9/1UhpSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfJEPRz (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 5 Oct 2019 11:17:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbfJEPRz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 11:17:55 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0234D218AC;
        Sat,  5 Oct 2019 15:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570288674;
        bh=acFRSYlfO8Qkpbi/YuIPYx0Ljkx8HyJ+idpXxnPv9OY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pL8Dn+l1jCqalwEpic/lkyRUlS4baAK47hY47IfX7w2UieBc7scYNkLC15lL74SLK
         IpaJJ8oxysY7QfWymYhg8hrLBhdEqvqdvQ9cHjK8w7rbWxrzgttJHrBYZUT6JnWB7d
         WzwJQ29Msw7IOp4QjbD0DnGNvtorJhwF406BIHXs=
Date:   Sat, 5 Oct 2019 16:17:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <vlad.dogaru@intel.com>
Subject: Re: [PATCH] iio: proximity: sx9500: fix
 iio_triggered_buffer_{predisable,postenable} positions
Message-ID: <20191005161750.2b3fb0ea@archlinux>
In-Reply-To: <20190920083513.720-1-alexandru.ardelean@analog.com>
References: <20190920083513.720-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 20 Sep 2019 11:35:13 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The iio_triggered_buffer_predisable() should be called last, to detach the
> poll func after the devices has been suspended.
> 
> This change re-organizes things a bit so that the postenable & predisable
> are symmetrical. It also converts the preenable() to a postenable().
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
This one seems simple and I've not heard from Vlad recently so
applied to the togreg branch of iio.git with a note to try and stop
the stable trees picking it up.

Thanks,

Jonathan

> ---
>  drivers/iio/proximity/sx9500.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
> index 612f79c53cfc..287d288e40c2 100644
> --- a/drivers/iio/proximity/sx9500.c
> +++ b/drivers/iio/proximity/sx9500.c
> @@ -675,11 +675,15 @@ static irqreturn_t sx9500_trigger_handler(int irq, void *private)
>  	return IRQ_HANDLED;
>  }
>  
> -static int sx9500_buffer_preenable(struct iio_dev *indio_dev)
> +static int sx9500_buffer_postenable(struct iio_dev *indio_dev)
>  {
>  	struct sx9500_data *data = iio_priv(indio_dev);
>  	int ret = 0, i;
>  
> +	ret = iio_triggered_buffer_postenable(indio_dev);
> +	if (ret)
> +		return ret;
> +
>  	mutex_lock(&data->mutex);
>  
>  	for (i = 0; i < SX9500_NUM_CHANNELS; i++)
> @@ -696,6 +700,9 @@ static int sx9500_buffer_preenable(struct iio_dev *indio_dev)
>  
>  	mutex_unlock(&data->mutex);
>  
> +	if (ret)
> +		iio_triggered_buffer_predisable(indio_dev);
> +
>  	return ret;
>  }
>  
> @@ -704,8 +711,6 @@ static int sx9500_buffer_predisable(struct iio_dev *indio_dev)
>  	struct sx9500_data *data = iio_priv(indio_dev);
>  	int ret = 0, i;
>  
> -	iio_triggered_buffer_predisable(indio_dev);
> -
>  	mutex_lock(&data->mutex);
>  
>  	for (i = 0; i < SX9500_NUM_CHANNELS; i++)
> @@ -722,12 +727,13 @@ static int sx9500_buffer_predisable(struct iio_dev *indio_dev)
>  
>  	mutex_unlock(&data->mutex);
>  
> +	iio_triggered_buffer_predisable(indio_dev);
> +
>  	return ret;
>  }
>  
>  static const struct iio_buffer_setup_ops sx9500_buffer_setup_ops = {
> -	.preenable = sx9500_buffer_preenable,
> -	.postenable = iio_triggered_buffer_postenable,
> +	.postenable = sx9500_buffer_postenable,
>  	.predisable = sx9500_buffer_predisable,
>  };
>  

