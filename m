Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:55881 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825Ab1I1ImK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 28 Sep 2011 04:42:10 -0400
Message-ID: <4E82DFD7.3000906@cam.ac.uk>
Date: Wed, 28 Sep 2011 09:50:31 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: JohnLM <johnlm@apollo.lv>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: New board potentially using IIO
References: <20110928014131.2dc76061@isg005>
In-Reply-To: <20110928014131.2dc76061@isg005>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/27/11 23:41, JohnLM wrote:
> Hello Jonathan!
>=20
> I wasn't exactly sure if this topic is worth discussing on linux-iio
> or it'd just cause more "noise". So I just wrote it to you.
> (Since you're -- from what I can understand -- maintainer of IIO)
Should be on linux-iio (people can ignore it if not interested!)
So I've cc'd the list.
>=20
> The thing is... I'm working in a project and we're developing a sort =
of
> DAQ (Data acquisition) device. It's still pretty much on initial
> brainstorming stage.
>=20
> Few things are laid down however - it shall be a PCI-Express device
> with potentially very fast (fuzzy definition here, but assume tens or
> hundreds of MSPS) data sources/sinks (or "channels" by Comedi terms).
> And I have simple and fairly generic protocol to exchange data over
> PCIe.
>=20
> Not to go into details too much I'll get to my questions.
> What's the current status with IIO and how it relates to Comedi?
=46irstly my knowledge of Comedi is somewhat light (tediously NI won't
give me docs for the only card I actually want to use it for and
it isn't supported - but that is another story!)

We've mostly kept clear of Comedi (other than for inspiration in
some areas).  Traditionally Comedi has covered high speed
daq cards in relatively high end machines.  We very much wanted to
have a clear progression from slow and simple drivers (basically hwmon
type interfaces where you read from human readable sysfs files) through
to the low overhead / high data rate end.  Right now though we don't ha=
ve
any truely high speed devices.

There has also been some discussion about sharing interfaces with comed=
i
but for now that has stalled because no one has had the time to look in=
to
it.  To my quick glance it looked like comedi was pretty much always us=
ed
through a standard userspace library so such sharing would probably occ=
ur
at the library interface level. Comedi is old and big so carries a lot
of legacy stuff very different to how it would be developed today.

I know there have been some suggestions that eventually some comedi
stuff might migrate to IIO, but right now no one has any time to even
see if that is feasible! (he says but who knows what others are looking
at!)
=20

> I can
> see IIO in progress of being moved out of staging, which is nice.
> What's the support for outputting data to the device?=20
Very basic.  Right now there are two types of output. Simple
dac controls via single sysfs files - write a value and that is
what you get and dds controls which only cover small classes of
standard waveforms (square, sine etc). =20

Analog Devices are interested in a more general framework but I
don't think any work has gone in on it as yet (cc'd Michael in
case there any updates on that front).  The plan was to do
a reverse version of the buffering we have for outputs.  So
you'd set up the channel format etc for an input buffer, then
push the waveform in you want.  That would then either sit in
a software buffer and be pushed to the device on a trigger
occuring, or the device would have a hardware buffer that would
eat it up.

The exact form of the interface hasn't been pinned down as
we don't have any code yet!
> Let's say an DAC
> as a voltage source or function generator.
> Does my upcoming device driver is a good candidate to use IIO, or
> should I look elsewhere?
I'd say that depends on how much work you want to give yourself.
It would probably be easier to do under Comedi as everything is
there already.  If you did want to do it under IIO, I would first
want to open up a full discussion with the Comedi list and more
generally about whether it makes sense to try doing this stuff
in IIO. Basically, I have no interest in starting a fight
with them, but would love to get their input if we do start
supporting the level of device you describe.
>=20
> One other thing, which as a newbie kernel hacker couldn't really find
> answer on.
> How should I go about putting a driver for prototype device in mainli=
ne
> kernel? Putting it in staging is obvious, but should I put it in
> mainline at all?
Usual question is whether two people might be interested / using it.
Their are whole architectures in there with only one physical device
in existence, so if you want to work with mainline then do so (and
I'd encourage you to indeed do that!).

I wouldn't necessarily bother with staging unless it is dependent on
stuff in there (e.g. IIO :). It makes sense when you are looking for
more general public code exposure or it is useful to others, but in
your case mailing list posts etc may be a better work flow.

>=20
> Thanks in advance.
>=20
> --
> J=C4=81nis "JohnLM" =C5=A0m=C4=93di=C5=86=C5=A1

