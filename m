Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F827345CC9;
	Wed, 16 Sep 2026 13:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789563690; cv=none; b=ZDpIQeAwbt/2llBoq2M7qAfBqZgrZ9MjZS4pf7qfdw8xqCh9XkLx5A5XGjgxKcS4/LCrwoHwhvoId7xifAY26d7dXNRMac9b5hpLXIhdSIiFbSXbcjd0v2l8wPZN7Df3h97pV5tteXLRKud2sHeGZ179hb+4zAJe33C4bQ5yBU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789563690; c=relaxed/simple;
	bh=BfWXz0hTyEvZDYQuGgOzHryecYGfoukaVueR1V16vZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tyY/WuyUrj4cS7cj8UNls7UkTJCFQbb/rxQzI2DI273PxejKbdxSog/9ivPrFlsHoWVhinNEOVtGKB3ybb/oq68wlEaIDy9n8269ka657zm/TzniU89AfmcSqzEK9zjMrmj71d/5HoqSFNtM3yroqRq3EUWSmAm+LdOGrYYMhug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QK13jFgv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QK13jFgv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1789563687;
	bh=BfWXz0hTyEvZDYQuGgOzHryecYGfoukaVueR1V16vZY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QK13jFgvAS8N5Ui3mQo1fEcCOEI31/YaZ3tSMEP+XqTpzZ5Tsb9ekWH9F8ZwIJZEi
	 90rVcpKWXariDEcFJ5Yu1ThnnTUNBM+p0bcUZvqATr5zhIGDH2FQFlv+9FhKEc2cXs
	 1WxHw45Egm5d/JRIm4imXp7H6n+/wVOZTxWgp/B93my9IHta6yYkhmoM4F5qRce6yB
	 fRRPGi1U35uB+FwT1sK3ZPsudOIDEVFOzYThQG8DhXKVdQqv/Yox8MIac3lN+iJ6Jx
	 Cqq4BIYvev7JgcTxRPudKu47L8pIcb6w9oNvfxOK03MGXbR5jS93RJDJE7jr0+Nx+4
	 Mp98lkomBXUnA==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E07C717E087F;
	Wed, 16 Sep 2026 15:01:26 +0200 (CEST)
Message-ID: <2554743c-1eaf-4799-b64c-4a384f8ea353@collabora.com>
Date: Wed, 16 Sep 2026 15:01:26 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: iio: adc: mediatek,mt2701-auxadc: add mt6572
To: rva333@protonmail.com, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20260916-6572-dt-auxadc-v1-1-e8190d614c33@protonmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260916-6572-dt-auxadc-v1-1-e8190d614c33@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/26 13:42, Roman Vivchar via B4 Relay wrote:
> From: Roman Vivchar <rva333@protonmail.com>
> 
> Add a compatible string for the mt6572 AUXADC, that is compatible with
> mt8173 IP.
> 
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
> index d9e825e5054f..750e1e837fb8 100644
> --- a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
> @@ -38,6 +38,7 @@ properties:
>             - const: mediatek,mt7986-auxadc
>         - items:
>             - enum:
> +              - mediatek,mt6572-auxadc
>                 - mediatek,mt6893-auxadc
>                 - mediatek,mt8183-auxadc
>                 - mediatek,mt8186-auxadc
> 
> ---
> base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
> change-id: 20260814-6572-dt-auxadc-e6df20ab3248
> 
> Best regards,
> --
> Roman Vivchar <rva333@protonmail.com>

