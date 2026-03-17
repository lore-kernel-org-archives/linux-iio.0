Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3797396589
	for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2026 08:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773735827; cv=none; b=CxMwsbnoNvsDudWRyjEg0296MHmw4uZ+LlFATovDZeI8pX25oC84REXZjzXmRKcek1l/Ma+hRYk9uz/Zhe1FyOL/fCwFq+lt9U1WXZX7W1paLsXrcPZ9mKdoWSrPZAlhZGUMfsedqKK0hWiu/zdFFoqW4mprzlzC93PLY6ryk/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773735827; c=relaxed/simple;
	bh=aTR0ByVDp5twPVDF0We0yxjjtWE6HL5DaVZrXfqb4cU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NnGBEHFbx7/cBw8OsBt/O3Su0w55YiZjZoIDXGyhjO9WhFuAfklRw3UYnuipd9YrcN+yrWUz9WxKyTuvWvujSD8x7pwwtKDjx2A4RN8ULK4BWvi0Jbzzj2XLbmBddJxJ/VlgKvesuZgFIBUaMfBd8lJftFG/N3fC6thMzMbcbMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-56b7fce3ae6so529623e0c.1
        for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2026 01:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773735825; x=1774340625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BWsLLpeb8S2Ruk3mIA0NNiewV90E5kBU5fFfxw9bA0=;
        b=ltIpIM7Nl3sI46u2V3vbpkAc8HQI18DUJPPzeUUe4dInbmKF2HS+neQxAp//OpoAQF
         gbaOLadm5YM8POFRG4w1RMOPnJPlmI4i9pDCt+3MgkWgqXymUDdrsbgobtnEQ0B3o4MY
         nL9lGHgOwdy4ikPcqaPHSJZq7aDn81ymWyzRHWfCE/Rmh+MsxIsXWrk6OZoI1K7mHeHE
         ifeXeWnhwQzrfxYKWIucu1gjOzwhqtBPyFrog1zVrpo/hjsFbl0Ta2rOVpn3OVeOZQQG
         +9acMpN3Dp23nYKmuRILRe56uwq7KF02ET26/IOIU7fkY/ovcdLALcCJQlZ5e/I4Nd9I
         Rhzw==
X-Forwarded-Encrypted: i=1; AJvYcCVG+aYM1EtbWLwVT8CoWACq8mZ9WdIRXfvCSgC9TP1USdX/aDik+rb1uPQLEyBde1O3+rvnYd6InBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFhaoSiH9C/9v698ESavN1NP/5yPtBIHhZekBcbOuB4Rw4z+3k
	a799slrJOC491WqkQ5zCpZQkpWysDrmAnvjbeZlMJ8N9N5YoCSOvwr2Z4FVfSFS2
X-Gm-Gg: ATEYQzwy0rIZ7EOPNxuR6T7utEd4Mh0zUuK61MU4DHpXEznIkAfZzPk/Z1NPyMsJAP0
	eb/+mM10Ge0kK7UxBrVNcB7nWuYwDvIEbcxNDGm+jGWbPIFQBuUNT9cAxZcc/kePMhh2+nKJi2R
	IAOThbW94rcug/UBxPo+qHOJMqeuzk7BsrYRzFD0AfOU2seQ3mSkc590WgilPjvuD5gtuHnBRjf
	TgUOc9kEUMOEpdkpFxfR2cXsRjMN23poSywq80hGJJ4cAa2DvYhyQ5sTCGAi8dPVzxr+Mj5UyJO
	rxxOFZFKpAjSyAwlDEXB3vVqNhrUqt6Fxq3Fick4GqcHrx+uUDLJo9XlPIN/IsS8JWuPgKYOR8Y
	dmwV/Iano+L3LpF9o+TDKnIriO80nsUbmCp6aT1UtxvK7DTZ4ronwfMw9ni0Grjh/WXvYcqscBj
	mTezhDux8MmaxrMLT2koUX1ZzN3xVRbxFrC+0lqzsDhMQdmosAT1AUUb3t69n8UYJGSgtHHXo=
