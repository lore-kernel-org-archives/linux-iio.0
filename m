Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D362E14E2F2;
	Thu, 29 Jan 2026 17:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769706399; cv=none; b=JXoubQ9NXhbToN7ToPv/p7ImNJK9b2WCAjWuibUkp1wnHu/zi+N8W3XX4WT8bOxgp0ITqwbjgmJYykJq1nFUoJg2qOXFf36T2T22uFGZbabjb+Cf3sc7TFFKyBbbTvx0f4PXEB2S6C+222L/JGewOCU7RX/JBDhaT97Ych+3obw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769706399; c=relaxed/simple;
	bh=F94jH0w5f7Gg8dsHMoRnI/vrtdW2QG8HVYtQjqpu/Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q2ncwvowYx0JTTICS5pIO2LkoRESLmJJnnSRMN275kj39ImCJaHUr4vVwuhSG91yRU19Vbo5W4QidUQAPQmHX2GPLARi17KJOFT9DWBDiNKiP3C+UI9WAJjlxTkCwYxjAdx3nITerjmqbUWSc9jJjoHh9qWwf6LgXlQwIKMKa9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdW7FKiO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdW7FKiO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0618C4CEF7;
	Thu, 29 Jan 2026 17:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769706399;
	bh=F94jH0w5f7Gg8dsHMoRnI/vrtdW2QG8HVYtQjqpu/Ak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EdW7FKiOtiUNS1YY+M4CUIcDypUR8Xam73pYC34RY4+jy1AwS26rn+eMXZHUN8RHm
	 39ZdKOvDi5ypG8rW/GwW4aETYaQ0muh3QjtfC6qfIa3bQiWrVs+FKk4CsRf/vuq43k
	 XlWdGfCNeZ2I/RaCn5b6eyueV/ZiFKyAxgKqkA69c0UsoZdPAaGNjvcLcYWYFZyIdG
	 1fbkAnVltZi695uyU8L/Iv7W4/rxUiEZjWhF0C/3xz7knCS91dxhQXAWi6BcT1KPCJ
	 Td790+F7ZXZKEbGzYuioxr6PTPX8bpRvg+oTZzOkCizAqekapIl1MbypvEsAd/FkWp
	 8LCBp509yXsvg==
Date: Thu, 29 Jan 2026 17:06:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Petre Rodan
 <petre.rodan@subdimension.ro>, Manuel Stahl
 <manuel.stahl@iis.fraunhofer.de>, Lars-Peter Clausen <lars@metafoo.de>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: pressure: hsc030pa: Fix i2c_transfer return value
 check
Message-ID: <20260129170631.34f429f9@jic23-huawei>
In-Reply-To: <20260129150151.127713-2-antoniu.miclaus@analog.com>
References: <20260129150151.127713-1-antoniu.miclaus@analog.com>
	<20260129150151.127713-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Jan 2026 17:01:46 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The i2c_transfer() function returns the number of messages
> successfully transferred. The function sends 1 message but checks
> for ret == 2, which can never be true. This causes the function to
> always return an error (1) instead of success (0).
> 
> Fix the check to compare against the actual number of messages sent.
> 
> Fixes: 6362d96585e3 ("iio: pressure: driver for Honeywell HSC/SSC series")
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Not a bug with any impact because the check is on ret < 0
at the caller. 

So this commit message needs adjustment to reflect that - little
point in anyone backporting it as a result.

If it were ever other than 1 or zero we'd want to do something subtler and
even though that doesn't happen I'd write the code differently to reflect the different
potential outcomes
> ---
>  drivers/iio/pressure/hsc030pa_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/pressure/hsc030pa_i2c.c b/drivers/iio/pressure/hsc030pa_i2c.c
> index a34ef4653f34..e780732c7b75 100644
> --- a/drivers/iio/pressure/hsc030pa_i2c.c
> +++ b/drivers/iio/pressure/hsc030pa_i2c.c
> @@ -35,7 +35,7 @@ static int hsc_i2c_recv(struct hsc_data *data)
>  
>  	ret = i2c_transfer(client->adapter, &msg, 1);
>  
> -	return (ret == 2) ? 0 : ret;
> +	return (ret == 1) ? 0 : ret;
That is
	if (ret < 0)
		return ret;

	if (ret != 1)
		return -EIO;

	return 0;

>  }
>  
>  static int hsc_i2c_probe(struct i2c_client *client)

