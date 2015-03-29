Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37143 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbbC2EA6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 Mar 2015 00:00:58 -0400
Date: Sat, 28 Mar 2015 21:00:53 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andrew Bresticker <abrestic@chromium.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH 1/2] Input: Add binding document for a generic ADC keypad
Message-ID: <20150329040053.GD36501@dtor-ws>
References: <1427503398-19682-1-git-send-email-abrestic@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427503398-19682-1-git-send-email-abrestic@chromium.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Mar 27, 2015 at 05:43:17PM -0700, Andrew Bresticker wrote:
> Add a binding document for a generic ADC keypad.  Buttons on an ADC
> keypad are connected in a resistor ladder to an ADC.  The binding
> describes the mapping of ADC channel and voltage ranges to buttons.
> 
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> ---
>  .../devicetree/bindings/input/adc-keys.txt         | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/adc-keys.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/adc-keys.txt b/Documentation/devicetree/bindings/input/adc-keys.txt
> new file mode 100644
> index 0000000..c9a57de
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/adc-keys.txt
> @@ -0,0 +1,43 @@
> +Generic ADC keypad
> +==================
> +
> +Required properties:
> + - compatible: "adc-keys"
> + - poll-interval: Polling interval time in ms.
> + - io-channels: List of IIO channels used by the keypad.
> +   See ../iio/iio-bindings.txt for details.
> +
> +Optional properties:
> + - autorepeat: Enable auto-repeat.
> +
> +Each button on the ADC keypad is represented by a sub-node.
> +
> +Required sub-node properties:
> + - label: Descriptive name for the key.
> + - linux,code: Keycode to emit.
> + - channel: IIO channel (index into the 'io-channels' above) to which this
> +   button is attached.
> + - min-voltage: Minimum voltage in uV when this key is pressed.
> + - max-voltage: Maximum voltage in uV when this key is pressed.
> +
> +Optional sub-node properties:
> + - linux,input-type: Event type this key generates.  Defaults to 1 (EV_KEY) if
> +   not specified.

I'd rather we have it defined explicitly in the binding, i.e. make it a
required property?

> +
> +Example:
> +
> +adc-keypad {
> +	compatible = "adc-keys";
> +	poll-interval = <100>;
> +	io-channels = <&adc 0>, <&adc 1>;
> +
> +	vol-up-button {
> +		label = "Volume Up";
> +		linux,code = <KEY_VOLUMEUP>;
> +		channel = <0>;
> +		min-voltage = <1600000>;
> +		max-voltage = <1640000>;
> +	};
> +
> +	...
> +};
> -- 
> 2.2.0.rc0.207.ga3a616c
> 

-- 
Dmitry
