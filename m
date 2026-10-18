Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02F43CB546;
	Sun, 18 Oct 2026 18:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792348657; cv=none; b=FRDtCCgOyQ6jnNxplrHdB/2fsl4fKR7lU+TCKdeEpsRx58eq0pNrcsqELS1+LT1Rbhg7V5dZ3eY9epmqek723wJ6rQEadwa9pM2NsiYEtRTQMVGAsp1rMH9jlN0g2no/xNwt94gA2aPPznO7HdT/Jbk7QOZ3GKxPhGw//L7VvCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792348657; c=relaxed/simple;
	bh=koL/Zye0yOEY2f2qrpZOxPWNVc6qfWgKEYA94SPC24M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XWPJG6StOPEDJSx/oOWnmVWlooxm53eC4ekZX8QITCUnaukLtCQebfQ4xK1zFBLqFwkjNDbG8Pb0V9rl/EnL/G1Noz0yYu8c3DG4yqi8LDuywtd8qACZjYmBDBGbxVzVt+oP0Lavjd5eCiHkSZ1NbxqNU6aa7aZ0bxIWoxCmY6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUQxdRXd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUQxdRXd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27EAF1F000C4;
	Sun, 18 Oct 2026 18:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792348656;
	bh=CWjDBO71xSodfTJwEHUuQd3js5p3IqLrES9sAP1AoFw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NUQxdRXdN2ckz4P0AR0yl7ieQ+kOEasNxj/VaAjvozhXKIp8NQM0ZNDwasn/7V3rU
	 VZH0zp3pt2A0BPa7XojyChkZIOiTncjyDZsgx4ZscrRRkttukZyvedE0v7GtjEtS/Z
	 xuw+OFRrJ/zGmcVfT/heD2hkskf26fOZAeyEbxat4tBYE84hbWOJljf0iSdwA41E+W
	 qTey9y2wtMW75L0cqF1WXz9MGuGcXWr+H9IOKmE2MlBFxcxdZOxE3j0PfbCUvukd4x
	 JULIOZAB/emCSJZjx2BRdE6cCZyJ00n/cr11ooEX4N36iZ7L1OSC6QK6ClnsVqvhm6
	 AfUyd7cmsoXmQ==
Date: Sun, 18 Oct 2026 19:37:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Muhammad Abu Bakar <m.abubakar365@yahoo.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] iio: pressure: add Sensirion SDP31 driver
Message-ID: <20261018193730.3beb28cf@jic23-hlaptop>
In-Reply-To: <20261007205104.4694-1-m.abubakar365@yahoo.com>
References: <20261007205104.4694-1-m.abubakar365.ref@yahoo.com>
	<20261007205104.4694-1-m.abubakar365@yahoo.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Oct 2026 01:51:02 +0500
Muhammad Abu Bakar <m.abubakar365@yahoo.com> wrote:

> This series adds support for the Sensirion SDP3x family of differential
> pressure sensors (SDP31, SDP32 and SDP33), I2C devices that also report
> temperature.
> 
> The SDP3x uses a completely different I2C command protocol from the
> already supported SDP500, so extending the sdp500 driver does not make
> sense.
> 
> Patch 1 adds the device tree binding.
> Patch 2 adds the IIO driver, which exposes differential pressure and
> temperature channels and validates each measurement using the sensor's
> CRC-8 checksum. The SDP32 and SDP33 differ from the SDP31 only in range
> and use it as a fallback compatible; the scale factor is read from the
> sensor at runtime. Tested on an SDP31 wired to the I2C bus of a
> Raspberry Pi 4.
Lovely little driver.  Thanks!

Applied to the testing branch of iio.git. I'll rebase that on rc1 once
that is available then push out for linux-next to pick up.

Jonathan
