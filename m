Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58267 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578AbcGCNn7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jul 2016 09:43:59 -0400
Subject: Re: [PATCH 1/2] input: adc-keys: add DT binding documentation
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <1467408602-16546-1-git-send-email-alexandre.belloni@free-electrons.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5d71d3a2-4d51-8dd5-0e4a-638ec1b5035a@kernel.org>
Date: Sun, 3 Jul 2016 14:43:56 +0100
MIME-Version: 1.0
In-Reply-To: <1467408602-16546-1-git-send-email-alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/07/16 22:30, Alexandre Belloni wrote:
> Add documentation for ADC keys
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Clean looking binding to me - one comment inline.

Jonathan
> ---
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> 
>  .../devicetree/bindings/input/adc-keys.txt         | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/adc-keys.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/adc-keys.txt b/Documentation/devicetree/bindings/input/adc-keys.txt
> new file mode 100644
> index 000000000000..873476bb4eab
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/adc-keys.txt
> @@ -0,0 +1,45 @@
> +Allwinner sun4i low res adc attached tablet keys
What is allwinner specific in here?  Looks pretty general purpose to me!
> +------------------------------------------------
> +
> +Required properties:
> + - compatible: "adc-keys"
> + - io-channels: Phandle to an ADC channel
> + - io-channel-names = "buttons";
> + - voltage-keyup-mvolt: Voltage at which all the keys are considered up.
> +
> +Each key is represented as a sub-node of "adc-keys":
> +
> +Required subnode-properties:
> +	- label: Descriptive name of the key.
> +	- linux,code: Keycode to emit.
> +	- voltage-mvolt: Voltage adc input when this key is pressed.
> +
> +Example:
> +
> +#include <dt-bindings/input/input.h>
> +
> +	adc-keys {
> +		compatible = "adc-keys";
> +		io-channels = <&lradc 0>;
> +		io-channel-names = "buttons";
> +		voltage-keyup-mvolt = <2000>;
> +
> +		button@1500 {
> +			label = "Volume Up";
> +			linux,code = <KEY_VOLUMEUP>;
> +			voltage-mvolt = <1500>;
> +		};
> +
> +		button@1000 {
> +			label = "Volume Down";
> +			linux,code = <KEY_VOLUMEDOWN>;
> +			voltage-mvolt = <1000>;
> +		};
> +
> +		button@500 {
> +			label = "Enter";
> +			linux,code = <KEY_ENTER>;
> +			voltage-mvolt = <500>;
> +		};
> +	};
> +
> 

