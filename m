Return-Path: <manabian@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL2L0Fu-q6U55A-OtjWzv1XLN709mG=ck7qrv=G9t5aKA@mail.gmail.com>
References: <1456772741-9402-1-git-send-email-manabian@gmail.com>
	<CAL_JsqL2L0Fu-q6U55A-OtjWzv1XLN709mG=ck7qrv=G9t5aKA@mail.gmail.com>
Date: Tue, 1 Mar 2016 21:43:51 +0100
Message-ID: <CAGhQ9VwL9dD=0mAoXFn0bEQQ346gcy29hKJQAMS3Mtgq8RjXsw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Support for analog peripherals on LPC18xx familiy
From: Joachim  Eastwood <manabian@gmail.com>
To: Rob Herring <robh+dt@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi Rob,

On 1 March 2016 at 21:33, Rob Herring <robh+dt@kernel.org> wrote:
> On Mon, Feb 29, 2016 at 1:05 PM, Joachim Eastwood <manabian@gmail.com> wrote:
>> This patch set adds support for the analog (ADC and DAC) peripherals
>> found on NXP LPC18xx/43xx SoCs. The ADC is a SAR converter with 10-bit
>> resolution and 8 muxed inputs. The DAC is a simple single channel 10-
>> bit DAC.
>>
>> Note that these drivers do not support all the features found on the
>> peripherals. DMA and interrupts are not supported in either drivers.
>> The ADC driver also lack 'burst-mode' and hardware triggers. So for
>> now the ADC is limited to single shot samples.
>>
>> Both drivers tested on Embedded Artists' LPC4357 Developer's Kit.
>>
>> Based on iio/testing branch from 29.02.15.
>>
>>
>> Joachim Eastwood (4):
>>   iio: adc: add NXP LPC18xx ADC driver
>>   dt: document NXP LPC1850 ADC driver bindings
>>   iio: dac: add NXP LPC18xx DAC driver
>>   dt: document NXP LPC1850 DAC driver bindings
>
> You need to send bindings to the DT list.

ah, my bad. I was pretty sure I added it when I did format-patch, but
it seems to have been lost along the way...

Either way there will be a v2 and I will make sure to cc the DT list then.

Thanks for reporting.


regards,
Joachim Eastwood
