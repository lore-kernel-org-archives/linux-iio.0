Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609082D94B0
	for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782668064; cv=none; b=BABmcLTOi2ftVU/yGm/aA8zMUR1ygd88oKWHrA2ZCRzUui6s/U4zFq4z/16FRdL328V+1Bxit5kaZFiSjuuVkmLuYo5BlxbsjgDgwk7vk/pDm/wk/h3ayO3y+NDUf/hJ0VmuhHsmVBYE7mmFTqeFG4PQNzOGH+OaV8kr2+Nqn34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782668064; c=relaxed/simple;
	bh=09qQqVCweaC9dVWudIvU863DvaxZKCbR+wzGTDCknJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IyqR3XxPjTfaBmUNy3XuydkYTO2mdIdB0ErXZzjmx1et2uaxZpIIOjk5eV6IHxZmd7C81F/X1bIa+RplcbKyE4ttF/OrhXJB4iPjblu5F6tgnkfBw4F787gwrO+n4BuYaHv/6o6hJrA66Xt/GjawvT0bQS2kLu/VaVKuQvTi4ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=aEiq2nHt; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="aEiq2nHt"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e9cb0e594bso269553a34.3
        for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 10:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782668061; x=1783272861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IvP5EC4HPkXdnPkEEbC3Vgbr3RX7xQ2s7hFuOh57p+w=;
        b=aEiq2nHtruIAs36argjAXLAQ2Zs2qpELM5zcGghUisCzW08kPoZjn/XnuiIj3La+el
         5VOPwpwsYPxuHJwGlIWOWLpiqydLIAPNF32PQEUNaTzhuq5IVyYyDzzPPA/Cxs/POpyY
         WJamjqYaNNZtfdNvhEk64f3r20SjFiTBaEQiprFqhfUvamFCEzAl3HFKuC/AFB6E8T6b
         B7Cf2Lra+boplDe7+7rY0lVr03BvIF86FIErAvPjKERC08JRKNqu1TrMGnNLYrTYJnQY
         lzbVI5cnnBVIsHTfAsStaPoMOpAB6ICFiivYAsyJomBVVVwV/9+GkfLgTyxfOacHbJTc
         NJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782668061; x=1783272861;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IvP5EC4HPkXdnPkEEbC3Vgbr3RX7xQ2s7hFuOh57p+w=;
        b=DmNU8QZl035L2pSzyLWSvAYlr5dOIgvC7WToSPBLgiBYNSfzzZIcKK1ulQRhYBf57a
         fF7BIiM+yX54CwqkdMccAeT0SWPj4pDXNE1XXdkuKeBLpyfbPWao+1ZjE14r9VV2m+56
         lRztMJmNDGUXCwK3IqOAv8bJkrl6cvYh9WWiZoK2ooGaKd1RwQNczITVcn2Q145ixBtR
         kY32AWl6gn1V71GG0Hx1k4cANGmNWIwnFqRb77AYUSXSbWXrtf2OnAhrK4aNf/OZbA10
         u0MiNhXCxH2NbdorS1yp+HTVqTo8TupT9V9JQT+Xkr0FbME6GpcE1iS5LuY0+4E1L8lq
         UcwQ==
X-Gm-Message-State: AOJu0Yyb96WDsbXXyC7Ir3nduGG4elHGwzoPdeWNcEqlrW2HOFEjn9uc
	jgfgmKx4JXXqNPm9fyu9a0Uyc1/yX//9fKFArDsDYp7txVpANAweN+U44f7gAcNeswo=
X-Gm-Gg: AfdE7cnWmtK68aRXVbl+h9xW540VQty7T7tOrTGwCNpXS9OvYR9+cO86SidTEMRmRGL
	VNJ1jz6wZjpYRahBL3X0dYllZCgrq9GdUqH56tZG0UKGTOSbkGctPTHvX/fo09cida2iaNOczw4
	6PjqG6Vst20uEtvJNaEh4YWbF0LSU3K6bqZzasCo4KtOjI1CM18EN/ghxq575Jqm621eBMBTd+l
	MOtB24JRc87WTjLtuIeWHEP28r0rOFEe04aasJ6DjQ1qaaZRxZ2DiE9t+t8d3CTcCxvpTann0aF
	vDqLp6G6l2/zUSOFU3k+2Ho0kL7dTznXD8mIt39GZ7wgIGfhI0FhxUWA19eqPSljmXlQGgCsBBS
	rftKz3TjTTlNj03iQXAJcsnuUvq/Y+ap0FlQuZpM+3kN5jKDNZlTgpe1e6uTO/h3b9i13d4d80l
	McJF9Rm8ZFUyHi9lb/KfyjJKgeangQutfpKmavNQHoITs6yARnLMpsbH3DeZVH9Ho=
X-Received: by 2002:a05:6830:4998:b0:7e6:f083:130e with SMTP id 46e09a7af769-7e99bfef82bmr13002333a34.4.1782668061288;
        Sun, 28 Jun 2026 10:34:21 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:f242:ecd6:f61e:d764? ([2600:8803:e7e4:500:f242:ecd6:f61e:d764])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9aa7eb558sm6725566a34.24.2026.06.28.10.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 10:34:20 -0700 (PDT)
Message-ID: <3f914030-44e8-4f63-ae72-7fde7d843325@baylibre.com>
Date: Sun, 28 Jun 2026 12:34:20 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] AUXADC driver for the MediaTek mt6323 PMIC
To: rva333@protonmail.com, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Ben Grisdale <bengris32@protonmail.ch>,
 Conor Dooley <conor.dooley@microchip.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20260623-mt6323-adc-v4-0-299680ad3194@protonmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260623-mt6323-adc-v4-0-299680ad3194@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/26 3:16 AM, Roman Vivchar via B4 Relay wrote:
> This series adds support for the 15-bit AUXADC hardware block found on
> the MediaTek mt6323 PMIC.
> 
> The previous version of the series for all AUXADC, EFUSE and thermal
> drivers was split after Krzysztof's comment [1].
> 
> Tested on the MediaTek mt6572 and mt8163 SoCs (Ben), both paired with a
> mt6323.
> 
> [1]: https://lore.kernel.org/linux-mediatek/20260504-mt6323-v1-0-799b58b355ff@protonmail.com/T/#med30fad67a090be35f549231336b2dec295233f6
> 
> Tested-by: Ben Grisdale <bengris32@protonmail.ch> # Amazon Echo Dot (2nd Generation)
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>

