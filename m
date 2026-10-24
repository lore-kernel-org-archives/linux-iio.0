Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792811034;
	b=QJafFtfTDqbLMzhGhVV56dWq+H/Pn1aaxFUzyX3zsrmEYcbibgfvRzSxzIksWx1/I97x
	 ruRCSsFaOpdyZJVqua2uzrI7i+dKCfsm2E6DKTVg8Z+cQu8NmgIseY/mpCKx6VeFBdQQP
	 ARGVvc063yaJSiIPUNdYobaxugkqkHXpinXQxJ9WwvG2sy+2QUz4TdpAmXMOuB1tFnYxb
	 Sji6bcvtatuSs7kIWuql50vyeOll0c1pzLOjmkWwqgRJM/g6aGGwzgEEl8yZ5slNyOuYK
	 2HFdV6sHOxTGwGJc7siXGe+zPRPZD7wooq85jFRwJ6dbPwn1fT8ZtQKwPiMMLhzBvkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792811034;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JgNtmgCu9nLRngDA9LIF/6Je3yHIdY2z9nmBR/y8Sn0=;
	b=xxdDsfavv6rcFyB4X9qKRFcj2cjKGeco0V8woKV/GTDIK2jDRtHXkc4TbyJON6Q+1X4C
	 QNZ9qEC56ygQYVylN5gJFROR66gaLhyp95AescQ9SEVBAlJAFvEIEMCsZ8GS/PgJ7zqQU
	 CqMDq0v3QJ2Sni+Batv6jMp0lRQxItFpfbizId3cWHbIXeIuAvr+lk+L+Ogzjru3mD9n7
	 tidGYw7zqh6x0lbrIwHxSxc6TD4MLY7zp3tiyddInpFn1D9Dw9COYclZqNkP6lWZZ3ed4
	 QNIAwCpAK2Gcy7dGooSw9d/GSLtYqCd4HGk8q//nKB+1pbxQarCF1uRgidhA+zDZbMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RtZCUODf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E64606A31B;
	Sat, 24 Oct 2026 03:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RtZCUODf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244031F01828;
	Sat, 24 Oct 2026 03:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792811033;
	bh=JgNtmgCu9nLRngDA9LIF/6Je3yHIdY2z9nmBR/y8Sn0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RtZCUODfdkUQj5JBthRPlWg7Ob0q4cKZayVVsbGKoogjaik/BW+/nVwocXNDr/ILw
	 QDkviisJR/u4m9Z5KOX0hg1KhrW9QTabOd1oObef7PU+FRnQcGtp2Jubu6261sV7GU
	 cO8Mtig0rkMB9sgXcmcbeIC66SQS2YnIgAjrOsoUg7E92moExiZoKF42xXhOKzJjA9
	 0BP2NDJTj8CDxRkruJ68aYy5OWtt9ChLfiPNJTTmdiUS3pf693c5df+3QfmOzyWISE
	 XDWZYx0zYz/da9ITrz/Wo2b56wvI/JbOxgorQgjpvNjkBlikIZ1UciDzRWh16j8LzN
	 hQmQnkBMLK4Sw==
Date: Sat, 24 Oct 2026 04:03:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Christoph Rudorff <chris@rudorff.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Bjorn
 Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: light: gp2ap002: add led power supply
Message-ID: <20261024040345.1fc6b6ff@jic23-hlaptop>
In-Reply-To: <CAD++jLmCo8tnG5vp4Qv=6rDG3nob25LHELretdu7t3_SLxQASQ@mail.gmail.com>
References: <20261020-iio-light-gp2ap002-v3-0-b7e0946c9e79@rudorff.com>
	<20261020-iio-light-gp2ap002-v3-2-b7e0946c9e79@rudorff.com>
	<CAD++jLmCo8tnG5vp4Qv=6rDG3nob25LHELretdu7t3_SLxQASQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Oct 2026 19:15:53 +0200
Linus Walleij <linusw@kernel.org> wrote:

> On Tue, Oct 20, 2026 at 1:36=E2=80=AFPM Christoph Rudorff <chris@rudorff.=
com> wrote:
>=20
> > tested on samsung-j5
> >
> > v2: Use regulator bulk api.
> > v3: pretty up, rename vled to leda
Change log goes after ---

> >
> > Signed-off-by: Christoph Rudorff <chris@rudorff.com> =20
>=20
> I think that commit message needs a bit of elaboration ;)
>=20
> With that fixed:
> Reviewed-by: Linus Walleij <linusw@kernel.org>
>=20
> Yours,
> Linus Walleij

