Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793953295;
	b=qB9x6DatzjOicX4NEsDC1yPLTZ2M10t2KrJ/5bVO3BC5jeh4ywXoi0wZnYTlHqO1Ftqi
	 4WPSRQ0Gd18rRXe1gq7DfNCHilD16pDwfWcZ32BFOR3vn9JUS0fe31wCA4gJ3jIJIcDWl
	 IS3CnZXxdkBqI4YhMBzpL5sc6VmXwuhmw1RYLzdnXQa8uG6W5SfaRrSBrSZjjdWcCRXdh
	 v9QQPyh/osre4rV7eVNqwpex+VIunDptLQPnsSkzNaK1bEumHdjveovpjGr00PsaDLrXi
	 Bkdw/WgG3c9DeuDXesoLVQqPPgA2D2Rr6Si+huxED0nF64yGgq89xS0A05d877gdkSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793953295;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=WmstpSnBSKpAZAcmaXaDjOLcmk+Ft1xPnpM15tWGe3Q=;
	b=dyPzCvfuZ15g8kYK6JFQSaFv1Lvy8o80aAEcuvujUDzKKFx40Mr/jFOF3OX8xUuIaoSY
	 Qdyj3t2Rj7yX7TyL5Ll0+Oi0msSwHXUzFeSv9TgR3PnwqIFTJqYKT0hex0E/LUFoC+i8E
	 yi6534uI36dbZW9v27Z+EWawUIPtT+8lEcY35uOBTK50JxmhK479SEQ69Tc6q6emR2PLe
	 JJdDlWQ1vJeONyePUSsk4dgOjXpaMMztJjAbVx9hsYJ/GGwxva9cUyxXw0+gQXJuBqKCk
	 P7sS0q49sjvUU86ot6uPeJsxBhShv6ia3r9zBVJGrT+ZoEz4GkVIxu1dDrloJ42TUYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T+4rSrdM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CED0606A33E;
	Fri,  6 Nov 2026 08:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T+4rSrdM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1BC1F008A4;
	Fri,  6 Nov 2026 08:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793953294;
	bh=WmstpSnBSKpAZAcmaXaDjOLcmk+Ft1xPnpM15tWGe3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T+4rSrdM1ksGmp17lGef9LSrbvCSwHxtd0Zdk6C9U1MaNPfkHVEVPynGACD8ubKRG
	 pFZvPwXBQltEwZZd8Jhl9JqFwL+nMgO9VGrZz1dyY6b2y9sUJPysEzWGvjvqjlWMzL
	 nOtMgJs0ZI/r9wUE24sshR8r6Dr8In6QHx2s7u5HPX5nR/eBvwlrmYXyCsMl5FGfrW
	 TG0vaZx2z88Yo0WqTM5SVyrAXw6OZrDx8FH2R1vnB1ucpkPAnyxPUW7JOxW5FkNFBQ
	 rmhBQgpc9g8kqkrLbkDUwDAkBMGVYRtToGNpmrSMH7nY84MSrRSzmSEm7eJu4SHdfN
	 fLbATTms0h7RA==
Date: Fri, 6 Nov 2026 09:21:30 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Henrik Grimler <henrik.grimler@axis.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
	Chris Morgan <macromorgan@hotmail.com>, Joshua Crofts <crofts@kernel.org>, kernel@axis.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v8 2/7] dt-bindings: iio: imu: icm42600: Add ICM-42670-P
Message-ID: <20261106-jovial-rousing-baboon-277581@quoll>
References: <20261105-b4-inv_icm42370p-v8-0-b44eb96020b6@axis.com>
 <20261105-b4-inv_icm42370p-v8-2-b44eb96020b6@axis.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261105-b4-inv_icm42370p-v8-2-b44eb96020b6@axis.com>

On Thu, Nov 05, 2026 at 04:48:50PM +0100, Kanak Shilledar wrote:
> TDK Invensense, ICM-42370-P is a 3-axis accelerometer. The device can
> support I2C, SPI and I3C. This device only has an accelerometer and
> lacks gyroscope and it has very similar properties as that of the
> icm42607/p the gyroscope feature is controlled via the driver depending
> on the device. Add this device to the existing dt-binding and update the
> description to match the devices.
> 
> Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
> Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
> ---
>  Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Valid comments from bots, dropping.

Best regards,
Krzysztof

