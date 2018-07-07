Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753949AbeGGQps (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Jul 2018 12:45:48 -0400
Date: Sat, 7 Jul 2018 17:45:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sean =?UTF-8?B?Tnlla2rDpnI=?= <sean.nyekjaer@prevas.dk>
Cc: Colin King <colin.king@canonical.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: remove redundant variable 'shift'
Message-ID: <20180707174543.1f67e22d@archlinux>
In-Reply-To: <62141c55-575a-d068-360a-e0ea53df6f17@prevas.dk>
References: <20180702102435.16724-1-colin.king@canonical.com>
        <62141c55-575a-d068-360a-e0ea53df6f17@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 2 Jul 2018 12:43:20 +0200
Sean Nyekj=C3=A6r <sean.nyekjaer@prevas.dk> wrote:

> On 2018-07-02 12:24, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >=20
> > Variable shift is being assigned but is never used hence it is
> > redundant and can be removed.
> >=20
> > Cleans up two clang warnings:
> > warning: variable =E2=80=98shift=E2=80=99 set but not used [-Wunused-bu=
t-set-variable]
> >=20
> > Signed-off-by: Colin Ian King <colin.king@canonical.com> =20
> Reviewed-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
>=20
> Good catch :-)
>=20
> BR
> /Sean
Hi Colin,

As ever, thanks for the patch!

If you wouldn't mind putting the name of the driver in question in patches
like these that would be great.    There are enough drivers, that I doubt
anyone (other than me) looks at all patches for DACs.  They only look at
the particular parts they actually have on boards ;)

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan


