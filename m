Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:38306 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753126Ab3JULXI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 Oct 2013 07:23:08 -0400
Date: Mon, 21 Oct 2013 12:23:00 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Lukasz Czerwinski <l.czerwinski@samsung.com>
Cc: "jic23@cam.ac.uk" <jic23@cam.ac.uk>,
	"denis.ciocca@st.com" <denis.ciocca@st.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"lee.jones@linaro.org" <lee.jones@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RFC v2 PATCH 13/14] Documentation: Add st_pressure binding
 documentation
Message-ID: <20131021112300.GD8144@kartoffel>
References: <1380299538-22047-1-git-send-email-l.czerwinski@samsung.com>
 <1380299538-22047-14-git-send-email-l.czerwinski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1380299538-22047-14-git-send-email-l.czerwinski@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Sep 27, 2013 at 05:32:17PM +0100, Lukasz Czerwinski wrote:
> This patch adds the document for STMicroeletronics Pressure Sensors
> driver under Documentation/devicetree/bindings/iio/.
> 
> Signed-off-by: Lukasz Czerwinski <l.czerwinski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  .../bindings/iio/barometer/st_barometer.txt        |   38 ++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/barometer/st_barometer.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/barometer/st_barometer.txt b/Documentation/devicetree/bindings/iio/barometer/st_barometer.txt
> new file mode 100644
> index 0000000..5ce4bfa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/barometer/st_barometer.txt
> @@ -0,0 +1,38 @@
> +STMicroelectronics Pressure Sensors
> +
> +Required properties:
> +
> +  - compatible : value should be:
> +	(a) "st,lps331ap" for barometer in LPS331AP

When you say "for the barometer in LPS331AP", is the LPS331AP a multi function
device? Or only a barometer?

> +	(b) "st,lps001wp" for barometer in LPS001WP
> +
> +  - reg : the I2C address of the barometer
> +
> +Optional properties:
> +
> +  - st,drdy-int-pin : redirect DRDY on pin INT1 (1) or pin INT2 (2) (u8)
> +
> +  - interrupts : Interrupt numbers for the ST barometer, as an array
> +	in case the barometer have more interrupt lines:
> +	<DataReady irq>,
> +	<Event irq>;
> +
> +  - interrupt-names : Array of strings associated with the interrupt numbers

The comments from patch 11 apply here too.

> +
> +  - vdd-supply: Phandle to the Vdd supply regulator
> +
> +  - vddio-supply: Phandle to the Vdd-IO supply regulator

These seem fine.

Thanks,
Mark.
