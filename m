Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80A742188B
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 13:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779457407; cv=none; b=CGX+oQxZq3YgCoRveaEep8oXz3L1wXRF9gU2IGEbGpYcRnW6R1O8dYK0IT8tJmPrCW6190gLH68YjxE2MDNs5w9qhthu9pKui0/oNh0jdc0TpHLC4OX9e8dGOmsjpe2v1y62wL9xwVJsemg/mKPbv7ErmvQ2Bxv8HRD4JlPVB+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779457407; c=relaxed/simple;
	bh=HEs2rq79YCoAiEGVJOXZDcuuCnNnzEJW3mYI9DGQ2fM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GylfRM+/Rkf/dVelyMZfTNkcUaAymT7/hdKXijp/dew92j1KaRJRqqps6Z/ooGuuayFeVk4P0kAPh0YrFU65fHS5IKmvaBGZ979H2T/RM2+hXDizkRuhKJWzWGR6IdGEgbvEBX34gxithdGxml2QqAihTIfljH3JwpSzhD4ascI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5751b7d147aso2760756e0c.2
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 06:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779457402; x=1780062202;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWzbSNX3RGbee5XiT1xV4dZKM9nwjUk9YQDs6iPG2rk=;
        b=shK0EqsSx9YppdiP0Nfz+5W7QquLYV1FxpMxEqybBbecSaQfxT3YEr278Mm84KoZ2b
         hwg2YWrEYjirqXbw1Ijtp9Ukiyg9NNqyPY8YEpAnGlB0FGZEC/bQ3ZohvnC/4a8mVqom
         yrA0QeSd0paBcMgh82An4DbLT8LtOh193oNeHOVtffy6jvGs6G4OyuboyaZKSIX3DO/P
         rOzub2sXceMJ6ESh+O5YIVhVFOfOD3hlnIzlnTWD3yGP69O7ajxnwR9rg4aKnq+zM/L6
         Tbh4fauwpXlq7vBGHeYMHEYJWdvZiF7vf80kzSf9dU6T66v8jNeggZjelIZLGtWqElBk
         pqMg==
X-Forwarded-Encrypted: i=1; AFNElJ8Q7B8nUrcGgdv/4F9RuVQZ/Bn+CIhosENFdR9ofCie9cmPWfs8gCWsiYezNHSXyh3FOaBqhUWr/6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YywHXoNa5laAw863FxbG4Aa6lqPc0HnYczXw9gLFPeVF4e4MqGT
	vNJTXSxbD3u992u4DuVB8ww7rYJOC1Dfb7wpVNd9JuERrIokIdIAiSM4GrpqsEuzs9A=
X-Gm-Gg: Acq92OHbREA8qSSwHpLiyYQgtQXFU/mHnqcSQteRElfoOAiheAOBFEIKC8RYCcoSOx/
	jZ4/nBAvE0ZbWO2Icz/FO6zINdsWAa1ihT2My2F1xykyE4YWEqLs4Pox49CJ55BHk4+o+C9qI7a
	go3raLPGmYe80cDplxaiQ/pKvQnhEvZ1ckBwicJc+FvFf5ULzIUqrkHAw3LKzBuHjXU3KyqAEh3
	Q3H6HOatifjdIf5bPhvUeDJpxzOJCLJIu/Z95BKJopxXBUKNkiRv/7Dd550sReuIbZgBSnZdYpO
	nO3CcbrBSzolVhtfWNBTB0yGfuQXdfARCO/59pqFNPh2quNbhipuAGUtJ1284FjsqKr8N7HAzh5
	jOSWE2a6OJ6AptMv7NEXta+JuJuX2Ig6DrILtALyv8SXw7Iy0YkChBO1dT3Mkaz2rC+AWoDGPgj
	cbSyLTeFvVkoF+CC/XmRh3tAMhakul3zWsyueOacbdF5AdDhg7GC6f8p+7FWZYGOJ36FANQXJ9W
	PQ=
X-Received: by 2002:a05:6122:3b16:b0:588:33d2:9249 with SMTP id 71dfb90a1353d-58833d29772mr513355e0c.8.1779457402589;
        Fri, 22 May 2026 06:43:22 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-586f23eea07sm2184981e0c.4.2026.05.22.06.43.22
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 06:43:22 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5751b7d147aso2760749e0c.2
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 06:43:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+M9bUmyoNc5ZrLJX2W9FTIjLOFJ6jkt8EdQnoR+6MZ5fc5BRBPd8F6JpLNECXz3BqPr6g6aw93sl4=@vger.kernel.org
X-Received: by 2002:a05:6122:ca1:b0:575:3b34:28b6 with SMTP id
 71dfb90a1353d-586624cee61mr1849670e0c.11.1779457402270; Fri, 22 May 2026
 06:43:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410163530.383818-1-cosmin-gabriel.tanislav.xa@renesas.com> <20260410163530.383818-9-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20260410163530.383818-9-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 22 May 2026 15:43:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVEbmX0QqVQE7YhnCO325=2djd5S=ynr8DZnspKKK7WoQ@mail.gmail.com>
X-Gm-Features: AVHnY4KCEtGxHGei_0qihwJrEjH83nV_Z2btTPs2i2CQslPWM7eGYi7MBkb4Nkc
Message-ID: <CAMuHMdVEbmX0QqVQE7YhnCO325=2djd5S=ynr8DZnspKKK7WoQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] arm64: dts: renesas: r9a07g0{43,44,54}: remove
 TCIU8 interrupt from MTU3
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
> The TCIU8 interrupt used to be documented in earlier revisions of the
> user manuals, but has since been removed. The corresponding entry is now
> marked as reserved in the interrupt mapping tables of all supported
> SoCs.
>
>  * Page 486, Table 8.2 Interrupt mapping (7/13) in the Renesas RZ/G2UL
>    Rev.1.40 User Manual
>  * Page 363, Table 8.2 Interrupt Mapping (6/13) in the Renesas RZ/Five
>    Rev.1.30 User Manual
>  * Page 528, Table 8.2 Interrupt mapping (7/13) in the Renesas RZ/G2L
>    and RZ/G2LC Rev.1.50 User Manual
>  * Page 540, Table 8.2 Interrupt mapping (7/13) in the Renesas RZ/V2L
>    Rev.1.50 User Manual
>
> Remove the TCIU8 interrupt. This does not cause any breakage as the
> driver does not make use of the interrupts.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> ---
>
> V2:
>  * reword to mention that TCIU8 used to exist

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v7.2.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
