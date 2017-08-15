Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34162 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753631AbdHOGbF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Aug 2017 02:31:05 -0400
Received: by mail-pg0-f41.google.com with SMTP id u185so714301pgb.1
        for <linux-iio@vger.kernel.org>; Mon, 14 Aug 2017 23:31:05 -0700 (PDT)
Date: Mon, 14 Aug 2017 23:31:00 -0700
From: Benson Leung <bleung@google.com>
To: Thierry Escande <thierry.escande@collabora.com>
Cc: Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Joseph Lo <josephl@nvidia.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Hung-yu Wu <hywu@google.com>,
        Vincent Palatin <vpalatin@chromium.org>,
        Wei-Ning Huang <wnhuang@google.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        bleung@google.com
Subject: Re: [PATCH v2 3/8] mfd: cros_ec: Stop the debugfs work when suspended
Message-ID: <20170815063100.GA99644@decatoncale.mtv.corp.google.com>
References: <1502461385-27564-1-git-send-email-thierry.escande@collabora.com>
 <1502461385-27564-4-git-send-email-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
In-Reply-To: <1502461385-27564-4-git-send-email-thierry.escande@collabora.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 11, 2017 at 04:23:00PM +0200, Thierry Escande wrote:
> From: Douglas Anderson <dianders@chromium.org>
>=20
> This patch stops the debugfs worker thread when the device is suspended.
> This change avoids messages like:
>=20
>   cros-ec-spi spi5.0: spi transfer failed: -108
>   cros-ec-spi spi5.0: cs-deassert spi transfer failed: -108
>   cros-ec-ctl cros-ec-ctl.0.auto: EC communication failed
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>

Applied.

Thanks,
Benson
--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJZkpUkAAoJEB8J9XsKL+ZYKVEP/ih/rZZlj3rddyGTvy6WGQpl
8CfXCkdOMoK0UJVZPqFnKhcizBzYBmP251joNaKted+uvAHCrGeHZhXSU4keq5Ir
PeubW85SdAResPw39F9lQi1dA54vEW+jDkU+nNorcP4RiXKNknptCbWhuHkTgOLt
ZU8D+jSYPWvcUHsQilpB3P9nvFvN9vaWILMS8HxFGdBaN6FdpwT5NYp4vdFfwSzI
lhcV4f/IfVLzpPR3iHG+IeXcBTh++Dz55Yi/25oFDqpQe3xMZ2r+GdWyLa1nRvwM
b6EQNQbU0BloX6oLzccaoRKdZyM04cLtTKu5BWqsWFhf3H9SyqwUwYcmEJccaXJw
6E+6AmfeXjRi0s3Ygzj/7/uMXi8ZuMo9dvZj7/aqCMx3BePOsFSIlxnjqXOjuxRY
Je9N3Dk9TGVJGiQPSGitV7/r/jd0lz2ufYQJuoM/+TtMBof9+7eQOQY/a2iqIHV2
6hGzHz+loGH1juYBiYY6+I8yABorrxb69T4v2TD9p1Yl4f9AMu5JgysPMhnkbZIc
KDiivf/08BtCokYlOOw/l9B/vPozeJCa6oBfgTW2HMPtBTK2e6HeTAVJMIchq3tN
7WPS9b8CfC+qVBDNm9WOc8T9MPsYaV65GA/3E0LImSjsKDLFK7ZEOpwkz9PN1lZT
p/iS+k/xK9odul3qOxsX
=H2+e
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
