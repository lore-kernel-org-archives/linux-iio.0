Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:42013 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087Ab3HSKzl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 19 Aug 2013 06:55:41 -0400
Message-id: <5211F99A.6070902@samsung.com>
Date: Mon, 19 Aug 2013 12:55:22 +0200
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
MIME-version: 1.0
To: Pawel Moll <pawel.moll@arm.com>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"kyungmin.park@samsung.com" <kyungmin.park@samsung.com>,
	"rob.herring@calxeda.com" <rob.herring@calxeda.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	"swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
	"ian.campbell@citrix.com" <ian.campbell@citrix.com>
Subject: Re: [PATCH/RFC v4 3/3] DT: Add documentation for gp2ap020a00f sensor
References: <1376658760-3459-1-git-send-email-j.anaszewski@samsung.com>
 <1376659687.11176.3.camel@hornet>
In-reply-to: <1376659687.11176.3.camel@hornet>
Content-type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/16/2013 03:28 PM, Pawel Moll wrote:
> On Fri, 2013-08-16 at 14:12 +0100, Jacek Anaszewski wrote:
>> diff --git a/Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt b/Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt
>> new file mode 100644
>> index 0000000..e4f377d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt
>> @@ -0,0 +1,20 @@
>> +* Sharp GP2AP020A00F I2C Proximity/ALS sensor
>> +
>> +Required properties:
>> +
>> +  - compatible : should be "sharp,gp2ap020a00f"
>> +  - reg : the I2C address of the light sensor
>> +  - interrupt-parent : phandle to the parent interrupt controller
>> +  - interrupts : should be INT interrupt pin

This seems a bit misleading, perhaps:

interrupts : should be interrupt number the INT pin interrupt is routed to

?
> Any particular reason for the interrupt-parent being required? Couldn't
> it be inherited, as is happens in most cases?

I think this was intended for the cases when the sensor is connected
to a GPIO and the GPIO interrupt controller is used. For example on
the Exynos SoCs with each GPIO bank is associated separate interrupt
controller instance (see arch/arm/boot/dts/exynos4210-pinctrl.dtsi
for details). Thus one of those interrupt controllers need to be
selected by dts, rather than inheriting the GIC.

I'm not sure if "interrupt-parent" needs to be part of DT binding of
this sensor device. Perhaps it could be an optional property or should
it be dropped completely ? I guess it should be considered as part
of the interrupt controller binding ?

Thanks,
Sylwester
