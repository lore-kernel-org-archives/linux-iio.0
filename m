Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792725534;
	b=tOmvOffJUxE117lASoS7uHSGBRW++6xVgRyq9J9we5J4kyXeLbS7BDx52lVa6V8rUanh
	 ICNSw1EBpIxCWGB+QlpEXiwE8nlVduqJ8foIiVd6CC+K+DFPHpcw1PJAhSpPONQBxEGsf
	 /CWLkTNg91iA8tYNUa1qgfrEVwqIuHSMtQ+K8dXyEDXS2WVkNT7nh4QRugYPVPfn9IQJA
	 dsbelDpK0+yPzwQJBhNjyOjPuHMbk3RmIr0AseEOx+RhoyknzEF981FbpYIO8h0SA02D+
	 BxYrpoKBmD6oIVG1bRtYPrneudVca/zOyblLQtwENwWhp9m6ZnzreGybJO3yT6LBnYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792725534;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=AUs7OF1usMfJMcpHjmk5KYZ2PbARiQvyI4u6AfmQUhw=;
	b=UbuCE//yvIwfidkhLQCZlz4cym0eX51LuPt7ys20De8maJXS3dl9DoI3fR9lywO4/qKL
	 6+8oGvbamUE/1J2mXb0krDnEYi/BiB1zh8ihibe8VgEGZ9IPbhUmwkHnk7LqkMLpsGLyj
	 KKb4pTFbCYP0vlJFcecG3vgc3Pmy/Md3HQOgFp4b5HY9Fuhi7Rqp5ztrYnSzom88bEZ92
	 QXFwReuNtfr3WQVu+qDIwmVsvmz1RBa+Xqk0YE4x7oT9L4ixGZ6looPLKRmsNx6x0kMxs
	 3PBfDvFQmqcOo9UCj6W+byWs8nGUzQyo2oc5kiRceuqnUQ1jz688omuQqife27HsiGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UPT0//Qd";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B864606A322;
	Fri, 23 Oct 2026 03:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UPT0//Qd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDBC1F01825;
	Fri, 23 Oct 2026 03:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792725534;
	bh=AUs7OF1usMfJMcpHjmk5KYZ2PbARiQvyI4u6AfmQUhw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UPT0//QdhWbxsgRa+dWWeB3fzgM1QQqW0n/p9n7FDLi1+T4k9N1E/QFPgk6SXHLsv
	 jIdK5ENRSZxw9Qg2HQYhS7O50pPkSTiZFKjTzdM7m+sxck9qaJy93Y2OQz+iG2YIMW
	 ryNGgmVfWaBwSukDT0Pb0hLcE1l6/Tv0OTHG6WJne+rCRtJnuCo2rzPSpJmQZAHBp/
	 1kW8JVPzkouguCxO2lmsA6ATiCfAr/mZrNa81D3bAynhqvSIC+LiAZzxe1pq4JXxNF
	 IC8eOB70iYz8wr4JPkV/Z877IPx7+XmqsmHIJltsaHjr660lox8Gj8PnDZ3ePKNZW3
	 SUDiJf0joPBuw==
Date: Fri, 23 Oct 2026 04:18:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jan Remes <ciakval@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Joe Sandom
 <joe.g.sandom@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jan Remes <jan.remes@mycroftmind.com>
Subject: Re: [PATCH v4 2/4] iio: light: tsl2591: add I2C device ID table
Message-ID: <20261023041847.16b8b660@jic23-hlaptop>
In-Reply-To: <20261022-first-patch-v4-2-90b2fc6e8e28@mycroftmind.com>
References: <20261022-first-patch-v4-0-90b2fc6e8e28@mycroftmind.com>
	<20261022-first-patch-v4-2-90b2fc6e8e28@mycroftmind.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Oct 2026 20:56:41 +0200
Jan Remes <ciakval@gmail.com> wrote:

> From: Jan Remes <jan.remes@mycroftmind.com>
> 
> Add an I2C ID table so that driver can match devices assigned via sysfs
> or through board info.
> 
> Signed-off-by: Jan Remes <jan.remes@mycroftmind.com>
This one is independent enough to queue now so applied to the
testing branch of iio.git. I think the other two need to wait for
the fix to work it's way to upstream.

J

> ---
>  drivers/iio/light/tsl2591.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
> index f56d31404c25..8cfce720efb9 100644
> --- a/drivers/iio/light/tsl2591.c
> +++ b/drivers/iio/light/tsl2591.c
> @@ -1149,7 +1149,14 @@ static const struct of_device_id tsl2591_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, tsl2591_of_match);
>  
> +static const struct i2c_device_id tsl2591_id[] = {
> +	{ .name = "tsl2591" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, tsl2591_id);
> +
>  static struct i2c_driver tsl2591_driver = {
> +	.id_table = tsl2591_id,
>  	.driver = {
>  		.name = "tsl2591",
>  		.pm = pm_ptr(&tsl2591_pm_ops),
> 

