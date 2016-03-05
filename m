Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48701 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760470AbcCEE36 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 4 Mar 2016 23:29:58 -0500
Date: Fri, 4 Mar 2016 22:29:52 -0600
From: Rob Herring <robh@kernel.org>
To: michael.hennerich@analog.com
Cc: jic23@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com,
	lars@metafoo.de, knaack.h@gmx.de, paul.cercueil@analog.com,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3] iio: dac: Add support for the AD5592R/AD5593R
 ADCs/DACs
Message-ID: <20160305042952.GA13525@rob-hp-laptop>
References: <1457009883-4017-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457009883-4017-1-git-send-email-michael.hennerich@analog.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Mar 03, 2016 at 01:58:03PM +0100, michael.hennerich@analog.com wrote:
> From: Paul Cercueil <paul.cercueil@analog.com>
> 
> This patch adds support for the AD5592R (spi) and AD5593R (i2c)
> ADC/DAC devices.
> 
> Signed-off-by: Paul Cercueil <paul.cercueil@analog.com>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>

[...]

> +AD5592R Example:
> +
> +	#include <dt-bindings/iio/adi,ad5592r.h>
> +
> +	vref: regulator-vref {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vref-ad559x";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
> +
> +	ad5592r@0 {
> +		#size-cells = <0>;
> +		#address-cells = <1>;
> +		compatible = "adi,ad5592r";
> +		reg = <0>;
> +		spi-max-frequency = <1000000>;
> +		spi-cpol;
> +
> +		vref-supply = <&vref>; /* optional */
> +		reset-gpios = <&gpio0 86 0>;  /* optional */
> +
> +		channel@0 {
> +			reg = <0>;
> +			mode = <CH_MODE_DAC>;

You are missing the vendor prefixes thoughout.
