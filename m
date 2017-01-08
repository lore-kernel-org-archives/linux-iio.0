Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43276 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162797AbdAHKbY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2017 05:31:24 -0500
Subject: Re: [PATCH v7 11/12] dt-bindings: mux-adg792a: document devicetree
 bindings for ADG792A/G mux
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
References: <1483532187-28494-1-git-send-email-peda@axentia.se>
 <1483532187-28494-12-git-send-email-peda@axentia.se>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-doc@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <05bcf023-f05e-5cdf-d812-f1e7f3bdd909@kernel.org>
Date: Sun, 8 Jan 2017 10:31:21 +0000
MIME-Version: 1.0
In-Reply-To: <1483532187-28494-12-git-send-email-peda@axentia.se>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/01/17 12:16, Peter Rosin wrote:
> Analog Devices ADG792A/G is a triple 4:1 mux.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
I think this is about as neat as we can make it.

Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  .../devicetree/bindings/mux/mux-adg792a.txt        | 79 ++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mux/mux-adg792a.txt
> 
> diff --git a/Documentation/devicetree/bindings/mux/mux-adg792a.txt b/Documentation/devicetree/bindings/mux/mux-adg792a.txt
> new file mode 100644
> index 000000000000..0b26dd11f070
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mux/mux-adg792a.txt
> @@ -0,0 +1,79 @@
> +Bindings for Analog Devices ADG792A/G Triple 4:1 Multiplexers
> +
> +Required properties:
> +- compatible : "adi,adg792a" or "adi,adg792g"
> +- #mux-control-cells : <0> if parallel, or <1> if not.
> +* Standard mux-controller bindings as decribed in mux-controller.txt
> +
> +Optional properties for ADG792G:
> +- gpio-controller : if present, #gpio-cells below is required.
> +- #gpio-cells : should be <2>
> +			  - First cell is the GPO line number, i.e. 0 or 1
> +			  - Second cell is used to specify active high (0)
> +			    or active low (1)
> +
> +Optional properties:
> +- adi,parallel : if present, the three muxes are bound together with a single
> +  mux controller, controlling all three muxes in parallel.
> +- adi,idle-state : if present, array of 2-tuples with mux controller number
> +  and state that mux controllers will have when idle. States 0 through 3
> +  correspond to signals A through D in the datasheet.
> +- adi,idle-high-impedance : if present, array of mux controller numbers that
> +  should be in the disconnected high-impedance state when idle.
> +
> +Mux controller states 0 through 3 correspond to signals A through D in the
> +datasheet. If a mux controller is mentioned in neither adi,idle-state nor
> +adi,idle-high-impedance it is left in its previously selected state when idle.
> +
> +Example:
> +
> +	/*
> +	 * Three independent mux controllers (of which one is used).
> +	 * Mux 0 is disconnected when idle, mux 1 idles with signal C
> +	 * and mux 2 idles with signal A.
> +	 */
> +	&i2c0 {
> +		mux: adg792a@50 {
> +			compatible = "adi,adg792a";
> +			reg = <0x50>;
> +			#mux-control-cells = <1>;
> +
> +			adi,idle-high-impedance = <0>;
> +			adi,idle-state = <1 2>, <2 0>;
> +		};
> +	};
> +
> +	adc-mux {
> +		compatible = "io-channel-mux";
> +		io-channels = <&adc 0>;
> +		io-channel-names = "parent";
> +
> +		mux-controls = <&mux 1>;
> +
> +		channels = "sync-1", "", "out";
> +	};
> +
> +
> +	/*
> +	 * Three parallel muxes with one mux controller, useful e.g. if
> +	 * the adc is differential, thus needing two signals to be muxed
> +	 * simultaneously for correct operation.
> +	 */
> +	&i2c0 {
> +		pmux: adg792a@50 {
> +			compatible = "adi,adg792a";
> +			reg = <0x50>;
> +			#mux-control-cells = <0>;
> +			adi,parallel;
> +		};
> +	};
> +
> +	diff-adc-mux {
> +		compatible = "io-channel-mux";
> +		io-channels = <&adc 0>;
> +		io-channel-names = "parent";
> +
> +		mux-controls = <&pmux>;
> +
> +		channels = "sync-1", "", "out";
> +	};
> 

