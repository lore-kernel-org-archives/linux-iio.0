Return-Path: <gregor.boirie@parrot.com>
Message-ID: <56CC1745.5080505@parrot.com>
Date: Tue, 23 Feb 2016 09:24:37 +0100
From: Gregor Boirie <gregor.boirie@parrot.com>
MIME-Version: 1.0
To: Rob Herring <robh@kernel.org>, Jonathan Cameron <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter
 Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Pawel Moll
	<Pawel.Moll@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Ian Campbell
	<ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v1 1/2] iio:iio-interrupt-trigger: device-tree support
References: <cover.1455908065.git.gregor.boirie@parrot.com> <d8f7902dbfe6e911e6ac0d1117502a02b1212022.1455908065.git.gregor.boirie@parrot.com> <56CA162C.5010406@kernel.org> <20160222190521.GA30054@rob-hp-laptop>
In-Reply-To: <20160222190521.GA30054@rob-hp-laptop>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 02/22/2016 08:05 PM, Rob Herring wrote:
> On Sun, Feb 21, 2016 at 07:55:24PM +0000, Jonathan Cameron wrote:
>> On 19/02/16 19:18, Gregor Boirie wrote:
>>> From: Grégor Boirie <gregor.boirie@parrot.com>
>>>
>>> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
>> Snag here is that iio_interrupt_trigger is a very linux specific
>> name and device tree bindings should be just about the hardware.
>>
>> Not entirely sure how we avoid this though as the use is rather
>> hard to describe generically.
>>
>> cc'd device tree list and bindings maintainers.
>>
>> As a brief summary - this IIO trigger driver takes a generic
>> interrupt (from whatever) and uses it to drive sampling of IIO devices.
>> The interrupt might be associated with particularly simple sensors directly
>> but is more commonly a gpio interrupt line used cause samples to be captured
>> from unrelated devices.  Sometimes the source of that interrupt can be a convoluted
>> external mux setup over which linux has no control for example.
> If linux has no control of the setup, then do we care? It's just some
> blackbox driving a signal.
>
>> Any suggestions on appropriate naming?
> I would think of it outside of IIO perhaps. We already have gpio-keys
> which is kind of similar. Maybe just "external interrupt"? Is it always
> a GPIO interrupt or could be polled GPIO or some other mechanism?
Our setup uses an ARM software generated interrupt coming from an 
alternate core
running a custom OS. Usage is however quite similar to GPIO irqs.

[snip]

Grégor.
