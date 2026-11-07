Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794012631;
	b=sOayPfp5gU5hDLNwZQBi+7Oz+7O1dz57IwSORbUZLjz3l9q5QQhTMwMlPkmGpRwdx6su
	 vosOnTmV2lO8Lsuwc0QlJeyWLiuQHwvlbFHWchxeN7E5UmRR9mBfgJj1O8rWKliQ8KPHT
	 A6SLx0ioOhXMB/ujPuzrPHYXNtUF2DyliYp6u/1XvW22m9xk16LgUS5H4p7Cqm8qL8W9B
	 ztO36IRXRwNdg3KpwQdCoi+8V8U3MCnmZbXmfSGm/xWejNqJChc0jcF9s5OaqtlxYCLGt
	 ck/IwS2wS6fVHz1/wCAd7sQxHUR67gC+oFhNeTmr4be5APNcOhRLzW7UWKbjycLzkOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794012631;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=YvuNwDxYdIJYtjv3UiiK3uOyQ+zAAh9DIMTs36nyuiU=;
	b=PAy0sDOD6PODsVR9IPE4IZTZjd+kVFYUC2b5/VEnlG0qWetCqFm2uFkK4CScfuLES+A5
	 Z7qT8HQSTMybNTwlxdLzjssTfOM4WG1sCYCDGsRTL4oISTaFFOVCxPM7sjNhRat++x8+l
	 FjGGI4vSdsjDaD7CwnTz+2WHZuqv03EdmS+7oyw2k3zBvUdD6v8JBpQFKZNhQsJav/JrE
	 o95myv/Dl8H+A74vfDAk1O/jG54w04bDIRKLz2XTgq9rOdT0+e1sP/ky+KEL2angxvp2G
	 Oci2mVFD3+Bzawz7cq2igR5G2I5kRBYHZrucyynbtjKU2Jyik2oeqzlgmaUqqBhFQ2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=htAyK+qg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24FA606D81A;
	Sat,  7 Nov 2026 00:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=htAyK+qg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45FC1F0089F;
	Sat,  7 Nov 2026 00:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794012630;
	bh=YvuNwDxYdIJYtjv3UiiK3uOyQ+zAAh9DIMTs36nyuiU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=htAyK+qg6c2lfK0GT5TnMv48XiWiuqvfkjaRI6aIz648REC5Twl5lgxRUHfUF7AZr
	 JYKZfs4IlF7SkjxB2hREB9PjsIFdHtqjL7dA2Hz4whq34XjGSg7kue/SFOC8uYVJIK
	 KtJmD8MjKZFcogCkEhEgDerpCqSgttfHva2lc0xaKuhoakzejPR95Mybyq0RoZHHD0
	 I5kaCRI52JrcRg8ofWtDW0ufLZxiHQVnEz4uOpYFsgzVeC1AJbzIJgDOtNR2GITacX
	 yiLsdK2lrRYmg8ZEph44mZbs9lqBSevPnIuaJdA99h8LSFfw2/IGs4eTEWYDEHbIQH
	 U5MuwxO1WqerQ==
Date: Sat, 7 Nov 2026 00:50:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Patrick Fischer via B4 Relay
 <devnull+admin.tsv-stahl-riesa.de@kernel.org>
Cc: admin@tsv-stahl-riesa.de, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Kevin Tsai
 <ktsai@capellamicro.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: light: Add Capella CM3217 ambient light
 sensor driver
Message-ID: <20261107005021.11405483@jic23-hlaptop>
In-Reply-To: <20261106-upstream-iio-cm3217-v2-2-d97adde9171c@tsv-stahl-riesa.de>
References: <20261106-upstream-iio-cm3217-v2-0-d97adde9171c@tsv-stahl-riesa.de>
	<20261106-upstream-iio-cm3217-v2-2-d97adde9171c@tsv-stahl-riesa.de>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 06 Nov 2026 21:56:30 +0100
Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org> wrote:

> From: Patrick Fischer <admin@tsv-stahl-riesa.de>
> 
> The CM3217 has no registers and no ID. Writing a byte to address 0x10
> or 0x11 sets command byte 1 or 2, reading a byte from 0x10 or 0x11
> returns the high or low byte of the 16-bit light count.
> 
> Command byte 1 holds the shutdown bit and the IT_T field (1/2 T, 1 T,
> 2 T or 4 T), command byte 2 the FD_IT field (800 ms down to 66 ms). The
> count scales linearly with both. The driver exposes FD_IT as the
> integration time and IT_T through the scale, so the scale list offers
> four ranges for each integration time.
> 
> The datasheet is not public. The bit fields, the reserved bits that are
> written as 1 and the startup setting of 2 T and 100 ms come from NVIDIA's
> downstream drivers (drivers/staging/iio/light/cm3217.c in the 3.4 kernel
> rel-tegranote-r8 and the 3.10 kernel
> android-tegra-flounder-3.10-nougat-mr1.1). One value differs: the vendor
> header defines 4 T as 4 << 2, which is outside the two-bit field. On a
> Tegra Note 7 field value 3 gave four times the 1 T count, so the driver
> uses that. For the resolution, Capella
> gives a range of 0.01875 to 119156 lux. The driver takes 0.01875 lux
> per count at 4 T and 800 ms. This matches both the upper end (65535
> counts at 1/2 T and 66 ms) and the 0.3 lux per count that the NVIDIA
> 3.4 driver uses at 2 T and 100 ms.
> 
> The sensor has no data-ready flag, and a new setting only takes effect
> when the conversion in progress ends. A conversion takes IT_T times
> FD_IT, up to 3.2 s. Leaving shutdown starts a new one at once, so the
> driver passes through shutdown on every change and waits one conversion
> period plus a margin before it reads the count. The timing was measured
> on a Tegra Note 7.
> 
> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Tegratab P1988
> Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
Hi Patrick,

This looks good to me.

I won't pick it up just yet though as need to allow time for
dt-binding review and for anyone else who is interested to take
a look.

Thanks,

Jonathan



