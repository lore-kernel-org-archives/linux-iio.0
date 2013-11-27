Return-Path: <fugang.duan@freescale.com>
From: Fugang Duan <fugang.duan@freescale.com>
To: Shawn Guo <shawn.guo@linaro.org>
CC: "jic23@kernel.org" <jic23@kernel.org>, "sachin.kamat@linaro.org"
	<sachin.kamat@linaro.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Frank Li <Frank.Li@freescale.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH v3 3/3] Documentation: add the binding file for
 Freescale vf610 ADC driver
Date: Wed, 27 Nov 2013 01:38:12 +0000
Message-ID: <9848F2DB572E5649BA045B288BE08FBE018988D9@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1385463394-11157-1-git-send-email-B38611@freescale.com>
 <1385463394-11157-4-git-send-email-B38611@freescale.com>
 <20131126133737.GA5402@S2101-09.ap.freescale.net>
In-Reply-To: <20131126133737.GA5402@S2101-09.ap.freescale.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

From: Shawn Guo [mailto:shawn.guo@linaro.org]
Data: Tuesday, November 26, 2013 9:38 PM

>To: Duan Fugang-B38611
>Cc: jic23@kernel.org; sachin.kamat@linaro.org; devicetree@vger.kernel.org;=
 Li
>Frank-B20596; linux-iio@vger.kernel.org
>Subject: Re: [PATCH v3 3/3] Documentation: add the binding file for Freesc=
ale
>vf610 ADC driver
>
>On Tue, Nov 26, 2013 at 06:56:34PM +0800, Fugang Duan wrote:
>> +Optional properties:
>> +- fsl,adc-io-pinctl: Enable field for the I/O port control of MCU pins =
used
>as analog inputs.
>> +- fsl,adc-vref: ADC refrence voltage value, unit is uV.
>> +- fsl,adc-clk-div: Current clock divider value, such as 1,2,4,8,16 and =
so on.
>> +- fsl,adc-res: ADC conversion mode selection, such as 8 for 8-bit, 10 f=
or
>10-bit, 12 for 12-bit mode.
>> +- fsl,adc-sam-time: ADC sample time duration, number of ADC clocks, suc=
h as
>2, 4, 6, 8, 12, 16, 20, 24
>> +- fsl,adc-aver-sam-sel: Determines how many ADC conversions will be ave=
raged
>to create the ADC average result.
>> +			The Optional value is 4, 8, 16, 32.
>> +- fsl,adc-hw-aver-en: Bool type to decide enable hardware average funct=
ion.
>> +- fsl,adc-low-power-mode: Bool type to decide enable ADC low power mode=
.
>> +- fsl,adc-high-speed-conv: Bool type to decide enable ADC high speed mo=
de.
>> +- vref: The regulator to support ADC refrence voltage.
>
>Shouldn't it be vref-supply?
>
>Shawn

It is vref-supply.

Thanks.
