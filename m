Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5690D342CA7
	for <linux-iio@vger.kernel.org>; Sat,  4 Apr 2026 13:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775310209; cv=none; b=fLCxVdZgMFQu7CanfM3ndowMi7E/TEwsK7ECdRPJ9Kp4szZYfB65HFzUKgh1N0phrC3klw25IojKD0CyBJouaGZvHQ83Cwl3okdsWTMWJivRhFiq71n063cWKKKm8CctyIHPQ7Dj4q35SDmUuK3IXmZyJlGFbYf9ppBK7wSlc9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775310209; c=relaxed/simple;
	bh=SdGycWIOB3BG5dloq4/UyFlmu8kZqSDXiej0RBe+/0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jx5ZYSGX9/MKCKw8u4ICwdJuXwpEq7ltb6vybVQ5Lad/KBa865nRdpujY5c7665nP0k3tNMUwzHGmYSkFu+0pzMkyFWrIvEBeTfTj8Iik8Zyw0mfqq/kLhmIjHausy4kfRglOcgSB3DP+cs2M/jy44IbnrKO8GBr32L0TdxvyHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=B9LA0cOY; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="B9LA0cOY"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-464ba2bb3aeso1656064b6e.1
        for <linux-iio@vger.kernel.org>; Sat, 04 Apr 2026 06:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775310205; x=1775915005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lMIoVmSCmnePN2nBeuOGxTIYxwpaueT16pR92e6ZJEg=;
        b=B9LA0cOYXqxY996In7WHWvbr6Wb9eyBWeumqyVq0DWXJAbWQys2+D8Fi7sF0H7ZXMo
         1TcHNgNyiEokugMKENXs34qJ5v4K4XvmBlkLuXfUIZ1Et53X1WKAMJpSpnMC/qKUGC4S
         kiXSKm0EGX++BKJTLSsBA2oeKtXMZh60CkzMpfKPRFhxkBUlGTqvHlBiWU7irElOCQ2l
         MVUOxhYB3Ihe9iO1EVy5cB91Lnxu0ruHUG0HfGj5azykto0/i0Opd2XyrjKsqdCasvuN
         4TP5tu9SbgiG5ouWlB/lMlbeciSOt321cwnDkstITRfRDGQrvJrPY4rYwkcnY6yO57m/
         qdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775310205; x=1775915005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMIoVmSCmnePN2nBeuOGxTIYxwpaueT16pR92e6ZJEg=;
        b=RLpXaYrKdM1Am3/CBRM3thB3u3Cc2LpgNNce4be/OqWX8mfVY/U6F+DyXg10QQ93xd
         +p4IrZpN1N2262gCVMlr3WPgs9nz/8bGM+FXyPq+sn9kwMnpVYXylSsg1L+o4pCSxVCj
         9Czrm7udVBsOEL6f0co5TmRepNQ0+/OaH7iuCs5OfY2aRP2mSf9WlbmrWXbMJsWwzKTd
         JxMHvVjBgtxH1uL0AHOKmV8YwoBqI5z92joKadX8FXzJ1fMLA/WvhmvMOW72n35Qfrbz
         hur+yACbmZjULZLWftnWR1OQBCC/JQ51A1rWefEyjd2cvCFLOWa2MI59i542raPFWz4C
         3VyA==
X-Forwarded-Encrypted: i=1; AJvYcCWK0lggmFbj/cnWuBXIh1AO0FrPaZqfTBiCQA1kaZU69zVXGP+0YEYr/mLpwTKtCZ7NJVhoSv0w3vg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/hy3RkUfOmBS9twmR0cnaPcprjVf0UHL0aYMARGMk9+ygtVXP
	CcAqW4+SpZmhGKL2TRgmoDdFC8pm1Ynuypzyz/Grhp6Jd3rQbeDmAuzuPYf8nOGDfWc=
X-Gm-Gg: AeBDiesVHdd1fc6/XqQMsbGBkmBiKgVGKVtdqasCl2EdvfXNegPVGt9OME5SgGcNcoe
	0ZfipUjoHvTZR4XVrgPvhUz4EiSqEEbJ6tJlgwZRMasalTc6+7UH5uH3bG2SimlUGHRhTSo4zhR
	uAI6IvGt/lStuA8X6VBMjXT0H8jS6ffjBEf/yXeZXtGfuzQSoH4jTkK1YQb6sEmVGoXJ2nVzFH/
	GJANQh+MAKF37FYLM8I2/X4ljywBm3ryAFYfEQaI6Sg5+Pb3Vo0tPxjg9QexWC15c0Wy3HPEHch
	/OEvaUiRDVhuZRb2PyVN7Y5vSVTwLl++r5QGQ6d8fP5WBzMOyvYq+wfnDM99aEgLz67jpjasl/3
	an+y2hxSH3TfDHvTUvH3cOExsR+PMP1i1qmIvGd+V8q3JJ+QQtMD4N1yZjnWr5Yi8wVWYVyy8ez
	+54Kni3CsoshGZPobjMK07Md5hFNlUP8A43pmNYG41j87KLRTefk0H0LmsTul2K3PYkDJOmqQgy
	w==
X-Received: by 2002:a05:6808:1a21:b0:467:8b7:4a46 with SMTP id 5614622812f47-46f01343bc3mr3240466b6e.9.1775310205076;
        Sat, 04 Apr 2026 06:43:25 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e14e:bcc6:3f95:26eb? ([2600:8803:e7e4:500:e14e:bcc6:3f95:26eb])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46ff2f94b71sm1991698b6e.5.2026.04.04.06.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2026 06:43:24 -0700 (PDT)
Message-ID: <dd0dbadb-604b-4f12-8674-268b7db096fd@baylibre.com>
Date: Sat, 4 Apr 2026 08:43:22 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: add support for Microchip
 MCP48FEB02 to MCP47FEB02
To: Ariana Lazar <ariana.lazar@microchip.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Conor Dooley <conor.dooley@microchip.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260403-mcp47feb02-fix2-v1-0-da60c773550e@microchip.com>
 <20260403-mcp47feb02-fix2-v1-1-da60c773550e@microchip.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260403-mcp47feb02-fix2-v1-1-da60c773550e@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/26 5:50 AM, Ariana Lazar wrote:
> This is the device tree schema for iio driver for Microchip
> MCP48FxBy1/2/4/8 series of buffered voltage output Digital-to-Analog
> Converters with nonvolatile or volatile memory on top of MCP47FEB02.
> The families support up to 8 output channels and have 8-bit, 10-bit or
> 12-bit resolution.
> 

...

>  examples:
>    - |
> @@ -280,7 +398,7 @@ examples:
>  
>          #address-cells = <1>;
>          #size-cells = <0>;
> -        dac@0 {
> +        dac@60 {
>            compatible = "microchip,mcp47feb02";
>            reg = <0>;

Need to change reg to 0x60 also.

>            vdd-supply = <&vdac_vdd>;
> @@ -299,4 +417,29 @@ examples:
>            };
>        };
>      };
