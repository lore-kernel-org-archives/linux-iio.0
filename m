Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:32863 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbdA0TvT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Jan 2017 14:51:19 -0500
Date: Fri, 27 Jan 2017 13:50:54 -0600
From: Rob Herring <robh@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 09/12] dt-bindings: mux-adg792a: document devicetree
 bindings for ADG792A/G mux
Message-ID: <20170127195054.wupmfkiw6kaoc7jx@rob-hp-laptop>
References: <1484755035-25927-1-git-send-email-peda@axentia.se>
 <1484755035-25927-10-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484755035-25927-10-git-send-email-peda@axentia.se>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jan 18, 2017 at 04:57:12PM +0100, Peter Rosin wrote:
> Analog Devices ADG792A/G is a triple 4:1 mux.
> 
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Peter Rosin <peda@axentia.se>
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

Can't this be implied by #mux-control-cells == 0?

> +- adi,idle-state : if present, array of 2-tuples with mux controller number
> +  and state that mux controllers will have when idle. States 0 through 3
> +  correspond to signals A through D in the datasheet.
> +- adi,idle-high-impedance : if present, array of mux controller numbers that
> +  should be in the disconnected high-impedance state when idle.

Perhaps combine these 2 to a common idle-state with the index being the 
mux controller number and a value of -1 (or 4) being hi-Z.

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

mux-controller@50

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
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
