Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:34794 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752895Ab3H0IPy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 27 Aug 2013 04:15:54 -0400
Date: Tue, 27 Aug 2013 10:15:50 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Josh Wu <josh.wu@atmel.com>
Cc: jic23@cam.ac.uk, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org, plagnioj@jcrosoft.com,
	nicolas.ferre@atmel.com, thomas.petazzoni@free-electrons.com,
	mark.rutland@arm.com, b.brezillon@overkiz.com
Subject: Re: [PATCH v2 2/4] iio: at91: Use different prescal, startup mask in
 MR for different IP
Message-ID: <20130827081550.GF2695@lukather>
References: <1376219071-29946-1-git-send-email-josh.wu@atmel.com>
 <1376219071-29946-3-git-send-email-josh.wu@atmel.com>
 <20130815192044.GD12162@lukather>
 <5215DF2C.3050502@atmel.com>
 <5215DF7C.2020909@atmel.com>
 <20130823154603.GA7468@ludovic.desroches@atmel.com>
 <20130823165936.GC1230@lukather>
 <20130826083207.GB7468@ludovic.desroches@atmel.com>
 <521B27F3.1050203@atmel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b8GWCKCLzrXbuNet"
In-Reply-To: <521B27F3.1050203@atmel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--b8GWCKCLzrXbuNet
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2013 at 06:03:31PM +0800, Josh Wu wrote:
> Hi, Ludovic and Maxime
>=20
> On 8/26/2013 4:32 PM, Ludovic Desroches wrote:
> >On Fri, Aug 23, 2013 at 06:59:36PM +0200, Maxime Ripard wrote:
> >>Hi Ludovic, Josh,
> >>
> >>On Fri, Aug 23, 2013 at 05:46:03PM +0200, Desroches, Ludovic wrote:
> >>>On Thu, Aug 22, 2013 at 05:53:00PM +0800, Josh Wu wrote:
> >>>>On 8/22/2013 5:51 PM, Josh Wu wrote:
> >>>>>Hi, Maxime
> >>>>>
> >>>>>On 8/16/2013 3:20 AM, Maxime Ripard wrote:
> >>>>>>Hi Josh,
> >>>>>>
> >>>>>>On Sun, Aug 11, 2013 at 07:04:29PM +0800, Josh Wu wrote:
> >>>>>>>For at91 boards, there are different IPs for adc. Different IPs has
> >>>>>>>different STARTUP & PRESCAL mask in ADC_MR.
> >>>>>>>
> >>>>>>>This patch introduce the multiple compatible string for those
> >>>>>>>different IPs.
> >>>>>>>
> >>>>>>>Signed-off-by: Josh Wu <josh.wu@atmel.com>
> >>>>>>Overall it looks like the right ways, but I think we can take it a =
step
> >>>>>>further.
> >>>>>>
> >>>>>>I'd drop at least the atmel,adc-drdy-mask, atmel,adc-num-channels,
> >>>>>>atmel,adc-status-register, atmel,adc-trigger-register properties (a=
nd
> >>>>>>probably the triggers as well description as well).
> >>>>>yeah, right. Currently I want to drop following:
> >>>>>
> >>>>>atmel,adc-drdy-mask, atmel,adc-status-register,
> >>>>>atmel,adc-trigger-register, atmel,adc-channel-base
> >>>>>
> >>>>>For the adc-num-channels, I'd like to leave it in dt parameters.
> >>>>>It is a description for an adc capablity.
> >>>About this parameter, I'll remove it too from the dt bindings. To set =
it you
> >>>need to have a look to the datasheet and to copy a constant value into=
 the
> >>>dt. From my point of view, it means than this parameter should be mana=
ged by
> >>>the driver and by the dt.
> >>>
> >>>On the other side since there are some dynamic allocation depending on=
 this
> >>>parameter maybe it makes sense to keep it in the dt. If the user wants=
 to use
