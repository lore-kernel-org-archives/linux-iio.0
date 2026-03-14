Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094FB37F73C
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 19:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773518033; cv=none; b=CRp549ZjyzYnaRQlN841bepPLjz7vHknW8eQ4K3WYwqqXD6l/R9EowR77GHYhODesBBUjK0vKyTFmdJ8EI6E4TTR2y4Wfw0/qv2QXFXSWQNYjpmhXOeCvx9sp1gk2H6ud0uf9yTjW2q3EDgtSPTNENO3Vj1Z+efPvbtQNIMi6Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773518033; c=relaxed/simple;
	bh=WoYBcfnqdXjGLK8p2ATCDv5Clwk3rCl9OK1fQPfrqbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EyB8e6LpeYmf7Y76iLtW39ASnNqGqdScwnTT6/yOzDfaTt8AAg0AF6dDgFR0SnHcajpY/cyQJd/NAaaDh4iqx01B6nNCBTkQDINC6eaxgKhPy8D2j3ZPOxPuOnuBOYisKEP8Yzms0M3dzJjyYlY2/VZTm2fFtPxhpdQikrrIDaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=phCg3G4U; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="phCg3G4U"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-4170e916d77so1045674fac.1
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 12:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773518031; x=1774122831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jAUWUxgIJbO5o3ZCocsIhLG9qA3mcb6cANaDC/wIQ9Q=;
        b=phCg3G4UpLjTDCiRn9Kfgzoxih14sZ5+A46wkuduGbAUTVGGLJioPsmvFndMoCGiMC
         5F72fHgNzPfMvaOYwbWPQF8Cb1hItKBp8s5bRB9tc4xzsRHP71pt1kUW7QxtT22UwJZL
         KzpaqbLAuNPt9lsQ9JjpzsabOqz3Tf7ZHF10Bvx6ayJdVxSCCiLwMGu6pCpLgQP8fdGR
         cQOkocPaO5DOzZ5eDlzz/jPXcKPFU8wL8fT4uVNcazviiCTFF0wMK0NwIacOHa+W1W4m
         w1KjV0cWB59E2z6g6Cy17EOGkCEVcp94RRmC0IfU2i+Hx+NOYu9fIv2tVe+RTNtekcd1
         r04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773518031; x=1774122831;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAUWUxgIJbO5o3ZCocsIhLG9qA3mcb6cANaDC/wIQ9Q=;
        b=mH2bNgzPcp0LS2gcLvVbDidzSro+bxo6Of6gVAj7cgyA/DxB9DEiqIsZJ+wD5auDjK
         zwA7wlF48XumLkZi0BF5NMnramyq3AomC3x3LVOz2avoPDsnibK8KppJPT0s94agb9Qb
         cBQf3RyQRhhpgD2/qAlMIfi2YORpgIBhaPmRHpbO4X+SiNCOM4QIcrCzjaVcDB4QAXeS
         mycJKNoDKFA8mEPepGsC4z8D05W5t3xII0A7ycilt3NuBHCe9BbKeYDkTqdO5fi/ZQsb
         4Ut7NZa4nYMqWbgW2e4yD/u/OrvJ1lTMI76b6DtM3jrdOFwSy1EAHahrZJDFc/xpeJCl
         KClw==
X-Gm-Message-State: AOJu0YxPUGZGAhdyIk9e1VX1ucN8i8nnvh5pAzDJlGJosvQi7mc1PPXU
	6KGX4/a730mk+FN3A8HvXKEivbwES1Hein51CWW8jitXWmxBowW9XzoKAdYYswcLknY=
X-Gm-Gg: ATEYQzysQnOJdGsUBXzxJZWI/w4bqG8mFTwJBDOU7TCFg9qNDjVpvrQxMAsrpjdUVTM
	3Od3zEJK2vkoWuyYN59C6AfhRHZT3tVinKzqsgKboGfAZmwljUAGIrhwFCNv0wg0pD0MjKfsTR3
	MN9XRi4hR/6eX3r9d+JlEa+eXqh6Bv8u9i/smryYhIpt9B0yjBcvProZKQ5dF7/CIQE9n4q4KB0
	jEIU+GryRoPVHP+zLOkyqZAq9bil4ACviFqMC0TkO6+/4PZGgisCSmKcCIBJ8mRH20v2j/v5ios
	NKSCF4bw6ZrIEI0kKFJx/L6jMMLx5NLPgGbwDQT4mEn3Z7hpiLA6MQZjNYsuc8Rf/cP+fg6fRZY
	PnYmpv11Rg/xI+TTOV4jb51dlnx9FJ/Em5uRXOfzKyOuGQqzZEOX1qW2cb0RhspdyeI7IzPWBlb
	2Q57/DvGx2cdwtYnFbxXv5YR18Xvt1wZ+bU8AvZgzajMfRZ1r0+YmQ9kGpWB2ReszoXoa2Iy/ZE
	oJYOsfyAJUJ
X-Received: by 2002:a05:6870:d8c:b0:404:33e1:3cc2 with SMTP id 586e51a60fabf-417b91b2c8fmr4441451fac.13.1773518030913;
        Sat, 14 Mar 2026 12:53:50 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:14a9:db6c:e65a:4287? ([2600:8803:e7e4:500:14a9:db6c:e65a:4287])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e64a931sm12099255fac.14.2026.03.14.12.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2026 12:53:49 -0700 (PDT)
Message-ID: <cb92bb47-9078-475d-b242-71e3f9181a72@baylibre.com>
Date: Sat, 14 Mar 2026 14:53:47 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] iio: light: vcnl4000: add regulator support
To: Erikas Bitovtas <xerikasxx@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, Raymond Hackley <raymondhackley@protonmail.com>
References: <20260314-vcnl4000-regulators-v3-0-3c4a48d30676@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260314-vcnl4000-regulators-v3-0-3c4a48d30676@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/26 11:06 AM, Erikas Bitovtas wrote:
> This patch series introduces support for voltage supply, I2C and cathode
> regulators. This fixes an issue where if a regulator is shared between
> the proximity sensor and some other device, and the other device is
> powered off, the proximity sensor would be powered off as well.
> 
> One of the commits includes a Reported-by: tag without a Closes: tag -
> the report was done outside of LKML.

If it is on the public web, we can still add a link. You can just reply
to that patch with the tag (if there is one) and it will get picked up.

> 
> Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>

