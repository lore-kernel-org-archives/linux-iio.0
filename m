Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39803 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753629AbcJIKcl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Oct 2016 06:32:41 -0400
Subject: Re: [PATCH v3 2/2] Documentation: dt: iio: humidity: add hts221
 sensor device binding
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
References: <1475912752-6444-1-git-send-email-lorenzo.bianconi@st.com>
 <1475912752-6444-3-git-send-email-lorenzo.bianconi@st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <975bb745-cf11-1c6c-aa73-71e00bf1a42b@kernel.org>
Date: Sun, 9 Oct 2016 11:32:39 +0100
MIME-Version: 1.0
In-Reply-To: <1475912752-6444-3-git-send-email-lorenzo.bianconi@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/10/16 08:45, Lorenzo Bianconi wrote:
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
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
It might not be a gpio irq.  Plenty of IRQ only chips out there that you can't
use for general purpose reading (you can't explicitly read their state).

> +- interrupt-parent: should be the phandle for the interrupt controller
Convention here is to add a cross reference to the main interrupt docs.
We have been a bit lax on this in some IIO drivers but might as well be
good with a new one.

Otherwise this looks good to me.

Thanks,

Jonathan
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

