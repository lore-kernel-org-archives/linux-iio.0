Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B852400E1B
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779458123; cv=none; b=HigHadjvT/GSMJYGXi/1JuRsrFWe545fM0aOuMcw8ZU9gS/E0qoVB5rzxvEpFP0RGDjJFxPG0OTHghZ2Z9R3zKgAjDMyzUmOwZjWu4aU6lh+Q/PyhE6s+ZOK1B1v7qjtLPe15bqIMJBCxAq64PcDnk6u3XsCbWjeP9TohJ5FUKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779458123; c=relaxed/simple;
	bh=p6FsAScfvmI00LgYGoLuomprcquQsIoplyeLI0inSTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m7cPabxN+5RyMap2jj86i+X0lqZmZIHALa48B4rS8K24pJtja9Kg60mLUjfj3fpgv3IpIt60EkGCemxd6XoFsoCqlkqImpLiU9Bk4j1k3+JdwULS8jahvsp8uM7KKn2jtdPobCLtu/pBB/av5V3Pn4Fghb/PsdRfZQMh0LU9vdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-631333ee9e4so2268224137.0
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 06:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779458120; x=1780062920;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j30cmgYlFN4mDEmlnYqRmgElSbQTzkiiS0OsZr3i+6I=;
        b=ZRzLusC80SwrgchE+n1zOKynMWsLI/p+EwmVlzMv+ptP7/Z2uX7ORUfFc1+DFO7JQh
         SjO2is8WMye0JyEbu8erhuq/ywjvs0o9cPrgeWeSLfeifrKao9zkamru91b8NGnYDjM9
         9cBaIKWM58Tp5d4Ir6mekablmZPLWvf6p+7/aSMMyxUwrFyaDuG+gXNJQ786qG+IZA5b
         7Kh3Umq0uWfN+flN6l4pE9vRx5q+g6lDw0GL+iCADFUJiXAhowuL4xdT+XrzQda19COW
         N2LDUAsYNrMGs5pbNoBjHYMJqzxljsuOwIEjoNSrBOGdMsf2biitIeBSm5GlJ0tJEwEs
         8Ing==
X-Forwarded-Encrypted: i=1; AFNElJ+XBXGQ+AmJGr0AX0BmYGlFRes0muWetkSuz+vouat1IuOb+17Y0GLq4KQaVA18oFCe374LDh8TuMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP/9vXUSwTWBAAcdFLCHGAhcdOFDWyn2X5W/RTUgvrxZv+8HCU
	TjzPHu/DECwx7RaCc9tDf3YOCBoCFSzBM5M8qlEnwNKIiM66JjbkOJ5AqA43ag64diA=
X-Gm-Gg: Acq92OGyCRsCiGz1s5Xv6iET3TiwweUllGegk7AANUXepvmiABQOM+xp/g1v8mgMOME
	tn8HjZBK8dHQZz+wNFSijeOVWkytZ96p0euCIYGvKdQZoW9JnUe3QwhnrJK4q10u2lInnMr5u1I
	kZyL6YzyNlLH685PJVSR8S5543jeo/Z1hALq7G5jZnR5oalSGG32+FsOflcuqXoGV/L9mUmC5xd
	xAHJj8O4QWgbeHP9j1H4dfU0A3Z/0qn9sLpsLTLGk6AVHwM72l6oVAW14Co5eRNs5Ln6Ya1UXgm
	nMrrqt4vUnppUj1uCMtKDcFAdSp99UhDzgY4RQ7DwfF2K/jbVfgZKcYhQKtqBnTwfJtpkX2yAO6
	Gkdb3fbEk8euIoKluJs9tnnxEyed4mQtTJ/eZDPA7qzDSvbnw3DzfvmFvYKMn/RhX2vIu+feBoF
	FJqCR6DJ6mOMHoctnzMBsOiQfrYEp4M6VAdkwfPiRAFVuVlHxiKDeBEejsupph4QdIvz95SLeEp
	tA=
X-Received: by 2002:a05:6102:c89:b0:65a:fcea:5a4 with SMTP id ada2fe7eead31-67c749055f5mr1751137137.4.1779458119690;
        Fri, 22 May 2026 06:55:19 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9617383b1a2sm1638491241.4.2026.05.22.06.55.19
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 06:55:19 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-57513733658so2501966e0c.3
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 06:55:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9/6D30VSmffuhknLEElC+jMukKkb9s0/fytEymhbfhTyjaCdcEZjaGXjgFPHddC9oARwN7Ygok5PM=@vger.kernel.org
X-Received: by 2002:a05:6102:c89:b0:608:94e4:1c00 with SMTP id
 ada2fe7eead31-67c7490526cmr1691949137.2.1779458118939; Fri, 22 May 2026
 06:55:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410163530.383818-1-cosmin-gabriel.tanislav.xa@renesas.com> <20260410163530.383818-10-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20260410163530.383818-10-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 22 May 2026 15:55:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWiJEnpfLs=cQ-j_VaFxMhLuV6YLsvqpE4bvCmT_madQQ@mail.gmail.com>
X-Gm-Features: AVHnY4LbuOPf1FKjHR7ZFR3fWcySVRSaw7vpgkocdsWUrZ7gBa__02wKZRL9zBo
Message-ID: <CAMuHMdWiJEnpfLs=cQ-j_VaFxMhLuV6YLsvqpE4bvCmT_madQQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] arm64: dts: renesas: r9a09g077: add MTU3 support
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
> The Renesas RZ/T2H (R9A09G077) SoC has an MTU3 block.
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
