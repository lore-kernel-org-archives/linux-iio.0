Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:32769 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751738AbdC2Cdr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Mar 2017 22:33:47 -0400
MIME-Version: 1.0
In-Reply-To: <20170328215259.31622-1-raltherr@google.com>
References: <20170328215259.31622-1-raltherr@google.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 29 Mar 2017 13:03:25 +1030
Message-ID: <CACPK8Xcf2A8RMy7cthJrdi2CA0L_Hfi+2Hy3JBCzLTsofjhEuA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] Documentation: dt-bindings: Document bindings for
 Aspeed ADC
To: Rick Altherr <raltherr@google.com>
Cc: OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Mar 29, 2017 at 8:22 AM, Rick Altherr <raltherr@google.com> wrote:
> Signed-off-by: Rick Altherr <raltherr@google.com>
> ---

Acked-by: Joel Stanley <joel@jms.id.au>

>
> Changes in v5: None
> Changes in v4: None
> Changes in v3:
> - Consistently write hex contstants with lowercase letters
> - Drop model numbers from description as same IP is used in every generation
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
> index 000000000000..674e133b7cd7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt
> @@ -0,0 +1,20 @@
> +Aspeed ADC
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
> +       adc@1e6e9000 {
> +               compatible = "aspeed,ast2400-adc";
> +               reg = <0x1e6e9000 0xb0>;
> +               clocks = <&clk_apb>;
> +               #io-channel-cells = <1>;
> +       };
> --
> 2.12.2.564.g063fe858b8-goog
>
