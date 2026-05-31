Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1AD3233ED
	for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780241854; cv=pass; b=aIst7SYCeMc3r6nEQ4x/mUMHMwvAligzWjnbHx57+qAKaXFSa1WxbKeRhqWNow34+4tID1QmuWNEP8FnmXF34q5pYkhEzcOohUoIjsM4dQmXJ5FlVXvNYHxYeguDkxkhg4h3Sx8hsxx039BoqnXl3QA1pcW11cW+ZA7VMChtKbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780241854; c=relaxed/simple;
	bh=gLdBtrcKSaf7Yhvs0o0oobST0TYT5VJgb+CJdLI89Js=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CR/9EJYTSSpkEdG/e6uN5DKJRwn2ZYrygjHVm5p3liJRgR14OdInah6hm8JBpRI9aSYUbMPQt9uNZ2tpdtBEg7zg5DzxnDuCuz4nkmp/ia7vzp7pDeiA5z1yma21M0Rx5vUha/t/sf52mGwFn5hPy8X+eJRIkk9DavGhJmA/loM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=F+Kb6PsI; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="F+Kb6PsI"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-beb8a08a6c8so129163466b.2
        for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 08:37:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780241850; cv=none;
        d=google.com; s=arc-20240605;
        b=Or/R3pQ0LikHusmk3XpqbnD4GOkTsG8qfZMHzYg0UiiMfGEHJETI4rg+8LilIX/a8O
         GjYt3Hf8V4+cvYMpYmqSrRN80cSCmWz/HgGMNIWajkxHmswr3nbHs9Bj9GhILQHDZV92
         MOR8Zbi1Szo+Mr74GhdT9h8asuDaQEC/eMGGnpJzHTNptNZ/bpiJkajYLqrjh1bRLuwc
         mjxMIzK6DESL4+NSPFw9C1QrtD75J0Ucg6p797JKCxsiTUkAvyPhkwaQftfRzkzkbNsB
         lUIjt2b3W1QLx6a+DSfI0iRgyVVqP6t/h5Y8+xBHbehIlQMFF4MD++JATaozY08dDMLz
         FNOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :mail-followup-to:from:dkim-signature;
        bh=GsUy+RJZPWgLmpycwtIiUI71TrJ5IX3ekRu7ES5q5M0=;
        fh=dby13gn/CN9BZCoEJOkN/EnBpTaGTJif31GdSWnOhJA=;
        b=No2EYSAy+ha7UlIMSj76geNkpIDuQEzCmYz1CHHDH0UYqL6oQH+ZJ4+uuwXoB9fIEO
         lWOAXIUSuPkatVJno6iPbAHkfklvOliVdGqeskWNNk4FgY2NzK263G7ZZJRuo3ulzqgl
         95PVtk5XlRLzGcutWURr3FfnXbwbkl5STq4jLV6DDmvDwGifRncAJ3bCWt/ge28YiB7n
         KD2Q813uIZL/1x/mQhhti38AfBoVgaG6arZ4xjeGoGPqH5Pi11lIFBpKjUF38WMTbJ5z
         EtmbwVcopjTAEZdZRZ1WIKYUF/JRg5W3RNazlHEHrI7ylVU6VMzrkD+dRsSTpl5y2KjH
         oc/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780241850; x=1780846650; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :mail-followup-to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GsUy+RJZPWgLmpycwtIiUI71TrJ5IX3ekRu7ES5q5M0=;
        b=F+Kb6PsIkpLd37Ld5Vo9wjyUlJLw7KD64KAKdC9u+2ljS1uqTedhH4+7+n0v8jVcMN
         Kg03P4CKDSv+mbpQVr8MjE4HV7JB8gCg7PsZu82IU4hWwPlceyj4gTKff3QEKjGrqR68
         NEeG73xN1mmNAfqezVxHwWr4OFIsjIGx8duGb3R+f1EbHGVy8ZckwtyqbY61g3ds3jv9
         xgCu8/sjJTUAyTYGls5fPPdDcimBjjXP3Z88XBrmzmW22iJS4fbnn992IVr0KEFMeOOP
         hgrpRD3qHrOEq5qgRExBaVwc9w4jm5FLYILu4S+sOdXJgyUdTQj9Gom9PXySsIohftf0
         Dfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780241850; x=1780846650;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :mail-followup-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GsUy+RJZPWgLmpycwtIiUI71TrJ5IX3ekRu7ES5q5M0=;
        b=o18WzHBL7Ok7k+agypgIko8JpFSyp87yoP9hRl3lQSn6akNbt5Ys14+3EJFPm/9tb0
         8jquRM90Et3+1z06OW89LhE1ejG5jlPbxgarpCXRoVa0SRlemMTlMrdB9yzZUm4JZz4p
         r18G+J3W11pELQMtNbe+vofp6wIEHDPk9otO3tyvB11vTUuw0TbWGQ5o4H1zfrQ6loAf
         h3mcUeR3skdOjI9tgDuKrirJaFdTLq4fWgLMyq/uletIlx5+dlbnFNFaGRz30NbDUr1y
         hOe9kCf0VCR7gWVm3RkeKqqvXBHxwiLo16e2xkTA+QpDPYz8nmfgpR5qjZ/j/dAigSZz
         B2/Q==