> >>>only 2 channels why doing allocation for max channel number. By the wa=
y, this
> >>>case is only valid if he uses the two first channels.
> >>I don't recall it very well, is there any reason to not have it in the
> >>DT? Can the ADC channels be used for something else? Or is it just some
> >>IP-specific number of channels?
> >>
> >It is IP-specific. I don't see what benefit we could have to keep it in =
the DT?
> >But Josh seems to have arguments to keep it.
>=20
> I'm ok to remove the channel number. What I worried is there also
> has a channel-used mask in DT.
> This mask should be removed too if channel number is removed.
> So maybe we can also use the sysfs to set the mask.

Indeed, that would make adc-channel-used irrelevant. But I'm not sure
the mask is useful at all. Just enable all the channels and that's it?

> >>>>>For the triggers, I am not decided. An obvious benifit to remove
> >>>>>trigger in dt will save many lines of code.
> >>>>>
> >>>>>>Maxime
> >>>>>>
> >>>>>Best Regards,
> >>>>>Josh Wu
> >>>Since we are talking about reworking this binding I was thinking about
> >>>resolution stuff. Filling atmel,adc-res is also copying constant value=
 from
> >>>the device datasheet, so if I was consistent I would say it has to be =
removed
> >>>too. But I am not consistent! I mean by doing this the only thing the =
user
> >>>will have to fill is the resolution value. He can't set the value he w=
ants,
> >>>there are only two choices. By keeping it into the dt then he will imm=
ediately
> >>>see the choices he has.
> >>But the resolution should probably be somehow user-defined, probably not
> >>really related to the DT has well. I think some other IIO ADC drivers
> >>are using sysfs files for this purpose, maybe that would be a better
> >>fit?
> >It sounds to be a good solution.
>=20
> ok, I will check the other IIO ADC driver about this point.
> Maybe this sysfs replacement need a bit more time. I prefer to send
> out the patches first without the sysfs implement in v3.
> And the sysfs replacement patch will be send out serperately. What
> do you think? Maxime.

Yes, of course. The resolution rework can definitely be done later.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--b8GWCKCLzrXbuNet
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSHGA2AAoJEBx+YmzsjxAgayAQAJb8BVOqHHApIFAQeo9oNLdy
qilRFC2AVACtPbgWymMFkwPxGRW+IMWv1AbZX4TTNiRYCR7scPQxi8J8Bj1kd5H9
b6Iax4/hJYji/t6PjYPyQocN66dZabKfWUz4NqbGDxPSmn+fSAMDAb/+hTHaX8L+
gkXSv7vypLrM6aDXOYSpvzpWZ0VHUjixlxpm/eaSCfDeiuaBMlVnolqho3yP59ii
qmGRvuA/vY4uuY10nP15O1uOF6rO3xaPjHOrW04C0igBmDwrysstLmKs33/wHTfZ
8WCpxQJZF3p+eWBXi9yq4sH7iB3jOMQmO0kjXFe1uLy+eFXWVgBRDDZrHiT/9rQ6
UjtEq2791Y6MBCs2c11nc7lyPQ/wh1jFIAMSYrR6Hyy2vNO6veQortxywSEVT/S/
dNNjr0L2doaIy158UTRtlgJUmECZ2CU1zZN70fnZxi6KwUdxE2cujkLsv8S1pE79
guTZmf0p2RFpT4dVIiglrNAx32I6EzZmkyWmp/FtqjUZA22/6JO0R6lRytb1DIE8
O4tl3V6MpjdlQz7yFeX1hw8XCq5ILoRsLDlLD4Ys6TWGRPFcjW2kfihE2r22fiDk
aR7WhdVf+VszECYNbR0EmUezv7SK6GL+SmF3lQwrenbaEQsvOLtWnLvAU1InRsxn
osRV130tFiz117u3uSsj
=wxDp
-----END PGP SIGNATURE-----

--b8GWCKCLzrXbuNet--
