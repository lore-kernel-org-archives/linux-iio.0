Return-Path: <SRS0=77Uk=A5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2976AC433E6
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 15:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 048D72076A
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 15:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595086504;
	bh=i3s5qsN8oGO2RhsqEffAuh7jFlthT0t8q6DEOLMh30I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VnUA3Ua41a1ha0OnKJRXBmUEpEiYYNGg8833w1woqyOtLZkDYRZo0Af4jl4YBSL8L
	 5hU+qKkvwpyqmtQOd+fpj+2G+uzeQC8AcwsXkRKJX5tClLlyPwxRw/igANzCKYvVv8
	 /ZQP2Qg/NPTaapTSlD6F/7XEXvb12vly07XTWOB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgGRPfD (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 18 Jul 2020 11:35:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:42268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgGRPfD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:35:03 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D0C420734;
        Sat, 18 Jul 2020 15:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595086502;
        bh=i3s5qsN8oGO2RhsqEffAuh7jFlthT0t8q6DEOLMh30I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CGgVsSg/Y3Ai04wkO4Chk+Q/J/Y8kFiLQVNMDRPSPKE0PSvpP0yM509ozseDL+LYm
         bmzfiFsDGJJFSvJpyg1CWBwwvxAU4p4wbgm+ya/HfVOP+ojef8iN3EwV0mSstjLArr
         e56tzK0gsyTWI/zDlmJPm6MKC8Ac4v8Z9MmJFC2s=
Date:   Sat, 18 Jul 2020 16:34:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Josef Gajdusek <atx@atx.name>
Subject: Re: [PATCH 04/30] iio: magnetometer: hmc5843: 'hmc5843_pm_ops' is
 unused in 1 of 3 files including hmc5843_core.h
Message-ID: <20200718163458.458ea23d@archlinux>
In-Reply-To: <20200717165538.3275050-5-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
        <20200717165538.3275050-5-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Jul 2020 17:55:12 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> We know that it's okay for 'hmc5843_pm_ops' to be unused here.
>=20
> Fixes the following W=3D1 kernel build warning(s):
>=20
>  In file included from include/linux/device.h:25,
>  from include/linux/iio/iio.h:10,
>  from drivers/iio/magnetometer/hmc5843_core.c:16:
>  drivers/iio/magnetometer/hmc5843.h:55:26: warning: =E2=80=98hmc5843_pm_o=
ps=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>  55 | static SIMPLE_DEV_PM_OPS(hmc5843_pm_ops,
>  | ^~~~~~~~~~~~~~
>  include/linux/pm.h:354:25: note: in definition of macro =E2=80=98SIMPLE_=
DEV_PM_OPS=E2=80=99
>  354 | const struct dev_pm_ops name =3D { | ^~~~
>=20
> Cc: Josef Gajdusek <atx@atx.name>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Seems like a sensible solution to me.

Applied to the togreg branch of iio.git an pushed out as testing to see if
we missed anything.

Thanks,

Jonathan

> ---
>  drivers/iio/magnetometer/hmc5843.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/magnetometer/hmc5843.h b/drivers/iio/magnetomete=
r/hmc5843.h
> index b0dee87a8b20e..3f6c0b6629415 100644
> --- a/drivers/iio/magnetometer/hmc5843.h
> +++ b/drivers/iio/magnetometer/hmc5843.h
> @@ -52,9 +52,9 @@ int hmc5843_common_suspend(struct device *dev);
>  int hmc5843_common_resume(struct device *dev);
> =20
>  #ifdef CONFIG_PM_SLEEP
> -static SIMPLE_DEV_PM_OPS(hmc5843_pm_ops,
> -		hmc5843_common_suspend,
> -		hmc5843_common_resume);
> +static __maybe_unused SIMPLE_DEV_PM_OPS(hmc5843_pm_ops,
> +					hmc5843_common_suspend,
> +					hmc5843_common_resume);
>  #define HMC5843_PM_OPS (&hmc5843_pm_ops)
>  #else
>  #define HMC5843_PM_OPS NULL

