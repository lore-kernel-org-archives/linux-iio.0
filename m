Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:34518 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbeKYTuS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Nov 2018 14:50:18 -0500
Date: Sun, 25 Nov 2018 08:59:39 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Tomasz Duszynski <tduszyns@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 3/3] iio: chemical: sps30: add device tree support
Message-ID: <20181125085939.421523d6@archlinux>
In-Reply-To: <20181124221415.10081-4-tduszyns@gmail.com>
References: <20181124221415.10081-1-tduszyns@gmail.com>
        <20181124221415.10081-4-tduszyns@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 24 Nov 2018 23:14:15 +0100
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> Add device tree support for Sensirion SPS30 particulate
> matter sensor.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
one comment inine, around the fact we are trying to move
to generic names in DT where ever possible.  Now we don't
have a suitable one (IIRC) yet so time to make one up ;)

+CC Rob for his input on that.
> ---
>  .../bindings/iio/chemical/sensirion,sps30.txt        | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt b/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt
> new file mode 100644
> index 000000000000..6eee2709b5b6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt
> @@ -0,0 +1,12 @@
> +* Sensirion SPS30 particulate matter sensor
> +
> +Required properties:
> +- compatible: must be "sensirion,sps30"
> +- reg: the I2C address of the sensor
> +
> +Example:
> +
> +sps30@69 {
We should define a generic type.  Rob, what would work for this
one?

particlesensor@69?

> +	compatible = "sensirion,sps30";
> +	reg = <0x69>;
> +};
