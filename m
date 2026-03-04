Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2643845D3
	for <linux-iio@vger.kernel.org>; Wed,  4 Mar 2026 22:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772664834; cv=none; b=k3WEuN+jIRPHWCDJxobdPnPQyP2QvMshylonfN+/cjxR4humf7Q2E1BaxakhZb6o7u3G7evdjHu0DQMzFfF2JiNLB+Bssz8Se6OYb2nTAAHbyL2hlb2bq5AN7HBe5OBMteFs5TiYROgGdGkew7dNbuNN/9eBNlcREmUmO6lLLWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772664834; c=relaxed/simple;
	bh=KgsH7RL+/t75qBFgpOtWwlUS/7lvJy57STviAsEdSrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pE1nSJTD3hnr+vlX9fMRgD8780O+Q35AQlz1YLFJoPyesYIfIwfHjYttz56inLY05njn49XqKheuFRFpcylKHLfgzoc0299bdB/1b9dikLRiBXnqLr7y0yrKSDSpc/oq3SIEBpoJijVm+Z0GbLdrJrtsJT16wD8rY+D06gsFsmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UdxJDJmY; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UdxJDJmY"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-463a0e14b4dso2606328b6e.0
        for <linux-iio@vger.kernel.org>; Wed, 04 Mar 2026 14:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772664832; x=1773269632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d7hoUPZ6OJpBxH+RHqUIwk6AIGVllMPyf3oZmRm458Q=;
        b=UdxJDJmY1P5MjkDvO8GcZ59xJCblhqfGf/Q+43DxnlvyXJgAFsL9bn9hbMm8kMNiQh
         6kXDY+xRDXOAzr/PnifLZAWfkOFk8Zu7GfHUUVMxHY+qZ6lpmbGbVk2EhomGCdpT6e/5
         KvcNGlOcDk4Au2suRx1NWY/bzLsM2BC59zUqZHIfo6qfnAhj9F/AYcsI73tTHu2EqRA1
         m73EOjDckuoSFMWBHH8rUhChvTIqTqXMH5WwBiFAMPEWdhSdtZBii0MCyXgvdaeJ9jV3
         m18o69mDjklMkXmGzEu8W3X8xjLStK3zGEEK+ksqCS+9LkYlvDsgYpl7KmE82AzpRnpO
         GnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772664832; x=1773269632;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d7hoUPZ6OJpBxH+RHqUIwk6AIGVllMPyf3oZmRm458Q=;
        b=Cykscrb/O/69IciEZmhUkFJ9jqN2ns8eCeZ+MIrFktiwAD8KJUX96qawA84aZ45eQ9
         V0nC41BohGFc1PM69pqqyDvvlYDzNrcn6F5R7XeZMKB/s20wpfn7uZuZsRrBcBVYI+tU
         wQMXbp1UMM9dpHHocSej4X4pz2RuovPlM4q4mYj2KyqEAdyDG/BS/mAa/h97ENKWkm20
         /zucoLuBiEaT8R7eN8sq32rmUlg3OZBig2k7x6U7kuOb5uiwSIxYbQTMKRBotHhAi4ki
         Jdy1Pi2+bHQU8LQCWmug4Ui4x8XFuVL2EcceJrJJSHdCP8WKnIKPpBBsj1pUb8OxXtkt
         ES+A==
X-Forwarded-Encrypted: i=1; AJvYcCW2nFqhVvvOY9eShJkMjss3Po64N/pWan74KQaGQhiXZ+YN5ZqMDV1x26SPuwYjb7MjF8asrAXh7U0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ6uKw+FUvnmVfc5dTNEfzBeOu61LuBaAq8JN7XfsQvczHr4MQ
	bPFPTLxNg4TuEjanX0ksnyAo98ElF9uimgLplEt1fzNAlqnE9jrm0cJ0rkhnGZKUftE=
