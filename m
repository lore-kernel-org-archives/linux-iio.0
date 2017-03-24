Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:36795 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751926AbdCXPMi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Mar 2017 11:12:38 -0400
Date: Fri, 24 Mar 2017 10:12:35 -0500
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/5] iio: xoadc: augment DT bindings a bit
Message-ID: <20170324151235.cb73gokg26qy7fvc@rob-hp-laptop>
References: <20170318133358.22314-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170318133358.22314-1-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Mar 18, 2017 at 02:33:58PM +0100, Linus Walleij wrote:
> In order to accommodate in a logical manner for the premuxed channels
> in PM8921 and the similarly addressed channels in later PMICs, we
> need a twocell arrangement with premux and analog mux setting as
> a tuple to uniquely identify a hardware channel.
> 
> These bindings are not yet in use, so it should be find to augment
> them before we actually start using it in drivers and device trees.
> 
> This scheme came out of lengthy discussions and reverse-engineering
> and reading of the few information sources we have.
> 
> Suggested-by: Björn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/iio/adc/qcom,pm8xxx-xoadc.txt         | 117 ++++++++++++---------
>  1 file changed, 69 insertions(+), 48 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,pm8xxx-xoadc.txt b/Documentation/devicetree/bindings/iio/adc/qcom,pm8xxx-xoadc.txt
> index 53cd146d8096..680bb7a29dd5 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,pm8xxx-xoadc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,pm8xxx-xoadc.txt
> @@ -19,32 +19,42 @@ Required properties:
>    with PMIC variant but is typically something like 2.2 or 1.8V.
>  
>  The following required properties are standard for IO channels, see
> -iio-bindings.txt for more details:
> +iio-bindings.txt for more details, but noitice that this particular
> +ADC has a special adressing scheme that require two cells for
> +identifying each ADC channel:
>  
> -- #address-cells: should be set to <1>
> +- #address-cells: should be set to <2>, the first cell is the
> +  prescaler (on PM8058) or premux (on PM8921) with two valid bits
> +  so legal values are 0x00, 0x01 or 0x02. The second cell
> +  is the main analog mux setting (0x00..0x0f). The combination
> +  of prescaler/premux and analog mux uniquely addresses a hardware
> +  channel on all systems.

64-bits to describe 48 possible combinations... I'd just combine these 
into 1 cell.

>  - #size-cells: should be set to <0>
>  
> -- #io-channel-cells: should be set to <1>
> +- #io-channel-cells: should be set to <2>, again the cells are
> +  precaler or premux followed by the analog muxing line.
>  
>  - interrupts: should refer to the parent PMIC interrupt controller
>    and reference the proper ADC interrupt.
>  
>  Required subnodes:
>  
> -The ADC channels are configured as subnodes of the ADC. Since some of
> -them are used for calibrating the ADC, these nodes are compulsory:
> +The ADC channels are configured as subnodes of the ADC.
>  
> -adc-channel@c {
> -	reg = <0x0c>;
> +Since some of them are used for calibrating the ADC, these nodes are
> +compulsory:
> +
> +adc-channel@0c {
> +	reg = <0x00 0x0c>;
>  };
>  
> -adc-channel@d {
> -	reg = <0x0d>;
> +adc-channel@0d {
> +	reg = <0x00 0x0d>;
>  };
>  
> -adc-channel@f {
> -	reg = <0x0f>;
> +adc-channel@0f {
> +	reg = <0x00 0x0f>;
>  };
>  
>  These three nodes are used for absolute and ratiometric calibration
> @@ -52,13 +62,26 @@ and only need to have these reg values: they are by hardware definition
>  1:1 ratio converters that sample 625, 1250 and 0 milliV and create
>  an interpolation calibration for all other ADCs.
>  
> -Optional subnodes: any channels other than channel 0x0c, 0x0d and
> -0x0f are optional.
> +Optional subnodes: any channels other than channels [0x00 0x0c],
> +[0x00 0x0d] and [0x00 0x0f] are optional.
>  
>  Required channel node properties:
>  
>  - reg: should contain the hardware channel number in the range
> -  0 .. 0x0f (4 bits). The hardware only supports 16 channels.
> +  0 .. 0xff (8 bits).
> +
> +  On PM8058 the hardware only supports 16 channels, but we get the same
> +  channels repeating with its input divided down by 1 or 3. Channels 00,
> +  10, 20, ... f0 are the raw values, 04, 14, 24 .. f4 are "unity" channels
> +  divided by 1, and 08, 18, 28 .. f8 are channels divided by 3. Bits 0
> +  and 1 of the channel index should always be 0.
> +
> +  On PM8921 the hardware supports more than 16 channels through a complex
> +  routing matrix using a premux, so 00, 10, 20 .. f0 are the basic raw
> +  channels while another set of channels appear for 04, 14, 24 .. f4,
> +  and again some of the same channels appear again divided down by 3
> +  in 08, 18, 28 .. f8. Again bits 0 and 1 of the channel index should
> +  always be 0.

Now I'm lost...

Rob
