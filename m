Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5025313539
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776439606; cv=none; b=d9FonL4UmuDVl3ngafvDI7ArYStajF2Wjfk0RGJu/tn41ieXnoUHhPI7mN17r9gpHkc/2Mxj3MpoBMQVLc4sHr4xPr0WT18RVEnugEO0Xb0cic/sGLkv3OzYrP6PSeo5mRWMEqtQf6cWqQBPqIm8Blu2PbH+2i6m3/n7l984zXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776439606; c=relaxed/simple;
	bh=8xZLHQa61+Ivb1WiPiCAAgPj2mnS+qCO84XViConO10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rdMZiruL8XHAczcm24OS9RBxLMCwa9P43AKd3kisaspOByHE70U0Zd1X3TEEKxTqt5PKm2Yxmn8JF5HfEMjdTO8qtRYR/36koWdJzVZn598XrZ8XQeD7KPI4swLR9qdfvR8/ZZOprX9iMdyNl9+AUDQDCuGkPmpXNKzd3Avzv8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=E9eZamUr; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="E9eZamUr"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-68244d317e5so496783eaf.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 08:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776439604; x=1777044404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q4h9F4+veahZHv6ouokvBNavgYCSXgwqEuSCU+Mrc2c=;
        b=E9eZamUrDl5gtmoYhGXz23M327RW71mlW6tpmQDsfkXO0RpNhzf414JhXys0S/mDlQ
         wkHdsMohyrdtki/oA7VHAGqAeU4z4ZqoLpVIQux0KwqMcUvHjvaUn/qWejBbR62FV7f5
         hqNO6lJaU0wth8rN0qaCzgyw7nPMNb72fRDF0wPtkaC4TM2txlMGhNLWJO3tXr0rYZGX
         ZWFwXponVciR5vVnODC9OSxrY7skdOIanRmnVWLI0l0kq8QM21VDmCnTfCTGheDI7r82
         el4CHhzVvmiACwZx/lFeyL+U9aSgq2Q0p09U5bNDRNFDkncCMkQVM94V4rigWSxU4mKA
         YjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776439604; x=1777044404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q4h9F4+veahZHv6ouokvBNavgYCSXgwqEuSCU+Mrc2c=;
        b=kKGzP1Jit9TfoCHEAOLjLnzgBAF3p+wcfmigBynO3TqW4LTKoUEpqsduP/ccNvDPHS
         ni3g4UBbgcTrva5S3Vv9tBvD3RBCMoiQiQ+UELWTkD5kHPt0u+xJ6Ca3d5RThBTpQluZ
         zO7RQlfzENzDCe1RugrH2AfcN62gua6ZC/R/JHQTc+QovR4tw5NbjZY/V3DxC529Zl3H
         lXbRmsMBTs0ACxrDUa6wUCK9KiUy4wgdonqeJd9TI4kxRxBdCgy4jmOMFS3VOC4xDaqT
         Qr1kQFrZ4dFZgd9KRKUnkuUzZpfAq1LQsLFwhrQ1g+lgdmyWslPwblSvhhHda1/S/RAt
         R+lg==
X-Forwarded-Encrypted: i=1; AFNElJ91N64yMF6cQsArDkJH5xWIBAHWOsnEaq+2OiCOl828D60aq1YdkSr8IjotIgJXhojgh8VJLmjxTr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws15VTEQKAlefheiktiI6ng84eJ/FG/R3W7G3CSqr9b1kTX84K
	8KjZF0uMkD4cd8r9IWptoUEK3u0Oe+Dxsq0Z3x4k0UUIQnXW5TY3o3trXhDV5Vdn6gM=
X-Gm-Gg: AeBDieu9sqOBHJ1q+Tg0voZdoI/MfNkxCGbkqubvofkq8r17ZMtMgdDcZVNNyVyejXN
	Mv8wWTso9bvsz9MptgWIhUTBU5yDTGeKfZMKL3zAGrQOmJJh8bkicH25uS5zv/bgBO81qhVFmki
	8Td/z0PoLmBwZ0BpahoTE0cxbfvNJ3YMi5wlJdx9YpV8meVqmD+tMDRBNNgV/ojuSbwZRtVTwWe
	Go1k4YhmpxMuF43gawOwWaTmODFe7fxvvH7MkDMxA4Uo7GoxPfTOv9s/cpIMHqLXcRDMQYs9rJi
	S6zba9No4/Uv6SYNLoDrv/gwbuRbVFlKUh2c4TEuKj1TMxKgNAJYgs63KxSV/AOLPFhlqCznMhk
	2HADPyN3dupn1UGKwshcBhPoWOCsgHuCH8L31n0/Twyc6dsMVkgxxy+4bnbRgHz0Xoxs4np/3es
	bE00qcnrwYmsjTr6XdQjdIagLHXFKZSgl8vMar74Yup+hNmB55em7l6K4zg4FmjP01T3X9vuO0y
	Ajx2lg/IA==
X-Received: by 2002:a05:6820:308a:b0:67e:3e99:1289 with SMTP id 006d021491bc7-69462f3572bmr1547103eaf.46.1776439603831;
        Fri, 17 Apr 2026 08:26:43 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:ef27:3314:b886:cd3? ([2600:8803:e7e4:500:ef27:3314:b886:cd3])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69465edde74sm907249eaf.10.2026.04.17.08.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 08:26:43 -0700 (PDT)
Message-ID: <120a34be-bc0d-4202-9996-c5da8cf15963@baylibre.com>
Date: Fri, 17 Apr 2026 10:26:42 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: iio: dac: mcp47feb02: Fix maxItems value
 for reg property
To: Ariana Lazar <ariana.lazar@microchip.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260417-mcp47feb02-fix5-v2-1-6592ea499cce@microchip.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260417-mcp47feb02-fix5-v2-1-6592ea499cce@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/26 8:38 AM, Ariana Lazar wrote:
> Change maxItems value from 8 to 1 for the channel number reg property.

The commit message needs to explain why this is the correct thing to do.

> 
> Fixes: 4ba12d304175 ("dt-bindings: iio: dac: adding support for Microchip MCP47FEB02")
> Link: https://lore.kernel.org/all/20260403-speed-childless-1360de358229@spud/
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> ---
> Changes in v2:
> - keep just maxItems value update in this patch
> - remove Reported-by from commit message
> - Link to v1: https://lore.kernel.org/r/20260416-mcp47feb02-fix5-v1-1-9656c2fed6d2@microchip.com
> ---
>  Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
> index d2466aa6bda2106a8b695347a0edf38462294d03..f2efa0ccbaa32482dcdc69d98c1565518538793f 100644
> --- a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
> @@ -161,8 +161,7 @@ patternProperties:
>      properties:
>        reg:
>          description: The channel number.
> -        minItems: 1
> -        maxItems: 8
> +        maxItems: 1
>  
>        label:
>          description: Unique name to identify which channel this is.
> 
> ---
> base-commit: d2a4ec19d2a2e54c23b5180e939994d3da4a6b91
> change-id: 20260416-mcp47feb02-fix5-26994c5b428c
> 
> Best regards,

