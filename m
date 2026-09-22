Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464B73A1A23
	for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 14:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790087649; cv=none; b=iKiJzTvG3uOBbKZYWO68gFWirKbplEe/y2R+loJSxcdLCYC9kdP7cIQBhS6QxKpcMRUNA7B9k+r/avgYNreXoAyUA8BG8tYPWiJr95eM7Zo/wm0sbWIpixkIZYBMYmCLarJZ1h1LWvjHlkrpdHh6RWNVwJ4UiCXK4VsudMdE4wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790087649; c=relaxed/simple;
	bh=zHlsfWC8sX3pz0/XSFoxgX7FqDI7whEHdUXnwOXIQoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4jOtiwYdyrcp6X0hCIeNbjghJSrj9Y+rNEUbwUILgeJVkkrKcO+IPRrgflvVRUd0N/YepjU6NxGF+ZJvxzZZh0Z/VzzwkeqLkkKoyWADhNoyPwiFx5PAaa8OrC87yGuMLXQdlmtkgMlFz5FJnOHW6tCQnSI6Xq6L9rTbcb57l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f12.google.com with SMTP id ada2fe7eead31-78a7003f94fso1155426137.2
        for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 07:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790087646; x=1790692446;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ifr1hHZZAJWVubWKqPeVb9esvq1iy0mCWPvBSTHrG+w=;
        b=eaC00p3X8w4R4RbRsxvxqZeixZn2wocrwmX8r2jmbBkpeV0qsbEXNsXRUEKK/fbHmE
         SmxzR1Ao1QanbvKT7DsOYuQmk6bdZY0QB8cMJKE0O7K9MJDe7Mdy/nHM87JScOXSP6uE
         GB1Qe4UQItW9UKmsAavnZuohbBjInkyyuDwjm/DYO9OeaK3SoVQQBuNzEVpXnbG81Jra
         pputKhz/oP9BSoiYZXFRTartawJP9dHfAJcssRRpkN1ItUd/DbH66lsZmzfL5SRrSlB5
         uMylAF66XywhAns8dk/2bcNSc32m+x3fyv70tHtWzDK/QPiZ6HLJdPXgaC/Hr41KYlmW
         bdFA==
X-Forwarded-Encrypted: i=1; AKwUvBwOYLj+O5LtJPudeHKlndl5F0KcjBfofa/TBvORU+IWCBiIOpOV0sQNZJSnCPg1BElhpg8dVJebZmE=@vger.kernel.org
X-Gm-Message-State: AFuF++kGnwUcOfMst7vgLbYDF3rRDoE2bZzbQRTHQ85OE7IZmi7WyZdU
	cuf0au6KT9zP0+KJyTGSUEotnKidf/uQxNgCzpJxGBMdwt8Rbr/pidyulvwnAdZa
X-Gm-Gg: AYBFou2IscbrbQvvSeXYfXtKj3oXxD+avaTZKqfHVrq2oBp6ZRONVfAaIApDrp2QfMx
	xBYZ6fodsxYT6ytPccPAjR103x63Sw1LokhvlG7UKdO15Puv68WMAVbK2S4vDhMYKJeykdLZd6f
	VrxaRGi0i6qADoq3PD24KJGGKJ1SuzB+n4RjkQ0VZ8MnT7vlKGg+8C0I6plpGnFWTTgmFWiUCMq
	rQg6+77SqpxmcYcQg5EPSYwTzGMIH1ivf4gBVdb0tCTyu1iWwU6D1TyQU3JS6z2qR9G5F6pQmlq
	18+I0H4p6dKU1YryYerS7PLyQgx2sgrLpbiLzCKnp6zO9MD1xB0EoALp/Ok21fpxeF996fDBg4M
	WPGrlSXxg1A4frJ7FMgAM6afMsu/tIiEVaBsdEXpg7VtY8ak4RTOnFBikPcEb+EVn3dFb14Z679
	xqWT3FJZvNqfj/ZutZ+J/EJdTDnM+Vx5BuLXaL/zUU+i1agVoUBoMwqYylScJo2HBADnHMS+3mx
	WGd0QlI4vxUzIQMt5Al7+1bfe1Wvp9Edvvikw==
X-Received: by 2002:a05:6102:3e89:b0:7a7:ce1f:6b95 with SMTP id ada2fe7eead31-7aada620140mr1904727137.2.1790087645539;
        Tue, 22 Sep 2026 07:34:05 -0700 (PDT)
Received: from mail-ua2-f43.google.com (mail-ua2-f43.google.com. [74.125.226.235])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7ab17f39273sm1898066137.7.2026.09.22.07.34.03
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 07:34:03 -0700 (PDT)
Received: by mail-ua2-f43.google.com with SMTP id a1e0cc1a2514c-9833bd5daffso1113628241.0
        for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 07:34:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxDQYztE8k5epexw15rFIGkqIXuqIO9g8YensahFxKxZaDiIQLBkNC6WXKdFeGuA1HkwgQMzSLDk2E=@vger.kernel.org
X-Received: by 2002:a05:6122:390a:b0:5c9:a617:580e with SMTP id
 71dfb90a1353d-5c9b8b29cf6mr8586451e0c.11.1790087642750; Tue, 22 Sep 2026
 07:34:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922042707.116378-1-biju.das.jz@bp.renesas.com> <20260922042707.116378-7-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260922042707.116378-7-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 22 Sep 2026 16:33:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVbyktVBAwBh=LoARWHHmb_FrF+omeDvNdR76uxus3mPA@mail.gmail.com>
X-Gm-Features: AclHuK8QDsFUbN6MlA77zfZcOMVCYGTCDIMnum6Wgku5P-WW7MUQq9pjTBb7a98
Message-ID: <CAMuHMdVbyktVBAwBh=LoARWHHmb_FrF+omeDvNdR76uxus3mPA@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] iio: adc: rzg2l_adc: Rename num_channels to max_channels
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

Thanks for your patch!

On Tue, 22 Sept 2026 at 06:28, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Rename the num_channels member of struct rzg2l_adc_hw_params to
> max_channels, as it represents the maximum channel supported by

... maximum number of channels...

"the maximum channel" (aka singular "max_channel") would be equal to
the maximum number of channels minus one.

> the ADC hardware rather than a count of channels currently in use.
>
> No functional change intended.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -62,7 +62,7 @@
>   * @adsmp_mask: ADC sampling period mask (see ADM3 register)
>   * @adint_inten_mask: conversion end interrupt mask (see ADINT register)
>   * @default_adcmp: default ADC cmp (see ADM3 register)
> - * @num_channels: number of supported channels
> + * @max_channels: the maximum channel for the ADC

"maximum number of channels", to avoid confusion.

>   * @adivc: specifies if ADVIC register is available
>   */
>  struct rzg2l_adc_hw_params {

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
