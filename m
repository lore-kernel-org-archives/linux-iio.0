Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED75221F39;
	Wed, 19 Aug 2026 08:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787127670; cv=none; b=CmP3gqgksO/X3nx1ne2ojeUVU6ww32/5lLAUCqXSkOjaYEhwgBKgPr0KzGeDH0RH5iv4NkTQu1LI9KJHcjtQ4YfT3PsYX/Zn/6ogX7fqRw7yTSL6EW7XGPBd8rX9z7OmiCHBDJJ18P12dyKwwXODXepSmf9Xxrvf0rRu5lE/I+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787127670; c=relaxed/simple;
	bh=VixBIgRFiiBCbeEFUcAvgEKJ1yy0uu3D8e2dBdd3Yqs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LkimhinczktLru90UWCu3iXcI4QOEI4py01Xeo/BHKh9EYct5c0bxKSZp+rgFaHCHSbEr7m2TlS++zIcaJwNQ/8BpmVXqU5kLjX015HWcBFXKd1oSVbBXZQCeouKqt4pHcB1O4s4bYU2u/i1RdWkAhKpLWlN9DZkNojDPvRoU0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Y6N+61uU; arc=none smtp.client-ip=185.70.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Y6N+61uU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1787127657; x=1787386857;
	bh=xXxRT3QbJHo2c99uZCsg9RLB8WoMlwldeXM4Z09l3x0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Y6N+61uUNoyC6U921NaKJsqwdvz2ks/RD08rGV75/LzcdTV28jx5MW1fFXhxx+wob
	 m4UtD1f/VNMj3wnNhwyCg3b3XzDDBEKuGX210P/6l5khHwOWvjvjfJoPgblu0VHTyP
	 GjP3O88PekSyX+d0IHki+BclDmOvTyUxd/sZrx+VScdmBdPwenulWY3A5SMrzVZgIm
	 +GuLxs10W1KVp2/bm/o5l0HJXfdFRvUvy8/YK8AGpErESPWJYsoLdnvrsAW9XAEHR8
	 JYkPzY3Zpdu+aBi/qEjxqPmIJ6m1Bp16Rq1lvl2gVTOIvoa1YKRgzPxzPxPrZEx6pa
	 HiJzOkQC/f5/Q==
Date: Wed, 19 Aug 2026 08:20:52 +0000
To: Jonathan Cameron <jic23@kernel.org>
From: Esben Haabendal <esben@geanix.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, Sean Nyekjaer <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Martin Kepplinger <martin.kepplinger@theobroma-systems.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Joshua Crofts <joshua.crofts1@gmail.com>, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v5 0/6] io: accel: mma8452: Allow open drain interrupt pin configuration
Message-ID: <xar1lfBElMI1sPcwFJbrjrshaqH9BWnzNRJv6TBjXfxiOW6MFA_829qDs1Zxw71PNTeF9Mtw9uoLrl1csyIGbNhH6ipsTTnhaWs2wxnTR9g=@geanix.com>
In-Reply-To: <20260819023620.6d996271@jic23-huawei>
References: <20260817-mma8452-open-drain-v5-0-e34e872d7d57@geanix.com> <20260819023620.6d996271@jic23-huawei>
Feedback-ID: 133791852:user:proton
X-Pm-Message-ID: 6ac5d50ade2c3ef3db72769b296df2dd3cc8c87d
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, 19 August 2026 at 03:36, Jonathan Cameron <jic23@kernel.org> =
wrote:

