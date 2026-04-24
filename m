Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7F63B0AC2
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 13:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777036234; cv=none; b=deYHZ5cT9cwD0foWOwL0CCAi9H1O+cHmjAcVSK1/6OLtHyiuGksDUsuNTDtJVdtlc1ZHGKGTUpAvPL7F0oF/1TQN4oD+D3KVJwiVVPrNaPfyPncw8CWAqADbsJJWTByJqQbMeMWX4W3UgpaQpViDfPPylpg+Dg6f6oQ72+Df2Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777036234; c=relaxed/simple;
	bh=jK60j71r/PMCLKQKB8efHIPJARlwkjCBCLpWCUUQ5TU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hFRxoPygv/DOhUnq3hxfTznaIT2NuqEHXvVSZVOcqHF9090KGT19o3kLNLuOdExI1GeV4QzLA+8cSXRDMDoWej+Gs6diovdjzoPtcti3l2+KqqJMKSTrsUlX5YasvYMScpzRAydUYTZICT9+6NdxpZ5Ak+KQ6Xg7zJSWfJo3ewE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ba7a1cc0380so1175881366b.2
        for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 06:10:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777036232; x=1777641032;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUxa5Yac5JZ/JIOen5ChIgl6Jr4G3NyrY10W57+tI7U=;
        b=cR0Ap5bVaTG9mKId9hhjENzT3pm68h82AwJ7xUl4D27CJynDJPs4rw0YEsq8Gom02c
         skgAVLIjpWPWBQw//RHB/ZyAgb7W+owdIC2FOhbJxvJLE32nTFBeARdBDwg7XItvDyrK
         kayoAbc8UUHiFlYrUJsi2aVaSzMjgkrXdES7UzpFE1m0kUuMoYtmWZWnUgdiJuHA+Z32
         doFinZSUX3Wuy87KW3zpW2ycirkUZFvGv7KzixEwj/nwXwto5LtjC1cNKO0Q0Dr/fiy+
         b4DS+taqTB4NYGIsRqeEBrjJKnGgt7E/nGPJth+2rjp5B/kLTX67Ogq6w7H8G89yFB0e
         7wRA==
X-Forwarded-Encrypted: i=1; AFNElJ9CJBWwRyqy/TwAizewBMXTM4IU87pfrjX1GhyIOC6jHmf9IUuQdF/8gdKEmBvGAMaOO8xnKX5yRE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyShLXf6xXO9DxQiEWhJiGqzk/mX5c8aRsn/cUqZC/CMtEjSUsL
	OIZDXR4Jfs++nC5yb/fcF6EVMYxRnzTxPhiTdYoG9yj51iknT2Kauw3+8uYCs9GteVo=
X-Gm-Gg: AeBDieuHFleNJFgzispWcLvFJunhbhept02OPUK658JccxWJAuB+kBLQ4YnDpT0m8MM
	ynDlA2lLWejnagE7PnUdUFQ2QtV7WOwOiW8hyGevkzvLXoeMhpFumPFfdCYi7v670PibtFuJsyj
	aFiZ0WuUlMScvD0H6M8HQOpNptIAFBzAGxPG988HHV4yj51B8TcmZiGZdjaJvNbt7gZ+5IF9Xsj
	FDLDCqjkaYxLphTUxVEPZmWlrJSCl3SbeD1mFMQvroyvmO3DHj+/a9Cj0ZR5PxwZffVqwdEmhLE
	EM3UoYTFJsjJVI8xAUkGqv4RXcav/9NThaJj5A1ONqeK3Q7tNuPTSta3sBCHzW4USHeWgzLIvrl
	HwEOjQjq27bNLOSLRJtCOLP7fASyWk0iDat+GIbJ+/QysIxiW3I1KZvCeCXx/08fj89JaUFvyVI
	CqUGmo0c1jzbmk8GBgmuHKEDdrrYDGcX4cykoRw2q3yXfx0yhrxs93SUC0kixYjFcD9bJKk6w08
	bhGST0szw==
X-Received: by 2002:a17:907:d38c:b0:b9c:3d56:e4ec with SMTP id a640c23a62f3a-ba41a91de15mr1539529566b.24.1777036231535;
        Fri, 24 Apr 2026 06:10:31 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba451cdfd27sm771063466b.26.2026.04.24.06.10.29
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 06:10:30 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-66e8cf72a93so9496703a12.0
        for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 06:10:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ89hMtvXzNo5hMKYNO7bQlPdqmzjPm0ecxIk0vOEK0we3ff7BpkygHhhLhkEMQizzQMZ7SNP+0tULg=@vger.kernel.org
X-Received: by 2002:a17:907:d07:b0:ba3:76b9:c3cd with SMTP id
 a640c23a62f3a-ba41b3de820mr1726472066b.42.1777035885959; Fri, 24 Apr 2026
 06:04:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410163530.383818-1-cosmin-gabriel.tanislav.xa@renesas.com> <20260410163530.383818-2-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20260410163530.383818-2-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Apr 2026 15:04:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUwdxVW9_xo-ivXWQHGe=6X=ZXyVGbxPf08Db2ryY0N+A@mail.gmail.com>
X-Gm-Features: AQROBzCYN8yQbUxpaU1BB5qpPqsbb7NS2Sh7I8H4Hxzs1kZXyoKXl2JLcJdS0KM
Message-ID: <CAMuHMdUwdxVW9_xo-ivXWQHGe=6X=ZXyVGbxPf08Db2ryY0N+A@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] clk: renesas: r9a09g077: add MTU3 module clock
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

On Fri, 10 Apr 2026 at 18:36, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have a MTU3
> block connected to the PCLKH and with a module clock controlled by
> register 0x308, bit 0.
>
> Add support for the module clock.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v7.2.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
