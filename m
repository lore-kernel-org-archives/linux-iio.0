Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39D335DA6A
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 10:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779012816; cv=pass; b=SlnGV/ddcJ4vLOCrL1n4RAS3dpVvql8ms4bDGlqVGXfChpQNw5UVVJZ8aPoL66MD0ibKYfZ1g4bzZy0s+e7TAc49IHqoLj7H14o7Kz7HHgecGTIKQUTtOA7Xnab/9PK75AyNuSrE/n8VASYPXztTzVoFy5iZGQ8Gym4yPYlnALI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779012816; c=relaxed/simple;
	bh=Ah355/SrzZrFxRMEDg0nnxbwUFNinnvYb3ZHH5bVd7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGMaFf6NX7YlNlrRprTsFezLLHZEw0uorsY5WOA2V3AGmlaAXZLikaYyF3mUXtCsNA0PZmHEOqJRf1g6o+vfc5QtKEM+mOeeTH5aMaV3LOdnlOH8mGn3dPpFSxkm4Y9QZGpEbEZLPAJJ++8BC4KtUdPv4+1IStWmLPkqHRO7gcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpiZQz5C; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpiZQz5C"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-303dbfbec77so8896eec.0
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 03:13:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779012814; cv=none;
        d=google.com; s=arc-20240605;
        b=Yvvf+HLb16ffaBL0OQNUN2fGmak0BkKxfbPafKV9DGNKAl7H7pV4LRXPju+N16ogZe
         DqR7Jl03SGUG7MqNF7W7AkQLFgJdGr3RpDnIqdjgY3y4gJGluK/jH4OmDisR8Ts2dvwh
         KrLh+3r07qrngbuA+7tf4v1DlPTAYgsgWXW4Dnbk2IWTtkw0kFdUUrzljxSJQyOZaE2l
         BBy10txYPAwCOpdQNrE8LsMpjDWCde4ifuHiWXEdlHMjQSTgKdNV584bLsltmG2+e+NS
         hyuqjNE0AHfB63FGaQkh82xVaNJ0J6A6jf+MeQ3Pg++n9OA/03eZrLF76OufcdZp00Jg
         n8rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ah355/SrzZrFxRMEDg0nnxbwUFNinnvYb3ZHH5bVd7Y=;
        fh=NIbXpLFpbJt2SvVM353nqgKBvuxTb1PdYrv6RqgEQgI=;
        b=FxtojQnS1pRviRAyG7khDUyzbbNwyLcykVjaANWD/JpDMhYOCUzxzqh4gVGY0OsCFU
         UGAtNlx0JErHmIXjd6WXaKzbrM/HH7MF9XcfhhmQw6C43zTUdANRyq1BD5WV6kxYB2YA
         KeApv9Tg5EEMW9W4zb52LqGlgyagX9m9JaaZGhxhUG5wFckZaMywoOHwzvYUyXqQmz4V
         yhvp1MoxXi5xJPFOpdfSvX5blKIZFsFmA2XAFGXicablpKPur6diPmfAtFOa+soyTb8c
         ejuymXnxg0WJwGv0J+GE9IX8dhuHNPuUaL1yRs1uEYWtraZM4FY4crOGcIi76884S0fu
         zOew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779012814; x=1779617614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ah355/SrzZrFxRMEDg0nnxbwUFNinnvYb3ZHH5bVd7Y=;
        b=DpiZQz5CG8ZsaOTOglNTkpxyCrOL2GT7MM2PeQzjC+91XVAbmvolTcCxLU63eB8NbQ
         WEI6T07V2j1xZObTgOmqSnbrokDXpO6061B+NXhy4sDdEPgT5a+ubEBxizQ9myDYGlWC
         O62zgIwpFxpPyLkH4EhPQqjEIdOWArEJXc7t0mML/K9fj+90Q+Qw71nRr09oxaXeqquh
         J7egeAQ7ppT4Va5M2I63q2c6XcGN9klLocWjLb7ZYA9A4LNa6W9Uh2Bm5Y2nQku6s9lA
         TgqsXMrnoAr8q01O+m4luSM4rbXjhePOOY7jxaFcDRXNkWopcSeGTB6F6pa6n0Qh3K1N
         t1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779012814; x=1779617614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ah355/SrzZrFxRMEDg0nnxbwUFNinnvYb3ZHH5bVd7Y=;
        b=s5bUUSExezEgozZniDGqWZ6LiUdDzy1o83MTXNe7AO6Q7AX+b9MLmitaRLkvpTJieo
         HrkBNTCXPsLzuf/xTBmrySg8jMxsjGjx6IrFnXrTGshhSoxyeoAD3clIQs1EqFCE7vDO
         oX/JBUCgcJodft6Ld0OintlX9QYtJc+Cc0uGnF8Ql+tr3sg0gn5IYUn1N/+la9qmKDIU
         UyZUSjJTr0nzmtBWG3zuBmKwH+dnor+4IfXBxCWDN6Q+m515l2bbPswhQ0jfm11Z0htI
         KLkCKfUKR8to4rAJNSsBs3uwH/F+ZajF4CHNXr5MsPln6QJB+ZqYFaB85oz41Wm26/9J
         xS8g==
