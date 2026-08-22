Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CD8259C80;
	Sat, 22 Aug 2026 23:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787441987; cv=none; b=snJ9U95H6UBnrZAuedI2DUWCr8uhwN9KZU9gdpmVCBfi33kU9k6TMzFjVZOk9J9mfBZvZP94ANnXSYDISmxjPF2a1HLlrh++4cDRM2WdF8P4W5S7GcTl8IMyGAms7Tkni1DWHw5D0MYfWZ9oEdV6BHTXWQ5wc1ar+gnv8PG9YVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787441987; c=relaxed/simple;
	bh=L9j50N1Q35arzWfMBu4430/l4pBj89Xn/Hh9bDiYEr4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vCGB+KtLJaADQCQdTujYXZa3JPPsyvN5/N27Wdfsb0CaJqkuXJrU5ooj6GzEHZkbF3jiipT93Tz7zu4U+7mM2WToTCGJpGZlxqzEfd7ugpI8Ye3ejzqvAx7i3NVPva/bSMECng26avZoy1hncDHo4HcaTOOcsC+q/RppgoV5bNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oomEKeFL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oomEKeFL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F091F000E9;
	Sat, 22 Aug 2026 23:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787441986;
	bh=lp7FsuWdu1yFpB6EEfSvbs1NH1djzhGZakcjjC/M5Ag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oomEKeFLj81rI3SxekPegJUzsfRxRrTJ95f9PBxrova+p1+E0ZjNoVERwDIvA7De/
	 FASogxBmHa2n5nemhh6xir+8iV/7Aq+6EsTS/EuiejGi+PZjaK8gNZPfN7Q3cm7cjD
	 4yTnHW3DylcMOd3TDkIwxFBrGHlAPfll+ffPWX52MqVG22TvVmEXDeK64zdP8PfcYe
	 1rq7vQKjOxP3SwiOlSjIvQV/hS460az6/dOu6PaLxllUfktHiZa34qBY/AY/Z/QDeI
	 L/wYgmJ3z84Ktf2u57xGzJWNbW7mijIpsFUsju7DtvqHINlfsvJ3m/cil1xEmBDwv5
	 kuNZobXxHXfwQ==
Date: Sun, 23 Aug 2026 00:39:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Esben Haabendal <esben@geanix.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>, Maslov Dmitry
 <maslovdmitry@seeed.cc>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, Thomas Gleixner
 <tglx@kernel.org>, Pan Chuang <panchuang@vivo.com>, Yangtao Li
 <frank.li@vivo.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v5 5/8] iio: light: ltr501: Drop duplicated error
 message
Message-ID: <20260823003939.0b64b8bc@jic23-huawei>
In-Reply-To: <20260817-liteon-ltr329-v5-5-6f71ab2b0588@geanix.com>
References: <20260817-liteon-ltr329-v5-0-6f71ab2b0588@geanix.com>
	<20260817-liteon-ltr329-v5-5-6f71ab2b0588@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 19:08:54 +0200
Esben Haabendal <esben@geanix.com> wrote:

> The dev_err() message was causing duplicated error messages, as
> devm_request_threaded_irq() calls dev_err_probe() on failure.
> 
> Acked-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Esben Haabendal <esben@geanix.com>
I picked up a patch that does this from  Pan Chuang back
on July 27th.

So dropped this one.


> ---
>  drivers/iio/light/ltr501.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index 7746d374688f..b36bd10a0262 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -1537,11 +1537,8 @@ static int ltr501_probe(struct i2c_client *client)
>  						IRQF_ONESHOT,
>  						"ltr501_thresh_event",
>  						indio_dev);
> -		if (ret) {
> -			dev_err(&client->dev, "request irq (%d) failed\n",
> -				client->irq);
> +		if (ret)
>  			goto powerdown_on_error;
> -		}
>  	} else {
>  		indio_dev->info = data->chip_info->info_no_irq;
>  	}
> 

