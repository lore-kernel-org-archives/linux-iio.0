Return-Path: <knaack.h@gmx.de>
Message-ID: <559431B0.6050304@gmx.de>
Date: Wed, 01 Jul 2015 20:30:08 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Thomas.Betker@rohde-schwarz.com
CC: Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 Michal Simek <michal.simek@xilinx.com>,
 =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH 3/5] iio: adc: xilinx: Fix VREFP scale
References: <1429125111-2926-1-git-send-email-thomas.betker@freenet.de> <1429125111-2926-4-git-send-email-thomas.betker@freenet.de> <558DCA63.6040001@gmx.de> <OF4F435CFE.EBD383ED-ONC1257E74.00350661-C1257E74.003C1F9E@rohde-schwarz.com>
In-Reply-To: <OF4F435CFE.EBD383ED-ONC1257E74.00350661-C1257E74.003C1F9E@rohde-schwarz.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Thomas.Betker@rohde-schwarz.com schrieb am 30.06.2015 um 12:56:
> Hello Hartmut:
> 
>>> The scaling factor for VREFP is 3.0/4096, not 1.0/4096; fix this to 
> get
>>> correct readings.
>>
>> I just had a look at the datasheet [1], table 3-1 on page 37, and 
>> get the feeling
>> that this scaling factor also applies to the VREFN channel. What is 
>> your opinion?
>>
>> [1] http://www.xilinx.com/support/documentation/user_guides/
>> ug480_7Series_XADC.pdf
> 
> The table provides the following references:
> - VREFP: Figure 2-10, transfer function 3*unsigned(code)/4096
> - VREFN: Figure 2-3, transfer function 1*unsigned(code)/4096
> 
> The table also says about VREFN: "The supply sensor is also used to 
> measure VREFN, thus 1 LSB = 3V/4096." I agree that this is not consistent 
> (by Figure 2-3, 1 LSB = 1V/4096), but I didn't have the means to check 
> which version is true as VREFN is close to 0V either way.
> 
> The situation is simpler for VREFP as UG480 is unambiguous here, and by 
> measuring the actual voltage we can tell 1.25V and 0.41V easily apart, 
> even when taking some measurement errors into account. In other words, we 
> have to use the factor 3 to get correct results for VREFP (thus the 
> patch), while either factor returns plausible results for VREFN.
> 
> I would suggest opening a webcase with Xilinx for clarification, and 
> adding another patch for VREFN if the factor 3 is confirmed. Can you do 
> this? If not, I can take care of it, but it may take a while as I am 
> pretty busy at the moment.
> 

Go ahead, whenever you find the time. I don't have a Xilinx device, just
reviewing the IIO patches and got a bit curious when reading through the
data sheet.

> Best regards,
> Thomas
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
