Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884152E92B3;
	Sun, 27 Sep 2026 20:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790542370; cv=none; b=ouhsNZ/V69brFwxKYtH8vcm5MKANgY09WmMH99pOu45l4W4olPMHHchpiJ4kI+N5KxBo5/XSrFbxq0GA+B5m6OcvtNrLtRhZl4UdwK9Y20pV6dAKecFHN7yZ20eEm7JHi4QJHdvQFhHeCAB+qCLQQTPfm9T2NA2sQ3K0LQzrKeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790542370; c=relaxed/simple;
	bh=/wxo6BQ8EBNCBri0xZn30BsV++ph7F/QEAsePT+eoUw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yae3yLyIHMVFFwOm2vGuslsq04uacFwGJFoX/gEekKbO7Y1WJa+qEn7tr6JPCvpzQjUt9V45XjVC38Gru8hiqMyLuGYv90rAnsKVgZjq/tqki1bNnvBFU74dBdlixnVifpZzdXGa8TC6daDnn3F/tbPPQ/Y1R/j0o6ylN6sxVP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGncMucp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGncMucp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DDE1F000FF;
	Sun, 27 Sep 2026 20:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790542369;
	bh=jXagDIFXWv/uhGdO81MZzXdQUPJiXRgFrH0SRQIbHWk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jGncMucpdrRzio9cqFSlo8N9VAnxGx2xb0ZywfRwPcLSfF7CHpdWXV+2HGWQ7QBjh
	 Bzn/JvrFBDkwtlDh0XQyWa9w7MDdQ7+4TpzKk5ZB4o/I5I3t8B/vTLpTLHmJMSgw08
	 YSHLG/dAVFTnLpFl2EBm7JzdQn2G5HpIWydaPjx8lil0jJ50tzmlmqwZ4zbRmSj3Dr
	 W1vgtJmEdmrn5/+l8LtQX8CX3gq/yP0v/BUDEQJnBJlw4eIEbJlV1FpuLceusoeIro
	 ijOeaJGcLjldp7vLAQP4MY6bvKCv0mq58QvZzqTES31Du3WOV0AO7Djs+2HTKjXowy
	 6ny812JD5CbhQ==
Date: Sun, 27 Sep 2026 21:52:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Arka Mondal <arka@arkamondal.net>, Nuno =?UTF-8?B?U8Oh?= 
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux@analog.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, arkamondalofficial@gmail.com
Subject: Re: [PATCH 0/5] iio: dac: ad5758: fix DMA alignment, raw range,
 offset and 4-20 mA
Message-ID: <20260927215246.3e9c57b9@jic23-hlaptop>
In-Reply-To: <20260920194107.12173789@jic23-hlaptop>
References: <20260918122032.134947-1-arka@arkamondal.net>
	<5cd6b31da1f8cbd5b004888cb0df22061fe86a2b.camel@gmail.com>
	<20260920194107.12173789@jic23-hlaptop>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 20 Sep 2026 19:41:07 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 18 Sep 2026 16:22:27 +0100
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Fri, 2026-09-18 at 21:20 +0900, Arka Mondal wrote: =20
> > > The first attempt to send this series on 2026-09-18 was rejected by
> > > the kernel.org mail servers, so it did not reach the lists. The patch=
es
> > > are unchanged.
> > >=20
> > > This series fixes four bugs in the AD5758 driver, all present since
> > > commit 28d1a7ac2a0d ("iio: dac: Add AD5758 support"). The last bug
> > > takes two patches, one for the binding and one for the driver.
> > >=20
> > > Patch 1 marks the SPI receive buffer __aligned(IIO_DMA_MINALIGN), so
> > > it no longer shares a cacheline with other driver state. The 2022
> > > conversion of IIO drivers to IIO_DMA_MINALIGN only changed existing
> > > ____cacheline_aligned markings, and this driver had none.
> > >=20
> > > Patch 2 rejects raw values outside 0 to U16_MAX. Writing -1 currently
> > > gives full-scale output.
> > >=20
> > > Patch 3 fixes the offset for every range that does not start at 0.
> > > The +-20 mA range reports -32 instead of -32768.
> > >=20
> > > Patches 4 and 5 fix the 4 mA to 20 mA range. The binding and the
> > > driver give it as <4 24000>, which is 4 uA to 24 mA. The data sheet
> > > (Rev. B, Table 32) and the original text binding say range code 1010
> > > is 4 mA to 20 mA. The old value is still accepted: the binding marks
> > > it deprecated and the driver maps it to the corrected range, so
> > > existing device trees keep working.
> > >=20
> > > Compile tested only; no relevant hardware available. The binding was
> > > checked with make dt_binding_check and with test device trees:
> > > <4000 20000> and <4 24000> are accepted; <4 20000> is rejected.
> > >=20
> > > Arka Mondal (5):
> > > =C2=A0 iio: dac: ad5758: Fix alignment for DMA safety
> > > =C2=A0 iio: dac: ad5758: Reject out-of-range raw values
> > > =C2=A0 iio: dac: ad5758: Fix the offset calculation
> > > =C2=A0 dt-bindings: iio: dac: adi,ad5758: Fix the 4 mA to 20 mA curre=
nt range
> > > =C2=A0 iio: dac: ad5758: Fix the 4 mA to 20 mA current range
> > >=20
> > > =C2=A0.../bindings/iio/dac/adi,ad5758.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++++
> > > =C2=A0drivers/iio/dac/ad5758.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 18 ++++++++++++++----
> > > =C2=A02 files changed, 18 insertions(+), 4 deletions(-)
> > >=20
> > >=20
> > > base-commit: 08df884136f1c1197bab2a27814404fd329d9aac   =20
> >=20
> > LGTM,
> >=20
> > Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com> =20
> Other than the one thing on the dt-binding that is more policy than anyth=
ing
> else these all look good to me.  I'll wait for that to resolve though bef=
ore
> picking these up.
>=20
Occurred to me that I might as well queue up patches 1-3 whilst we
wait for dt review.  So done that.
Thanks,

Jonathan

> Thanks,
>=20
> Jonathan
>=20
>=20

