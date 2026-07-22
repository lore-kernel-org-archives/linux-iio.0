Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F7B349B19
	for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 19:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784749633; cv=none; b=M83qdRayg/rfRqd09cq4xEw0yTLlY4jFW/PjbnY02UdxblOGhABuRH1GshfQscteTSkfU/BiFB5G863BBQARKk5rNbXsFTloqouXorMBoJFRDT5mRcIM1vEOUBG/GempGBxlXRRGNHTi46F8E0kBZLVRR/EXm6ons66d8twUWm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784749633; c=relaxed/simple;
	bh=6sv+FiPVq0EsrHhhvuJ6MuEHxA23D5VzY0gov0LBjSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X1vuo42780FoiL7N+Ua+ioZaYdyjPwxxcY35Y7SOJjohQW03D3vvLEUtl+xNfqXAmiA6LyO9LIDWtUYkriEZGGrBOAxcYpGOWeMg9Fho5yFLdXoOG3Dexrmi75N25j0bd3/0zMGUrhB1LGh62QKEEjOnRk4NHs1RRAXQApXQmOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Bn5uNDy+; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Bn5uNDy+"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6a3897109bfso4598368eaf.3
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 12:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784749630; x=1785354430; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=25lW1olxCrNiyANiOxoyrikBwf6oNATnngWHhqIjQZk=;
        b=Bn5uNDy+7ySbp8sTJcnUeyMCdaPSPOITbSW/AHRldu+94tXjLZdl9b0MIqCO3H9CSO
         CGPCLESC1hI3F88Hq3b40ycsAY4DjDut74FxFqGfMnT8DaKUIO2JNqM4M7dc1w5jC3Cn
         F7DssUVRlXxmLX+tofajDKSKOmuOi8+6pSz9oA70LHSXhmf/E5X/k8kWOQroEo5d2V3x
         zzq0X6EEgAHYt6re757RVV2Pw3uptDj4NJkr7CH5NI1OP9zCuM0atV2xdCbhA2GY+AvK
         IOhKm8CPVLWOzkfTjjVfiOgQbhRBL3N9zZUoBf3i8sDqDiT3sZlxawk/qXKCHSAP6QlT
         DT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784749630; x=1785354430;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=25lW1olxCrNiyANiOxoyrikBwf6oNATnngWHhqIjQZk=;
        b=DaKCHgYrPqSFZVURKyuixV7g6GXSUbYl7w0OP4inomUgbbJq+FpXNFTkfP7CgDsWIX
         WBL0o1dKifOleYIW7NggcI81ajGmmNUX1D5eoo+YC0gfGkn6xGuoLQ1snqosml81uyr+
         oteW19zLkZBU3M0u4dKPSNutDEl3V5pqFjbHn5aKh+PNRswRwLXH98ntAcQ1+VzrqDV/
         Tb8EZcv9YhPgJhgb2lOu5mOYiWvi+eWk0usOPOV5yLvlArSI22nP/9JkOs/EAQhE5T4m
         Ss6F2FxgPRLPSnV42ExaQNjF0BuA5M85ue+eXINMCtgP34rFRA/riJqcsQsqfjBlAU/0
         VcMw==
X-Gm-Message-State: AOJu0YwhSmeZF4HmgCowZYMOmP20T5WXYrq/1FGVbtd/Nd/FXbqRBdQe
	hOZ+4Fa9ng2yCBm+va+Ns+SFX4Hd6TrP7HebYrM1dSY0VnsJwudCClCxBm9z9/nfRVYOEbSq3BS
	LUp8l
X-Gm-Gg: AR+sD128Zyod+8+P7O2TCSFdaLIdy+Va9bJUdWjgZDEtimthxUsNyWX0evHJXvJ+pGi
	2DnzQEhoVGlC++kOMVLYPSOLLEJSKa7yzuWSyaCcS2qc3iaMIos0T/H7Qqu7QArdHBfi2Msp7xr
	bqrIZkLqeixxpAEA9Gsrk89S6S7Tn2yWGOd/6pCMwHfASm5ishmUEYojrlyFL9gUjVmcdy3wn2e
	IAsEpk+b3eDdYgBqG8I0ahDWjt3KbHYwGKNNAYXu92JioVgk1+X9J6dsjydKago2dx2QszQSwKM
	HnQJSiNqHWUOAFGNkiIb0EAz0Ps429BNEYg9iuommvOwTYJDHjYiZNB4LuVGkadDpoAB/Rrx7Tf
	oWBjHagC3tD0cTHzTzpPz/y3gLKoIswNotTutNchpKo1bghQ8sy0zVJ2Xzcst38JXJczceeftzt
	JYPGHXdYIPmQXNChF3IGd9Ihkk5OMVwJdx1fsU0/5yJXCV6oyMOA==
X-Received: by 2002:a05:6820:a28b:20b0:6aa:c665:e73c with SMTP id 006d021491bc7-6aac665f3a6mr1085425eaf.71.1784749629880;
        Wed, 22 Jul 2026 12:47:09 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:d067:7d1:556a:2be5? ([2600:8803:e7e4:500:d067:7d1:556a:2be5])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aa76233e99sm2189786eaf.2.2026.07.22.12.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 12:47:09 -0700 (PDT)
Message-ID: <3314a217-5e6c-44cb-af8e-1327c375c4dd@baylibre.com>
Date: Wed, 22 Jul 2026 14:47:08 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: at91_adc: use const char * for DT string
 property
To: Amin GATTOUT <amin.gattout@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260722-master-v1-1-ab0591897e4b@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260722-master-v1-1-ab0591897e4b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/26 2:39 PM, Amin GATTOUT wrote:
> Declare the local variable as const char * and remove the unnecessary cast
> when passing it to of_property_read_string().
> 
> Signed-off-by: Amin GATTOUT <amin.gattout@gmail.com>
> ---
>  drivers/iio/adc/at91_adc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index f610ad729bf3..0ac74ad92fca 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -988,7 +988,7 @@ static int at91_adc_probe(struct platform_device *pdev)
>  	struct iio_dev *idev;
>  	struct at91_adc_state *st;
>  	u32 reg, prop;
> -	char *s;
> +	const char *s;
>  
>  	idev = devm_iio_device_alloc(&pdev->dev, sizeof(struct at91_adc_state));
>  	if (!idev)
> @@ -1023,7 +1023,7 @@ static int at91_adc_probe(struct platform_device *pdev)
>  
>  	st->res = st->caps->high_res_bits;
>  	if (st->caps->low_res_bits &&
> -	    !of_property_read_string(node, "atmel,adc-use-res", (const char **)&s)
> +	    !of_property_read_string(node, "atmel,adc-use-res", &s)
>  	    && !strcmp(s, "lowres"))
>  		st->res = st->caps->low_res_bits;
>  
> 
> ---
> base-commit: 248951ddc14de84de3910f9b13f51491a8cd91df
> change-id: 20260722-master-23179d7c00c4
> 
> Best regards,

Makes sense.

Reviewed-by: David Lechner <dlechner@baylibre.com>

Although perhaps could be simplified instead by using
of_property_match_string().
