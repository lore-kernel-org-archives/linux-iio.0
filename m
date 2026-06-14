Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FE931DDBB;
	Sun, 14 Jun 2026 13:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781443449; cv=none; b=bWN/guTDQ+0YBSi6/6DQ/her2l8T9pfDNmrDpUB6CIFg1HksPrG51TDEIpVc9l0n+PY76XwELXeq2rUV3ktZ+uvpP0CrjC3Bbp6GltamWN9NyyI+4nYiDuRjXOABjuOxUoKIb++L1+BpafQ3rj3eGSLJyjstnIx+KngQTYOvmxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781443449; c=relaxed/simple;
	bh=+JiVbSnfl0F288sbazSIAKba+/RseL5WZ9vovzFmYDs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mkhIQl/n8Xys7PEq8/UHJg4DZBM+VriZxerV2qXpAUX8fHOOTusKvW9pgBT8NDZREOAmyAmV6yS6iuEpyQlyngV2yEGDngXAOsUhn5zcdhTbSwUYIBhf72K6z77TfzFSZeJsEOrjsCvFOcA3SSB8YKEoz/I5SdBP7Dzlbc1DOwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTSGq1O/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTSGq1O/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB9E1F000E9;
	Sun, 14 Jun 2026 13:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781443448;
	bh=2f4+B/irgLib6PczrKd+rJ5TIt49LWWVv8VIfJ/iZxA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WTSGq1O//Tvo6e0TDIuc+vO2uQ9EZLlEOGxOZ6uQDL1VRS2w44wSHbOKKv8LKAkzA
	 TKb515Q3E3YWhbnVLDkYDc9WO8G3AH0Na8EHWmWfKNGnlBq+cJUmR+SE38XA6JR2jH
	 98rUP8P7Y3T/Z6Qhcx7C4yAegqYVFqmWPR1Q5rUSHmOuIMkcSOb4sP4IPRYKWGCLiX
	 k4A1vcTwy7HPVTwAiESjX4pl5vTfGAnYa02rDH7cI61WIaR9CpKABgAZfd8QzmJThh
	 DDKqvwi4aXeBvK63Fa+fUKvkUPKGBoV6yXHh7CjrXqqOHphR0RszP/WrQ1CsDAx1yo
	 Pioon9O3HcQQQ==
Date: Sun, 14 Jun 2026 14:24:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Biren Pandya <birenpandya@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] iio: pressure: mpl115: fix runtime PM leak on
 read error
Message-ID: <20260614142400.3eb1f011@jic23-huawei>
In-Reply-To: <20260614071549.81920-4-birenpandya@gmail.com>
References: <20260614071549.81920-1-birenpandya@gmail.com>
	<20260614071549.81920-4-birenpandya@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Jun 2026 12:45:48 +0530
Biren Pandya <birenpandya@gmail.com> wrote:

> mpl115_read_raw() takes a runtime PM reference with pm_runtime_get_sync()
> before reading the processed pressure or raw temperature, but on the read
> error path it returns without calling pm_runtime_put_autosuspend(). Each
> failed read therefore leaks a runtime PM reference and prevents the device
> from autosuspending.
> 
> Drop the reference before checking the return value so both the success
> and error paths are balanced.
> 
> Signed-off-by: Biren Pandya <birenpandya@gmail.com>
> Assisted-by: Claude:claude-opus-4-8 coccinelle
Applied and marked for stable.
Thanks,

Jonathan

> ---
>  drivers/iio/pressure/mpl115.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
> index 830a5065c008..16e112b796ba 100644
> --- a/drivers/iio/pressure/mpl115.c
> +++ b/drivers/iio/pressure/mpl115.c
> @@ -106,18 +106,18 @@ static int mpl115_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_PROCESSED:
>  		pm_runtime_get_sync(data->dev);
>  		ret = mpl115_comp_pressure(data, val, val2);
> +		pm_runtime_put_autosuspend(data->dev);
>  		if (ret < 0)
>  			return ret;
> -		pm_runtime_put_autosuspend(data->dev);
>  
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	case IIO_CHAN_INFO_RAW:
>  		pm_runtime_get_sync(data->dev);
>  		/* temperature -5.35 C / LSB, 472 LSB is 25 C */
>  		ret = mpl115_read_temp(data);
> +		pm_runtime_put_autosuspend(data->dev);
>  		if (ret < 0)
>  			return ret;
> -		pm_runtime_put_autosuspend(data->dev);
>  		*val = ret >> 6;
>  
>  		return IIO_VAL_INT;

