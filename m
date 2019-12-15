Return-Path: <SRS0=NL2V=2F=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F27C43603
	for <linux-iio@archiver.kernel.org>; Sun, 15 Dec 2019 15:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8414220726
	for <linux-iio@archiver.kernel.org>; Sun, 15 Dec 2019 15:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfLOPwv (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 15 Dec 2019 10:52:51 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:44394 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfLOPwv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Dec 2019 10:52:51 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id C746B9E7C73;
        Sun, 15 Dec 2019 15:52:48 +0000 (GMT)
Date:   Sun, 15 Dec 2019 15:52:47 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.4 074/350] iio: proximity: sx9500: fix
 iio_triggered_buffer_{predisable,postenable} positions
Message-ID: <20191215155247.66ea5412@archlinux>
In-Reply-To: <20191210210735.9077-35-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
        <20191210210735.9077-35-sashal@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 10 Dec 2019 16:02:59 -0500
Sasha Levin <sashal@kernel.org> wrote:

> From: Alexandru Ardelean <alexandru.ardelean@analog.com>
> 
> [ Upstream commit 3cfd6464fe23deb45bb688df66184b3f32fefc16 ]
> 
> The iio_triggered_buffer_predisable() should be called last, to detach the
> poll func after the devices has been suspended.
> 
> This change re-organizes things a bit so that the postenable & predisable
> are symmetrical. It also converts the preenable() to a postenable().
> 
> Not stable material as there is no known problem with the current
> code, it's just not consistent with the form we would like all the
> IIO drivers to adopt so as to allow subsystem wide changes.

See comment.

Jonathan

> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/iio/proximity/sx9500.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
> index 612f79c53cfc6..287d288e40c27 100644
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

