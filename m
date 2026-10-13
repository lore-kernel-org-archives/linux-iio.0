Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D0B551982
	for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 20:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924967; cv=none; b=MyC2BXluz79vsE8wVllxIa02Mhe0+SjIdkST20qASrTN9sIDngvRKa1C80HGdVwYSDIF2S0GVndZXgrG0zccunNRvxmSbI3zKuD3fp8bq3dX+vsx7bVi8kV9oAAb7X+ZX5bzkZVxqqnX3n+uOb+3hvexzPk1t/rq2IvZ68ydfp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924967; c=relaxed/simple;
	bh=3qWH2koItPy/vbViCZzFcKJYSGqpM60iDvtoECll2CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDSpEK16JqF+aMVdMorWl5IK5D+bRxx1SjhpYWssQaPVMb7cvj9CMAjnpF5jbpr+5NhOZCYYG7iYOAlFgpcB8IYC5haLBH21qReU+fCt4kB91aZ2Rby+c7N3s6n+C3Wkpri5ndyti4ZvKDqbTM163jYiBTKq4jzJM3k8S+WLgjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ly0Grsm/; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ly0Grsm/"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5dc2dc6d3fdso1241461e0c.0
        for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 13:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791924965; x=1792529765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6OUQ+zAp4RYn8L595v0XwK+mQR3INz3p6beOnr31+Cc=;
        b=Ly0Grsm/8ftZYQ1MnOEhTnmFCe49RJXFjX4kxrmD9zEUJeLw9ZuD85P91dC3B16XO4
         jaV2ugm4D4pfQ0HbG7qintijVuVpWE4X6gS0izdQmM7erwaTjOV9pJhAE6J9NyjKtLin
         MR4mnLc+qQDCXTgkOYADzKnT3FBXF6lS3I3tcGTbe9/mE1H/v1Ah049meqY+MkzrbjuK
         mIC5CEj9SHDSUyxgi8CNZ0Ki9wuw4dDS2/bIZ+An/Ulj3sA1AgrHBXjST7JPGwm1QyL1
         pPEW4sqfwjlruaTC0oX31JwzQ60XV81fQSAYm6bAw5HT4ghypiD/UNOlm4r+7zSvzopZ
         xMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924965; x=1792529765;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6OUQ+zAp4RYn8L595v0XwK+mQR3INz3p6beOnr31+Cc=;
        b=wiEJQOuUYHWv0X+oDaY4iN4YqSnmZh52KnPIirQ4/VyGgVsvpERfiarcypsod+AqUG
         CDrAWaSTkk747uAsGBENLtNBtqbhU4IdEQt3bTZucZktt/14grRRA4bn8vvT8E2Rs0eO
         51h+oMuZduxTZePiRZugZFw/IJ9PHrilfCeNbBv1CoNO4Byn9IKfOdBMtdoSPTG/VjZi
         hlNj123xAvQ8q9/ldRkU1c0HPcBdiZLEvxShSdaluJ1dZDvpcEYaJUqXjlBZCYsP/U4l
         xbkpKda/x0PlQnEN3GTx2TdutalPahBfyGyfw6w6C4bB9PFRojI6eJ/pYIBmJr9w8P7B
         b/PA==
X-Gm-Message-State: AFq9FYJ7TyRbroHqnn9wcjUdYALpdfGLz6geKry2UIfDP7lyJ1ZUi+V1
	HH/MXXbWaWj+NqGaxzyof4ih/JVx2w/nyEyIKmL3p+euyTRwde6ihmQWCpbeBPaH
X-Gm-Gg: AYBFou0qDypGTKISxPuothy4uH0QSgE/c+1WthxpPW9u+AyOX04FdcJ+FnTixf6+vkJ
	lm+ELzrLrg/2pGPq0auS1K6b2ExZGQQQ+57KJIecHcA22OmWKzjdyApAQkaj+4ihDtXc/ZS5sTd
	e5vE7Am3nNO8L6RMc/cXWTCkZhcUdFuQGTlVUB4dTSggsKdqQ9fJXxyO4A+qFtNG3seDFQhaRCz
	LaXBI80nzjioJWzVAV3HFLRTlyr4rBP9tjuZ7Deo8bLaq0ZTzxCh1EvMXX3RYpHhoxokrfUb0ch
	M7+bOnTCUKiUR4HE2zL1NKqWR8P76VlwM0dbl6HqUW5HFsCleaMgyz+L3lAEjhk1dFVCjrTkLt7
	ZUwlU44H1lO+f5MQ4U3TFdnC6V8IJGaQGo8mZFAKu/lPqC0KJHwNYCi94ewJGgYUR8tK4xr1rWv
	Vtnx0k7gS6J7FGo/bDaEnmlVu8B+fChCT/cQLUnMKSpsmGqEUBMc2yUkpofXwG2IrJwxIfGIKIZ
	GxZ
