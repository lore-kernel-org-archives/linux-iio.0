Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51263 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752113AbdANMmO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Jan 2017 07:42:14 -0500
Subject: Re: [PATCH v4 2/2] Documentation: dt: iio: add st_lsm6dsx sensor
 device binding
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
References: <20170110215519.960-1-lorenzo.bianconi@st.com>
 <20170110215519.960-3-lorenzo.bianconi@st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <071c951f-120c-7192-3aab-64f51d425f63@kernel.org>
Date: Sat, 14 Jan 2017 12:42:12 +0000
MIME-Version: 1.0
In-Reply-To: <20170110215519.960-3-lorenzo.bianconi@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/01/17 21:55, Lorenzo Bianconi wrote:
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Applied.

Thanks,

Jonathan
> ---
>  .../devicetree/bindings/iio/imu/st_lsm6dsx.txt     | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> new file mode 100644
> index 0000000..ed3cdac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> @@ -0,0 +1,24 @@
> +* ST_LSM6DSx driver for STM 6-axis (acc + gyro) imu Mems sensors
> +
> +Required properties:
> +- compatible: must be one of:
> +  "st,lsm6ds3"
> +  "st,lsm6dsm"
> +- reg: i2c address of the sensor / spi cs line
> +
> +Optional properties:
> +- interrupt-parent: should be the phandle for the interrupt controller
> +- interrupts: interrupt mapping for IRQ. It should be configured with
> +  flags IRQ_TYPE_LEVEL_HIGH or IRQ_TYPE_EDGE_RISING.
> +
> +  Refer to interrupt-controller/interrupts.txt for generic interrupt
> +  client node bindings.
> +
> +Example:
> +
> +lsm6dsm@6b {
> +	compatible = "st,lsm6dsm";
> +	reg = <0x6b>;
> +	interrupt-parent = <&gpio0>;
> +	interrupts = <0 IRQ_TYPE_EDGE_RISING>;
> +};
> 

