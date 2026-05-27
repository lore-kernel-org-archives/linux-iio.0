Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466553ED100
	for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 10:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779878441; cv=none; b=K0zyOu2tBSJ22UaIlt7Gg13n/c2SvGbBYnr/4z/B+7V3RC+JpjxjXLepdWdmhIxdCcEpth1n5eVJ3maxZCFSvAUYU74F25sJwSX7jnzpKb6O28VrZXjRux9UZ26vmeOa8HuouarcBzPf1mkaMaZxBZcleUBcumH+fJOANj1GV+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779878441; c=relaxed/simple;
	bh=40TsmwKp/7Wy8SWEzmjDb13anIIOB+B4qa8KZHnL8pw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RWZ2l45N+lVR3wd0M8HOK2x9kP70eTDqdmw1o/DTBiHQEpIbtnsmQ+rYFYOY6CD9hJo4LHGr+eyMnVCEtgj8aKlDVtIia+WqBTzkBSeHiFMe6dlAJKvzsvG3yQKNbZT/QCn9HrrvrEBd4WIFynn4wD3ebehwghVuyUQ72K7b2bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abVkNdYG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abVkNdYG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65F21F000E9;
	Wed, 27 May 2026 10:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779878439;
	bh=Jw7E9rY9222SJiN2S/RnjV6gSauLHlg+BfgSncGUfms=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=abVkNdYGtN24ukAAkVxAmdLHmqMS4X2tQdAfGfUAvqA21/SS03jMyptnX5cl5Q2nY
	 GC+vqVWvYN9jL27u73PFLKlVKPuJ9/Mx9juM5Wgtx77t/71UuVKUvif6+HFbUH7slk
	 idBF8Yi9sl0o4CsZLh8kTBx9ClENCkOQJDmlPP3IDFr4cvgTqHvq+AMVyeK4dBn3Ik
	 619TxdJONsb48wgL29zLcAFTIBJqTOlVoslx275t9MBUF1VAzkfCPSCLVVpilI5M/s
	 w+YNcpDu1G9MOtwVFoDSC+CxBPdDoaWODud7nAUD5Ce1EFNpKN9t0yqMhrDOGHx0y7
	 5wZpJ5Zxz+Ukw==
Date: Wed, 27 May 2026 11:40:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Louis Adamian <adamianlouis@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com
Subject: Re: [RFC PATCH 1/2] dt-bindings: iio: pressure: Add binding for
 MS5637
Message-ID: <20260527114031.5934925f@jic23-huawei>
In-Reply-To: <20260526185612.35048-3-adamianlouis@gmail.com>
References: <20260526185612.35048-2-adamianlouis@gmail.com>
	<20260526185612.35048-3-adamianlouis@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 May 2026 14:40:30 -0400
Louis Adamian <adamianlouis@gmail.com> wrote:

Hi Louis,

Title should just be 
dt-bindings: iio: pressure: Add MS5637
as it is obviously a binding from teh dt-bindings bit.


> Create meas,ms5637 devicetree documentation file and move existing
> devices from trivial-devices.yaml

Ad something here about why you need to include the variants and what
the compatibles with out variants correspond to.


Note that Sashiko calls out that at least some of these devices support SPI so
the binding needs to incorporate that as well
https://sashiko.dev/#/patchset/20260526185612.35048-2-adamianlouis%40gmail.com
Note we should do that even though the driver is currently i2c only I think.

One minor thing inline

Thanks

Jonathan



> 
> Signed-off-by: Louis Adamian <adamianlouis@gmail.com>
> ---
>  .../bindings/iio/pressure/meas,ms5637.yaml    | 52 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  | 10 ----
>  2 files changed, 52 insertions(+), 10 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/meas,ms5637.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/meas,ms5637.yaml b/Documentation/devicetree/bindings/iio/pressure/meas,ms5637.yaml
> new file mode 100644
> index 000000000000..703e34989cb5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/pressure/meas,ms5637.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/pressure/meas,ms5637.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +title: Measurement Specialties ms5637 and similar pressure sensors
> +
> +maintainers:
> +  - Louis Adamian <adamianlouis@gmail.com>
> +
> +description:
> +  Measurement Specialties ms5637 pressure and temperature sensors with
> +  I2C interface.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - meas,ms5637
> +      - meas,ms5637-30ba
> +      - meas,ms5803
> +      - meas,ms5803-01ba
> +      - meas,ms5803-02ba
> +      - meas,ms5803-05ba
> +      - meas,ms5803-14ba
> +      - meas,ms5803-30ba
> +      - meas,ms5805
> +      - meas,ms5837
> +      - meas,ms5837-30ba
> +      - meas,ms8607-temppressure
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +required:
> +  - compatible
> +  - reg

vdd-supply should be required as well in the binding.
(doesn't necessarily need to be in the driver!)

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pressure@76 {
> +            compatible = "meas,ms5803-14ba";
> +            reg = <0x76>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 23fd4513933a..a1516ab50a40 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -232,18 +232,8 @@ properties:
>            - meas,htu21
>              # Measurement Specialities I2C temperature and humidity sensor
>            - meas,htu31
> -            # Measurement Specialities I2C pressure and temperature sensor
> -          - meas,ms5637
> -            # Measurement Specialities I2C pressure and temperature sensor
> -          - meas,ms5803
> -            # Measurement Specialities I2C pressure and temperature sensor
> -          - meas,ms5805
> -            # Measurement Specialities I2C pressure and temperature sensor
> -          - meas,ms5837
>              # Measurement Specialities temp and humidity part of ms8607 device
>            - meas,ms8607-humidity
> -            # Measurement Specialities temp and pressure part of ms8607 device
> -          - meas,ms8607-temppressure
>              # Measurement Specialties temperature sensor
>            - meas,tsys01
>              # MEMSIC magnetometer

