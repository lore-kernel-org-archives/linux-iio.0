Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B5953B5EC
	for <linux-iio@vger.kernel.org>; Wed, 14 Oct 2026 13:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984997; cv=pass; b=nCH2WWMDjwX8FpvBfnxE4hS4t0GfrYepRwgu0ceTuqvU/a9tp16qxt01pLQLG6tVloTjZLoNTunjyAV4nENlZsH9Nq8a0gBPoUlRvIMuzxg+d6qka8nja93M8EAXkHSl8f7TMwiV6ZS+G9L0VfGPbTQ2oqs0F37/Wpdcy6ipjyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984997; c=relaxed/simple;
	bh=IT0qggrd1mARJ6zH4Bx5bdn3EzKctPth4DH9TaUm78M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6874NJRoWhSAu1+B6zNj6wGFrtPuhjyv4lmkEjRJj5eqwl/+1AebMjSjEGZvP2aBMDRXMUP9e7Gb3B0hBlwvUuMaNoZ7z8YGs/FileY5Gu0HuSp8qcgR1UsMo7jCNhz5WJAnRdBzFvhWX+0e6HMLOr8uJzWBkrJRGYHIG2cEP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=stl97STh; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stl97STh"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6acbdbc1725so1350753a12.3
        for <linux-iio@vger.kernel.org>; Wed, 14 Oct 2026 06:36:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791984990; cv=none;
        d=google.com; s=arc-20260327;
        b=Dfp8FnbusksNa7vRiujwts6aLvsMVcMzr3/Yetd4Sh+PwFi1GdmuxViZWPH8N2oFuc
         RLYxwB8SDrNWcQ6QcbnDN9xNamgx2o8TyGEXXPGtBKjRa7Ahezll1WtwxhM+6fyIAC3k
         6LmZA2vt0O29YoOg4M2OBneOHWlq7pAC70nQOMeXKs7S8JIbt2mdBNa0TzwUg9Q6kcjF
         VJ66NWOeKH6PfAkzxuXf9PFpeTIywzbEWflilDJkTm0H7QNiEbWVf3Dw6PDRl0Ae0a6a
         k+giQfmk+iRH5BZluEBNIgrUlpReRP1LO7FJX37V0hvdtnoRhf5NR0W9PSEVw0kkbfpC
         YU6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WzfJaWITDWTXbAq39l/2Sp3XytY3nCJV7TfZMBMIxVs=;
        fh=qwaRnUqQAXc4yDp7ndkqDYhgRiMGZTvHMI/fPnm957s=;
        b=e8HgBvnRPNzU+7HpaBv0MeBxQUpXtquKfS27F9mjU1r3pfZoveYf0Jtwxb5W1YTSQE
         stAPWuIXkIhUF8jXaRA88Rmai1ZPnJ+9yijKYYPmHMCECZQ4cMeR5N7qrrbBn217D216
         XEnFelsFjxPqWz25WsYFlfxVIxr6Jl9r8Rn2406q/UfqslN7k2tMzqFIEuHEpp1o96BZ
         IVWpixkd/8q0+6HbKf4LM/S54E+QFflP7zSn+j6QU5DuS20JjKZR7fm4Qq0Xz8b/ESC/
         h4C0VQAYFrxBEVw4cuZgMmco7bhbGVXtdYDqeqPg2RaYjS6mKqDxE23bFNi5NtPoVOiO
         R3JQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791984990; x=1792589790; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WzfJaWITDWTXbAq39l/2Sp3XytY3nCJV7TfZMBMIxVs=;
        b=stl97SThMAAaKpod2Yo9NGY11Ms0uA2KmHC3Qq68BTZNwq3Nozbh/f2/qLMrAmqXOn
         5c3jcejjbE8lC60StZ16+ykubS3dxO4UA8mbaJAzXuJxyXtSlJsaq76+TwUBiP4e4r1e
         dU/C/3Hty3fh34T3Zs/9Fi2kMW1m25XJOHTiIQBU0lrnhQKzQG7rB5xV8L+ArmPMHkpU
         fiV8bpzGHqByTbO9WbfPvQ7BYcEA6kipWSS1PF7J6v/4Jq/o2Ubdc3KyRKFKqPBwQYIg
         5DWLtQ+eA6KjMnd+kEduCPoJ4pBsoSm8bJquOHX7RDzdfh02iwV4FkL1eENDmnG2DET+
         WBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791984990; x=1792589790;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WzfJaWITDWTXbAq39l/2Sp3XytY3nCJV7TfZMBMIxVs=;
        b=cXUXARKFzpE3Ls72JqPhafm+RZgTW/x7HJ9i2r1RfNF1zCvHQlZbzdmwZNDuQimMOq
         gMBcbGma4h8sCQZXaHX3NHuYUxf+YY6ArgFWOGNIMIsktCj1FzVnSGyN3OXWxXoKZsJ5
         eF5MK/FFjs0S+vnKGaB5pApb6IVLlrllPG2Pg39oev9fXR1WNKEtp3PmsR2cPQdp2lR2
         LqUfwshFBuspSDBm4Q/+q5AIRGQ6KoXKUKaZKW4v1qfDy+LnFVonAjsfKGqA1cNtbFHh
         Nlg4KykTaxpKgMe3P0tYvh3UVXHVHY376e/mbZWj4crH3EUJN5jS3T8/qeQkIfbr5c8w
         Bm4A==
