Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794172433;
	b=oNLbNS3Ike5AXB3kwbxZjPkJFIV0/3mmOO+EQ7W1tvZ6ZJltzlaDKde1vB0eRv/LT/VT
	 x97nnYk0fouDuCFiajjx97JzvP1bikIIU7grheb9g0RKGsIEEzTx5hHt9TNMa4wf8UwVu
	 +AtLfyvSO1gJOJ8Ktt2CqedHLsT70fp5LlJDnizBIfLlVdyH8Ns1cP0NE353bpcoWvgoQ
	 1oX2WPF28mk60fIn7KV2FH9sDmDUNGt790sc5fQ4nfTJPt+GoPUL6GzDFDeIf9ypVsZo4
	 aBBdZZBWW744Z6MTW6gKlqdVByqEFxfT7MylzaXXVmhMjufbIOkjFthx+3w6mUTBqRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794172433;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=NfsiPlfeChHXa7FHvQGdbAbZ+3j7yl2ALAzQCNxrtJ4=;
	b=TzKu0Uy8Kqhzw8u8NEBbcUIoAYi5WiBmagGgDhO2V7WAvEQTPEfCDp0fFyrLzhmL74BD
	 k37CRq0sxusqlYV0fOcTYqA3UmMpKbnL+pLAErXNeO+oWe1fmWJbwPrZ159hPF+DFqRY6
	 UYlSrk3vtJXE1WfuKwbVKlBgitz6n7v9NBqN3ALp9S8k/xIWddpCyK8QN29+f9q8srLLT
	 zokSLerBDqk0F9yzG3G2EH7YHPJmEh7E2vHPeiQbBpXo3sWmeT/u1kwzebUq4TybXdAf5
	 ouB66tkRJKgr4xhvqu77xLf1VoVm16tMgVgfVQc+B2DtvmEMxP+s4DLo8GHQd02MItA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PhxDaZTL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0851606A320
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 21:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PhxDaZTL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0A01F008A2
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 21:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794172432;
	bh=NfsiPlfeChHXa7FHvQGdbAbZ+3j7yl2ALAzQCNxrtJ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PhxDaZTLZY29YJj12vefUX8VejuSNpYiKDMljPrZPNFItV/0Ksylb5Lbh0F0AnkzI
	 uyaoWiKLlLJAkREBTeCBDzVVgsu9zuwpU6qDMR8iMg2KActNrJZYcLSPqmyx+9CkSl
	 roZjaauC7Ph5khA6kCDq+L0BrHdeq7AbGCze3KZyRtqnJHzNmjOi37wJ0ksaF8fh2D
	 vlIJjc6zDuE4kV0nI4u6feVXLZBUO9CHOrzLbNYZyLefnfj0ggV3NqHRgBsMu/GhnP
	 0oROLr6cWtKgoduglgHVzeVCRgagD/CMmGfwiu6/rFwBPDFkVQCm7S914dnuGM2THV
	 7JVjahEJ+uSVg==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5c1479be604so124637e87.1
        for <linux-iio@vger.kernel.org>; Sun, 08 Nov 2026 13:13:52 -0800 (PST)
X-Gm-Message-State: APuU4Z+ViHUtSrSPu0QtUXLrsHsgwVlaz5ikSB6wh8FUszaU45c9wCgH
	Icz9pGxpN2wHel4YhyPzprElAjeK6QuZhV3IKL6UoyJ3lqfrDFN+ucVyYmsS4gQ8cTp4ac/cMDU
	AjanIQXjeDO8kbLJQhnrMsFrXGD9kxEY=
X-Received: by 2002:a05:6512:1083:b0:5bc:f2fb:f50c with SMTP id
 2adb3069b0e04-5c14c013534mr466477e87.53.1794172431399; Sun, 08 Nov 2026
 13:13:51 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108-gp2ap030-v1-0-55314eb7055b@kernel.org>
 <20261108-gp2ap030-v1-4-55314eb7055b@kernel.org> <20261108002155.29740ae6@jic23-hlaptop>
In-Reply-To: <20261108002155.29740ae6@jic23-hlaptop>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 8 Nov 2026 22:13:38 +0100
X-Gmail-Original-Message-ID: <CAD++jLkMRe-hNB0=8G_K5tmK6PU0H=zm1Evhm_azW=nLDa9C9w@mail.gmail.com>
X-Gm-Features: AclHuK9Xc9_YTR7KHYkysEhO-qFuV54hOhTZVduK87r-rNPmyMy5nO7aPl1v8WQ
Message-ID: <CAD++jLkMRe-hNB0=8G_K5tmK6PU0H=zm1Evhm_azW=nLDa9C9w@mail.gmail.com>
Subject: Re: [PATCH 4/4] iio: light: gp2ap020a00f: Add GP2AP030A00F support
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kyungmin Park <kyungmin.park@samsung.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 8, 2026 at 1:22=E2=80=AFAM Jonathan Cameron <jic23@kernel.org> =
wrote:

> > +     /* Bit 0 is reserved on the GP2AP030A00F. */
> > +     if (!data->chip_info->has_als_auto)
> > +             op_reg &=3D ~GP2AP020A00F_TYPE_MASK;
>
> Perhaps set it explicitly to MANUAL_CALC

Jesus the name of that flag. I just shudder whenever I
see code referring to "manual" in a computer program,
as if there is a man in there, or we throw a prompt at the
user to fix the issue as if there is a manual gearshift.

What it actually means is "imperative", as performed
by a machine. I will grudgingly swallow my pride and
go with this because I suppose it is the name in the
register description in the manual.

Fixing up the rest of the comments!

Yours,
Linus Walleij
