Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795060427;
	b=LEaTtu2qb4ibaTaK2RwDnJ2mEbPfwmGGYSQYtsnnjYYK+E/JJuOBHzlgGm9VcYAOT77H
	 9Doq3hO5CsHLFw8bSTUYcyvucaWXawJBf9JL99CVuLk0BcVS1seOKGGwGEvfgLVcNWNfs
	 X3WDFv+3ng2Zcp+7Gbaa/seUwCUTexr5YXbsBbSwGpOLFHkJjqV4auQk4FLu9KybLPhpF
	 5ExH2oih95xbS136V22C1axNlJ6oCul4bTWRKHkfhI36DKlxRzQZXSB9dNSJC9tZD7n4G
	 Mi1LijwXDObx8V+kEEDZK3gyEdh3BtSljotGQePAt92Cq3npo5MILKrDtq6FZJotN2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795060427;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=EJcdpzpdc4ymx97V4fcL6Pc0CDvdbAOt3/GU/41gBrg=;
	b=P1S3HIdNwkhzQhm5+2aBw9wgIhOnxsBPEJDErlRJT/1ql1nXFUQ4AqYwKJPpct2lSC/k
	 cFS1cZj584pL/YIpDlO+oqr7JnJ26KL/n1LvcnEPTM0gUJudcBxlAyPoV32NPlvonpcJM
	 Z71ERmjYPb+frm4yPpGQ0Hjee0tG7MCh7mTrYcvVJyIpAk3gfu7lG5sZXhIzaTEUADjNP
	 hfNVl3HD9egqBxI5t3dHFTXWPQbfFu7vdKkqIpwS40LNfyX4bWxm22PQmEOCZMsFDvGfY
	 ix/moPmrZQICb6o1njw8UFC/Qrtn1rDv93bVd9M2j6OtNfynvC3c5WsymGoQmpyQmWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JPk4zqLn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA549606A326;
	Thu, 19 Nov 2026 03:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JPk4zqLn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BFF1F000C4;
	Thu, 19 Nov 2026 03:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795060427;
	bh=EJcdpzpdc4ymx97V4fcL6Pc0CDvdbAOt3/GU/41gBrg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JPk4zqLnWhppufht7KxttQiIZ/H8BR75b3tuiQkp9xzTLGIyjKBdb461CNyOBV3mZ
	 2LaDdYObAkor7xkOW6GDK14mIainT49IfGtrKfOXVcIxq8hHwazXmd2IrzmxqvN7/F
	 GlB3toOV+Exbdmqr+T3OBrvETP3Jhi6P0aQ6fVCtAA7yknp5YaK71eCrSkyxeOuhzh
	 nHar2oHDR23BJoKhAlvlSA5gZZtgHrXkms+tUcE5YdG1GdCFTWJKYALIvU36CSP71h
	 pYDUX6cuFBJO1mDNW6FC+721DsoDyDkAcuOh6CyeJvKPJbKH+uFQrXZ1NRdmNuJiz2
	 l1wGthNXDp00Q==
Date: Thu, 19 Nov 2026 03:53:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Joseph Telaak <joseph@telaak.dev>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Peter Rosin
 <peda@lysator.liu.se>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@analog.com, devicetree@vger.kernel.org
Subject: Re: [PATCH 5/5] iio: potentiometer: mcp4018: Add Analog Devices
 AD5246
Message-ID: <20261119035341.6b9486ac@jic23-hlaptop>
In-Reply-To: <20261116-iio-ad5246-v1-5-ef6b7c06d4b0@telaak.dev>
References: <20261116-iio-ad5246-v1-0-ef6b7c06d4b0@telaak.dev>
	<20261116-iio-ad5246-v1-5-ef6b7c06d4b0@telaak.dev>
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

On Mon, 16 Nov 2026 17:59:54 -0500
Joseph Telaak <joseph@telaak.dev> wrote:

> The AD5246 is a 128-position digital rheostat with the same I2C
> interface as the MCP4017/18/19: a single data byte writes the 7-bit
> wiper and a single-byte read returns it, with no command byte. Add its
> four resistance options.
> 
> Its resistance is D/128 of the end-to-end value, where the MCP401x's is
> D/127, so the scale divisor moves into the per-part config.

So which value can't we hit? 128 values gives 127 steps.
Sometimes with high bit rate things we ignore over that because it
makes no difference in practice given noise levels etc.
With only 7 bits it may be noticeable.

Ah, I checked the data sheet. Nominal Resistance +- 30% :)

Ah well, I don't really care if we resolve the rather theoretical
argument. So fine to follow the datasheet.



> 
> The misc ad525x_dpot driver also knows the AD5246, by I2C id only and
> through its own sysfs files. It can't provide an IIO channel, which a
> consumer such as dpot-dac needs. The AD5272 is likewise in both drivers.
> 
> Tested on an AD5246 at 0x2e that sets a fan's speed, described as
> adi,ad5246-010 with a vdd-supply. It probes, out_resistance0_raw_available
> reads [0 1 127] and out_resistance_scale reads 78.125000000. Raw writes
> of 0, 64, 100 and 127 read back the same value, and 128 is rejected.
> Writes through iio_write_channel_raw() from an in-kernel consumer of the
> channel read back as well (127, 38, 0 and 76).
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/AD5246.pdf
> Signed-off-by: Joseph Telaak <joseph@telaak.dev>
Otherwise, I didn't have anything to add to existing reviews

Thanks,

Jonathan

