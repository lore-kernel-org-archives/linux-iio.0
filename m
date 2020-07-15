Return-Path: <SRS0=5TKQ=A2=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4A0C433E1
	for <linux-iio@archiver.kernel.org>; Wed, 15 Jul 2020 12:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 488CF2070E
	for <linux-iio@archiver.kernel.org>; Wed, 15 Jul 2020 12:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594815086;
	bh=EXu1kOfMT0TfeYMt5SaQKguRAQVoN7/43lBZkGikHUM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=IE2LdbYlp3U3n6w/xkDj5vF7AfwEFSBh5svsDHu7mLf3jCUTjoJewvEc54u67vMyh
	 KjzLCa6JKhWZM9qD6stOfigHJPcHRlDlDYHH/clBu0wv92swRYxhWetzLEjc2B2fow
	 89oVKEwZ4nO+hS1XZax/K3oP6403EWucUoFLvxsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbgGOMLZ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 15 Jul 2020 08:11:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728801AbgGOMLZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 15 Jul 2020 08:11:25 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 205922065D;
        Wed, 15 Jul 2020 12:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594815084;
        bh=EXu1kOfMT0TfeYMt5SaQKguRAQVoN7/43lBZkGikHUM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vifp9O6mgxoldHa1gdB3O/MPEwFJarzgHlOglCwDg9iGGVKJFT6kaHW3mtbCPcPHj
         ETtBNeazYeFCsIRnLJHRJkQvbfHKEQHuMI+BRs4ePqhh2ebe3lGLThb0Rdi/tdRoeY
         pwvyzapVPMv9HuWGVMQuVNk12A8vuHsvcL2fQu6w=
Date:   Wed, 15 Jul 2020 13:11:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>
Subject: Re: [PATCH] iio: buffer: fix attach/detach pollfunc order
Message-ID: <20200715131121.23f5a952@archlinux>
In-Reply-To: <20200715041629.81435-1-alexandru.ardelean@analog.com>
References: <20200715041629.81435-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Jul 2020 07:16:29 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The original patch was error-ed by the submitter (me) and not by the author
> (Lars).
> After looking through the discussion logs (on email), it seems that this
> order was wrong for the start, even though the order implemented in the
> drivers was correct.
> 
> Discussions:
> - first RFC: https://lore.kernel.org/linux-iio/20180622135322.3459-1-alexandru.ardelean@analog.com/
> - 2nd patch: https://lore.kernel.org/linux-iio/20181219140912.22582-1-alexandru.ardelean@analog.com/
> - final patch-sets:
>   https://lore.kernel.org/linux-iio/20200522104632.517470-1-alexandru.ardelean@analog.com/
>   https://lore.kernel.org/linux-iio/20200525113855.178821-1-alexandru.ardelean@analog.com/
> 
> The last one was applied.
> 
> The idea is that pollfunc should be attached before calling the
> 'indio_dev->setup_ops->postenable' hook and should be detached after
> calling the 'indio_dev->setup_ops->predisable' hook.
> 
> While the drivers were updated to take this into account, the change to the
> IIO core was somehow omitted and was made wrong.
> 
> This change fixes the order to the proper form.
> 
> Fixes f11d59d87b862: ("iio: Move attach/detach of the poll func to the core")
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Great thanks.

Applied to the togreg branch of iio.git. 

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-buffer.c | 31 ++++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 2aec8b85f40d..a7d7e5143ed2 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -971,24 +971,29 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
>  			goto err_disable_buffers;
>  	}
>  
> +	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
> +		ret = iio_trigger_attach_poll_func(indio_dev->trig,
> +						   indio_dev->pollfunc);
> +		if (ret)
> +			goto err_disable_buffers;
> +	}
> +
>  	if (indio_dev->setup_ops->postenable) {
>  		ret = indio_dev->setup_ops->postenable(indio_dev);
>  		if (ret) {
>  			dev_dbg(&indio_dev->dev,
>  			       "Buffer not started: postenable failed (%d)\n", ret);
> -			goto err_disable_buffers;
> +			goto err_detach_pollfunc;
>  		}
>  	}
>  
> -	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
> -		ret = iio_trigger_attach_poll_func(indio_dev->trig,
> -						   indio_dev->pollfunc);
> -		if (ret)
> -			goto err_disable_buffers;
> -	}
> -
>  	return 0;
>  
> +err_detach_pollfunc:
> +	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
> +		iio_trigger_detach_poll_func(indio_dev->trig,
> +					     indio_dev->pollfunc);
> +	}
>  err_disable_buffers:
>  	list_for_each_entry_continue_reverse(buffer, &iio_dev_opaque->buffer_list,
>  					     buffer_list)
> @@ -1014,11 +1019,6 @@ static int iio_disable_buffers(struct iio_dev *indio_dev)
>  	if (list_empty(&iio_dev_opaque->buffer_list))
>  		return 0;
>  
> -	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
> -		iio_trigger_detach_poll_func(indio_dev->trig,
> -					     indio_dev->pollfunc);
> -	}
> -
>  	/*
>  	 * If things go wrong at some step in disable we still need to continue
>  	 * to perform the other steps, otherwise we leave the device in a
> @@ -1032,6 +1032,11 @@ static int iio_disable_buffers(struct iio_dev *indio_dev)
>  			ret = ret2;
>  	}
>  
> +	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
> +		iio_trigger_detach_poll_func(indio_dev->trig,
> +					     indio_dev->pollfunc);
> +	}
> +
>  	list_for_each_entry(buffer, &iio_dev_opaque->buffer_list, buffer_list) {
>  		ret2 = iio_buffer_disable(buffer, indio_dev);
>  		if (ret2 && !ret)

