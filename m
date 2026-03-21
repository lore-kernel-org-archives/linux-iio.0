Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC8819005E;
	Sat, 21 Mar 2026 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774107496; cv=none; b=sao4MDX5hF/hikUSnV0anX+Al2YPlj7eDGoo2NBnYbjJ/p5tg2qXaDw+MQr7rrP2KzqILRI3/65Dtrl5l7M4HhsJk99xqERomojv5+ruOQdm0HDM1AxfM0RL8dLeR3NG73einw89M0Ol/rXq7ZQO4GvD5fifZXT3fHn6UnnEZu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774107496; c=relaxed/simple;
	bh=htmyQNJXrIsXj9ow67w+TR5cXjp4psuVQ12Q5uCufCc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rKspcx0AuIm8gKKGgqIrodnSXj80lvFkGIZc/K40KJ/qFFhw/9c2YaaMtZo6ry4690SCRl/rxC+8yRPBG4zI7kswUVqSIU9Ga5k8CBIccG+xmqSaJWXsdWkqrQOxbgNUP5tSIKAbm8a0+A20cE+iBEYP5fUsZwcXNXoFMImHsX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwZQvMcA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwZQvMcA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8FDC19421;
	Sat, 21 Mar 2026 15:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774107496;
	bh=htmyQNJXrIsXj9ow67w+TR5cXjp4psuVQ12Q5uCufCc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IwZQvMcACgq+cX1szXhZ/jaZPiYWBjbEgLlCXZbiflwOzBpZT2KzldKgFKI23kqju
	 M0oG6NvSxX3vayV94LvQ/Rj1bpseOG83fAG7gNn72XEl822z2n2QR7fqGPVjDzQXae
	 nEJZvKi7/YtVGB82IeJuzFaV//HD/yOBSQiC6RPo9czDZt7mshWh0dzeRxoF3sGHZR
	 wDGGUmjmHPebTVGfF2tDizUM+I0o3owU7WdiuQiXdkgjxcz9kFeKaOIGtRiVRwzXSs
	 TPrenq5Tx0uaTI50io4287VSZYD9TCzueGYCNBqaqxtssX5m2UoQYZueZ1vJcXmCL4
	 KcYFexSxhxK8A==
Date: Sat, 21 Mar 2026 15:38:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David =?UTF-8?B?TWFyaW5vdmnEhw==?= <david.marinovic@pupin.rs>
Cc: andriy.shevchenko@intel.com, dlechner@baylibre.com, nuno.sa@analog.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 michael.hennerich@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: dac: ltc2632: add support for LTC2654 DAC
 family
Message-ID: <20260321153806.1ff27073@jic23-huawei>
In-Reply-To: <20260320150957.105571-4-david.marinovic@pupin.rs>
References: <20260318135736.91564-1-david.marinovic@pupin.rs>
	<20260320150957.105571-1-david.marinovic@pupin.rs>
	<20260320150957.105571-4-david.marinovic@pupin.rs>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Mar 2026 16:09:48 +0100
David Marinovi=C4=87 <david.marinovic@pupin.rs> wrote:

> From: David Marinovic <david.marinovic@pupin.rs>
>=20
> Add support for the Linear Technology LTC2654 quad DAC family.
>=20
> The LTC2654 is a 4-channel, 16-/12-bit DAC with SPI interface,
> sharing the same 24-bit SPI protocol as the existing LTC2632/
> LTC2634/LTC2636 devices supported by this driver.
>=20
> The 12-bit variants of LTC2654 reuse existing LTC2634 chip_info
> structs as they are register-compatible.
>=20
> Add support for the following variants:
> - LTC2654L-16: 16-bit, 2.5V internal reference
> - LTC2654L-12: 12-bit, 2.5V internal reference
> - LTC2654H-16: 16-bit, 4.096V internal reference
> - LTC2654H-12: 12-bit, 4.096V internal reference
>=20
> Signed-off-by: David Marinovic <david.marinovic@pupin.rs>


>  MODULE_DEVICE_TABLE(of, ltc2632_of_match);
> @@ -404,5 +424,5 @@ static struct spi_driver ltc2632_driver =3D {
>  module_spi_driver(ltc2632_driver);
> =20
>  MODULE_AUTHOR("Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com=
>");
> -MODULE_DESCRIPTION("LTC2632 DAC SPI driver");
> +MODULE_DESCRIPTION("LTC2632/LTC2654 DAC SPI driver");
I'm going to tweak this to=20
		  "LTC2632 and similar DAC SPI driver" because there are already
other parts not listed here.  E.g. LTC2634 parts

>  MODULE_LICENSE("GPL v2");

