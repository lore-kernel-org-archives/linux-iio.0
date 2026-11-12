Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794520124;
	b=rzurR9f/DvrL9TFXdbqjFDGqlTirTgQigm/YqFhOa5YSFZ22IjYUYfW90WP2Uw+P/30P
	 kojNeeuMb5FgjEiuAycHp3GcN5KtlcVjwXN35oY7MG3p3EvQAp5mX4CH18QanQ8RZBoB+
	 7XLfLw0Qq3JiYhOnzjZuzldvrxznHt803iqkCNdOpvdMr949o94jQmcI28adiHeAIfNUn
	 A/0z3bDCVvScRxS8XvZrqbWZon6vgqRkf+/wQD5PiJeiU6jGwg5s3Q/drXhkOkNTAsPJJ
	 EtWFLp63oOAz4bAt/zhMfHw8r7zHkoKBnnpF9o08MXwn3qKgRQ7rvh0L3hhkC1NPPaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794520124;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fesgCzTxx5071HiI0xE+w3LpgmsF8//ZkpUzdTSqsMQ=;
	b=JWOGNV0kmj/jtz5xhPvlTurvvQkKkOixnCslxBd+alaliYO5Ug3GtYjwIjch3jslB5oQ
	 VMjXSgWwq41X0X2SwCjjJxyMaMeDhyK8x/AZtAECN4vG8nNnHzLdaDJwsJtXg4fdGDcjw
	 J5PSEwrj6AONswebzHQg4pLMZl+/V0agrF5/e5MI8KLDXwmjDSPkb9OKNlv4oBh//j7KC
	 0FV+5aUPEqT6xPlGfOAEOtqW8JIJfQBNowmTTxToz9E08yRnrCyCXXNbq8ZkppiiwBbjg
	 3tA2QjSEtJCAFoARmNhOPoTUlBkU1pApqajiZCGLpMndJSoJyGBOdV7gYLTQ9vmLhpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mga5IDXi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A429606A31C;
	Thu, 12 Nov 2026 21:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mga5IDXi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A031F000C4;
	Thu, 12 Nov 2026 21:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794520124;
	bh=fesgCzTxx5071HiI0xE+w3LpgmsF8//ZkpUzdTSqsMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mga5IDXiVkfFb5x+s/upMmw92FnnOD9XVGkY3ZZQBS+Tz2lOdoHmqMw3Hj8hblhk4
	 XzCxnasjDdUEKFtIi/BEnBjUVVomwlt79wLC1b0gLMmScnAInAOu37aDmhNevi2f/I
	 OahAwIRfbkA4C5hDL6GIYxJkOpLiE9FbvoinauvqnCqhPgA/BKUdBfdHjam2navYCQ
	 s8PxNm+tGDxeJDRcMSnJSB/6lI+/LqBQlTuicmMitZZl5PaLJlI4v4B6QtwW/cMb06
	 8JGV+zHm+yOKfXvbGw96Ob+GDgv84h54yQTq5CdAxDexTPUSQxbABE7rPNijr5WWNa
	 6EQEcCGhDlqOA==
Date: Thu, 12 Nov 2026 15:48:41 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Joshua Crofts <crofts@kernel.org>, kernel@axis.com,
	Chris Morgan <macromorgan@hotmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Henrik Grimler <henrik.grimler@axis.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v9 2/7] dt-bindings: iio: imu: icm42600: Add ICM-42370-P
Message-ID: <179452012130.1414504.2731805588656381924.robh@kernel.org>
References: <20261112-b4-inv_icm42370p-v9-0-875c828a281e@axis.com>
 <20261112-b4-inv_icm42370p-v9-2-875c828a281e@axis.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112-b4-inv_icm42370p-v9-2-875c828a281e@axis.com>


On Thu, 12 Nov 2026 15:29:28 +0100, Kanak Shilledar wrote:
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
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

