Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AC938D402;
	Tue, 23 Jun 2026 19:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782242826; cv=none; b=IKCtZbGNo3el8naQ/ljGZHqrY3Pe7EyLTPIP+a0YcNRaL/zSmK637SMs9gYF0rclO/pbvGq9v+MKcyLByPeI9XByadoSiekAXhXPqZdp5kwHYELlQ8q2IL8DJmBd7xmaK5BaciuB51yAed8JZTTC5Gp1ZOKHmB1ILSH5kd0CVcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782242826; c=relaxed/simple;
	bh=UdJQ7MF+bWrHcMAMYbY3yufjN5biEaDg61DrZgkfktE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Go76do+SgoQoP21ZWevBcWerBzrlvAyAPUqmndv683f8LMuudXtlyCGr0287Bi95tCZAnAIWqlBJ4rpXev6xRRgzniLM/9PgT3BdLU933ReRMCIC2X266JH2c36C8PL1PSyYcDewEdaN6UlOrUXbcPM9ikiNCA11hR0XD7Gor/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osKsdsds; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osKsdsds"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0571F000E9;
	Tue, 23 Jun 2026 19:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782242825;
	bh=fY7+Qjso6OV5dU6LiTyf8OW91V/vJT0ZeQDfUV9KiE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=osKsdsdsdSRrb1vztVn6OBLsx1boENTPDo0pPGyGgFxNUjqW30dFvb0qG9ZyKB0Q7
	 tWdqTH1vjkFvJ4Cwl6Xo2q6yF4qCluempfiUnUz2EE014VaK/27T9B7dOvJ0LI7Wgm
	 H26JPQSLtWuljqo8rCYjSszZpDgHFtN80eRMja4fYWL4dHJv8QKgSfgvVoV8+5N1jJ
	 qXRUFGvlFn4raTzOjNxKehSkbaGcBuwxbQMn2kaKpJ5hp/5wU8kapt27eC4UsgTfjq
	 aeHjjccUMdZTUcBf5TC5ssYp2E/6mI1WWsVuTQe/i2SCThTSM+x2VIZzDL4/YFqznF
	 0CtRCPiD8R/jg==
Date: Tue, 23 Jun 2026 20:26:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Herman van Hazendonk <github.com@herrie.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Denis Ciocca <denis.ciocca@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Denis Ciocca
 <denis.ciocca@st.com>, Linus Walleij <linusw@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: st,st-sensors: add
 st,fullscale-milligauss
Message-ID: <20260623202652.2f29a1fe@jic23-huawei>
In-Reply-To: <20260616-submit-iio-lsm303dlh-magn-fixes-v2-2-063edcf74e60@herrie.org>
References: <20260616-submit-iio-lsm303dlh-magn-fixes-v2-0-063edcf74e60@herrie.org>
	<20260616-submit-iio-lsm303dlh-magn-fixes-v2-2-063edcf74e60@herrie.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jun 2026 15:02:05 +0200
Herman van Hazendonk <github.com@herrie.org> wrote:

> Add an optional st,fullscale-milligauss property that selects the
> initial magnetometer full-scale range at probe time, expressed in
> milligauss.
> 
> The motivating case is the LSM303DLH magnetometer on the HP TouchPad
> (apq8060 / tenderloin) where the kernel's chip-default +/-1.3 G range
> saturates the X axis to the chip's 0xF000 overflow sentinel out of
> probe, because the chip is mounted close to surrounding power planes
> and picks up enough DC bias to exceed the smallest range.
> 
> The chip is not wedged by the saturation: a sysfs write of a wider
> range to in_magn_x_scale recovers it on the next conversion, and a
> UDEV rule on add of the IIO device is a viable steady-state
> workaround. What the DT property buys is the probe-time window: the
> in-tree consumers we use (sensorfw's iio-sensors-adaptor and the
> geomagnetic / orientation services on top of it) start polling
> in_magn_x_raw essentially as soon as the device node appears and
> treat the 0xF000 sentinel as a legitimate sample. Until a UDEV rule
> fires and commits the wider range, every read returns the stuck
> sentinel, and on slow-boot paths the consumer may have already
> cached a bogus calibration baseline by the time UDEV catches up.
> 
> st,fullscale-milligauss lets the device tree declare a wider
> initial range up-front so the correct range is in effect before any
> IIO consumer can open the device, and keeps the board-specific
> magnetometer calibration alongside the rest of the hardware
> description rather than splitting it between DTS and per-distro
> UDEV rules.
> 
> The full property name is spelled out rather than abbreviated to
> "-mg" because this same binding file already covers ST accelerometers
> where the conventional shorthand "mg" reads as milli-g (acceleration);
> the explicit "-milligauss" suffix makes the unit unambiguous if a
> similar tunable is ever introduced for the accel/gyro/pressure
> families.
> 
> The property is scoped to magnetometer compatibles via allOf/if-then
> clauses, with per-family enum lists of the accepted milligauss
> values (1300..8100 for LSM303DLH/DLHC/DLM, 4000..16000 for
> LIS3MDL/LSM9DS1/LSM303C). LSM303AGR / LIS2MDL / IIS2MDC have a
> single fixed full-scale (15000 mg) with no register to switch
> ranges, so the property is rejected outright for them. DTSes that
> misspell the value, place the property on an accelerometer /
> gyroscope / pressure node, or set it on a fixed-FS magnetometer
> fail dt_binding_check rather than emitting a runtime warning.
> 
> The property is purely additive: if absent, drivers fall back to
> their existing chip default. No existing in-tree DTS is affected.
> 
> Assisted-by: Claude:claude-opus-4-7 dt_binding_check checkpatch
> Assisted-by: Sashiko:claude-opus-4-7
> Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
> ---
>  .../devicetree/bindings/iio/st,st-sensors.yaml     | 71 ++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> index a1a958215cdb..f0805604c849 100644
> --- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> +++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> @@ -126,6 +126,13 @@ properties:
>    mount-matrix:
>      description: an optional 3x3 mounting rotation matrix.
>  
> +  st,fullscale-milligauss:
> +    description:
> +      Initial magnetometer full-scale at probe time, in milligauss.
> +      Per-chip allowed values are enumerated in the allOf clauses
> +      below.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
>  allOf:
>    - if:
>        properties:
> @@ -163,6 +170,70 @@ allOf:
>            maxItems: 1
>          st,drdy-int-pin: false
>  
> +  # Per-chip enum lists for st,fullscale-milligauss. Out-of-range
> +  # values fail dt_binding_check instead of being demoted to a
> +  # runtime warning by the driver.
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - st,lsm303dlh-magn
> +              - st,lsm303dlhc-magn
> +              - st,lsm303dlm-magn
> +    then:
> +      properties:
> +        st,fullscale-milligauss:
> +          enum: [1300, 1900, 2500, 4000, 4700, 5600, 8100]
Can we also add default: to these entries to document what happens
when nothing is provided?

Thanks,

Jonathan
