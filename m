Return-Path: <SRS0=8d3L=YD=free-electrons.com=quentin.schulz@kernel.org>
Subject: Re: [PATCH 1/7] Documentation: DT: bindings: iio: adc: add
 documentation for Allwinner SoCs' GPADC driver
To: Maxime Ripard <maxime.ripard@free-electrons.com>
References: <20161220102709.9504-1-quentin.schulz@free-electrons.com>
 <20161220102709.9504-2-quentin.schulz@free-electrons.com>
 <20161220142554.rcocnculfehiwhpn@lukather>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
 lee.jones@linaro.org, linux@armlinux.org.uk, stefan.mavrodiev@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@free-electrons.com
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <61dc140a-5ef1-f55d-e749-cb816a014705@free-electrons.com>
Date: Tue, 20 Dec 2016 16:43:58 +0100
MIME-Version: 1.0
In-Reply-To: <20161220142554.rcocnculfehiwhpn@lukather>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

Hi,

On 20/12/2016 15:25, Maxime Ripard wrote:
> Hi,
> 
> On Tue, Dec 20, 2016 at 11:27:03AM +0100, Quentin Schulz wrote:
[...]
>> +Currently, the touchscreen controller does not have a driver using this ADC
>> +driver. The touchscreen controller is currently driven only by
>> +input/touchscreen/sun4i-ts.c which is absolutely incompatible with this driver.
>> +
>> +The Allwinner A10, A13 and A31 SoCs already have a DT binding for the
>> +aforementioned input driver, thus an MFD driver matches the existing DT binding
>> +(mfd/sun4i-gpadc.c) and replaces the input driver. No DT binding is required for
>> +these SoCs' ADC, everything is handled by the MFD which is matching the existing
>> +DT binding for input/touchscreen/sun4i-ts.c.
>> +
>> +The Allwinner A33 GPADC only have a thermal sensor and have a proper DT binding
>> +for this driver unlike the previously mentioned SoCs.
> 
> The DT bindings should be agnostic from the OS. You can remove all
> mention of the implementations details in Linux.
> 
> (and you should wrap at 72 characters).
> 
> But we already have a binding document for that controller, so you
> shouldn't create a new one, reuse the old one that is already there.
> 

ACK.

>> +Required properties:
>> + - compatible: "allwinner,sun8i-a33-gpadc-iio"
> 
> IIO is an implementation detail. The IP is called GPADC.
> You're also missing reg.
> 

ACK.

>> +
>> +Optional properties:
>> +(for use with thermal framework for CPU thermal throttling for example, and/or
>> + IIO consumers)
>> + - #thermal-sensor-cells = <0>; (see
>> +Documentation/devicetree/bindings/thermal/thermal.txt)
>> + - #io-channel-cells = <0>; (see
>> +Documentation/devicetree/bindings/iio/iio-bindings.txt)
> 
> I wouldn't list that as optional.
> 

In what sense? Do you mean you wouldn't put them here at all or you
would require them?

Thanks,
Quentin

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
