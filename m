Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499977;
	b=DcqqjpEsjhlYTQrvN6MOdt/vOgYECzS9ajdAatcFYKPF4fbs5fGN4o5lNpE35cJOAXKB
	 0WOOcwEkhJz7GktN+ceDZQrgg6Cg16bVmaK4+i3G5KYmLJyBB9BoBYO2U0iE+loaIkQHJ
	 P49zuvIGVQ/m8kooB5x9EuT2dWPjQC9fKpy9o/UaO9SsdAUvwKR3lnnByuUUgBM5daQq+
	 NTKpsoJRy4NwVxxi0LRHJZRs7jAP4sXrxk3fcJx11JPp0Mlxq2QkoI+mWIZ2GQ+V5GEQd
	 uep/mso3WYCE/RW4EAznQ/n4wlqf6jEDIRyTyjIY9+xRdk2MMYKEPohQ8QnwRw+vQ/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499977;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=RgceOe+o9SSPiUOOX+dafdP5lR0/MnDvLfVzpqJudMk=;
	b=5gi6+7XJiDqARgpbgJjSiY/M0VOiTz0MhhRByyaxzaXZbRUONOZSFutr5rnT+5G7Nx7w
	 AVHB0zUZ7S1kZT5trosGtvvTj2nMXMnIOgOvL7QPH8ghiyx3DjcU++gto0vKMo2cCS4xQ
	 Imv/FTpAuZHbw7uGFaXPF9XHRML+KDLi3O4wi0KZMPkGri5Hd9PgmqbSkPLcEjPwztQKF
	 cQOkP2KFq/9U7/pfNBEF2lwBNYo/ZgssdcEEZRpL1KaFbLKO1s0tBK0Pd1gIED7gjpdOX
	 kQFptT7X/eO3i0WGVzw81C8QNIpGdbP1KHpH++yzYHD7sprDrZ4xpfvtM4qo9ATYJdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PPpnjRGA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B18606A324;
	Sun,  1 Nov 2026 02:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PPpnjRGA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4301F000C1;
	Sun,  1 Nov 2026 02:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793499976;
	bh=RgceOe+o9SSPiUOOX+dafdP5lR0/MnDvLfVzpqJudMk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PPpnjRGAfXGfaPE3Att3cIu4zMErP49vpC+K0MmV4tY5IM1Sq6WNQi7Nnbk3CkxQG
	 adn8bUCv11RoHi16xoXaJnSJw1R+JfXq6+z38WN2f3hKWpyV4Ql7BoMbAUyygHNk8o
	 33XAlrduzgkfFqqzRnXfrRhx64oayR0DxJaegTL5+2UX6do32x41EE5LjIcQuB9Iee
	 pnM5zIV4McL0x5h6tXp9jMjniRaM1j6YVBbvmfl68s62y2WacHVerra1I1x2KfgCWX
	 tcBsqYx5EebuTXdviI2lpOakQ+OBOpiCxzozmIy733Htpo1IOTsl+RI21LKyxoaTnB
	 mF2eLB/HIpXyA==
Date: Sun, 1 Nov 2026 02:26:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Josef Bacik
 <josef@toxicpanda.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable <stable@kernel.org>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 04/15] iio: accel: adxl380: don't stay in standby on
 -EINVAL
Message-ID: <20261101022608.0196b0ef@jic23-hlaptop>
In-Reply-To: <auHIJRLqIm97GrEG@nsa>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
	<20261027-llm-char-misc-iio-v1-4-0d818334f6c7@linuxfoundation.org>
	<auHIJRLqIm97GrEG@nsa>
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

On Wed, 28 Oct 2026 10:02:36 +0000
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> On Tue, Oct 27, 2026 at 05:19:08PM +0100, Greg Kroah-Hartman wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> >=20
> > adxl380_set_act_inact_threshold() puts the sensor into standby, writes =
the
> > threshold and switches the measurement on again.  A threshold above 819=
1 is
> > refused in between, and the sensor stays in standby: no samples and no
> > events until the next write that succeeds.
> >=20
> > adxl380_set_range() has the same problem and a worse one.  It rescales =
both
> > thresholds for the new range.  If one no longer fits it returns -EINVAL
> > with the sensor in standby, the new range in the chip, the old one in
> > st->range and rescaled thresholds in the driver's state: from the next
> > successful write on the samples are reported with the wrong scale.
> >=20
> > Switch the measurement on again if the threshold is refused.  In
> > adxl380_set_range() see whether the thresholds fit before anything is
> > changed.
> >=20
> > Fixes: df36de13677a ("iio: accel: add ADXL380 driver")
> > Cc: stable <stable@kernel.org>
> > Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>
> > Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > Cc: "Nuno S=C3=A1" <nuno.sa@analog.com>
> > Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> > Cc: David Lechner <dlechner@baylibre.com>
> > Cc: Andy Shevchenko <andy@kernel.org>
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied to the fixes-togreg branch of iio.git

thanks

J
