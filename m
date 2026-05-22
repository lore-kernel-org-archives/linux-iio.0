Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F859403EB0
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779458148; cv=none; b=g3xfibipzSi0+fX8fPdmrXM82fEEmc5hKHT+wOUk9rDTJqP1tJCqyy3mkhvc6QURw65VNVI47B7GcK288EX9cRHHtZPEhjzzefvJRAvOWmrmBhu7ysOdUyO4Ms3DO84PTX6+fujLY8yu0uVLq5Z0L8Zj0BPzTqOR+JdBruCOeQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779458148; c=relaxed/simple;
	bh=FUrrvYF1KlCYgNZMOn/2U2OmhC3p91aW8lXQejJ1EWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DcJMX8DpnIMQuuCrEqtAUQJNzUxjCUbsrkC2jnSUPZoOyXRPfBgC6TFDctl6/H5NBdC+2qnJDlUMUA8WqzXSNLEs0aAZptINfwrLjp9gIf+dzYxVPIzhETnaC9KisD0HCIbYulcy3Icc1YWVewltFiIR50n1LtnAF4r15uQ8Mgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-57513a91514so2431043e0c.2
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 06:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779458145; x=1780062945;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3tqZ3OVcBR7J9y1KxfWGi4ZaR+C0ebaX/TOYg/Itik=;
        b=dWQ0N/Fpckq+fP5WGDQLeFFErEU3DfMv+SMFa9Fd/yJIaaWHnGpqQNooyRoWp1uayL
         2OGTehkJXjuZY9zcxAH8xbs8CK0LOFv9tSTF1HQKfg34vkOLfnC2nsYzoLCvQb+GP3Oo
         GHD8iHi1S/6isV2zFWxM6vssBLtiOtYEahP0m2tqo2pK9To1IXY7eOoHzReh5U3tp363
         h6NEe+9NMYMW5j5QWPI9NldaGl/IklDMiiXRWrLaVfJy9OGZ3EnNr+jq/vwng3obEYbB
         Ey97MS8SSo2IzdQztHNpg7D1jMLFRO8Wa8K9q7yrypU/o4xgglwtEnM30Rwf5ZBnF4IE
         QBYQ==
X-Forwarded-Encrypted: i=1; AFNElJ8CIVBV6G8oJEFDLx9Pr6C/ILN3XDQzUy29X8LSw7pu38Dl9igaLrL+0yTzD8DFugSeaYh/IHfIX5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwdtT/OnTdYXNKfEiKlRPRqbqiJAtE6aIMXvpRrxd051nd0Xkv
	uxcKOVF6pTD0CWaJOmAqsjq7IabrIjhiGztfSFJeig8wA2rYzlLWUTgePTiQhkOWT0M=
X-Gm-Gg: Acq92OH0WnUnZw1n5x7aNaCQSdnU7wUK39FLQ7D9EQXuebCLw7gMQDMRobxIg9t02AG
	+oI6FzD50VMVNnHAFkosIa13wAjfbEwte0Mgy00Ln5kgESPi80ehB1NbHff979nIxk/tJmPqY1P
	k+Z5vl4TpiSV5if9wW0wuL7SOiWSJU5WnnOWw4cfDGzqdQPj3sT7pEqQRNEPP2fMAbKWCBSRkcZ
	RjdIeNVQGizCB6/sTEcHgfbFgWHMQOkfmNsuqUr//x5ZceVHmYDlifYJwR7FxM8a6ndr5AxuW95
	ROe9FqF0yOrET/QBp6tzp0YR7g8WqLuz0xZUaY6OdVJE++5jma/ImWFkgd71o2kX65mJSFBJzn7
	3sKMFug6OeCbh1TJkP2voWEgXH7p6ZTVHTSSKod3XBY0vZ+t+SUkgpnIMo9GmyJl4Sjl3+6XlEc
	BZVev/g3JEuHVJb1bM3FAwvY3RCQ9Ixi2WTgy8NJtti3jAj6lgdeW2OCvqRLjNQniFxCs5YkU=
X-Received: by 2002:a05:6122:d22:b0:57d:8059:e0e9 with SMTP id 71dfb90a1353d-5865e4a446amr2097756e0c.2.1779458145232;
        Fri, 22 May 2026 06:55:45 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-586f85bde2fsm2203038e0c.13.2026.05.22.06.55.41
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 06:55:42 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-95cc1a5fe9cso2001053241.2
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 06:55:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9+YmfP8Wr6yRGTZXuLbHnjxORCp/3CZ2/CwA2u5zpo7Ou//pTcZcBdEsuUPt+Ckl/qKRDZsP3jbAw=@vger.kernel.org
X-Received: by 2002:a05:6102:fa2:b0:639:6533:65a0 with SMTP id
 ada2fe7eead31-67c7ffecbb9mr1562113137.18.1779458141395; Fri, 22 May 2026
 06:55:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410163530.383818-1-cosmin-gabriel.tanislav.xa@renesas.com> <20260410163530.383818-11-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20260410163530.383818-11-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 22 May 2026 15:55:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV=jDbjoyqh1qraVSRPjTJieTEoY331zHRn3-rRvPW81w@mail.gmail.com>
X-Gm-Features: AVHnY4ISeZdPBYDF9Wtg2Sy3PVMdCCeL0WeBXF2maqndwrmCz-EByfhYArSf_hI
Message-ID: <CAMuHMdV=jDbjoyqh1qraVSRPjTJieTEoY331zHRn3-rRvPW81w@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] arm64: dts: renesas: r9a09g087: add MTU3 support
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Lee Jones <lee@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Apr 2026 at 18:37, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> The Renesas RZ/N2H (R9A09G087) SoC has an MTU3 block.
>
> Add support for it.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v7.2.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
