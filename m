Return-Path: <SRS0=DYZA=SL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551EEC282CE
	for <linux-iio@archiver.kernel.org>; Tue,  9 Apr 2019 08:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E912133D
	for <linux-iio@archiver.kernel.org>; Tue,  9 Apr 2019 08:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554798299;
	bh=ZYRzEQyfewOii6aGeNYvtymxtEmIi+gyTPSm6+kfyuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=De+KRagfTx43uHZWz3/IX35Pqk+OXPuXp4+M70oJM1GTVNOhQ+qTBNRcv0nFHzVpi
	 aVry241V3lSNR8mWqH6Iv2G6h4hCuls9MvjgHdTetPs/Yffj2zbvoYW+wjM/5Ehmt9
	 ubAtAvEcVx7HS/LceD83dFe3sHLXOr3crccRbhkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfDIIY5 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:24:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfDIIY4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 9 Apr 2019 04:24:56 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7589C20880;
        Tue,  9 Apr 2019 08:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554798295;
        bh=ZYRzEQyfewOii6aGeNYvtymxtEmIi+gyTPSm6+kfyuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ix+M/gjYf+4n8lS6rW4m7X2z2zJlWFsyHxqWSfu8x69B2lHDwTRcmuHA7vNEeIkTg
         sqc/pZSyHPhUvpZEd5U3R/o8CmmKDKjB23jCQuUzj7JA1IRUJi/k0zmG2XN4/Wmop3
         pYi/DzC/22UPrujBob4hoD+fWveeWvLRNoMyPA8k=
Date:   Tue, 9 Apr 2019 10:24:49 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] iio: imu: st_lsm6dsx: remove set but not used
 variables 'acc_sensor' and 'gyro_sensor'
Message-ID: <20190409082448.GA26320@localhost.localdomain>
References: <20190409021217.155327-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <20190409021217.155327-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Fixes gcc '-Wunused-but-set-variable' warning:
>=20
> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c: In function 'st_lsm6dsx_r=
ead_tagged_fifo':
> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c:520:41: warning:
>  variable 'gyro_sensor' set but not used [-Wunused-but-set-variable]
>=20
> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c:520:28: warning:
>  variable 'acc_sensor' set but not used [-Wunused-but-set-variable]
>=20
> They are not used since commit 14c7c6e1a860 ("iio: imu: st_lsm6dsx: add
> st_lsm6dsx_push_tagged_data routine")
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index 2da8c5ff699a..bd08711d5b75 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -517,7 +517,6 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw =
*hw)
>  {
>  	u16 pattern_len =3D hw->sip * ST_LSM6DSX_TAGGED_SAMPLE_SIZE;
>  	u16 fifo_len, fifo_diff_mask;
> -	struct st_lsm6dsx_sensor *acc_sensor, *gyro_sensor;
>  	u8 iio_buff[ST_LSM6DSX_IIO_BUFF_SIZE], tag;
>  	bool reset_ts =3D false;
>  	int i, err, read_len;
> @@ -539,9 +538,6 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw =
*hw)
>  	if (!fifo_len)
>  		return 0;
> =20
> -	acc_sensor =3D iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> -	gyro_sensor =3D iio_priv(hw->iio_devs[ST_LSM6DSX_ID_GYRO]);
> -
>  	for (read_len =3D 0; read_len < fifo_len; read_len +=3D pattern_len) {
>  		err =3D st_lsm6dsx_read_block(hw,
>  					    ST_LSM6DSX_REG_FIFO_OUT_TAG_ADDR,
>=20
>=20
>=20

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXKxWzQAKCRA6cBh0uS2t
rCilAP9/9sJAN8IDRapuxibUz2tmbY4FDKC2bEUW3tz2IUKhqwEAxyyEo/mgqhNx
RQh69uE5Jc/RMXrYfvUXpqy5loL5SQ8=
=Edmp
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
