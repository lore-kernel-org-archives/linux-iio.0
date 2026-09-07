Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8441B2D7BF;
	Mon,  7 Sep 2026 01:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788746098; cv=none; b=QWvgISAQnGPahJjM6QB+nrQkdVrRMVOvtEAGeW3N3oEvIibSnSWimlnFBohWBtkUXD9AsLvl4DdUuPnnAbdp6R5l+veisPaIikDoXCU6sTJAps3aaxfXXTl4YPYoYNea8mpqHBWXRxzm5cdfKpE/4iJh+XKfqpmqXt5ljC2fjRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788746098; c=relaxed/simple;
	bh=y+sjUc32NEPDnCgrXvJq2pu4snPojuQwGsErDpHvasU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=PyVY0iRWJghMwmBhtsv+HlPVrJgvVDzRXzkiblBTmfG8MX8A4tIENaF7Ns3i+5zeluNLvXmskYdcCrpATOgBeV1161GH8mrQ46xSkR2bIHVJdxFOBX9OhQDPUhsUTW6maD3Cbn7ydbJt5fYfOE6t+gpfV8vevasm7Lplmn5m41A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvN/cfxJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvN/cfxJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E7A1F00A3A;
	Mon,  7 Sep 2026 01:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788746097;
	bh=7V6Xs9nIJ3enoH+qXaIZO6HrRvvjPahwLWNrVDZIKvA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=OvN/cfxJ/mi4QG2yEM7dIknGXpYFhhRs8fJJNQjUM8uRbCeeTQPsTrpUd8xnh1TFD
	 waXCQKr0C7DSkpoK+qAHz3PfmaM6ZPlNQ9ZEfN0MaG+LlOibO+Ar1dMpdvST3SIc4+
	 JR59Wg1Y21cnH6/h/g22VpJxrKs2b2REBHAxWWGgkxvH5efr6iUDQiKtcS2UwVp49x
	 +8VA2VOYyN/M5VSfugHrUW4ZSrPrPwyX/3Z5YfyRLXqjK+S9tdd8oYxcu34GGtqa89
	 ze4XsqdliNDRcNc0itnwmhSGOz6IG+8m6RrNU9AlVEP2gCY61o+irhmZGq4ZvH7R52
	 55D0xuMlbIofw==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/8] dt-bindings: Add InvenSense ICM-42370-p
 accelerometer
From: Jonathan Cameron <jic23@kernel.org>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Henrik Grimler <henrik.grimler@axis.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
 Chris Morgan <macromorgan@hotmail.com>, kernel@axis.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260901-b4-inv_icm42370p-v3-1-77cc31642115@axis.com>
References: <20260901-b4-inv_icm42370p-v3-0-77cc31642115@axis.com>
 <20260901-b4-inv_icm42370p-v3-1-77cc31642115@axis.com>
Date: Mon, 07 Sep 2026 02:54:51 +0100
Message-Id: <178874609181.3402141.14348716380765604460.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=606;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=y+sjUc32NEPDnCgrXvJq2pu4snPojuQwGsErDpHvasU=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqnhlua2CMAKffdA3jHhE8aYJi0A9qoccooL4dJ
 xPWxtnleAaJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCap4ZbhEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiKecEACwXxd+d5HtqUlqbNat5c8Jm04e8AT18isW2TXXQO15GKo
 PSD+ZqHyGKuvpTzMW00JK08NWDxZRBbhqMl6w0nsbp0amLwMr4szvHoZ6EQ5vhFomoyfFmFvMHJ
 BR1M8bZ2XobWYD+z3XeY4h9k7Ce0WFV7Skq9TmmtMLCrHT3NKyQuWbAt1hRITpp4PGoLTKRSSd8
 pmdKztW7uB3DgGLI17SXr+A6f1bGxotT+weQp0ROlVWlatsB/Mx5EAGmw8J+ULQC9C04qv90ir/
 XnEu7gDby5Xamq2tqB+ebf4DubuKgi5vvVQ16xtlXaM4YPIgaTQ8FGe8gNlzMlFumlEzfL2PQDk
 8biUefPULlDGgjodAy2GsU1Vfj4mut6PdJ6cO1hBfikQESO7PFQD1HhQ2/YFzkmnMMWaG6yf+Jc
 j/gcYo9vKOIRpSCztvBxCiNNfyfOjTnA4J/OYVDgioMLv8SJYZKe25eBumxjMbTOK6rPhXOSlys
 7gio8kCvAFIbgduJW6RzxXIkKSjYCgNEONT3dXMc8qRBLOyvYpwAbVrFd0Tm+OypCDwITK70Loj
 riHuoW+ETaEZYlopwxAy/IaeppMN2Z9eIjEPkCeBsBVznDSNFageXU9GkZPZNaGgfj0znrLlPrE
 thZxrmJJ7EkqMnewurLhVO1MsXmYH68/vz64lrg==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> ICM42370P is a 3-axis accelerometer. The device can support I2C, SPI
> and I3C. Add the supporting devicetree documentation for I2C as we
> have only tested using I2C protocol and leave the rest for future
> work.

Sashiko correctly calls out that this needs an update given the
spi specific properties in the binding.

> 
> The device supports VDD and VDDIO operating range of 1.71V to 3.6V.
> 
> Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
>
...

> +  spi-cpha: true
> +  spi-cpol: true

Thanks,

Jonathan

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
