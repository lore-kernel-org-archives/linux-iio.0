Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794992451;
	b=ZfA8NZd96RfCcEMlALo02XleNeOwHn1kiBAGhQuGQJgDj26GmV8MHRHK8Q3i6PrCuT6E
	 6Zgh5EGqCBCdW2eKf0U+wTDJSy/41befdqXqnXCZJKbkpWUboC1HaLmeyRiZzC9omlSts
	 2iI0NiRWgLS+2baVospKlvpTacZdbRLv3UIgToRv4+ogwXecYS/OpviFdRnCwWaWJ+a6n
	 VHpFJsssu4m6q7+fwabL7ShewFq4wfkZMtIkjreUlgCOHC5zKnj3PPr/OdqPyf3DPtPpw
	 IDX+HQSeqOKVQbi74Palyu9kooJE7DdifsiPslMdu30POOs3p+NuaBZMPjGSkrjlASg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794992451;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=sr9doCvp9PjzykzAEoSbutZrtMIBi4xONV35RKYKw/A=;
	b=vLGiWcDeiYurT3v/mhkd0+Vd/32d7WpGA5KZQMBKV6rVyItmmvdhiuOvRBDfhf8NonT3
	 tGA5hI2BIahgj+3gDIRpJAdQQax+veOk60DGxcHsU43HdZql1qJL9ubUWGXGVRwVMPbq0
	 Z96tBep4zQBqMtERXfndnipe8iwC3CGNLkEZq7jX2+Vub9bImUfQLjdPIvREJSjHgDnP3
	 7lTk/YbFrwLRTCzYfstBiAwBtdYQ7cup8tKRB2K0gkBHWLdxAowqG+/uGAy964LIYFg6Y
	 Dy3lGih9ujSA5oWsHqgCutgGvAb7abfybg77b5qa2AY2JmNh+KVHVz1mIJSPsQ0N2lw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UQe0DAOh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32338606A31C;
	Wed, 18 Nov 2026 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UQe0DAOh
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794992450;
	b=g6ZsUdTG0RwZY3MKlBEQ2SYq8bqLFnVqvBhplmW5Q8AxG9gIx2+5+0TiAjzALuVY97jm
	 /SKgLR2VbDZi3CQUgqjiz+TyeqZT+rnwXBBvL+GcYfXtuswbpAuGSdSYKmaku82p5belF
	 q1rSrLJjYxiYTMPVhq5rGAMhW9polbg9E+5qQ3TF1axjKEVG3210Nzt2XEf/R7R+gFD5k
	 e8HL0fxUuhyqNkriXAAozxaAWKhvTgkkVzmL6bl1d7yKzF917rV6OgHH/X8QLROIU8J2H
	 oz5ihTJ8nOv5fyvdju9DreMH47HECwoM0U2nYUkumhrP26ndDplqnzfZyFhqn7p0Rdw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794992450;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=sr9doCvp9PjzykzAEoSbutZrtMIBi4xONV35RKYKw/A=;
	b=0l4n9vCLzZ0k19sGNWEbzAJQPPxAWbNuhUlDY2EsdpjNxA9fD1EL/GBHJshCYjDlxGld
	 IrcTaI98kWLyukTg0ouRi0pORCYLIG56zCaT6qDUb9NdqDwiV55qu7n1pOa7JNbuJHfpp
	 reVo2EJuuXy2EGIr1KOOCVmdCBo3YK8lYq26EW0osz/H7gkjyAM9CJKQzDoIOJ6hjN452
	 x0TTMoa6VbPEsNXODDl2Hp/Wag8w4tia7f04at0lUrkyR+yl8rDgiQig2e/pnNdblRiDN
	 IAJtrUMMCkBHEy2hRVJompprQVGTmRVNR6dqYX1utalVcRVY7j+338BTJJXeOvmc/cA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id CC6721F000C4;
	Wed, 18 Nov 2026 09:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794992450;
	bh=sr9doCvp9PjzykzAEoSbutZrtMIBi4xONV35RKYKw/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UQe0DAOhTKneIIS9iuJOy0QPxWfQEFrkPNKamL4s7nfvzXQLFqW9+5QHATMnMCjIc
	 nToO92PiIyuv1O52OMdHOnqAefkexhJiFi29AvRl3VrTNCy7gc+4rG1z8tM7DwJolq
	 CHyRoiBuuGLpaTOUhdlpAtSM3FXme8X2bfBFs5OyHZwoq1YRzIavmqmN+ZfM5/qTQ0
	 gMNaL8mzyXgglu1VeF1Q8L7n1OsgCEzKnNBd5HVSB1Oi/ka/bEHkcC1hH7jAEfer32
	 0u5M4E5cu4gtaCPeLl9xp24Xcx0cFVIUBZhd2wOFxz/QNt2RCv4BOm5n9n+F6cUAcx
	 sLyc+PPZbC9vQ==
