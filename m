Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44929 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbcJAOwx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Oct 2016 10:52:53 -0400
Subject: Re: [PATCH 2/2] Documentation: dt: iio: humidity: add hts221 sensor
 device binding
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
References: <1474919741-21316-1-git-send-email-lorenzo.bianconi@st.com>
 <1474919741-21316-3-git-send-email-lorenzo.bianconi@st.com>
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <01eba341-2323-52c9-cb86-32da09526a36@kernel.org>
Date: Sat, 1 Oct 2016 15:52:52 +0100
MIME-Version: 1.0
In-Reply-To: <1474919741-21316-3-git-send-email-lorenzo.bianconi@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/09/16 20:55, Lorenzo Bianconi wrote:
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Please cc the device tree list and maintainers on the next version.
This is simple enough I 'can' take it without their Ack, but
nice to keep them informed.

Jonathan
> ---
>  .../devicetree/bindings/iio/humidity/hts221.txt       | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/humidity/hts221.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/humidity/hts221.txt b/Documentation/devicetree/bindings/iio/humidity/hts221.txt
> new file mode 100644
> index 0000000..46a152c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/humidity/hts221.txt
> @@ -0,0 +1,19 @@
> +* HTS221 STM humidity + temperature sensor
> +
> +Required properties:
> +- compatible: should be "st,hts221"
> +- reg: i2c address of the sensor / spi cs line
> +
> +Optional properties:
> +- interrupts: interrupt mapping for GPIO IRQ. It should be configured with
> +	      flags IRQ_TYPE_LEVEL_HIGH or IRQ_TYPE_EDGE_RISING
> +- interrupt-parent: should be the phandle for the interrupt controller
> +
> +Example:
> +
> +hts221@5f {
> +	compatible = "st,hts221";
> +	reg = <0x5f>;
> +	interrupt-parent = <&gpio0>;
> +	interrupts = <0 IRQ_TYPE_EDGE_RISING>;
> +};
> 

