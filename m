Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794023512;
	b=EM23eveoxgVJ6vQOu3u+dfb9jjhidsIaoctSvSOeLjDKRgWmRYCU6+AEOjhAd8k1JKBF
	 f/D5sPzKO+/BEa5Z5bZD3YMynVoSOhxXU8qtjtYmTH8hBbRf7E1ghDAZ42rjliG9gCYXq
	 dN1d6MSkfYEwGcmVPZMUfkWB62MS4slVuafYliyMojhWnddRwDbaQLV3nrUctXrElgbob
	 8IFdCSWTGJuVwxtTG32jVXsudP1JBpTMtigJcQ+AoO2aMhKKX2l787NoRR0DCqCgvO6Gx
	 GJ95V+mQxKSY1PzdpvMtc59BSCY0mbmJ5wv0gKfySCWBBC4oNm9mWuTrVQXcjBzXbuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794023512;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=f/DC+tSsInliv5Tu3By5+T3A/cR47LlwUoItIGDPm1s=;
	b=oB7WNe7Y6bwKRx7AyY/KfQOwdocF2DbCrN+DvEQd7MdAeo4vcg5c4zIQ887h4MXIzah+
	 KtO/pWMpoqLGpsa+MxO+4+QmEuOS0Q19h46Lijk/MFVmDif/kHD/KT0Ey+85T9X45qbgU
	 RvyIlUDe3BftPkg8Hv83F6tO+07oARzOo//nPy6RXG8GLgIZ4ee5a9KqSU1QnXIUY2F73
	 IfjmfSObzZG0cnXwKAdMNAXUQ7f87Kq5PlDyTd4siMU57HDtW58aiAYmcwivW6uuNOzUj
	 mOmcVudgbPkYMac9Mk619x9puoU7AR0V8nAXuF9YikhNmH1dc8DwS2dN+8YS4ItZTWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bj5WD1uI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC141606A326;
	Sat,  7 Nov 2026 03:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bj5WD1uI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C771F0089F;
	Sat,  7 Nov 2026 03:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794023511;
	bh=f/DC+tSsInliv5Tu3By5+T3A/cR47LlwUoItIGDPm1s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bj5WD1uIwXY/YUvwvG4xJyLsr2cffD9fYl0vmtaEL2X//89Y621FqJ3VVu58F1HUG
	 NrDiEE8ozBexgmG81XHOxr6zi6PyeZC3f3/pcG3b4vz9Dae4LiRZq3IQuLaLUEet/l
	 fl/Det52UDSi07DSiNl9lV3SzeSxdC/BmVOVG3AkVw/VrToAkJW1sZGZPyJcOpwIob
	 ZR4W59d8zAHQmXDUEL0oCSo9WttOxI/yy0OwTaRCqJ5p0GMCS/M/FY6ZMwP3sT8f2F
	 NFkoVPp/edrAQisYeEuBdyd1EPFFgzxU7KOgQPQfLMLQ8InhOPurG//UnT1YmY3YYQ
	 UJVeBGFuN/+uQ==
Date: Sat, 7 Nov 2026 03:51:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Henrik Grimler <henrik.grimler@axis.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "Jean-Baptiste Maneyrol" <jean-baptiste.maneyrol@tdk.com>, Marcelo Schmitt
 <marcelo.schmitt1@gmail.com>, Chris Morgan <macromorgan@hotmail.com>,
 "Joshua Crofts" <crofts@kernel.org>, <kernel@axis.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Jonathan Cameron
 <jonathan.cameron@oss.qualcomm.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v8 7/7] iio: imu: inv_icm42607: Add accelerometer
 calibbias support
Message-ID: <20261107035143.4f00d34f@jic23-hlaptop>
In-Reply-To: <20261105-b4-inv_icm42370p-v8-7-b44eb96020b6@axis.com>
References: <20261105-b4-inv_icm42370p-v8-0-b44eb96020b6@axis.com>
	<20261105-b4-inv_icm42370p-v8-7-b44eb96020b6@axis.com>
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

On Thu, 5 Nov 2026 16:48:55 +0100
Kanak Shilledar <kanak.shilledar@axis.com> wrote:

> Expose IIO_CHAN_INFO_CALIBBIAS on the accelerometer channels. The
> registers are stored in MREG1. The calibration bias is written to
> OFFSET_USER4 to OFFSET_USER8 registers in MREG1. Reject the out of
> limit calibbias values instead of clamping it.
> 
> Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
> Datasheet: https://www.lcsc.com/product-detail/C5129967.html
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
The series looks in good shape other than those dt binding issues.
Fingers crossed for v9

Along with the dt typo, there is a question from sashiko
about one check that seems to still use a gyro register.  Please
take a look:
https://sashiko.dev/#/patchset/20261105-b4-inv_icm42370p-v8-0-b44eb96020b6%40axis.com
Jonathan

