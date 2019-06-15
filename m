Return-Path: <SRS0=Oe63=UO=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34805C31E47
	for <linux-iio@archiver.kernel.org>; Sat, 15 Jun 2019 08:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22BF2184E
	for <linux-iio@archiver.kernel.org>; Sat, 15 Jun 2019 08:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560587922;
	bh=w4FV9QFJPg67zMuaEg0tRrd3hFhiXE0yxS/3dfBiiPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NB7gyFe/LYbX+O3I4uwdBSwZL8xDVYVsdFMAeOH1FfpBkuSQM+vIW5qpynWYwlb9J
	 nVb6bM2fGNVgYYT+ZERkwI+aj8aAdeMhwq817Y2yCfMlyhSCXiZbB/47RUb2c5+zuP
	 SNxdyTLKHjv1gfBm5vlzoOQPXO++nWFRk+WHWwrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbfFOIil (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 15 Jun 2019 04:38:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbfFOIil (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 15 Jun 2019 04:38:41 -0400
Received: from localhost.localdomain (unknown [77.246.15.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85EFD21848;
        Sat, 15 Jun 2019 08:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560587920;
        bh=w4FV9QFJPg67zMuaEg0tRrd3hFhiXE0yxS/3dfBiiPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Seyt4Lx/Bn0uc6verPIMtGyNdB/Mv93+7T3bat6k+2e5OKMkK5RCrrh96Sh92uj3I
         OeYFl2AKKX5d+2ebbAExyZO5XF1jwN7BMg50+qEJRWoi61aLeoqSDOsxe8roXPtL8A
         fx1Y9VuayzfrwzwicyFwGbvutF9xF43BJm8L0Jrw=
Date:   Sat, 15 Jun 2019 10:38:35 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        martin@geanix.com
Subject: Re: [RFC PATCH 2/3] iio: imu: st_lsm6dsx: add wake on accelerometer
 enable hook in sysfs
Message-ID: <20190615083834.GB5778@localhost.localdomain>
References: <20190614122604.52935-1-sean@geanix.com>
 <20190614122604.52935-3-sean@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
In-Reply-To: <20190614122604.52935-3-sean@geanix.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> This adds a wakeup_enabled hook in sysfs.
> If wakeup-source is enabled, wake on accelerometer event is default activ=
e.
>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 31 ++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>=20

same here, what about using write_event_value/write_event_config function
pointer?

> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 092c4d02bd4e..2c8ad7d65d2f 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -630,15 +630,46 @@ static ssize_t st_lsm6dsx_sysfs_scale_avail(struct =
device *dev,
>  	return len;
>  }
> =20
> +static ssize_t st_lsm6dsx_sysfs_get_wakeup_enabled(struct device *dev,
> +					    struct device_attribute *attr,
> +					    char *buf)
> +{
> +	struct st_lsm6dsx_sensor *sensor =3D iio_priv(dev_get_drvdata(dev));
> +	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> +
> +	if (device_may_wakeup(hw->dev))
> +		return sprintf(buf, "%d\n", 1);
> +	return sprintf(buf, "%d\n", 0);

what about:

return sprintf(buf, "%d\n", device_may_wakeup(hw->dev));

> +}
> +
> +static ssize_t st_lsm6dsx_sysfs_set_wakeup_enabled(struct device *dev,
> +					    struct device_attribute *attr,
> +					    const char *buf, size_t len)
> +{
> +	struct st_lsm6dsx_sensor *sensor =3D iio_priv(dev_get_drvdata(dev));
> +	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> +
> +	if (strncmp(buf, "1", 1) =3D=3D 0)
> +		device_set_wakeup_enable(hw->dev, true);
> +	else
> +		device_set_wakeup_enable(hw->dev, false);
> +
> +	return len;
> +}
> +
>  static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(st_lsm6dsx_sysfs_sampling_frequency_=
avail);
>  static IIO_DEVICE_ATTR(in_accel_scale_available, 0444,
>  		       st_lsm6dsx_sysfs_scale_avail, NULL, 0);
> +static IIO_DEVICE_ATTR(wakeup_enabled, 0644,
> +		       st_lsm6dsx_sysfs_get_wakeup_enabled,
> +		       st_lsm6dsx_sysfs_set_wakeup_enabled, 0);
>  static IIO_DEVICE_ATTR(in_anglvel_scale_available, 0444,
>  		       st_lsm6dsx_sysfs_scale_avail, NULL, 0);
> =20
>  static struct attribute *st_lsm6dsx_acc_attributes[] =3D {
>  	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
>  	&iio_dev_attr_in_accel_scale_available.dev_attr.attr,
> +	&iio_dev_attr_wakeup_enabled.dev_attr.attr,
>  	NULL,
>  };
> =20
> --=20
> 2.22.0
>=20

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXQSuhgAKCRA6cBh0uS2t
rItNAQDSRuHMwhsao7A0wDTVRMfK7VDadXcVfkwb8GFZB8MazwEA/5HSIia6FYlP
xmi82nnys0KtLPFZJTw7TchztTBPGwM=
=sy+g
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