X-Forwarded-Encrypted: i=1; AFNElJ+5esRmvc7MUHfbbq9/Dh8g6fCmaOxaMgiKP0t3WIc5W//ojx8wYMt/x8c96CceOK48lAw0oDS8kqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbiM19QhnpP+1tTyoRltr4kKv4jyBKJC4zUUmLDzfB2NjgeqE/
	bh84BolgA5Bvbqz7td0IGIAy49anslo63zR4Elz+KQMOkQhezOvFi4uk19A9Fn0xB1Da86GwR+P
	KLJrpWt13VUG7jNvt9O0dZ68+IVREJWp7megeRo2uRA==
X-Gm-Gg: Acq92OG6OJJB5SAwPg3F+Nlf7pjpscPibvZQjq1mNouxEMEGT2FndQ8ws//+G1RvX18
	gIUh12TZxDnsxKHmgLPt5utt/ucypH4l6dGOCW4DrsBc99cHJYUdHMo6C3uSWahI9E71boOSk6H
	1IrYW5muB+aAq5Fvg8p/xHWpTF2mauFCoqZStul9UABW8r/xDJvR6i+ke5eT4Zy4c08pTneDjt0
	uXOLqv3xXlNMPgrpaYGDJhMOVBwIZaXClLY490ILQpQGKQlUMW6g2zvppKVKOp+TWjXqLrrfqTx
	ttuL9tLtUo4MR7BdW5u/h4jl1Ex3DXHZUl4x4QTnuC7DNhE=
X-Received: by 2002:a17:907:1c0f:b0:bec:228e:26ea with SMTP id
 a640c23a62f3a-bec228e2c86mr154675966b.13.1780241850051; Sun, 31 May 2026
 08:37:30 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 31 May 2026 08:37:29 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 31 May 2026 08:37:29 -0700
From: Angelo Dureghello <adureghello@baylibre.com>
Mail-Followup-To: Greg Ungerer <gerg@linux-m68k.org>, 
	Angelo Dureghello <adureghello@baylibre.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Steven King <sfking@fdwdc.com>, Arnd Bergmann <arnd@arndb.de>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
References: <20260522-wip-stmark2-dac-v3-0-16be0ad35a67@baylibre.com>
 <20260522-wip-stmark2-dac-v3-3-16be0ad35a67@baylibre.com> <ecf346d5-a65f-4507-b277-40e75ae89442@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ecf346d5-a65f-4507-b277-40e75ae89442@linux-m68k.org>
Date: Sun, 31 May 2026 08:37:29 -0700
X-Gm-Features: AVHnY4KfVAiFLMBLt8OCHtOET5j_xWQ5bRSDD33gmCDJzuWhX0mLUD1pV9Eh9I4
Message-ID: <CALSJ-wAiLgFWStDtymqrysx=4ZFGgY+SjYC+wjiMifVKgW7QoQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] m68k: mcf5441x: initialize DAC clocks by iio DAC
 driver name
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Steven King <sfking@fdwdc.com>, Arnd Bergmann <arnd@arndb.de>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

On Sun, May 31, 2026 at 11:15:43PM +1000, Greg Ungerer wrote:
> Hi Angelo,
>
> On 23/5/26 07:20, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> >
> > Later in this patchset, the mcf54415 DAC driver is added.
> > Considering some other different ColdFire cpu DACs exists, the DAC driver
> > is named as "mcf54415_dac", related to the mcf5441x family SoCs with
> > DACs (mcf54415/6/7/8).
> >
> > So updating DAC CLKDEDV_INIT with proper driver name.
> >
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
> > Changes in v2:
> > - none
> > Changes in v3
> > - roll back clock names as they was originally
> > ---
> >   arch/m68k/coldfire/m5441x.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/m68k/coldfire/m5441x.c b/arch/m68k/coldfire/m5441x.c
> > index 5b5e09ecf487..b02ca2eb55a4 100644
> > --- a/arch/m68k/coldfire/m5441x.c
> > +++ b/arch/m68k/coldfire/m5441x.c
> > @@ -106,8 +106,8 @@ static struct clk_lookup m5411x_clk_lookup[] = {
> >   	CLKDEV_INIT("mcfpit.3", NULL, &__clk_0_35),
> >   	CLKDEV_INIT("mcfeport.0", NULL, &__clk_0_36),
> >   	CLKDEV_INIT("mcfadc.0", NULL, &__clk_0_37),
> > -	CLKDEV_INIT("mcfdac.0", NULL, &__clk_0_38),
> > -	CLKDEV_INIT("mcfdac.1", NULL, &__clk_0_39),
> > +	CLKDEV_INIT("mcf54415_dac.0", NULL, &__clk_0_38),
> > +	CLKDEV_INIT("mcf54415_dac.1", NULL, &__clk_0_39),
>
> I thought after the last discussion on this that we would not change these
> clock names?
>

sorry, seems i seen this comment just after sending v4.

As a change i rolled back original names in DEFINE_CLK as they was, "mcfdac".
While i cannot change these names above, from tests i did they must match with
the driver name or driver does not find the clock from his code.

Or am i missing something ?

> Regards
> Greg
>

Regards,
angelo

>
>
> >   	CLKDEV_INIT("mcfrtc.0", NULL, &__clk_0_42),
> >   	CLKDEV_INIT("mcfsim.0", NULL, &__clk_0_43),
> >   	CLKDEV_INIT("mcfusb-otg.0", NULL, &__clk_0_44),
> >
>