X-Received: by 2002:a05:6122:ca5:b0:5e3:828a:267d with SMTP id 71dfb90a1353d-5e91f518042mr4469938e0c.15.1791924964615;
        Tue, 13 Oct 2026 13:56:04 -0700 (PDT)
Received: from localhost ([2804:30c:96c:bf00:7844:c38c:894:4054])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5e962a6e2b7sm1842792e0c.8.2026.10.13.13.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:56:01 -0700 (PDT)
Date: Tue, 13 Oct 2026 17:56:21 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, marcelo.schmitt1@gmail.com
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, robh@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 05/13] iio: adc: ad4134: Run shorter transfers when
 CRC is disabled
Message-ID: <as6a9WRxHHav-Nq6@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1791309733.git.marcelo.schmitt@analog.com>
 <e46fd2f9b11ff2b690483bc2ea6489b6d145c773.1791309733.git.marcelo.schmitt@analog.com>
 <sashiko-outbox-162348@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-162348@kernel.org>

On 10/06, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] iio: adc: ad4134: broken SPI read CRC calculation and ignored failures
> - [Medium] iio: adc: missing delay after reset deassertion in probe
> --
> 
> commit 5284b96efc125640c497213951d3fabe580894ec
> Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
> 
> iio: adc: ad4134: Run shorter transfers when CRC is disabled
> 
> This commit conditionally reduces the SPI transfer length when the AD4134
> CRC feature is disabled. It introduces a crc_en flag in the driver state
> to skip the CRC validation check and send fewer bytes when CRC is inactive.
> 
> > diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
> > index a0113fff4b715..85fa16321d744 100644
> > --- a/drivers/iio/adc/ad4134.c
> > +++ b/drivers/iio/adc/ad4134.c
> [ ... ]
> > @@ -232,7 +233,7 @@ static int ad4134_register_read(struct ad4134_state *st, unsigned int reg,
> >  	*val = st->rx_buf[1];
> >  
> >  	/* Check CRC */
> > -	if (st->rx_buf[2] != st->tx_buf[2])
> > +	if (st->crc_en && st->rx_buf[2] != st->tx_buf[2])
> >  		dev_dbg(&st->spi->dev, "reg read CRC check failed\n");
> >  
> >  	return 0;
> 
> [Severity: Medium]
> Does this CRC validation logic reliably verify the read data?

It would require mid-transfer data CRC calculation to properly implement AD4134
CRC feature. That would probably require changes to the SPI core or even more
unusual hacks. Fixing the CRC is not part of this series and I don't want to
extend it further.

...
> > @@ -313,6 +314,7 @@ static int ad4134_min_io_mode_setup(struct ad4134_state *st)
> >  	struct device *dev = &st->spi->dev;
> >  	int ret;
> >  
> > +	st->crc_en = true; /* In minimum I/O mode CRC cannot be disabled */
> >  	st->odr_gpio = devm_gpiod_get(dev, "odr", GPIOD_OUT_LOW);
> 
> [Severity: Medium]
> Does the AD4134 device require a stabilization delay before interacting with it
> over SPI?
> 
> In ad4134_probe(), devm_reset_control_get_optional_exclusive_deasserted() is
> called to deassert the reset line. Execution then proceeds directly to regmap
> initialization and SPI transfers without any hardware stabilization delay:
> 
> 	rst = devm_reset_control_get_optional_exclusive_deasserted(dev, NULL);
> 	if (IS_ERR(rst))
> 		return dev_err_probe(dev, PTR_ERR(rst),
> 				     "failed to get and deassert reset\n");
> 
> 	crc8_populate_msb(ad4134_spi_crc_table, AD4134_SPI_CRC_POLYNOM);
> 
> 	ret = devm_mutex_init(dev, &st->sync_lock);
> 	if (ret)
> 		return ret;
> 
> 	st->regmap = devm_regmap_init(dev, NULL, st, &ad4134_regmap_config);
> 
> Without a delay, could the first SPI transactions during probe drop or return
> invalid data, causing initialization to fail?

Has never been an issue during tests. Though, I guess it's easier to add
fsleep(AD4134_RESET_TIME_US) than to keep replying to bots.
