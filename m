Return-Path: <SRS0=qmBI=5D=linaro.org=linus.walleij@kernel.org>
MIME-Version: 1.0
In-Reply-To: <b2b461d4-586d-d2e8-4188-8e25d5d7211e@cogentembedded.com>
References: <20170519144802.14427-1-nikita.yoush@cogentembedded.com>
 <20170519144802.14427-4-nikita.yoush@cogentembedded.com> <18fc343b-d7a4-c5b8-84e6-702af6e94e44@cogentembedded.com>
 <4ba5a0ce-d443-bdf0-bb23-9941b7db59a4@cogentembedded.com> <5eec10c5-9e13-b0fc-fe40-a8b74a4fdbb0@cogentembedded.com>
 <20170524203808.34aec03a@kernel.org> <b2b461d4-586d-d2e8-4188-8e25d5d7211e@cogentembedded.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 29 May 2017 19:08:59 +0200
Message-ID: <CACRpkdYLyCr2pH3ayrjgx7AZY=aWrPdFFpBfKoq=RNRT=dxztg@mail.gmail.com>
Subject: Re: [PATCH 4/4] iio: hi8435: cleanup reset gpio
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Matt Ranostay <mranostay@gmail.com>,
	Gregor Boirie <gregor.boirie@parrot.com>, Sanchayan Maity <maitysanchayan@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeff White <Jeff.White@zii.aero>,
	Chris Healy <Chris.Healy@zii.aero>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Thu, May 25, 2017 at 8:27 AM, Nikita Yushchenko
<nikita.yoush@cogentembedded.com> wrote:

> - I found that chip's reset line is active low per datasheet, but device
> tree for board I work with states it is active high

There you have it, there is a bug in the device tree, because it is
not properly describing the hardware.

> - I checked driver code and found that driver depends on this incorrect
> setting, it won't work if device tree will state that gpio is active low

Yeah...

> - I could revert values in driver code AND in device tree, this way make
> device tree be correct (against reality) but make dtb files flashed into
> existing systems incompatible with future kernels -  which I disliked

Is this one of those systems where people actually flash a DTB and
never change it?

If not, then just patch the DTS source and stop worrying already.
We don't do backwards compatibility just because it's fun.

If it is really deployed and really not seeing updates...

In that case I want a way to check the signature (such as a checksum)
of the DTB and apply a workaround for elder (incorrect) device trees
when detected, and let newer (corrected) device trees describe the
hardware properly.

> - Thus I thought that I can remove explicit definition of polarity from
> device tree (replacing it with neutrally-looking zero), and change
> driver to use _raw.  I assumed that there is no real gain to let device
> tree override gpio polarity for signal that is per-datasheet always
> active low
>
> - Thinking further on this, I realized that for common case signal
> polarity is something defined by chip, and thus this knowledge belongs
> to chip's driver and not to chip user's device tree.

That is a fallacy IMO.

Just like we define regulators for all voltage inputs on a chip and
set the voltage constraints accordingly in the device tree, so we
set the polarity of signals in the device tree.

GPIOs, like regulators, are defined in terms of the consumer
properties. Else having a signal iversion flag (*ACTIVE_LOW) would
not make sense.

> Moreover, device
> tree writer could easily be not aware of signal polarity (too many
> datasheets are NDA-closed), thus hello copy-pasting, try-and-check and
> other counterproductive approaches.

Mistakes will be made but seriously, device tree writers know as much as
driver writers do in my experience. If it is unknown they will look
at some hint from the rail, like it being named RESETN on the schematic
indicating negative (active low) polarity.

> - revert the patch, restore situation with driver depending on wrong
> statement in dts, maybe document that in bindings,
> - replace patch with code assuming that device tree has correct
> definition of reset gpio polarity; break existing device trees (all are
> out-of-tree as of today),
> - keep the patch, thus not break anything and still stop requiring
> device tree to contain wrong statement, but make entire situation
> somewhat hacky and loose support for board reverting signal between gpio
> provider and hi8435's pin (hopefully no such board exists).

I would fix the device tree and the driver to handle it correctly.

Signal active low in the device tree.

Assert with high level in the code.

Then, if backward compatibility for older device trees is needed,
find a way to detect elder device trees and then alter the behaviour
with an extra inversion on those.

Preferably by altering the device tree in memory actually, but that may be
hard. (Code for this exists.)

Yours,
Linus Walleij
