Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F31A19D074;
	Mon, 19 Oct 2026 01:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792373121; cv=none; b=FPAb821wsG/ycEoDZICG273KLaUWvNTuysSubPbplhn29rP9txFh8naKrH7oXDbTzAmum/YKv4N5/ROr8lzO+MjCQVYbv/fDsd/NAg6lbG+kN528zd+SHirR86HxEJ1gR8mf/tuX4XjJxNH+R8CSS0sSYzEi1fKO8fnZHeV3YGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792373121; c=relaxed/simple;
	bh=Q+urfe/rE0RzGbZB3fpkMvtN/BBhkGp/H+jgJAuHAY0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dU0YjOE4Wa3ntz+zNd/Y7WvsA+gEp/xtvdobb4wEkmeANGU8JzriqZ/EK0ch2Hjmrc96VnD2wFItcCK+8mNDImaXFFBzYe+btQ9iI9VeXXToVG9qDLmOkhW9lGJvmasdeSGKR5bRoOCAcmMHNMm0X5IYG+aFT5xrYPfTS9elS8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCxNxixl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCxNxixl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4971F000C4;
	Mon, 19 Oct 2026 01:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792373119;
	bh=8zLV/oA5mXJ2dsu+6UTBfH8DC6caY520BYB0DD+Xugo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KCxNxixlJa2XxeG05iqWyOPTRF9anrZQCY6rT3XcWCG6+7CLlJQIUXqDy2vLxojkv
	 4ocEMk51sfN0J8G3uqxc7Lm7l7Nfkob/Vk5C8QvU1Be+epmZ6/7kESG0xdyVqqhmuw
	 5qkSOAXVA9AjqBsFmHE6OBApcx27Lqs8gKq4errwl8F1IsuZrKBjfj7nbDHUbDRzgZ
	 yA88CZWDOWSNQLrrxutmuJdzu1zdoV9DqhtoU/4VpwuP9UXCKjtEPpr3nYMsPOnTTZ
	 72PwpzZZZW9fjIPVkwh5sevl8bkg55SZzpBl7/J+KOaZKPUi6J2g56+lRL7XIPyAKP
	 YI9WFQeM30FUw==
Date: Mon, 19 Oct 2026 02:25:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Olivier MOYSAN <olivier.moysan@foss.st.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: add bindings for stm32 mdf
 filter
Message-ID: <20261019022510.0d554b39@jic23-hlaptop>
In-Reply-To: <20261015-attentive-conflict-1a1f538de77d@spud>
References: <20261001-tribesman-gauze-862e1ef0cdd8@spud>
	<bb8af256-5a77-4215-9eeb-fbcd0cae1829@foss.st.com>
	<20261008-9e2a48675c1a4c28f2dfa73b@squawk>
	<950f2801-a613-4f5a-a5a7-cb30101cf293@foss.st.com>
	<20261009-8db882a9fa159f8759aa7327@squawk>
	<2ba9235f-182e-4906-92e2-e35cf831d289@foss.st.com>
	<20261014-untrimmed-partly-81a4a21db49c@spud>
	<48e528a5-0c54-4778-bd29-b6f44ae95be7@foss.st.com>
	<20261014-unmade-sphinx-71cb25110d58@spud>
	<436ef0bf-4146-435d-8252-acec68e64b9e@foss.st.com>
	<20261015-attentive-conflict-1a1f538de77d@spud>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Oct 2026 13:34:04 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Thu, Oct 15, 2026 at 11:19:19AM +0200, Olivier MOYSAN wrote:
