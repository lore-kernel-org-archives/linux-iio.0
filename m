Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7952D2475E3
	for <linux-iio@vger.kernel.org>; Wed,  8 Apr 2026 07:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775635090; cv=none; b=JlqrERxM+dLxWyNvl/u+eJv9oCclRwUZAAG6jIu2ZH38Ms7It+xl+X6Za1UeKUxxWpL1tWcUCKNSMH8/sM6nDfMRunwIn24NI84l0MVs/uGGSP27ik+lmF3TSmQe/xJFxupYM3GrlJTD5/cP/AfZIqXOnQhJHSSFM2Y2m/nL+zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775635090; c=relaxed/simple;
	bh=tb5ayrKCU1QRWz4F+1quo/d9UHKE8nDLKnD4uurIqwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Otmz7WqjjKNM9eVd5wedfBiL3NA5gNgfvTg20ntNkrkNYXMQOL1R6zNEzCftByvDMTCwOh5B0NcC4umtVED1lslGeu2n67MSgNy1nIN08WSS14MCnqdcH0zu7qVwLORYbNKJN2PwtNM6Nvi5lhS9WjLcPvSmA5FT8rTEt7EECuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-953943f7a33so2545935241.0
        for <linux-iio@vger.kernel.org>; Wed, 08 Apr 2026 00:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775635088; x=1776239888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s4R92sE+3j+L6v6U2wW4n9L1aU391JVM9cT4kRUC3wo=;
        b=qQMG28kIQWfOVOhanJebiDCKkKJn/fhGNaG3dE6DE4e5Bdc64H1mNPWFyXB4aZHr8B
         I69gw0oihUJwvlm4VSxr7nfZT8GDfKENs/0FpbPZl3su/HbK3nIFZNE3XE3C/fahp9Mz
         RDDL0QwVC5ago+odpmNBZyew6EZZMxFNRplE8lWmmc54BipAdsZDs+RMz9JaG22+NLA+
         k3RWy4EdjM+CC71KGY1zeywNo+KADoTVcYhxzyhQp5qHdmD8Md/ImCdAeVwYPtzl1ynb
         CwUcdF+nVv/iXmsa9MGj1Eg01r8bMcEf+z68IqfydqG7mTRKbQxXnKv+y7nNCzYC192T
         6n7w==
X-Forwarded-Encrypted: i=1; AJvYcCVLqBJuuPqYxwDkP1fuOmoZc6UQzNMjBM+4DamL7swBSaqZaiwR4oHl7YQ7+43sEmdR+dnmk5Lyhjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgEyRBlWOCmbPkr1JTN7f+2j0upNn23YmXtZOPZ1SOdHV9yrB6
	yzr5dbUEhlffuYPnNKb/mWvhWA5tOX7I1ObjMMND5tMZZgCwSOiUhYZOLnuiuxLg
X-Gm-Gg: AeBDies5UrdUeFGSKJsJH1wMCkvC7wH9L0jHjhisfGom/KsLW/DF3G59jY/73eg8mpn
	7hcnFw63PExU6bC+vlfXl24Tc96JNquOYhYkQIBMk3oO7YWjjKGXbv5p1yuGbhwRD46uENm+aJ2
	sXyCA9PVRb1xHc2qexTvWZiVY8nwUSe44gZUenFOmGg6Jm5SHD0nhLoR8jEfLgxj2uwOnjzfVH/
	Efcm6UwpuyNabdzK3fuU3RO6/xT9qbWq+o5ctcbP7iMp9y4V2CUPDDV+6EHzLxXyYCEFqtP9So8
	ExuTtQM8nT8KP8IE0lYqIQXrItyoOyHKq1ryMWU0W2AsJ5MjogPZ5YTyt+X5R4Ih48N4rUbnVYX
	DCW67jb66o7cSA385o1GrTsLMxQHJzBueBEm1BiX6lttTDltWswlON8tBrsOtbn9M6XUaJd97If
	f37PAMkw3XjNeYxN+6ubUMMLR5w7mUnetgPzrdn1lUevVL+JeXJBPM45pzZc6eL/X9X/mT6rA=
X-Received: by 2002:a67:ef49:0:b0:607:9443:b29d with SMTP id ada2fe7eead31-6079443b7a2mr1482597137.7.1775635088227;
        Wed, 08 Apr 2026 00:58:08 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-60582e730e9sm20151873137.6.2026.04.08.00.58.07
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 00:58:07 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-605def5b7f8so1983696137.1
        for <linux-iio@vger.kernel.org>; Wed, 08 Apr 2026 00:58:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUXErz5RJfFFSpuOEk7T2VQvkb1i7E9oYZBSCu+JMeCT8+8WwIWtQr2U9RB0OgY2yOQTQj1fLS6te4=@vger.kernel.org
X-Received: by 2002:a67:e718:0:b0:604:e315:6eb1 with SMTP id
 ada2fe7eead31-605a4e92bb0mr8578869137.14.1775635086837; Wed, 08 Apr 2026
 00:58:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327192425.438263-1-cosmin-gabriel.tanislav.xa@renesas.com> <20260327192425.438263-7-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20260327192425.438263-7-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Apr 2026 09:57:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXkh0Q0_O4VZ=DoJ26=+QiddsLi_CwTVwK-L+Q5zb6wPg@mail.gmail.com>
X-Gm-Features: AQROBzCZCuwf6NF6rEXqKfmkxTjFfqDW2pSk-I-eqOP6g3EoYNQgB2zRxA-RYgI
Message-ID: <CAMuHMdXkh0Q0_O4VZ=DoJ26=+QiddsLi_CwTVwK-L+Q5zb6wPg@mail.gmail.com>
Subject: Re: [PATCH 06/11] dt-bindings: timer: renesas,rz-mtu3: remove TCIU8 interrupt
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Lee Jones <lee@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cosmin,

Thanks for your patch!

On Fri, 27 Mar 2026 at 20:25, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> Based on the following pages in the User Manuals, the MTU3 block does
> not have a TCIU8 interrupt, only a TCIV8 interrupt, as the row where
> TCIU8 should have been is marked as reserved, and the GIC SPI numbers
> stop at 212.
>
>  * Page 486, Table 8.2 Interrupt mapping (7/13) in the Renesas RZ/G2UL
>    Rev.1.40 User Manual

According to the Revision History:

    8. Interrupt Controller page 486
    Table 8.2 Interrupt mapping
    The =E2=80=9CCause of Interrupt=E2=80=9D column, modified (TCIU8 =E2=86=
=92 =E2=80=94)

So this interrupt was definitely documented before, and I think it would be
good to document that it was removed, instead of saying "it does not have".

>  * Page 363, Table 8.2 Interrupt Mapping (6/13) in the Renesas RZ/Five
>    Rev.1.30 User Manual
>  * Page 528, Table 8.2 Interrupt mapping (7/13) in the Renesas RZ/G2L
>    and RZ/G2LC Rev.1.50 User Manual
>  * Page 540, Table 8.2 Interrupt mapping (7/13) in the Renesas RZ/V2L
>    Rev.1.50 User Manual
>
> Remove the TCIU8 interrupt.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
