Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D66E46F497
	for <linux-iio@vger.kernel.org>; Mon,  7 Sep 2026 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788794104; cv=none; b=ajqY1iNNSrEG8xi0X3zQjwL1IZzinkjDe9QcfCVnu5IL/QYy+w77jkiU//K9oQzAcnU2OI3w+k93NaoCJoGA68bJs3It/8GmTLNYTMOF3NNEkW6ReZ9DQfHJaZLzRhjb5gZcLFSAjkXA2uhe1lx2mF3ctbgcYky/7Lwk+26KQqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788794104; c=relaxed/simple;
	bh=Hj5U5tuhaGLPE9duWI7mE72tBgu7I2rb+4tWpfLknSE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nfn4u09XXJBg3t8ZtBVNViDFozBGE9CywWavmaAxy9ht+crFGL+AOJM1R9hLMQYi8yFSnVCJL88zj9PY3wEDsEnA0Vvr54Pw0OCRM5Rf4XxM9Hk0R9A8/IgsEyp+DMk+1b34unCcfMq4vD36sX2G8l4CXG8cHavLAQi6hCv2F4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLzModcE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLzModcE"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49a97714f5dso35306075e9.0
        for <linux-iio@vger.kernel.org>; Mon, 07 Sep 2026 08:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788794096; x=1789398896; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2IS/rYcwgewFHdcgCRoRR2IlNUPHyURUtKmUR1+9WG8=;
        b=FLzModcEYThgaeFWNo/5GicWtGtmSfC5OZw0zbi2rtUUdeG8tM+XolK7ngoXxyPLdq
         uvnrCIrYdDebQoXaWDmmZNbjxedLO8lmfEfHVhGil+nKCbObNaAwjZjKyAdHzPsmdgZL
         sS6ugpMZr3hIEax5R8q+EaEQ7OBZ1IPrgXLAlEZRiIS+5hPlzWfP2KuGcUpbC2CvWqbQ
         b4NFsFsVakNLy1M+w2eksSPz2fJvPXfzk6hYX/hx8RIASmrYB4LQaJDq/rH0toOpD5OY
         BjMuzFQ3LaVYc/TadQQyQgEdC2LEU9zfwV3NPr7+K95F3rtq3qL4Yk/zcl7g6Y9uLz4v
         kQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788794096; x=1789398896;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2IS/rYcwgewFHdcgCRoRR2IlNUPHyURUtKmUR1+9WG8=;
        b=X0/nvng7vigrN78KnSuDtHCK1Pe0vgXxtoBs3p9DFCMuS4fb7EdqppMB72yZiNzMFn
         hOseggWgZGKM+8IKXyaRHJDoimAJkKssdK+KlMFUxaCToHDI/bVYwqgDt+COlAUm56Mk
         hMg7WxfqiWbZZ3dEvwqzRC2on2K73VtsUhr6zQhwstNt+sogyxiRoKCc8T80Be2tIPLg
         8tU338c6G5rjaHIHxZyjXhOj+jeFM6oyVFNh6UAaS/FWl23FvXh4O6KEJhmw/XoKImB9
         noIDLze2hOBYqstT0czNxuUFu4Yo7x8WARAIPsAGga+tdFZaX9kAV19CtZRGrxPRB9xg
         76/A==
X-Forwarded-Encrypted: i=1; AKwUvBwoiBPTFDfXAvghPRNUN01EyWN1Yv4YyLOMBfQTeGgFcRgXFkzwGMikkPhq450ktue4v7yywomuD9s=@vger.kernel.org
X-Gm-Message-State: AFuF++mo0+7HaGvUq7Fjq093EpoSMdSbo1x+DexitxUO2VfLQNanmHV1
	/gFEjHFkv/TPoVUZ2lLaJAY9uuD0VEOuuzjDSsPQGBzz1Lc05aqREfjHyY/rXVu5/ew=
