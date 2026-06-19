Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D3231F9A4
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781879324; cv=none; b=GzatYVCYdGFfrA4ZHAi+gLT+wt9VKIa9sUJL4/yCcDcL9sgalbsE5UtgHmyPrOVCfPsCcSVtKs+xItjTlnYkl3KE/wV/PrEfspsKOdvYZLirsiOJU2qovmRWnWbzFyDLJHX/W9f0Uhu8htXUHYaWJYj3c4enDDo2h/SHoDe6SJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781879324; c=relaxed/simple;
	bh=BYZvNYrhCRRVi7+9/Vp1XV84hbYw0obk8I3Nq/z0MdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sdOC+srMXiNuYLCub9PwQsxLt/3OwFd3p1orBfhFimuklJn6A4XbY9chJvXORyGpz30l+RAyMTtGnnp5x+3B26m5PpC/GWAI8VeTeJC2rpPB0HuPnlGssFPp7n2kpkmdKTeRuwGONRMW6dsNe4f9iLXoMvcEMWIGoZHgQxjXn/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=bDH130/O; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="bDH130/O"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-43f1f2b82c6so1435865fac.3
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 07:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781879322; x=1782484122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gAirWMVH8yFynNlBYDyfsHiH9Wt1aHuKQoVM4l8pDRo=;
        b=bDH130/OOtVS/8nqrbTaAIg6pXo2FYsspJ+cya7o+JKeQzfBjQQ2GKS3izm0Y/vQX/
         M9jmYc31Hvq7O59WwwcMcNgNNq4eWwMGL2oAKJlz1plDMCmLgbvXdbbY+wHf80z+yoNh
         xpA2qU4IhlAnGZVFI0hFJlSOAF2ATYsWa+aNojcMIDi42DgE99WQBAvBotir9esF6RHF
         MwbOK760DWXjkr/qHbUua29zn03O70WqVSWhbvfAlz+bo8Rknjy//wgD38TNvAjYmary
         +cJnus+ZV5EokUQavuiugxyXi9i5zcTxrlnScawreJngCqewknJSkKglX6nJm89LK5Tu
         WCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781879322; x=1782484122;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gAirWMVH8yFynNlBYDyfsHiH9Wt1aHuKQoVM4l8pDRo=;
        b=rXRuZNQvSe9M2zt28omlPqTIil+9FMwV2vFU9+j+J4LouY4WVYJbUXWGuvmIHNzHxe
         hZFz+wtpIgk7DhKtwppukncoOEL8XO47fdxIkUrz1NMpm+owFiHfoMVAKaPWbpvF3DQo
         2xMcsx6ieTpqYQOm1L0Ym4CwvLZwc1+kANc2n2mpXOwCmoQmn2YaVMq3F5l3EQ1vpQb3
         fhnr53NlA7Mu2gL+DjaeoYVmE85DZp20xzm3rS+406uy19CtekDDQD0VE98hF2O0WfKS
         ayrqSi1+xpKhZ/2A/ObEyxAwRF1mCVj+25cPVGCQBb+HjVLHwJDqpq2JuAfdPg2fKHmE
         Ew3w==
X-Forwarded-Encrypted: i=1; AFNElJ/JxZMXg0KdndgerWgqv72vqkCI9wCy1BKkUts8UgKlkA/jmsQOKUGTso3WJDR52v60fkShhscfxcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzQ+7BUHdAece9AKq/1/M+CcQ396Yty19iDdqMRh8yb2nwbbY0
	q1euizu1ehxjzE0WWAJrwUmcW+79uR+Gj4uWi3GF39LuMD1f8CrYNGBtAIwgNbsAMFc=
X-Gm-Gg: AfdE7ck9MbgVGhFF1AgUH9s162RbxAkzbXyi1rCxZoIP5lLg1GNao34DXcwHzNG839A
	LhvIzYZqNZN8HzKnCkCVLLJqvXQDK1oE3VDF1fAQrTs4Q6Ob05jOCNR3exbwCyqcl9+7L53+eRs
	uvXLdqYXR256NnPyju07KfP2JQ7RDEQgO7cmt12OrRM8jlP3osWYi7yFZ8T+p/R7pVdYwdjNHNH
	tux13rT6m6blKr6v3uPOQKPKCmzvmy5gTlhuhcGhDgcxCyAN/bhRovFPRuvaSKIlZeo6UBcAeeA
	uxV/C/QLQGd4hVRsDnwOLf72aN/OLVguOitiFwuHcFKWCEnq8ZyissZ2wQdXvGtAld8PihTbodK
	sYzhbmlKbWkejYcbD3D5fTEOnnbEvFDennw4f21z7uBrGktFCV71IdSMOS2pfPo7G5ySJ/LkOg6
	NaWh6GvWqstl88hAilsaqo2Ql7xLRGjQBuHqfllTfez6YqxsxVr6lmA9hceQ==
X-Received: by 2002:a05:6820:134a:b0:696:1a85:586b with SMTP id 006d021491bc7-6a0d8cd4635mr2866882eaf.35.1781879321803;
        Fri, 19 Jun 2026 07:28:41 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:dd8:d93b:3cde:c07? ([2600:8803:e7e4:500:dd8:d93b:3cde:c07])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4470a42d901sm2533106fac.17.2026.06.19.07.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 07:28:41 -0700 (PDT)
Message-ID: <0831356f-76ff-4eed-befa-7a35ffce921d@baylibre.com>
Date: Fri, 19 Jun 2026 09:28:40 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] dt-bindings: iio: adc: Add burn-out current
 properties
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260618-new-channel-props-v1-0-963c1b5cf40a@gmail.com>
 <20260618-new-channel-props-v1-3-963c1b5cf40a@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260618-new-channel-props-v1-3-963c1b5cf40a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/18/26 7:33 PM, Kurt Borja wrote:
> Some ADCs incorporate burn-out current sources that provide current to
> the channel's input pins for open-circuit or short-circuit detection.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adc.yaml | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> index 106b1e317411d5..6b63aac9ac04dd 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> @@ -106,6 +106,20 @@ properties:
>        This array describes the current configuration of the excitation current
>        sources or the single matched current for all sources.
>  
> +  burn-out-current-microamp:
> +    description:
> +      Burn-out current sources provide current to the channel's input pins for
> +      open-circuit or short-circuit detection.
> +
> +  burn-out-current-polarity:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Burn-out current sources provide current to the channel's input pins for
> +      open-circuit or short-circuit detection.
> +    enum:
> +      - pull-up
> +      - pull-down
> +
>  anyOf:
>    - oneOf:
>        - required:
> 

This doesn't really work with chips that just have and enable bit to
enable or disable the feature.
