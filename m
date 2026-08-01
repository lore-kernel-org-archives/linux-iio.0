Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6BC264614;
	Sat,  1 Aug 2026 02:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785552382; cv=none; b=jVER4izHRL0lKGKmlhq5RGzSHNurs7bBOB71HuuBX7h8qpBbuQ69L0L9k+p7EuXolaQLWflxX5XUm63yp6Aq2TKFFL9UI7d+1tCFkDXSrR2/xJ5h6feVB9Jds+MLEpYS6GYF/0Gs6YGUjOqAQ13mxuikEd8uPVZDdb5iydWJtkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785552382; c=relaxed/simple;
	bh=1nf3q6IC9sTO7UFKoctJHAMBXsIQR2aGRT/RrV4jL90=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sePDiWyONSPfPltBzR6fa0f3y8PAJmWYgU6JAiygBzI5AjCWwnOxqXTP+MjSlKFpWjD894S85m7MmI4tCKNBaGtvHLy0l+6XYfWk7h919Cq8bDONIaAMPn0+4FlmQErHNtfBUMmoGhniqsOiss2BGxOPqkpXAKqGnLkuCFsiMIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXvIUf0s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXvIUf0s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850F21F00AC4;
	Sat,  1 Aug 2026 02:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785552381;
	bh=EDFt6RAFrSvdpL+f6hgvwP+7xY7v8S7wuicJjSW/0xE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GXvIUf0ssStYRf378g3bx3JjZavrMNJWI6ilsI99/Ls6hFtLpPP9mYGhIwwkCBOHs
	 tkX9f4+B8iwo7SKWb6u25r8OmFnJqTXzY/AdCsXDNKDy4kc01J2pZASCmzeodQGPLj
	 1pZwv1DW9GZRfCIOgejKRyv37gVmvgo/jlfTQY8W1K8Vn4dtS1L3FsC6bM0ZN6usLs
	 gsA96VqOpc1mx+Ir7TTXy59uFQ8WZIsoPKuDJ8Yo1R3poRl1xMcrc2z6zSLN5Uqup3
	 qZZNCRtGoYK5+9sM2JAAj9DyMZW3BSJdhVzOotbWnoOc94AGHX07ayd43bbfkYjpcB
	 77PvTS429nmmg==
Date: Sat, 1 Aug 2026 03:46:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: nuno.sa@analog.com, dmaengine@vger.kernel.org,
 linux-iio@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, Frank Li
 <Frank.Li@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 1/9] dmaengine: Support bus widths of 32 bytes and above
Message-ID: <20260801034617.5dab3286@jic23-huawei>
In-Reply-To: <20260801034222.45d4d479@jic23-huawei>
References: <20260730-dmaengine-support-wider-dma-masks-v1-0-3732f1f9d9ca@analog.com>
	<20260730-dmaengine-support-wider-dma-masks-v1-1-3732f1f9d9ca@analog.com>
	<amujDsVXJQ8gaCvw@SMW015318>
	<20260801034222.45d4d479@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 1 Aug 2026 03:42:22 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 30 Jul 2026 14:16:30 -0500
> Frank Li <Frank.li@oss.nxp.com> wrote:
>=20
> > On Thu, Jul 30, 2026 at 03:23:08PM +0100, Nuno S=C3=A1 via B4 Relay wro=
te: =20
> > > [You don't often get email from devnull+nuno.sa.analog.com@kernel.org=
. Learn why this is important at https://aka.ms/LearnAboutSenderIdentificat=
ion ]
> > >
> > > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> > >
> > > The src_addr_widths and dst_addr_widths capability masks encode each
> > > supported width as a bit whose position equals the corresponding
> > > enum dma_slave_buswidth value (e.g. DMA_SLAVE_BUSWIDTH_4_BYTES sets b=
it
> > > 4). As these masks are plain u32, widths of 32 bytes and above
> > > (DMA_SLAVE_BUSWIDTH_32/64/128_BYTES map to bits 32, 64 and 128) cannot
> > > be represented at all.
> > >
> > > Introduce bitmap-based bus width capabilities that span the full enum
> > > range. To allow DMA controller producers to be converted incrementall=
y,
> > > keep the legacy dma_device u32 fields alongside the new bitmaps:
> > > producers using the new helpers populate the bitmap and mirror the low
> > > 32 bits back into the legacy field, while dma_get_slave_caps() folds a
> > > legacy-only producer's u32 into the returned bitmap.
> > >
> > > Add helpers for producers and consumers so users do not need to depend
> > > on the bitmap layout directly. Once the remaining producers are
> > > converted, the legacy dma_device u32 fields can be dropped.
> > >
> > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > ---   =20
> >=20
> > Reviewed-by: Frank Li <Frank.Li@nxp.com> =20
> https://sashiko.dev/#/patchset/20260730-dmaengine-support-wider-dma-masks=
-v1-0-3732f1f9d9ca%40analog.com=20
> has a comment on this that smells plausible at least.
> Looks like the stm32 driver modifies dst_bus_widths in it's device_caps()
> callback.
Reading on, you fix it later in series.

This is going to break bisection on that device, but not build
so I guess maybe fair enough to do it in this sequence.

J
>=20
> Jonathan
>=20

