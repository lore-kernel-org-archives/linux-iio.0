Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8FB3B2D1A;
	Sat,  1 Aug 2026 02:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785552149; cv=none; b=SohOXock2b5/7+Xv0jPp0yGUAHyW6NsTmU/1TOdl1LFurzUSTOp4u9wOIew/SXWuhbNa9UqfzDIHYEf/OgByzJAZdQoHKkmJiUwZ3c3jYIreosx6M2tmHyosudvHDZch3YDJwjvNch/24ePAy5dJ/UvNqNlVrB8qY4E+Ew2lOYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785552149; c=relaxed/simple;
	bh=DBy8GM64E3L4qowYNbwhnpNAdGzInexudXmTNok3qG8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R4C0QJZ060nu8Ks0q0r+LIRoxY52AxLpl2ZGELy0F/JdVBZCyheV6IVlgIGOhxHQxNwGvH+3CfF5bRM83F7SrA1qX9YFh3kvn09DN75WeG+KFyaHkZt1351Z/UU12S3HkCUGN9jB/MPntMBZdPo+A3xGvlybNBeKWLXww8gtUrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bl41I0Os; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bl41I0Os"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F06E1F00AC4;
	Sat,  1 Aug 2026 02:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785552147;
	bh=DBy8GM64E3L4qowYNbwhnpNAdGzInexudXmTNok3qG8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bl41I0OsLNHW0M7Q0trWDplEPQZtiPeklWslt/nnts46swYhaptgF8Y71b3SIhDlk
	 EsHpJ6QVBHfmQ2YZYHASnyAPu1F5unF/ClV813PgdZC9hYcgT7STn2WksxQ3ZONciS
	 hpQBruh6iRRAlv4yasP7IchNvKM5GTZKBxVtGAUkw4lch4mB8OPf9y9DKRPD6EdlXL
	 Wpi0gSFFW//rr6atdjXdWsBW11jOyGqc82Y4ufWX6Txvp6zZOQHwF+15tDqm4rM6Kp
	 uuMNu/hyjHxrZTXMT7M7WWkljo8O2Wt9RYnRSiXTazuQKCusFcWnpIcnVuzBTffggq
	 JWfcRvmZJlbDg==
Date: Sat, 1 Aug 2026 03:42:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: nuno.sa@analog.com, dmaengine@vger.kernel.org,
 linux-iio@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, Frank Li
 <Frank.Li@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 1/9] dmaengine: Support bus widths of 32 bytes and above
Message-ID: <20260801034222.45d4d479@jic23-huawei>
In-Reply-To: <amujDsVXJQ8gaCvw@SMW015318>
References: <20260730-dmaengine-support-wider-dma-masks-v1-0-3732f1f9d9ca@analog.com>
	<20260730-dmaengine-support-wider-dma-masks-v1-1-3732f1f9d9ca@analog.com>
	<amujDsVXJQ8gaCvw@SMW015318>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Jul 2026 14:16:30 -0500
Frank Li <Frank.li@oss.nxp.com> wrote:

> On Thu, Jul 30, 2026 at 03:23:08PM +0100, Nuno S=C3=A1 via B4 Relay wrote:
> > [You don't often get email from devnull+nuno.sa.analog.com@kernel.org. =
Learn why this is important at https://aka.ms/LearnAboutSenderIdentificatio=
n ]
> >
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >
> > The src_addr_widths and dst_addr_widths capability masks encode each
> > supported width as a bit whose position equals the corresponding
> > enum dma_slave_buswidth value (e.g. DMA_SLAVE_BUSWIDTH_4_BYTES sets bit
> > 4). As these masks are plain u32, widths of 32 bytes and above
> > (DMA_SLAVE_BUSWIDTH_32/64/128_BYTES map to bits 32, 64 and 128) cannot
> > be represented at all.
> >
> > Introduce bitmap-based bus width capabilities that span the full enum
> > range. To allow DMA controller producers to be converted incrementally,
> > keep the legacy dma_device u32 fields alongside the new bitmaps:
> > producers using the new helpers populate the bitmap and mirror the low
> > 32 bits back into the legacy field, while dma_get_slave_caps() folds a
> > legacy-only producer's u32 into the returned bitmap.
> >
> > Add helpers for producers and consumers so users do not need to depend
> > on the bitmap layout directly. Once the remaining producers are
> > converted, the legacy dma_device u32 fields can be dropped.
> >
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > --- =20
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
https://sashiko.dev/#/patchset/20260730-dmaengine-support-wider-dma-masks-v=
1-0-3732f1f9d9ca%40analog.com=20
has a comment on this that smells plausible at least.
Looks like the stm32 driver modifies dst_bus_widths in it's device_caps()
callback.

Jonathan
