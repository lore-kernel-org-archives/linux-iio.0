Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB893FAE1D;
	Thu, 11 Jun 2026 17:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781197842; cv=none; b=JExrjQcsrvzDoR1Ht0U5E8XvfJgDZEZMcfSj+hzs4vKLy9+1s5an4uFPnPy9lgerBqrN0EAhX7Ee1ab/ZuCCr+SBFCv9vjn+ZbM6+tjzTcKu9ttbJnSRxci6+sf0vHevOCPd0t7GxUQE40gHPmWqhqVsdWEfrl2PT+x6iv5pjNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781197842; c=relaxed/simple;
	bh=dqpD2DL5ZYTOQxBjDP/Q0r+oCuGntYACBALlaNRN62w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/X+eCsLcLOiTgEyVqZSmqLMCpd4x2JvrrkTgWVAIs3Z0y6P0BY+FpKspNPGs89KqYIJPxA2P48v5zG83+lmxlgwcnwKMXH9M6VjKXsWkbMApBdFJ4XxN6NHoqu3BrgrmWPnNqqQEVcUu5Ht71aw/Pp+kMbfqlAqVlp/MboOM/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4I5Iqv/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4I5Iqv/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68C71F00893;
	Thu, 11 Jun 2026 17:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781197840;
	bh=f+TNKAsVr4evYwiz7DFTzqvBrv2MnEmWp809rqSwbMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R4I5Iqv/hRG9nYRnaKHWq2yM6ToWdsA5EPcrwZ5Grvs5j5XYSKd4Ext/gHP0HzRrh
	 VmkxG8jvrfvn+b0j4aNn0zm42Fz4tynu2Cw/RYBmZSAijIDXhmILQWTQwaLnFoxh+R
	 HB6atXljd8Iq8HC7yOddp7rRTs1Lx27Eveoyxgwe8w839zOngNIM7uLStu1qM4ZfqQ
	 Smwn50nIx+YgPAKWLBW51VJqViDMA8Y14IlQacooPGwn6s8k1/7u7MtXAE1676f0YO
	 T4WqsD33In4zDfn2mpkgAbhE2uoMlAjr8/PVMTsE7mz4e3gUvJYNlw8LJiW8tIGtVO
	 R1w1Z3Gm381kA==
Date: Thu, 11 Jun 2026 18:10:36 +0100
From: Conor Dooley <conor@kernel.org>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, jic23@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linusw@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: accel: convert lis302 binding
 to YAML schema (v2)
Message-ID: <20260611-catacomb-jazz-e8e0d7eabb87@spud>
References: <20260611154105.3727-1-shofiqtest@gmail.com>
 <20260611154105.3727-4-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="34MfzEqiPWWvHZlU"
Content-Disposition: inline
In-Reply-To: <20260611154105.3727-4-shofiqtest@gmail.com>


--34MfzEqiPWWvHZlU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 06:41:05PM +0300, Md Shofiqul Islam wrote:
> Replace the plain text lis302.txt with a YAML schema for the
> LIS302DL/LIS3LV02D accelerometer family.
>=20
> Key changes from v1:
> - Add a prominent WARNING in the description that this is a legacy
>   binding and must not be copied for new devices
> - Add st,lis302dl compatible (used by Nokia N900 / omap3-n900.dts)
>   in addition to st,lis302dl-spi and st,lis3lv02d
> - Document both supply naming conventions: Vdd-supply/Vdd_IO-supply
>   (legacy uppercase, used by most boards) and vdd-supply/vddio-supply
>   (modern lowercase, used by Nokia N900)
> - Add mount-matrix support (used by Nokia N900)
> - Add self-test limit properties st,min-limit-x/y/z and
>   st,max-limit-x/y/z (these legitimately belong in DT as they
>   encode per-board hardware tolerances)
> - Mark all click/irq/wakeup/filter properties as deprecated=3Dtrue.
>   They configure run-time driver behaviour, not hardware, and should
>   not appear in DT for new boards
> - Add st,click-thresh-x/y/z as deprecated with an explicit note that
>   this is a misspelling present in several upstream boards; the driver
>   reads st,click-threshold-x/y/z and never reads the short form
> - Remove driver path reference from description
> - Use schema constraints (minimum/maximum) for axis remapping range
> - Remove Jonathan Cameron as maintainer; use Linus Walleij who
>   already maintains the related st,st-sensors binding
> - Use example based on actual upstream board (Nokia N900)

