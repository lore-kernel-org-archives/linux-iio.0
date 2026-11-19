Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795080474;
	b=N89CtD6tRdydoyAd8DEGcGjC330Ojoht35c28hvh6/SEwGcGs/TqC9oTExHs+E8/ZsS8
	 mn7B9VMSmFV9iLRpSFbu2TsK9z5cx12udmB16MoQariRO+OeIsjxDvddEjeqZsRT9vpVe
	 OPD8VZ+4kTTPkCv/c9r4S8ITA9QNC+xtwTu90k0QqhKF7VcOn5qIpIXPt/Dr/mledo+Ud
	 8o18by/QlgwIqxIPnPxEnZbfCcSKB9xUOpej9C22y655jUL+vuXcuiTdYf7HMF5VU/G4g
	 0mDZaFVXQo2T8Hwhg6Yk1W9M7sOu9ZOcb2m7rgRXqbYHOeYYkZz+kIN4c3+NV1/QFFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795080474;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=L9TuTgBV46WPeIv/49f6jn6O879aub+pG2/2NN+M22U=;
	b=sC0dXtdvBVyGJfWcjB/jyfPLmT/HRIHl+qdvusukhyzhV2dyzdeJR1bu/6e6A8ouirqK
	 WtI3eVZlR53yrDi0lWLGeu/mOUQkGZUPf2dzIPMk3Hg968K7XW9PfGOp8Wu8Dyu28rDWj
	 oUX/eO3DIomzBKo3Ep+NyikEnDlFGwpJWsczqox5s3dAqeJlIkXgQSkhvglFtzHLVCjLj
	 p0uj/Nx/5SWjUo+fWKDjhu2xKUaI1ldKk+/Jyq65J7YU5jYr8eeqJVuYG6u2UjgFs5lpx
	 Ua6g1K7WglOuEZqoSgA3z/xLuSM8ZQ1bCi13ZWdbS3Nwb9bMN5WxLC4gbI5jp/ZpIrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mzJ874e7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F79606A320;
	Thu, 19 Nov 2026 09:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mzJ874e7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805C41F000C4;
	Thu, 19 Nov 2026 09:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795080474;
	bh=L9TuTgBV46WPeIv/49f6jn6O879aub+pG2/2NN+M22U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mzJ874e7zZTdjbhwwU/Wjstjf7MatG5CDnNh0Dn/XvRhQI4LntSggthfGljP4TA3x
	 r284FvXBjk4sOlkxxihA6sG3lT+2mQDUl+er8ml96q9inlrc1j8bJlntmPo5HX9yg9
	 TWUxOAJ4N8LH0IPrki6RpOJ2bBVEOIp7OS10UrTHLDpNFYhmUXtpcCM/DNvWNXtrPC
	 ChUFjVzAd6bvRSDNrnuv39mKDRMu7DbKh33HpabpXZzhqMJKd0vlKVMIsdrBhJV7pS
	 QWKE2hx7wzks8E1PT5b9jvLsLIww9QISwcK/b55y0AemJxSJvIrf18yYBJfSbxt4xr
	 2xUKhiP8wV6XA==
Message-ID: <d4a3e229-ddb4-4c01-99b7-672b64cb71c8@kernel.org>
Date: Thu, 19 Nov 2026 10:27:25 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: imu: bmi323: check i2c_transfer() return value
To: Siqi Chen <chensiqi@uniontech.com>, jagathjog1996@gmail.com,
 jic23@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261119070837.3844364-1-chensiqi@uniontech.com>
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <20261119070837.3844364-1-chensiqi@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19-Nov-26 8:08, Siqi Chen wrote:
>  drivers/iio/imu/bmi323/bmi323_i2c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi323/bmi323_i2c.c b/drivers/iio/imu/bmi323/bmi323_i2c.c
> index e025c88c30b4..18f05f119961 100644
> --- a/drivers/iio/imu/bmi323/bmi323_i2c.c
> +++ b/drivers/iio/imu/bmi323/bmi323_i2c.c
> @@ -40,8 +40,8 @@ static int bmi323_regmap_i2c_read(void *context, const void *reg_buf,
>  	msgs[1].flags = priv->i2c->flags | I2C_M_RD;
>  
>  	ret = i2c_transfer(priv->i2c->adapter, msgs, ARRAY_SIZE(msgs));
> -	if (ret < 0)
> -		return -EIO;
> +	if (ret != ARRAY_SIZE(msgs))
> +		return ret < 0 ? ret : -EIO;
Better to do

	if (ret < 0)
		return ret;
	if (ret != ARRAY_SIZE(msgs))
		return -EIO;

It improves readability.

-- 
Kind regards,
Joshua Crofts

