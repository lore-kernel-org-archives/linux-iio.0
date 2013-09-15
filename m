Return-Path: <ydroneaud@opteya.com>
Message-ID: <1379262842.9257.1.camel@dworkin>
Subject: Re: [PATCH v3 8/8] industrialio: use anon_inode_getfd() with
 O_CLOEXEC flag
From: Yann Droneaud <ydroneaud@opteya.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Date: Sun, 15 Sep 2013 18:34:02 +0200
In-Reply-To: <5235DFD2.4050008@kernel.org>
References: <cover.1378460926.git.ydroneaud@opteya.com>
	 <91c7332bc0616447587ec64a0c8f512a1d9e498d.1378460926.git.ydroneaud@opteya.com>
	 <5235DFD2.4050008@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi,

Le dimanche 15 septembre 2013 =C3=A0 17:26 +0100, Jonathan Cameron a =C3=A9=
crit :
> On 09/06/13 11:39, Yann Droneaud wrote:

[...]

> >   http://lkml.kernel.org/r/cover.1377372576.git.ydroneaud@opteya.com
> >=20
> > Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
> > Link: http://lkml.kernel.org/r/cover.1378460926.git.ydroneaud@opteya.co=
m
>=20
> Thanks Yann.  I had no idea about this issue but your well supported desc=
ription
> above made this easy to review.
>=20
> Applied to the togreg branch of git://git.kernel.org/pub/scm/linux/kernel=
/git/jic23/iio.git
> as it's not a regression but if there is support for pushing this back to=
 stable
> I personally am not against it.
>=20

It's not a -stable materiel. So let it flow to v3.12 or v3.13.

Thanks for the review.

Regards.

--=20
Yann Droneaud
OPTEYA
