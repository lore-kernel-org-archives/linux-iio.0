Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-cys01nam02on0048.outbound.protection.outlook.com ([104.47.37.48]:59619
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753435AbeDTRF2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 20 Apr 2018 13:05:28 -0400
Subject: Re: [PATCH v7 2/2] dt-bindings: iio:imu:mpu6050: support more
 interrupt types
To: Martin Kelly <mkelly@xevo.com>, linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
References: <20180420165401.13076-1-mkelly@xevo.com>
 <20180420165401.13076-2-mkelly@xevo.com>
From: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Message-ID: <e4b895f2-8730-598c-5716-3dee151de26d@invensense.com>
Date: Fri, 20 Apr 2018 19:05:12 +0200
MIME-Version: 1.0
In-Reply-To: <20180420165401.13076-2-mkelly@xevo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 20/04/2018 18:54, Martin Kelly wrote:
> Document that the hardware supports falling edge, rising edge, level
> low, and level high interrupt types, rather than just rising edge.
> 
> The language used is the same as that in st_lsm6dsx.txt.
> 
> Signed-off-by: Martin Kelly <mkelly@xevo.com>
> ---
>   Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> index 2b4514592f83..6b106d5ef298 100644
> --- a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> +++ b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> @@ -11,7 +11,12 @@ Required properties:
>   		"invensense,icm20608"
>    - reg : the I2C address of the sensor
>    - interrupt-parent : should be the phandle for the interrupt controller
> - - interrupts : interrupt mapping for GPIO IRQ
> + - interrupts: interrupt mapping for IRQ. It should be configured with flags
> +   IRQ_TYPE_LEVEL_HIGH, IRQ_TYPE_EDGE_RISING, IRQ_TYPE_LEVEL_LOW or
> +   IRQ_TYPE_EDGE_FALLING.
> +
> +  Refer to interrupt-controller/interrupts.txt for generic interrupt client node
> +  bindings.
>   
>   Optional properties:
>    - mount-matrix: an optional 3x3 mounting rotation matrix
> @@ -24,7 +29,7 @@ Example:
>   		compatible = "invensense,mpu6050";
>   		reg = <0x68>;
>   		interrupt-parent = <&gpio1>;
> -		interrupts = <18 1>;
> +		interrupts = <18 IRQ_TYPE_EDGE_RISING>;
>   		mount-matrix = "-0.984807753012208",  /* x0 */
>   		               "0",                   /* y0 */
>   		               "-0.173648177666930",  /* z0 */
> @@ -41,7 +46,7 @@ Example:
>   		compatible = "invensense,mpu9250";
>   		reg = <0x68>;
>   		interrupt-parent = <&gpio3>;
> -		interrupts = <21 1>;
> +		interrupts = <21 IRQ_TYPE_LEVEL_HIGH>;
>   		i2c-gate {
>   			#address-cells = <1>;
>   			#size-cells = <0>;
> 


Acked-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
