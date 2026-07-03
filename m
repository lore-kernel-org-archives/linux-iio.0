Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E62346769;
	Fri,  3 Jul 2026 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783088552; cv=none; b=qmpB+0TtGV5EwVxWtkP/EIy9lrovvlp9RuWErlZhY6WPW3N4FjFLBWF6n+R8VABqw5b24WKF4Xq1jESewkoDIfcvsz8NxVsF4vbRPHHdtnmJAbAxErtiM/GVC0uQXRXnAAX5L7k3axdY81gMJwrNvbMdt1bBrlc7pUAdkEf8TXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783088552; c=relaxed/simple;
	bh=Tm+wtGEfpOxeupHTCTNR6Nj8gIYTKObds3rJsZRBSAc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mTXSgstntXQP6FPgL5UQZoakI50EtAfe5Kn8InQFLT7VUsPkqCc/YGDMMLSsVoqDwIiWdPWIT8UilN3xjoWW+xQgEJuFRJFEVrcJvL7xvLytrV2OdyV6Bt1u+VuoIvJomvTuRhLRQ2a03+fBwuceQkrPWiXR8NxqIo3ITAsJ2HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S036ANL.actianordic.se
 (10.12.31.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Fri, 3 Jul
 2026 16:22:21 +0200
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%3]) with mapi id
 15.01.2507.061; Fri, 3 Jul 2026 16:22:20 +0200
From: Andreas Kempe <andreas.kempe@actia.se>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?iso-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: imu: st_lsm6dsx: deselect shub page before
 reading whoami
Thread-Topic: [PATCH v2] iio: imu: st_lsm6dsx: deselect shub page before
 reading whoami
Thread-Index: AQHdCg9TzIHoqzc+tky4sQ8AXUYya7ZaAbcAgABSTICAAWUOAA==
Date: Fri, 3 Jul 2026 14:22:20 +0000
Message-ID: <akfFnFUk3mKjCoqh@w570anl.actianordic.se>
References: <20260702104059.1744219-1-andreas.kempe@actia.se>
 <akZVDry41WEl5y4Y@lore-desk> <20260702180423.2c9e4c8c@jic23-huawei>
In-Reply-To: <20260702180423.2c9e4c8c@jic23-huawei>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-esetresult: clean, is OK
x-esetid: 37303A2955B1445F6C7162
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <78729CEE786CEF41AA997B80234E1893@actia.se>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Den Thu, Jul 02, 2026 at 06:04:23PM +0100, skrev Jonathan Cameron:
> On Thu, 2 Jul 2026 14:09:50 +0200
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > > As part of driver initialization, e.g. st_lsm6dsx_init_shub() selects
> > > the shub register page using st_lsm6dsx_set_page(). Selecting the shu=
b
> > > register page shadows the regular register space so whoami, among oth=
er
> > > registers, is no longer accessible.
> > >
> > > In applications where the IMU is permanently powered separately from =
the
> > > processor, there is a window where a reset of the CPU leaves the IMU =
in
> > > the shub register page. Once this occurs, any subsequent probe attemp=
t
> > > fails because of the register shadowing.
> > >
> > > Using the ism330dlc, the error typically looks like
> > >
> > >     st_lsm6dsx_i2c 3-006a: unsupported whoami [10]
> > >
> > > with the unknown whoami read from a reserved register in the shub pag=
e.
> > >
> > > The reset register is also shadowed by the page select, preventing a
> > > reset from recovering the chip.
> > >
> > > Unconditionally clear the shub page before the whoami readout to ensu=
re
> > > normal register access and allow the initialization to proceed.
> > >
> > > Place the fix in st_lsm6dsx_check_whoami() before the whoami check
> > > because hw->settings, which st_lsm6dsx_set_page() relies on, is first
> > > assigned in that function.
> > >
> > > Placing the fix in a more logical place than the whoami check would
> > > require a bigger restructuring of the code.
> > >
> > > Signed-off-by: Andreas Kempe <andreas.kempe@actia.se>
> > > ---
> > >
> > >  Changes in v2:
> > >    - Drop st_lsm6dsx_get_page() and unconditionally clear the shub pa=
ge.
> > >    - Make the code comment clearer.
> > >    - Document the placement rationale in the commit message.
> > >    - Link to v1: https://lore.kernel.org/linux-iio/20260604132646.109=
9072-1-andreas.kempe@actia.se/
> > >
> > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 21 ++++++++++++++++++=
+-
> > >  1 file changed, 20 insertions(+), 1 deletion(-)
> >
> > Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >
> Given I assume we want to backport this, please send an appropriate
> Fixes tag in response to this email.
>=20

Fixes: c91c1c844ebd ("iio: imu: st_lsm6dsx: add i2c embedded controller sup=
port")

> > >
> > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/i=
io/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > index 630e2cae6f19..f4edcb73ec8c 100644
> > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > @@ -1712,6 +1712,26 @@ static int st_lsm6dsx_check_whoami(struct st_l=
sm6dsx_hw *hw, int id,
> > >             return -ENODEV;
> > >     }
> > >
> > > +   hw->settings =3D &st_lsm6dsx_sensor_settings[i];
> > > +
> > > +   if (hw->settings->shub_settings.page_mux.addr) {
> > > +           /*
> > > +            * If the IMU has the shub page selected on init, for exa=
mple
> > > +            * after a CPU watchdog reset while the page is selected,=
 the
> > > +            * regular register space is shadowed. While the regular
> > > +            * register space is shadowed, the registers needed for
> > > +            * initializing the IMU are not available.
> > > +            *
> > > +            * Unconditionally clear the shub page selection to ensur=
e
> > > +            * normal register access.
> > > +            */
> > > +           err =3D st_lsm6dsx_set_page(hw, false);
> > > +           if (err < 0) {
> > > +                   dev_err(hw->dev, "failed to clear shub page\n");
> > > +                   return err;
> > > +           }
> > > +   }
> > > +
> > >     err =3D regmap_read(hw->regmap, ST_LSM6DSX_REG_WHOAMI_ADDR, &data=
);
> > >     if (err < 0) {
> > >             dev_err(hw->dev, "failed to read whoami register\n");
> > > @@ -1724,7 +1744,6 @@ static int st_lsm6dsx_check_whoami(struct st_ls=
m6dsx_hw *hw, int id,
> > >     }
> > >
> > >     *name =3D st_lsm6dsx_sensor_settings[i].id[j].name;
> > > -   hw->settings =3D &st_lsm6dsx_sensor_settings[i];
> > >
> > >     return 0;
> > >  }
> > > --
> > > 2.53.0
>=20
> CAUTION: This email originated from outside of the organization. Do not c=
lick links or open attachments unless you recognize the sender and know the=
 content is safe.
> =
