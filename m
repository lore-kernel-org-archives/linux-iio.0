Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:35358 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752906Ab3H0JrQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 27 Aug 2013 05:47:16 -0400
Date: Tue, 27 Aug 2013 11:47:12 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Josh Wu <josh.wu@atmel.com>, jic23@cam.ac.uk,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	plagnioj@jcrosoft.com, thomas.petazzoni@free-electrons.com,
	mark.rutland@arm.com, b.brezillon@overkiz.com
Subject: Re: [PATCH v2 2/4] iio: at91: Use different prescal, startup mask in
 MR for different IP
Message-ID: <20130827094712.GH2695@lukather>
References: <1376219071-29946-3-git-send-email-josh.wu@atmel.com>
 <20130815192044.GD12162@lukather>
 <5215DF2C.3050502@atmel.com>
 <5215DF7C.2020909@atmel.com>
 <20130823154603.GA7468@ludovic.desroches@atmel.com>
 <20130823165936.GC1230@lukather>
 <20130826083207.GB7468@ludovic.desroches@atmel.com>
 <521B27F3.1050203@atmel.com>
 <20130827081550.GF2695@lukather>
 <521C6BD2.7070602@atmel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDnEQgWzhgf+8aPe"
In-Reply-To: <521C6BD2.7070602@atmel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--dDnEQgWzhgf+8aPe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On Tue, Aug 27, 2013 at 11:05:22AM +0200, Nicolas Ferre wrote:
> On 27/08/2013 10:15, Maxime Ripard :
> >On Mon, Aug 26, 2013 at 06:03:31PM +0800, Josh Wu wrote:
> >>Hi, Ludovic and Maxime
> >>
> >>On 8/26/2013 4:32 PM, Ludovic Desroches wrote:
> >>>On Fri, Aug 23, 2013 at 06:59:36PM +0200, Maxime Ripard wrote:
> >>>>Hi Ludovic, Josh,
> >>>>
> >>>>On Fri, Aug 23, 2013 at 05:46:03PM +0200, Desroches, Ludovic wrote:
> >>>>>On Thu, Aug 22, 2013 at 05:53:00PM +0800, Josh Wu wrote:
> >>>>>>On 8/22/2013 5:51 PM, Josh Wu wrote:
> >>>>>>>Hi, Maxime
> >>>>>>>
> >>>>>>>On 8/16/2013 3:20 AM, Maxime Ripard wrote:
> >>>>>>>>Hi Josh,
> >>>>>>>>
> >>>>>>>>On Sun, Aug 11, 2013 at 07:04:29PM +0800, Josh Wu wrote:
> >>>>>>>>>For at91 boards, there are different IPs for adc. Different IPs =
has
> >>>>>>>>>different STARTUP & PRESCAL mask in ADC_MR.
> >>>>>>>>>
> >>>>>>>>>This patch introduce the multiple compatible string for those
> >>>>>>>>>different IPs.
> >>>>>>>>>
> >>>>>>>>>Signed-off-by: Josh Wu <josh.wu@atmel.com>
> >>>>>>>>Overall it looks like the right ways, but I think we can take it =
a step
> >>>>>>>>further.
> >>>>>>>>
> >>>>>>>>I'd drop at least the atmel,adc-drdy-mask, atmel,adc-num-channels,
> >>>>>>>>atmel,adc-status-register, atmel,adc-trigger-register properties =
(and
> >>>>>>>>probably the triggers as well description as well).
> >>>>>>>yeah, right. Currently I want to drop following:
> >>>>>>>
> >>>>>>>atmel,adc-drdy-mask, atmel,adc-status-register,
> >>>>>>>atmel,adc-trigger-register, atmel,adc-channel-base
> >>>>>>>
> >>>>>>>For the adc-num-channels, I'd like to leave it in dt parameters.
> >>>>>>>It is a description for an adc capablity.
> >>>>>About this parameter, I'll remove it too from the dt bindings. To se=
t it you
> >>>>>need to have a look to the datasheet and to copy a constant value in=
to the
> >>>>>dt. From my point of view, it means than this parameter should be ma=
naged by
> >>>>>the driver and by the dt.
> >>>>>
> >>>>>On the other side since there are some dynamic allocation depending =
on this
> >>>>>parameter maybe it makes sense to keep it in the dt. If the user wan=
ts to use
> >>>>>only 2 channels why doing allocation for max channel number. By the =
way, this
> >>>>>case is only valid if he uses the two first channels.
> >>>>I don't recall it very well, is there any reason to not have it in the
> >>>>DT? Can the ADC channels be used for something else? Or is it just so=
me
> >>>>IP-specific number of channels?
> >>>>
> >>>It is IP-specific. I don't see what benefit we could have to keep it i=
n the DT?
> >>>But Josh seems to have arguments to keep it.
> >>
> >>I'm ok to remove the channel number. What I worried is there also
> >>has a channel-used mask in DT.
> >>This mask should be removed too if channel number is removed.
> >>So maybe we can also use the sysfs to set the mask.
> >
> >Indeed, that would make adc-channel-used irrelevant. But I'm not sure
> >the mask is useful at all. Just enable all the channels and that's it?
>=20
> On the top of my head: keeping all channels enabled, won't it have
> an impact on:
> 1/ power consumption?
> 2/ minimum period of sampling for a particular channel in case of
>    continuous ADC trigger?

I don't know, you tell me ;)

This is exactly why I was asking.

> And do not forget that sysfs is an interface that is:
> - needing a userspace tool to be configured properly (even just an
>   echo xx)
> - hard to design
> - a strict ABI that can't be changed once deployed
>=20
> But yes, it is true that if the user has to configure ADC at
> runtime, it is certainly an interface worth considering...

Yes, of course. But the resolution is something I'd expect to be
user-configurable, probably at runtime, and the DT doesn't make it very
convenient to achieve.

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--dDnEQgWzhgf+8aPe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSHHWgAAoJEBx+YmzsjxAgls4QAJ/nhGucIA0j3HiXVgucWtdN
81P0uIYj69pVOq6d75LtzE34bg2z1bokJhEf4AQ8eJjISRZzptvY/lx37gcafxR/
46oKFWqZh9v9xhuXrom4LnlmV1w23Zj/5+djrH0vGQXYKjjTVrKWfe7K4ugDBQap
HWg9DBTLzSYT7rdFffG8rzSQgBt9vXp7YVDRGWVIbCArjcF8mdcbwsCghzLuCCYv
mkTWn3jVOIufGjO6XPJGAk/pXDXOMq8ohNoVCf7atUrp5yLXOev5YgtjUFhri5oW
kXJRUc2+RCtYQBs8v/1b2EMVmczKs3ukTcuDfe4Ztqup7nr+q6oX8ZQs6zolQtbd
Fgeb+LjttXQ+xUIeKnqi8knPwx2R9GpfY5rG03NHccPVKs8j6j4VyG+t4Y3+ZeZT
+RUN+BLknUJ69+i3iOkEqkkcOzvds514uXb57pbNjeXHyaf0ReRagQJdID7M1b5N
veq4EvATKrB1H4b2c9z4emWO5dBEyDYN64YZqNRfvQxE2yh95qe89P/YWEpi/75Q
N9htY58XxZw8Zyq2YbvA0xIpwt1n0bbGVXIhHRE8gY1YJMg5c9o4HkTW997dWqwq
PvyFlUUXB0iXTm3bs5K4W30qZvH0kwkPKOqytRTwDK6g5cB3eG4G17YNGde+4eov
j3YPsqM1zFFotFtJwNmX
=9eoG
-----END PGP SIGNATURE-----

--dDnEQgWzhgf+8aPe--
