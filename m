Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37463E49F7;
	Wed,  7 Oct 2026 20:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791406068; cv=none; b=pOftSkEE0Npi30hMGCP3vCeozEy7wPSvEdPz9m3f4yJ+gBc3DoZdhE+YjLNMpBveRpOL6xbDw0mnzqN0qK3kBPkDUUKxIcAnS52BaOf+xMIPEriPfyC2ysGdnR7L0/HABe2lwk67IacSRaxgS1h9k37lBbhxo/L1YawXhgiw3QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791406068; c=relaxed/simple;
	bh=SxrGDSyEX73l7LarG93DakxyOY4pzJamaXHDM4sBiEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IscsRbvz21uhiIWndttpsz07WATYnZemSmkj8wvyDUpNamoTT86QuOiOJvIYRpeDXt1POxZtvRDg1YaMagtnmv+HOmB2elb//85Xge6SgTwndpA7m+OUJYwvzgkQs80WZDLdIlq9FttqjMqjYKetdbPcxk7M5ARBDmyEjKGkzic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5bhswkH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5bhswkH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6917B1F000FF;
	Wed,  7 Oct 2026 20:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791406066;
	bh=u8v09+uznNxns8CiadeSWkPY6KMiMjm7ORLmbiWyCfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c5bhswkHMpLunPnbXDUTmHb0e9KMooSSYkFHsROS+gXOU/Kw01/a4seaLu1RHL9oK
	 P6ffGKl30zjhP8yNVFu+oSL/tTVSfS1m0LXMTHG9do4iIxNZaMVhqUyPeykEV941yn
	 YlL7yXtPAh24LXPw9+r21fCgTZWuHvMYo7319isDIKgS2+u7PFm8K4C6cXY6cNPK1M
	 OL+2ATGDrIxSmpZ2EJaQQog29i22kIiIWdFuel6mX0euAd7U8VI4SOtVh6c/KzvTVt
	 4iFTUjaEESE4n3+aOgPD18/Tjk4yxW4ZO9yolBhDQ9vKEx6gKhvMcTTGSCyLT04rIp
	 xTl4i8bdd1LYQ==
Date: Wed, 7 Oct 2026 15:47:45 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: linux-hwmon@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: iio: adc: add support for PAC1711
Message-ID: <179140606511.243312.18354429162452985979.robh@kernel.org>
References: <20261007-pac1711-v4-0-6ef34d7a7947@microchip.com>
 <20261007-pac1711-v4-2-6ef34d7a7947@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007-pac1711-v4-2-6ef34d7a7947@microchip.com>


On Wed, 07 Oct 2026 17:41:54 +0300, Ariana Lazar wrote:
> This is the device tree schema for Microchip PAC1711, PAC1721, PAC1811 and
> PAC1821 single-channel power monitor with accumulator. The PAC1711 and
> PAC1721 devices use 12-bit resolution for voltage and current measurements
> and 24 bits for power calculations, while PAC1811 and PAC1821 have 16-bit
> resolution and use 32 bits for power calculations. The 56-bit accumulator
> register accumulates power (energy) or current (Coulomb counter).
> 
> PAC1711 and PAC1811 measure up to 42V Full-Scale Range, respectively 9V for
> PAC1721 and PAC1821.
> 
> The accumulation-source property aims to specify what kind of hardware is
> intended to be used/available for the user. There are two main cases here:
> - the user wants to measure also the current/power consumed before the
> driver insertion (e.g. from the boot to user control) and if this is a
> runtime setting, the hardware accumulator will be reset by the default
> configuration the driver starts with.
> - the driver does not know what type of hardware it's dealing with. In
> case the part is monitoring the charge/discharge current it does not
> make sense in user-space to change the accumulator to calculate energy.
> Same if the hardware is intended to calculate energy it does not make
> sense in user-space to change to Coulomb counter. Changing the setting
> from one mode to another will reset the hardware accumulator inside the
> chip.
> 
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> ---
>  .../bindings/iio/adc/microchip,pac1711.yaml        | 169 +++++++++++++++++++++
>  MAINTAINERS                                        |   6 +
>  2 files changed, 175 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

