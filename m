Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30F94E77EA;
	Mon, 28 Sep 2026 17:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618337; cv=none; b=MJpewcdGwlEEp3UqGwlJZTso+R8AafznW9YCg9q9h/g5UC9dgAffR0vgHXql6tU9ZaGGQtcHyuyaey8itKc4Bjo0DebMrtUa4cOlRfp2yJf1C19Nw2ZIEw2p0i7O8YQlsjZsaLvDPAa2ODr3K234U1L/bTSVi7EHAw53XhjKI1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618337; c=relaxed/simple;
	bh=K28y/GqNscp24nbZuGJ2llZjSaaMYZExamvNFTnw8Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUBuy4wa++81JHLUGKXFsaz/Ne3NuFpCaP2iNLZFx+RDDecMnhSmkZnqA50XeaLXwpcvwKvHkcXnc6NCLSYcwZTzaSH2ZseAotw65T8yLl7trV7aym+t3okb9OEPN30NpcH0B+UHLhJZOlyz/8laYy5YCwO1UHYvOr/1oqs6jYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sbhi1Ong; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sbhi1Ong"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7B11F000FF;
	Mon, 28 Sep 2026 17:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790618336;
	bh=5pKfJ6aLiwvyAK3VzNlALwEbHUTSCcGm1R4yvd2GzJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Sbhi1OngDFq1aPAaRuHwtAjrdqZnUeRugz+2rodYAP4lhkijBYklRmndzz8s1sIcK
	 sGyVbdVyfTGtj09DFZqn/uFc4qO3nVT/YNxSi2Gcr39YjLcOf5LbW1XSEDDm5KbGav
	 5lSz6/8Cxbn3STgIV6h5LSU6dFcuCQXbVykAWB8erxVhlQMT6bY26RNObmno72IOqm
	 L5frwfqlCXsDCqHlYdAgqDcJijv/YR6C1VKBEu8XUAZ7aHXeYYHNmFgZycITEoacko
	 gXtSJwYUFVFa0Njfbxs57gBo9FFRJJVdtga4K6zgo53Ekkl+J4M1GPlTYLJwZa9Gjr
	 1QpFtkqU7j4wg==
Date: Mon, 28 Sep 2026 12:58:53 -0500
From: Rob Herring <robh@kernel.org>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Henrik Grimler <henrik.grimler@axis.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>, kernel@axis.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] dt-bindings: Add InvenSense ICM-42370-p
 accelerometer
Message-ID: <20260928175853.GA97613-robh@kernel.org>
References: <20260917-b4-inv_icm42370p-v4-0-fd9373f123c9@axis.com>
 <20260917-b4-inv_icm42370p-v4-1-fd9373f123c9@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-b4-inv_icm42370p-v4-1-fd9373f123c9@axis.com>

On Thu, Sep 17, 2026 at 03:38:16PM +0200, Kanak Shilledar wrote:
> ICM42370P is a 3-axis accelerometer. The device can support I2C, SPI
> and I3C. Add the supporting devicetree documentation for the device.
> The device supports VDD and VDDIO operating range of 1.71V to 3.6V.
> 
> Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
> ---
>  .../bindings/iio/accel/invensense,icm42370p.yaml   | 87 ++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/invensense,icm42370p.yaml b/Documentation/devicetree/bindings/iio/accel/invensense,icm42370p.yaml
> new file mode 100644
> index 0000000000000..d519dc7e63dd0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/invensense,icm42370p.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/accel/invensense,icm42370p.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: InvenSense ICM-42370-P Accelerometer
> +
> +maintainers:
> +  - Kanak Shilledar <kanak.shilledar@axis.com>
> +  - Henrik Grimler <henrik.grimler@axis.com>
> +
> +description: |
> +  3-axis accelerometer MotionTracking device.
> +
> +  It supports I3C, I2C and SPI serial communication, has a 2.25kB FIFO
> +  and 2 programmable interrupts with low-power wake-on-motion support.
> +
> +  It also has programmable filters and an embedded temperature sensor.
> +
> +  https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
> +
> +properties:
> +  compatible:
> +    const: invensense,icm42370p
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      enum:
> +        - INT1
> +        - INT2
> +
> +  drive-open-drain:
> +    type: boolean
> +    description:
> +      Whether irq is in open-drain mode. False means push-pull mode.
> +
> +  mount-matrix: true
> +
> +  vdd-supply:
> +    description: Regulator operating range between 1.71V to 3.6V.
> +
> +  vddio-supply:
> +    description: Regulator operating range between 1.71V to 3.6V.
> +
> +  spi-cpha: true
> +  spi-cpol: true

Generally, you either need these properties or you don't. If you do, 
then they should be required.

Rob
