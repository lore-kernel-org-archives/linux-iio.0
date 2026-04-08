Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496D338D6A2
	for <linux-iio@vger.kernel.org>; Wed,  8 Apr 2026 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775677489; cv=none; b=BvZeNzP5rMDcJoC14lMS5wzTEIdsnMxywUbH4ifYJHKgLfpYQPPlW4JroV90tqGEm399Us1i1o6CiZf8d8vbpeCnisn0dvfQiPuyPN3w9zNCFcH5Nyt53sxswYXPFVMaX0DQhLSZAb9gg4ph4W7hn0lqfZJXULxfZBbp81v/67w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775677489; c=relaxed/simple;
	bh=c5WnR933iazb0lin+oW2ATL9IN7UoHtxMl/eLZxJcb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SsRMvwdiczX9EisYYgHnaKwWPvcMokVSOi6RhxDK+QRZKCHMt9iFh8//mtRxd9k5k4KPvtdLadCSAmVI8PJOJIMwY+/u7gt9aH2nrFy+a/SJWseKE6ki2sazIxRIOTysfsqPUIKVIanhkUogpI2jntzSRCdxGaJ3LLIh404IG14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/t7Mvad; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/t7Mvad"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86818C2BCB2
	for <linux-iio@vger.kernel.org>; Wed,  8 Apr 2026 19:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775677488;
	bh=c5WnR933iazb0lin+oW2ATL9IN7UoHtxMl/eLZxJcb0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h/t7MvadYlcTmS24VXSHmX/uQwrlhTPAG3MLnhvHT91dvLf1Y2ieO9eXoZB2TXrcd
	 6GABrkaM5MR4G2jBPPXkPVUeDcpQpgVLiBiw/PBWRkDUAV+FOusvfQa8DFQ8vrOofk
	 mTrOrA1YtRCBVstexSwBr75B/IWCkwGvQ3+FSd/dZw+pTaDM2UMgkGWzNG3wSHB96d
	 N4XKgWKEeghWeFNeUWieYPSPSp5oMdyDa9hWwqIJOGSEFssdTQjmbKLkY+NLnjRGgN
	 E0isYap1tYKGjrpUD9Rp0DZUhbT33mXIupZgZFTI8g8W6/LiQbRd623SnmYa4Z/uSO
	 BX4OX5b2pOlAg==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b9c3a9fe80fso10453566b.3
        for <linux-iio@vger.kernel.org>; Wed, 08 Apr 2026 12:44:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWqn1XfW7VeatHBZcKtdRke/kz7FkDq7bpS+I2PBitST8f0hEjlZ2xxunXjhYdhATKasXUjzlShBFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZkt88LFBWo3599INJde46zY1gzTUbpvoAemJAFMxOBzeekbJw
	nTClGM9iNX1/cojcHC5UUBb6G6jCxqRMPCUO+sc8yhpZ7vQ9HID7ng4G1mHmOdbAcAhQ2ONwbFv
	SCjXS9LeVksF+g/yV3ZRt0EDaM9wvvg==
X-Received: by 2002:a17:907:c20:b0:b97:a39d:ae3d with SMTP id
 a640c23a62f3a-b9d476a9b22mr36701966b.44.1775677486956; Wed, 08 Apr 2026
 12:44:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330195853.392877-1-macroalpha82@gmail.com>
 <20260330195853.392877-2-macroalpha82@gmail.com> <20260408131944.GA1901621-robh@kernel.org>
 <PH0PR19MB9973386B000D79AD04904C96B2A55BA@PH0PR19MB997338.namprd19.prod.outlook.com>
In-Reply-To: <PH0PR19MB9973386B000D79AD04904C96B2A55BA@PH0PR19MB997338.namprd19.prod.outlook.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 8 Apr 2026 14:44:33 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLEBnF2g7p2ubkUnpc2X9+r7wx9HP-Wdzp5Cm5wj013eQ@mail.gmail.com>
X-Gm-Features: AQROBzDGxcdM9Vyw-5a18RZVzC8wwyekQwwIUeeoAHpDXWW3RAwMTQpvv5yzZ2I
Message-ID: <CAL_JsqLEBnF2g7p2ubkUnpc2X9+r7wx9HP-Wdzp5Cm5wj013eQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/9] dt-bindings: iio: imu: icm42607: Add devicetree binding
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org, andy@kernel.org, 
	nuno.sa@analog.com, dlechner@baylibre.com, jic23@kernel.org, 
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org, 
	krzk+dt@kernel.org, andriy.shevchenko@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 9:31=E2=80=AFAM Chris Morgan <macromorgan@hotmail.co=
m> wrote:
>
> On Wed, Apr 08, 2026 at 08:19:44AM -0500, Rob Herring wrote:
> > On Mon, Mar 30, 2026 at 02:58:45PM -0500, Chris Morgan wrote:
> > > From: Chris Morgan <macromorgan@hotmail.com>
> > >
> > Subject space is limited, so don't say devicetree binding twice:
> >
> > dt-bindings: iio: imu: Add Invensense ICM42607
> >
> > > Add devicetree binding for the Invensense ICM42607 and Invensense
> > > ICM42607P inertial measurement unit. This unit is a combined
> > > accelerometer, gyroscope, and thermometer available via I2C or SPI.
> > >
> > > This device is functionally very similar to the icm42600 series with =
a
> > > very different register layout.
> >
> > Similar enough to use the same binding schema?
>
> Yes. I was under the (possibly mistaken) impression that different driver=
s
> required different binding schemas, but these should be similar enough to
> use the same schema if it's allowed.

Total fine. Bindings and drivers can be 1:1, N:1 or 1:N.

Rob
