Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E774A3F8254
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 13:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784293599; cv=none; b=i4wNJnIoxNz3DIdJWgg5o+Sx5OFSevi43Uy4nQbb+6b5+Ma6+jt2CtJLVBYrfbfX3JAztEQwxF0U/d/JSI/CD7FuKDqM6JXNlXscEg03fJ3qRx5oz17Mg3ble51v+BPwrbYwJl5n1uQuYP/MDiR+D0TNoXV7Jgv2Z83/3CVsy/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784293599; c=relaxed/simple;
	bh=7Jsey1+8xTkyIYChgC6IDNSN2QeM4BwOld1GnQeJuoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SR3PDxyzAxwL1MlrDCKBf3TicQDjMubW1ZwfiDY8XdZ5DlDctnpgX3br24YTUiE3iW4pu4rijmQHy/+dis/AD04OKqB+w5iQ40v4We5r3A2RxP0zq4tp9zDKTuL2PlbDRDfQbg7Mh5Kk6knU8Fw880JneUTL+aiPpBoo/f2+6LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCShuLEo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCShuLEo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6B61F00A3A
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 13:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784293597;
	bh=mamoyFKjWvwAuu0GxO6oNdptahRz0WsLGovVsb1KAic=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RCShuLEoeLiLiieUuzg3cC0Ahs9bSguy1LIoYnrIkaUhnloavxbkEmnUcLdHDcXtn
	 TFY/BJ8mu5wbSKaNwlnWcCYOEKU66/yzUJCJNHk85YJIeMJD/IyiOaAfAQPuJcP7XH
	 em0fFXG69aqY53k3a85wUf/y7/byv43YRYh6ptW//iTMkmk1LclbTzOpU7N//hhzvT
	 323dUYxRht7EOlhCmtpNfXtinxe/7HdNwNWR76pDec8KwOVWqZt1bKm7XuNfQwv9FP
	 WFMmVx0E0m7BfjTVmTKBd/Hr5X5nnRogGjJBfA2ftKe2oZ3HGSWBvcU7juS8ham3Wr
	 iUgZi/PV6I4NQ==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c1600d040e4so254781066b.1
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 06:06:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqMNZXyARkVJ3rTACxzNEF5xzl+EeX+S/A1Mj1qJw1H7RUzG8C9ofNVAGqd93GcV5C40Uv6WmAH4WM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg7r9/i/mC9hGM8XuGcbUbOU8zHaNXKFLgChXxTuo4lHh9eRhs
	wgKBeRGMszEA6xIbYGl/gmlrnhmvypxBgojvI8B83S3mJ+rLKcoaFIwGYWuo/Y00M59Fp7gh1f/
	Lnz8t5lFcCKP3EUwUVoYCg1Fz+FEJtQ==
X-Received: by 2002:a17:906:6a1a:b0:c16:ab18:55bf with SMTP id
 a640c23a62f3a-c16b417051dmr138404466b.31.1784293596209; Fri, 17 Jul 2026
 06:06:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713081127.115197-1-cwweng.linux@gmail.com>
 <20260713081127.115197-2-cwweng.linux@gmail.com> <20260716174237.00004b79@oss.qualcomm.com>
 <8d757505-ea93-4dd4-a374-79f143f6f949@gmail.com>
In-Reply-To: <8d757505-ea93-4dd4-a374-79f143f6f949@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 17 Jul 2026 08:06:24 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+5N9AvzQ0cxUVY97Ad+CasR29Fan7sUuprDYjgqzWjMQ@mail.gmail.com>
X-Gm-Features: AUfX_mw6LJXrxe2IQurrdLfm7PIOYMWKcR5ywCkgwLq8okgu2522Hbb9oiRx92U
Message-ID: <CAL_Jsq+5N9AvzQ0cxUVY97Ad+CasR29Fan7sUuprDYjgqzWjMQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Add Nuvoton MA35D1 EADC
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, jic23@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cwweng@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 7:59=E2=80=AFPM Chi-Wen Weng <cwweng.linux@gmail.co=
m> wrote:
>
> Hi Jonathan,
>
> Thank you for the review.
>
>  > Not sure this doc helps. What are these interrupts for?
>  > The driver only uses one of them so why are there 4?
>  >
>  > May well need interrupt-names to allow gaps in the list to
>  > work but hard to tell without more information.
>
> The hardware has four EADC interrupt outputs, ADINT0 to ADINT3. The
> conversion-complete source for each interrupt can be selected through
> the EADC interrupt source registers.
>
> However, this initial driver only uses sample module 0 and routes its
> end-of-conversion event to ADINT0. So the binding does not need to
> describe the unused interrupt outputs at this stage.
>
> I will simplify this in v3 and document only one interrupt entry for
> ADINT0. If support for the other ADINT lines is added later, the binding
> can be extended with interrupt-names at that point.

No, document what the h/w has, not what a driver currently uses. The
only exception I can think of here would be if only 1 interrupt pin is
usable on a given system. Then it would be just 1 interrupt with
interrupt-names to define which one is used.

Rob
