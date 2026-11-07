Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794023339;
	b=Dz6kGczNfO4Zf0RLaRqyiacjgvsTaoHXF/yByPhN9Q17M6viVR/O+h2Bu58P0Lx/d7Bs
	 FJYtIbf6MNExp5AKqRli5in1TcejPJqnFV2CMS50vAqQ2aX6ZA8F0uPSaF4yNCZLsUkAh
	 4OfZiIk5qyY+gylGu55eEIg9gwxPnmcrp3KFBvFbsexMx+XKaNdFDlFVfIPZ3I9Dqjnbm
	 A/b26BD7hvpKzBvHVugPGySm2+f6Hm38TTmv8Gz8HW64s2GIM25HwbeF+kG78k6p3zYYS
	 jMT/66Yd0WxYIpcHp82nnE+moo9riwYWQtbyb2HuqdLFHLNnn8hR9Y9aKpCfQ4icC1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794023339;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4Xhvuub9f3TgDS6whwlg1xIyGY5W/eSnVYnLXGJ5TiY=;
	b=ty3JOoo8YELiRHVK8905ASXuzxiskCeNjqYVKq/DIX7TwUoSlEOhDovj39O1WL3p6dC3
	 FktAxuLXEf8rOAuyJrjSi5okC2VJPzKExNj0LfTZYVFcBY3R7BdYAAgjrqTzfBMCOLFma
	 TKU9ZoW1WtVtlNJ5CKhXq9muV0Mudw/X44mbbEEqcPkA3IlyV1MMttrxQyU+rELFXu9L3
	 lX1B0cPPT5OZfdxX6Fl3z+1xZIhWd3XhJENYOJ4yKlgveWUZNv+VSxPgZ4F9OitdJpCvE
	 QBgPGgeFOe4BKxPGbAWW6o7TKKVST8M+lAGFVs8810Q1Y9DR9G2uDvKWxmPsYlJraIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jUNElKmf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3CF606A326;
	Sat,  7 Nov 2026 03:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jUNElKmf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26491F0089F;
	Sat,  7 Nov 2026 03:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794023338;
	bh=4Xhvuub9f3TgDS6whwlg1xIyGY5W/eSnVYnLXGJ5TiY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jUNElKmfFdwH+G46vyrBSNo4L/kTNeWi3tJtYn3jyCL3+cj5Ks0WgN9sGZAUKtahT
	 V3COjuavt9m93BioGyRmTi6j6ydWY9a/T7cBK7VfMg5oWDx7hD0D3dTmlbJXuK9OhU
	 QZBkAU0ix9qR3x0McnjeSqgYcHR9TtsLHs9SuFqeBAseOSp78G1rLGJVuN8m5yW+Kw
	 aoai2B/mzaNKrmQQF/4sdx0xlYf50VfMeieBS+PQin6rhNyZYM474eMFfMejN8dzue
	 bTCw1V7bpXGgNnZ78Pf0fayVbIKBByOZkZBbIOyIVzwW0JWedYCcwvejTS2JcWYZFZ
	 MlPLmRUVxMuNg==
Date: Sat, 7 Nov 2026 03:48:46 +0000
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
Subject: Re: [PATCH v8 6/7] iio: imu: inv_icm42607: Implement MREGx register
 access
Message-ID: <20261107034846.429482a2@jic23-hlaptop>
In-Reply-To: <20261105-b4-inv_icm42370p-v8-6-b44eb96020b6@axis.com>
References: <20261105-b4-inv_icm42370p-v8-0-b44eb96020b6@axis.com>
	<20261105-b4-inv_icm42370p-v8-6-b44eb96020b6@axis.com>
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

On Thu, 5 Nov 2026 16:48:54 +0100
Kanak Shilledar <kanak.shilledar@axis.com> wrote:

> The device supports indirect register access to different banks. A
> specific routine needs to be followed when accessing the registers in
> another bank as documented in the datasheet (section 13). This is
> required for accessing registers configured via the user and
> implementing buffer support. The implementation is inspired from the
> icm45600 driver.
> 
> The banks are defined based on their initial bank access code which are
> written to the BLK_SEL_* regs. However, there is a variation for MREG1
> as User Bank 0 and MREG1 both share the same 0x00, so User Bank 1 has
> 0x00 and MREG1 has 0x01. When MREG1 register is accessed, then BLK_SEL_*
> is written with 0x00 instead of 0x01. All the register access goes
> through the 16 bit virtual regmap layered on top of the 8bit bus regmap.
> Bank id in the upper byte and the register address in the lower byte.
> Bank 0 accesses are forwarded to the bus regmap with the bank field
> stripped, while MREG accesses are forwarded to bank switching sequence.
> 
> Due to the specific bank switching routine, it is not possible to use
> regmap-ranges. Only User Bank 0 supports bulk read/writes whereas other
> banks can only be accessed serially. Each time some data in the other
> bank needs to be accessed, it should go through the complete bank
> switching sequence.
Does turning off bulk accesses for user bank 0 have much impact on performance
of existing features? 

Otherwise looks fine to me,

Jonathan

> 
> After initiating the MREGx bank access, the BLK_SEL_* should be reset to
> 0 even in case of failure. Ensure the internal clock is running before
> initiating bank access. Add extra helper functions to separate good and
> bad paths.
> 
> Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
> Datasheet: https://www.lcsc.com/product-detail/C5129967.html
> Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>



