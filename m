Return-Path: <vapier.adi@gmail.com>
MIME-Version: 1.0
Sender: vapier.adi@gmail.com
In-Reply-To: <544AC56F16B56944AEC3BD4E3D59177130945B1B3C@LIMKCMBX1.ad.analog.com>
References: <1287955358-3153-1-git-send-email-vapier@gentoo.org>
 <4CC4C2B8.2@cam.ac.uk> <AANLkTi=p3ArLzC_qz85emJeXytpnR2F9pzeG647Qj2Ek@mail.gmail.com>
 <544AC56F16B56944AEC3BD4E3D59177130945B1B3C@LIMKCMBX1.ad.analog.com>
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 25 Oct 2010 20:53:02 -0400
Message-ID: <AANLkTimDSo6CbrfEiosK6mhsjk97pmsii0G=OkBFm8g=@mail.gmail.com>
Subject: Re: [Device-drivers-devel] [PATCH 00/36] staging: iio: ADI drivers
 for staging-next
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Oct 25, 2010 at 04:39, Hennerich, Michael wrote:
> Mike Frysinger wrote on 2010-10-25:
>> On Sun, Oct 24, 2010 at 19:35, Jonathan Cameron wrote:
>>> * I want some proper proposals of abi's for the new classes of device.
>>> Lets debate =C2=A0these on list. I would probably get round to doing th=
is
>>> myself eventually, but =C2=A0if someone who knows the device class does=
 it,
>>> things will proceed much faster. =C2=A0I've never used a resolver and h=
ad to
>>> google what they were ;) =C2=A0Having poorly defined abi's has bitten u=
s a
>>> few times in the past and tends to =C2=A0put others off using the subsy=
stem.
>>> =C2=A0So lets at least bash out what they should =C2=A0be even if it ta=
kes a
>>> little while to bring the drivers up to date.
>>
>> that'd be for Michael Hennerich
>
> We can start debating and refining on the exact API, to use.
> However I like to do so once these drivers have merged.
> The ones likely subject to change we can mark as EXPERIMENTAL.
> Or even print a warning using dev_warn() on probe.

i dont think that's necessary.  we're already in the staging area
which is labeled as "worse" than EXPERIMENTAL.
-mike
