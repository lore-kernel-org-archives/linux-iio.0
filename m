Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1774831960A;
	Wed, 19 Aug 2026 01:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787103387; cv=none; b=l3K4c0DRCtmwsmun5lzcykNnG7ao2P0Aa/Nc3pkjzFn0JNMxZhIzz435nHnlSEOQxjNM/PBU4Zkpt/vXlbuomvU56k/AvAyKix4+JnMCvYPrmGHfmpb2JODCjlkksYe+o6zC1U27mqnHIBz+tq23uw3/WQbpNn5d12wgjfRZ9yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787103387; c=relaxed/simple;
	bh=5vxZysQexv9LgA4nI3RL3QEQ1guXTIFRjJ8ss4d+On4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qsi9sxc9tVmkPCe3oQTqzRtZLAvau5zfX1bZTKBBjN0Xibo6B6wRKl7LnuXEWXH5Oa7BT7v5iI5+HGZZ2W+/nz4qvd7kj8VPzRYbEPgN/W49+ny/mA7eKZNwXF81FIRExavDep20Qqh8NUJacQA//j3sT5pL0kMNqcx9JbPPfxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vjl3tmrD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vjl3tmrD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C57F1F000E9;
	Wed, 19 Aug 2026 01:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787103385;
	bh=XHdQdCXeVVXVa2EQNHiJnnORPSquXXRGu0i2fQPgxYE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Vjl3tmrDAkm1xUHH+sWWOBDGq/0rMQ7kGQJGENec1cj0rQn+42RmyglotWK5YILIk
	 JCxiP6d6F52a1Mp/Cjbx5a1U+0JucQiQxZVJa4bBiNnk7rmPKM/JWd//W17KTvgyd0
	 nqA1jwgr6mKDatcEwlrOBGJx7D+Da7jw6kg5RCt/1jgHLFdvNGjKD4U3NayeCgCa28
	 r0cR7uv1iIImAjtLwVTisRSPqRJABXhXlwuei3rjYyvDYeUnhwJGCKozM/tT8/wm16
	 aH5kWJaXvRL5gyu7QglRKS+K7W9ZLtVcaf8zok9H5YbSQxhlhWp7yReD2qPcQz1pPu
	 6J/1lg8iI0d0A==
Date: Wed, 19 Aug 2026 02:36:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Esben Haabendal <esben@geanix.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, Sean Nyekjaer
 <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Joshua Crofts <joshua.crofts1@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v5 0/6] io: accel: mma8452: Allow open drain interrupt
 pin configuration
Message-ID: <20260819023620.6d996271@jic23-huawei>
In-Reply-To: <20260817-mma8452-open-drain-v5-0-e34e872d7d57@geanix.com>
References: <20260817-mma8452-open-drain-v5-0-e34e872d7d57@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Aug 2026 19:20:22 +0200
Esben Haabendal <esben@geanix.com> wrote:

> Extend the mma8452 driver with support for configuration of the
> interrupt line in open-drain mode, which is needed for hardware designs
> where the interrupt line is shared with other chips.
>=20
> Adding drive-open-drain property to mma8452 device-tree node for such
> designs to enable switching pin configuration to open-drain mode.
>=20
> Signed-off-by: Esben Haabendal <esben@geanix.com>

Hi Esben,

Seems something throttled your mail. Only 0-3 made it to the list.
Please resend and mark it [RESEND PATCH ...
with a brief statement of why in the cover letter.

Thanks

Jonathan

> ---
> Changes in v5:
> - Squashed dev_err_probe() call to one line.
> - Fixed typo in patch 2 title.
> - Added synchronization between runtime suspend and interrupt handler.
> - Link to v4: https://patch.msgid.link/20260812-mma8452-open-drain-v4-0-b=
fca15d02b59@geanix.com
>=20
> Changes in v4:
> - Fixed interrupt handler to check runtime PM status before trying to
>   access the chip.
> - Split open-drain support and interrupt sharing into separate patches.
> - Added new patch to reuse existing struct device * through mma8452_probe=
()
>   function.
> - Print warning message when irq type is not set by firmware.
> - Link to v3: https://patch.msgid.link/20260805-mma8452-open-drain-v3-0-6=
149f406a409@geanix.com
>=20
> Changes in v3:
> - Reordered patches, swapping #2 and #3.
> - Always add IRQF_SHARED flag.
> - New patch to change it so IQRF_TRIGGER_LOW flag is only added when no
>   trigger type is set by firmware.
> - Link to v2: https://patch.msgid.link/20260715-mma8452-open-drain-v2-0-9=
5be9f5f4795@geanix.com
>=20
> Changes in v2:
> - Commit message of patch 2 updated.
> - Operator precedence bug fixed in flags argument to
>   request_threaded_irq().
> - Always check return value of mma8452_set_interrupt_pin_mode(), and just
>   check for non-zero value.
> - Added new patch with optimization of struct mma8452_data ordering.
> - Link to v1: https://patch.msgid.link/20260715-mma8452-open-drain-v1-0-b=
1dd2a440c60@geanix.com
>=20
> To: Jonathan Cameron <jic23@kernel.org>
> To: Lars-Peter Clausen <lars@metafoo.de>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Martin Kepplinger <martink@posteo.de>
> To: Sean Nyekjaer <sean@geanix.com>
> To: David Lechner <dlechner@baylibre.com>
> To: Nuno S=C3=A1 <nuno.sa@analog.com>
> To: Andy Shevchenko <andy@kernel.org>
> To: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
> Cc: linux-iio@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
>=20
> ---
> Esben Haabendal (6):
>       dt-bindings: iio: accel: mma8452: Add drive-open-drain
>       iio: accel: mma8452: Optimize struct mma8452_data member orders
>       iio: accel: mma8452: Only apply trigger type when not set by firmwa=
re
>       iio: accel: mma8452: Support interrupt sharing
>       iio: accel: mma8452: Allow open drain interrupt pin configuration
>       iio: accel: mma8452: Reuse existing dev pointer in mma8452_probe()
>=20
>  .../devicetree/bindings/iio/accel/fsl,mma8452.yaml |  6 ++
>  drivers/iio/accel/mma8452.c                        | 98 ++++++++++++++++=
------
>  2 files changed, 80 insertions(+), 24 deletions(-)
> ---
> base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
> change-id: 20250401-mma8452-open-drain-81577c41375c
>=20
> Best regards,
> -- =20
> Esben Haabendal <esben@geanix.com>
>=20

