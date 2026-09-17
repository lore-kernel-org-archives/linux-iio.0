Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820F94B827A
	for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 10:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789639221; cv=none; b=VEVMb/dTLR2f1829F2s870ie98r7PD/q0Bz3KPcwYf+YXWjv9zMpTz4WUpRllofdD04qJFCimLpXtYdlTmCPdaxjPfv4YLy0iKWLmL+SwX4crOWHxD2fK4IT+PSedkl7FSpmsdjyj8hikh0nWp9d5mrApWF1qxmloQOU287t2YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789639221; c=relaxed/simple;
	bh=paeQyicGy4uOJnj9MMiYfbfBIScuQX5Dy7auLPzshnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XW71G+5PXs0rWYkR7sUciRbrqMU1m+n7jsiNC+Q/BLbjKAMPMJuMRkrLhUgighbqLU4nVOhrXc0btqAef2xC1zMeJzeVMkcqJ6Ag17wgniHIBNcgINkVY6ufxdPFc2AlwqJYcaXr94VJ4LVgQmFVEnpxW32WYcUk/GOuwB+sdic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f12.google.com with SMTP id ada2fe7eead31-78569cf871bso382466137.2
        for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 03:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789639207; x=1790244007;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PgwBsZe/a4Fuzb0Py083b181bySHfV18F3y848rFS0s=;
        b=v7Kayk2yB8TUHeFKD63v6RjKycPTcbqE0Vn65U8773sOkHTwgNsYnR118srBWrVilt
         /HstrM7Nq1vsSNFN6W4qHM77JuUF8x+22cN9pUl3E8XUYWpAxWvXAFdbtOJQX+pms+Hi
         dukCizSO1eDsu+rmlthDeeayJPsp2/F7ixBtTLWrLOvxTViWVbVLSbTLlmtl3j25xJXx
         R8YHW+yYijAVnBlRVg97TIft4c7u3B2l6Ws7l/Oxj+wwLx0loDOGIbXH5gnwpSvtAAGh
         tn0eRH5xpYwz23KNIqSz6Lu97VRu4phzqpyxJfy+hxNAUsUQoVmdaflnsZg4Ed1rvh11
         R/3A==
X-Forwarded-Encrypted: i=1; AKwUvByJufQCHKCwzCkg3Bc+g56Msa3wRpy7MNPSuIqpDYL3ukgeSf6Vpt4SY4RB3ENn6sF/eRYQowQXkys=@vger.kernel.org
X-Gm-Message-State: AFuF++nznV6vEqtFVgJQazSThWYnIfIEohbI7g0XYunJiQwZpp8xjkob
	8grwKAjnu8nZM1kk/YOFiL5rOKnZritrb+vlG5PUeu9qO1LeUAK3UbDO4cmkXlgAY/w=
X-Gm-Gg: AYBFou3LqSeiHfqhEv80fGj2wpyXokicbJV3GSEbW1a/qn0zvGLb51mCMnq9WFbQr2E
	layBIq8aV/dWOd+caqZw1rl9hi+JXA6RNbvf64hutXq5LBjNIIiv72rlnggbGlcy81csdDkn/8E
	R4uQvSaPR/OqUJIrjwS9ILECWGR8eTA1s2WIXgTUjzf58xbnTqqtNxl7xcv/sl03tFkICNopH3c
	cAm08BlD4yYOpHVwq9jReEAl1m4gMQbO5etV2/H84Qer/KtmarkruML1k0QVZF3ptApuj4gy/Rt
	qLPw6ThAbZqKIIeiKqUkUKX4ADGaSGYhihestfarYa/qReLUceZzwHKTYbAFXcluiy+gZKvqBov
	bA59M1caII9vhGL4R8H5wfJaYKxy9wre1YH4rhPjbOoG0pvcT92sk+C04CiFunWhG4X9rR8owbC
	2OShf3CHuEVd/VMc7hbDxXERdIopurMAvM4OzOGCfJKda6OvW1caBMURDqt+EMBxG/I5Ta9rKFW
	KCa2iBaZ0WQcnPmy3f0KIQDIsbLEeyFkhGM3A==
X-Received: by 2002:a05:6102:a46:b0:79f:9ffb:adb9 with SMTP id ada2fe7eead31-7a201f9fd87mr804027137.5.1789639207057;
        Thu, 17 Sep 2026 03:00:07 -0700 (PDT)
Received: from mail-ua2-f32.google.com (mail-ua2-f32.google.com. [74.125.226.224])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7a1df5ee249sm2597218137.2.2026.09.17.03.00.05
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 03:00:05 -0700 (PDT)
Received: by mail-ua2-f32.google.com with SMTP id a1e0cc1a2514c-97e97e2c7d4so323658241.1
        for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 03:00:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxMBp7PUzN9EM80jVpBw+VPIiPImSoD71DX4ujD1GL3cJmUliXWwkdgVJR8iEb04PxebGYLxqhk6tw=@vger.kernel.org
X-Received: by 2002:a05:6102:9d0:b0:7a1:f7d2:e826 with SMTP id
 ada2fe7eead31-7a2049c966fmr811148137.31.1789639205042; Thu, 17 Sep 2026
 03:00:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910085430.3173166-1-cosmin-gabriel.tanislav.xa@renesas.com> <20260910085430.3173166-10-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20260910085430.3173166-10-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 17 Sep 2026 11:59:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWcPMD9kzEUbkZofv6O6EoCz7mZ52Rp-ennBYP30v9-Yg@mail.gmail.com>
X-Gm-Features: AcwNN1XQBPUy3BHOan6ZOGxBXs0JV-45PEV0B5RSS4MUAdKXHpMlIwNQ2uEPp3k
Message-ID: <CAMuHMdWcPMD9kzEUbkZofv6O6EoCz7mZ52Rp-ennBYP30v9-Yg@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] arm64: dts: renesas: r9a09g087: Wire up DMA
 support for ADC
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Sept 2026 at 10:56, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> RZ/N2H (R9A09G087) has three DMA controllers that can be used by
> peripherals like the ADC to offload data transfers from the CPU.
>
> Wire up the DMA channels for the ADC peripherals.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v7.4.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
