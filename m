Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36141 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750782AbdIKTmF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Sep 2017 15:42:05 -0400
Received: by mail-pf0-f180.google.com with SMTP id e199so15386038pfh.3
        for <linux-iio@vger.kernel.org>; Mon, 11 Sep 2017 12:42:05 -0700 (PDT)
Date: Mon, 11 Sep 2017 12:42:01 -0700
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
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 8/8] platform/chrome: cros_ec: sysfs: Modify error
 handling
Message-ID: <20170911194201.GB40388@decatoncale.mtv.corp.google.com>
References: <1502461385-27564-1-git-send-email-thierry.escande@collabora.com>
 <1502461385-27564-9-git-send-email-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
In-Reply-To: <1502461385-27564-9-git-send-email-thierry.escande@collabora.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Thierry,

On Fri, Aug 11, 2017 at 04:23:05PM +0200, Thierry Escande wrote:
> From: Gwendal Grignou <gwendal@chromium.org>
>=20
> When accessing a sysfs attribute, if the EC command fails, -EPROTO is
> now returned instead of an error message as it is unlikely an app is
> parsing the error message to do something meaningful.
> Also, this patch makes use of cros_ec_cmd_xfer_status() instead of
> cros_ec_cmd_xfer() so an error message is printed in the syslog.
>=20
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>

Looks good. Applied.

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJZtucJAAoJEB8J9XsKL+ZYmYEP/0qYAyo+vdwUSk9ttzbYb4MD
yLvWiF3JDHjZMcK6sxfhkezoy1S1G+w+mYyTEggle6dWeqKnOfVlN2E3nbikxc11
wwlqcUL0LybiRV/DkMQVpW89aDRWsK+Ibvm0sdDvefmOtNEAOFyLDQfPv1OoWd+p
qETz/JIA05wQTMwL+zUPncYORW2DQiVKWs8yLTRK+wblLqr38a4HfouHQ9ZBYnjB
AZor1QiRaz1Mj9X7E5zVHTBckAIUD0wJRbKY9gCimYBLPFwha1HdmdApdiR8EKpc
nUx/MNMZjUBFKWtQbPbyTPJd8o/sbIIBci4o/r7fccwTnm8qxDR0LroBy/REdl1B
jFHo2T7pGPzbAtsp7D8knPU1MLLXQVr1ZUbyT+Subc5K3uBuSNtEN4+2hXqQU32f
mxpGJfA2ilXfqR+PtZ298NFLDCrCqjtbRxMwtACXyp73VC7FdfjUsV+uhLgd4qmV
6bWQf8Qy6+4lRP7lLx68iSItQDZI6yISykMLW30AZ47I08mgT6HXy/h2Oyodc6Wq
2vmeicxw+wjoxZofmtMO9WttKGhj+Ikt7AA/DDEDg7XzjrBrFs9+CtO3S0jfQzeB
OHfsjVXlybZ039Z5oKR+1fneG3J/cTz2xW/b5XmJkx51KV01YchZTq3kGCPwPj0r
j7nZ3h4tWEFQEHzavT7t
=xzJs
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