> > Hi Conor,
> > 
> > On 10/15/26 00:49, Conor Dooley wrote:  
> > > On Wed, Oct 14, 2026 at 06:51:45PM +0200, Olivier MOYSAN wrote:  
> > > > On 10/14/26 17:15, Conor Dooley wrote:  
> > > > > On Mon, Oct 12, 2026 at 02:56:04PM +0200, Olivier MOYSAN wrote:  
> > > > > > On 10/9/26 21:12, Conor Dooley wrote:  
> > > > > > > On Thu, Oct 08, 2026 at 06:37:26PM +0200, Olivier MOYSAN wrote:  
> > > > > > > > On 10/8/26 12:11, Conor Dooley wrote:  
> > > > > > > > > On Wed, Oct 07, 2026 at 11:01:28AM +0200, Olivier MOYSAN wrote:  
> > > > > > > > > > On 10/1/26 20:32, Conor Dooley wrote:  
> > > > > > > > > > >   
> > > > > > > > > > > > +
> > > > > > > > > > > > +required:
> > > > > > > > > > > > +  - compatible
> > > > > > > > > > > > +  - reg
> > > > > > > > > > > > +  - ranges
> > > > > > > > > > > > +  - clocks
> > > > > > > > > > > > +  - clock-names
> > > > > > > > > > > > +  - clock-ranges
> > > > > > > > > > > > +  - "#address-cells"
> > > > > > > > > > > > +  - "#size-cells"
> > > > > > > > > > > > +
> > > > > > > > > > > > +additionalProperties: false
> > > > > > > > > > > > +
> > > > > > > > > > > > +patternProperties:
> > > > > > > > > > > > +  "^sitf@[0-9]+$":
> > > > > > > > > > > > +    type: object
> > > > > > > > > > > > +    description: Serial interface child node  
> > > > > > > > > > > 
> > > > > > > > > > > Why is this a child node at all?
> > > > > > > > > > > Probably not worth reviewing more without a link to the docs for this
> > > > > > > > > > > device so I can figure out what on earth is going on!
> > > > > > > > > > >   
> > > > > > > > > > 
> > > > > > > > > > The MDF is a digital filter for sigma-delta bitstreams, rather than the
> > > > > > > > > > analog-to-digital converter itself.
> > > > > > > > > > 
> > > > > > > > > > Here is the link to STM32MP25 reference manuel
> > > > > > > > > > https://www.st.com/resource/en/reference_manual/rm0457-stm32mp2325xx-advanced-armbased-3264bit-mpus-stmicroelectronics.pdf
> > > > > > > > > > Chapter 45: Multi-function digital filter (MDF)
> > > > > > > > > > 
> > > > > > > > > > On STMP32MP25 SoC, the MDF provides 8 serial interfaces (SITF) and 8 digital
> > > > > > > > > > filters (DFLT) which can be connected through a multiplexer.
> > > > > > > > > > 
> > > > > > > > > > Below is a schematic view of typical applications targeted by this
> > > > > > > > > > peripheral
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > Audio use case:
> > > > > > > > > > 
> > > > > > > > > > 		mdf
> > > > > > > > > >                 +-------------------------------------+
> > > > > > > > > > +------+    | +------+    +------+    +------+    |
> > > > > > > > > > | dmic | -> | | sitf | -> | mux  | -> | dflt | -- | -> audio device
> > > > > > > > > > +------+    | +------+    +------+    +------+    |
> > > > > > > > > >                 +-------------------------------------+
> > > > > > > > > > 
> > > > > > > > > > For instance, in an audio use case the serial interface can be configured to
> > > > > > > > > > provide the clock to the digital microphone (cck0, cck1 or both) at a common
> > > > > > > > > > predefined rate, and to retrieve the PDM samples.
> > > > > > > > > > The serial interface provides this samples to a digital filter, which
> > > > > > > > > > delivers PCM samples on its output.
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > Analog use case:
> > > > > > > > > > 
> > > > > > > > > > 		mdf
> > > > > > > > > >                   +-------------------------------------+
> > > > > > > > > > +--------+    | +------+    +------+    +------+    |
> > > > > > > > > > | sd adc | -> | | sitf | -> | mux  | -> | dflt | -- | -> iio device
> > > > > > > > > > +--------+    | +------+    +------+    +------+    |
> > > > > > > > > >                   +-------------------------------------+  
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > So, looking at the docs and a brief chat with Jonathan about this
> > > > > > > > > device, I believe you've got things backwards and this is actually the backend,
> > > > > > > > > and the adc should be the one populating the io-backends property
> > > > > > > > > pointing to this device. You should have io-backend-cells, and I assume
> > > > > > > > > that there should be a cell for the adc to select which dlft it is connected
> > > > > > > > > to.
> > > > > > > > >   
> > > > > > > > 
> > > > > > > > There have already been lengthy discussions in the past about a DFSDM
> > > > > > > > peripheral on STM32MP1, which has features similar to those of the MDF and
> > > > > > > > similar implementation constraints. For the DFSDM, a solution based on an
> > > > > > > > IIO backend had been upstreamed. The MDF follows the same architecture. I
> > > > > > > > need to take a little time to dive back into this issue.  
> > > > > > > 
> > > > > > > One thing to note there is that you retrofitted the backends onto that
> > > > > > > device, and the original design here is much older (it's a text
> > > > > > > binding).
> > > > > > > 
> > > > > > >   
> > > > > > > > 
> > > > > > > > DFSDM sources:
> > > > > > > > drivers/iio/adc/stm32-dfsdm-adc.c
> > > > > > > > drivers/iio/adc/stm32-dfsdm-core.c
> > > > > > > > 
> > > > > > > > Here is a sample of DFSDM DT
> > > > > > > > 
> > > > > > > > sd_adc0: simple-sd-adc0 {
> > > > > > > > 	compatible = "sd-modulator";
> > > > > > > > 	#io-backend-cells = <0>;
> > > > > > > > 	vref-supply = <&v3v3>;  
> > > > > > > 
> > > > > > > Yeah, pretty sure this is wrong (backwards). The backend is the thing
> > > > > > > that gets data from an ADC not the ADC.
> > > > > > >   
> > > > > > 
> > > > > > The backend framework was introduced to implement complex IIO aggregate
> > > > > > devices. The hardwares that were driving this need were analog device ad9467
> > > > > > and ST DFSDM.
> > > > > > 
> > > > > > https://lore.kernel.org/linux-iio/20231204144925.4fe9922f@jic23-huawei/T/#m222f5175273b81dbfe40b7f0daffcdc67d6cb8ff
> > > > > > 
> > > > > >   From drivers/iio/industrialio-backend.c:
> > > > > > 
> > > > > > "The typical architecture is to have one device as the frontend device which
> > > > > > can be "linked" against one or multiple backend devices. All the IIO and
> > > > > > userspace interface is expected to be registers/managed by the frontend
> > > > > > device which will callback into the backends when needed (to get/set some
> > > > > > configuration that it does not directly control)."
> > > > > > 
> > > > > >    *                                    ---------------------
> > > > > >    * ------------------                 | ------------
> > > > > >    * |     ADC        |-----------------| | ADC CORE |
> > > > > >    * | (Frontend/IIO) | Serial Data (eg | |(backend) |-------
> > > > > >    * |                |-----------------| ------------
> > > > > >    * ------------------                 ---------------------
> > > > > > 
> > > > > > The MDF (or DFSDM) use case, follows this topology:
> > > > > > - The SD modulator (ADC core) registers in backend framework
> > > > > > - The MDF registers in IIO framework and exposes the IIO devices
> > > > > >     It also get configuration (ref voltage) from SD modulator, to compute
> > > > > > scaling.
> > > > > > 
> > > > > > I agree that if we consider the terms frontend and backend, the elements in
> > > > > > the data flow do not have the roles that we would naturally expect. However,
> > > > > > if we consider the expected role of the elements using the iio-backend
> > > > > > framework, the usage seems coherent to me.  
> > > > > 
> > > > > I didn't even get as far as sd modulators or whatever, if I understand
> > > > > correctly the ADC inputs on this device are fed by the onboard ADC?
> > > > > (https://lore.kernel.org/linux-iio/20261006-adc-stm32mp25-v1-v4-0-d31ec75aecf3@foss.st.com/)
> > > > > In that case, I can't really see how it makes sense for the primary iio
> > > > > device to change when data is fed back through the mdf or taken
> > > > > directly from the ADC itself, particularly given how that would affect
> > > > > the userspace interface.
> > > > > 
> > > > > The "serial" side of this seems in a similar vein to the adi,axi-adc
> > > > > stuff, which when considered with the ADC inputs, really does give me
> > > > > the impression this is backwards.  
> > > > 
> > > > Some clarifications about the STM32MP25. This SoC does indeed provide ADCs,
> > > > and these can be connected to the MDF via a dedicated interface. (but not
> > > > the serial interface).
> > > > 
> > > > However, this use case is not supported by the driver. Only sigma-delta
> > > > modulators, external to the SoC and connected via the serial interface, are
> > > > supported. On ST boards, the only available SD modulators are digital
> > > > microphones.  
> > > 
> > > Quite frankly, I don't care what you are choosing to implement in the
> > > driver or what your first-party boards support. The binding must
> > > represent the capabilities of the device, not what subset you deem
> > > relevant at this point in time. I'm not going to ack anything that does
> > > not consider all use cases for the device, especially since I the more I
> > > look the more I am convinced that this is the wrong way to model the
> > > relationship between devices and therefore intentionally ignoring a use case
> > > is likely to be problematic when someone does decide that they want to use
> > > that feature.
> > >   
> > > > Anyway, if the internal ADC to MDF use case was supported, the issue would
> > > > be the same. The whole ADC + MDF set would be presented at the interface as
> > > > an aggregated device, and the ADC data would not be directly accessible to
> > > > the user.  
> > > 
> > > Of course, that's what I was talking about when I said:
> > > | In that case, I can't really see how it makes sense for the primary iio
> > > | device to change when data is fed back through the mdf or taken
> > > | directly from the ADC itself, particularly given how that would affect
> > > | the userspace interface.
> > > 
> > > To me, in that ADC to MDF use case, the frontend portion of the aggregate
> > > device presented to userspace needs to be the ADC and the MDF needs to be
> > > the backend, since otherwise the ADC will simultaneously be frontend and
> > > backend, depending on which channel is considered. That makes no sense to me
> > > when the MDF can always be the backend, for all use cases and avoid that
> > > sort of problem entirely.
> > > I've heard no argument as to why the MDF cannot be a backend, just that you
> > > don't want to because the previous device didn't, but copying what was
> > > done before isn't a justification that bears weight if how it was done
> > > before isn't the way it should be done.
> > >   
> > 
> > These topology problems were discussed at length in the case of DFSDM.
> > The main blocking point being support for interleaved channels (scan mode),
> > a problematic issue that is still found with MDF.  
> 
> If I am not mistaken, you're talking about what's described in the
> section labelled "Interleaved-transfer mode" of the document you
> provided previously?
> 
> > The constraints that led to this approach are in the following thread:
> > https://lore.kernel.org/all/20210919191414.09270f4e@jic23-huawei/  
> 
> That to me seemed like a discussion about why the MDF/interleaver needs
> to be represented as a separate device, I don't see anything that
> explains why the MDF cannot be a backend.
> 
> Reading the document, "Interleaved-transfer mode" doesn't trash the
> association between data and which fifo, and thereby which sensor or
> ADC, it came from. Using #io-backend-cells = <1> in the MDF, the
> sensor/ADC can provide the channel to which it is linked, and the data
> association restored. You already know what the set of interleaved channels
> is from the st,interleave property so there's no extra properties required
> for this I think.
> 
> The problem here must be that you want to access the interleaved data? That
> could be handled by having a cell value that represents the interleaved
> data (e.g. -1), rather than a channel (1-N)? That'd support systems that
> want interleaved data (like an array of identical sensors?) and systems
> using the mode for the stated aim of it in documentation of optimising
> DMA request resources who have disparate devices where interleaved data
> itself is not useful?

Sorry it took me so long to get to this. I promise I wasn't hiding - it
just happened to fall down the gaps in my various flurries of reading
IIO from latest emails back in time over the last few weeks.

I'd managed to blank the whole complexity of multi channel SD demodulators
from my mind since the earlier discussion that was linked (thanks for that
- I now remember how these work - though maybe not how we ended up with
the binding).  We are still evolving so it is also possible the solution
from that isn't how we'd do it today.

As to the question of front end vs backend question, Nuno is probably best person
to give input on that but let me have a go.

Backends tend to the datashifter / manging engines that deal with taking
data from the 'front end' which is typically the ADC device with the actual
pins to which we connect analog signals.  Examples being parallel interfaces
and the many weird and wonderful specialist SPI engines.

Front ends as mentioned are the devices to which the inputs are connected.
I think that aligns with what Conor was suggesting (and the quick discussion
we had in Prague 10 days or so back).

The problem you have with the multiple modulators is actually pretty similar
to the one we have with chained SPI devices or those weird addressable ones.
 - share a bus
 - extra address bits that allow any given device to 'sometimes' ignore messages.
 - magic registers that are written whatever the address bits.
 - Special read out sequences that let you 'stream' from multiple devices.
 - For these we currently constrain things to 'like' devices rather than a mix.

A single data pipe (the interleaver here?) is taking data from multiple front end devices.

A question here.  Do you care about mixed modulator types? The example
suggests you do.  Which puts us in the situation of something like
 ____________              _______           ___________
|Modulator 1 |            |       |         |           |
|(ADC)       |-pulsetrain-|Demod 1|-Digital-|Interleaver|
|____________|            |_______|         | (Skipping |
 ____________              _______          |  dflt as  |-> Software dmux
| Modulator 2|            |       |         |  diag too |
|(Audio/ADC) |-Pulsetrain-|Demod 2|-Digital-|  fat)     |
|____________|            |_______|         |___________|

In this if we just took the top half, then simples, the
Demodulator 1 and Interleaver (not interleaving) would
be a normal IIO Backend for the Modulator 1 (kind of
the ADC). 

If we take the whole thing (but with bottom as an Audio
channel, not an ADC) then effectively we have a backend
backing both signal types and it's up to software to unwind
what turns up in memory.

Note that a lot of what follows isn't stuff that ends
up in DT, but I'm trying to represent the dataflows through
IIO. Some of this is very idealistic :(  Also my terminology
is probably garbage. For me demods go from an encoded signal
on one line to ADC samples. I suspect that maps to the acquisition
bit of the digital filters in this device.

If they are both IIO style ADCs then this runs into the
same challenges as SPI chaining.  We really would want to
end up with a composite device that presents

 __   ____________              _______           ___________
|  |  |Modulator 1 |            |       |         |           |
|  |--|(ADC)       |-pulsetrain-|Demod 1|-Digital-|Interleaver|
|  |  |____________|            |_______|         | (Skipping |
|A |   ____________              _______          |  dflt as  |-> Software dmux
|  |  | Modulator 2|            |       |         |  diag too |
|  |--|(ADC)       |-Pulsetrain-|Demod 2|-Digital-|  fat)     |
|__|  |____________|            |_______|         |___________|

Imagine A for example was an a multichannel analog device such
as a 2 axis analog Accelemeter.  The ultimate IIO device we want
would represent that A.  We have these in tree and they work
by being consumers of ADC channels but assume those channels
come from a single IIO ADC.  Here the snag is that
Modulators 1 and and 2 would naturally be separate IIO 'devices'.
(Note there is an example like A in the datasheet - middle of figure
378 - key is the shared clock I think)

So conceptually we have

 __   ____________        _______     ___________           __________
|  |  |Modulator 1 |     |       |   |           |         | Data for |
|  |--|(ADC)       |-pdm-|Demod 1|-D-|Interleaver|        /| A chan 0 |
|  |  |____________|     |_______|   | (Skipping |       / | (mod 1)  |
|A |   ____________       _______    |  dflt as  |-SWDemux |__________|
|  |  | Modulator 2|     |       |   |  diag too |       \  __________
|  |--|(ADC)       |-pdm-|Demod 2|-D-|  fat)     |        \| Data for |
|__|  |____________|     |_______|   |___________|         | A chan 1 |
                                                           | (mod 2)  |
                                                           |__________|

But then we actually want to have A as one device which
conceptually requires a mux

 __   ____________        _______     ___________          __________
|  |  |Modulator 1 |     |       |   |           |        | Data for |
|  |--|(ADC)       |-pdm-|Demod 1|-D-|Interleaver|        | A chan 0 |
|  |  |____________|     |_______|   | (Skipping |       /| (mod 1)  |\
|A |   ____________       _______    |  dflt as  |-SWDemux|__________| SWMux - Data A
|  |  | Modulator 2|     |       |   |  diag too |       \ __________ /
|  |--|(ADC)       |-pdm-|Demod 2|-D-|  fat)     |        | Data for |
|__|  |____________|     |_______|   |___________|        | A chan 1 |
                                                          | (mod 2)  |
                                                          |__________|

Obviously in practice we want some way of flattening the and mux
so that we don't actually do anything. (FWIW we haven't yet built
a SW mux concept into IIO, though it has come up a few times for
this soft of case).

So what is what in this model.

A - Simple IIO consumer of Modulator 1 and Modulator 2.
Modulator 1/2 - IIO front end devices - each a device on its own.
Demod 1/2 + interleaver - IIO backend (data mangler)

SWdemux - new concept we need to unwind from a backend that provides
          service to a pair of front end (actually similar to the IIO
	  demux. Might be able to reuse that)
Data for A chan 0.  Kind of a virtual backend for the top half of diag.

SWMux - new concept that we haven't built - but here it is only theoretical
        anyway because we don't want to demux then remux. Trick is
        never use the apparent interfaces for the IIO devices
        representing the modulator

Anyhow, how on earth to we map this to DT. Hmm..

We don't need to represent the device A, though we may need to figure
that out by looking for devices pointing to the backend and build it
in software.

The backend should be both the demodulators and the interleaver
(which I think maps to interleaver + digital fiters + the serial
 interfaces in this case).
Stuff to the right is all software concepts.

How to indicate what is interleaved?  Maybe we do have to
represent that front end device as a consumer of channels provided
by the various ADCs (modulators here).

Other bits in the device here.
Digital filters.  Why do we need those in DT?  Aren't they software
controlled things and associate with a channel? Or are they representing
what I have as demodulators above.?

Given I think they end up in the backend we may need to extend some interfaces.

Anyhow, that probably confused anyone who previously had
any idea on how this all fits together.

Also, I should have gotten out my UK keyboard or changed keyboard layout.
US keyboard, with UK layout makes for tricky to find symbols for asci art :(

Jonathan


> 
> Thanks,
> Conor.