> On Mon, 17 Aug 2026 19:20:22 +0200
> Esben Haabendal <esben@geanix.com> wrote:
>=20
> > Extend the mma8452 driver with support for configuration of the
> > interrupt line in open-drain mode, which is needed for hardware designs
> > where the interrupt line is shared with other chips.
> >
> > Adding drive-open-drain property to mma8452 device-tree node for such
> > designs to enable switching pin configuration to open-drain mode.
> >
> > Signed-off-by: Esben Haabendal <esben@geanix.com>
>=20
> Hi Esben,
>=20
> Seems something throttled your mail. Only 0-3 made it to the list.
> Please resend and mark it [RESEND PATCH ...
> with a brief statement of why in the cover letter.

Done. And it looks like they all appeared on at least lore.kernel.org this =
time.

I don't know what happened the first time. It looks like b4 was interrupted=
 without me noticing.

/Esben

>=20
> Thanks
>=20
> Jonathan
>=20
> > ---
> > Changes in v5:
> > - Squashed dev_err_probe() call to one line.
> > - Fixed typo in patch 2 title.
> > - Added synchronization between runtime suspend and interrupt handler.
> > - Link to v4: https://patch.msgid.link/20260812-mma8452-open-drain-v4-0=
-bfca15d02b59@geanix.com
> >
> > Changes in v4:
> > - Fixed interrupt handler to check runtime PM status before trying to
> >   access the chip.
> > - Split open-drain support and interrupt sharing into separate patches.
> > - Added new patch to reuse existing struct device * through mma8452_pro=
be()
> >   function.
> > - Print warning message when irq type is not set by firmware.
> > - Link to v3: https://patch.msgid.link/20260805-mma8452-open-drain-v3-0=
-6149f406a409@geanix.com
> >
> > Changes in v3:
> > - Reordered patches, swapping #2 and #3.
> > - Always add IRQF_SHARED flag.
> > - New patch to change it so IQRF_TRIGGER_LOW flag is only added when no
> >   trigger type is set by firmware.
> > - Link to v2: https://patch.msgid.link/20260715-mma8452-open-drain-v2-0=
-95be9f5f4795@geanix.com
> >
> > Changes in v2:
> > - Commit message of patch 2 updated.
> > - Operator precedence bug fixed in flags argument to
> >   request_threaded_irq().
> > - Always check return value of mma8452_set_interrupt_pin_mode(), and ju=
st
> >   check for non-zero value.
> > - Added new patch with optimization of struct mma8452_data ordering.
> > - Link to v1: https://patch.msgid.link/20260715-mma8452-open-drain-v1-0=
-b1dd2a440c60@geanix.com
> >
> > To: Jonathan Cameron <jic23@kernel.org>
> > To: Lars-Peter Clausen <lars@metafoo.de>
> > To: Rob Herring <robh@kernel.org>
> > To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> > To: Conor Dooley <conor+dt@kernel.org>
> > To: Martin Kepplinger <martink@posteo.de>
> > To: Sean Nyekjaer <sean@geanix.com>
> > To: David Lechner <dlechner@baylibre.com>
> > To: Nuno S=C3=A1 <nuno.sa@analog.com>
> > To: Andy Shevchenko <andy@kernel.org>
> > To: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
> > Cc: linux-iio@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> >
> > ---
> > Esben Haabendal (6):
> >       dt-bindings: iio: accel: mma8452: Add drive-open-drain
> >       iio: accel: mma8452: Optimize struct mma8452_data member orders
> >       iio: accel: mma8452: Only apply trigger type when not set by firm=
ware
> >       iio: accel: mma8452: Support interrupt sharing
> >       iio: accel: mma8452: Allow open drain interrupt pin configuration
> >       iio: accel: mma8452: Reuse existing dev pointer in mma8452_probe(=
)
> >
> >  .../devicetree/bindings/iio/accel/fsl,mma8452.yaml |  6 ++
> >  drivers/iio/accel/mma8452.c                        | 98 ++++++++++++++=
++------
> >  2 files changed, 80 insertions(+), 24 deletions(-)
> > ---
> > base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
> > change-id: 20250401-mma8452-open-drain-81577c41375c
> >
> > Best regards,
> > --
> > Esben Haabendal <esben@geanix.com>
> >
>=20
> 
