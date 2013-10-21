Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:38243 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753154Ab3JULTW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 Oct 2013 07:19:22 -0400
Date: Mon, 21 Oct 2013 12:19:14 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Lukasz Czerwinski <l.czerwinski@samsung.com>
Cc: "jic23@cam.ac.uk" <jic23@cam.ac.uk>,
	"denis.ciocca@st.com" <denis.ciocca@st.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"lee.jones@linaro.org" <lee.jones@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RFC v2 PATCH 12/14] Documentation: Add st_gyro binding
 documentation
Message-ID: <20131021111914.GC8144@kartoffel>
References: <1380299538-22047-1-git-send-email-l.czerwinski@samsung.com>
 <1380299538-22047-13-git-send-email-l.czerwinski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1380299538-22047-13-git-send-email-l.czerwinski@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Sep 27, 2013 at 05:32:16PM +0100, Lukasz Czerwinski wrote:
> This patch adds the document for STMicroeletronics Angular Velocity Sensors
> driver under Documentation/devicetree/bindings/iio/.
> 
> Signed-off-by: Lukasz Czerwinski <l.czerwinski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  .../bindings/iio/gyroscope/st_gyroscope.txt        |   38 ++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/st_gyroscope.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/gyroscope/st_gyroscope.txt b/Documentation/devicetree/bindings/iio/gyroscope/st_gyroscope.txt
> new file mode 100644
> index 0000000..8a6a9be
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/gyroscope/st_gyroscope.txt
> @@ -0,0 +1,38 @@
> +STMicroelectronics Angular Velocity  Sensors
> +
> +Required properties:
> +
> +  - compatible : value should be one of the following:
> +	(a) "st,l3g4200d" for gyroscope in L3G4200D
> +	(b) "st,lsm330d-gyro" for gyroscope in LSM330D
> +	(c) "st,lsm330dl-gyro" for gyroscope in LSM330DL
> +	(d) "st,lsm330dlc-gyro" for gyroscope in LSM330DLC
> +	(e) "st,l3gd20" for gyroscope in L3GD20
> +	(f) "st,l3gd20h" for gyroscope in L3GD20H
> +	(g) "st,l3g4is-ui" for gyroscope in L3G4IS
> +	(h) "st,lsm330-gyro" for gyroscope in LSM330
> +
> +  - reg : the I2C address of the gyroscope
> +
> +Optional properties:
> +
> +  - st,drdy-int-pin : redirect DRDY on pin INT1 (1) or pin INT2 (2) (u8)
> +
> +  - interrupts : Interrupt numbers for the ST gyroscopes, as an array
> +	in case the gyroscope have more interrupt lines:
> +	<DataReady irq>,
> +	<Event irq>;
> +
> +  - interrupt-names : Array of strings associated with the interrupt numbers

All my comments from patch 11 apply here too.

Mark.