X-Gm-Gg: AYBFou1Y/VAa8nRAAiCkADuszvxwiJaC3TlBxfy68kmzjF9lUUxQecKqW+E7EidGhFz
	ADeQgPbimcAsTifpAOsTew5WQwY9PGPVaAJGQic591dNB3VfI0izQx01V1E/EEpAHMmgUj+cXXD
	pCvGtujMdw9PtsyyUvXy4PYKnOL0YjIu5MCybJVQt2l+4YfRuuUOLX2G2iuoBAsdYskvCdLMN0D
	x7LTO9bGaFTQHhUIz/ZEaF73rohL8uUkIogmKO0FY/uZ4PFw7z9EzRhIpya8G3HNROKOcIXbt0p
	gVwd1PVTjCPakWNrRKXiMUawshQYbbajs55vxrhQeuN6Tl4i44rUjuqovS03isyH73PwtbftYew
	BoCRJmA6yMjruiQudhhwqYRvmIwXzRKJkY8huRy2zyv8gbgaU7R6pzEB/2s5R8gU1YRCEN9VDew
	RHTINCPzpb+eVqjGVELJazB+PvBXX58cr4ETeRq/iPxTz1DxrmymKtHU6wtXjgTTt7w07QkSNTi
	ut4BvFIVNxgHr8iOlVRomzbcBRsz/CFk16gUFV1Eql+65d5gJINkCnk3zsl4s6a5K7QSGAUOgsT
	jUXoZKh4l7IrMfjGpbIqIPaPR1bWbDm6+uXpEdLniEnrTtbUAgCaaB0uWATB1dCFwTo9mscJ9rZ
	b2Yuklcs3NI0SuEbtBKCM/tn4RCGzCoF0gMZteuPJblDTa08D3m4mpujV4MZzHfhktHfrdCSrPX
	sz8dCB
X-Received: by 2002:a05:600c:3f08:b0:49c:fa20:cc04 with SMTP id 5b1f17b1804b1-49cfa20cd10mr194873055e9.27.1788794095682;
        Mon, 07 Sep 2026 08:14:55 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf75ce49esm550897855e9.1.2026.09.07.08.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:14:55 -0700 (PDT)
Date: Mon, 7 Sep 2026 17:14:52 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger
 <martink@posteo.de>, Sean Nyekjaer <sean@geanix.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Martin Kepplinger
 <martin.kepplinger@theobroma-systems.com>, Christoph Muellner
 <christoph.muellner@theobroma-systems.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 6/9] iio: accel: mma8452: Add comment block for
 struct mma8452_data
Message-ID: <20260907171452.00004fc8@gmail.com>
In-Reply-To: <20260907-mma8452-open-drain-v8-6-c17407e22118@geanix.com>
References: <20260907-mma8452-open-drain-v8-0-c17407e22118@geanix.com>
	<20260907-mma8452-open-drain-v8-6-c17407e22118@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 07 Sep 2026 16:51:01 +0200
Esben Haabendal <esben@geanix.com> wrote:

> The struct mma8452_data is central for this driver, and it makes sense to
> have a description of the fields in it to make it easier to work with the
> driver.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  drivers/iio/accel/mma8452.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index c6af68d2a297..2c1b97b77bc1 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -104,6 +104,22 @@
>  
>  #define MMA8452_AUTO_SUSPEND_DELAY_MS		2000
>  
> +/**
> + * struct mma8452_data - IIO device private data structure
> + * @client:			the I2C client object
> + * @lock:			mutex for synchronziation of register
> + *				read-modify-write and holding chip in STANDBY
> + *				mode while writing to registers

Perhaps add the word sequences after read-modify-write (that
could be a personal preference though)?

> + * @orientation:		mounting matrix, flipped axis etc

Missing period in etc., but that's a small enough nit :)

> + * @chip_info:			chip specific data
> + * @vdd_reg:			reference to VDD regulator
> + * @vddio_reg:			reference to VDDIO regulator
> + * @buffer:			triggered buffer
> + * @sleep_val:			time in ms to sleep while waiting for drdy
> + * @ctrl_reg1:			CTRL_REG1 register shadow value
> + * @data_cfg:			DATA_CFG register shadow value
> + * @open_drain:			true for irq pin in open-drain mode
> + */
>  struct mma8452_data {
>  	struct i2c_client *client;
>  	struct mutex lock;
> 

Either way, with those added in a new version or fixed up
by Jonathan,

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
