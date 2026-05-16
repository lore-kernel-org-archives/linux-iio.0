Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F392DECDF;
	Sat, 16 May 2026 11:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778930926; cv=none; b=flVyYt4DTjVjR75kx+leFbrxI+7T3emnFdZr/APKhoM6shKDbbKKqVUCz0esFEuxGMLbzADdK7SeZj/45+/qIa/hwXOqoku8ZB5zrj6d2MMOFpU4F6v8Nvui+1wzfScmfC1kLI87wuY1i+wihgkc4lTxM/YPYTpqdGnyana+FYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778930926; c=relaxed/simple;
	bh=LRjM+In+OrFvSry4G3iwBS9Sd9Xss9Q00R8W6hu9AAA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AwffDfFPXAwhJcqoUlqAQ3YBoZUT4mcKdtA4FNefgZKPnAVTU3JiOXN79Bmv0+XmGd8J7WAR7rUn7dkCvCPieg1gGMSsFUQeixX0pTTtwR+gScvkZFSd8J31IhZGMKgl+4iX1x1xHEw3dI38g16b0MNH90DCGLLvuYWjzf4qrh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGK+eZrc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGK+eZrc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE786C19425;
	Sat, 16 May 2026 11:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778930926;
	bh=LRjM+In+OrFvSry4G3iwBS9Sd9Xss9Q00R8W6hu9AAA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qGK+eZrcl0afDSr36eEJUVhfBRKU69/LwruVADvbamOXiEuzn9/z+RvwiAfKGS800
	 NG8aOL3q6HOlZpZXVH1dotbWhO5WNkw+yeUO8AVyYpejAd8vTGjgaO4YhRLNpymEr/
	 up+LnimJTNg5aL/E1kmxordIoDREXanrn1unqRyFdoaZKBVjldsesHc6KKeIjOH27y
	 HdMSpy62zUQMjUVxrjFhMfxTgelp/EV/SOzmJbqu18CHAUib57ktPCoTUPjGxBAxTv
	 QG4DEfSd3pyyvdN9BTDYiZd1O6Vdcynn4sxy3LzijQ9oPwiTrqx0zQ0MbYksgnEdlK
	 jorm+fC4bOvrg==
Date: Sat, 16 May 2026 12:28:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: resolver: ad2s1210: notify trigger and clear state
 on fault read error
Message-ID: <20260516122838.163a77d3@jic23-huawei>
In-Reply-To: <20260515133138.32319-1-sozdayvek@gmail.com>
References: <20260515133138.32319-1-sozdayvek@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 May 2026 18:31:38 +0500
Stepan Ionichev <sozdayvek@gmail.com> wrote:

> ad2s1210_trigger_handler() walks several scan-mask branches and uses
> "goto error_ret" to land on the iio_trigger_notify_done() teardown at
> the bottom of the function for every I/O error -- except the
> MOD_CONFIG fault-register read, which uses a bare "return ret":
> 
> 	if (st->fixed_mode == MOD_CONFIG) {
> 		unsigned int reg_val;
> 
> 		ret = regmap_read(st->regmap, AD2S1210_REG_FAULT, &reg_val);
> 		if (ret < 0)
> 			return ret;
> 		...
> 	}
> 
> Two problems on that path:
> 
>   - the handler returns a negative errno where the prototype expects
>     an irqreturn_t (IRQ_HANDLED / IRQ_NONE), so the caller in the
>     IIO core sees a value outside the enum;
>   - iio_trigger_notify_done() is skipped, leaving the trigger
>     busy-flag set. A single transient SPI/regmap error on the fault
>     read then wedges the trigger so subsequent samples are dropped
>     until the consumer is detached.
> 
> Convert the error path to "goto error_ret" so the failure path goes
> through the same notify_done() teardown as every other error in the
> handler.
> 
> Fixes: f9b9ff95be8c ("iio: resolver: ad2s1210: add support for adi,fixed-mode")
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>

Not related to this as the fix is good, but I was obviously half asleep
when guard() got added to this function which is full of gotos :(

If you have time could you look at factoring out helper that basically lifts
everything before trigger_notify_done() which should not be done with
the guard held - at least in this case it's not a deadlock source
as the device doesn't have any triggers!

That helper can use guard() and do direct returns to simplify the code flow.

Anyhow, this fix is good so applied and marked for stable.

> ---
>  drivers/iio/resolver/ad2s1210.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/resolver/ad2s1210.c b/drivers/iio/resolver/ad2s1210.c
> index 774728c80..1be19fe8a 100644
> --- a/drivers/iio/resolver/ad2s1210.c
> +++ b/drivers/iio/resolver/ad2s1210.c
> @@ -1334,7 +1334,7 @@ static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
>  
>  		ret = regmap_read(st->regmap, AD2S1210_REG_FAULT, &reg_val);
>  		if (ret < 0)
> -			return ret;
> +			goto error_ret;
>  
>  		st->sample.fault = reg_val;
>  	}