X-Forwarded-Encrypted: i=1; AFNElJ+eBvlU8TxnHr2Cef1ea2XLafxT64aG6/MWcSwg0hx1r7zIM+aKC2UFc9qLcx+xQ3aaQELIBSCPFcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPjdWcIdbiZvibLetlzD/jsfeZgSn11r6H4FcaC07C+ExEQNNb
	EK+vreuB3ja3u3LoqSH8gfMNpmoc/mGc4BuJshtnmhGfSRp3yG2Rs0Y47PovrvB3NL/1I2WW8uO
	LSvPTWAb5HADMZzsERgi9knqOlYU0H1U=
X-Gm-Gg: Acq92OEni28m+nGT37Q9z7+tuVCUB5JjfnbTF5Wct4sh97mPwzT+G202kszitCYNgmu
	vMT8f0YVKwzy2zmq/86JatFss7psprzKHbX0BY+G3cvcEmoZNALecVq1UCxYhLlqXdoMiu4BnHX
	zMDIWr/aFMUge/qHCBw6F/r9O4/tQmAvIh04CtUrBicv/JWKWhQdyrd00LkleUmSVGmKkGf+a5E
	E4dWDIaB8+Sc+sHflskED02Zteg7hSfo1VF0+EzMnwL2y3UPYr8gioaVBLjIngUGttM0OD6r8b8
	JtTjwSMZMf+d/pxrC4s=
X-Received: by 2002:a05:7300:8b95:b0:2e0:1f09:d924 with SMTP id
 5a478bee46e88-3039813cab5mr5237843eec.5.1779012813884; Sun, 17 May 2026
 03:13:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517074306.30937-1-clamor95@gmail.com> <agl1T8O6kwP7SFZ1@ashevche-desk.local>
In-Reply-To: <agl1T8O6kwP7SFZ1@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 17 May 2026 13:13:22 +0300
X-Gm-Features: AVHnY4IqE6FsGFbbFI5FSmJMlyOUEK62QOSOEKabbR3m07ZeyolRt90bM2zxkWg
Message-ID: <CAPVz0n0tfbwa1AbgO4eKrmNunHvmTFLDqXDFd1=VfLayuafH8w@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] mfd: lm3533: convert to OF bindings, improve support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, 
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BD=D0=B4, 17 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 10:5=
9 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, May 17, 2026 at 10:43:00AM +0300, Svyatoslav Ryhel wrote:
> > Convert LM3533 to OF bindings, add missing VIN supply, add support for
> > setting mapping mode and LED sources based on device tree.
>
> How is this being different to
> https://lore.kernel.org/lkml/20250218132702.114669-1-clamor95@gmail.com/
> ?
>

I have decided to have a fresh look, this is continuation.

> What about this comment
> https://lore.kernel.org/lkml/ZmBcvtLCzllQDWVX@hovoldconsulting.com/
> ? Have you talked to Bjorn A and Johan?
>

No, but since grep -r "lm3533_platform_data" * gives 0 results there
are no platform_data users of lm3533.

> --
> With Best Regards,
> Andy Shevchenko
>
>
