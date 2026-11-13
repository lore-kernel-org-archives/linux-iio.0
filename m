Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794535172;
	b=C4OoT426TjYUj421Fdcv13DW5Ow0H0MCInQr3S3kZbFNtI85Ydg9+NbZZBlqFfrzNLWv
	 /J/PaGePrEnLR3GMVGRdrEseE+UMues1sjAlZSNrfPVeKxpQk8INZh5FK9+gB6mvSUm4G
	 uTX5oBNcnfmqsQHYkSqnXDwoZgnghqzJ2b+05i94iUQvoI46EKEIdzpHWC9+pY4+48CK6
	 4HyMb5MqfqbYiz6DqDYuInP5EMhF3Ds1xb3OWkg4LP+Nh6db1zwIVN7t/yAez20steFFH
	 hC+0RCMHEYBoHn5W/T1vkOblxzCFN/kj3FS6lCoYUpqoDR4nHQRUdjPtDbBbI5N22zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794535172;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=B3TZduTnFzChcHGfYfZGHRmxnY1aolOmHvj30T88wh4=;
	b=XUXZscWqB90Uu2iRLPWm1/i0gcd6GC23BD9M8NI3hkEc1DEKYFb9OsAj9DBNt2c6qDNq
	 kkayAvfOzmh1MY/pNCN2j+xrzxznr9IXvHFZ/CadqGWSbhJUAgUmTX6qi6/lCBt6PuJCR
	 nQ4hc3Jaef/JfuV6VNZbumfm1b1Jz+KG77W8HeUZlzSsGgruT5EoQUR54XqV/ZXs4Ng2J
	 340VO+z+e4YuPKELpI54TIz4uD/lTSot70XKaXkiaGL8pBKt+052vw8WoG0mm8D+Df8BG
	 IhO7SXxubjzHFlMmX7CIPljhiWZRbxq/5msY9IpPmEqwDyaQ2Dv9YAov2RwvDFRMB1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZJtPH+Hu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F187606A31C;
	Fri, 13 Nov 2026 01:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZJtPH+Hu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FDB1F000C4;
	Fri, 13 Nov 2026 01:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794535171;
	bh=B3TZduTnFzChcHGfYfZGHRmxnY1aolOmHvj30T88wh4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZJtPH+HuttCaLSL5bTWc5HpRiOYvBtGXoHMqgof5AZ+sEI0dZb431ygMgMQ5rPowq
	 H++BwoQzN5ON489nM5N+yGtnjTzpPCmcKq4ukuNLRODNJSfT1zFjY02dJRgOdkq1DW
	 +RnXyaNcrWzjysibtdgsrxtXnYwlWb19l9WuJX2T1z2lWIBwDkzwH6D5LLoCa9TMoQ
	 jOfFFJMp+B+2EQIfr+1AkCPiBlCNHKza+pexxxt0n0UhzvujEH1mP5BRC0Qb9P9gHe
	 6NCecFcdJir1/tk49DfAF4o11rpCWZnoKDHmyRnIBWPmDVhHuEVRYATAyaIu+oJGRg
	 5rWrB0EbpSk8w==
Date: Fri, 13 Nov 2026 01:59:28 +0000
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
Subject: Re: [PATCH v9 0/7] Add support for InvenSense ICM-42370-P
 accelerometer
Message-ID: <20261113015928.7a691cf1@jic23-hlaptop>
In-Reply-To: <20261112-b4-inv_icm42370p-v9-0-875c828a281e@axis.com>
References: <20261112-b4-inv_icm42370p-v9-0-875c828a281e@axis.com>
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

On Thu, 12 Nov 2026 15:29:26 +0100
Kanak Shilledar <kanak.shilledar@axis.com> wrote:

> InvenSense ICM42370P is a high performance MEMS MotionTracking 3-axis
> accelerometer. It supports I2C, I3C and SPI protocols. It has a 2.25kB
> FIFO and two programmable interrupts with support for ultra-low-power
> wake-on-motion support. It has a built-in temperature sensor. This
> patch series adds basic support for the sensor with functionality of
> performing raw reads and writes via the I2C interface.
Applied to the testing branch of iio.git.

I'll let it sit there until sometime next week and if all looks
good then that tree will get pushed out as the togreg branch that
linux-next picks up.

In the meantime, last minute tags and feedback can probably still
be handled.

Thanks

Jonathan
