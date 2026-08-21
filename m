Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F87E30BF70;
	Fri, 21 Aug 2026 01:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787275559; cv=none; b=CF7xKhXVfAWwk8Bx4vqIPtgXO4DQGk1AB2MsdnVjMD/EiOshgDBQ3Jh3JkQ55e7FQk1CxGb6q6S1RnlqIOTInUz0vYd6hfYfDPhb0GYcflBOWvMi31/y47/qpwaqcyoMTsEQBS49kpoBqpTWwFvnZtxA+k2q4c9/o8gufOF6MDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787275559; c=relaxed/simple;
	bh=Wz9K9pqBrnDai0amQ/RAivfRwmhMwP6x3ULWyXgZJWY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jADd+OL87pot8ZiOLlHULpGntT/VxH0Fm7/wp6VrPu0IZjnBZMCaO5aFKwX4QRKtj2BRGZKTDFFWj4dXNG5KDr4VZYNqYoyCnNi+Orps1fge2Gteb2dfves+NXUElxllfrwkDBZSQVGoz35LdPz71wS3AGEGQNCalKJMFx12HfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoXcFVSv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoXcFVSv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076DC1F000E9;
	Fri, 21 Aug 2026 01:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787275558;
	bh=SmnmX+PqbBgqoJffPOXB8suUIBO4rYdm04b3kswIdxs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FoXcFVSvqM82kaOXaOy7ncKDIzEyueipyJu558trjDSI52I5Pwtf899UsPLA8ip6A
	 a3AYwKc4oTOJCYy0E1QBwIc2vLvoTQNv/Epp4YZ+38f4Oaotv2yqsnRbL+CRw3jiA6
	 8QF0s8psao220PFIFOG6lxL2ahfmKbhSSep2vxRGg6iGg9Gs/J03ZaFuMK80mvWOFA
	 iYO96ushqNlOPY4q3sWWVl4LI5kydq8gJiaf5DrniCfM1ZlCjJfHs3u31CIzoxLotn
	 0EKOnuskr4l0oTDVRzC8G9uhw8xLDNviWEzfZA9JHlBlJaWrEIa8gRdX0QVP1NcSoG
	 CY1qfeHz0Il8A==
Date: Fri, 21 Aug 2026 02:25:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kyle Hsieh <kylehsieh1995@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v6 0/2] iio: adc: Add support for Texas Instruments
 ADS112C04
Message-ID: <20260821022554.5382aa7b@jic23-huawei>
In-Reply-To: <20260820-ti-ads112c04-driver-v6-0-0e8f0aacce9b@gmail.com>
References: <20260820-ti-ads112c04-driver-v6-0-0e8f0aacce9b@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2026 15:51:50 +0800
Kyle Hsieh <kylehsieh1995@gmail.com> wrote:

> This patch series introduces support for the Texas Instruments ADS112C04
> Analog-to-Digital Converters.
> 
> The ADS112C04 (16-bit) is precision, low-power, delta-sigma ADCs with
> an I2C interface. They feature a flexible input multiplexer supporting
> single-ended and differential measurements, a programmable gain amplifier,
> and an internal voltage reference.
> 
> Note: While this chip shares similarities with the ADS112C14 (currently 
> being upstreamed by David Lechner), the register maps and feature sets 
> are sufficiently different to warrant a separate driver. However, the
> DT bindings and channel parsing logic have been aligned with the
> ADS112C14 conventions.
> 
> This initial submission provides a minimal feature set (single-shot 
> conversions and basic DRDY interrupt) covering current use cases.
> 
> Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>

Sashiko had some feedback on the interrupt - if you are respinning for
other reasons it might be good to add a comment in the dt-binding about
it being an edge interrupt. From a quick look at the datasheet a level
interrupt would not make much sense.

https://sashiko.dev/#/patchset/20260820-ti-ads112c04-driver-v6-0-0e8f0aacce9b%40gmail.com

Other than that, looks good to me.  You've had a lot of review from
others though so I'll leave it on list for a little while in case
any one wants to take a final look and perhaps give tags.

Thanks,

Jonathan
