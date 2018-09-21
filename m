Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from anchovy2.45ru.net.au ([203.30.46.146]:42846 "EHLO
        anchovy2.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388771AbeIUH6z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Sep 2018 03:58:55 -0400
Subject: Re: [PATCH] iio: magnetometer: Add support for PNI RM3100 9-axis
 magnetometer
To: Song Qiang <songqiang1304521@gmail.com>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180920131340.6699-1-songqiang1304521@gmail.com>
From: Phil Reid <preid@electromag.com.au>
Message-ID: <4633d30b-b493-d70b-dd7b-3f5bc3e16e78@electromag.com.au>
Date: Fri, 21 Sep 2018 10:05:38 +0800
MIME-Version: 1.0
In-Reply-To: <20180920131340.6699-1-songqiang1304521@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/09/2018 9:13 PM, Song Qiang wrote:
> PNI RM3100 magnetometer is a high resolution, large signal immunity
> magnetometer, composed of 3 single sensors and a processing chip.
> PNI is currently not in the vendors list, so this is also adding it.
> 

In the subject: Isn't the RM3100 a 3axis mag.
The 9axis bit comes when you combine it with an accel / gryo I think.

... snip

> +++ b/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
> @@ -0,0 +1,57 @@
> +* PNI RM3100 9-axis magnetometer sensor
> +
> +I2C Bus:
> +
> +Required properties:
> +
> +- compatible : should be "pni,rm3100-i2c"
> +- reg : the I2C address of the magnetometer
> +

... snip

> +SPI Bus:
> +
> +Required properties:
> +
> +- compatible : should be "pni,rm3100-spi"
> +- reg : address of sensor, usually 0 or 1.
> +

Looking at other drivers supporting i2c / spi.
They use the same compatible for both.

eg: see iio/accel/adxl345_*.c

and it's binding doc:

Required properties:
  - compatible : should be "adi,adxl345"
  - reg : the I2C address or SPI chip select number of the sensor
