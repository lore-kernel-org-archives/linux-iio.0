Return-Path: <SRS0=vxmK=26=pmeerw.net=pmeerw@kernel.org>
Date: Tue, 21 Mar 2017 22:16:10 +0100 (CET)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Rick Altherr <raltherr@google.com>
cc: openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
    linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
    Lars-Peter Clausen <lars@metafoo.de>, Mark Rutland <mark.rutland@arm.com>,
    Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 1/2] Documentation: dt-bindings: Document bindings
 for Aspeed AST2400/AST2500 ADC
In-Reply-To: <20170321204828.31303-1-raltherr@google.com>
Message-ID: <alpine.DEB.2.20.1703212215100.26011@vps.pmeerw.net>
References: <20170321204828.31303-1-raltherr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


> Signed-off-by: Rick Altherr <raltherr@google.com>

extreme nitpicking below

 ---
> 
> Changes in v2:
> - Rewritten as an IIO ADC device
> 
>  .../devicetree/bindings/iio/adc/aspeed_adc.txt       | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt b/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt
> new file mode 100644
> index 000000000000..7748c2c2ad0c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt
> @@ -0,0 +1,20 @@
> +Aspeed AST2400/2500 ADC
> +
> +This device is a 10-bit converter for 16 voltage channels.  All inputs are
> +single ended.
> +
> +Required properties:
> +- compatible: Should be "aspeed,ast2400-adc" or "aspeed,ast2500-adc"
> +- reg: memory window mapping address and length
> +- clocks: Input clock used to derive the sample clock. Expected to be the
> +          SoC's APB clock.
> +- #io-channel-cells: Must be set to <1> to indicate channels are selected
> +                     by index.
> +
> +Example:
> +	adc@1e6e9000 {
> +		compatible = "aspeed,ast2400-adc";
> +		reg = <0x1e6e9000 0xB0>;

maybe 0xb0 (consistent lowercase hex)?

> +		clocks = <&clk_apb>;
> +		#io-channel-cells = <1>;
> +	};
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
