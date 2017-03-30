Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:39288 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933803AbdC3PGA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 30 Mar 2017 11:06:00 -0400
Date: Thu, 30 Mar 2017 17:05:57 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: cl@rock-chips.com
Cc: heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com,
        zhengxing@rock-chips.com, andy.yan@rock-chips.com,
        jay.xu@rock-chips.com, matthias.bgg@gmail.com,
        paweljarosz3691@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, wxt@rock-chips.com,
        david.wu@rock-chips.com, linux-iio@vger.kernel.org,
        shawn.lin@rock-chips.com, akpm@linux-foundation.org,
        dianders@chromium.org, yamada.masahiro@socionext.com,
        catalin.marinas@arm.com, will.deacon@arm.com, afaerber@suse.de,
        shawnguo@kernel.org, khilman@baylibre.com, arnd@arndb.de,
        fabio.estevam@nxp.com, zhangqing@rock-chips.com,
        kever.yang@rock-chips.com, tony.xie@rock-chips.com,
        huangtao@rock-chips.com, yhx@rock-chips.com,
        rocky.hao@rock-chips.com
Subject: Re: [PATCH v4 0/6] initialize dtsi file and dts file for RK3328 SoCs
Message-ID: <20170330150557.znttalrsxpnmccx6@ninjato>
References: <1490607650-18650-1-git-send-email-cl@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="t3raypotlh7kogkn"
In-Reply-To: <1490607650-18650-1-git-send-email-cl@rock-chips.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--t3raypotlh7kogkn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2017 at 05:40:45PM +0800, cl@rock-chips.com wrote:
> From: Liang Chen <cl@rock-chips.com>
>=20
> Changes in v4:
>     Remove some assigned-clocks as they should be inited in their
>     respective device nodes.
>=20
> Changes in v3:
>     Adjust some descriptions in dtsi.
>=20
> Changes in v2:
>     Remove RK_FUNC_* in dtsi as it dose not help understand things better.
>     Adjust the order of description in dt-bindings.
>=20
> v1:
> These patchs depend on pinctrl patchs as below:

Why didn't you renumber the patches? I and probably others wondered
where and what patch 2 is and why it could be missing. I recall now that
I applied it already. Other maintainers don't have that knowledge. Also,
since I applied your patch, no need for me or the i2c-list to be on CC.

Please no "quick fixes" when sending out patch series. I know it is
tempting but it usually creates confusion.


--t3raypotlh7kogkn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljdHtUACgkQFA3kzBSg
KbbzJw/+NWUSFD9p+NewJsQ4meU2Lruf1wjsyLTvZDtWkdSCSq7EIlrLsOxO6g7E
4ntxCrdpSsIXszhwLumzCkVtqVPtiXKxSUei3JQFiDmS1fPol6r9ab5p1S+mVakl
rgK7NCXsYL+BwZtUdZ/VTBnu2xmOETD2IdvvuYLBnSkmARmOEXHPIYszJj0C5DnE
SJo73LkZ8uLrLhdp8gEDXEm8Iag507OPFr+PuZgKMjHoFruAmIFg4awan0AKskjs
Re0o46PV1oOybp64+CszmLD8sDJE9c7pvRjzYxLi9hPAY22Dybgnt95jYahHcn+J
lUrD/M6WuNbKDziecRkbGPWpwRojttLLCfPstCVk+WCEHW+3kAl1LMaWeh6ILw/t
p0KNc+xaYd9CUs1/0pjc8OWJEQRaudJHNQ5JeHPYcV8M1SuJoE/MSOfrrW589NBM
nN3qTY0WJWYX5HJoWqXyPR+/sfiWwkhuLopgiGZSYnk7qbl4n/UGjiv8NCYHpifm
57GIwkn48phYLVWNRMyLwwe/x7+JLrDxM6ItvL6HGkfb3MlQEMyxY0Ooky9xnCV8
7MjNdIUZdyD6g4BDz7brTV7tbVBoJuozjmO/ha+jBqSfpay4hHs8gfx+U/PafklF
dZxhEAuYqVjU4oGg/OdZwANj2izeRstKt1AalFrdrAWEoUoxVuk=
=4ZYN
-----END PGP SIGNATURE-----

--t3raypotlh7kogkn--
