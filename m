Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D780171CD;
	Sun, 14 Jun 2026 18:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781462693; cv=none; b=ZcCaLue1wl41ZqWYg6HX+9EdA6uafEva0SSnZJ86BCXLFUaMbHZrFdUJvBfVn0zrY9LKXO3FUUnbYHOBr2vIgve7lYIGIkwRNnCz28K2cekqflifXfTn2ng7R97D5Uv6svrym/hnzpMq37C3I7DHsqpx1LcgcxYdLz9G93p1KLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781462693; c=relaxed/simple;
	bh=Nv5T4ABzwDIijvGHNIC5xvGeplANBw+54noBdZJsshU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JsWakfcwlwAxe1EvTT4/WgNjrl1E4uF1ALCYxbTmW1Uoy9QTCftV8hluMepTp2f1mJfx4AXQ6L4vbDBvS/3WiT9NHvSansILt1lVV3pYf5GDtZpWiUKdI+b6rhSq4jHNnVfSn2sJIIOxVjUhMgmTlfbn9igMVqGIZdzDokg8cPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAUsrqnU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAUsrqnU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D931F000E9;
	Sun, 14 Jun 2026 18:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781462692;
	bh=4OCR0SR1M2Q+HlRLWIbJc+UtKvK71TYIwcxtVqxVKvg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jAUsrqnUDSmOjOoc/E3e6CJTZCRuphEfKIJRrP/9ycBmpISkmXizjUS98P9ImcgjA
	 uvAiVYHcyIuuBbhJQhbvYQMcIz2mVJuiwVfIhGCxU2xDMKrJUXX5Adp6eq8ENck+aD
	 WYCBe8K8UScvLBrWeusmhTCdZvi64uYoVzPd2Rx8C6rqVygQtZeWLIBM0CLv0xLEJJ
	 rDygNCeHdMq4zHXhZaEksrE18vtLE86QzbcrXGMT1i717JaCHiAfePsl6MaHeurjGa
	 /TanZ9GDZl+gxM6ALE5gdu6CrrcOizMrOgu9irUj8ViA4sVNPurzT79nYAp4VjYn8m
	 iNKZ1X6p9yiGg==
Date: Sun, 14 Jun 2026 19:44:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Herman van Hazendonk <github.com@herrie.org>
Cc: linusw@kernel.org, denis.ciocca@st.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, sanjayembeddedse@gmail.com,
 maudspierings@gocontroll.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: st,st-sensors: add
 st,fullscale-mg
Message-ID: <20260614194442.61191f68@jic23-huawei>
In-Reply-To: <e49aba850b1f48ea00089e7142c00584541001eb.1780652883.git.github.com@herrie.org>
References: <cover.1780652883.git.github.com@herrie.org>
	<e49aba850b1f48ea00089e7142c00584541001eb.1780652883.git.github.com@herrie.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Jun 2026 12:08:42 +0200
Herman van Hazendonk <github.com@herrie.org> wrote:

> Add an optional st,fullscale-mg property that selects the initial
> full-scale range of an ST MEMS sensor at probe time, expressed in
> milligauss for magnetometers (and analogous engineering units for
> other ST sensor families that may grow this property in the future).
> 
> The property is purely additive: if absent, drivers fall back to
> their existing chip default, and if present but unsupported by the
> specific sensor the driver warns and falls back. No existing in-tree
> DTS is affected.
> 
> The motivating case is the LSM303DLH magnetometer on the HP TouchPad
> (apq8060 / tenderloin) where the kernel's chip-default +/-1.3 G range
> saturates the X axis to the chip's 0xF000 overflow sentinel out of
> probe, because the chip is mounted close to surrounding power planes
> and picks up enough DC bias to exceed the smallest range. The driver
> core hardcodes fs_avl[0] as the starting range, so userspace cannot
> recover without racing the driver to write the in_magn_x_scale sysfs
> attribute after probe. st,fullscale-mg lets the device tree declare
> a wider initial range up-front and avoids the race entirely.

I'm trying to understand what you mean here by racing.

If we get this overflow condition the chip is wedged until reset, or
userspace simply has to change the range to recover?

I'm wondering if a UDEV rule is sufficient in theory to fix this.

I'm not necessarily against having the range in DT as it is effectively
hardware dependent but just want to make sure I fully understand the issue.

Jonathan



> 
> Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
> ---
>  .../devicetree/bindings/iio/st,st-sensors.yaml | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> index a1a958215cdb..335f38e9f78f 100644
> --- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> +++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> @@ -126,6 +126,24 @@ properties:
>    mount-matrix:
>      description: an optional 3x3 mounting rotation matrix.
>  
> +  st,fullscale-mg:
> +    description: |
> +      Selects the initial sensor full-scale at probe time, expressed in
> +      milligauss for magnetometers (or analogous engineering units for
> +      other sensor families that may grow this property in the future).
> +      The value must match one of the sensor-specific full-scale ranges
> +      supported by the chip; if the chip does not support the requested
> +      range the driver falls back to its built-in default.
> +
> +      This is intended for boards where the magnetometer chip picks up
> +      enough DC bias from nearby PCB structures (power planes, ferrous
> +      shields, etc.) that the kernel's chip-default highest-sensitivity
> +      range saturates one or more axes to the chip's overflow sentinel,
> +      and userspace observes that axis as permanently stuck. Declaring
> +      a wider initial range avoids the saturation at the cost of a
> +      slightly coarser quantisation.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
>  allOf:
>    - if:
>        properties:

