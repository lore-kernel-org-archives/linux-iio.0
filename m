Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E01E3B4EA9
	for <linux-iio@vger.kernel.org>; Sun,  6 Sep 2026 14:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788704157; cv=none; b=HbCdcRRWSPKiADGVkQxJY9hjPk5Qxupg8MDirfhEFhq8yuSLMNMmkMfjvavkhWedE37LtS6fisAdGvyckwyqLf25DNazrp0y8bi52RS+cYhP3asxcSZRdWerGlonvPxfF7sUYwPnbHTuvrJpFI70VR6cR+Tpl68pF12vIeH/Bnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788704157; c=relaxed/simple;
	bh=5z1XyfZy9X2PAxK1/9Yh2cUeXP9XgPJuFrK5ZQ96h4g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WUZFuSAy7pDH0LCH3oz5GukjoHGlcsHlcM/IH836Fg4PCD8J+gbkw9zz+NmoO34GuzwZ8pKkGlaGeOFleYxiAWbkO+ZS1HqE2Aib62MIUec0tIRUk0BgtdQgDzaGp7VbvwNZ9O1XE8BYyM1OZLI/pyq+NB8wlhMCJ80NlHF1XFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODvUZw00; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODvUZw00"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49d036e0e99so5985815e9.1
        for <linux-iio@vger.kernel.org>; Sun, 06 Sep 2026 07:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788704154; x=1789308954; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4kWMuuXK4yTjCPbPm2zu6KDXy0eIRwL1Ztz5775GY5k=;
        b=ODvUZw00KponDPjNPgvAQVWegLbPo47KInx6uaJ6/uVUQboAFY77nRmSw0l7r2fYvv
         M2RiZ97xcXFE5oaytJEbWDU+oXWObrgdKz1j0rQd+LtBa2368Hm0Jqc/9JVYk9X0fRC1
         9cixgplYj7mvGbipDLymn3WGkwnCZdUlJ7VDyDO0VGUdhRgooryBiIzPs4kJTeigXlpC
         l6Rdkqq2cUeF4z9yQwhO1f29ELaMlJlTMq6i6QngbB7LU1RGfkuytziQYw4gItTDtbFt
         8x/MVhrOnifCbO/dS3bCgaqrr7utSW/MoNR/krbvQJzj5wsvUT3bE3hI077I8vLY4l29
         74SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788704154; x=1789308954;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4kWMuuXK4yTjCPbPm2zu6KDXy0eIRwL1Ztz5775GY5k=;
        b=UDaMayLjrwwqn3T6dM4J4j3p3SSW5XKZxDR5J+6o0hzksTq2MJN2HSVdj8tyKklkw6
         pTdYfavki6MlBluSRNVOINqQWsRT1QLbYW/QU9laGlUOmWUh6xJVOw5BTuJtvO+9SBqH
         xSRToAzPWH2TiwSQt+O5GBjJs8V7R7bbmG9HemQ7ziGbhjUsvY6TYUknTP9oe5l5KeCH
         bSBLF5o6AUQdQYv3jTNsZ0r0Du4Ef8Uo9TuDFbh1YzVqoTfRPdr3R7Z+rI0qfqC3vxCW
         vZ9ucjxRV800bCN18k/umy+pLSgwR2pyLDIo/W6nnBwfCKJWDJkQE+Pwk9Ohr2CKm9cp
         EFRQ==
X-Forwarded-Encrypted: i=1; AKwUvBw/qOe4VCoI7MAGE9A5KbvTvDjAlJojcv8ovI/HQTR3/bI7Mkbzs20VpRWsP4RFh+1cJk+1Sz0kpow=@vger.kernel.org
X-Gm-Message-State: AFuF++nbnHy92HopomtNWQ+utY+XKE7kX3NiM+MbQN9GzXUUcDE4G557
	KPnZXDQoouROGj5KbyOKbVrGXQtEu505hTwvlW86lhX6I5kni3X/gLz0
X-Gm-Gg: AYBFou3EN/hVuyeDWFNM5LMu2gs8/MJ+tyxW6YUpKlTe1xA07pekcSM7SgtWDHFAXNb
	+b3u9fXXmGHYrGDYvsaHYjD+01Sv8CXmpxDgY/ZJum4MLUilcrgNrSLLzJsa2X8tRlBYOf4DA/b
	kvP2UhdsW5A6x6HIzv5UlvTsEF2tMqImNQKaUZbRJaI6Wd8hn+8C1y46nnZecMAoziVWbbPknCQ
	W38S6HhTyXcixmy2jrLmIrj7vIstD6WH0t2fkBe0SS57PNjwa8j6EDQANqlkqcVJi8ww8K4cz7J
	1a8AC1WvS1DY97kxzhScE+R2IQ7vy0VqQedga2EE3Ej+QiwQsv+GYZGmmuO3x4CYZlnA7veS6K3
	CkpV9FnKzzm1uVVmVdxF87C55KEa2Vc6cfPXtBjh/06qGZhFdLduzZxKLLeHvcLM8r4QD1phHT3
	UhR0aw6/9+okOPf5AwgHCGpEm9wiViXBRrAf0jnWLCbvet2lnqEACilQzgWl7Ls5bK/boTIAku8
	zADM+5ZCVm0Yf23fM4lbhCCTHgsWIIzIjQVo2UwTlsXdEM2/j2fG/NFt9k4igZb2QjGktmlIZyu
	JODhAOikZ6oQ6q0pzNt5o8rv75ka9xa4H0QvAA5gCtfiuz5E6rgn8LwyRPHTqKHiEmBqgyBOVlL
	Y4Ne/qv4OCokpF+70iYNilcMYvzkpNPgcw5ZE04nOUQtKvQl1aWSwoq80XcSBDdBIqWDJ07Gkn5
	xKQds=
X-Received: by 2002:a05:600c:46d5:b0:49c:fc6c:be06 with SMTP id 5b1f17b1804b1-49cfc6cc142mr141792295e9.29.1788704153980;
        Sun, 06 Sep 2026 07:15:53 -0700 (PDT)
Received: from systembl0wer (78-80-112-223.customers.tmcz.cz. [78.80.112.223])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7740d44sm534138115e9.15.2026.09.06.07.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 07:15:53 -0700 (PDT)
Date: Sun, 6 Sep 2026 16:15:29 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
 linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] staging: iio: adc: ad7816: Use DMA-safe buffer
 for SPI read
Message-ID: <20260906161529.5d2c874e@systembl0wer>
In-Reply-To: <20260906114049.32912-3-abdelnasserhussein11@gmail.com>
References: <20260906114049.32912-1-abdelnasserhussein11@gmail.com>
	<20260906114049.32912-3-abdelnasserhussein11@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  6 Sep 2026 14:40:49 +0300
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index ab80b3a889bb..e14ae805f076 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -52,6 +52,8 @@ struct ad7816_chip_info {
>  	u8  oti_data[AD7816_CS_MAX + 1];
>  	u8  channel_id;	/* 0 always be temperature */
>  	u8  mode;
> +	struct mutex lock; /* protect device state during SPI transfers */

See my 2 replies to the previous patch. This change shouldn't be here.

> +	__be16 rx_buf __aligned(IIO_DMA_MINALIGN);
>  };
>  
>  enum ad7816_type {
> @@ -94,13 +96,13 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
>  
>  	gpiod_set_value(chip->rdwr_pin, 0);
>  	gpiod_set_value(chip->rdwr_pin, 1);
> -	ret = spi_read(spi_dev, &buf, sizeof(*data));

As well as the fact you removed buf in the first patch, causing build
errors.

-- 
Kind regards,
Joshua Crofts
