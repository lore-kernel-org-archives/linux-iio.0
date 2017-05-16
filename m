Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:41643 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752120AbdEPJaG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 May 2017 05:30:06 -0400
Date: Tue, 16 May 2017 11:30:04 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, wens@csie.org, clabbe.montjoie@gmail.com,
        linux-iio@vger.kernel.org, thomas.petazzoni@free-electrons.com,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: sun4i-gpadc-iio: fix parent device being used
 in devm function
Message-ID: <20170516093004.gkot2nkmhfdll3ym@flea.home>
References: <20170515073902.25994-1-quentin.schulz@free-electrons.com>
 <20170515091148.gk2zvtjy5bdpbfzt@flea.home>
 <73eb7674-dba9-8bdf-c886-6ad8177f4c1b@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="dp6zk7vtxllzg4q5"
In-Reply-To: <73eb7674-dba9-8bdf-c886-6ad8177f4c1b@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--dp6zk7vtxllzg4q5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2017 at 11:18:45AM +0200, Quentin Schulz wrote:
> Hi Maxime,
>=20
> On 15/05/2017 11:11, Maxime Ripard wrote:
> > On Mon, May 15, 2017 at 09:39:02AM +0200, Quentin Schulz wrote:
> >> For the sake of DT binding stability, this IIO driver is a child of an
> >> MFD driver for Allwinner A10, A13 and A31 because there already exists=
 a
> >> DT binding for this IP. The MFD driver has a DT node but the IIO driver
> >> does not.
> >>
> >> The IIO device registers the temperature sensor in the thermal framewo=
rk
> >> using the DT node of the parent, the MFD device, so the thermal
> >> framework could match the phandle to the MFD device in the DT and the
> >> struct device used to register in the thermal framework.
> >>
> >> devm_thermal_zone_of_sensor_register was previously used to register t=
he
> >> thermal sensor with the parent struct device of the IIO device,
> >> representing the MFD device. By doing so, we registered actually the
> >> parent in the devm routine and not the actual IIO device.
> >>
> >> This lead to the devm unregister function not being called when the IIO
> >> module driver is removed. It resulted in the thermal framework still
> >> polling the get_temp function of the IIO module while the device doesn=
't
> >> exist anymore, thus generated a kernel panic.
> >>
> >> Use the non-devm function instead and do the unregister manually in the
> >> remove function.
> >>
> >> Fixes: d1caa9905538 ("iio: adc: add support for Allwinner SoCs ADC")
> >>
> >> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> >> Reported-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> >> ---
> [...]
> >> @@ -688,6 +687,12 @@ static int sun4i_gpadc_remove(struct platform_dev=
ice *pdev)
> >> =20
> >>  	pm_runtime_put(&pdev->dev);
> >>  	pm_runtime_disable(&pdev->dev);
> >> +
> >> +	if (pdev->dev.of_node)
> >> +		thermal_zone_of_sensor_unregister(&pdev->dev, info->tzd);
> >> +	else
> >> +		thermal_zone_of_sensor_unregister(pdev->dev.parent, info->tzd);
> >> +
> >=20
> > Can't we just store the device used to create the zone in the
> > structure as well, that would avoid that non-trivial logic.
> >=20
>=20
> Yes we could.
>=20
> I've that same condition in the probe function, if pdev->dev.of_node
> then I continue in the probe dedicated to device probed from DT, or I
> continue with the probe dedicated to device probed via MFD.
>=20
> The thermal_zone_of_sensor_register is different in those two functions,
> thus, I thought that it would make more sense to replicate the same
> condition in the remove to make the relation between the device used in
> thermal_zone_of_sensor_register and unregister clear.
>=20
> That's just a matter of taste for me, so I'm definitely ok to write a v2
> for this change.

My point was only a cosmetic one. It's true that you have teh same
condition somewhere else, but you also have a lot of comments to
explain why there, and you don't have them here.

Adding a pointer to the structure would make it trivial for the
reader, without having to duplicate the comments.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--dp6zk7vtxllzg4q5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZGsacAAoJEBx+YmzsjxAgpJYP/1iBpumdJPUMV1nonhx/P/bO
XYtSNZ1svNLq3s2QDS4yyhTs8qSSjq716X8YbbVmnh02rMpKcLnD+CR1huH+8Fue
NP+IoR8XKHCwYfgRZgDUXpmTCbJWYkUSxuVHkhpxWwZnXnqOX3mRmkS+KynMn/nC
zz4cdZahmNp6MLZNVxCh06bnwgZQtk/2vPN07ZuiDsB8z9s6oLYYI8izFbDFpNhT
iA7tuVJJZeAAjlFHwz9zS+SVY+lg6ovEE/O+8yv3+IEg7ewrPW8PZ3gl8LWQjz6m
dPD8I/eDUDzI1/dR10be2QDTXtO2R3sDYTcA2gc78FkaDrqcLIgouPdFKgXMsIDS
Hm0ndKT0L53N3mQic0idTWaWDpLYP/wg8KpDuOug2RvsCzmepD3qau6Y2hv/uHtG
XfVtS49a/arh5dWZUh9B/sj28ZvcxtRhcWGYLZ36yuFjrOYQdQLwRXGMiAXlkprt
V/vt9qaBXeCobIqPoe4LpDPZRAumOiu2dhwIolZrZoofPa/UeytFDJBx9le+1Uhb
mzK4qqTBF7HpgCLHAsc+BzhnIEvebyH5C3E/avyXKae44MoTmVPNw9zX9Mi2+wmG
6/7RCMDTXpOs4EKF4mG2GJdiEE4S6cZwdjyS6810RFmDmuYToNTmpfXnms9fGKfs
nZIlsmnYZPdX9GRobIKJ
=UnpK
-----END PGP SIGNATURE-----

--dp6zk7vtxllzg4q5--
