Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2A02AD35;
	Sun,  4 Oct 2026 07:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791100426; cv=none; b=Sz9uWoMd9UUMyxnnRRSVj2OkMH5AK//1X4BcnIuBvFnOqsn+QCQmUxNnF8QaxRcEwE3bzL4uCFJSgfMJnMMZDfWnpBTcp1pVniE2gWL7afEqkesYaTiIdwNWF21XP4PeXsUQ694EpeW8yS7DHSXZbvoed8Vo+zRAbWjYsiMAw1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791100426; c=relaxed/simple;
	bh=utxP3uy3ciIRp7e0aIXzEQmD+tnu2RSV9aniC6Wh+38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooSArFRQ+qt25FkXaX5Q0JvFwxDzrzOOdRTm+P/fK27foMNo4/YLZ/AeTZUdEwngC6OSPgNeiBEWhXHCn9Umw9Rffp/cIawppXcObvfA+3reDX0KBTugvtoy6g9gL7nSiZO0pOI0yke+cuRhYINfuQSlT3y6FA4juBs8M9Pza6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qi/ipoTJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qi/ipoTJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14AC11F000FF;
	Sun,  4 Oct 2026 07:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791100425;
	bh=0tQQoSgX9OI7TJ3zFEhinA3XLRJ7TofcVHGvY+RYw3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qi/ipoTJj/xEfRdBNwZOWyo28NHzoEtdFsi9AjzuMqOEmADCxeZSrq4a5OyvCCeIt
	 gHi1cLIJOz1KE2/q2Rz9tKh0vIGN6Ev/cLBgI/hXYAOyOiJmMz7Be+8mQv18Gg6UD4
	 Pf2u0V3hQmQu388UjjZiiGq12/ANW0sn3/tO5yaDvi34rW7kQ/0rxYMPyvQjt6LciO
	 W3Fgu8a1Hq3wEQ6k8TWV5AJP0q37IN62+RkwlmYJJATrNg9nVRQQ4i4uL+9CikDeYp
	 F0AIs4V3W7I4QbMjsv0VA9sekEgLdKFvZMafT1hkQ24JpIUx6yckJH9ccFfjjRecWu
	 /Hwmrs+6NgDgg==
Date: Sun, 4 Oct 2026 09:53:43 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Muhammad Abu Bakar <m.abubakar365@yahoo.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: pressure: add Sensirion SDP31
Message-ID: <20261004-uncovered-ecstatic-jaguar-d7b0a6@quoll>
References: <20261003160949.4657-1-m.abubakar365@yahoo.com>
 <20261003160949.4657-2-m.abubakar365@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261003160949.4657-2-m.abubakar365@yahoo.com>

On Sat, Oct 03, 2026 at 09:09:48PM +0500, Muhammad Abu Bakar wrote:
> Add device tree bindings for the Sensirion SDP3x family of differential
> pressure sensors (SDP31, SDP32 and SDP33), I2C devices that also report
> temperature.
> 
> Assisted-by: Claude:claude-opus-4-8

LLM, see current kernel docs for Assisted-by format.

> Assisted-by: Claude:claude-opus-5-5

Drop

> Signed-off-by: Muhammad Abu Bakar <m.abubakar365@yahoo.com>
> ---
>  .../iio/pressure/sensirion,sdp31.yaml         | 51 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml b/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml
> new file mode 100644
> index 000000000..ed02b639c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/pressure/sensirion,sdp31.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sensirion SDP31, SDP32 and SDP33 differential pressure sensors
> +
> +maintainers:
> +  - Muhammad Abu Bakar <m.abubakar365@yahoo.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  Differential pressure sensors from Sensirion with an I2C interface.
> +  The SDP31, SDP32 and SDP33 differ only in their measurement range.
> +

With these two fixed:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

