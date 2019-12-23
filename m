Return-Path: <SRS0=L16q=2N=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E76BC2D0C0
	for <linux-iio@archiver.kernel.org>; Mon, 23 Dec 2019 16:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9C920715
	for <linux-iio@archiver.kernel.org>; Mon, 23 Dec 2019 16:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577117407;
	bh=7ZQgPmxoHQO4U5+3AvRV2gfbaH1rOJBCXE1hu9quvVs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=GrFhAoEH/Qsd2kkhsN8CT0xGQTaXCZ9/K/LV4vJqngK+ei8AD/IQgPwEvl6Nk1e3Y
	 xxT10dGrUBoDTJZH9gk52JAtXoyzMb1KkXYO75YnPIFhaDVvlqzx/oyfF8bGkF4FrY
	 Y0mSvjyJE5+ckzpSWXjSQdkIJa0d/iNaRFqJ9zJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLWQKG (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 23 Dec 2019 11:10:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:53752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfLWQKG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 11:10:06 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E401F20709;
        Mon, 23 Dec 2019 16:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577117405;
        bh=7ZQgPmxoHQO4U5+3AvRV2gfbaH1rOJBCXE1hu9quvVs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GmI2ug9SzZPcSW5rMbrARnPf3YsHUCXaT0H9tXWxZyxFpGwp/GzJ8EY6WcDeQQfOZ
         mk44GX0x6kn8dDahlee54O6jkysnP6s1gCpCiU2xlv96QMFqm8vYESqIOfiEwGjpP8
         CPx1z1BF38QB+noLqcdEPSxel/RgZgfsd6+JPbiM=
Date:   Mon, 23 Dec 2019 16:10:01 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1 1/3] iio: st_lsm6dsx: Mark predefined constants with
 __maybe_unused
Message-ID: <20191223161001.015d2afe@archlinux>
In-Reply-To: <20191216181925.927-1-andriy.shevchenko@linux.intel.com>
References: <20191216181925.927-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Dec 2019 20:19:23 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Since we put static variable to a header file it's copied to each module
> that includes the header. But not all of them are actually used it.
>=20
> Mark predefined constants with __maybe_unused to calm a compiler down:
>=20
> In file included from drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c:17:
> .../st_lsm6dsx/st_lsm6dsx.h:399:28: warning: =E2=80=98st_lsm6dsx_availabl=
e_scan_masks=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>   399 | static const unsigned long st_lsm6dsx_available_scan_masks[] =3D =
{0x7, 0x0};
>       |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> .../st_lsm6dsx/st_lsm6dsx.h:392:36: warning: =E2=80=98st_lsm6dsx_event=E2=
=80=99 defined but not used [-Wunused-const-variable=3D]
>   392 | static const struct iio_event_spec st_lsm6dsx_event =3D {
>       |                                    ^~~~~~~~~~~~~~~~
> ...
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Huh, I wonder we I never saw this one either locally or from the autobuilde=
rs.

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to have a fun Christmas poking at it ;)

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
> index dc55d7dff3eb..b3fbbae81955 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -389,14 +389,17 @@ struct st_lsm6dsx_hw {
>  	const struct st_lsm6dsx_settings *settings;
>  };
> =20
> -static const struct iio_event_spec st_lsm6dsx_event =3D {
> +static __maybe_unused const struct iio_event_spec st_lsm6dsx_event =3D {
>  	.type =3D IIO_EV_TYPE_THRESH,
>  	.dir =3D IIO_EV_DIR_EITHER,
>  	.mask_separate =3D BIT(IIO_EV_INFO_VALUE) |
>  			 BIT(IIO_EV_INFO_ENABLE)
>  };
> =20
> -static const unsigned long st_lsm6dsx_available_scan_masks[] =3D {0x7, 0=
x0};
> +static __maybe_unused const unsigned long st_lsm6dsx_available_scan_mask=
s[] =3D {
> +	0x7, 0x0,
> +};
> +
>  extern const struct dev_pm_ops st_lsm6dsx_pm_ops;
> =20
>  int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,

