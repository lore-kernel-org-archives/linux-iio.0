Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751476AbeDUP2G (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Apr 2018 11:28:06 -0400
Date: Sat, 21 Apr 2018 16:28:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc: Martin Kelly <mkelly@xevo.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 2/2] dt-bindings: iio:imu:mpu6050: support more
 interrupt types
Message-ID: <20180421162801.4b8ddc25@archlinux>
In-Reply-To: <e4b895f2-8730-598c-5716-3dee151de26d@invensense.com>
References: <20180420165401.13076-1-mkelly@xevo.com>
        <20180420165401.13076-2-mkelly@xevo.com>
        <e4b895f2-8730-598c-5716-3dee151de26d@invensense.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 20 Apr 2018 19:05:12 +0200
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> On 20/04/2018 18:54, Martin Kelly wrote:
> > Document that the hardware supports falling edge, rising edge, level
> > low, and level high interrupt types, rather than just rising edge.
> > 
> > The language used is the same as that in st_lsm6dsx.txt.
> > 
> > Signed-off-by: Martin Kelly <mkelly@xevo.com>
Hi Martin,

Please pick up an acks / reviewed-by's from earlier versions.
The chances are I'll miss them some of the time otherwise.
Rob acked this one.

Applied with the two acks I know of to the togreg branch of iio.git
and pushed out as testing for the autobuilders to play with it.

Thanks,

Jonathan

> > ---
> >   Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt | 11 ++++++++---
> >   1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> > index 2b4514592f83..6b106d5ef298 100644
> > --- a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> > +++ b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> > @@ -11,7 +11,12 @@ Required properties:
> >   		"invensense,icm20608"
> >    - reg : the I2C address of the sensor
> >    - interrupt-parent : should be the phandle for the interrupt controller
> > - - interrupts : interrupt mapping for GPIO IRQ
> > + - interrupts: interrupt mapping for IRQ. It should be configured with flags
> > +   IRQ_TYPE_LEVEL_HIGH, IRQ_TYPE_EDGE_RISING, IRQ_TYPE_LEVEL_LOW or
> > +   IRQ_TYPE_EDGE_FALLING.
> > +
> > +  Refer to interrupt-controller/interrupts.txt for generic interrupt client node
> > +  bindings.
> >   
> >   Optional properties:
> >    - mount-matrix: an optional 3x3 mounting rotation matrix
> > @@ -24,7 +29,7 @@ Example:
> >   		compatible = "invensense,mpu6050";
> >   		reg = <0x68>;
> >   		interrupt-parent = <&gpio1>;
> > -		interrupts = <18 1>;
> > +		interrupts = <18 IRQ_TYPE_EDGE_RISING>;
> >   		mount-matrix = "-0.984807753012208",  /* x0 */
> >   		               "0",                   /* y0 */
> >   		               "-0.173648177666930",  /* z0 */
> > @@ -41,7 +46,7 @@ Example:
> >   		compatible = "invensense,mpu9250";
> >   		reg = <0x68>;
> >   		interrupt-parent = <&gpio3>;
> > -		interrupts = <21 1>;
> > +		interrupts = <21 IRQ_TYPE_LEVEL_HIGH>;
> >   		i2c-gate {
> >   			#address-cells = <1>;
> >   			#size-cells = <0>;
> >   
> 
> 
> Acked-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