X-Received: by 2002:ac5:c00d:0:10b0:56b:9534:c06f with SMTP id 71dfb90a1353d-56b95dad5bdmr872155e0c.3.1773735824737;
        Tue, 17 Mar 2026 01:23:44 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b4646bdfasm9323949e0c.13.2026.03.17.01.23.44
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 01:23:44 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-950c26b6b05so332483241.1
        for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2026 01:23:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW4sX/K/ptux2GAFO02yrToAifR86JTqayqxLYjPPy5LQxmRXzcyccNX3peu/H6DD3TDRnL3dCPyOI=@vger.kernel.org
X-Received: by 2002:a05:6102:38d4:b0:5ff:de83:3e46 with SMTP id
 ada2fe7eead31-60263d8f933mr1167606137.7.1773735823847; Tue, 17 Mar 2026
 01:23:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130122353.2263273-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260130122353.2263273-2-cosmin-gabriel.tanislav.xa@renesas.com>
 <aaqTVDQa7xn70bR_@monoceros> <TYRPR01MB156191C8E77BDA44AE23A7D4F857AA@TYRPR01MB15619.jpnprd01.prod.outlook.com>
 <TYRPR01MB156192CC838EC0B3DD66246158540A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
 <CAMuHMdVqqGTmxiKRQBbphw8KmtG66HLaZhDVvtSK81cfiMsXcQ@mail.gmail.com> <TYRPR01MB156193245985A82B792817FE68540A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
In-Reply-To: <TYRPR01MB156193245985A82B792817FE68540A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Mar 2026 09:23:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV6c1F8eVOi6bQssq3qsBcpGnQ-cT1AeXLqXXYEgK4xrg@mail.gmail.com>
X-Gm-Features: AaiRm50jZRADgQIXJgbrFUg4WeDPSzcNuPJxTTXR-hiMiTGwpkXr0IAMZW3mmeM
Message-ID: <CAMuHMdV6c1F8eVOi6bQssq3qsBcpGnQ-cT1AeXLqXXYEgK4xrg@mail.gmail.com>
Subject: Re: [PATCH 1/5] pwm: rz-mtu3: fix prescale check when enabling 2nd channel
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, William Breathitt Gray <wbg@kernel.org>, Lee Jones <lee@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Cosmin,

On Mon, 16 Mar 2026 at 20:13, Cosmin-Gabriel Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > Sent: Monday, March 16, 2026 8:26 PM
> >
> > Hi Cosmin,
> >
> > On Mon, 16 Mar 2026 at 16:52, Cosmin-Gabriel Tanislav
> > <cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> > > static int rz_mtu3_sibling_hwpwm(u32 hwpwm, u32 *sibling_hwpwm)
> >
> > Unused sibling_hwpwm?
> >
> > > {
> > >         if (!rz_mtu3_hwpwm_is_primary(hwpwm))
> > >                 return hwpwm - 1;
> > >
> > >         if (rz_mtu3_hwpwm_is_primary(hwpwm + 1))
> > >                 return -EINVAL;
> > >
> > >         return hwpwm + 1;
> > > }

> It's funny how even after triple-checking the message I was about to
> send, I didn't notice it.
>
> This should have been what I sent.
>
> static int rz_mtu3_sibling_hwpwm(u32 hwpwm, u32 *sibling_hwpwm)
> {
>         if (!rz_mtu3_hwpwm_is_primary(hwpwm)) {
>                 *sibling_hwpwm = hwpwm - 1;
>                 return 0;
>         }
>
>         if (rz_mtu3_hwpwm_is_primary(hwpwm + 1))
>                 return -EINVAL;
>
>         *sibling_hwpwm = hwpwm + 1;
>
>         return 0;
> }

Thanks, now I can see what you intended ;-)
As the output parameter value is unsigned, and never very large,
returning that value or a negative error code as the return value may
be simpler (i.e. use the original "bad" version, and drop the unused
output parameter)?



Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
