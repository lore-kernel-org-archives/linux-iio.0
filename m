Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7894D560AB8
	for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091098; cv=none; b=YxV7u7WAWYmgkdd9hpomugEfzOH3d1HXYYgY/pXAmnzGnbDHNZ0Aowq8IInaarIrCx2I2btu9OEKpRTlJpO+QOV31wOAAvxUoBOC015+cfhTygR/3syweNemG2fuQR83qdc+iArT1EkoWe/K/Rc7csIqcxda7BEAdQaPrK38Ewg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091098; c=relaxed/simple;
	bh=tAyiwXOmkifke3Bc+NxLOBMDbHXY6l1OlgnArNcsfhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f0eZXwzSlKp+LSmdb70q/sQpo66isB+nBIVRtVBhq5CkQlNAwRQM9RJ0AffQPMiX/DbpHIGhIKcAbYt+liF2ydPUyP2g7NLFxKpLFBKLRvKVbooTPGxsLT8CI2R4/cTbthLvQgtEVQUeHc3M/6UjSUF+YyoK/0DQ1d3JfgqHUkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2d747ee1f38so44425975ad.2
        for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 08:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790091096; x=1790695896;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EibhQgWiuapM4MkmPRwugdMJ27jgZzllZGbWfakUivA=;
        b=uxKBSgGqIl6hPc/jnWocQwG2T162I/NtIfOUm2PEmCgo++QJ4nLASHXq4GQKOSnrdF
         LUZYVydGPuxCSBxfbfJSWrfPjlGTw+gJpRAAhADK0R9Ov3mHdGBxoe3IMCHq3d4LyyN1
         cqxmfGCzBgUq1kgc8pKTbkQujJJ1jAGR6vrgHYZq5Z3ej75883YPDTGrhuD8cUP6LtRK
         STT1UhH6EBl/ViSYlCQ7PJT4XKIf1qg7l/G+NH++x/3dJXqYDl6r2lPSEmladr0q+yti
         DK0TGVOBZGUSXYwnTqmtNMRqgoIILFahqpHxRVFpJtlt5+sua6suK0EJUi1YNpGlmgpN
         Vy7w==
X-Forwarded-Encrypted: i=1; AKwUvBwjhHQgrZ2QU2kinaS0nf5W2gmSKP63PIlwSfA4kCDUOEPSTIpHLYknRE9aj1hPnCJjVE4KsjfGFsQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nNGSf9+7VesE0A+R2/JE9HduXWtKBaZni/ZcIYX0HaKWd5MhOv
	dUtTZyndB/TyLl7CnvqMSP8KqagCz7W2EZ2Kc1NkxNNnkKBZGUlGtJBiSgN4zKk3
X-Gm-Gg: AYBFou1+xUmp+4d6vB7ssW0UEXswF0ZNIJK0ChEB4Mzo/wzICiagJwisOhLMTE/g/fu
	RZlW5Pkj7Ju1+A20N/Ypp5n8SXEkvOVPyRGkp1VK+b9SytCEUDNCzEzKPUGpxteAhVm5XZ+RKG3
	D6Ue5n+52tpsmrt74Mv8SHL9uWu6f8DYyjAaTdeZqKJLWeURsboHNi2JqvSOSZkmyaM//qoR+1C
	UM20bQ+kw+g3EM7tc9iuZuzCyWSBbfOscBYr7TqHuOVNVCiQ9bkH/rQsvvf2GlON//114x+Q2Kl
	hlRhBOyUibnnnMkAIXvjuamHZBrlPPvTc/nLa6ll7vMco3HgL1fUtrBjrt6yl9V/8i8D7519hF8
	dMaA+mdhTxGuDgwNia9e/ctv6gH3bsvb6jbcLYwGgZDmF4SwCtz82SaKsDQnf8wR8o1Jyj/ffA4
	UABCQTlwTJwX02FlgMbDLZA6Eztl8ic7V5j8esm8DySERzVc/rB4qoYhMsELPL5AhEoByajYxZJ
	XwTau1Z7I18sVri8Mrcb2Dvmp47L1QnMO0c
X-Received: by 2002:a05:6123:12f:b0:5c7:ab80:2922 with SMTP id 71dfb90a1353d-5c9b591f65cmr8465934e0c.6.1790091084059;
        Tue, 22 Sep 2026 08:31:24 -0700 (PDT)
Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com. [74.125.227.41])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98516ac67f1sm43212241.12.2026.09.22.08.31.22
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 08:31:22 -0700 (PDT)
Received: by mail-vs2-f41.google.com with SMTP id 71dfb90a1353d-5c67e529da9so1593084e0c.2
        for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 08:31:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxSQlrNahCiWUtZVL/F8gWezYBv2KRtVze8mz9iUUVm6r/a3oa4P3pBviIEHo2XQ3NR034j2AkpNjw=@vger.kernel.org
X-Received: by 2002:a05:6122:e183:b0:573:a779:62cf with SMTP id
 71dfb90a1353d-5c9b592206emr9513571e0c.7.1790091082417; Tue, 22 Sep 2026
 08:31:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921110144.44425-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260921110144.44425-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260921110144.44425-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 22 Sep 2026 17:31:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW44-25RV5uR2=mn63xMy9e8Q-nB8fteaUveigvBt2Zog@mail.gmail.com>
X-Gm-Features: AclHuK8eE1mJ10XIW9ciQ8bZMT3j6oSiCVVbmbWm-UvOOnb6nS6TVY6Jb0Jgh4g
Message-ID: <CAMuHMdW44-25RV5uR2=mn63xMy9e8Q-nB8fteaUveigvBt2Zog@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: renesas: r9a09g077: Drop unwired ADC interrupts
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Sept 2026 at 13:02, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Remove the compare match and compare mismatch interrupts from the ADC
> device nodes, as these interrupts are not wired to the GIC according to
> the hardware manual Rev.1.30.
>
> Fixes: a82a42963c89 ("arm64: dts: renesas: r9a09g077: Add ADCs support")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v7.4.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
