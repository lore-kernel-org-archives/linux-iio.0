Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BE7320CAD;
	Sat,  5 Sep 2026 23:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788649922; cv=none; b=Nu7GE9NcMrTrBAzccKxj31jsTm1/IhIdUhr+u6n2G/bOwHHUWlnCWgohOdRMbUtyZmAp1MfwuxtH/9yEdZIVe1tEqPRjKxrLqZNDLMqO23PfLGiXSKiSRYO29M6sXJb80WFzV+xmJ9seiLdUqSP1uRqkFo9RSzUpJqxAolFoKVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788649922; c=relaxed/simple;
	bh=vQBctRcsBfjoLqPRv9vHvRLLSZc7xVbgGU2t0QnNQcg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MQi6RZ0+8tqUfOxqZeP2B9HlAIdg9BybmfczEnBB48mjG8HOaWTtSLqw8664+Y3LBTkhMQFafRjDtHsLcdnqGHWjA641MD1goQ+2Zjxx/AtW1/VYINrNxWs/mFMScC03xnB6v+v9esmyRlawsh6RqNEQNbDoEGZ5JuFmlLeCCDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHbEIR3U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHbEIR3U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0AE1F00A3A;
	Sat,  5 Sep 2026 23:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788649920;
	bh=8uEsE2QqUohAUZaR16m/mHSQWaa+kGEbT36L5RUqZTQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oHbEIR3UtvX0b334ejAoAh6F9LMxMyU9rhNrUo5Qt/UCoqHT3KS4tqvE7VlfY2EeE
	 LUNYOM3CaGYuytLZeJ9UPwSz8FI0wjg+E4O9s1EvaeaH20EQhIvk4cmendYjnmvFXz
	 i5eqf9Y5OAWJPN0ypta0AddQZbH3P54MSgsV1ztL1VcgGpFcfKTYjqQXTYm3UVzrOo
	 oCKTJYXElY/BNauyUpV3EIQunOTf0Cst5MLDLKk8Yq/7Vy1bTEebR07EBVEVmXvroa
	 0YFAf7Kk1K0KdKtMDBW8aoulezhY7//4YE95l4YO3TjGDzw8tPGdzJ0T8xWP+SMjGR
	 W9P+ccuZ+Z8Eg==
Date: Sun, 6 Sep 2026 00:11:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "hpp.iscas" <hppiscas@163.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, linux@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: cdc: ad7150: fix OF matching and publish module
 aliases
Message-ID: <20260906001156.260af57a@jic23-huawei>
In-Reply-To: <20260905133939.66210-1-hppiscas@163.com>
References: <20260905133939.66210-1-hppiscas@163.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  5 Sep 2026 21:39:39 +0800
"hpp.iscas" <hppiscas@163.com> wrote:

> The positional initializers in ad7150_of_match populate the name member
> of struct of_device_id, not compatible. Consequently the table does not
> match the compatible properties documented for AD7150, AD7151 and AD7156.
> The table is also absent from the module alias metadata.
> 
> Use designated compatible initializers and publish the corrected table.
> Keep the existing I2C ID fallback and per-device driver data unchanged.
> 
> Fixes: 89f2d5b080bc ("staging:iio:cdc:ad7150: Add of_match_table")
> Signed-off-by: hpp.iscas <hppiscas@163.com>
Hi, 

We need a 'known' identifier for signed off. That basically means
real name or a name that you have used widely in other forums.
I did my usual test of putting hpp.iscas into google and seeing if 
anything looked like a person in the top few links.

As nothing does, I can't pick this up under the Developer Certificate
of Origin (look in docs if this not familiar to you) rules.

Please either provide me with some links as evidence this is a well
known identifier for you, or send a v2 with a name.

Patch itself is good.

thanks,

Jonathan


> ---
>  drivers/iio/cdc/ad7150.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/cdc/ad7150.c b/drivers/iio/cdc/ad7150.c
> index 2f35c6d..b36ac4e 100644
> --- a/drivers/iio/cdc/ad7150.c
> +++ b/drivers/iio/cdc/ad7150.c
> @@ -636,11 +636,13 @@ static const struct i2c_device_id ad7150_id[] = {
>  MODULE_DEVICE_TABLE(i2c, ad7150_id);
>  
>  static const struct of_device_id ad7150_of_match[] = {
> -	{ "adi,ad7150" },
> -	{ "adi,ad7151" },
> -	{ "adi,ad7156" },
> +	{ .compatible = "adi,ad7150" },
> +	{ .compatible = "adi,ad7151" },
> +	{ .compatible = "adi,ad7156" },
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(of, ad7150_of_match);
> +
>  static struct i2c_driver ad7150_driver = {
>  	.driver = {
>  		.name = "ad7150",
> 

