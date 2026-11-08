Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794154148;
	b=fHsGdCBO5g+clHSb79gEcKZ7RUt+UCapuH7iGtrKIINtb3fHCBPyftYaf6Qv+gpW4loP
	 UuTF+vo5csOOGzKzqcQFRwb51vdSRWHyMbmuwpkJ6y5QkiU10KTrF1EyDCpc2Uo8vZ11z
	 GlOnuywTsvVbDjTO1hOHImK/glOkut6MKblrksN4+B8vbwLpnvmzdvegeAMNdn7ZUNBeb
	 01jeRfnHSi7jdJMv+AGGxARsBJq5E3yswkVWASLEeoxku6EHmHjUbSQgdZU634Oni6vvS
	 tj0KALrnphUjoL5mJVAz2/gjBsK2t6ZCN851JLLJGEZT9MunplYkkNX7OFrjiQH4z8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794154148;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=SQe5jbD/zyzZ+9qfy+XHKm+jJlq4rsLg14mHaCfHlQE=;
	b=nNw1+EbMqKOGGE7/RIVf2fMrkyJoGAtRgq1YX4Uk6xtRDM2E/qpg0h7XAMXgG4RNDiOo
	 Rszo6KppheMXiGO9UJeyQ+vxLWewTf98a4qzJ0bgYMgt2UwNWzaiYow2vcOmGDOPoKSZA
	 iQXmAOa1zLpr4ixdLmqjf5y4+YH07yByEzDbA673u7frEZtEVwEgjKII1v+QTcmZqtSl/
	 lYDKGpUOeg11hJMYe+JLdASjbXOJ1r6bh4udY0NvKZINHxbzzOETm4TjfQDzPkkgbqwBt
	 uzWNVP11Zj+O5KCXc5rnugubONmG8MgJc0kv+SnG9XbX3aYu49a9jsI2GM+57YlraJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LYqbHS4R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E08606A31C
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 16:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LYqbHS4R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F7C1F008A6
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 16:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794154147;
	bh=SQe5jbD/zyzZ+9qfy+XHKm+jJlq4rsLg14mHaCfHlQE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=LYqbHS4RfWZiPOL1YPi2Wh1HB7z3oQkhtZskD838VdFop50hFqbF77o3as05gkllm
	 hQ7cwH1A2thyBJvEsGuu3E34m2SjFPQVDPdi/KPe7juKtrRXpwRw4yjOwZJJJXxBoO
	 gKg23K/iOEWZmtjIXNTKa5wGcRYlJXfWz2qnxSXO/llxyVUrCRPCDubq7WaDsXbhvV
	 BoDaSQi7wCXY9qiiKuC4XrqrHUAol+F53aKvTfSCrOds6MzJk9SuKcxIPCfzRblFWS
	 SgZEoFTecFHqGLhWTnW59nSZRxpdWm+crzWpQJ8R7ROXWlObnPEvAvbOiOrgyyF2nr
	 QC28vsg283oww==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3ab46699a09so1513661fa.0
        for <linux-iio@vger.kernel.org>; Sun, 08 Nov 2026 08:09:07 -0800 (PST)
X-Gm-Message-State: APuU4Z8DjRVrQnnHw0RBzkbOmdseA77MaUu/Mdaekm4brJpRcZALz2Ru
	AF/mtp7opwSoWfBoqIxumMyl2nvWXBj9K0iuBbjSS33WbMwW+KII0sMS4SqTgjb9hKEqjlfp9p0
	nuskfq0tuGmJ1UiV8//YW2AFQ3nkPH9Y=
X-Received: by 2002:a05:6512:4018:b0:5bf:f8fc:7b5e with SMTP id
 2adb3069b0e04-5c14c021361mr438569e87.55.1794154146533; Sun, 08 Nov 2026
 08:09:06 -0800 (PST)
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
 <20261108-gp2ap030-v1-1-55314eb7055b@kernel.org> <20261107235827.02951362@jic23-hlaptop>
In-Reply-To: <20261107235827.02951362@jic23-hlaptop>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 8 Nov 2026 17:08:54 +0100
X-Gmail-Original-Message-ID: <CAD++jLm6Ch0kLCxf-rd7R8UFnGjd_ij-cxVOM=vhAguNSye-sQ@mail.gmail.com>
X-Gm-Features: AclHuK8iI-CaRdJHPlnZpNc5__iuWVfECSfYTdAhoz7ptvyeATcnPbJbCcZe3K8
Message-ID: <CAD++jLm6Ch0kLCxf-rd7R8UFnGjd_ij-cxVOM=vhAguNSye-sQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: iio: light: sharp,gp2ap020a00f: Add supplies
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kyungmin Park <kyungmin.park@samsung.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 8, 2026 at 12:58=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
> On Sun, 08 Nov 2026 00:31:33 +0100
> Linus Walleij <linusw@kernel.org> wrote:
>
> > The GP2AP020A00F needs a core supply as well as power for its infrared
> > LED. Its I2C and interrupt pull-up resistors may also be supplied from
> > a separately controlled rail.
>
> Hi Linus,
>
> The infrared led mention made me think there was a separate supply for th=
at.
> If not, does it warrant mentioning?

It is already in the binding, incorrectly named vled-supply.

A later patch clarifies that this is the leda-supply.

(I saw that you saw this too ;)

> > Describe the core supply as vdd-supply and the pull-up supply as
> > vio-supply. Keep both properties optional to preserve compatibility
> > with existing device trees that only describe vled-supply.
>
> Is vio supply wired to the device?  It would be unusual to describe
> a supply that is a pull up only one given that would often be a character=
istic
> of the interrupt chip at the other end of the wire.

I guess I managed to look at the datasheet for the
suspiciously similarly named GP2AP002* which as separate
VDD and VIO...

I think both of these should have VCC only.

I'll fix!

> Definitely after input from one of the DT binding reviewers on that aspec=
t.
> If there is precedence for this good to call that out.
>
>
> >
> > Link: https://global.sharp/corporate/news/110721.html
>
> What is the link for? It is not referenced from rest of patch description
> so seems a bit odd.

It's the only thing even close to a datasheet that Sharp
has published for GP2AP020*.

It doesn't deserve the title of Datasheet: tags.

Yours,
Linus Walleij
