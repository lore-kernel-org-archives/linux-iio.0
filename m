Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1B223A564;
	Mon, 13 Jul 2026 01:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783906493; cv=none; b=sAS5r5Wc4llOGAMyrKH6wkzHFWrkYu6r/GdU6ygExI6j2msEyfjY0Zvk/pc/NEJgDYWYbd8tBmfojzDzrDvmjjR8TmnzWyeHKc2AJRCjzKLrZcXuWTrx44B0xHsM5on3q2/r2kwVxXEB17J/IdYae6d4HPupwTVSOPILO2QDSwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783906493; c=relaxed/simple;
	bh=WNMMz5K7EryQ6DHQAMS+LxuZaLeFySnj5mDADFRl5J0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SNDPZ2+Y10VJ0jqxUVhyAJp7aMELZuAUIVB76yJVuuvuki3LmN7fxbgfUUTC4jeHWLFojlTAfzTuc9L/4azLIG0l8LeVoJ+TTuNw+gx5oOLZm26pwIlfQUHv8elRWN6PSaQeXYk1xZ06jcPHB8IUPCetfvZQAIzWxNvugl8bOyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+8IIBgN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+8IIBgN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6EA1F000E9;
	Mon, 13 Jul 2026 01:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783906492;
	bh=WrGLb51pjDFZSWge3h1JanVeqwUGG+vdXRljL6THa/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=f+8IIBgNRCHGVh9RkX54n7DxO+9nzUe33sf09fMolNOJX5NfYFR1lXdeZ8pYG1Wyn
	 urb/GRQu3DqOibYPZyQR1t3c0gO8sBIOEcCSN+i8Hg6EYoHMi9x7BTt/+1uCI7WyMI
	 wXhjb+v3FWbdfOr2LqT7RrEPYtYEu0HnwBkMq8yd2wwycxrfl93DoStNCGncYTXVwI
	 iyZ1KXtyJSoOSc5RAswQoXUcCLaLouc7D81S7PMEoioAYXH3mXzaS/5Yco+3iocRz5
	 rbyieOpVwIictdtSt6FbUWdd/wRfz3Pd3Gi6Hyex/1X8vvIFXv/KhkbK7A3a1wWZko
	 M0WYLIBXPqbcg==
Date: Mon, 13 Jul 2026 02:34:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chris Hall
 <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, Kurt Borja
 <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/8] dt-bindings: iio: adc: add input-chopping
 property
Message-ID: <20260713023443.1a7a9acb@jic23-huawei>
In-Reply-To: <20260710-iio-adc-ti-ads122c14-v3-4-746d52cbf1d0@baylibre.com>
References: <20260710-iio-adc-ti-ads122c14-v3-0-746d52cbf1d0@baylibre.com>
	<20260710-iio-adc-ti-ads122c14-v3-4-746d52cbf1d0@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jul 2026 17:50:37 -0500
"David Lechner (TI)" <dlechner@baylibre.com> wrote:

> Add a generic input-chopping property to adc.yaml. This is a feature
> seen frequently in ADCs that are designed to measure resistive loads,
> such as RTDs and strain gauges. Enabling this can reduce offset errors
> by swapping the positive and negative input channels on every other
> conversion. This can have side-effects in timing and filter response, so
> it is not always desirable to enable this feature in some applications.
> Therefore, it is best to make this a property that can be enabled or
> disabled in the device tree.
> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
> ---
> v3 changes:
> * Renamed property to input-chopping to reflect more common terminology.
> * Removed "allowed" from the description.
> * Extended description to explain when it should not be used.
> 
> v2 changes:
> * New patch.
> ---
>  Documentation/devicetree/bindings/iio/adc/adc.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> index 308857f11220..c408feebd46d 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> @@ -80,6 +80,14 @@ properties:
>        ADCs usually allow choosing between internal reference sources or a pair
>        of external pins.
>  
> +  input-chopping:
> +    type: boolean
> +    description:
> +      If set, the positive and negative input channels are swapped on every
> +      other conversion to reduce offset error. This generally comes at the
> +      expense of added settling time between conversions, so should be omitted
> +      on systems with high-frequency signals or high data rate requirements.

I'm lazy so I didn't check back, but in my mental model of this, the DT is simply
saying that the analog circuitry is suitable for doing chopping.  Driver decision
on whether to do it.  Perhaps we can reword it for that?
> +
>    excitation-channels:
>      $ref: /schemas/types.yaml#/definitions/uint32-array
>      description:
> 

