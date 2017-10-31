Return-Path: <SRS0=JiSV=B6=gmail.com=joel.stan@kernel.org>
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <CACPK8XcVP=8sXf1rdLFSL1nTDKUwPSGkJ-QhLiHnTB+82AW=ww@mail.gmail.com>
References: <20171030072218.2094-1-joel@jms.id.au> <CA+gwMccGYbx7-oD2ChrFQBr9g=KAF=_nse15kMrWG4XaFvU2pg@mail.gmail.com>
 <CACPK8XcVP=8sXf1rdLFSL1nTDKUwPSGkJ-QhLiHnTB+82AW=ww@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 31 Oct 2017 11:34:49 +1030
Message-ID: <CACPK8Xei8nbZ0LfZn+7xfLi2LZroS7Nq7wXBwRy6b5pZkWqzRQ@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: aspeed: Deassert reset in probe
To: Philipp Zabel <philipp.zabel@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rick Altherr <raltherr@google.com>,
	Rob Herring <robh+dt@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	devicetree <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Tue, Oct 31, 2017 at 11:02 AM, Joel Stanley <joel@jms.id.au> wrote:
> On Tue, Oct 31, 2017 at 2:51 AM, Philipp Zabel <philipp.zabel@gmail.com> wrote:
>> Hi Joel,
>>
>> On Mon, Oct 30, 2017 at 8:22 AM, Joel Stanley <joel@jms.id.au> wrote:
>>> The ASPEED SoC must deassert a reset in order to use the ADC peripheral.
>>>
>>> The device tree bindings are updated to document the resets phandle, and
>>> the example is updated to match what is expected for both the reset and
>>> clock phandle.
>>>
>>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>>> ---
>>>  .../devicetree/bindings/iio/adc/aspeed_adc.txt      |  4 +++-
>>>  drivers/iio/adc/aspeed_adc.c                        | 21 ++++++++++++++++-----
>>>  2 files changed, 19 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt b/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt
>>> index 674e133b7cd7..034fc2ba100e 100644
>>> --- a/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt
>>> +++ b/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt
>>> @@ -8,6 +8,7 @@ Required properties:
>>>  - reg: memory window mapping address and length
>>>  - clocks: Input clock used to derive the sample clock. Expected to be the
>>>            SoC's APB clock.
>>> +- resets: Reset controller phandle
>>
>> Adding new required properties to existing bindings would break backwards
>> compatibility. In this case, the reset is optional anyway.
>
> As far as the hardware is concerned (and therefore the bindings), the
> reset is required.
>
> To date the only reason the driver worked was an out of tree hack in
> mach-aspeed. I have written a clk/reset driver and are now working to
> ensure the drivers work correctly.
>
> The driver is written to make the reset optional as it's unlikely the
> clk/reset driver and device tree updates will land this merge window.
> As we say; the bindings should describe the hardware, not the Linux
> implementation of the driver.

I changed my mind. No one would have been able to successfully use
this driver without out of tree hacks to release the reset, so we are
not regressing any functionality by requiring the reset controller.

I will submit v2 with the controller required, and save any stuffing
around in the future.

Cheers,

Joel