This whole section should be under the --- line.
Please do not send additional versions while discussion is still ongoing
on your most recent.

Thanks,
Conor.

>=20
> Boards using this as primary binding:
>   st,lis302dl:     omap3-n900.dts
>   st,lis3lv02d:    omap3-n950-n9.dtsi, am335x-pepper.dts
>   st,lis302dl-spi: pxa300-raumfeld-controller.dts
>=20
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
> ---
>  .../devicetree/bindings/iio/accel/lis302.txt  | 119 -------
>  .../bindings/iio/accel/st,lis302dl.yaml       | 320 ++++++++++++++++++
>  2 files changed, 320 insertions(+), 119 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/accel/lis302.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/st,lis302=
dl.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/accel/lis302.txt b/Doc=
umentation/devicetree/bindings/iio/accel/lis302.txt
> deleted file mode 100644
> index 457539647f36..000000000000
> --- a/Documentation/devicetree/bindings/iio/accel/lis302.txt
> +++ /dev/null
> @@ -1,119 +0,0 @@
> -LIS302 accelerometer devicetree bindings
> -
> -This device is matched via its bus drivers, and has a number of properti=
es
> -that apply in on the generic device (independent from the bus).
> -
> -
> -Required properties for the SPI bindings:
> - - compatible: 		should be set to "st,lis3lv02d-spi"
> - - reg:			the chipselect index
> - - spi-max-frequency:	maximal bus speed, should be set to 1000000 unless
> -			constrained by external circuitry
> - - interrupts:		the interrupt generated by the device
> -
> -Required properties for the I2C bindings:
> - - compatible:		should be set to "st,lis3lv02d"
> - - reg:			i2c slave address
> - - Vdd-supply:		The input supply for Vdd
> - - Vdd_IO-supply:	The input supply for Vdd_IO
> -
> -
> -Optional properties for all bus drivers:
> -
> - - st,click-single-{x,y,z}:	if present, tells the device to issue an
> -				interrupt on single click events on the
> -				x/y/z axis.
> - - st,click-double-{x,y,z}:	if present, tells the device to issue an
> -				interrupt on double click events on the
> -				x/y/z axis.
> - - st,click-thresh-{x,y,z}:	set the x/y/z axis threshold
> - - st,click-click-time-limit:	click time limit, from 0 to 127.5msec
> -				with step of 0.5 msec
> - - st,click-latency:		click latency, from 0 to 255 msec with
> -				step of 1 msec.
> - - st,click-window:		click window, from 0 to 255 msec with
> -				step of 1 msec.
> - - st,irq{1,2}-disable:		disable IRQ 1/2
> - - st,irq{1,2}-ff-wu-1:		raise IRQ 1/2 on FF_WU_1 condition
> - - st,irq{1,2}-ff-wu-2:		raise IRQ 1/2 on FF_WU_2 condition
> - - st,irq{1,2}-data-ready:	raise IRQ 1/2 on data ready condition
> - - st,irq{1,2}-click:		raise IRQ 1/2 on click condition
> - - st,irq-open-drain:		consider IRQ lines open-drain
> - - st,irq-active-low:		make IRQ lines active low
> - - st,wu-duration-1:		duration register for Free-Fall/Wake-Up
> -				interrupt 1
> - - st,wu-duration-2:		duration register for Free-Fall/Wake-Up
> -				interrupt 2
> - - st,wakeup-{x,y,z}-{lo,hi}:	set wakeup condition on x/y/z axis for
> -				upper/lower limit
> - - st,wakeup-threshold:		set wakeup threshold
> - - st,wakeup2-{x,y,z}-{lo,hi}:	set wakeup condition on x/y/z axis for
> -				upper/lower limit for second wakeup
> -				engine.
> - - st,wakeup2-threshold:	set wakeup threshold for second wakeup
> -				engine.
> - - st,highpass-cutoff-hz=3D:	1, 2, 4 or 8 for 1Hz, 2Hz, 4Hz or 8Hz of
> -				highpass cut-off frequency
> - - st,hipass{1,2}-disable:	disable highpass 1/2.
> - - st,default-rate=3D:		set the default rate
> - - st,axis-{x,y,z}=3D:		set the axis to map to the three coordinates.
> -				Negative values can be used for inverted axis.
> - - st,{min,max}-limit-{x,y,z}	set the min/max limits for x/y/z axis
> -				(used by self-test)
> -
> -
> -Example for a SPI device node:
> -
> -	accelerometer@0 {
> -		compatible =3D "st,lis302dl-spi";
> -		reg =3D <0>;
> -		spi-max-frequency =3D <1000000>;
> -		interrupt-parent =3D <&gpio>;
> -		interrupts =3D <104 0>;
> -
> -		st,click-single-x;
> -		st,click-single-y;
> -		st,click-single-z;
> -		st,click-thresh-x =3D <10>;
> -		st,click-thresh-y =3D <10>;
> -		st,click-thresh-z =3D <10>;
> -		st,irq1-click;
> -		st,irq2-click;
> -		st,wakeup-x-lo;
> -		st,wakeup-x-hi;
> -		st,wakeup-y-lo;
> -		st,wakeup-y-hi;
> -		st,wakeup-z-lo;
> -		st,wakeup-z-hi;
> -	};
> -
> -Example for a I2C device node:
> -
> -	lis331dlh: accelerometer@18 {
> -		compatible =3D "st,lis331dlh", "st,lis3lv02d";
> -		reg =3D <0x18>;
> -		Vdd-supply =3D <&lis3_reg>;
> -		Vdd_IO-supply =3D <&lis3_reg>;
> -
> -		st,click-single-x;
> -		st,click-single-y;
> -		st,click-single-z;
> -		st,click-thresh-x =3D <10>;
> -		st,click-thresh-y =3D <10>;
> -		st,click-thresh-z =3D <10>;
> -		st,irq1-click;
> -		st,irq2-click;
> -		st,wakeup-x-lo;
> -		st,wakeup-x-hi;
> -		st,wakeup-y-lo;
> -		st,wakeup-y-hi;
> -		st,wakeup-z-lo;
> -		st,wakeup-z-hi;
> -		st,min-limit-x =3D <120>;
> -		st,min-limit-y =3D <120>;
> -		st,min-limit-z =3D <140>;
> -		st,max-limit-x =3D <550>;
> -		st,max-limit-y =3D <550>;
> -		st,max-limit-z =3D <750>;
> -	};
> -
> diff --git a/Documentation/devicetree/bindings/iio/accel/st,lis302dl.yaml=
 b/Documentation/devicetree/bindings/iio/accel/st,lis302dl.yaml
