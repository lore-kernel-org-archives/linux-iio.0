Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727079AbeHATti (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 1 Aug 2018 15:49:38 -0400
Date: Wed, 1 Aug 2018 19:02:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxime =?UTF-8?B?Um91c3Npbi1Cw6lsYW5nZXI=?=
        <maxime.roussinbelanger@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: si1133: fix uninitialized resp variable
Message-ID: <20180801190240.3e0d2eb6@archlinux>
In-Reply-To: <20180731201321.17178-1-maxime.roussinbelanger@gmail.com>
References: <20180731201321.17178-1-maxime.roussinbelanger@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 31 Jul 2018 16:13:21 -0400
Maxime Roussin-B=C3=A9langer <maxime.roussinbelanger@gmail.com> wrote:

> Read response register to detect any error.
>=20
> Signed-off-by: Maxime Roussin-B=C3=A9langer <maxime.roussinbelanger@gmail=
.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Thanks.  Given the announced delay in the merge window opening I'm
going to make an optimistic pull request and this just snuck in.

Applied to the togreg branch of iio.git.

Thanks,

Jonathan

> ---
> Changes in v2:
> 	- Added missing signed-off-by
>=20
>  drivers/iio/light/si1133.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
> index d3fbeb3bc463..9b8862af0127 100644
> --- a/drivers/iio/light/si1133.c
> +++ b/drivers/iio/light/si1133.c
> @@ -409,6 +409,9 @@ static int si1133_command(struct si1133_data *data, u=
8 cmd)
>  			err =3D -ETIMEDOUT;
>  			goto out;
>  		}
> +		err =3D regmap_read(data->regmap, SI1133_REG_RESPONSE0, &resp);
> +		if (err)
> +			goto out;
>  	} else {
>  		err =3D regmap_read_poll_timeout(data->regmap,
>  					       SI1133_REG_RESPONSE0, resp,

