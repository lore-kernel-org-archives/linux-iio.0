Return-Path: <SRS0=dRc7=6J=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319F2C54FCB
	for <linux-iio@archiver.kernel.org>; Sat, 25 Apr 2020 16:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11373206B6
	for <linux-iio@archiver.kernel.org>; Sat, 25 Apr 2020 16:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587832917;
	bh=VlLvPWUcgwaI5upECsGVMAvYnVDg78YSh+FwDRjjHOw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=2BMSgMlp9pCVbtZNrwX2AT7dCsCpYnznDVritvhJ6m7vLuCgbx/sjl+pE8ZOOo85/
	 mqBOLyd8YaL7nEZ2evFYH8tP0/ZXS1sX4/z1d0JzPX0wKjW36q/zUTdnrq9xLxKnNs
	 n26kkxxniVYNyPVuUZ1ci9piPuBYanuNFOebiJ2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgDYQl4 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 25 Apr 2020 12:41:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbgDYQl4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 12:41:56 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECE0F206A2;
        Sat, 25 Apr 2020 16:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587832915;
        bh=VlLvPWUcgwaI5upECsGVMAvYnVDg78YSh+FwDRjjHOw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X5Wc3grskpo6oBMYR+hlnFQn1U4e+aM60yEkTOM9bGnwirwpJdcJfbDTp32oqyv9F
         UpfSXmY9z2hjsOGJeFIp55K05/ljiPM6Xq/o114J7wFZcQiWrcNOVVGsZpvhnw0ItY
         JZnb4B+MVQ2Qht5UFyc39pmWzT2vlTOqwE6k5OgY=
Date:   Sat, 25 Apr 2020 17:41:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Maxime =?UTF-8?B?Um91c3Npbi1Cw6lsYW5nZXI=?= 
        <maxime.roussinbelanger@gmail.com>
Subject: Re: [PATCH v1 09/16] iio: light: si1133: Use get_unaligned_be24()
Message-ID: <20200425174152.1fba5a70@archlinux>
In-Reply-To: <20200421003135.23060-9-andriy.shevchenko@linux.intel.com>
References: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
        <20200421003135.23060-9-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Apr 2020 03:31:28 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> This makes the driver code slightly easier to read.
>=20
> Cc: Maxime Roussin-B=C3=A9langer <maxime.roussinbelanger@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied with asm/unaligned include added.

J

> ---
>  drivers/iio/light/si1133.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
> index 9174ab928880..8931a8afbafc 100644
> --- a/drivers/iio/light/si1133.c
> +++ b/drivers/iio/light/si1133.c
> @@ -104,8 +104,6 @@
>  #define SI1133_LUX_BUFFER_SIZE		9
>  #define SI1133_MEASURE_BUFFER_SIZE	3
> =20
> -#define SI1133_SIGN_BIT_INDEX 23
> -
>  static const int si1133_scale_available[] =3D {
>  	1, 2, 4, 8, 16, 32, 64, 128};
> =20
> @@ -633,8 +631,7 @@ static int si1133_measure(struct si1133_data *data,
>  	if (err)
>  		return err;
> =20
> -	*val =3D sign_extend32((buffer[0] << 16) | (buffer[1] << 8) | buffer[2],
> -			     SI1133_SIGN_BIT_INDEX);
> +	*val =3D sign_extend32(get_unaligned_be24(&buffer[0]), 23);
> =20
>  	return err;
>  }
> @@ -723,16 +720,11 @@ static int si1133_get_lux(struct si1133_data *data,=
 int *val)
>  	if (err)
>  		return err;
> =20
> -	high_vis =3D
> -		sign_extend32((buffer[0] << 16) | (buffer[1] << 8) | buffer[2],
> -			      SI1133_SIGN_BIT_INDEX);
> +	high_vis =3D sign_extend32(get_unaligned_be24(&buffer[0]), 23);
> =20
> -	low_vis =3D
> -		sign_extend32((buffer[3] << 16) | (buffer[4] << 8) | buffer[5],
> -			      SI1133_SIGN_BIT_INDEX);
> +	low_vis =3D sign_extend32(get_unaligned_be24(&buffer[3]), 23);
> =20
> -	ir =3D sign_extend32((buffer[6] << 16) | (buffer[7] << 8) | buffer[8],
> -			   SI1133_SIGN_BIT_INDEX);
> +	ir =3D sign_extend32(get_unaligned_be24(&buffer[6]), 23);
> =20
>  	if (high_vis > SI1133_ADC_THRESHOLD || ir > SI1133_ADC_THRESHOLD)
>  		lux =3D si1133_calc_polynomial(high_vis, ir,

