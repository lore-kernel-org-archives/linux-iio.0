Return-Path: <SRS0=dRc7=6J=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC03C54FCB
	for <linux-iio@archiver.kernel.org>; Sat, 25 Apr 2020 17:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9620A20728
	for <linux-iio@archiver.kernel.org>; Sat, 25 Apr 2020 17:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587834843;
	bh=hOtsB+DN6WGIPXY5sIR15wmPMKfko2/6MGBgyUS7KM4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KWQ5GS++HbP9J6ucACZoswM6roQf3MYJvHxzgKzlqXPiRK2P3YOiuDbwwhKXF15WO
	 uJCiPuiTj+jPMSW/pcLQYhbW2Q4lTKnSN0FsoQWqqC2PTSayCsdUZy3NovtVvlrS16
	 1QnoPt51uvEWAQIaP41lliU++5ynqS9b/j+COQzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgDYROD (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 25 Apr 2020 13:14:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgDYROD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 13:14:03 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E10CF206B6;
        Sat, 25 Apr 2020 17:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587834842;
        bh=hOtsB+DN6WGIPXY5sIR15wmPMKfko2/6MGBgyUS7KM4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rn8kxlY8kJUz4OnwkuUsfposkIuHK56jjs66W37MoPhH7Cr7H3RoZ3H2gNFUjcsgO
         aS0rNcK5O4NlQpUhb4P8v/+RbE/PhwzicETKG35n2GJAUHfDGp5IEXjbI4k1l8nJNJ
         WEW5jGoHE0Q0xx+LpDDlSQfj9rP3s8wfC7/tWyfc=
Date:   Sat, 25 Apr 2020 18:13:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?R2HDq3RhbiBBbmRyw6k=?= <rvlander@gaetanandre.eu>
Cc:     <linux-iio@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v2] iio: st_sensors: make scale channels also shared by
 type
Message-ID: <20200425181359.1e30e315@archlinux>
In-Reply-To: <20200423121714.607262-1-rvlander@gaetanandre.eu>
References: <20200423121714.607262-1-rvlander@gaetanandre.eu>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 23 Apr 2020 14:17:15 +0200
Ga=C3=ABtan Andr=C3=A9 <rvlander@gaetanandre.eu> wrote:

> Scale channels are available by axis. For example for accelerometers,
> in_accel_x_scale, in_accel_y_scale and in_accel_z_scale are available.
>=20
> However, they should be shared by type as documented in
> Documentation/ABI/testing/sysfs-bus-iio.
>=20
> For each sensor (acceleros, gyros and magnetos) only one value is specifi=
ed
> for all the axes.
>=20
> Existing, by axis, entries are preserved in order to to leave the old ABI
> untouched.
As I mentioned in v1, there isn't a strict ABI rule that says that we must
do the shared form

+CC'd Bastien for comment on what userspace is assuming and whether we shou=
ld
push this back to stable or not.

Thanks,

Jonathan

>=20
> Signed-off-by: Ga=C3=ABtan Andr=C3=A9 <rvlander@gaetanandre.eu>
> ---
> v1->v2: add comment explaining why we are doing both.
>=20
>  include/linux/iio/common/st_sensors.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/co=
mmon/st_sensors.h
> index 33e939977444..42663fbab085 100644
> --- a/include/linux/iio/common/st_sensors.h
> +++ b/include/linux/iio/common/st_sensors.h
> @@ -46,12 +46,19 @@
>  #define ST_SENSORS_MAX_NAME			17
>  #define ST_SENSORS_MAX_4WAI			8
> =20
> +/*
> + * Scale channels are configured both by type and by axis.
> + * - By axis to keep the previous ABI and flexibility.
> + * - By type because it is how some userland
> + * applications are expecting them (ex: iio-sensor-proxy).
> + */
>  #define ST_SENSORS_LSM_CHANNELS(device_type, mask, index, mod, \
>  					ch2, s, endian, rbits, sbits, addr) \
>  { \
>  	.type =3D device_type, \
>  	.modified =3D mod, \
>  	.info_mask_separate =3D mask, \
> +	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE), \
>  	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ), \
>  	.scan_index =3D index, \
>  	.channel2 =3D ch2, \
>=20
> base-commit: 2de8c02349f02d014e51b43f306d28fc7a23ea6e

