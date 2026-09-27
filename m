Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610C441BA7A;
	Sun, 27 Sep 2026 17:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790529899; cv=none; b=pbNkdlhEzC3qNOvzrQyuqxzYxp37LvVwpDwfLTACi6W/FKehnrjnbVLkCBgCTxgPXMqxKUUtbPmuI4Kc4Qcq9RMrzpf3MNAF1KQCOZa2DyupBBHD6GWwceaVmv9UJ7s2P/e7JMUBKKfIW+kIIgkvV7pO+Qw+Ls8uDwnTQgxtD3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790529899; c=relaxed/simple;
	bh=OuN2ndxuCUThwOuzsE/xNgfIKnPGSkYUHA5pIz+BEiU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tAt+uTE1bQ7ONHNeu+ggRNnQQy4HxQXRpNVR+IzQoeLWWCKMvUx+b466fZpQKpb0Gq2e54qJoiBHVzHGNMdfeP+0notvnii+oIjEcaj7q/55Gk1ltZuezk83OPFTBIMsT1EatdUBf6DzGtCsqVIjaazPb0b8xBb/kzP38U4mNs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E62jj1dL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E62jj1dL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9313B1F000FF;
	Sun, 27 Sep 2026 17:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790529897;
	bh=oMs/Hq0Db/D1FWahvFRO/BSal8VTgymAtB6OnvGiC7g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=E62jj1dLOaM+q0+QaDU3jofUtuj3XKcdyn9KQ0lbxGXbN1ZIARbg1RGhIMFCJLuYM
	 NVXFCbRp/vD/I31N65PHTdG0AIMhYFFMNCjs/IGlYiA9rOPixN+kK2+0+wU0JBQhv3
	 y28n5j8sYxLmSnllLvOnMlxJoCaOFGrtwS8yYsi+EV0qRYJEhWuxxt8Mahb3xURe39
	 TCrfN6+3Oh+mLb/JzQF534IeF1boNNK8b0Tg1BiQwKGWL9Ehs7j+6Np24xK15GbuyO
	 qSsnsZwWna6O1tgHamaLfQu3SxsgyGiSfVE+80jYskOIPS0bGxgn2UyBeuRb0J6jZn
	 fv9ugVvi48qwQ==
Date: Sun, 27 Sep 2026 18:24:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Muhammad Abu Bakar <m.abubakar365@yahoo.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: pressure: add Sensirion SDP31
Message-ID: <20260927182452.5755fba7@jic23-hlaptop>
In-Reply-To: <20260926154118.5471-2-m.abubakar365@yahoo.com>
References: <20260926154118.5471-1-m.abubakar365@yahoo.com>
	<20260926154118.5471-2-m.abubakar365@yahoo.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Sep 2026 20:41:17 +0500
Muhammad Abu Bakar <m.abubakar365@yahoo.com> wrote:

> Add device tree bindings for the Sensirion SDP31 differential pressure
> sensor, an I2C device that also reports temperature.
> 
> Signed-off-by: Muhammad Abu Bakar <m.abubakar365@yahoo.com>
I think you have been missing some replies for some reason.

See https://lore.kernel.org/all/20260920014032.2cc3c851@jic23-hlaptop/
Also the reply Krzysztof sent to point out you hadn't addressed all
the feedback on v1.

If you disagree with any suggestions then reply to that email.

Reviewers tend to stop reviewing very quickly if they see that stuff
they raised in previous versions hasn't been addressed yet.

Jonathan


> ---
>  .../iio/pressure/sensirion,sdp31.yaml         | 41 +++++++++++++++++++
>  MAINTAINERS                                   |  5 +++
>  2 files changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml b/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml
> new file mode 100644
> index 000000000..a98e7c97e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/pressure/sensirion,sdp31.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sensirion SDP31 differential pressure sensor
> +
> +maintainers:
> +  - Muhammad Abu Bakar <m.abubakar365@yahoo.com>
> +
> +description: |
> +  Differential pressure sensor from Sensirion with an I2C interface.
> +
> +properties:
> +  compatible:
> +    const: sensirion,sdp31
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      pressure@21 {
> +        compatible = "sensirion,sdp31";
> +        reg = <0x21>;
> +        vdd-supply = <&vdd_3v3>;
> +      };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 214aeee76..e285147be 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24855,6 +24855,11 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/chemical/sensirion,scd4x.yaml
>  F:	drivers/iio/chemical/scd4x.c
>  
> +SENSIRION SDP31 DIFFERENTIAL PRESSURE SENSOR DRIVER
> +M:	Muhammad Abu Bakar <m.abubakar365@yahoo.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml
> +
>  SENSIRION SDP500 DIFFERENTIAL PRESSURE SENSOR DRIVER
>  M:	Petar Stoykov <petar.stoykov@prodrive-technologies.com>
>  S:	Maintained

