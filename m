Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ED24A32
	for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789824281; cv=none; b=fBrYdjL07fw5c/IR0gtej0Qwt0bjxmcxzfviRf+lQhNMBGXZEOnFH5TK2y8TKjljB75caS8O7qB1zV3S8pWckuTPmYMFOVxUiThz2Vey6KnsjF7wl4HTapAKPy+f1luUcQ7EUcJakSU5jbhc9B7cv8Bz46vss0JolW96H7eZMoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789824281; c=relaxed/simple;
	bh=We4kQ3+PMqzSMpklzI6gmAx2TCZtf539gHKv2s/cemw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KuBmj+Dq89DE9/9LE6HUfGucGP7HBEZ7thNMV2LRojdaZV64ExS8dUd4lDUrP9MI3cxY+dqOorf3ZfBXahwFWvF6PhEQ6KOkRrARPUkV3biePOBg3tKeY3dvIRhmMLGIce4OmTSmOJkYEr4hTqvm0oCRdsunMR0e4fsp9rQHp2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=a4Fq4ZSF; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="a4Fq4ZSF"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cc9f581c4so6256355e9.0
        for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 06:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1789824278; x=1790429078; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z1fZ6KqR7Gubow5Qyu4FfRMFbkSYpjfYEjbAmpCRKQA=;
        b=a4Fq4ZSF6lWD7ysroqrS9FCd7HJwRGaolwn+ULT2RcwllXYo7DfEwZEOPn5uYs3HqW
         A8UemQ0mm594wz9kW/Zf6My71ZXBd/HUXIjU7s3uFazt4vIhoCKCIz3bBri7GVAQOh6q
         kBTbv56v/rFCOTolH97Z4dSYIulIcw5xBEDCCP9LixHNEkiB/VSx6SrJwzMAhlfQb7QY
         zzbnnFiA+oOoD4n9yG4z63o0wKiS+M2vHj/sxE8YWwH7oHNJQgt/tEmt6gFVqcQh1dQl
         9MJvY7oRXaytOvaL79djt3YGKkm0HakSf27j7KiXNwaNwZbm/IROoozITJAL1CfXUuRT
         1Isw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789824278; x=1790429078;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z1fZ6KqR7Gubow5Qyu4FfRMFbkSYpjfYEjbAmpCRKQA=;
        b=Cp9uevBsiYQ64i5mJNqxG7whGcRg2MHNdSOhXFMEKBvqe5UJSyW4hhYwqRY5z8aDMe
         sCA50zx5PLrGxXdW03rN32NopFNDL0clgTSY9EJ0xc2IJvEbqk2lfarwPB9p5/aT+zu9
         pbuYl5cRZ4BujuVFln2KIvXJfOsb1h0c7xTGoS+9qZpfH+GvFK2zzJk/cJ+/sopGm+9E
         wIb51S6olXjMn5Sb1kFrTYjQu4hPJAKsuR1hJwAKLCUvsyclN+wqQhjxpIch/CLbCjNX
         pzJ93oSoRtSJH9CRpbVlt8zDI5wHCaqO3n5I4x9laLlHZRia7d+lkCktHG/7Awda60Gq
         03yA==
X-Forwarded-Encrypted: i=1; AKwUvBwNt7tGT7luTtqrkQBUFNbPeRVZRdZmreOjjM0jHFkWpt4kVUfUmF69sfJS/UhVbVB4s2SzjIq4y+I=@vger.kernel.org
X-Gm-Message-State: AFuF++nvqbtVzl1K8NPF3wyO872Cw8lPTzRFgD+O6gSizZhyoMqzOZYb
	iuP5zmH4vL1/DfFf2rBnyhS1uUDmsMCWcRv4bWl7uFKTh9gIlNSyVj+P9DrwEzUMTaw=
X-Gm-Gg: AYBFou2DMz04etYV8N4AAZqXCj3vuSH9B6DA1K0ehvMyOzzqrvze7aB4tFj3dhEqbAz
	m7owcutjR1cWYfn2X4+xYIDOxxZ6FcU0aWDzKIjijs3/j0GSvD7KKbrp281l7NyI5LCenS5oY2s
	2x7tDUG7oSgMN32eQWUtBSsd3GFwjb3Lf9tj2euBQ8q9tBMGENovNOZAFZCOa0NovOCMVVt2Dsv
	uXA+PRGFkF2ru6+pDVL1hlqStH3L7TH8+Iv16EtpqPfEG/t6QYiNQHDF/U/LjAKSZC9YSOOuIpI
	1ldVOusJu9z6slcTD3D8d4j6jPHB70l6AcBJBHvnu0iPbnjMspm05NhSJWDq70y6zn/r7UbgqXN
	NUIqX/8fAaCMYTyCbeLQoB1ZHC0uCtr80sdvot0xG8cIluaQBaiuPXBVCzvOjARrLS/jCBMTAiC
	kDt5bi8+5YDRXIyoBk6vwQ3/PH0eVthjHaKtn+2sDKhYH0TbIdRb7FQMk38LPxNsU+uRpQFmciD
	dIAOxbj3e0jSkMerXKDYRgqAmpwjTAnmr29NfX9abWCMZkLgstxEBPr
X-Received: by 2002:a05:600c:4e89:b0:49e:6ca6:d40f with SMTP id 5b1f17b1804b1-49fc4ff40a9mr87364545e9.9.1789824278440;
        Sat, 19 Sep 2026 06:24:38 -0700 (PDT)
Received: from ?IPV6:2a02:2f05:1204:e000:2cf7:c250:64a9:ae77? ([2a02:2f05:1204:e000:2cf7:c250:64a9:ae77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc585920fsm303117955e9.4.2026.09.19.06.24.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2026 06:24:37 -0700 (PDT)
Message-ID: <e23712ef-1515-43a1-8cb0-e88e26505b05@tuxon.dev>
Date: Sat, 19 Sep 2026 16:24:35 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/17] ARM: dts: microchip: sama7d65: add cpu opps
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
 <20260806074024.531259-12-varshini.rajendran@microchip.com>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260806074024.531259-12-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/6/26 10:40, Varshini Rajendran wrote:
> Add CPU OPPs table for SAMA7D65.
> 
> Signed-off-by: Varshini Rajendran<varshini.rajendran@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
