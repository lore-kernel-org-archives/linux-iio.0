Return-Path: <vapier.adi@gmail.com>
MIME-Version: 1.0
Sender: vapier.adi@gmail.com
In-Reply-To: <4CC4C2B8.2@cam.ac.uk>
References: <1287955358-3153-1-git-send-email-vapier@gentoo.org> <4CC4C2B8.2@cam.ac.uk>
From: Mike Frysinger <vapier@gentoo.org>
Date: Sun, 24 Oct 2010 19:45:06 -0400
Message-ID: <AANLkTi=p3ArLzC_qz85emJeXytpnR2F9pzeG647Qj2Ek@mail.gmail.com>
Subject: Re: [Device-drivers-devel] [PATCH 00/36] staging: iio: ADI drivers
 for staging-next
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, Oct 24, 2010 at 19:35, Jonathan Cameron wrote:
> On 10/24/10 22:22, Mike Frysinger wrote:
>> I've rebased all the drivers onto staging-next. =C2=A0I've only fixed th=
e API
>> breakage due to the changes made after 2.6.36 (and fixed a few warnings)=
.
>> I've also run checkpatch across these.
>>
>> I have not however addressed any real feedback Jonathan has provided wit=
h
>> regards to driver correctness or direction. =C2=A0That stuff I'm leaving=
 up to
>> Michael Hennerich since it's his job and he actually understands this.
>>
>> Where possible, I'd like to have drivers merged so as to avoid another
>> round of "new API just broke all your drivers". =C2=A0We will still look=
 into
>> feedback given, but we'd like to focus on that rather than random `sed`
>> changes as API names change.
>>
>> This patchset supersedes all other "new driver" patches I've posted in t=
he
>> last 48 hours.
>
> As we are still in staging, I'm happy to see these merge into IIO with so=
me provisos
> (this wouldn't be acceptable anywhere else in the kernel tree).
>
> * We will be breaking abi's and probably even config symbol names cleanin=
g these up.
> =C2=A0So if your customers start complaining you get to explain why to th=
em :)

it wont be an issue.  we make it clear to people who use the IIO stuff
that this is in heavy development and people have been OK with that.

> * We sought out some test coverage for these. I want someone I can poke i=
f we
> =C2=A0get a bug report, happy to use a generic address as long as someone=
 is able
> =C2=A0to respond in reasonable time! (no complaints so far with Analog, b=
ut this is
> =C2=A0a lot of new devices for someone to have wired up somewhere)

i can add a MAINTAINERS entry for all ADI IIO drivers if that's
sufficient.  any question about using Linux and an ADI part we are
happy to answer.

> * If Randy or any one else reports build issues with weird combinations, =
someone
> =C2=A0other than me quickly fixes them.

i think the MAINTAINERS would cover this too

> * I want some proper proposals of abi's for the new classes of device. Le=
ts debate
> =C2=A0these on list. I would probably get round to doing this myself even=
tually, but
> =C2=A0if someone who knows the device class does it, things will proceed =
much faster.
> =C2=A0I've never used a resolver and had to google what they were ;)
> =C2=A0Having poorly defined abi's has bitten us a few times in the past a=
nd tends to
> =C2=A0put others off using the subsystem. =C2=A0So lets at least bash out=
 what they should
> =C2=A0be even if it takes a little while to bring the drivers up to date.

that'd be for Michael Hennerich

> * As per standard staging rules, I will ask Greg to drop any driver that =
no one is
> =C2=A0willing to support. =C2=A0I will give plenty of warning of course!

np

> * Some of the temp chips might want to be in hwmon. I would like to see a=
n open
> =C2=A0discussion across both lists of whether then should be in IIO or th=
ere (or both).

there has been discussion in the past in this regard.  but i dont
recall where it occurred.

> The negatives of merging this set as is are that people might copy code w=
ith issues
> we haven't fixed yet. =C2=A0Such is life I guess. We could put a big note=
 in the TODO
> file, but then, who reads that?

we have a tracker where we log all device driver feedback and assign
to developers:
  https://blackfin.uclinux.org/gf/project/device-drivers/tracker/
-mike
