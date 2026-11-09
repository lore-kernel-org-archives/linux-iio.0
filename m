Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794216049;
	b=EYVcFjQ3hW1II1oQOuq4YZtT/e1MUrsHprOyNYFUn6q8pw2RRkuANmUVQSmQeNduExX2
	 eBZTUZ8Ws1Xz6dh7OZvtfgS5yRcn7qmfE23bvVMxzOtz/vQnLyInuBFzQmdRovA+lfr1m
	 8VkwfzLZ4kQniuhHMH0yCsRfAAngq82a5eISVdGVcVGmrZgidO+UBJT9YpQ2t9skXAOcn
	 CBLUyKGFfEHbauFJteI8HOwqwkGVvTbajXgufyeGm3SP1sykpT9Bg0vPSlTG6Ow2ZCAeN
	 lwAHrV+8qyrUEa1JEUink8Q3NO74d4NCGYarEqGmA0pdW+Nwdn60wK6z5DJRosj9c9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216049;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ui+dYTVHR6Ir+tYC2uG3/X4Lj+sncsoEcKeeP7yC0jI=;
	b=SUHrkL7d/nWiCB4HIqCUuIoMtC8tqv1tfYTH3yC0oY/qCmXdJC1nH/GItveGEGXhlAbW
	 gY8joS74RopT0qn3QiLUP5vqKX0Kmv8Z69yzJbrxG/JZDTUyRjDRjE8SzArlnvhSQ9SbR
	 StBOZTkzZpQMFGS3Cf04cdNegdXDrHIFaOoPMRGUf49FXJFY/EkEGhfjzLvHgTJFsDWd7
	 3OTeh1KgnheyqFEF8N6miw5pWhAmpL2bxJq4jGjiRhoC8ji7AVbtfI35WnyVe4BeJwG1q
	 S7fJbkpm4FRcL3QQnNuA99bBXxer8PEo1jrbcMd2a3IOBEjck6hbeCiomEHw71j6T5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f1YApqM0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF94C606A31C;
	Mon,  9 Nov 2026 09:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f1YApqM0
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794216048;
	b=YUu9J4Q+MOo7K5BEz3KergN5Gg81j1q9/iuLAUM0Ry7HQkSN4y0VkaTfFOO3KCDtkxWj
	 Xvc0f9vAhFYHY+Y5Et/Nc8t4H65k4rJyxOKfZ54UHb9kAMBymHi6e5KS3eKgUondGkRkH
	 +nxNm0AzNpzNKMOQxbDo8J0PvzSbkTCtmT74lRXl4k28N0UAVZ8WcksiYRDm8mEwfphyt
	 IHw6NeOiJpGN0UPLmXLxXB+BDSfyeDmO3ym/Z7dNYgQ+2Himnsl0dluRDi1mVwZnpGIs3
	 jheAdSMr+q9YgnSQrzizHAcWsGwPzKthByTH88hv4gZxxa5aGOoP5JbOzRKkzuJ3CEQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794216048;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ui+dYTVHR6Ir+tYC2uG3/X4Lj+sncsoEcKeeP7yC0jI=;
	b=dLGTTsu+4QzRbmUz50DZBtZzKRN27CHSAWpd2U+2Gl/e7ucHMVad3ktAYUEnNCijpAQ6
	 1qDcPlBIohL+9EkeQK6KwZNQhLM5QG/xk0vvp8o/MemLX28fNugsjOgTdiCbpRea4Lxqm
	 /V96zLuWTnKbCIi9dfjSixAMHmlfbJ9h1y12CLHRCRpbzBwlnp44ckqtDKfpbQ2TLbJLP
	 lMJn0moVPtmDqL0bEEXNATOVrzZ9iso9LEEBoykkLJlGqWBkU6sJWo01NMQ0bR9OESNi9
	 icYb3O2S1zWGFD772wDtvjWCiCnr70s158/WNoLe8KElo8k9HwZDrveq5mh8HIInVog==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 393721F008A1;
	Mon,  9 Nov 2026 09:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794216048;
	bh=ui+dYTVHR6Ir+tYC2uG3/X4Lj+sncsoEcKeeP7yC0jI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=f1YApqM0NYtPRG1O60XWekUZojkUYVpABbaXZaqw/gXBTXqFZ82PKj4S/mlN3qo9F
	 thZ+/Jedw8etm7VP9xGf6Pg/kV9GKolua6vUo3vbOYzyCiHgvhrpAK6YKm2HVljk1X
	 zwk5QAOkfz9QM5rAxrmeijC8G4TdsMFv6KGBrYPCx+SwriangAv2u3cLBUtyhTOj+k
	 wDyPzo3cEdhutx1Ox/embp4yyJ6T0NKon7EfFvjwBda1QsYZXYjPCGvhSO9+OjllsB
	 YmKf/UvtumxC07EBpUYnHMisd7MvHGr5cY9wS5Bz+0Vf+NY45wG/Ui9GJrdd5z/C8H
	 IUy8baB7UP0ew==
Date: Mon, 9 Nov 2026 10:20:40 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/5] iio: light: gp2ap020a00f: Prepare for chip
 variants
Message-ID: <20261109102040.00004c1a@kernel.org>
In-Reply-To: <20261108-gp2ap030-v2-4-24eaa1b9fe59@kernel.org>
References: <20261108-gp2ap030-v2-0-24eaa1b9fe59@kernel.org>
	<20261108-gp2ap030-v2-4-24eaa1b9fe59@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
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

On Sun, 08 Nov 2026 22:44:02 +0100
Linus Walleij <linusw@kernel.org> wrote:

...

>  static int gp2ap020a00f_probe(struct i2c_client *client)
>  {
> -	const struct i2c_device_id *id = i2c_client_get_device_id(client);
>  	struct device *dev = &client->dev;
>  	struct gp2ap020a00f_data *data;
>  	struct iio_dev *indio_dev;
> @@ -1413,6 +1427,9 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
>  		return -ENOMEM;
>  
>  	data = iio_priv(indio_dev);
> +	data->chip_info = i2c_get_match_data(client);
> +	if (!data->chip_info)
> +		return -EINVAL;

-ENODATA is better.

Otherwise LGTM.

Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts
