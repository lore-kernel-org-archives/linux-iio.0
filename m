Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20673AEF2D;
	Tue,  9 Jun 2026 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021967; cv=none; b=erdUmw7z9fDeA/P10eo7AjAUZqDZnx3iuvwDCZ63XMhfKzesRhgkImzsuLy7VRaWOV9OspDbtyw1ceRW07toq87khvZ/1DMOnnoM7vA/GleDVISsKgPFhlAz0W5gTIsDOgjCrqCndVJ6GXRBgudVoTL/AOg38QvmmFHc/cGuPoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021967; c=relaxed/simple;
	bh=B6EI/h1LWS0Jqv2kTyDAtsKf2l7T9n0epCWtM2Pmz/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuk6L2WfKK5m1BN+HFwJfTSu90brTo9Ii74VoQ4YWjSp9Dz4NoqiFU3bFMfDvSLDVvz1uebs20Hc6rHYOhrQdszmGiZnN8Qx6lUictdpAIWUrQFHqUDheFM3aPMdV5jWc522qVdVWLbakZ2wCT8JyZQ7UsxRrkgt+OQeyvkJQJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1q2sXJP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1q2sXJP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCDE1F00893;
	Tue,  9 Jun 2026 16:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781021964;
	bh=7/SJnNWoDhHlr5d4lRtke1mim+L3BgF0cgfIn7ih1+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V1q2sXJPcn9SSS3e4eRDIMTteqZbXBSgHqCUZP5WMrndNvubEYKDKKEvxXB/dhbBE
	 QQmqyOTwy6PkbhTBpIqRrXcLrZYa/xnDu86iHdFWm1v+s6zT1P9MSt15pIq2p9L54r
	 eTs0PxR3TBLQNrNDSNemcBA4Ncd60ipXTGfZ1xRR/2Jk5o2w/APEtkSkZz4lURa7cZ
	 icHWl0VqkbWUGNRZcLcvOdzCHm4UfTqAIdcyeC532zwAReVY6t512uomw+EAChF0qd
	 V8TA1fZL8Y048uT1vA4wK1YG+iltGw9aYmJDFSiQsTMnhDgdH/vPcOSFqDdzrSKwO4
	 KaD6UO9rIQLqg==
Date: Tue, 9 Jun 2026 17:19:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC v4 1/6] dt-bindings: iio: add Open Sensor Fusion
 device
Message-ID: <20260609-glacial-colossal-38b4937ec620@spud>
References: <20260607234343.22109-1-kimjinseob88@gmail.com>
 <20260607234343.22109-2-kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F4y7872aqCtHrHPU"
Content-Disposition: inline
In-Reply-To: <20260607234343.22109-2-kimjinseob88@gmail.com>


--F4y7872aqCtHrHPU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Jonathan/IIO folks,

On Mon, Jun 08, 2026 at 08:43:38AM +0900, Jinseob Kim wrote:

> diff --git a/Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml b/Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
> new file mode 100644
> index 000000000..a4049715a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/opensensorfusion,osf.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Open Sensor Fusion Sensor Aggregation Hub
> +
> +maintainers:
> +  - Jinseob Kim <kimjinseob88@gmail.com>
> +
> +description: |
> +  Open Sensor Fusion is a sensor aggregation hub. The hub exposes an OSF
> +  protocol data stream over its host interface and may report capabilities and
> +  samples for multiple sensor classes. The Linux driver discovers the actual
> +  sensor channels from OSF capability reports instead of describing those
> +  sensors in Device Tree.
> +
> +  Open Sensor Fusion is not a generic industry standard. Public project
> +  documentation is available at:
> +
> +    https://github.com/opensensorfusion
> +
> +allOf:
> +  - $ref: /schemas/serial/serial-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    const: opensensorfusion,osf
> +
> +required:
> +  - compatible

Do you think it makes sense to permit a regulator here, so that the
"host" OS can power on/off the board running the osf stack?

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    serial {
> +        sensor {
> +            compatible = "opensensorfusion,osf";
> +        };
> +    };
> +...

--F4y7872aqCtHrHPU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaig9BwAKCRB4tDGHoIJi
0hG/AP4hOCzIQNNjnnrRnQE3z/CD1lLuIvpAI2jwssxsab2H0gD+O2rB5gXCoAzW
8hHQlJX15NIvlN0EFLeu4rHiADANewQ=
=0y3g
-----END PGP SIGNATURE-----

--F4y7872aqCtHrHPU--
