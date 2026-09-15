Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E346F36C582
	for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2026 01:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437191; cv=none; b=gZv3U7tQJfQANo5AN7sGNPvfFdxVaPVXNAgLrI8zn6lZ5zzXA8/44v7iKhJZMObtG1o8MQ5Wlo40ZKbtj1Ho45wyalt+chAwXl+zXzOwMVwqtxo9rWl/sG38mi9sCRNQYp4+EQ113+Gyct1GJP9PvjECPUlpfuG218VWA8e9VNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437191; c=relaxed/simple;
	bh=YLhZ1J4p3EUdKxhsg9iYuJO51jHcBUEBJC612xT7c3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJwIidpZD2J/hSEe42xIYMi6xtVx3C8tofOD6pN/xRnrwBrQYIj0w5pIsgt6TZ3iMhLwpEek12owURB6mIjZuESNvfwI4s97hwsqQfNc9FT5lIeuh+bczIA12Co+Wq3j+UPQp1v7z2oxe104lK48REC0IMgAVu4exnuSbdkAZK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oc5GWSi6; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oc5GWSi6"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-792c4084f91so1558513137.3
        for <linux-iio@vger.kernel.org>; Mon, 14 Sep 2026 18:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789437189; x=1790041989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U4Jx0gqCqlP6JSyM7YNUSbMymSXVv7Wb6Hva9YnJeBQ=;
        b=oc5GWSi6ruZgDn+fmMBFLltiANvq9YrwHR4NcZ5Sut2pjYxdQFpNfSSZo2HfYFMU4V
         51q62O7mAI/E5+1KY25tmuAX39JaDrk1Ioduvdk1jJbpw69hz40r1P0ts8xGJRCK2+jO
         dn2f0CdxgvxxAAUrZG43EM9yDaH6oI4W0LBzayrxz0WqYc8JCjNrVfsRFFZQLxpov+jA
         ++/fB/S6C+Z8uvnG7dVHTxU8TWVizBIWvjNn5ChE302E00AtB/y3PW5XsPbZLZzhf4EA
         uWb6j7QR1f8xCyhQ8S2sEyHURWqjHobSuKagyLvIP0FgoAa8AeEmsNah4ZEiGN5ePt+o
         3Ddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789437189; x=1790041989;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U4Jx0gqCqlP6JSyM7YNUSbMymSXVv7Wb6Hva9YnJeBQ=;
        b=V06XVhRrozt/ZqkD8QbfkcABcgOFgb1IHfBWaokimaArPp344+szkfDfEcXqAG2XXd
         nFJkt0hDglbUunddQKdBJEdje4eVxBl2pIAH5y/TJ/ywLEGZ8MIm8lmINC+KK/ySlWDZ
         Fpk9ynPFuWNJ9Q6PmzshYP8mEq5qK+AR/93LyrPNPOk/V5twBcvw5ffscN1z2EbqgEzL
         nIC9MFOsn7C+kZjBL5SMI1OHB5jHpU/LranEB6HJyL8zDWsN23sllMafY1T9beHG4Qsr
         IminmOvE0NmJpAsFW5GwPEqTk++J7b0eR4bt0WM2bj8LCiwzf4NsYZlolFrmS1k4knAc
         9IJg==
X-Forwarded-Encrypted: i=1; AKwUvBwhdN4oBo92KqGnwkTzSNdNXq+umqQMZeKHe1rh4pPAN7nqU0cQEzNtQutrw9L7RhCn/EvUrfXTLoM=@vger.kernel.org
X-Gm-Message-State: AFuF++md6t+HFj7ukNlA/YUWtxKA++I4o86XEN9n8kWxPylYFrGRtbcL
	GpgzEQfV44O2HtBCpqWN30RWgKoDIqwyo0+xEHTiLx10kfAwQOnLv3mM
X-Gm-Gg: AYBFou0lzuSqsVt8b8vwsmrJJW4B023L1PYGPymKWjLtvu5J9J9+MC3sNHqHXHr7yZP
	EzBXZbYgWKwqDBWleMSg40KZTVUhejJVDL1qT7VI63vap70aWTBL+V5M/B47smdl2YY4WCDOZVV
	IAQSMLHGfaq55SIynLno3BC/pQiSj8zrWUAuXOiGTzaQksnSj7AHTuTiaBSi9YycOn0syECI46K
	UwArwhGxSk5kBG+qr1Voz/cXpzHcJAJWX8WIw7L/aXbxg6RRD+nyGsP1kY16C9joelhCOYO8VnM
	L/7GEsM0M344jS73YWDO+Pqs9MiOzPj6i9cr5kKni0wuF7F0LpV6FNvlQAslqoZ07mDu8z1isji
	0uZZHV7dWUbsjZusBZeixr9pL2g4EQwHNfAAiXpuuuYUVZxv7AMyt+6wO2fWITo/FZBnjIlgg9O
	pw9PCsMDBUVrFCh0lfQFaSjkkbA33iTE4haa+L5zYwVo4hI+PeakccHgMRVh0uFLIuZzOJB1zVV
	0KHaA==
X-Received: by 2002:a05:6102:3a0f:b0:79d:63bb:249b with SMTP id ada2fe7eead31-79d63bb25fbmr1122940137.13.1789437188656;
        Mon, 14 Sep 2026 18:53:08 -0700 (PDT)
Received: from localhost ([2804:30c:96c:bf00:7844:c38c:894:4054])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-982b9fac504sm13361055241.8.2026.09.14.18.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 18:53:07 -0700 (PDT)
Date: Mon, 14 Sep 2026 22:54:07 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: mdshahid03@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] iio: adc: bcm_iproc_adc: convert to devm-managed
 APIs
Message-ID: <aqilP8FSTmrLpqEQ@debian-BULLSEYE-live-builder-AMD64>
References: <20260908172359.30003-1-mdshahid03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908172359.30003-1-mdshahid03@gmail.com>

On 09/08, mdshahid03@gmail.com wrote:
> From: Mohammad Shahid <mdshahid03@gmail.com>
> 
> Changes in v4:
> - Move the ADC enable error-path cleanup simplification into the
>   clock conversion patch.
> - Simplify the ADC devm cleanup action.
> - Restore the blank line after the copyright header.
> 

For the whole series,
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