> new file mode 100644
> index 000000000000..8a19aa108521
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/st,lis302dl.yaml
> @@ -0,0 +1,320 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/accel/st,lis302dl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics LIS302DL/LIS3LV02D 3-Axis Accelerometer (Legac=
y Binding)
> +
> +description: |
> +  WARNING: This is a legacy binding for hardware that predates modern DT
> +  practices. It is documented as-found in upstream board files. Do NOT u=
se
> +  this as a template for new drivers or bindings.
> +
> +  The driver lives in drivers/misc/lis3lv02d, not in IIO. Many properties
> +  listed here represent run-time driver configuration that would normall=
y not
> +  appear in device tree. They are documented here only because existing
> +  upstream board DTS files use them.
> +
> +  Compatibles st,lis302dl-spi and st,lis3lv02d were previously listed as
> +  deprecated in st,st-sensors.yaml. They are moved here with their actual
> +  hardware configuration so validation works correctly.
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: I2C variant (original part)
> +        const: st,lis302dl
> +      - description: I2C variant (larger range)
> +        const: st,lis3lv02d
> +      - description: SPI variant; including the bus type in the compatib=
le
> +          string is a legacy naming error, do not copy for new bindings
> +        const: st,lis302dl-spi
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +
> +  Vdd-supply:
> +    description: Main power supply (legacy uppercase name used by most b=
oards).
> +
> +  Vdd_IO-supply:
> +    description: I/O power supply (legacy uppercase name used by most bo=
ards).
> +
> +  vdd-supply:
> +    description: Main power supply (modern lowercase name, used by omap3=
-n900).
> +
> +  vddio-supply:
> +    description: I/O power supply (modern lowercase name, used by omap3-=
n900).
> +
> +  mount-matrix:
> +    description: 3x3 mounting rotation matrix.
> +
> +  st,min-limit-x:
> +    $ref: /schemas/types.yaml#/definitions/int32
> +    description: Minimum acceptable self-test delta for X axis.
> +
> +  st,min-limit-y:
> +    $ref: /schemas/types.yaml#/definitions/int32
> +    description: Minimum acceptable self-test delta for Y axis.
> +
> +  st,min-limit-z:
> +    $ref: /schemas/types.yaml#/definitions/int32
> +    description: Minimum acceptable self-test delta for Z axis.
> +
> +  st,max-limit-x:
> +    $ref: /schemas/types.yaml#/definitions/int32
> +    description: Maximum acceptable self-test delta for X axis.
> +
> +  st,max-limit-y:
> +    $ref: /schemas/types.yaml#/definitions/int32
> +    description: Maximum acceptable self-test delta for Y axis.
> +
> +  st,max-limit-z:
> +    $ref: /schemas/types.yaml#/definitions/int32
> +    description: Maximum acceptable self-test delta for Z axis.
> +
> +  # The following properties configure run-time driver behaviour and do =
not
> +  # describe hardware. They are deprecated. Documented here only so that
> +  # existing upstream board DTS files pass dt_binding_check.
> +
> +  st,click-single-x:
> +    type: boolean
> +    deprecated: true
> +    description: Enable single-click detection on X axis.
> +
> +  st,click-single-y:
> +    type: boolean
> +    deprecated: true
> +    description: Enable single-click detection on Y axis.
> +
> +  st,click-single-z:
> +    type: boolean
> +    deprecated: true
> +    description: Enable single-click detection on Z axis.
> +
> +  st,click-threshold-x:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    deprecated: true
> +    description: Click threshold X axis. Driver default is used if absen=
t.
> +
> +  st,click-threshold-y:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    deprecated: true
> +    description: Click threshold Y axis. Driver default is used if absen=
t.
> +
> +  st,click-threshold-z:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    deprecated: true
> +    description: Click threshold Z axis. Driver default is used if absen=
t.
> +
> +  st,click-thresh-x:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    deprecated: true
> +    description: |
> +      Misspelling of st,click-threshold-x present in several upstream bo=
ard
> +      files. The driver does not read this property; it is silently igno=
red.
> +      Documented here only to avoid dt_binding_check failures on those b=
oards.
> +
> +  st,click-thresh-y:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    deprecated: true
> +    description: See st,click-thresh-x.
> +
> +  st,click-thresh-z:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    deprecated: true
> +    description: See st,click-thresh-x.
> +
> +  st,click-time-limit:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    deprecated: true
> +    description: Click time limit in 0.5ms steps (0-127).
> +
> +  st,click-latency:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    deprecated: true
> +    description: Click latency in 1ms steps (0-255).
> +
> +  st,click-window:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    deprecated: true
> +
> +  st,irq1-click:
> +    type: boolean
> +    deprecated: true
> +  st,irq2-click:
> +    type: boolean
> +    deprecated: true
> +  st,irq1-ff-wu-1:
> +    type: boolean
> +    deprecated: true
> +  st,irq1-ff-wu-2:
> +    type: boolean
> +    deprecated: true
> +  st,irq2-ff-wu-1:
> +    type: boolean
> +    deprecated: true
> +  st,irq2-ff-wu-2:
> +    type: boolean
> +    deprecated: true
> +  st,irq1-data-ready:
> +    type: boolean
> +    deprecated: true
> +  st,irq2-data-ready:
> +    type: boolean
> +    deprecated: true
> +  st,irq1-disable:
> +    type: boolean
> +    deprecated: true
> +  st,irq2-disable:
> +    type: boolean
> +    deprecated: true
> +  st,irq-open-drain:
> +    type: boolean
> +    deprecated: true
> +  st,irq-active-low:
> +    type: boolean
> +    deprecated: true
> +
> +  st,wakeup-x-lo:
> +    type: boolean
> +    deprecated: true
> +  st,wakeup-x-hi:
> +    type: boolean
> +    deprecated: true
> +  st,wakeup-y-lo:
> +    type: boolean
> +    deprecated: true
> +  st,wakeup-y-hi:
> +    type: boolean
> +    deprecated: true
> +  st,wakeup-z-lo:
> +    type: boolean
> +    deprecated: true
> +  st,wakeup-z-hi:
> +    type: boolean
> +    deprecated: true
> +  st,wakeup-threshold:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    deprecated: true
> +
> +  st,wakeup2-x-lo:
> +    type: boolean
> +    deprecated: true
> +  st,wakeup2-x-hi:
> +    type: boolean
> +    deprecated: true
> +  st,wakeup2-y-lo:
> +    type: boolean
> +    deprecated: true
> +  st,wakeup2-y-hi:
> +    type: boolean
> +    deprecated: true
> +  st,wakeup2-z-lo:
> +    type: boolean
> +    deprecated: true
> +  st,wakeup2-z-hi:
> +    type: boolean
> +    deprecated: true
> +  st,wakeup2-threshold:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    deprecated: true
> +
> +  st,wu-duration-1:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    deprecated: true
> +  st,wu-duration-2:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    deprecated: true
> +
> +  st,highpass-cutoff-hz:
> +    enum: [1, 2, 4, 8]
> +    deprecated: true
> +  st,hipass1-disable:
> +    type: boolean
> +    deprecated: true
> +  st,hipass2-disable:
> +    type: boolean
> +    deprecated: true
> +
> +  st,default-rate:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    deprecated: true
> +
> +  st,axis-x:
> +    $ref: /schemas/types.yaml#/definitions/int32
> +    minimum: -3
> +    maximum: 3
> +    deprecated: true
> +    description: Axis remapping. Replaced by mount-matrix.
> +
> +  st,axis-y:
> +    $ref: /schemas/types.yaml#/definitions/int32
> +    minimum: -3
> +    maximum: 3
> +    deprecated: true
> +    description: Axis remapping. Replaced by mount-matrix.
> +
> +  st,axis-z:
> +    $ref: /schemas/types.yaml#/definitions/int32
> +    minimum: -3
> +    maximum: 3
> +    deprecated: true
> +    description: Axis remapping. Replaced by mount-matrix.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        accelerometer@1d {
> +            compatible =3D "st,lis302dl";
> +            reg =3D <0x1d>;
> +            vdd-supply =3D <&vaux1>;
> +            vddio-supply =3D <&vio>;
> +            interrupt-parent =3D <&gpio6>;
> +            interrupts =3D <21 IRQ_TYPE_EDGE_RISING>,
> +                         <20 IRQ_TYPE_EDGE_RISING>;
> +            mount-matrix =3D "-1", "0", "0",
> +                            "0", "1", "0",
> +                            "0", "0", "-1";
> +        };
> +    };
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        accelerometer@1 {
> +            compatible =3D "st,lis302dl-spi";
> +            reg =3D <1>;
> +            spi-max-frequency =3D <1000000>;
> +            interrupt-parent =3D <&gpio>;
> +            interrupts =3D <104 IRQ_TYPE_EDGE_FALLING>;
> +            st,click-single-x;
> +            st,click-single-y;
> +            st,click-single-z;
> +            st,irq1-click;
> +            st,irq2-click;
> +        };
> +    };
> +...
> --=20
> 2.51.1
>=20

--34MfzEqiPWWvHZlU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCairsDAAKCRB4tDGHoIJi
0iQqAQDBceWigzXfWHCLEe79ISvFvLq9tzUYZHmm+NgGjyzuqwD+OTIY/cIBxdhy
dwIQuqUzXC9kIb8/I9488J6au9wTHAQ=
=X5qc
-----END PGP SIGNATURE-----

--34MfzEqiPWWvHZlU--