Date: Wed, 18 Nov 2026 10:00:40 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Adil =?ISO-8859-1?Q?H=FCsrev?= Tepe <tadilhusrev@gmail.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iio: proximity: add Imagis ISG5320A (Samsung
 Galaxy XCover5)
Message-ID: <20261118100040.0000744a@kernel.org>
In-Reply-To: <20261117173333.1853986-1-tadilhusrev@gmail.com>
References: <20261116074013.355363-1-tadilhusrev@gmail.com>
	<20261117173333.1853986-1-tadilhusrev@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Nov 2026 20:33:31 +0300
Adil H=FCsrev Tepe <tadilhusrev@gmail.com> wrote:

> This series adds an IIO driver and its DT binding for the Imagis
> ISG5320A capacitive SAR/grip proximity sensor (I2C), as fitted on the
> Samsung Galaxy XCover5 (SM-G525F, Exynos850).
>=20
>   Patch 1  dt-bindings
>   Patch 2  the IIO driver
>=20
> v3 fixes the real review findings on v2: Sashiko AI caught a High-
> severity INT-polarity bug in the reset sequence (eliminated by
> dropping int-gpios from the driver and binding entirely, since the
> pin is already described by the required "interrupts" property) plus
> a Medium-severity devm unwind-order bug and a Low-severity unchecked
> enable_irq_wake(). Both are now live-tested, not just built. Per-patch
> details are below each patch's "---" line, as Andy Shevchenko asked.
>=20
> Tested on a Samsung Galaxy XCover5 running 7.4-rc1 plus this series
> (2026-11-17, kernel 7.4.0-rc1-00023-gdcb8b91fb779+ #30): the driver
> binds, registers as iio:device4 "isg5320a", and in_proximity0_raw
> tracked a live hand-proximity test (baseline ~0, swinging to
> -12817/9748/10759 as a hand approached/withdrew the sensor).
> checkpatch.pl --strict and dt_binding_check are clean.
>=20
> Based on v7.4-rc1.
>=20
> Tool usage
> ----------
> This series was developed during XCover5 mainline bring-up with the
> help of an AI coding assistant (Claude Code, Anthropic), which drafted
> the IIO driver from the Samsung vendor driver's register map and
> drafted these changelogs. I reviewed every line, built it (arm64, 0
> warnings), ran checkpatch --strict (clean), and tested it on hardware
> as described above, and take full responsibility for the contribution.
> Review comments are welcome and I will answer them myself.
>=20
> Adil H=FCsrev Tepe (2):
>   dt-bindings: iio: proximity: add Imagis ISG5320A
>   iio: proximity: add Imagis ISG5320A SAR sensor driver
>=20
>  .../bindings/iio/proximity/imagis,isg5320a.yaml   |  55 ++
>  drivers/iio/proximity/Kconfig                     |  11 +
>  drivers/iio/proximity/Makefile                    |   1 +
>  drivers/iio/proximity/isg5320a.c                  | 848 ++++++++++++++++=
+++
>  4 files changed, 915 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/imagi=
s,isg5320a.yaml
>  create mode 100644 drivers/iio/proximity/isg5320a.c
>=20
> --
> 2.53.0
>=20

Not only you sent this as a reply to v1 (which obscured this new version
in my inbox), you also sent a v3 the same day you sent a v2. This is a (rel=
atively)
big addition, please don't do this. For trivial patches it should be at lea=
st 24 hours
between revisions, for new drivers ~1 week.

I know it's tempting to send a new version after a Sashiko review/trivial i=
ssue you
found, but you'll save the reviewers' and maintainer's sanity by waiting :)

Thanks!

--=20
Kind regards,
Joshua Crofts
