Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C3D31A065
	for <linux-iio@vger.kernel.org>; Mon,  6 Apr 2026 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775483979; cv=none; b=jaVXKYuRQrBOqvXXd1vcJE5uST/ZjWdbOl7ngNn1gP6jgPr6DJdkkl+xvSjsIlF0qigGt/ZqMqdhKlWCChK2GCH0BGQ6ZzosuJnjlMjodwAetasxQPyGpUG/ON/aP/qKh1JxhOUTN8GpciR1TuN3caXF00sF0LA7VC/vRG4LqLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775483979; c=relaxed/simple;
	bh=aNDOiPoUYaogDOyPJjzo1tvadFAmDnc56pANEy4qgcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C2K1fHSvXFXdYE078S8GVtwLulwREqPmJ5rNnQ6jSsQxW/76aqMo5vB4FYdhmz4kQ6HNeN5X58pXSv/5G7rXTL/5YyJ9M7PrcddU70vR60QsY+8yuYhlEXqMYvynl2a4mhUcv33cfq7afHEzMDlonorRStvpoyCs/sHY8XCHYuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=moFd7wTj; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="moFd7wTj"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-47018d341f8so1540123b6e.3
        for <linux-iio@vger.kernel.org>; Mon, 06 Apr 2026 06:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775483976; x=1776088776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kCi/ffQ5hb85YnIhfegeAyP7smgQQkcrABLKqEm7GPQ=;
        b=moFd7wTjaob3hSIRSJlD1MmZZqIYqxj8CgqkvYEBKdpr7x9GLO1vcIgXIzykZkcRFD
         qhe8vI51t+mmXnhwZLJ81uO4bx5NV3i6iZv4Nr1gYpt7yAMxuV4KFc/3JnUNe5G5l/A8
         51gYbzQ/DdtMU21YbcTrFE+NJ9ic50zKWktY+Aau4dQwtURobrEYkc9PYICNyKaO/F5X
         ccd3kMTIFVlI1jbhtuzDToeFEwnfaOUVqwU60tcmuyGsLIKy+gDw3WwgNS3og7f3mUmq
         Hzw1dzbiz6KKMb4ZKxKXmut4r5it07ZqCBM9rUdPJ8759t2g0edwTa9oG4NXnTesqKdm
         tUYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775483976; x=1776088776;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kCi/ffQ5hb85YnIhfegeAyP7smgQQkcrABLKqEm7GPQ=;
        b=pVr7ChbLwYDT1Uk+2dc/AMeBCylL4AMiscmOcmWXbd2hfIrIAxTvWZOcTEutV1ALcK
         XUjYb0177iNmyifmjxjvr2mg+xTFuy2AbatcSv0CgTdRQZF5JR7X8uhVlsZl603yJJfW
         OJ8dF9DLhuTxldeOPW/QykTY0uAFMcL5mD2e/2B+t/AsCnqfSVoXo2PDUDfxKriLGd9W
         pYtXUGDfCsmCB7X2ruw0Sv9JkcpdBRhdz249Teqay5ozn2/ShNhwrkXOrFb3YQRofDMw
         m+82qpgBqz5aZj6FqeGBfCsRpNIBOR4N0Atl4wyEBl5RABqNMeFBbRbuzl3uM6pG58N0
         ZCTg==
X-Forwarded-Encrypted: i=1; AJvYcCVw+Usdavv+F8Nvnt6fnX7vN6mSiL8Rn5a8UHxdCXweezr/169djcqYpYQfOS/RNNwIyAAOZM7HiaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR/Wc/1qobli30xulOtf6AexrIYTw6ScoLzjXLszZvW+s20kty
	Y7B1YJ+2jmuUp2+mqJfc+r6MeuYAACL9mVdbGE7mGtOKwoGqUio9VSXx+qO24NloFos=
X-Gm-Gg: AeBDietMSi3dr3CwrinbLqIiTtReAc1aXEccglz45Y8fOQkXRl5u1Kv4ili8lTB6jjR
	1N/NSjpo6AQgaNR/Pa4vsKk3run3peqjG4fVepiTURn1ZK/Kd+GiMYcetIOy2cTqkgyNaGZOJwp
	W07bp+kYV+G6wFiBi2OKsSfHz09rM95+NB3RXU/JoGECLEMjTXdqtdMMnXr+0MGOUpmYuHW6i9y
	hXew2t5CazvMnwfER4vcHxUSveGM/r4kjhAvGfHwswEfwWUihQZu3a67+56cS/klXXlBI50oCbV
	JEIuq2llq8q02DWUnoqqMlcWI+18hyvkAMFtGzQvMyTjRimm1lmTy9MBz9ERDYhDtcj7ba2Zm0B
	BCJAXrVBEx6n+IntQFiu1Ih1HhMU6LmrPgNE64vwLlanG3RrQNvbF+5nhipc9u8LIqPIhv4Ml1v
	8ATpAamyfBS1W5JWYaSPnYd4iJ0Fp2APev+5JAYbdwXfIl85e67Qwo9otZ21i6VveFlje+ScI=
X-Received: by 2002:a05:6808:c16e:b0:467:5571:1b0a with SMTP id 5614622812f47-46efb1cf759mr6443287b6e.26.1775483976306;
        Mon, 06 Apr 2026 06:59:36 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:90d7:b13f:c53:8ca3? ([2600:8803:e7e4:500:90d7:b13f:c53:8ca3])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eaf2c7c3sm11358441fac.5.2026.04.06.06.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 06:59:35 -0700 (PDT)
Message-ID: <3c24723f-801c-46a5-9257-910f3c181235@baylibre.com>
Date: Mon, 6 Apr 2026 08:59:34 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: nxp-sar-adc: zero-initialize dma_slave_config
To: Shuvam Pandey <shuvampandey1@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260406095324.99671-1-shuvampandey1@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260406095324.99671-1-shuvampandey1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/6/26 4:53 AM, Shuvam Pandey wrote:
> nxp_sar_adc_start_cyclic_dma() only fills the RX-side members of
> dma_slave_config before passing it to dmaengine_slave_config().
> 
> Zero-initialize the structure so unused members do not contain stack
> garbage. Some DMA engines consult optional dma_slave_config fields, so
> leaving them uninitialized can cause DMA setup failures.
> 
> Fixes: 4434072a893e ("iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms")
> Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
> ---
>  drivers/iio/adc/nxp-sar-adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
> index 9efa883c277d..7d7b5a580167 100644
> --- a/drivers/iio/adc/nxp-sar-adc.c
> +++ b/drivers/iio/adc/nxp-sar-adc.c
> @@ -659,7 +659,7 @@ static void nxp_sar_adc_dma_cb(void *data)
>  static int nxp_sar_adc_start_cyclic_dma(struct iio_dev *indio_dev)
>  {
>  	struct nxp_sar_adc *info = iio_priv(indio_dev);
> -	struct dma_slave_config config;
> +	struct dma_slave_config config = {};

IIO style is to have space between braces.

Wait and see if Jonathan asks for a new version first though
before sending one for trivial changes like that.

>  	struct dma_async_tx_descriptor *desc;
>  	int ret;
>  

Reviewed-by: David Lechner <dlechner@baylibre.com>

