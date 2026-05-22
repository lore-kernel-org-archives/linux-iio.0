Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F1E2222CC;
	Fri, 22 May 2026 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779469340; cv=none; b=O5pSA5mMBZAyV9odCKhQWxr8o6SZiUnSckYNuiARQLQnX/g6In9pkBq8gA5gBqaBmtiay35v5aglsx3TWFPClY1L1dfdYFpOA9mV9mnIOdZWzp5//XrHhd8/NBrGmTML7YJY540I2Qb9x1Jaj7bDG5oYZTeVE9ujJo5VPY2cGjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779469340; c=relaxed/simple;
	bh=ZT438QpfdkV342To8rC4e986CAHRHP03DGVC4RwMVEI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L/VaknVIP+DAp9PZbjXIA1viyLS2ftbgbjzKdL6Qub4kalTm3XpkRUfRuINr/WUukfuWjaIJMXdIbFV2og6z6Assd5WyKURiiv5CR08hQZN87XcX6V1vtaBOhatNu9R80YyUtFESk9wSVonyIhB2/4sX3hlN0GtGaM7wwY/w7as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOXAnMSw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOXAnMSw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1891F000E9;
	Fri, 22 May 2026 17:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779469338;
	bh=dFLeOAy+lG1jO24092Be2VYCeGNtREL/YhJ4BDlk35k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cOXAnMSwXLS3Cx3pmWGfedk+qEDsnZLs9wI9mY6XdGLGV7mnkq2qaoUdVvE98nzg6
	 UUAJWPxIKx2vMulFJ7HTK2hVGOIyk6oCM9kiJPWQQoc/B9gciTAn8XgpIlnB58Czsk
	 6x+TO1BagE67DgE8xfeSPH89ni4PCj0tknYszJ5rx+i0VAQiR3CdZhzjEO+DI8XGLZ
	 jKjaaTWN1FEI97QdfeYdM6TyujUjW8Dcp8Kafc7RleP1ETcp4FD/50Y2VuenfvhcxL
	 7vpkfIZnEK2HJ+FQcLb+DtWSJ2WrSeKunLE6Xg2enYXwi0eFut2JVce04Z80HPkS1q
	 1qgixNQS2FnEQ==
Date: Fri, 22 May 2026 18:02:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, Janani Sunil
 <jan.sun97@gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: dac: Add AD5529R
Message-ID: <20260522180207.63b725fb@jic23-huawei>
In-Reply-To: <20260519-ad5529r-driver-v3-1-267c0731aa68@analog.com>
References: <20260519-ad5529r-driver-v3-0-267c0731aa68@analog.com>
	<20260519-ad5529r-driver-v3-1-267c0731aa68@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 19 May 2026 17:42:58 +0200
Janani Sunil <janani.sunil@analog.com> wrote:

> Devicetree bindings for AD5529R 16 channel 12/16 bit high voltage,
> buffered voltage output digital-to-analog converter (DAC) with an
> integrated precision reference.

Note that I'm seeing this as Changes Requested in the DT-binding patchwork
but didn't see any replies.

Seems I didn't get the sashiko reply - nor did the IIO patchwork.
Hopefully Janani did!
https://patchwork.kernel.org/project/devicetree/patch/20260519-ad5529r-driv=
er-v3-1-267c0731aa68@analog.com/

>=20
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,ad5529r.yaml   | 217 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   7 +
>  2 files changed, 224 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml b=
/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml
> new file mode 100644
> index 000000000000..eb66f6ca063d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml
> @@ -0,0 +1,217 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ad5529r.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD5529R 16-Channel 12/16-bit High Voltage DAC
> +
> +maintainers:
> +  - Janani Sunil <janani.sunil@analog.com>
> +
> +description: |
> +  The AD5529R is a 16-channel, 12-bit or 16-bit, high voltage, buffered =
voltage output

Long line. Check the wrap.

> +  digital-to-analog converter (DAC) with an integrated precision referen=
ce.
> +  The device operates from unipolar and bipolar supplies. It is guarante=
ed
> +  monotonic and has built-in rail-to-rail output buffers that can source=
 or
> +  sink up to 25mA.
> +
> +  Specifications:
> +  * 16 independent 12-bit or 16-bit DAC channels
> +  * Independently programmable output ranges: 0V to 5V, 0V to 10V, 0V to=
 20V,
> +    0V to 40V, =C2=B15V, =C2=B110V, =C2=B115V, and =C2=B120V
> +  * The device supports SPI communication with Mode 0 and Mode 3.
> +  * 4.096V precision reference, 12ppm/=C2=B0C maximum
> +  * Built-in function generation: Toggle, Sinusoidal Dither, and Ramp wa=
veforms
> +  * Multiplexer for output voltage, load current sense and die temperatu=
re
> +
> +  Datasheet: https://www.analog.com/media/en/technical-documentation/dat=
a-sheets/ad5529r.pdf
> +

> +patternProperties:
> +  "^channel@([0-9]|1[0-5])$":

Sashiko commented that this should be hex.  Why the forcing to decimal?

