Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF1E43B489
	for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2026 20:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786133747; cv=none; b=iNuJrieTj2BIyzn9hQbrS1wifCpvJDrty/rubopVcewxvKymBinPqBqsy47WHsRCQPX0YzVY6TsqP3oUBNywC61d02Qg+F0m3cbxmV+DDo0wBQn3J49wvX4B0fczxSdla4aQI6n99dhit7AmFAdDQ2M9ngf2a/UmAJFw3sjdkhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786133747; c=relaxed/simple;
	bh=YSXzr2qDW6IB6pgbTnr7HMKxhYbfWr6lHnHoebLKAbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FbHBG5O98/OO70apo4yECQlwfxDox6VZCKGdYPBs+Vpx7P9Pgfil94iJiOgn34KaFyO15XiL5mqeA58FvwOS2p14f4dc+XsZ2n6Vndm5G2z4COh+hV2iAcyEg+iaLqsXsW/me15X/aguRXP7O8xwm4zokWbQdQQOTkxswuwQcfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=LP2e9MyI; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="LP2e9MyI"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7eb42a2f5feso1667419a34.1
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 13:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786133743; x=1786738543; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dpeDkCyTn5YS50r2G03VKYqbjFd7CkwFCzk1kWY72VM=;
        b=LP2e9MyIGG9nIRSUYbrHL05AL8B+ihkTQHqRYm4pSn/5HiQRi7vAnJUIi5FBQQ8NY5
         dc1S95cB+q+V3BJI0v8FkFPUcyAYeLOLMRpyyqrTAvhOqi3WPtz38FH8IyfS07gHQEZX
         /XmJLPDBYRr6UHERnJAve+nRV6e2l2eUt9nkJNjYDfo9QjVkpc0YHIGR/Y4fG1T8CPMl
         PWul1Ux3wvHzEqDgxHpBIfAuTjkm3HnwtLefYB+L5ZnjMyCxTiCKHkVM+Pdq8z2oELhk
         ydNvw+WUiwhh5UDmL0PFO8+bJs0O/XXuX7fo3XXxj6SDq15YV5d+t+xLoeDlLn+AtcSz
         lrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786133743; x=1786738543;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dpeDkCyTn5YS50r2G03VKYqbjFd7CkwFCzk1kWY72VM=;
        b=aLTu7vzf7M5Jo62SSUeJexZiMcvivqPrFaCj2drydrgZ07nr0dOdr9TTgBtP5eKRK6
         lC+ytARrIXrJFW4qp9OwrxUT7pG9NTF34V7lxXY9BQIZYbAbByRqJoNAQftafdaVpWN1
         gQ41lUr1y34qRG2cYZs8NcTxBA0qHdpvDRQK7gL7yZCFbJJdP2ovO+SMAdzMyqQjc3h6
         eUldjrjF/zQ7tvIqX7vBZxfgi4smAMWKj1AkcGiiTSfGNP75CxvmmYjoasYGFhcXTINm
         VdeEfRRjnk/GnpHW1kxzfYJxuKgcfvR6ZUUyxPKTaIGM52zJsb/QuzyPz6WIeLpQexqU
         6rMA==
X-Forwarded-Encrypted: i=1; AHgh+Rp8IZAZHkWRkJZY3JzNIDOMpYQlAv1d9FMX3QFgveb+p0Sw9rsgb9SIOxe68uosAVyJWPTPKz1SrRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW276jvv+izBJjEHFUe/pAgf9WOB4H3RDA83C2vMWOYG3vs2Ra
	8xQBSB1Vvpbf80rFr8LJBmZJUXVXQkFuEXs7aEpO6jAaLx+NM+C0L0yJXKgjUzozj30=
X-Gm-Gg: AR+sD11Fr+cf4Ri6O7CqbFXw3yzwyrZpeeN9TaEwDOCJb993njhRjya/duk2Gy+pSrp
	Du0NrrH46SXwJTFPwgFI0rqT+9KSQYqc//DuhE2gQUPdG5X5YSaE2K+AEnikj4zBX/4lt/7lb5P
	p1QQ+db6gZO+iHzv8Lj2HZX3Lztxxg1KvMyWKvv7YICi1L/MZQvj1PI34a5pDCIij295sxr4hw5
	jHQRtVKLxgCO8RBlkAWoV2qfBt7nByyEtE4+oS7lycNxok5Y07YDvvR73x4IOjcLm+o+9EOUqsE
	D6NiIipVaVjOjMsY+kYdImlfHchYloZwlql96j1AXXm+KuY9L6rOjegvTkGLGI6ZT1Mg+2ZINm/
	mANXHIX/jNuCV855ivlNcrSdt+JYtxd9E5Ii9vIY9nKcZ+EZwH7rOzrS3S3ewmPft+IA5IuoIeD
	mju0EWz4BXslb6J7b4SCWf2TWBzgrgAiUlCjcKUzSJeHOprxyGNgf6/OjOqgB3GUaCZzJXdAGB6
	7n+ybW937a2MqUN2/IhFg0jfax2nq2OlT/C
X-Received: by 2002:a05:6830:828e:b0:7dc:c4ae:a689 with SMTP id 46e09a7af769-7f1e5c13d47mr17747832a34.2.1786133743641;
        Fri, 07 Aug 2026 13:15:43 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b714:88c:313d:dee2? ([2600:8803:e7e4:500:b714:88c:313d:dee2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f35b76ff90sm1889573a34.17.2026.08.07.13.15.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 13:15:43 -0700 (PDT)
Message-ID: <3b0e2254-7806-4828-876a-0faa6e9d7029@baylibre.com>
Date: Fri, 7 Aug 2026 15:15:42 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: ti,ads112c04: Add binding
 for ADS112C04
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Kyle Hsieh <kylehsieh1995@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Mark Brown <broonie@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20260805-ti-ads112c04-driver-v3-0-49f436829e01@gmail.com>
 <20260805-ti-ads112c04-driver-v3-1-49f436829e01@gmail.com>
 <178591106730.3177648.16689407752813401069.robh@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <178591106730.3177648.16689407752813401069.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/26 1:24 AM, Rob Herring (Arm) wrote:
> 
> On Wed, 05 Aug 2026 13:38:20 +0800, Kyle Hsieh wrote:
>> Add device tree binding documentation for Texas Instruments ADS112C04
>> I2C Analog-to-Digital Converters.
>>
>> These devices provide 4-channel, 16-bit delta-sigma ADCs with an I2C
>> interface, programmable gain amplifier (PGA), and data-ready (DRDY)
>> interrupt output.
>>
>> The binding uses child nodes to dynamically define the connected
>> single-ended or differential channels.
>>
>> Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
>> ---
>>  .../devicetree/bindings/iio/adc/ti,ads112c04.yaml  | 146 +++++++++++++++++++++
>>  1 file changed, 146 insertions(+)
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yaml: excitation-channels: missing type definition

I think this is just because base-commit: in the cover letter is wrong.
It is pointing to something shortly after v7.2-rc4.

Make sure that it comes from a branch that includes the required
prerequisites. So either iio/togreg or linux-next.

> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.kernel.org/project/devicetree/patch/20260805-ti-ads112c04-driver-v3-1-49f436829e01@gmail.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

