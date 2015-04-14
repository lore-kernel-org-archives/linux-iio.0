Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38135 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755132AbbDNMDT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 14 Apr 2015 08:03:19 -0400
Message-ID: <552D01E2.4080305@ti.com>
Date: Tue, 14 Apr 2015 17:32:42 +0530
From: Vignesh R <vigneshr@ti.com>
MIME-Version: 1.0
To: Hannes Petermaier <Hannes.Petermaier@br-automation.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Karol Wrona <k.wrona@samsung.com>,
	Jan Kardell <jan.kardell@telliq.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <fcooper@ti.com>,
	Johannes Pointner <Johannes.Pointner@br-automation.com>
Subject: Re: [PATCH 0/2] iio: ti_am335x_adc: Add optional DT properties for
 tscadc
References: <OFD386DA80.D9FD2A2E-ONC1257E27.003DC94D-C1257E27.003DF465@br-automation.com>
In-Reply-To: <OFD386DA80.D9FD2A2E-ONC1257E27.003DC94D-C1257E27.003DF465@br-automation.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Hannes,

On Tuesday 14 April 2015 04:46 PM, Hannes Petermaier wrote:
> Hi Vignesh,
> 
> did you recognize my last email ? whats your opinion around that =
> 
> best regards,
> Hannes
> ----- Forwarded by Hannes Petermaier/Eggelsberg/AT/B&R on 14.04.2015 13:14 
> -----
> 
> Hannes Petermaier/Eggelsberg/AT/B&R schrieb am 07.04.2015 14:30:19:
> 
>> From: Hannes Petermaier/Eggelsberg/AT/B&R
>> To: vigneshr@ti.com
>> Cc: linux-iio@vger.kernel.org
>> Date: 07.04.2015 14:30
>> Subject: WG: Fwd: [PATCH 0/2] iio: ti_am335x_adc: Add optional DT 
> properties for tscadc
>>
>> Hi Vignesh,
>>
>> would it be possible to add some more channel-specific settings ?
>>
>> It would be nice to have allmost full control to the STEPCONFIGx 
> register.
>>
>> At least we need to write the bits
>>
>> SEL_RFM_SWC_1_0
>> SEL_INM_SWC_3_0 
>> SEL_RFP_SWC_2_0 
>>
>> In the current mainline version only (SEL_INP_SWC_3_0) is written.
>> So for the other bits "0" is value is used, for my point of view this is 
> not correct.
>>
>> For example if we want to read a value from AIN5 the negative pin from 
> adc is 
>> muxed allways to AIN0.

Sorry... I didn't understand what you meant by"AIN5 is muxed always with
AIN0"?

>> In fact i can readout heavy jitter even if AIN5 is connected to ground - 
> after
>> setting up negative adc pin within code (to use REFN)  the readout value 
> is 0 
>> as expected without nameable jitter.
>> If i short AIN0 also to ground, jitter is also eliminated.

Hmmm... nobody has reported such behavior before. ADC support for
am335x-evm/beaglebone has been there for quite long time, but nobody
reported any jitter on AIN5 line. I think this may be specific to
your setup. Can you provide more info with regard to your setup?
Which kernel? Is it am335x-evm or beaglebone or a custom board?

>>
>> Maybe this is also some fault of TI SoC ... in normal case somebody 
> could 
>> expect, that negative adc pin is equal even the Diff_CNTRL bit isn't set 
> - but
>> in practice it isn't.
>>
>> Also actually it isn't possible to make some accurate measurement due to 
> the 
>> fact that allways VDDA_ADC is used as positive reference.
>>
>> So it would be nice to have control around this bits.
>> Whats your opinion around that?

Sorry, I am not yet clear on your bug/use-case.

Please comment inline while replying on mailing list

Regards
Vignesh
