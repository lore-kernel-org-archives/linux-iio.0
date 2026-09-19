Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19FE2EEE76
	for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789824357; cv=none; b=RuX39qPBf50C36pf6M7xTM/8CsdO27tFQunYCsQYopfUtKAGy5N82yDRD/sMWMQNwkDaS9ReDNP6AE6Jax/nMHg18bP9WclW/FLEqwgcjcwh6FwTG6mzAQ1VR6j+0n2kgJ0kd3VeSTK2ACG5hGwfpHATaNOlVTq6dyN22tsf8Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789824357; c=relaxed/simple;
	bh=r3HXOtYX15ksa5Y7XiuBMlOv1mTGOuU0Z7hWlnHyZ2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Rdrw829x7KJaKaVT7/HpcxsGzzmM3pwOMZVWIu0HRJqEYqCEQNOAFlVkTHApP9D/wjOgD19A655tYmpmFXAmGTyH2i3PumesM/iLQCkURLKQUR8cv9JAlHOct5gB6zByBV7oIZ2oe6GzNo0/7bBRBzXTPUiLZrM51LbMS7LTx04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=TDicbROm; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="TDicbROm"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48449f62b93so536026f8f.0
        for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 06:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1789824354; x=1790429154; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uq+PPxMiRAqhAbb6KLB+BVIaIHgARkrWQhfVObJDBT4=;
        b=TDicbROmUzQHu+30xP54hVbFlXmn9GBK6JTDBru65lyHZRnrRS+U+IvBzSEcyaBpm0
         zBaDf/C0aXwXrXmMQeMoXHS5PB+nvO2kbgVYv7UbKehHwMRVS7+IP/T3tn1e5lTgow45
         ZNBftE1N95vU6bXrH5k7U4IGoP6tY+JGD/XBeIfsAxvGLBhaNUYLrPB0N9SEGKtOmJJY
         1YMb29ryTY+Xrx1ZujdDAG2KFeAeZveZSGPC5h1mdYSyvGFWsimwC3JYKMh1c59uWD1k
         51SNghMuz/JjRvJUO1WDZfZZ9++lMEug7cSvDowcaUeqQYoOGFMTP9JMniiyKUXcY5XQ
         6IlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789824354; x=1790429154;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uq+PPxMiRAqhAbb6KLB+BVIaIHgARkrWQhfVObJDBT4=;
        b=lPmNyxJdNPRWO23HyNnPNK9FW8D+zKBt6jgmQRib3T2Xoi37YqaN9fAeqcoA9R4FPH
         R9adjh+48onDwk8tUQYYB+cOpOTblJMXDTibfhzEiMZkjrqwU2xu32pg/JTOJpoXfa3x
         XVBUJQIRJsxqoFvhb4+bR+4hBOT9Ntgwr18KjUp8d6kKBg1ip3ZU+JFtDU4Zfaj3uddf
         JsKlTt3o+ISzODDqtweISEXRSnHCbrK7mGaL3TlZLkgXOJOTUefHgR4k1XeH7PRz/dNA
         cPxSOYpg4Z5SkhLWp9JVCyQDhMNnlHaxA4TycXzTOOaZ67hp4nAZteBNtjWi12seYnuh
         SZ0w==
X-Forwarded-Encrypted: i=1; AKwUvBx8eGJ0njvQq6vKzJ0kVlNFUTvBiSAl430fAQaFLqsvjvUksVVss98rMqzNHf6YF+YA+lueCh4aNxw=@vger.kernel.org
X-Gm-Message-State: AFuF++leFhyqoJ0Cuf+E6hU39m/5q4xHN1FqKfpbvvURMv16i4DKHF6e
	r30m7tMnT6lQH2kwxWSVDd5JF8Gmx14szJ/6nKuj4693XxUAVAJLTAPB0auz/XGRreg=
X-Gm-Gg: AYBFou0BYR/9iYTgFSF3TYRWCTisxgQ49ZmySqVG6Jz8YTLEpktVWc7gjtTKEFdGZrM
	n8QikSUIMODOm56rdRgseAZXFTPGNNsO2tPOsWdlZjDZNUlleQQzVdhMqv12Mb+vIcvluY/tn3P
	0TTuNtigyfIrzXHUtkEoaIOH8XEL8BhwUO1k166yQpRHdyUUfy/3KLuFk7Xs7ke3blSJr2tMtYW
	XocnCj92MjG+srDGobjqM9sqPlWVWTobm84tBE/EbJzix5ctF0iyyBql7CkvDmo6BM2E0F3JZuL
	KYo05J8L3jokUcHFs+WYEwrex34xLfO5cWdWeC1822dSctUcK/qMTNFoMM3C4C/EvYKrl0nJLwx
	KwrUz/aINhl5t6Dhfginh0Dg6lxt3hdhgS7SYCuxt/Jw48Q9HzmZbS+JqmpCdYRCGsEkAFbAany
	u2IJGSzx5u/ytZaHhBolv8Mx9D0nOMKtM71q4/hs5VlXluC4aSh+BraFEbddUJoEJ0PkeY/UFLr
	qKvg15zFhOPkPHM62pU1dxDcPWokcljWeWyP73rCcmZgjHTjFWVXX3Q
X-Received: by 2002:a05:6000:41cb:b0:486:fed6:d7e with SMTP id ffacd0b85a97d-4871db11bbfmr9104336f8f.22.1789824354231;
        Sat, 19 Sep 2026 06:25:54 -0700 (PDT)
Received: from ?IPV6:2a02:2f05:1204:e000:2cf7:c250:64a9:ae77? ([2a02:2f05:1204:e000:2cf7:c250:64a9:ae77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724460898sm6712256f8f.9.2026.09.19.06.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2026 06:25:53 -0700 (PDT)
Message-ID: <e854d8f8-a010-430d-bd29-03726fa6faad@tuxon.dev>
Date: Sat, 19 Sep 2026 16:25:47 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/17] ARM: dts: microchip: sama7d65: Add ADC node
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 ehristev@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, srini@kernel.org, marcelo.schmitt@analog.com,
 radu.sabau@analog.com, joshua.crofts1@gmail.com, jorge.marques@analog.com,
 Jonathan.Santos@analog.com, jishnu.prakash@oss.qualcomm.com,
 antoniu.miclaus@analog.com, duje@dujemihanovic.xyz,
 mazziesaccount@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260806074024.531259-1-varshini.rajendran@microchip.com>
 <20260806074024.531259-13-varshini.rajendran@microchip.com>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260806074024.531259-13-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/6/26 10:40, Varshini Rajendran wrote:
> Add node for the ADC controller in sama7d65 SoC. Add the vddout25 fixed
> regulator node which provides the 2.5V reference voltage for the ADC.
> 
> Signed-off-by: Varshini Rajendran<varshini.rajendran@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
