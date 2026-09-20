Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628F035C681;
	Sun, 20 Sep 2026 23:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789947224; cv=none; b=raFMLQ5OGj+avEydvAHxCprlKcN+76sKEGWRBg4r3E8hjYJm6Ul8oDVXJD25pB6qIvzhlt9U4KjHEq+TFYeW6lKm7OZ1da1RGuHF18BFFITcLOoYIF1dA4A7ukXphwdFjl++TR9YV1H+X6pUZKGneXoT8b/0yxA9FAt9nPBVCDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789947224; c=relaxed/simple;
	bh=8VICIN/F2wToJZ7ooTFabEiTlwM2hBTrxIsnSZK/48c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pJ8Dn82Ezzy0zu/S4GQFLnZJzm9m7D37x3o2EPwZZHcZM8M1xqG10wzZEQyGEU3cEftpKmcFfwXk7X7CrVqUCTBQNZrvOhM2MmgpKruzuUVsEqcSXhySw5HryiZaAtcXBmzaa5607S4a7VxCHYfFzPBJJEdPIRR7+gAI7py3cnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G496T7vc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G496T7vc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631221F000FF;
	Sun, 20 Sep 2026 23:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789947223;
	bh=dM/1gF4fecTeXEYmFZotNmYW9jLovVRLmgpkqhugR/Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G496T7vcs5sY9Zsy1p6Ra3ysg0J2IFr0YBJTDiIHCOig+S2FygjqjenJS6iagvur9
	 /nNL2TiM6RaBNjP433eiO5Y/B8Hx+PLCmxvGtUsjxdgvG7rEhUjRj3IjNULl28FG9I
	 m8hOh2buKFwA8rwn7X+h84EWDOVZPc2Ebq8mNMIwBx0887imaIVYOD8NTbOex8PjXQ
	 p1OEM2fUrZmxNbnWJbXgiPHRGCcpEFZBDkhJSmuGiNG/tkggiqT+Dl9O27A7uZMLJJ
	 XyHcOWx8hPtAPk5k4HHUKom/fQOrkQDDWjQZycFe4wRGQZLJoCFB5lMiDYwdy/XsUh
	 a2a+hyTcuvrkA==
Date: Mon, 21 Sep 2026 00:33:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Henrik Grimler <henrik.grimler@axis.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "Jean-Baptiste Maneyrol" <jean-baptiste.maneyrol@tdk.com>, Joshua Crofts
 <joshua.crofts1@gmail.com>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, <kernel@axis.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/5] iio: imu: inv_icm42607: Add support for
 ICM-42370-P
Message-ID: <20260921003336.370856a2@jic23-hlaptop>
In-Reply-To: <20260917-b4-inv_icm42370p-v4-3-fd9373f123c9@axis.com>
References: <20260917-b4-inv_icm42370p-v4-0-fd9373f123c9@axis.com>
	<20260917-b4-inv_icm42370p-v4-3-fd9373f123c9@axis.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 15:38:18 +0200
Kanak Shilledar <kanak.shilledar@axis.com> wrote:

> Add support for the Invensense ICM-42370-P MEMS MotionTracking 3-axis
> accelerometer with built-in temperature sensor. This device is almost
> identical to the existing Invensense ICM-42607-P IMU, but lacks
> gyroscope. The device supports I2C, SPI and I3C, implement only I2C
> support. Provide basic support for raw sensor reads via sysfs. There is
> also a built-in temperature sensor but it can not be turned off similar
> to the ICM-42607. Return with `dev_err_probe()` when WHO_AM_I read
> fails.

In ideal world, the has_gyro bit would be split off into a no-op precursor
patch where it is set for all existing supported devices.  This
patch would then just bring the new device support.  Not something
I'd block a series on but I think you are doing a v5 anyway so a
definite nice to have change for that.

Otherwise looks good to me.

Jonathan
> 
> Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
> Datasheet: https://www.lcsc.com/product-detail/C5129967.html
So this is the 42607.  Not sure we need that Datasheet tag here
as you are just referring to it as 'similar'.

> Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>


