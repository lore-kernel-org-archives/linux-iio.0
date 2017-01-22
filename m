Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40610 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbdAVOfR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Jan 2017 09:35:17 -0500
Subject: Re: [PATCH 2/2] Documentation: dt: iio: imu: st_lsm6dsx: add
 st,drdy-int-pin property
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
References: <20170122103052.8769-1-lorenzo.bianconi@st.com>
 <20170122103052.8769-3-lorenzo.bianconi@st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <71a02c15-73c7-9614-e9c6-2a3e8138305b@kernel.org>
Date: Sun, 22 Jan 2017 14:35:06 +0000
MIME-Version: 1.0
In-Reply-To: <20170122103052.8769-3-lorenzo.bianconi@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/01/17 10:30, Lorenzo Bianconi wrote:
> Add st,drdy-int-pin property to select interrupt pin of the package
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Looks good and lines up with existing st-sensors binding.
> ---
>  Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> index ed3cdac..cf81afd 100644
> --- a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> +++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> @@ -7,6 +7,8 @@ Required properties:
>  - reg: i2c address of the sensor / spi cs line
>  
>  Optional properties:
> +- st,drdy-int-pin: the pin on the package that will be used to signal
> +  "data ready" (valid values: 1 or 2).
>  - interrupt-parent: should be the phandle for the interrupt controller
>  - interrupts: interrupt mapping for IRQ. It should be configured with
>    flags IRQ_TYPE_LEVEL_HIGH or IRQ_TYPE_EDGE_RISING.
> 

