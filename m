Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EFB4A3407;
	Thu, 24 Sep 2026 21:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790285153; cv=none; b=MLhGH5+YxHWO37tc9eovH/UYPCPmhEfOXGsKsRCTj4eyLrD701V/+wVfydkzx/ue/H6Prb0IhfzbkH2GvZS85mLzkfKxFnAdQ7/rVzoAi97DwV+BYihLYbENf5qINWnv5JG2W6i9uCepKoN3JrbVIQA0zDb7piyrWdejR62mR9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790285153; c=relaxed/simple;
	bh=vDvLYTI6tnYf3H2oS1lnjDD6CnfX1bxlGEfbPqjB158=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExMdA8WJpanK7uX7D4Y8Uju7Kxn0VZ6Q+Xkof23jw6xDmXKGa+Cjpfj/MJxKCGecsp+9i1f16uSgCxLPSmAMhk/+3gfnYQQ/CcqYIx3reM5jo8KvsCwu1uuPYVpzr3QMMjmtuHbyunuwns8oS5Dye/x/5OIvBMPAjtQlCFV5YeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeD8V6X3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeD8V6X3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3E91F000FF;
	Thu, 24 Sep 2026 21:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790285148;
	bh=Bq+vpYLOEWURPyiEZ/CsTCJauh1Qbcp+tLVo7e431Oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CeD8V6X3U0SPJAdRZDCPsuo374AWmMX5ifcGdK/VX0pcSB35Ag/YaaKg/hieSPoE1
	 dK3zk/sVdgyeWzOxWtuSxbAPu6wPyRV6Y6fsHLM/uRnE6hsL9hGUvRR7DavUMVdaos
	 JCIt67/dfhWOMQeWeZHkNQe8rr0w7EFi1migb773AmCKfc+CobUs9SFuO2NsP5l74S
	 1YBB3Bo6pu8EelkQS10Rq3DSSF79TOGwBc4VDM4hc65dimMaNA9NK4nQ8oTLp+1b4d
	 cJ0Jwe3KexxuEaQ3jj/fNHFaCRAkJsadNbU5WWHZtuM95NMzr9OcumtL+Uw/9mitte
	 o/Z6jTG00f2wA==
Date: Thu, 24 Sep 2026 16:25:46 -0500
From: Rob Herring <robh@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com, jic23@kernel.org,
	nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org,
	Michael.Hennerich@analog.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2 13/15] dt-bindings: iio: adc: adi,ad4134: Add high
 data throughput example
Message-ID: <20260924212546.GA1805605-robh@kernel.org>
References: <cover.1789494473.git.marcelo.schmitt@analog.com>
 <958894021cf7bd3012567d1dfabd7f2008fe8d31.1789494473.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <958894021cf7bd3012567d1dfabd7f2008fe8d31.1789494473.git.marcelo.schmitt@analog.com>

On Tue, Sep 15, 2026 at 04:16:06PM -0300, Marcelo Schmitt wrote:
> Add device tree example for AD4134 operation in 4-wire SPI mode with 4
> lines to transfer data samples to the host controller.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> No changes since v1.
> 
>  .../bindings/iio/adc/adi,ad4134.yaml          | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> index ad67d1cdacec..133996917ee2 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> @@ -243,4 +243,46 @@ examples:
>  
>          };
>      };
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    ad4134_sdo_dout0_mux: mux-controller {
> +        compatible = "gpio-mux";
> +        #mux-state-cells = <1>;
> +        mux-gpios = <&gpio0 100 GPIO_ACTIVE_HIGH>;
> +    };

Drop. We don't put providers in examples.

> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "adi,ad4134";
> +            reg = <0>;
> +
> +            spi-max-frequency = <1000000>;
> +            spi-rx-bus-width = <1>, <1>, <1>, <1>; /* 4 lanes of 1 bit each */
> +
> +            pwms = <&ad4134_odr_generator 1 1000000 0>;
> +            reset-gpios = <&gpio0 86 GPIO_ACTIVE_LOW>;
> +            odr-gpios = <&gpio0 87 GPIO_ACTIVE_HIGH>;
> +            powerdown-gpios = <&gpio0 88 GPIO_ACTIVE_LOW>;
> +
> +            clocks = <&sys_clk>;
> +            clock-names = "clkin";
> +
> +            avdd5-supply = <&avdd5>;
> +            dvdd5-supply = <&dvdd5>;
> +            iovdd-supply = <&iovdd>;
> +            refin-supply = <&refin>;
> +            avdd1v8-supply = <&avdd1v8>;
> +            dvdd1v8-supply = <&dvdd1v8>;
> +            clkvdd-supply = <&clkvdd>;
> +
> +            mux-states = <&ad4134_sdo_dout0_mux 0>, <&ad4134_sdo_dout0_mux 1>;
> +            mux-state-names = "data_read", "reg_access";
> +
> +            adi,spi-mode = "4-wire";
> +        };
> +    };
>  ...
> -- 
> 2.53.0
> 