X-Forwarded-Encrypted: i=1; AKwUvBwIJXkKP2pFgMBppLn454KyOdr402wNvcHuxpZpnnVCosiCIogWYjEs78OP2v/S7VEr/SrxlLXCBwI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLMQoglCh6N5o0lcXc9cJGo0S6IA8gQMaxwFnjwk5GxPc3wDycy
	7/zI1vwPlhG4rQTxBkNP7+Q9HNZWMDdJjJXa7JgicQj9kQB3ITEQdcokYJzKWHNcA7iz33SB0z2
	hc67E1e6MbOlLrjTbAtrbT/EsHKPR+bw=
X-Gm-Gg: AYBFou2ZMpo5X/IDYTN+QgGsKl3KatDt5q4uz49GE3bnrwcg9wzi4GjVupdAkrLOAZ7
	TAMngjmKm0gf34QYrKtl9Q62vZrFF74B9wdxBNlLcDTdYSYE+9AHx/URNdzrSWCKKmfs55S1KR+
	/2E2X8KKm7tpLKk4/2vrpP9RJ4VaY5BpQbZ8LnDCWZ/yr4IpXJVVBqpTd5Tej0Q+cLxjIhy01dT
	pRiUlpDI9Q7Wlev9Xbxv4Zk3Q/o0doVisCbHJq3QlG+6XiyVBGn0eIcVdxTSobMPD9T/cEqJ+Pz
	el8BIjkuW0dELyOdUJdw3/dvxDsf2LYnfrU4kLFy9gaFvW7wlimcwseLgfj2oSXsffxmgwllYTV
	mmX1voRLNru75zwIKJhsustQYQnEb61S93DHgtgYiuak2JFPs7JLZQGEdLAwqNSBZ+vPe+VjFog
	==
X-Received: by 2002:a05:6402:461a:b0:6b1:e37c:135f with SMTP id
 4fb4d7f45d1cf-6b1e37c1669mr5342555a12.3.1791984989802; Wed, 14 Oct 2026
 06:36:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009184122.1378797-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20261009184122.1378797-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <as5GXPcMKe-CBLXK@ashevche-desk.local>
In-Reply-To: <as5GXPcMKe-CBLXK@ashevche-desk.local>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 14 Oct 2026 14:36:03 +0100
X-Gm-Features: AclHuK-KZvXq9usDlegpOUwMj00FdeLieTauYj8tlmG7JTbxbS1FG7D7z0W2904
Message-ID: <CA+V-a8sec-ZzMKGZJeNA-iXw-Tkt9mcXv7OoziMtjeh23BjOsg@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] iio: adc: rzt2h: Wait for the analog part to stop
 after a forced stop
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Prabhakar <prabhakar.csengg+renesas@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

Thank you for the review.

On Tue, Oct 13, 2026 at 3:55=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Fri, Oct 09, 2026 at 07:41:16PM +0100, Prabhakar wrote:
>
> > When ADCSR.ADST is cleared to forcibly stop a conversion, the analog pa=
rt
> > of the A/D converter can take up to 2 ADCLK cycles to stop operating.
> >
> > Wait for the write to ADCSR to complete and allow the analog part to st=
op
> > before reconfiguring or restarting the converter.
>
> ...
>
> > +     /*
> > +      * When a conversion is forcibly stopped, the analog part of the =
A/D
> > +      * converter takes up to 2 ADCLK cycles to stop operating. Read b=
ack
> > +      * ADCSR to make sure the write has reached the hardware before
> > +      * starting the delay.
> > +      */
> > +     readw(adc->base + RZT2H_ADCSR_REG);
> > +     ndelay(DIV_ROUND_UP(RZT2H_ADC_STOP_CYCLES * NSEC_PER_SEC,
> > +                         adc->adclk_rate));
>
> A single line (84 characters) is okay in this case.
>
>         ndelay(DIV_ROUND_UP(RZT2H_ADC_STOP_CYCLES * NSEC_PER_SEC, adc->ad=
clk_rate));
>
Ok, I will update it as above in the next version.

Cheers,
Prabhakar

> --
> With Best Regards,
> Andy Shevchenko
>
>
