Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EB053ED0B
	for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088972; cv=none; b=aJu3crc+PLp/Xc1l8wMKNokTKwE0dP3ifDN0xBwfbuNzQQIXrZn/6z3UFWB0oaeeonpBi9RDp0IwS8mFJjNDaEjzhqieF8NxUjCkAuXrKBzs2Ie+Bi8mMTPj9leUQxO85XdmdO0z2wSDHuaW7++G9yElWVppywrlo9F+Mnt5AlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088972; c=relaxed/simple;
	bh=AV+dyjZB8sTwHOLZbjxxfBxGqHWS2kCM/XvssUEmLOw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fx+5A+rvb8Ndjcl3vmoSRNHFDblGgicTpzMQxM8ziwoSp3XrSEiebHQ5C+we4yglXE0OKoyTtJTyBOnsl4Evz4IpMO9v/hKf8IccRKbMOvQiVLbZViR1EAWNBmPHFxpMpltFuXoRCFw0rGuMB1EyTHN5D4P1iUz4QQTya2gmicA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgxXdgNc; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgxXdgNc"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485b1d2874fso12654f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 07:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790088969; x=1790693769; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+4QPCByQ1WC0MxqcTLpCr7YHlhoiPo4h/d1r2QbbvjY=;
        b=UgxXdgNcgjPwXJs7kzH6PcEAk1clHW4UeIeMkHnng9VwcU+SqYEx2LIks0dSoBD2GF
         b9uG49rkyPGbtvV6bZf3Crsv88HvPAWAmyUNfBZGtcioTjl+dpcXZrsn/kW2rH2mj37P
         s9IOTjixmCZ/Ll84iraAgyJEQiI3t+kyAI8IcbNacrSg6nrzMEELjxGXpom7lafkgJF8
         wjXHvVDkvkx0haICtk65PeAlDpm4GT/KpNpsBioc0SLeQIMpF+GVOoCkSOToyREX9pvu
         oiAB+NfB8eVn83+KJZuzMinpnhwH+b6DP2E6qaIXhIKnr2SN42jXP2UcDHkG3h5yGd1j
         jRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790088969; x=1790693769;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+4QPCByQ1WC0MxqcTLpCr7YHlhoiPo4h/d1r2QbbvjY=;
        b=FRKHApcsINlpsWkGfgtvOcXE3pp912Xqih82T6A9Rsgrl6NsSZhC5XSV3GC2xcwOHc
         nwJ2VpMxasBNab4IIADO9vJFTL5ztnlsx86+oK4tykoG6KwblaNdkFo5S0bArn0sD9WB
         qGdw3WuFqHuuXrzfqvyPxgiMLofmM4BsJ1oTmap0S4ZflzBg7PpB6+VrjbtFzqt7RQj3
         jFaXfimOjUIxHyxwpbbP+iYxmnT+V8bGv1eG45lE9XYKqwo5mK7gvNFepcneUODQL9s4
         +8szfnQyzLZVNbybV6Lje+hqb/V+m6Ej9pfp8SeL7B00kR3mfhMXIUhXyjXvZV4sHPbn
         AclA==
X-Forwarded-Encrypted: i=1; AKwUvBzF0jBSOSqR5up0KN3W7KUnye599njbc22pDdPtkXfzqCHHQpi5r/+9fGn2gASw3Z1OSx9ZxIWrcm4=@vger.kernel.org
X-Gm-Message-State: AFuF++k7A20E6HeoYb8cYs59luIiUaU9tR83GBrkSSq5fMpSSu3HXlac
	UnI6AhyZhlVSUGSxmmHCSaY76SfB5cQxmK3vOLYdO8FZQPGvDcBLK0eB
X-Gm-Gg: AYBFou1rpmRI6oFPdWKMh6NNs2MbqmWhVO7LYPoDMAUWwcuXQ3T/K2M4s57lYxiwLnK
	bjVfMeGGYsX3G70x1G31vQuSMbVmEOlQRu7i6qZRfKZVZ64x+Tf1HWhf8dCHBCyjYQFXvidp7Sf
	PKySOS2Zv3ZkEu1Ec2wsDyK4ZvXlI10Xus+Mgpkta936O0VwINXiKngWtH6l/tTJun+rSRawOqJ
	blmFPV8iNwMYrdNkV+9WLBpFtOHAAADSVx6rTnYVnAgOsDL16vTiDQWOmCBHtVCGj8DAS1bDn3Y
	94WelVz8mHLkhj6JTvjBVmTW78mpmdK1p8G1vL2kaDZybJsunmKjudAY5/h1niBa6kCTShaClup
	aydG+pJjZSSAl6XlqX6BRpNNBYW/rjvnVwcBAG6YwmxN7tv+8aWj3/Dgt2g/PuFPeIOlmQsIntt
	f3RqOuPpIJWWAEEpypoSXxqVjIUK74grqJWi8Fx7HT8qbDr0ZZxmu0MRVznePCWcr/WqH+tiGZ7
	dkIaXsksH1pLNMl59NJpZW7O25QNCGiQspZn1THmHzdP2HexsaczMhg5y1cjgWPLesiXB3cWZIZ
	AoZVXy+JUuYzh+5IWFkNluK2QED0sR7rKDkQAT7nWBksdWv67CoAK3RXsUB8P4luCRCAw6oBqeV
	nzuFAQX/MZR+QTJ8Xfz9gQ5lidGHHEOHCjLBz/vwbaB7fLSw8hifgnG+Yhhds/FHeUGiZT83OVc
	HO9mZ5
X-Received: by 2002:a05:600c:4515:b0:49e:6581:7baf with SMTP id 5b1f17b1804b1-49fd88534a9mr52059775e9.2.1790088969036;
        Tue, 22 Sep 2026 07:56:09 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fddfdce15sm184675e9.10.2026.09.22.07.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 07:56:08 -0700 (PDT)
Date: Tue, 22 Sep 2026 16:56:06 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Liviu Stan <liviu.stan@analog.com>
Cc: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, <linux@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: temperature: adi,ltc2983: Add ADT7604
 datasheet link
Message-ID: <20260922165606.00002b73@gmail.com>
In-Reply-To: <20260922143950.176910-1-liviu.stan@analog.com>
References: <20260922143950.176910-1-liviu.stan@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 17:39:49 +0300
Liviu Stan <liviu.stan@analog.com> wrote:

> Add the ADT7604 datasheet URL to the binding description alongside the
> existing LTC2983/LTC2984/LTC2986/LTM2985 datasheet links.
> 
> Signed-off-by: Liviu Stan <liviu.stan@analog.com>
> ---
>  .../devicetree/bindings/iio/temperature/adi,ltc2983.yaml         | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> index 13e5f29f0588..09b809f01550 100644
> --- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> +++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> @@ -17,6 +17,7 @@ description: |
>      - LTC2986
>      - LTM2985
>  
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/adt7604.pdf
>    https://www.analog.com/media/en/technical-documentation/data-sheets/2983fc.pdf
>    https://www.analog.com/media/en/technical-documentation/data-sheets/2984fb.pdf
>    https://www.analog.com/media/en/technical-documentation/data-sheets/29861fa.pdf

This probably doesn't even need an Rb, but anyway,

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
