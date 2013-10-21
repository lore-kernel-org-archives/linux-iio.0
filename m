Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:38192 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753154Ab3JULQm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 Oct 2013 07:16:42 -0400
Date: Mon, 21 Oct 2013 12:16:32 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Lukasz Czerwinski <l.czerwinski@samsung.com>
Cc: "jic23@cam.ac.uk" <jic23@cam.ac.uk>,
	"denis.ciocca@st.com" <denis.ciocca@st.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"lee.jones@linaro.org" <lee.jones@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RFC v2 PATCH 11/14] Documentation: Add st_magn binding
 documentation
Message-ID: <20131021111631.GB8144@kartoffel>
References: <1380299538-22047-1-git-send-email-l.czerwinski@samsung.com>
 <1380299538-22047-12-git-send-email-l.czerwinski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1380299538-22047-12-git-send-email-l.czerwinski@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Sep 27, 2013 at 05:32:15PM +0100, Lukasz Czerwinski wrote:
> This patch adds the document for STMicroeletronics Magnetic Sensors driver under
> Documentation/devicetree/bindings/iio/.
> 
> Signed-off-by: Lukasz Czerwinski <l.czerwinski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  .../bindings/iio/magnetometer/st_magnometer.txt    |   33 ++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/st_magnometer.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/st_magnometer.txt b/Documentation/devicetree/bindings/iio/magnetometer/st_magnometer.txt
> new file mode 100644
> index 0000000..fb4f473
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/st_magnometer.txt
> @@ -0,0 +1,33 @@
> +STMicroelectronics Magnetic Sensors
> +
> +Required properties:
> +
> +  - compatible : value should be one of the following:

s/should be/should contain/ -- we might have a future variant that's compatible.

> +	(a) "st,lsm303dlhc" for magnetometer in LSM330DLHC
> +	(b) "st,lsm303dlm" for magnetometer in LIS3DH
> +	(c) "st,lis3mdl" for magnetometer in LSM330

I'd drop the (a), (b), (c) here, it'll just make it more painful to add future
variants. It's probably better to use "*" instead.

> +
> +  - reg : the I2C address of the magnetometer
> +
> +Optional properties:
> +
> +  - st,drdy-int-pin : redirect DRDY on pin INT1 (1) or pin INT2 (2) (u8)

Could you elaborate on this?

What does this property mena?

What values are valid?

> +
> +  - interrupts : Interrupt numbers for the ST accelerometers, as an array
> +	in case the magnetometer have more interrupt lines:
> +	<DataReady irq>,
> +	<Event irq>;
> +
> +  - interrupt-names : Array of strings associated with the interrupt numbers

Nit: Interrupts are described by interrupt-specifiers.

Please describe the names explicitly, otherwise there's no point having them at
all, as no-one knows what they are...

How about something like:

- interrupts: a list of interrupt-specifiers, one for each entry in interrupt-names
- interrupt names: a list of strings. Should contain
  * "drdy" for the ???? interrupt
  * "event" for the ???? interrupt


> +
> +Example:
> +
> +lis3mdl@1c {
> +	compatible = "st,lis3mdl";
> +	reg = <0x1C>;
> +
> +	st,drdy-int-pin = /bits/ 8 <1>;

The use of /bits/ is remarkably uncommon, why do you need it here?

Thanks,
Mark.

> +	interrupt-parent = <&gpf0>;
> +	interrupts = <5 0>, <6 0>;
> +	interrupt-names = "drdy-int", "event-int";
> +};
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
