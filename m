Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:35664 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753768AbaKMOhl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 13 Nov 2014 09:37:41 -0500
MIME-Version: 1.0
In-Reply-To: <1415888044-16635-3-git-send-email-ezequiel.garcia@imgtec.com>
References: <1415888044-16635-1-git-send-email-ezequiel.garcia@imgtec.com> <1415888044-16635-3-git-send-email-ezequiel.garcia@imgtec.com>
From: Rob Herring <robherring2@gmail.com>
Date: Thu, 13 Nov 2014 08:37:19 -0600
Message-ID: <CAL_JsqK=F36EweJyWKemYn=5TbzKWv3xLFfhbfQ1bvQKR6tQLQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] DT: iio: adc: Add CC_10001 binding documentation
To: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc: Andrew Bresticker <abrestic@chromium.org>,
	James Hartley <james.hartley@imgtec.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, Naidu.Tellapati@imgtec.com,
	Phani Movva <Phani.Movva@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Nov 13, 2014 at 8:13 AM, Ezequiel Garcia
<ezequiel.garcia@imgtec.com> wrote:
> From: Phani Movva <Phani.Movva@imgtec.com>
>
> Add the devicetree binding document for Cosmic Circuits 10001 ADC device.
>
> Signed-off-by: Phani Movva <Phani.Movva@imgtec.com>
> Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
> [Ezequiel: minor style cleaning]
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> ---
>  .../devicetree/bindings/iio/adc/cc10001_adc.txt    | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/cc10001_adc.txt
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/cc10001_adc.txt b/Documentation/devicetree/bindings/iio/adc/cc10001_adc.txt
> new file mode 100644
> index 0000000..1533c19
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/cc10001_adc.txt
> @@ -0,0 +1,22 @@
> +* Cosmic Circuits - Analog to Digital Converter (CC-10001-ADC)
> +
> +Required properties:
> +  - compatible: Should be "cosmic,10001-adc"
> +  - reg: Should contain adc registers location and length.
> +  - clock-names: Should contain "adc".
> +  - clocks: phandles to input clocks.

You need to be explicit about how many clocks and their order. From
the names, I'm guessing it is only 1.

> +  - vref-supply: The regulator supply ADC reference voltage.
> +
> +Optional properties:
> +  - cosmic,adc-reserved-channels: Bitmask of reserved channels,
> +    i.e. channels that cannot be used by the OS.
> +
> +Example:
> +adc: adc@18101600 {
> +       compatible = "cosmic,10001-adc";
> +       reg = <0x18101600 0x24>;
> +       cosmic,adc-reserved-channels = <0x2>;
> +       clocks = <&adc_clk>;
> +       clock-names = "adc";
> +       vref-supply = <&reg_1v8>;
> +};
> --
> 2.1.0
>
