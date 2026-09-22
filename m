Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com [74.125.227.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BD2556BA2
	for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 15:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091110; cv=none; b=DycGFCJFXhdWvyR6WtvoNj8QQXGbcB5p7NaGy6v12P3X4tSXKon1gT/8RFNr6qvg50lY4ZnvflPTjDydUdxLME4rqwylJJ84ikgvuipD3TunY9cDtDCuhRVOHMyCbXVUnk5BMYOXEWQp1BgtWwvR0TaSSZho2l+vGmAAWQbrwaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091110; c=relaxed/simple;
	bh=/ukrFcJMdNfUbd95Oysy1/fsP+8xyb8tq0z0ZJZKRFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BVooCfrbnFaAnUgCa/aARZ0bG+lbdOiWe/AdyL2vRGiZyBazOZ+j9yEfN0+eDG17FMRejqJ2pzAc1iegdmbu5o/COexe8jt+sroKr8bxDwk9j36DggejadMDerjQJ8URH4oTjp/+6STOJZgqvN776snjrJUJ+1jE7UmHckQB5UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f42.google.com with SMTP id 71dfb90a1353d-5c8319dd4a5so1734887e0c.1
        for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 08:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790091108; x=1790695908;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=A0rEYpC8SPWX296ZTPGePNnfJTd5Ihf4si8iFoObZU8=;
        b=xDngBLvr4IhXsnNIGnoEiwSdo+570rHwbmcnIk9AN3G3xZNB2QUz1xesr/pW92r9ej
         CcOnKxUCMFgexnh/TT7OpMK0WfIENrlU4Ps1n106oh3xMwZFILeZRQt+27XBO7PTI+16
         MPIzZq7Zq6/goWefZvZWVAgM5amjF9OYYLLZPqJfItrmhaD1A2ZvKu4pRRSWSTYb/3gL
         bvvl3tiOqhezeUDIvskvGwS83EXRhCYVLvsa2CPcWUdrIpzADZx1c15psCMfoZcHSL9s
         qtkwZnERNJqFyMm2NI7UxifcwnA9eO6lTmjJR5lSsYeIN5D3DTGuh9YtVhiUPfXSuvhE
         8ZCQ==
X-Forwarded-Encrypted: i=1; AKwUvBw9ZIgIWaVjpZA/QmsrOWJXC+nmtQwR+h/l5Qmcqnb5wcCgwq6c/Fp4kWnl6ixxwN+NvWgsqn0+jV4=@vger.kernel.org
X-Gm-Message-State: AFuF++mQg8GOTLB/x+6wdtBLKVseeMxFqhDTkafPwEFkrd5WnTRK+loJ
	udCSUHoptexOa2x34apr1GSwOTJSfAWkFtWdt2teWOVUko8AVEb6jYu+
X-Gm-Gg: AYBFou2kG1vSLGzspNMKMPQ+kTc2CmYU1AzYeOsyxAVxm5HP1YZmPrf+6yKI00OHGjt
	84hiSkadBrD7+v+OLHLFDxv5o8ClUXrfbHEf8qTg8k24mUA0ggZpOBBzXPZmmlCaESs3le5n26Y
	rhmIsxVB1clliennmHXm0pnBosEOCqBw32LrlTQpyJ+I//wt43M4t/03bH5zvQzMeTkbwWH1/r+
	URy66TdkZIbjGLHJfJHZDVmQdaWRzlbBPvQ4G7A1YE0Z0WRcFIBNHcTrxk0c/jb2vdV2rNj6CEQ
	BC+Z44DyhoO9V8jcmA3mdCki7j2XZf7127rmEevuQqRtvxBmaLaQC4bZrnkrtHsL2mrHxccJnZH
	6DfvGM+XAShG3xlrKYuH7tlCRVs19kTuPGbVLxaVRTYKY2uCUdxJHvya38qxYJ4zJ2q10T1Fp6S
	zb9zox1DeRryTrBrzb+HWBLZur2x+KOH3cPPYzOm/+oKITb1gvjSib7Q8lHiY4C28lXw==
X-Received: by 2002:a05:6122:29ce:b0:5bd:aba5:3830 with SMTP id 71dfb90a1353d-5c9b579cd25mr10302395e0c.0.1790091107781;
        Tue, 22 Sep 2026 08:31:47 -0700 (PDT)
Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com. [74.125.227.42])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98516a3db78sm59079241.6.2026.09.22.08.31.46
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 08:31:46 -0700 (PDT)
Received: by mail-vs2-f42.google.com with SMTP id 71dfb90a1353d-5c8319dd4a5so1734853e0c.1
        for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 08:31:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwD/9raFjDSfzNfQumQ8ctBOdiG6lUBadCGyn9FASMjtmnc6iJDTY73nvvQGJXTxz8OxrnCCesxRmo=@vger.kernel.org
X-Received: by 2002:a05:6122:893:b0:5c9:c60a:e9af with SMTP id
 71dfb90a1353d-5c9c60af4cdmr7442761e0c.21.1790091105880; Tue, 22 Sep 2026
 08:31:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921110144.44425-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260921110144.44425-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260921110144.44425-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 22 Sep 2026 17:31:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU5srt57ABpHqXjM=hiYv+iAHBPu5LPsKb1u1N5q2ub5A@mail.gmail.com>
X-Gm-Features: AclHuK9iMHOIXZ9MmnycyGypUmOvSRrnhUAGxYcsZMveRI3d88Yc1uUP9CxLaUQ
Message-ID: <CAMuHMdU5srt57ABpHqXjM=hiYv+iAHBPu5LPsKb1u1N5q2ub5A@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: renesas: r9a09g087: Drop unwired ADC interrupts
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
> Fixes: 4ed27b4fdeb1 ("arm64: dts: renesas: r9a09g087: Add ADCs support")
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
