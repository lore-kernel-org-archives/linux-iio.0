Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34083 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbcGDRAD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jul 2016 13:00:03 -0400
Received: by mail-pf0-f175.google.com with SMTP id h14so62706296pfe.1
        for <linux-iio@vger.kernel.org>; Mon, 04 Jul 2016 10:00:03 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] ARM:dts-Add dt node for Broadcom iproc-static-adc
To: Jonathan Cameron <jic23@kernel.org>,
	Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1467099636-31855-1-git-send-email-raveendra.padasalagi@broadcom.com>
 <1467099636-31855-4-git-send-email-raveendra.padasalagi@broadcom.com>
 <184c47dc-6cdb-c314-9f29-7b03d5784de6@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Jonathan Richardson <jonathar@broadcom.com>,
	Jon Mason <jonmason@broadcom.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Anup Patel <anup.patel@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Pramod Kumar <pramod.kumar@broadcom.com>,
	linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <577A9604.90702@broadcom.com>
Date: Mon, 4 Jul 2016 09:59:48 -0700
MIME-Version: 1.0
In-Reply-To: <184c47dc-6cdb-c314-9f29-7b03d5784de6@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Florian,

Patch to apply

On 16-07-03 03:34 AM, Jonathan Cameron wrote:
> On 28/06/16 08:40, Raveendra Padasalagi wrote:
>> This patch adds DT node for Broadcom's iproc-static-adc
>> controller driver.
>>
>> Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> Driver is working its way towards just making the next merge window...
>
> Guessing this will go through the relevant path to the arm-soc tree
> as normal.
Florian, can you add to next pull request?

>
> Thanks,
>
> Jonathan
>> ---
>>   arch/arm/boot/dts/bcm-cygnus.dtsi | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
>> index b42fe55..fabc9f3 100644
>> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
>> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
>> @@ -366,5 +366,16 @@
>>   			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
>>   			status = "disabled";
>>   		};
>> +
>> +		adc: adc@180a6000 {
>> +			compatible = "brcm,iproc-static-adc";
>> +			#io-channel-cells = <1>;
>> +			io-channel-ranges;
>> +			adc-syscon = <&ts_adc_syscon>;
>> +			clocks = <&asiu_clks BCM_CYGNUS_ASIU_ADC_CLK>;
>> +			clock-names = "tsc_clk";
>> +			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
>> +			status = "disabled";
>> +		};

Thanks,
  Scott
>>   	};
>>   };
>>
>
