Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail2.br-automation.com ([213.33.116.61]:60349 "EHLO
	mail2.br-automation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932230AbbDOFdV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 15 Apr 2015 01:33:21 -0400
In-Reply-To: <552D01BB.5040500@ti.com>
References: <OFD386DA80.D9FD2A2E-ONC1257E27.003DC94D-C1257E27.003DF465@br-automation.com> <552D01BB.5040500@ti.com>
To: Vignesh R <vigneshr@ti.com>
Cc: devicetree@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, fcooper@ti.com,
	Kumar Gala <galak@codeaurora.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Jan Kardell <jan.kardell@telliq.com>,
	Johannes Pointner <Johannes.Pointner@br-automation.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Karol Wrona <k.wrona@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] iio: ti_am335x_adc: Add optional DT properties for tscadc
Message-ID: <OF8FD6AADF.98AD3B30-ONC1257E28.001B8C0B-C1257E28.001E820E@br-automation.com>
From: Hannes Petermaier <Hannes.Petermaier@br-automation.com>
Date: Wed, 15 Apr 2015 07:33:13 +0200
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> Hi Hannes,
Hi Vignesh,
thanks for answer.

> >>
> >> would it be possible to add some more channel-specific settings ?
> >>
> >> It would be nice to have allmost full control to the STEPCONFIGx 
> > register.
> >>
> >> At least we need to write the bits
> >>
> >> SEL_RFM_SWC_1_0
> >> SEL_INM_SWC_3_0 
> >> SEL_RFP_SWC_2_0 
> >>
> >> In the current mainline version only (SEL_INP_SWC_3_0) is written.
> >> So for the other bits "0" is value is used, for my point of view this 
is 
> > not correct.
> >>
> >> For example if we want to read a value from AIN5 the negative pin 
from 
> > adc is 
> >> muxed allways to AIN0.
> 
> Sorry... I didn't understand what you meant by"AIN5 is muxed always with
> AIN0"?
Have a look to the TRM (spruh73k.pdf) Page 1740 / Figure 12-2. Functional 
Block Diagram.
There you can see that the ADC-cell which has two inputs, one positive and 
one negative.
Also there are two reference inputs, one positive - one negative.

All this "pins" are muxed, because only one channel per time can be 
sampled.
This muxes are controlled through the STEPCONFIGx registers.

If you want for example take some measurement from AIN5 the driver muxes 
the positive input from the ADC to AIN5 by setting the bits for 
SEL_INP<3:0> - this is ok.
But the bits for SEL_INM<3:0> are still 'zero'. 
In summary this results in following mux-setting (regarding page 1771 in 
TRM):

positive-reference muxed to   VDDA
negative-reference muxed to   VSSA
positive-input muxed to       AIN5
negative-input muxed to       AIN0

>From this setup we run into 2 problems:
- the negative input terminal is muxed maybe to wrong potential
In much cases we have a single-ended signal so this setup looks good at 
first, because the "Diff_CNTRL" bit is also false. 
In fact there is an influence to the reading if the negative 
input-terminal isn't setup correctly (to VSSA or REFN). 
Maybe i interpret the "Diff_CNTRL" not correctly, there is no detailed 
description within the TRM - maybe some of your workmates can explain you 
the functionality of this bit.

- reference is allways taken from VDDA/VSSA
For a precision measurement you dont't use in normal case the 
analog-supply.
This rail brings noise, drift - all things whicht we don't need for 
accurate measurement.

> 
> >> In fact i can readout heavy jitter even if AIN5 is connected to 
ground - 
> > after
> >> setting up negative adc pin within code (to use REFN)  the readout 
value 
> > is 0 
> >> as expected without nameable jitter.
> >> If i short AIN0 also to ground, jitter is also eliminated.
> 
> Hmmm... nobody has reported such behavior before. ADC support for
> am335x-evm/beaglebone has been there for quite long time, but nobody
> reported any jitter on AIN5 line. I think this may be specific to
> your setup. Can you provide more info with regard to your setup?
> Which kernel? Is it am335x-evm or beaglebone or a custom board?
Maybe nobody does some precision measurement with beaglebone.
For operating some touchscreen or readout a potentiometer for evaluation 
purpose it is still good enough.

Kernel is current mainline, 4.0
Board is some custom board of my company.
But all this parameters shouldn't have some influence to the case.

> >>
> >> Maybe this is also some fault of TI SoC ... in normal case somebody 
> > could 
> >> expect, that negative adc pin is equal even the Diff_CNTRL bit isn't 
set 
> > - but
> >> in practice it isn't.
> >>
> >> Also actually it isn't possible to make some accurate measurement due 
to 
> > the 
> >> fact that allways VDDA_ADC is used as positive reference.
> >>
> >> So it would be nice to have control around this bits.
> >> Whats your opinion around that?
> 
> Sorry, I am not yet clear on your bug/use-case.
> 
> Please comment inline while replying on mailing list
okay so ?
 
> Regards
> Vignesh
best regards,
Hannes



