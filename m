Return-Path: <bigeasy@linutronix.de>
Message-ID: <51D57DFA.9060809@linutronix.de>
Date: Thu, 04 Jul 2013 15:51:54 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Sekhar Nori <nsekhar@ti.com>
CC: Lee Jones <lee.jones@linaro.org>,
 Samuel Ortiz <sameo@linux.intel.com>,
 =?UTF-8?B?QmVub8OudCBDb3Vzc29u?= <b-cousson@ti.com>,
 Tony Lindgren <tony@atomide.com>,
 Jonathan Cameron <jic23@cam.ac.uk>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-input@vger.kernel.org,
 Pantelis Antoniou <panto@antoniou-consulting.com>,
 Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Re: [PATCH 14/22] arm/am33xx: add TSC/ADC mfd device support
References: <1370950268-7224-1-git-send-email-bigeasy@linutronix.de> <1370950268-7224-15-git-send-email-bigeasy@linutronix.de> <51D57D4F.30905@ti.com>
In-Reply-To: <51D57D4F.30905@ti.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On 07/04/2013 03:49 PM, Sekhar Nori wrote:
>> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
>> index 1460d9b..4ad7797 100644
>> --- a/arch/arm/boot/dts/am33xx.dtsi
>> +++ b/arch/arm/boot/dts/am33xx.dtsi
>> @@ -404,6 +404,24 @@
>>  			ti,hwmods = "wkup_m3";
>>  		};
>>  
>> +		tscadc: tscadc@44e0d000 {
>> +			compatible = "ti,am3359-tscadc";
>> +			reg = <0x44e0d000 0x1000>;
>> +			interrupt-parent = <&intc>;
> 
> interrupt-parent can be dropped since it will be inherited from parent.

That is true. I prepare a patch for that after the merge window.

> 
> Thanks,
> Sekhar

Sebastian
