Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF79C189F43;
	Sun, 26 Jul 2026 19:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785093330; cv=none; b=A2r/K/VnWJiTwIXZ+Eu5sRPbIbIzuM1ES/WoqUILBCtmTO0HZfVjI5KhkdNtmHLJx56I+TDQXOGVkAPs58ZDDiTsxd9A/B68zdrnaEKI5fkngt9cXDOgjjE9CyDejz7abwy4rLUokZ0akhONRF8G+lse+HTgZI1xWEf/xVl8icI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785093330; c=relaxed/simple;
	bh=OC9cBnx7X7IbeSf+8Qr5dw1nANU1hDFCBmO/fIl2M1s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDp81V57Y3Ygp3CdIFYDaOjdViTF8QvvOji3qDsh72WiJq5srQb8fATRnScjaHuvvbieVnMz5loHwleqYq8tIMln0ttsfTkQdFUUtmH7iv7dw5IkESuWMM9NnN41j54T2axAKJ6I0cBaDyPzwXwW7nOObluNPYhxQl5rP/dX8UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yf/h6P27; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yf/h6P27"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E321F000E9;
	Sun, 26 Jul 2026 19:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785093328;
	bh=FkLtPF60IAU+9qZ3+YoF6ea6qKnd54Afm+wPTcqLmDE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Yf/h6P2703hxeJzUVSg/Z0qqX9hysRYnntfqCJb6iPEQT/zPyRsnOHKHtuwy02D/G
	 EE/2RlRFyj3vtDQ9i9jNrDQ4wM9vt8B+CiGTFj2+Sd929pfw6fviuxGSqJweMV86dg
	 +x9IErtlA68Dk8i4fAsPzDs0bS8V7yR/GGbcrtdRd6P0lQoPVYjhaov28hgQ/0ZcBE
	 jniS+vtlQDpXsqJglHj2HF5AjmqSoNGuMvXlVJyG9v9lJFP48DkqJP7mBubJ2yasOq
	 /iT95jikaMJhgwVBFoodfUUS39hmPvgwr+oiqdytG3vsikRzd10xDNsNDCBNeM7Xyg
	 HaNUkGHqIa8Ng==
Date: Sun, 26 Jul 2026 20:15:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: light: veml3328: remove unused
 i2c_set_clientdata()
Message-ID: <20260726201525.0aec2c28@jic23-huawei>
In-Reply-To: <20260724-veml3328-cleanup-v1-1-240ecf3e5097@gmail.com>
References: <20260724-veml3328-cleanup-v1-0-240ecf3e5097@gmail.com>
	<20260724-veml3328-cleanup-v1-1-240ecf3e5097@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 00:07:08 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> The I2C client data is set but never used. Remove the unnecessary
> function call.
Yes it is.  Take another look at how that works and how else the resulting
data is accessed (or just look at Sashiko)

I was hoping it would catch this one :)

The combination of different interfaces to access the same data has
been much debated over time but we never came to a conclusion on whether
it was worth the effort of stopping doing so given i2c driver reviewers
are far too familiar with this particular hole.

J

> 
> No functional change.
> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  drivers/iio/light/veml3328.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/light/veml3328.c b/drivers/iio/light/veml3328.c
> index 7ff1753925c4..a65748466116 100644
> --- a/drivers/iio/light/veml3328.c
> +++ b/drivers/iio/light/veml3328.c
> @@ -318,7 +318,6 @@ static int veml3328_probe(struct i2c_client *client)
>  		return -ENOMEM;
>  
>  	data = iio_priv(indio_dev);
> -	i2c_set_clientdata(client, indio_dev);
>  
>  	data->regmap = devm_regmap_init_i2c(client, &veml3328_regmap_config);
>  	if (IS_ERR(data->regmap))
> 

