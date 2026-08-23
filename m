Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66DE2931C4;
	Sun, 23 Aug 2026 18:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787510729; cv=none; b=LLwMptrIE3VeYjyx3Ff8mzlInArBh0pnp2pak2uZ3ZtVe1TH0QvhI/sUZMlOHos0sMXn+a3SL1z0POU8RR/SsKOoZuBbafzh+mns/PgZBtJHLgsFCxUsi2Syjo2/7yLCe1g7VH/1iwFugcLpb/JbbovH17e5E5HRRyK6e0GngJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787510729; c=relaxed/simple;
	bh=Q+vhxlH5HQh6qFlxVjsH7Baxl+5NA1deJyfvO0VJK6U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G/WbhPj15gcikJKuQj7K/0Deu0HrmcWTfevwXik7mVt+jbS+BsprZcrMT8KrNyfGYxTJTEIIbwZUaNEbj+KjICk2UmyNlzKi2MKJ3A+Sm+Dwn/hd/VqxbwemlE1GpgeCW5359P9U/zpZso/fojMp0YMLvG1jHpVA2UtzV1RbCiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O388s4Y/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O388s4Y/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3A71F000E9;
	Sun, 23 Aug 2026 18:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787510727;
	bh=Hj/tWFL0EQL7xejnt4I8PK09Xrfp9iy/D044+M6xIOQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=O388s4Y/bAobZIp8MQfKdoQ3BLydCSO6lIqT8yWYzETcP7jBvFYJNWN+3vyKTB37+
	 w9hA5wzmZvne1a4R9TyQSZ+q+EBbW14cOgmxkQ3j/xlUjPJLRDYs3R+6S5kfIqJGEt
	 kZJNKDrv2Pri8MI6Gwlk0TwBInypDUUXAOJE6JukL2y5wynQUgidBW3q3OSCMmrSyi
	 d+jyBWpMROMKi/vU6UIj6BfYwm0UAubyJ9h4Tipu8RkUH7YHIWcEOnRTMhCjsyPDxw
	 aCpCwvMCmSvb2D4FxPLbCgWN6R9R3wFQoYa+tyFBTfJuW6u2vIov5dLS9Lhx3Xmdvd
	 M15uZl2GEPDkA==
Date: Sun, 23 Aug 2026 19:45:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>, <linux@analog.com>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: iio: update unreachable maintainer
 entries
Message-ID: <20260823194522.0f4c9b12@jic23-huawei>
In-Reply-To: <20260821180753.4633-2-antoniu.miclaus@analog.com>
References: <20260821180753.4633-1-antoniu.miclaus@analog.com>
	<20260821180753.4633-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Aug 2026 21:07:50 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Cosmin's Analog Devices address is no longer valid, leaving the ADXL367,
> AD4130, AD74115 and AD74413R bindings without a reachable maintainer.
> Take over maintainership of those bindings and add myself to the
> corresponding MAINTAINERS entries alongside Marcelo.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

Looking for an Ack from Marcello.

Jonathan

> ---
> Changes in v3:
> - No changes.
>=20
>  Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml  | 2 +-
>  Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml     | 3 ++-
>  Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml  | 3 ++-
>  Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml | 3 ++-
>  MAINTAINERS                                                   | 4 ++++
>  5 files changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml=
 b/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
> index f10d98d34cb8..29689bc38b90 100644
> --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Analog Devices ADXL367 3-Axis Digital Accelerometer
> =20
>  maintainers:
> -  - Cosmin Tanislav <cosmin.tanislav@analog.com>
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> =20
>  description: |
>    The ADXL367 is an ultralow power, 3-axis MEMS accelerometer.
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
> index cc38617bb829..a4ab6adef1c6 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
> @@ -8,7 +8,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Analog Devices AD4130 family ADCs
> =20
>  maintainers:
> -  - Cosmin Tanislav <cosmin.tanislav@analog.com>
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> =20
>  description: |
>    Bindings for the Analog Devices AD4130 family ADCs.
> diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml=
 b/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
> index 2a04906531fb..6aa86cb56032 100644
> --- a/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
> +++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
> @@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Analog Devices AD74115H device
> =20
>  maintainers:
> -  - Cosmin Tanislav <cosmin.tanislav@analog.com>
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> =20
>  description: |
>    The AD74115H is a single-channel software configurable input/output
> diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yam=
l b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
> index 590ea7936ad7..5318a00e7669 100644
> --- a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
> +++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
> @@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Analog Devices AD74412R/AD74413R device
> =20
>  maintainers:
> -  - Cosmin Tanislav <cosmin.tanislav@analog.com>
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> =20
>  description: |
>    The AD74412R and AD74413R are quad-channel software configurable input=
/output
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 04fa5322d9f7..ade07e6637bc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -641,6 +641,7 @@ F:	drivers/iio/accel/adxl355_spi.c
> =20
>  ADXL367 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
>  M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
> +M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
> @@ -1493,6 +1494,7 @@ F:	drivers/iio/adc/ad4080.c
> =20
>  ANALOG DEVICES INC AD4130 DRIVER
>  M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
> +M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
> @@ -1598,6 +1600,7 @@ F:	drivers/iio/dac/ad7293.c
> =20
>  ANALOG DEVICES INC AD74115 DRIVER
>  M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
> +M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
> @@ -1606,6 +1609,7 @@ F:	drivers/iio/addac/ad74115.c
> =20
>  ANALOG DEVICES INC AD74413R DRIVER
>  M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
> +M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers

