Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr00056.outbound.protection.outlook.com ([40.107.0.56]:35119
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751833AbdGGIzA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 7 Jul 2017 04:55:00 -0400
From: Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "singhalsimran0@gmail.com" <singhalsimran0@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "b38611@freescale.com" <b38611@freescale.com>,
        Andy Duan <fugang.duan@nxp.com>
Subject: RE: [PATCH] iio: adc: vf610_adc: Fix VALT selection value for REFSEL
 bits
Date: Fri, 7 Jul 2017 08:54:56 +0000
Message-ID: <VI1PR04MB1021E1AAED7C72C7FCB78564DFAA0@VI1PR04MB1021.eurprd04.prod.outlook.com>
References: <1499332001-8486-1-git-send-email-stefan-gabriel.mirea@nxp.com>
 <20170706194101.428c49a1@kernel.org>
In-Reply-To: <20170706194101.428c49a1@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan Cameron <jic23@kernel.org> writes:
> Looks good.
>=20
> Applied to the fixes to greg branch of iio.git.

Thank you.

> Cc'd Fugang as the original author.
>=20
> Btw if you know the author is no longer available, adding a note below th=
e
>   --- saves on me trying to get hold of them!

I only took maintainers from the get_maintainer.pl output. Now I Cc'd Andy
Duan on his new address as well.

Stefan
