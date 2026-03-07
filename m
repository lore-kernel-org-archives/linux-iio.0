Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394B12874E1;
	Sat,  7 Mar 2026 17:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772903269; cv=none; b=jwcwGb4Rq6iEumoOrggcfXhyaas0JxnqQRnLSOU1ioMCyUQHL6MXpI5mXq8M9ki9LkPWfBKa5qSPB74Z1m7Hak6d+Zu2OheMAYYf6BpEZfGt3mGzEvwzsGMDpgMMUNrQchvVFcm7fQfRy71+uuvP8gyllQjv+1dPXIccIWf9kd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772903269; c=relaxed/simple;
	bh=r52KEvQmBGDnp3IoDZ00PMN+N3mXaify/jhP6aOi9l0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oSWBxh5HpZ2B8OpTylGAr4sz4xSdbCCZkmcOxPK3oUfw3EbIZVSkH5CkYupy+iKdtFrx8cHzYGUCkmIn5e41lzYt79VJL0Azt/82zV2dNKixeNmIQo4PrvZv0hTyzZhm4gFwzuUOuWjZt9lv0WIkcKD0RBAOSKjyE70DZ+BydwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGXyo/Nl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGXyo/Nl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD83C19422;
	Sat,  7 Mar 2026 17:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772903269;
	bh=r52KEvQmBGDnp3IoDZ00PMN+N3mXaify/jhP6aOi9l0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hGXyo/Nlt+Xpmec43ubpSQZbxEJ5HYVLKBPQHzBCRMCbOUeaSuY/H1+GU/ztv6TFl
	 KWKqjGguEP1Fd58EPd2Gs03cZxitWHeGc0WuBpMY8GYtvJDpGejhQxPgUX23DsTzcl
	 5TeXTnfXXsJ+QvSmt6P5Z3ZFH62Gw9LujZlJC+IssiwDo+BAwX4FGWssL0hjJARWHd
	 ck7QkKqr+74mjE4S++jHThjHSOc7zdu2sEgQuhZFLApOEPrmgvMhUKBsZfMzUYDNII
	 Btp6lYVtrUCZPQXPy/UN9rh06Z8rPhA+DZ6xQEkyRqjjKqPdzDwnK+qPY8mtjdvHT8
	 5s4u/CmXAnSzQ==
Date: Sat, 7 Mar 2026 17:07:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Shrikant Raskar
 <raskar.shree97@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: rfd77402: Fix completion race condition
 in IRQ mode
Message-ID: <20260307170741.0bbcee90@jic23-huawei>
In-Reply-To: <20260304-77402-v1-1-47ad6eedd643@gmail.com>
References: <20260304-77402-v1-1-47ad6eedd643@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 04 Mar 2026 22:14:32 +0800
Felix Gu <ustc.gu@gmail.com> wrote:

> In IRQ mode, the completion was being reinitialized after the
> measurement command had already been sent to the hardware. This
> created a race condition where the IRQ handler could call complete()
> before reinit_completion() was executed. Consequently,
> wait_for_completion_timeout() would fail to see the signal and wait
> until it timed out.
> 
> Move reinit_completion() to occur before the measurement command is
> triggered to ensure the synchronization primitive is ready to
> capture the interrupt.
> 
> Fixes: dc81be96a73a ("iio: proximity: rfd77402: Add interrupt handling support")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>

Looks good to me. Shrikant, you know this driver better than I do so if you
can take a look as well that would be great.

Thanks,

J
> ---
>  drivers/iio/proximity/rfd77402.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
> index 6afdbfca3e5a..81b8daf17a54 100644
> --- a/drivers/iio/proximity/rfd77402.c
> +++ b/drivers/iio/proximity/rfd77402.c
> @@ -173,10 +173,8 @@ static int rfd77402_wait_for_result(struct rfd77402_data *data)
>  	struct i2c_client *client = data->client;
>  	int val, ret;
>  
> -	if (data->irq_en) {
> -		reinit_completion(&data->completion);
> +	if (data->irq_en)
>  		return rfd77402_wait_for_irq(data);
> -	}
>  
>  	/*
>  	 * As per RFD77402 datasheet section '3.1.1 Single Measure', the
> @@ -204,6 +202,9 @@ static int rfd77402_measure(struct rfd77402_data *data)
>  	if (ret < 0)
>  		return ret;
>  
> +	if (data->irq_en)
> +		reinit_completion(&data->completion);
> +
>  	ret = i2c_smbus_write_byte_data(client, RFD77402_CMD_R,
>  					RFD77402_CMD_SINGLE |
>  					RFD77402_CMD_VALID);
> 
> ---
> base-commit: c025f6cf4209e1542ec2afebe49f42bbaf1a5c7b
> change-id: 20260304-77402-ec479de1b9f6
> 
> Best regards,

