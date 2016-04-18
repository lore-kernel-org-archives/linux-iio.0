Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:35838 "EHLO
	www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbcDRK7P (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Apr 2016 06:59:15 -0400
Subject: Re: [PATCH 1/5] max44000: Initial commit
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
References: <cover.1460045763.git.leonard.crestez@intel.com>
 <5dbbd82290c575f595ae0907aaf8e03117a6d017.1460045763.git.leonard.crestez@intel.com>
 <alpine.DEB.2.02.1604072142510.26969@pmeerw.net>
 <570A513A.4020106@kernel.org> <570BBDFC.6010601@intel.com>
 <57134AFA.3040406@kernel.org> <20160418103212.GQ3217@sirena.org.uk>
Cc: Crestez Dan Leonard <leonard.crestez@intel.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Daniel Baluta <daniel.baluta@intel.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <5714BDF5.8080305@metafoo.de>
Date: Mon, 18 Apr 2016 12:59:01 +0200
MIME-Version: 1.0
In-Reply-To: <20160418103212.GQ3217@sirena.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="90HLff0SFJ113eMJU2GKsPgvM4xx1DbJ9"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--90HLff0SFJ113eMJU2GKsPgvM4xx1DbJ9
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 04/18/2016 12:32 PM, Mark Brown wrote:
[...]
>>>> This always seems like a good idea, but tends to cause issues.
>>>> FLAT is really only meant for very high performance devices, you
>>>> are probably better with something else here.  If you are doing this=

>>>> deliberately to make the below writes actually occur, then please
>>>> add a comment here.
>=20
>>> I used REGCACHE_FLAT because my device has a very small number of
>>> registers and I assume it uses less memory. Honestly it would make
>>> sense for regmap to include a REGCACHE_AUTO cache_type and pick the
>>> cache implementation automatically based on number of registers.
>=20
>> I've fallen for that one in the past as well.  AUTO would indeed
>> be good if it was easy to do.
>=20
> It's extremely easy to do.  Unless you've got a good reason to do
> anything else you should always be using an rbtree.  The core would
> never select anything else.

Just to add some technical background, maybe that helps to clear things u=
p.
The rbtree does not have a one node for each register, it has one node fo=
r
each continuous register region. You can think of the rbtree regmap as a
tree with a flat cache at each node. If there is only one continuous regi=
on
there will only be one node and the behavior is very similar to the flat =
cache.

The memory overhead is the size of single node, which is usually negligib=
le.

For register reads and writes there is a slight overhead of looking up th=
e
node. But since the rbtree caches the node that was looked up last the
overhead is just checking if the current node is still the correct one
(which it will be since there is only one node). This check is about 4-5 =
hw
instructions which is completely negligible to the time it takes to execu=
te
the SPI or I2C transfer. The only place where flat makes sense is where t=
he
hardware register access itself only takes a few CPU cycles and where the=

overhead of the lookup is noticeable.


--90HLff0SFJ113eMJU2GKsPgvM4xx1DbJ9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXFL38AAoJEOj3aLScRbOZJMAP/Rk79pMpjI70Lvn9LDcdQBdk
KQhb6ptP5vp/gA4EqT0i4AXC94/20Rpa6e8ipa+PgKjcy0HYfo6+Cu32QRWgHPe6
pj/AEq1SeZajyXPc599tfCZ9sRFM129chQ+N1smkUr79wiCcto6Pp1ENEhY4Indw
Rg7Aj0U0S4GANJNVvJ04M9D0fkP7SzvMGeGFTh2o7b9b4ryizcm9rCsUhCGCrmy1
o04JDj7EhUC5RoVP8FOSk01FMlkpRubBipaPvFLrjBzj9MX8W0iVC62HE7UbHqwJ
iW4di05ZpeBKkyk9+CKGPiya3BanwiU+Zn8yLjPE/+OVriET5t9FRYTgkTqsAX69
ClVh1yicFGhUvS5XgaPzNZpV0h46Q52Zy33csFLulOvW/SD0vc9ywL4T8WvXdz5q
9GMR6VJ7AM+CfHVqTwLAD6Oe1laH00Zk1Cin5IR2yEhrsBefZtMUDrhP9osS5OwB
s7mfiy6kj43d0kyv9EY4/cI68b287oSiyPXmggSxF5xgaA6cuHuuoPi7dFCG7wi+
vP0UtjmyZxH1eFukM4HPYECofC3luQdMdYiGjoi4nH8qFryYKq6ByidTlwMUoI3x
nqBGt4yybmxIKAETWHbMBtAH7edwk9XAI9ZPNFEJDf29JJI7SpkTmKPt8Hx+taf0
fF3CbdqE6D/X35EHvdtv
=LgaY
-----END PGP SIGNATURE-----

--90HLff0SFJ113eMJU2GKsPgvM4xx1DbJ9--
