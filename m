Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB592DA75B;
	Mon, 11 May 2026 17:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518863; cv=none; b=dSvgqVFfZ6iCW42qPNxICs9QqFT42RMn+SSvRgJCRiB5ehslTh8iGceRK2fV08+rkIXhcQqTb9vQys4yzsXoZSn32iKUmHAS7p8U65+N/a1AZM8/21U3jx+4WJqwMcM8LwbsAZwDN/IjT8XuNJ3nKN1O7oHrB7lfD8b14WxJtMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518863; c=relaxed/simple;
	bh=oBQIZAf/Y1nxyQ1AdKOPmZyypz/lv+qNW5y0C9rlcnc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DJFwebRnHedsI8Vo0tpbmx5BXyV4twefos/XU0fY3rnZhi6eAkE3T4IYEso//Mgc0Imv9JVJiJ++LsstCmXSgR43ET69Qw4ufn3c82XJmdUQHrKNzqq9wxgL40XsClixj0lVnNkjbdoC+MeqgILGEvzW7TR7MiQQ4oaTgd5mpA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTYIs61E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTYIs61E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF00C2BCB0;
	Mon, 11 May 2026 17:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778518863;
	bh=oBQIZAf/Y1nxyQ1AdKOPmZyypz/lv+qNW5y0C9rlcnc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YTYIs61EkoCYJz8wAHPj26p4P6YhLzg5u8+NVyYnHHdKFYOVL9PvC0d9rDZg4jTCO
	 KqO3ehfpTtr8rSVAL9Qt+sCqqEnd+3OTx0Rgw2RfyjUYx1duzkwK7u4+ac3EZa8tIM
	 f8ld9BWC+tO9fjpTM1iimWKDX9RD8kX1l54rMbI+ysTA782GFZwcUJ1xWAd/oIPjuG
	 j44F1J7RXs7PC7LFIeYIbjM20IxWyc6mZwGyr8+GUZm+LmImZ5MepRPZJXoZ9dWAMS
	 3GGMnyixeDb/2bjBmAhPK1rxi2XRL9bW8u6t/4uARcg4yK6hst9Qv2arlFp5cH1wWL
	 4w1W5xutVC/rA==
Date: Mon, 11 May 2026 18:00:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] dt-bindings: iio: dds: Add AD9832/AD9835 binding
Message-ID: <20260511180056.07986443@jic23-huawei>
In-Reply-To: <20260509013745.80478-2-dennylin0707@gmail.com>
References: <20260509013745.80478-1-dennylin0707@gmail.com>
	<20260509013745.80478-2-dennylin0707@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  9 May 2026 01:37:45 +0000
Hungyu Lin <dennylin0707@gmail.com> wrote:

> Add devicetree binding documentation for AD9832 and AD9835 DDS devices.
> 
> These devices are SPI-controlled direct digital synthesizers
> requiring AVDD, DVDD supplies and an external master clock.
> 
> Require spi-cpol since AD9832/AD9835 use SPI mode 2.
> Update the example to include spi-cpol and use a generic node name.
> 
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
As per v1 discussion that is ongoing - we haven't in the past put
dt-bindings in place until we are ready to move the driver in question
out of staging.  IIRC these are a fair way from reaching that stage.

Anyhow with that in mind a few quick comments inline.

Thanks,

Jonathan

> ---
>  .../bindings/iio/dds/adi,ad9832.yaml          | 91 +++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dds/adi,ad9832.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/dds/adi,ad9832.yaml b/Documentation/devicetree/bindings/iio/dds/adi,ad9832.yaml
> new file mode 100644
> index 000000000000..9f3e41cb0a0d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dds/adi,ad9832.yaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dds/adi,ad9832.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD9832 / AD9835 DDS
> +
> +maintainers:
> +  - Hungyu Lin <dennylin0707@gmail.com>
> +
> +description: |
> +  Binding for Analog Devices AD9832 and AD9835 SPI-controlled direct
> +  digital synthesizers (DDS). The devices use an external master clock
> +  and are controlled over a serial SPI-compatible interface.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad9832
> +      - adi,ad9835
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 20000000
> +
> +  spi-cpol: true
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      External master clock input.
> +
> +  clock-names:
> +    const: mclk

Do we need to name it if there is only one?

> +
> +  avdd-supply:
> +    description:
> +      Analog power supply.
> +
> +  dvdd-supply:
> +    description:
> +      Digital power supply.
Personally I'd not bother with the descriptions as
avdd is always analog supply and where you have one of those
dvdd is the digital one.  Absolutely fine to have

   avdd-supply: true
   dvdd-supply: true

And no more info about htem.

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - avdd-supply
> +  - dvdd-supply
> +  - spi-cpol
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    mclk: clock {
> +      compatible = "fixed-clock";
> +      #clock-cells = <0>;
> +      clock-frequency = <25000000>;
> +    };
> +
> +    vdd_3v3: regulator {
> +      compatible = "regulator-fixed";
> +      regulator-name = "vdd_3v3";
> +      regulator-min-microvolt = <3300000>;
> +      regulator-max-microvolt = <3300000>;
> +      regulator-always-on;
> +    };

See other binding examples. Normally we just refer to clocks
and regulators etc that are magically coming from somewhere outside
of the example snippet. So shouldn't need any of the stuff above here.

> +
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      dds@0 {
> +        compatible = "adi,ad9832";
> +        reg = <0>;
> +        spi-max-frequency = <20000000>;
> +        spi-cpol;
> +        clocks = <&mclk>;
> +        clock-names = "mclk";
> +        avdd-supply = <&vdd_3v3>;
> +        dvdd-supply = <&vdd_3v3>;
> +      };
> +    };

