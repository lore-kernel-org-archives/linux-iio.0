Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CDF31A07B;
	Fri, 24 Jul 2026 23:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784935958; cv=none; b=FBwMiWrS15A904Vh0t47ssedCszxZksKTAY8eXMhda3/hvY3JSE5t2LeJLAWPVxDgnaJJp6OrVNxOU+viUEemjdicje57UHU8aIm6/q4pmjr1WmmVbRkFIUQuUGDbXh5DR9PBIorarqA6TkejT9XswZNdFIhJXnKpeiwS25we+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784935958; c=relaxed/simple;
	bh=7axYFn6mxDj2xn6gpdLKVjgWj9xV5fL0PIx2W9U4lwE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eh4Ps9pAa5FsHs14UylTNjrS8xfZo3fI2X9PyLwyGRzVtLE7cm45rtfNzvI0/ipRX0yK60EC941hQtmFPMbOkeDKZbxgagWbeYXCNbgKpcStYo9vhZZq6WxAdJp577fNZgv87fPMazgdBC6DYwPHWbsE029oFXMzCm+FcDH8u/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmAx17Ro; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmAx17Ro"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1681F000E9;
	Fri, 24 Jul 2026 23:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784935957;
	bh=TWAP8T6WOJsUz6MzJkSqcJPZlPU3cyW4yrYGm9LPy3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dmAx17RoTXtYEx+iMwN8peRSbJ8iBasL7i5FBb6JKqdH9XxJYTZuKvP7NaVOGzGQN
	 Lsaan4xsucSjLF8Kjcj6GjHboPaMvexIxDCnIjJ4dkGYMlr6Z07wfPUhZRgwqd9Lz9
	 EWYhK8GsKn0QA8DkL9TPqe0m5vI3y270gZmmwKtatL+W4XC12zsfuGHHrAat3sPn52
	 hj3U0tU0YPrSkRg7/kL2lowHdUMfVmxG6x0MgV0xQeqhHpkJHbKqNFfH5vXMVkTwsk
	 mkxTbIf6ZeBAITrr1FtNg9RfNDnvRslIZCKnN5+YowXV9+sKDExR3A/wmPPcC5YtMC
	 1GGUCGHU7F8tg==
Date: Sat, 25 Jul 2026 00:32:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>, Marius Cristea
 <marius.cristea@microchip.com>, Marcus Folkesson
 <marcus.folkesson@gmail.com>, Kent Gustavsson <kent@minoris.se>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, Janani Sunil
 <jan.sun97@gmail.com>, <linux-spi@vger.kernel.org>, Kent Gustavsson
 <nedo80@gmail.com>
Subject: Re: [PATCH v7 1/7] spi: dt-bindings: Add spi-device-addr peripheral
 property
Message-ID: <20260725003230.0e22d6b0@jic23-huawei>
In-Reply-To: <20260722-ad5529r-driver-v7-1-7781cd74ad75@analog.com>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
	<20260722-ad5529r-driver-v7-1-7781cd74ad75@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jul 2026 09:54:13 +0200
Janani Sunil <janani.sunil@analog.com> wrote:

> Some SPI devices support sharing a single chip select across multiple
> physical chips by encoding a device address in the SPI frame itself.
> Add the generic spi-device-addr property for describing these hardware
> addresses. The property is placed on the SPI peripheral node and may
> contain multiple addresses.
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>

Looks good to me.

Given this is going in the main SPI binding I'm looking or an ack or
similar from Mark Brown before picking it up (in addition to the
DT ack from Conor that we already have).


> ---
>  Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> index 880a9f624566..b59d047cf117 100644
> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> @@ -142,6 +142,13 @@ properties:
>      minItems: 2
>      maxItems: 4
>  
> +  spi-device-addr:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      Device addresses used when multiple peripherals share a single chip
> +      select. The array allows one logical peripheral to comprise multiple
> +      physical devices, with one address per device.
> +
>    st,spi-midi-ns:
>      deprecated: true
>      description: |
> 

