Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752451AbdGIRUY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Jul 2017 13:20:24 -0400
Date: Sun, 9 Jul 2017 18:20:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/9] staging: iio: tsl2x7x: add device tree
 documentation
Message-ID: <20170709182022.78f9c422@kernel.org>
In-Reply-To: <20170706225626.6716-3-masneyb@onstation.org>
References: <20170706225626.6716-1-masneyb@onstation.org>
        <20170706225626.6716-3-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu,  6 Jul 2017 18:56:19 -0400
Brian Masney <masneyb@onstation.org> wrote:

> Add device tree documentation for the tsl2x7x IIO driver.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: devicetree@vger.kernel.org
For what it's worth given the simplicity of the patch

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Documentation/devicetree/bindings/trivial-devices.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
> index 35f406d..0e6e953 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/trivial-devices.txt
> @@ -21,6 +21,16 @@ adi,adt7490		+/-1C TDM Extended Temp Range I.C
>  adi,adxl345		Three-Axis Digital Accelerometer
>  adi,adxl346		Three-Axis Digital Accelerometer (backward-compatibility value "adi,adxl345" must be listed too)
>  ams,iaq-core		AMS iAQ-Core VOC Sensor
> +amstaos,tsl2571		AMS/TAOS ALS and proximity sensor
> +amstaos,tsl2671		AMS/TAOS ALS and proximity sensor
> +amstaos,tmd2671		AMS/TAOS ALS and proximity sensor
> +amstaos,tsl2771		AMS/TAOS ALS and proximity sensor
> +amstaos,tmd2771		AMS/TAOS ALS and proximity sensor
> +amstaos,tsl2572		AMS/TAOS ALS and proximity sensor
> +amstaos,tsl2672		AMS/TAOS ALS and proximity sensor
> +amstaos,tmd2672		AMS/TAOS ALS and proximity sensor
> +amstaos,tsl2772		AMS/TAOS ALS and proximity sensor
> +amstaos,tmd2772		AMS/TAOS ALS and proximity sensor
>  at,24c08		i2c serial eeprom  (24cxx)
>  atmel,at97sc3204t	i2c trusted platform module (TPM)
>  capella,cm32181		CM32181: Ambient Light Sensor

