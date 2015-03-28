Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60515 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207AbbC1OD0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2015 10:03:26 -0400
Message-ID: <5516B4AB.1090805@kernel.org>
Date: Sat, 28 Mar 2015 14:03:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Andrew Bresticker <abrestic@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH 1/2] Input: Add binding document for a generic ADC keypad
References: <1427503398-19682-1-git-send-email-abrestic@chromium.org>
In-Reply-To: <1427503398-19682-1-git-send-email-abrestic@chromium.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/03/15 00:43, Andrew Bresticker wrote:
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

Just thinking about this, what options do we have for how such a keypad might
be wired.  The interesting cases are the more than one key at a time ones.

If that happens, then we end up with a voltage that should allow us to 
work out which combination of keys is pressed.

http://en.wikipedia.org/wiki/Resistor_ladder

The binding as it stands only works for single keys being pressed at a time
(I think!)

Do we want to make it flexible enough to cope with multiple keys?
I guess we'd need to model the common resistor ladder forms and provide
a way of specifying the different setups in the device tree.

J
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
> 

