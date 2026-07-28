Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071AD3914E5
	for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 16:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785257687; cv=none; b=DpaiVVFIB9e9pKGq3n5tgUm7pQnBfX2+Nw9cuDQIp2pSdq9+0l4KmMBm+uTEXX2ylaNEZnAVlqoXEnEsk0VY7YymDIVXLQ34cl4FY6J/fnsvCrfjfxPoPez06L+7DiMsn9Dxxt56d0FQgeq6WQJlc3WK1aV2di2FhHOQ9iKzEFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785257687; c=relaxed/simple;
	bh=jhSuL7gt9VIpF/6X00TJsqok9yskPwKTngvmyB336xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRp55ODMhwgVkqrhmIx0GgaiHZtBiMPb6zhd3RGSwzUf1xxDposEMFa7yCgrjdJfCrErMOkn+6GYWb3M5cMp5O9X1v2Ug/LyC3aJtodvR5vC4Xf1ARXbN7dpf6AS1YPhZev87iHQO2e495FKQGjaYvFSgji4J9ltCZ1AHG6+3RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9BEWwb9; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9BEWwb9"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47de0093c42so75905f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 09:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785257682; x=1785862482; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lW1gGRbXyp32cWc8RnOmCHBS0mWa+Js0uD7RvlhagQk=;
        b=L9BEWwb9mNi3QHRZxtd7JNr4cvX7ydc+N+epqEtJSvddyzuWq8fcOlUSDFU7GeSXqP
         nPqFi8lDfrqWyOVnsG7M2cibJmeYqDpXfWW13ftLfEUmb+r/VKKf1WXwQrw6qg2SRBNo
         Zp34ZR5WXKIMESAoNhMw+f+jTJs39Pr6pT7WlcIrqiU/kAxJoIKp+B/lunlEYtnkbp8n
         qCVYQyTmNyNoo8MA6PG3wdt2UU+4lG0dd7GpAOaiA/83l9IKDSC7FJw53a8OLDpji2Ah
         WjAKZDeeDA88HpkLh5Pc+hMtnU4xAxOpUMBen0l9E0fHn4Yf4RIyWrylX0T230sMZYmi
         A34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785257682; x=1785862482;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lW1gGRbXyp32cWc8RnOmCHBS0mWa+Js0uD7RvlhagQk=;
        b=MNAPj/awcSHlh9rVUyr8OufO+7pROb046Xlra0ydrGrVzNJvBvkOgES1T0dQgHj9gR
         VreoWSlO+yd1Z0yWWDnnwYLTWZU9BPi2CNPaC2nOSdcX8HgkwTdEpTtJfTUrbPbuNsU3
         UCDXmTZUjjW/tO4TqEZOOhG7ZHc1cH3wLSPtoxeYAqd9G3cWLRN3l4E1cEdFrz44aw3W
         BYNM1p9LD0EH194pm+3bYlgiVgbwbmAx9yYSA/XdKZL7f8TrmjOl3Zpo6A/LpD5SQQKN
         xldbJYPrpr5daNgi7Fn+MzWAaueFJt3jSpP5G4diF6olKLMHhwwFoIZyrq2JX/I2OMlK
         2csw==
X-Forwarded-Encrypted: i=1; AHgh+RoXyY3B7vDbfQXJy6zuu+ErPylDoJJDhg7rbXehF5yaPCFACRb2s0yoCLWxhMV2fycbcRA8yjrhDI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtI8qIg2C0blAnTne3rXOYWMbzK7LO9VK5A/Bi5tQZInAy7TCY
	ckhDzPgYasDwVHvXLi0QyhiRESQ7y1RMpU5Kym91omVSxI6BqDSC3f1d
X-Gm-Gg: AR+sD13NNhFGplxmNoyBveG0VfSqDGHQCdPcOQwOhgv5OdH9C0UcsJEDjBQ6kQDcQkf
	2CJmeBzzJ/BzKTn7pyXnIypugX2QTNN4OZydANJGr775BJEx0E9cd3VnYlUvE8oxfkSlqy9f1m/
	h4MHznaBK/SsLwBPRVp8384gwZfe2n/6XsATMwNMiy4vvitp5U6jeNxZrVd8pmi3YHO7ra/vyof
	hZIBpMdfjKMT3/4gsTEue3J06XtepfwmJn3M4crXgCXxwX7OnBeu+AX+eGNnG2GrDx4xuwhmJBc
	43952GUWzUK+z9vlF5JeAe2ZZH12G7ENbERttCdlmHZ8qIj6SAjosTRwnY2n5hc9WUWPU/b66TY
	3cgxiW4WpIoBWOgKuzH14AaF5wN+UttEZrG+RWnjeF9Ww0oW8FSOkkn/aVZpwNyZGbpsUbw==
X-Received: by 2002:a05:6000:471b:b0:47f:90a4:ff41 with SMTP id ffacd0b85a97d-47fb1ebbdf8mr3941679f8f.58.1785257682051;
        Tue, 28 Jul 2026 09:54:42 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6aa3a88sm495883f8f.6.2026.07.28.09.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 09:54:41 -0700 (PDT)
Date: Tue, 28 Jul 2026 17:55:50 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, 
	Marius Cristea <marius.cristea@microchip.com>, Marcus Folkesson <marcus.folkesson@gmail.com>, 
	Kent Gustavsson <kent@minoris.se>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Janani Sunil <jan.sun97@gmail.com>, 
	linux-spi@vger.kernel.org, Kent Gustavsson <nedo80@gmail.com>
Subject: Re: [PATCH v7 1/7] spi: dt-bindings: Add spi-device-addr peripheral
 property
Message-ID: <amjfAV5HvcIxOdv_@nsa>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
 <20260722-ad5529r-driver-v7-1-7781cd74ad75@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260722-ad5529r-driver-v7-1-7781cd74ad75@analog.com>

On Wed, Jul 22, 2026 at 09:54:13AM +0200, Janani Sunil wrote:
> Some SPI devices support sharing a single chip select across multiple
> physical chips by encoding a device address in the SPI frame itself.
> Add the generic spi-device-addr property for describing these hardware
> addresses. The property is placed on the SPI peripheral node and may
> contain multiple addresses.
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> ---

Acked-by: Nuno Sá <nuno.sa@analog.com>

>  Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> index 880a9f624566..b59d047cf117 100644
> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> @@ -142,6 +142,13 @@ properties:
>      minItems: 2
>      maxItems: 4
>  
> +  spi-device-addr:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      Device addresses used when multiple peripherals share a single chip
> +      select. The array allows one logical peripheral to comprise multiple
> +      physical devices, with one address per device.
> +
>    st,spi-midi-ns:
>      deprecated: true
>      description: |
> 
> -- 
> 2.43.0
> 
