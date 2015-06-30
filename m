Return-Path: <Thomas.Betker@rohde-schwarz.com>
In-Reply-To: <558DCA63.6040001@gmx.de>
References: <1429125111-2926-1-git-send-email-thomas.betker@freenet.de> <1429125111-2926-4-git-send-email-thomas.betker@freenet.de> <558DCA63.6040001@gmx.de>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>, =?ISO-8859-1?Q?S=F6ren_Brinkmann?= <soren.brinkmann@xilinx.com>
MIME-Version: 1.0
Subject: Re: [PATCH 3/5] iio: adc: xilinx: Fix VREFP scale
From: Thomas.Betker@rohde-schwarz.com
Message-ID: <OF4F435CFE.EBD383ED-ONC1257E74.00350661-C1257E74.003C1F9E@rohde-schwarz.com>
Date: Tue, 30 Jun 2015 12:56:42 +0200
Content-Type: text/plain; charset="US-ASCII"
List-ID: <linux-iio@vger.kernel.org>

Hello Hartmut:

> > The scaling factor for VREFP is 3.0/4096, not 1.0/4096; fix this to 
get
> > correct readings.
> 
> I just had a look at the datasheet [1], table 3-1 on page 37, and 
> get the feeling
> that this scaling factor also applies to the VREFN channel. What is 
> your opinion?
> 
> [1] http://www.xilinx.com/support/documentation/user_guides/
> ug480_7Series_XADC.pdf

The table provides the following references:
- VREFP: Figure 2-10, transfer function 3*unsigned(code)/4096
- VREFN: Figure 2-3, transfer function 1*unsigned(code)/4096

The table also says about VREFN: "The supply sensor is also used to 
measure VREFN, thus 1 LSB = 3V/4096." I agree that this is not consistent 
(by Figure 2-3, 1 LSB = 1V/4096), but I didn't have the means to check 
which version is true as VREFN is close to 0V either way.

The situation is simpler for VREFP as UG480 is unambiguous here, and by 
measuring the actual voltage we can tell 1.25V and 0.41V easily apart, 
even when taking some measurement errors into account. In other words, we 
have to use the factor 3 to get correct results for VREFP (thus the 
patch), while either factor returns plausible results for VREFN.

I would suggest opening a webcase with Xilinx for clarification, and 
adding another patch for VREFN if the factor 3 is confirmed. Can you do 
this? If not, I can take care of it, but it may take a while as I am 
pretty busy at the moment.

Best regards,
Thomas
