Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA9C3A6B8D
	for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2026 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786214381; cv=none; b=slwk20dmIrGDXo3D53o3FKXDC1fxtUF/P7u/+JzEGlL04cHYwD4xnJ8Ti7/OkqqenYTwWZBiBS0GaGNNSqwcg5TBoMkURGKBj4VQQYTKSsrFWmScBE2QOZyg9qDzs+xIMiHmOTNv2WAbz1BPceFyGrSVMdeucHQGkU/p2q7ovsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786214381; c=relaxed/simple;
	bh=jSQ0A9K+xnOHZyNT2OndwMSs4ft9/c23YE8mq+yqz8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vx+OTiGWnAOisdMk3ijdXOUBh5uhmWoo57XvEYlIxO68NEEVc0GbIDzFz7PhYLelqKAGtXq4wHq2zVSGdLs1f66vmKX2BxqeJdIztKkbJashLv40CJfOigq5F7h36t9Hr99pRZjeIpshXAtJ0Cfm/LjxcmVt5AWxzb/2BkR7oYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=PRBHkhq+; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="PRBHkhq+"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-451fd21113cso563700fac.1
        for <linux-iio@vger.kernel.org>; Sat, 08 Aug 2026 11:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786214377; x=1786819177; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yzZj/lVPkDVMefq5EaYotjMjnYdA6H3Ey0cDfrm8V/M=;
        b=PRBHkhq+fjME1DJ06HOImXmppsFHIXBkesennVnK+GzQMYGaXxs2mjh/UCcXEWdBIL
         Z1BaWXi9Vyjrf+S5tygjkvN8v9A5Y5xku1LWl3cnvwaBmzq/lmVYzWgHlm/Y5Ob/PJnC
         Q9PlZgROQxHhFwCXNsVOFSWt5bVcimhFmjfIOnxUiAw9IwxB3tfKvu6gOFMeAdSbqRNm
         5uYPAhB1NQNISu/GW6vHkiDIon6QqBITmYpgyphGvBcabsvF+CZME1Uc0/Ka1ekFDYpM
         QGkoJ2d6HlYMi4ekaspS+fSpokT47C6+UM+PjaGvNx3q2IseI3bnT3g47ZZP61gSgGxE
         J7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786214377; x=1786819177;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yzZj/lVPkDVMefq5EaYotjMjnYdA6H3Ey0cDfrm8V/M=;
        b=SQYbBqfWZpLK3gTjQOWUoK17w819nuzwNlEXcoaFS4rkiRuvqjB46/xxYJcDEvyZWl
         TCpJXDtbieHM8xM1Ki0GjEzqrsJ2LRCvsa9CPvM/CYlGKaJ5gtZAYJnilmsvRJqyzOZU
         T00kHKp2acKC1OS+/P5ey54klm1yMgYN7x0QT3sarz+ynSCqwc5qXA237nNoH+V7QVjI
         mzx03Obq7cz6n3+8phToqpCjqRmOKy+P63WfC8PW/6gNQjq/YAzYYSOfFvKi5Pg5IArF
         loeF5xuSwdZwhMLW/7Sm+IC2vgaViSWlmG4NojzcrlQ6hwM5tTnNex6mkPdlDJRgvUZz
         qXcw==
X-Forwarded-Encrypted: i=1; AHgh+RoyKN17MVsxiiWCQXH2eLPkUSrSgHIfuD0oJLd+s091yyXF5rjSyHqAPEDNLevXerpBxFTAhwK/piA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZtSAI+EkwbD5FIkuXYXFfaD1JJyVWec7vOsp/xaEdpRXOMLba
	PTR0LZ3isv01xJvgGKdLstAN8zG4G3BLK7/uBtn9Pzp7hh131ZCihfpvqJeKT86csTKEnZvPrPl
	CLnT/KGk=
X-Gm-Gg: AR+sD12FjMOKyftspK0bLDbhYwVsWg8qZwOK/F+w8nPC4Jp1vb4QoLSoL50AQoQwK3L
	VjCOMtKa76zb/gh7QikPV6qgub4TEY7Srwfa4ew5cuhWFBYgWHh6uIDo+T+s7BFJhOjER8jkp4x
	n2BxKrefzlwPJdIGMY0vOyMguyoxxqA+6TCJKKQ/sg8l76OPIIzcKV1IIZO7bg7P2r1PqgjOK1n
	S9wwtOf2xf+Wl0uWzfLilNd6vPCagLv00L1nSVZwKBfKS61XvZPNhl7uD16Z/bTELVbyZIo6fqi
	uMdpHlfEIE33qFfLnhL8FSwLl6VuHjrZJtNKgpmRtS3bwQ6vuffy87VTgtzw9g6mTixkEnWGSGU
	ShLV1RmDQK5It0GD92Tv9iWSbXVqyooqgd9JzcrKSaZkAZHRrG1lxuSxls3y3XuMIWvgnrKGNmj
	K98Oo9VeXqzVDwKflnYtzIZj9cTh4UevV8DxbU8ilJqqWnBvvBVy5mxY0umM0lDaIGzibCXHRgo
	FRVGr/P02eYQ0juvQmHIjb7y+EgNX9vH01n38A=
X-Received: by 2002:a05:6871:4cc:b0:456:cd41:1492 with SMTP id 586e51a60fabf-45a15d4ae7bmr1682961fac.1.1786214377643;
        Sat, 08 Aug 2026 11:39:37 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:99c2:f16e:201c:3bb5? ([2600:8803:e7e4:500:99c2:f16e:201c:3bb5])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-459f1d793c9sm4702369fac.9.2026.08.08.11.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Aug 2026 11:39:37 -0700 (PDT)
Message-ID: <924736ec-f503-40e4-bb50-450d425eaea8@baylibre.com>
Date: Sat, 8 Aug 2026 13:39:35 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] iio: adc: ti-ads1262: support input chopping
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
 <20260807-ads126x-v3-5-f89925d72792@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260807-ads126x-v3-5-f89925d72792@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/7/26 10:58 PM, Kurt Borja wrote:
> Enable per-channel input chopping via the "input-chopping" property.
> As the device withholds the first conversion in chop mode, single reads
> are taken in CONTINUOUS run mode with a brief start/stop pulse, as
> recommended by the datasheet (Section 9.4.1.2).
> 
Reviewed-by: David Lechner <dlechner@baylibre.com>

