Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795292123;
	b=48MCl44TSuCiOjcbtvnE4EPuK1ezf30k+xEmdb/TVlKCr0ETWFAxUzX5DTl5uc2bfQVD
	 hZrc0H6i7cphcaYdDTi7lqVEsB/jC3Rg3ENjIC57sZqDNton7upwub0oDrdHL8vkGzmE6
	 dyL4jtYJCHsjbr6Puy1kXNmwMe/VeJIvASBY9kNL3cYJx9IoYT+3Hx7C9GZMTHLR10WgY
	 R3gJaaz8jVCXAf+qA+7I/GdkngfdY1a+YojGTM8hHi1vkl/b+ok8OtJ/v6Us7SZoU2/Gw
	 Ius4rKPtmzuQgfy7xS/wjuCGVuY6LXuCXZxAi+CW2+YqJlmgtpW6/dd7LXINu8FYEIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795292123;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=l7X4mAGdBRVciPlPhmcQmKSQYt6DGO6RBLBeUnQB/KU=;
	b=FSzkVfXpN0q9dqXkF8zfipbGmBc1R+vAeR9AcGMKHN2wAdfQiXzUya8OJlbp4m6n0SY3
	 K3+rbRJ3frVaD2nDK9+9Jwl1yaRYziDU2sZKr2eacHG16zjaQy5s8bB6bzw+7CUfaurSn
	 iWfxhVZZTJEyCIzAaLhhf3DNPQmMw6sQlzKhXs/cCPI5iRxwXuK1k1C1cjVEfEKJ10B0j
	 LX97IsKtQQRHeebgkudrnBhFO4c+gdV6V+mfXTPZNYjD1+CpA+0B5sJd9ePHD3Hzazq0X
	 xOlwIawxcSZrJcjRNMG52O8Y7L7402CpxJzMXpeHeKj7pjgiofMdAqH0DSxUDEAY1mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H3HRCo1y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294AB606A32C
	for <linux-iio@vger.kernel.org>; Sat, 21 Nov 2026 20:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H3HRCo1y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40691F000C0;
	Sat, 21 Nov 2026 20:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795292122;
	bh=l7X4mAGdBRVciPlPhmcQmKSQYt6DGO6RBLBeUnQB/KU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=H3HRCo1yslI8tEUjwiGfHdNhAWn9q8Ku/n7/HamPrsE2x2Tpu2tlt0Eorfv4HLDi3
	 hPOWDFBr0Z6HiSPFvK080d/Kf9slc/8tRM9vh1Fwi22WW0C+aYSqmt0kpJ8VM0TFy9
	 6eNPTv1fRW2vZoej2CGAVifQMy0wdN/QkeC6i2robf84N/bzbH3CyQiwOB+zTBYlQI
	 Pd77sxoGTD9QYMb4yRF/ItjSfJpHxoSSuscbX1zPKVTzlzZIMLEVFvoKx+jkwhArqG
	 UUCGyBIAkPtjcbs10qekHi6kN6WZn/IHtABEO86yDjehqCGZC2DxgTSDO4hWqJX8Iz
	 q9kOIVbELsrDw==
Date: Sat, 21 Nov 2026 20:15:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Oscar Alejandro =?UTF-8?B?U8OhbmNoZXo=?= Lucero <aleszlucero@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Marcin Malagowski
 <mrc@bourne.st>, linux-iio@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v2 0/2] iio: pressure: abp060mg: Fix scale typo and I2C
 read handling
Message-ID: <20261121201519.6572aa59@jic23-hlaptop>
In-Reply-To: <20261120-b4-abp060mg-fixes-v2-0-89a274d68a9a@gmail.com>
References: <20261120-b4-abp060mg-fixes-v2-0-89a274d68a9a@gmail.com>
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

On Fri, 20 Nov 2026 04:28:25 -0600
Oscar Alejandro S=C3=A1nchez Lucero <aleszlucero@gmail.com> wrote:

> This series addresses two bugs in the Honeywell ABP pressure sensor
> driver (abp060mg):
>=20
> - Fix a transposed-digit typo in the maximum pressure value for the
>   abp001pg variant (6985 Pa -> 6895 Pa) per the Honeywell ABP Series
>   datasheet.
> - Validate the byte counts returned by i2c_master_send() and
>   i2c_master_recv() to avoid parsing uninitialized stack data on short
>   transfers.
>=20
> Signed-off-by: Oscar Alejandro S=C3=A1nchez Lucero <aleszlucero@gmail.com>
I've taken the view these are relatively low urgency fixes.
Second one is protection against something that in practice doesn't
tend to happen. First is more likely to be seen but I think isn't
something we need to rush.

As such queued them both for next merge window but also marked them
for stable so they eventually get backported.

Applied to the testing branch of iio.git

Thanks,

Jonathan

> ---
> Changes in v2:
> - Patch 1/2: Reference the Honeywell ABP Series datasheet (Document
>   32305128, Issue 2, Figure 3 and Table 7) instead of the driver comment.
> - Patch 2/2: Collect Reviewed-by tag from Andy Shevchenko.
> - Drop the msleep_interruptible() -> msleep() patch from v1, as the
>   40 ms delay in the driver is a conservative margin rather than a strict
>   datasheet minimum and cannot be validated without physical hardware.
> - Link to v1: https://lore.kernel.org/linux-iio/20261120-b4-abp060mg-fixe=
s-v1-0-2baf026cde47@gmail.com/
>=20
> Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps=
/siot/ko-kr/products/sensors/pressure-sensors/board-mount-pressure-sensors/=
basic-abp-series/documents/sps-siot-basic-board-mount-pressure-abp-series-d=
atasheet-32305128-ciid-155789.pdf
>=20
> ---
> Oscar Alejandro S=C3=A1nchez Lucero (2):
>       iio: pressure: abp060mg: Fix max pressure value for abp001pg
>       iio: pressure: abp060mg: Check for short I2C transfers
>=20
>  drivers/iio/pressure/abp060mg.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> ---
> base-commit: adcad7f4e6332cff3d6d7165f41584899f598534
> change-id: 20261120-b4-abp060mg-fixes-fa5c210392a6
>=20
> Best regards,

