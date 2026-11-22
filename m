Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795371165;
	b=mALsEEeePDyU0B2a9LkL8xCVHO9RiVfiOYe7SR8tD0VjfxrTmwyNn/J6J98fGw5mW6np
	 ltronAKBdI530PrupprdhkSa/s4s3SAd7e1LRoUMV/bX5vSmRYVlGcu+CvZO5kM5dU9YF
	 m6epc/TdaQcvGCGkH45ORMctv7z+0VGWjKcxtZkV6vY9SsqHK17YiEBtAQlpqswHFjZge
	 Hb7yyWznLp2HBtm/KT3gxAVu7SxPyb/cIaoKS8733q6nNIqX1+6sLVukAGD1kvt1+TLJa
	 UraaJyAnvGT8gRK3H4TcqgUoitBbizm6gryNQ1wPMfVHjAOPL1hCiimUWpXnbXjQGcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795371165;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=YJaCgLHs/Q7Pp0/P8Wb8esuj5mGDsQYN+PhwL3+DWEs=;
	b=Uf/AALJ/5un46hQTZMNWgqoI7+vhu/5vtIsWeqZOH0Im1Nr6y20QxRgTenKuzRlWDx1h
	 8BmeNHw0DSxIY0sVAJ+tHMWJqIr5VM41ZPO3E913lS7XnIfROrMMH9ZFWF3vBW5GzdeTO
	 skC2hE7bolz7kO0mPzxoc64n+hDZscCJ+cf0Se8hdf9Ay2UQXTVkh5+QZHpvBKTPaDiEj
	 NFVL91ZZOnmLuAhTA1z/d/7MSeaTNNsOia/+ENZIOH+yyku8DLVaTv/TxP3DOUtZ1dyCC
	 yLy+XU4K1lY+c0Z1B6IgOtoP/woe6VgQqSbGf5UxtjYiJsPLN3uCxW9f1qL4cKmHsgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UbryogAd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42687606A32C;
	Sun, 22 Nov 2026 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UbryogAd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928C41F000CA;
	Sun, 22 Nov 2026 18:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795371164;
	bh=YJaCgLHs/Q7Pp0/P8Wb8esuj5mGDsQYN+PhwL3+DWEs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UbryogAd37+gNK4Q2RTHnzlk9aiVpVpcch2fJA9vO7FjFGJViq1t69wW3q2Qv1bOo
	 GPgdEIEv+rL9AL2k8y6dPvUNHA0bt/UmTHCd+stDrrkYj/2+Rx5m0N0QLF39tgtpb3
	 PqG4xx21k9oGg2/ovYz/OhpCaurT1I32a1IiryJNhHZ6mGxgc6IWUzENRtojvDqWKx
	 u9+9EjKDBpb4PLSpJbtUvKGldLZy+a0BpFHBTsnWATCY9I8IzBlI8JBjlFRDmZ9W2H
	 /OyT1F1u9BDSv0Kq4MuVleBDCyUtSdHvwQLDPHu/CO4mKL+7jXR0xF4Mt2Q/PjWdlQ
	 YiG5n7GnoSTVw==
Date: Sun, 22 Nov 2026 18:12:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@analog.com, devicetree@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org, Olivier Moysan
 <olivier.moysan@foss.st.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Conor
 Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 00/12] iio: frequency: ad9910: add IIO backend
 support
Message-ID: <20261122181232.5208e160@jic23-hlaptop>
In-Reply-To: <20261116-ad9910-backend-support-v4-0-fcf1ad364ed5@analog.com>
References: <20261116-ad9910-backend-support-v4-0-fcf1ad364ed5@analog.com>
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

On Mon, 16 Nov 2026 16:39:52 +0000
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> This series extends the AD9910 DDS driver with support for an IIO backend,
> enabling data streaming through the parallel data port, and with control of
> the DRCTL pin, which defines the slope direction of the digital ramp
> generator (DRG).
> 
> The parallel data port allows modulation of the DDS core parameters
> (amplitude, phase, frequency or polar) at up to the PDCLK rate, which is
> SYSCLK / 4. Such data rates require an FPGA IP core as the data source, so
> an AXI backend driver is added for the AD9910 HDL reference design. Besides
> streaming data from memory via DMA, the IP core also drives the PROFILE[2:0]
> and DRCTL pins. The latter is exposed as a PWM output, so that the frontend
> driver can consume it through the PWM framework without depending on the
> backend being present.
> 
> The backend is optional: the AD9910 remains functional through the SPI
> control interface alone, hence the new devm_iio_backend_get_optional()
> helper.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Applied to the testing branch of iio.git.  Still time for any last minute
feedback as I won't be pushing that out as togreg for a few days at least.

Thanks,

Jonathan
