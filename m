Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com [74.125.227.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1163A0B3F
	for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 09:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789639202; cv=none; b=sfm6jsCcMqYgxfx8gPbyefcrmTUun/wld1iO9LVm/9lxlF0ycfqmaTuq5FmfaETkdPBjXBksSso281/+Lc7VIuIwoOctDVFZXPQArpuaSWtsV8MwFQMQV3lyDHJZv2nz5trKt04zBrXnjk4Gzo0xD2c6NO6QOFiN/hlE4jeITLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789639202; c=relaxed/simple;
	bh=lyxCvXomazoscclUR0t4ky/vHCgm3jn4yYZm7vcNMNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CM677UzoPrthVrgiaajwFM8WRfj4pC88H05FMrfjs+EKFpQaJ/3wdaycuh/b/zbcpkYAcGQ6a9+Fx0+KhsRffRFJ1WeRcBy+kbbYSxqCN9pRDh7ePXEDGm/HoyXUVq9eLbozkfNeOITxWrAW6QoUYi/LierFZdgx2idyPeUc2LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f42.google.com with SMTP id 71dfb90a1353d-5c98e1942dfso410875e0c.3
        for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 02:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789639185; x=1790243985;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=s008ZoScdhr7BNxJ8Chjjcs4adQQJjIUFRUX5dqGglE=;
        b=pH5glnwiewYF7C5bLomR02Q2k31yHMPHrxK3dmMhegiCleu52iDHvIj9+ZmfN04PXC
         +mnJ5+xtGQaayrZTInysgbT60O1h/Cwy1mKXqf7u6sniJBl6FhYn8KbqTO6SvDbleqgn
         tYqIGAPU2tyFPmoHCrOgy0VBT7/FALpfsHJdNhhe55AqQtcWuJ/yotXla/Bt7VZ1biR3
         7OYd8GRc2IST8u1Je5gDvHj16clQ+ac7tlRkWFfEnBBpAwQcLOfSIwrQvR3Eay/fIW5o
         aC6F9Dh2/HTPW8lOSRtb3NvMXO5FAlziB8X7FoaGDQgfKZCPNJuMIdz9UTlH1gDnwccc
         3G+w==
X-Forwarded-Encrypted: i=1; AKwUvBy1rynwg/zFan2a1m3V0P/iDFAFeL9ial6/tgTGc5xm2XdrEv5VUs3DkpIIt4xxvhNpHEBNgbZQKS0=@vger.kernel.org
X-Gm-Message-State: AFuF++lst/Z3gROVhBMbww+rOo7CEZdczXhiNb1rkeyVBjft8PyMQMmn
	TO4aFY/826cyOsgfePe1Qx937VhCFwUg6JTyKIIDeQO4Hv3liT6husRfW4HP01NxvTo=
X-Gm-Gg: AYBFou1UvYlQrSMW0ryjAE0GVYqD+8QkEnGLRvR1a6fbLBk6Z63GssFh96lxYX7wOa1
	xGdaAenGUhK+YxKaOgx5o5b/5427zhD56aQe9SoYTuTaz/LTmk0EwrQM3umaTfQEOIySNzWqInM
	7IBNDuFYZiYkmCII41dHr0ueHigokc1oDfppG7lJTYYNtrpCpOYZXlGpnJifUVq0U0qNRzLTT0D
	6whnz5AvappwFbFAkPrle5FvxtQ2DTO6nQfjgtZ2+Px8OLT8epDBFnshpsGzFpOSKOo4KdlD5Pl
	WRn6ebbLrKci9V8q+opakK/HcagGATxvyeONPVlEMDO8W66U25bnW/lRAaIi/vaRtT02p/LhSjx
	s2H8DY+Ab4rj5c+6YomK9+hPsE1tc5iWhYz/56IigDHen3mezshhnDh1XwPH+x0eMOUo6F6XK24
	n8rRp+0KtHJkLeBJoCYbaSN2NQo0hiqHdnKBOV23b1A+Ml2sYHLIcWMiiWxLjwROzDQK3dZNrEH
	jzBYT3dnsxQPErHtuqURUOUcnIOQ4Cc7qUWGadAaT87bthT
X-Received: by 2002:a05:6122:893:b0:5c8:2a47:b111 with SMTP id 71dfb90a1353d-5c99ae06517mr6338658e0c.3.1789639185456;
        Thu, 17 Sep 2026 02:59:45 -0700 (PDT)
Received: from mail-ua2-f43.google.com (mail-ua2-f43.google.com. [74.125.226.235])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c9a5399d46sm2117283e0c.7.2026.09.17.02.59.43
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 02:59:44 -0700 (PDT)
Received: by mail-ua2-f43.google.com with SMTP id a1e0cc1a2514c-97eaa1155b1so338055241.3
        for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 02:59:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwckNyJZVXY21f83E26CBGzPe+yYaWjYLKaQUvMU7lEZEySFRRy/yla9CYzH5PdB3UZXHvEJWkkgaU=@vger.kernel.org
X-Received: by 2002:a05:6102:161f:b0:79e:cc38:c40b with SMTP id
 ada2fe7eead31-7a0285a1f25mr6780296137.11.1789639183155; Thu, 17 Sep 2026
 02:59:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910085430.3173166-1-cosmin-gabriel.tanislav.xa@renesas.com> <20260910085430.3173166-9-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20260910085430.3173166-9-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 17 Sep 2026 11:59:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXFVd160eAuWAcxqvRWUnCHZXshCZscnRoYdiZGCzBqHw@mail.gmail.com>
X-Gm-Features: AcwNN1V3Cad5Rk6IGr1bTFS9lb5rrCjt1yRBSqziGUl61jF7JvalYEJw63TOIlA
Message-ID: <CAMuHMdXFVd160eAuWAcxqvRWUnCHZXshCZscnRoYdiZGCzBqHw@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] arm64: dts: renesas: r9a09g077: Wire up DMA
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
> RZ/T2H (R9A09G077) has three DMA controllers that can be used by
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
