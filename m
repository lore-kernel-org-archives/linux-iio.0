Return-Path: <mark.rutland@arm.com>
Date: Wed, 21 Aug 2013 11:09:20 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
   "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
   "jic23@kernel.org" <jic23@kernel.org>,
   "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>,
   "s.nawrocki@samsung.com" <s.nawrocki@samsung.com>,
   "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
   Pawel Moll <Pawel.Moll@arm.com>,
   "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
   "ian.campbell@citrix.com" <ian.campbell@citrix.com>
Subject: Re: [PATCH/RFC v5 1/2] DT: Add documentation for gp2ap020a00f
 sensor
Message-ID: <20130821100920.GA4278@e106331-lin.cambridge.arm.com>
References: <1377010033-5190-1-git-send-email-j.anaszewski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1377010033-5190-1-git-send-email-j.anaszewski@samsung.com>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Aug 20, 2013 at 03:47:13PM +0100, Jacek Anaszewski wrote:
> This patch adds device tree binding documentation
> for the gp2ap020a00f proximity/als sensor.
> 
> Signed-off-by: Jacek Anaszewski <j.anaszewski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  .../devicetree/bindings/iio/light/gp2ap020a00f.txt |   17 +++++++++++++++++
>  1 files changed, 17 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt b/Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt
> new file mode 100644
> index 0000000..a92fccd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt
> @@ -0,0 +1,17 @@
> +* Sharp GP2AP020A00F I2C Proximity/ALS sensor
> +
> +Required properties:
> +
> +  - compatible : should be "sharp,gp2ap020a00f"
> +  - reg : the I2C slave address of the light sensor
> +  - interrupts : should be interrupt line number the INT pin is routed to

Nit: DT talks in terms of "interrupt specifiers", which are
interrupt-controller specific descriptions of interrupts. This could be
reworded as:

 - interrupts : an interrupt specifier for the sole interrupt generated
                by the device

> +  - vled-supply : VLED power supply, as covered in ../regulator/regulator.txt

You don't seem to have mentioned this is part of the unit, as discussed
last time [1]. As not all light sensors have embedded LEDs, for clarity
it would be worth mentioning that this is part of the unit.

Thanks,
Mark.

[1] http://marc.info/?l=linux-iio&m=137707379614385&w=2
