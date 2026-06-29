Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92F133EB06
	for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 06:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782715666; cv=none; b=VA37DLaxCmaqtWFT1XKK92x0Bq6/wZKgkql0ZNnj+W/DggJYtawYQv4Zjsrx5ipoqUac4PR1Vd11ELriLA4j5O4Z1DIPVdnQmxQzvGpBXZ9gIKkCHihMSttpB9v21hjuvVYQEkXm3sWVobv0TaZWN+qfjcjQBYIaji1mhzRzJ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782715666; c=relaxed/simple;
	bh=v+qWVRauUjpTMkiJIe9BuToSx5p+cD4V9llEvD9oJl4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=YokWy4hV0qs3TYwo4rvY1nBgLtzNzN5X5N546ATg7JLR+wwNpEpTveYhmAXWvd44nvJM08t9zhVQV2RnPeNwIPkWSqYMDTVjbCql4EPhmnzWe2rVQWBE1wEdDnn+HMxr+lwb2jzNCOaEPApGFKX49/Euycf+ly0PwLq6b/TB+kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1R0e2+t; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1R0e2+t"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-738bd0b7960so445143137.0
        for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 23:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782715664; x=1783320464; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+oe0ICWRfN20FKF1msz77hWxvDcYi0f/X+trcO5BX8=;
        b=H1R0e2+tnbR8pO8OI1J7c1IJknieQWaHHRkkeIWgjOPW00ncsQUQZs0e3jpG+plmpV
         C0m3GHV/JhxGzZ4mnWAN8lYpXxj9koSB3uFg0eJzSPXgR1RwTD4Fwb5dPYywQ71aXq1o
         GhlUHr8lF5A9CMno1chirc0KcrLBE17f77aEMA0svfxfzJBbeyNClZeYNCU7ZqITXFvw
         ZJ/kUp23HljTfKw3xI0IuPT+uPSw3DGTg1s+hp7fb6zRVkYU77/lVXit36IiEHmSxU2C
         kah2052a4gL7gAaLfRpBfAZEldstTzXHgQUkJUm8Iaotlkd3RAwKyk+QEXg0wTR2cfrz
         i4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782715664; x=1783320464;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5+oe0ICWRfN20FKF1msz77hWxvDcYi0f/X+trcO5BX8=;
        b=FvP50mXL0rDQ1hY2kH7Dbs4BTFaQ0hM3LLq3JHpPBzem+zGCx7ETf1iFjOj1d+lkqu
         aWQ2If0HX8NX//CnUP0ZBKh0JUdJ2WoV8GXREziJ/RkOHPNWoVXMPO2VcIci89pmhRVA
         6qSk2aHwJ9ssvAz6NJjmbCVm55oMoQykLU7Qbrfc1mpv1JRIYxxAhF8tpgccdydJfddk
         CmcfFxRaZKdN6lW70Pkv46Vb9N9u/MC16A8w5uZnyzNqip9rmr9Ix+YDthEsAHKJVZeQ
         zkRapWS8GUC417VoVG0tQGRaGUe/m1w7PSfSvTzapPOhcJn7EtoT8p2+3dqcZ9wHv501
         NVfA==
X-Forwarded-Encrypted: i=1; AHgh+RrxmOkSwCIH9lzu24XaUjb2gHzEDfyZVeajZOXJ05z8JUi2ngm7hKSQ+i6l55jsXynYHKJ6JGKjXcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuEBHYP5NRpk4pkKFB/qzBIeNQQ+qulAK+9ASSGfTdh98y4mga
	pV17eJ5YU5Ru5HpiEWZEsNopPsZ9banFFDMn28vohvJnMwg9CebKAxLR98HmPg==
X-Gm-Gg: AfdE7ck476F4ppXC9YR0gJy0NFEtRzbF3ebHvUJhD0DSyQMyVkO7L37zzh4WSPlkyTD
	ufsveklrGTblubvzIGkXYvFlD2TBfzTDUVqeEcmNhE8GZHJr6T+ySGvc7AJoyp7EtFrba1lGP6J
	rVXWlakOMC6LGQEiCR7U6+5+9OshyqXWUCBcbZzweliAa2hSnlKwIvw7L+ckHBo/itmryn01hXx
	VKGAMcp5pVLuRGs/8Toqj0UQwzpC3dtaf99KOD7rm19wakKp37N9zb8dUJ7aOUYHpoEwkM9xGoH
	9eTr+ziyvUvesOvWL1XdD9yNj85al3Wm4kTG8Bc3psI+yljw1GuNq65rGk90ZhCI8ZIFRQ72/G0
	pv9TglAKT7jrpdf09HGz8q19Y7yD0N8e3FHnwJtzczt6bREJsJmVJ+zTEnDljBzx9BjLkrSvszK
	lNMSc=
X-Received: by 2002:a05:6102:80aa:b0:650:94b2:b209 with SMTP id ada2fe7eead31-73433e36b9amr7521498137.4.1782715663900;
        Sun, 28 Jun 2026 23:47:43 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-73566da9b45sm5178561137.5.2026.06.28.23.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 23:47:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jun 2026 01:47:35 -0500
Message-Id: <DJLBYI4V0I6Z.2ZMJOFAZXG10L@gmail.com>
From: "Kurt Borja" <kuurtb@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Jonathan Cameron"
 <jic23@kernel.org>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
Cc: "Chris Hall" <c-hall@ti.com>, "Patrick Edwards" <pedwards@ti.com>, "Kurt
 Borja" <kuurtb@gmail.com>, "Nguyen Minh Tien" <zizuzacker@gmail.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/8] dt-bindings: iio: adc: Add reference-sources
 property
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260625-iio-adc-ti-ads122c14-v2-0-ceb9b0b561cb@baylibre.com>
 <20260625-iio-adc-ti-ads122c14-v2-1-ceb9b0b561cb@baylibre.com>
In-Reply-To: <20260625-iio-adc-ti-ads122c14-v2-1-ceb9b0b561cb@baylibre.com>

On Thu Jun 25, 2026 at 4:55 PM -05, David Lechner wrote:
> From: Kurt Borja <kuurtb@gmail.com>
>
> Some ADCs have configurable voltage reference sources for each channel.
>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
> ---
> v2 changes (compared to Kurt's RFC v2):
> * Drop maxItems.
> * Drop 2nd paragraph of description.
> * Make reference-sources plural since it is an array.
> ---
>  Documentation/devicetree/bindings/iio/adc/adc.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documen=
tation/devicetree/bindings/iio/adc/adc.yaml
> index b9bc02b5b07a..12800737d4fb 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> @@ -73,6 +73,14 @@ properties:
>        device design and can interact with other characteristics such as
>        settling time.
> =20
> +  reference-sources:
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    minItems: 1

Is minItems necessary here? Its causing dt_binding_check to fail:

	ti,ads1262.example.dtb: adc@0 (ti,ads1263): channel@0:reference-sources: [=
'ain2', 'ain3', 'ain2-ain3'] is too long

I don't really know why, but removing it fixes it and allows various
array lengths.

> +    description:
> +      Indicates the voltage reference source or sources for this channel=
. Some
> +      ADCs usually allow choosing between internal reference sources or =
a pair
> +      of external pins.
> +
>  anyOf:
>    - oneOf:
>        - required:

--=20
Thanks,
 ~ Kurt