X-Gm-Gg: ATEYQzzoig46Z96oaP1zuTDz9rNSbmN36fSpSuvIRUeXQAUq97UUyyZFOys+Vf06QT0
	5r5fBcnArBJ0ck/x4k/mQrt+tlkv8vdbmHTHKiBPBtAdjSS745uDyM63xR24za0JDispg8f5Pw+
	5s1OOXI5KqstrVhBodim68+O6A9mxIBbm5KmBSpPtRa4FNzLbNsQ3NAi4MZIGOmlRfwZ8PydAif
	s5ldRmWEeFWmrDQ22G3HMqXwfGqMGKzTX0/D5/KRYLL4pU4AcAq9HnO1dIFixlSgiKWhKOZFo+6
	g37j6Aw9iEy5DK9BXSwTbPJsflpkSrX4HJmizmAXHmn5QLCuaEY5G7u/i4RhV0ahQsXzGz8gO/L
	Dkh60TW1+awF8tDtyG/DTUHvNE02D74f69BWpOG6Vk2xZs1iLYJyKPgPndmMNDetcXA1gBPP7Zc
	WJ/DLlQTDkr3tqWGc8xSFpZkwbaWFKO8TTxwn4cBeP3SJeFAOIGB57kTuF6JYDUH5VDH+omZ5bS
	A==
X-Received: by 2002:a05:6808:1391:b0:44d:b72e:ec1a with SMTP id 5614622812f47-4651ace7519mr1948954b6e.45.1772664831633;
        Wed, 04 Mar 2026 14:53:51 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:d719:8353:352f:b2e0? ([2600:8803:e7e4:500:d719:8353:352f:b2e0])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb59b656sm12059893b6e.12.2026.03.04.14.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 14:53:51 -0800 (PST)
Message-ID: <c47ef538-7568-4e6a-9e39-a783bc0d6708@baylibre.com>
Date: Wed, 4 Mar 2026 16:53:50 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/6] iio: tools: Add support for floating-point numbers
 in buffer scan elements
To: Francesco Lavra <flavra@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260304080519.2844101-1-flavra@baylibre.com>
 <20260304080650.2844401-1-flavra@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260304080650.2844401-1-flavra@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/26 2:06 AM, Francesco Lavra wrote:
> A subsequent commit will add floating-point support to the ABI; enhance
> the iio_generic_buffer tool to be able to parse this new data format.
> 
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> ---
>  tools/iio/iio_generic_buffer.c | 56 +++++++++++++++++++++++++++++-----
>  tools/iio/iio_utils.c          |  8 ++---
>  tools/iio/iio_utils.h          |  4 +--
>  3 files changed, 55 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
> index bc82bb6a7a2a..39c13b9ad20b 100644
> --- a/tools/iio/iio_generic_buffer.c
> +++ b/tools/iio/iio_generic_buffer.c
> @@ -89,7 +89,7 @@ static void print1byte(uint8_t input, struct iio_channel_info *info)
>  	 */
>  	input >>= info->shift;
>  	input &= info->mask;
> -	if (info->is_signed) {
> +	if (info->format == 's') {
>  		int8_t val = (int8_t)(input << (8 - info->bits_used)) >>
>  			     (8 - info->bits_used);
>  		printf("%05f ", ((float)val + info->offset) * info->scale);
> @@ -112,12 +112,26 @@ static void print2byte(uint16_t input, struct iio_channel_info *info)
>  	 */
>  	input >>= info->shift;
>  	input &= info->mask;
> -	if (info->is_signed) {
> +	switch (info->format) {
> +	case 's': {
>  		int16_t val = (int16_t)(input << (16 - info->bits_used)) >>
>  			      (16 - info->bits_used);
>  		printf("%05f ", ((float)val + info->offset) * info->scale);
> -	} else {
> +		break;
> +	}
> +	case 'u':
>  		printf("%05f ", ((float)input + info->offset) * info->scale);
> +		break;
> +	case 'f': {
> +		union {
> +			uint16_t u;
> +			__fp16 f;

Do we need to check for compiler support here since this data type might not
be supported on all targets?

Also wondering if _Float16 would be better than __fp16.

> +		} converter;
> +
> +		converter.u = input;
> +		printf("%05f ", ((float)converter.f + info->offset) * info->scale);
> +		break;
> +	}
>  	}
>  }
>  

...

> @@ -46,7 +46,7 @@ struct iio_channel_info {
>  	unsigned shift;
>  	uint64_t mask;
>  	unsigned be;
> -	unsigned is_signed;
> +	unsigned format;

char would be more natural.

>  	unsigned location;
>  };
>  

