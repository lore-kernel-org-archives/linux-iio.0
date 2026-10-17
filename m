Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543D53AAF5D
	for <linux-iio@vger.kernel.org>; Sat, 17 Oct 2026 05:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792216521; cv=none; b=fwuakM52Evt+wdZcE0QGOE6hdIbRAJrvz77tz2VAevOs61CtfSECXLTTn1rayp4wDmpefBVvtgD3fmAE1YtGKwoyygUWT50Sb81RtH8+aLSloK1EcwCFxFcefdloB6pUhH/TiD9l4gywG8gyomHfQpu/ynR4oSewSDEoR+Gvbvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792216521; c=relaxed/simple;
	bh=4H4PumMFOkWTL8QF40HV7GYJCLyqj2M1mR7XH7UN8l4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O+IaV03F5mAG+TBjN7yZOeGpZNlooqI34NmMcOimaL6z4nf5kJZ7Bkfg6cLXZ6o3AoZbeTJoL5PrMuIE8gjl96lUZ37hvOqTUWpQ6pFtK3VFPBskXzlj7TYQxy6sl/hdUOfXnrJGHDZOhD6wu+Rx/pihO1Fc9YoCzQLgi03RiRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUfnqNsl; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUfnqNsl"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48afbd2c386so195933f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 22:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792216517; x=1792821317; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hyAOm2K0XZGAzKdD2fYYYed+loFddeRK4BJxeSnK+7o=;
        b=kUfnqNslcr1EuMTkiq5jDWkcpDyVNq258StXgmZlxbz7s4wvo8GjtG52NhhxllEgKq
         YMJHOE87hL/hRZTp3IhORgu3f52L1A4FZ3Z2+qRfyvQh5xB0I6QxaxHQlUkxs3c76Ajy
         MiVeacNpRvD8zfk+CzPSxRYgFR7uPzD3nobB3nQy29lGvHCVxBRZpqztBbarpExEvZjh
         7XvtQjfpuFxUvcLpKjN5sb8U5UEjT1k4PhdfRs4BcUgIbxAFufSsdRAahXkOfcanYgwB
         K9UUIl/YfNYQYxQfdvTC2poYnsiyIMt5HFcVjkWj2/7QXTb2vcK3o30XH0r/mZAHWx7U
         pHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792216517; x=1792821317;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hyAOm2K0XZGAzKdD2fYYYed+loFddeRK4BJxeSnK+7o=;
        b=U0aCbHtZJhaU+McoZpTxs68G50ogAiwyjCPy6DNH48u3nIc90mreUEJ8tQljIpW9kQ
         SG7KQ5WC3fuI4tTZBo85AfW0LD5BJzoOxCBINhQ3brcy1VNquTDxUoyfJJLU/jK5VmKn
         KL+OwR3obQlN98YsLVjuTN8bST97b84BTqAz507aj6h7rbIVv0kC8E3Gy9bhxdfiWDpV
         ne/kHqyaUJUBGoTs7UJUAEPcvRHRCdPLOkFAEqjZNfr4JDptLhGtiRCN3qGEXoOtijEH
         Z9YyTeLytB0ur8ApDxU2AeU79/1TILq46uNyCt5vAGxbqZbKenqO6sq/LnAlGDoiBMwP
         kUqQ==
X-Gm-Message-State: AFq9FYJHUO2MEQC2l2nPjh+VewMn5qdZXYrXe6TAYIt4n3DJZWdW4uDj
	hcAZhS/CwR8ZN/1zLrTs2gEAldj7Ra9cJpAeE2ZTvh4RWpYeLnGh6T07
X-Gm-Gg: AYBFou15ZVBe1WfztrzfqXncp9zOf7tDE5J+r11RNjOMEiSqCveERzX5alzN+j5QxFv
	9pz341PsDrqi1539PhpMrg0tEzNB3AefO6oa20i7QEqtf3dULmuJs2PGSx/8uBPNjAKk9BjtQ+S
	WuwHgRhDA0f47rbCuB7S1SOhGPjiQjmKyleV3e2z4jnZJYJiroJCdLcLSF+z00QcYLjBn+mBZxK
	FVDmNFZkl+cV5lbrxrQF9/dlUygCRN4waDyA5Pl7PrjFKCJCAB8B1cjgNFQ2+drKqrXRQxDyJtl
	Jb5Tb8xdGv9t81jJlWZLtm04kxyfl9ntqKEA8d59IkLw8F4xPc2e1M+D2bS9Cc/FSaksa4X/HK4
	xLIv8WnFoAj1JqLexvMcA+Fr2NjxnIbIYOUUV1+0QEMhHea78L1kB3Zo0TgkJHKoabGom2AJtJb
	jUYx8+g3FiKRItkO5rhPftUdb7lLRo06V15/W3XTPRBh4dKbjh2d0u+kpNXmFpNv2lNC7HkYJMC
	RzGaPTLfft8H/jEPt7HhmMStzY12bewMF0ksR1/5hI53vsdSkXVFkoIxPX6yOh4MW7capwQHt5h
	dJkcRWTaFCVMireTugJXfxvip1FPvPb/pm5FnY/OKUkl/pY2ZvnmHA/6F+mYzr3LaBd1UP/noab
	KehA9031pxzY7arTLZqGdc3MXTCC094trsucmO2c/Fm/rBf3inQsva3K6s8eY/BM4rpOW
X-Received: by 2002:a5d:5e8e:0:b0:48e:932:af01 with SMTP id ffacd0b85a97d-48e0932b079mr2213957f8f.31.1792216517468;
        Fri, 16 Oct 2026 22:55:17 -0700 (PDT)
Received: from systembl0wer (109-81-110-61.rct.o2.cz. [109.81.110.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfe4d2321sm10443937f8f.19.2026.10.16.22.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 22:55:17 -0700 (PDT)
Date: Sat, 17 Oct 2026 07:55:13 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux@analog.com>, <jic23@kernel.org>,
 <nuno.sa@analog.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
 <Michael.Hennerich@analog.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
 <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v5 03/15] iio: adc: ad4134: Apply reset recovery wait
 time
Message-ID: <20261017075513.3a959a6a@systembl0wer>
In-Reply-To: <9f6d78d607b2f9a896513535fefa3329d52c4464.1792200021.git.marcelo.schmitt@analog.com>
References: <cover.1792200021.git.marcelo.schmitt@analog.com>
	<9f6d78d607b2f9a896513535fefa3329d52c4464.1792200021.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Oct 2026 22:57:08 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Add a reset recovery wait time to avoid any SPI transfer from running too
> soon during device probe.
> 
> Fixes: e0bc6d7e2584 ("iio: adc: Initial support for AD4134")
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> New patch in v5.
> 
>  drivers/iio/adc/ad4134.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
> index 40b27b01f126..d555874b4959 100644
> --- a/drivers/iio/adc/ad4134.c
> +++ b/drivers/iio/adc/ad4134.c
> @@ -442,6 +442,7 @@ static int ad4134_probe(struct spi_device *spi)
>  		return dev_err_probe(dev, PTR_ERR(rst),
>  				     "failed to get and deassert reset\n");
>  
> +	fsleep(AD4134_RESET_TIME_US);
>  	crc8_populate_msb(ad4134_spi_crc_table, AD4134_SPI_CRC_POLYNOM);
>  
>  	st->regmap = devm_regmap_init(dev, NULL, st, &ad4134_regmap_config);

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
