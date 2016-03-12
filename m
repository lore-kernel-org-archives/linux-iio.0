Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43993 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbcCLMIw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Mar 2016 07:08:52 -0500
Subject: Re: [PATCH v1 1/2] iio:iio-interrupt-trigger: device-tree support
To: Rob Herring <robh@kernel.org>
References: <cover.1455908065.git.gregor.boirie@parrot.com>
 <d8f7902dbfe6e911e6ac0d1117502a02b1212022.1455908065.git.gregor.boirie@parrot.com>
 <56CA162C.5010406@kernel.org> <20160222190521.GA30054@rob-hp-laptop>
Cc: Gregor Boirie <gregor.boirie@parrot.com>,
	linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56E406D0.5090902@kernel.org>
Date: Sat, 12 Mar 2016 12:08:48 +0000
MIME-Version: 1.0
In-Reply-To: <20160222190521.GA30054@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/02/16 19:05, Rob Herring wrote:
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
> 
> If linux has no control of the setup, then do we care? It's just some 
> blackbox driving a signal.
> 
>> Any suggestions on appropriate naming?
> 
> I would think of it outside of IIO perhaps. We already have gpio-keys 
> which is kind of similar. Maybe just "external interrupt"? Is it always 
> a GPIO interrupt or could be polled GPIO or some other mechanism?

The challenge is that we need to be able to capture it's use.
> 
> Could you add "trigger-gpios" to every device that uses it and allow for 
> it to appear multiple times? It somewhat depends on how static setting 
> the trigger source is whether that would be appropriate.
Right now we don't have a device - the interrupt trigger is only soft
associated (via sysfs) with it's users at a later date.

I think we just have 'make up a device' for this to represent the use case
so we can probe the interrupt trigger driver in iio.

sensor sampling trigger perhaps?

> 
>> We aren't really describing hardware here, rather a policy decision on what
>> a given interrupt is to be used for.
>>
>> I suppose ultimately we could take the view this should be handled via another
>> route (from userspace via an appropriate configfs interface for example).
> 
> You would still need to know which GPIOs you could use or assign, so I 
> think we need something in DT.
Absolutely. Short of allowing completely generic grabbing from a configfs call
of an interrupt, definitely need to specify which interrupts are suitable for
use like this. 

I think a 'fictional' device is going to have to exist to allow this..

Jonathan


