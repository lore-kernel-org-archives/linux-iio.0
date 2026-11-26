Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795656567;
	b=bmkwoydXL1waicK69yys37cEWb7kAV4sefFCAbN0Pom+GT9LNK+74ylXVcLa2J2ZHCZ+
	 vQWLZktMF2wf5nvWgr13viT7NK18z1m39hYYGxksv6WdAXXYA3zbp1PBktKprVa0/5vYv
	 rxfF7utXI3eFvtddRd1I3huSNdZLyobeg22Zzswb6s8V2iNgSbZOAArNFytOCwDADFpcr
	 dmTEIS5+n7pGXvXIplE3r5M3bQwwq3jF2WuaUOvLnN3x2E8J3utfFI5e2d9xCl2ssvroH
	 TsaoifTsLR5ZDcsnb+ZKP4/9iN91jVKoEwyGPvCPKWYgwj0xTbvfiq28mg8DqqU7hpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795656567;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=lYfAzimQeKYglGy8WwevUdBKNNX60VKjrnfwkOqQRfo=;
	b=ubUSlFJabHz3l3TZv2mUaYfL+wvigDv9QCVjHVHzFRcZc+jvYlpz2vVcbw0O0jd3n+HG
	 PO4AOzrYfq9epYzEwPjQ4GWibHOkeMsx2L1FXcktGpHn+C2Wqbw2gtQRKjv6TkSp4Q7LG
	 70ZgJ0wm8IPAy3M4nMIAWAhNFY31kQSdqVGUxe149C81eLbKV1UPTrifVvbTbGtGYcln4
	 Km5dvglfoDdoFdHB4EiTjHl0nc+epQP0VZC1/iq3kEiPH51QYleXdp9yNFZtTN4xfEYtF
	 OcBZk9vqKxwOgbRYuI8FRbPuU7EnT95rniNaf2C1onmWUxC9PJnoE3DZq8rGxPH+MxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dxMUR0dD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB17606A31E;
	Thu, 26 Nov 2026 01:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dxMUR0dD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A00E1F000C0;
	Thu, 26 Nov 2026 01:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795656567;
	bh=lYfAzimQeKYglGy8WwevUdBKNNX60VKjrnfwkOqQRfo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dxMUR0dDne2xCfqgdQJjwD5xehGGP8/ybUT5OTPtfm+bfLou496LTRhExMEH2h2Li
	 3AE4DFFh492a84zIJdULB7X2kIkhCnMqZxLRfoiOYN748O0HjXBkFqq8bJg/jST+P1
	 gpPGb9+RacItd1fqshv88tbU6aoEhN0/NazKtWA8QF9n5ISTsKxwbxnjGNF7gmUTv/
	 Oqx8inzQDu8P1Gc53ZHklmmM1DIgMSLnJrhi8stN7eK1q0+J1GgzugQgamup+OoXOy
	 m0HuTEo9qnCgdt4hrYyioBVx4I8bghC++UCZhWUAgBQYkz76FIvNVsyboBsll3bhAd
	 AFWMW5vQwzxKw==
Date: Thu, 26 Nov 2026 01:29:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Joseph Telaak <joseph@telaak.dev>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Peter Rosin
 <peda@lysator.liu.se>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@analog.com, devicetree@vger.kernel.org,
 Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 0/6] iio: potentiometer: mcp4018: Add Analog Devices
 AD5246
Message-ID: <20261126012919.4a3e9004@jic23-hlaptop>
In-Reply-To: <20261125-iio-ad5246-v2-0-8feeb630f0b6@telaak.dev>
References: <20261125-iio-ad5246-v2-0-8feeb630f0b6@telaak.dev>
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

On Wed, 25 Nov 2026 15:22:27 -0500
Joseph Telaak <joseph@telaak.dev> wrote:

> The AD5246 is a 128-position I2C rheostat that speaks the MCP4017/18/19
> protocol. This series adds it to the mcp4018 driver, so it can be an IIO
> channel provider for an in-kernel consumer.
> 
> Patch 1 moves the out_resistance*_raw_available ABI to the generic file,
> patch 2 reports the wiper range, patch 3 adds the binding, patch 4 turns
> on the vdd supply, patch 5 moves the scale divisor into the per-part
> config, and patch 6 adds the parts.
> 
Applied to the testing branch of iio.git. That means it is now queued up for
the next merge window.

Thanks,

Jonathan
