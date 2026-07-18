Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB58C14A60F
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 22:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784415583; cv=none; b=qT8vf+kYkHSTQpG27fkECh+ZMr2tzEckBKtLthDFrOwvF8uHIS0QYchhm2FUNjwUNx302/qKEoeo9qymiCeTfqekx2PhxSLMsZ/K0ODrE9Hp3qhk7g6SVFuVlvTYqsfqUt+xdM7ZypmazgqrdFPqp5EYjxBblr5ddU2lzJ2yPRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784415583; c=relaxed/simple;
	bh=11FMn3rA+VhND3muyRdwJ35x5fHo2sz1m8dzM12VAyM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=euwXsLc7wXjy19wrYxVJDjUNumUNptwjiV0pMacNHPMnlWOPHNLl0nX1yy75OHYWVsHk3dJpDM5wqk8nRrMVJG2FsFqyaP894Z0CpxEa1GfVcTIbWXXaNdE11qSZb++DVIFpoy9WPoxU0o2fADyydjgce+N4IfjYc/laegRdmBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RZeToCl5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DoXaeXNa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RZeToCl5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DoXaeXNa"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66IJphht1603080
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 22:59:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nrsZU7xmwPEwCAxaerhGVSMGdHSwQ31e0Kr0BYK+OpM=; b=RZeToCl5eIb+7LhC
	bJRF9iXQE8Kx2HBeBjW7W2dqk5XXzCsrOxObj6WFee0wuk6OIzJv+Oq28AsbHfSp
	BDhzP/1LSYh1/GFkgFPZHjF0NRxpearJhKQs2oWYcBtPfkPQA/7PAN9Tklf0P69j
	9qhW82HkLAuts2W3GVTJZkB0dkuTf+eYQEG3JNwZpCamHY13H2FvDi0Kim72/O6j
	HmGE9RelYKIGw9zVDoheQHAvsddIB107wCY3ff5liemzFtql+Ylnh+tKWpPRslIG
	p13L2a1Jcdj57UsmZZkPcdjDQWkcPG1XEbMLkP7VaHQMa2RAriOAEIMbLArftGVF
	69aAGQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2dc1qx5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 22:59:40 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-848662cd2a1so6274453b3a.2
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 15:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784415580; x=1785020380; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nrsZU7xmwPEwCAxaerhGVSMGdHSwQ31e0Kr0BYK+OpM=;
        b=DoXaeXNawgfzuRS32U9I1dyWHLoZFjeN3rRinUIZPso+MFwlkQkfnXvwEdIARy9d4R
         RngeCMpv1A94sQq6Dca0pwQl1xPYmlw2hlp64dZSwlynBfsf6pTmpqUG1W8z5YXhz9/D
         DDP7VvD0IuoG+yJDIpxuanQfiYYeNdsPCcdoSKT8mDsPgH5FswUtxJklO/Zk1qPDRosv
         i34CEjd5tW7PMOXrfYs0KeLKWuSfwyz+tmzNQt1J92Xp7BirVGouOAEta4jPXaw9aNjZ
         ROKsX9FAyw/7waTehBVS/rQqcQjS5vUYcOqB3v+ChXsvBiIujzOg/YZ6WngRUYbVgZSc
         H2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784415580; x=1785020380;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nrsZU7xmwPEwCAxaerhGVSMGdHSwQ31e0Kr0BYK+OpM=;
        b=pXXjrSLzmPIwABfIelETLuMr/nytL+kiW1oty7S/0gXAqQRZbjk3OB4gVgvkeAWQR9
         eCQmG4Y6yniYSzOkvi/ndbyNLdg8VwQKUUQvuKriuC5CAhz1ZSe+v2b0p7J//5/L9kQT
         YLCu6AccfcOdPhfXnYnKFFVcNR8g0WRUpBGAtvrTxAws0Xu/FFaiYaUeDUjyUhqw0+fw
         7aBreu/IVQ5Gjs4kx3uJ0RReFttH3AbhfxV2f1I6qDeHpzr5hKAKeaX3aM1omcMkBqNe
         A+wGb1psjGAukqFUL90UKTR3dw1LQo91BeMZtPwiZu3I5OFXSeAGzIyTWCuhlkOX+Nts
         bLwg==
X-Gm-Message-State: AOJu0Yz7pZkQPh/uymfKDCJdNHAhM090owoS8AZ/7rXHozX/65dbLJLV
	6PplDfUdQYV0ffTEmVE3DOj0EuypideDlBj7QsA4cri1NoGyYUI/Nh+KPEkLnIX8lpFzCHUY4bz
	giaq4AAJ+fx+Eq0+5p37nqyqQRbAmX//ao1d8Pva2syA2RU2Qgeu9vrJH26G3/LGREUSOrGc=
X-Gm-Gg: AfdE7cmhdD9re49jviHUT7/+XooJgVKRYV+Zb50TOfESAUqlbqHtJ84DIwIDwCBewxc
	T/h1Y++N6ZcBSo0l5aX5roLXNVJqgj4NNLvmFj6ixiOPxGlBmz5ocHQt3Hx3O1JbS6HkFGdH7bC
	DSVosLxK0DPA3gx34o1uqqCaFpQUYh1DRxd8aZdA1/nuyZJy+2rQlwlvxpmkVDoBZvnvLb8hYn2
	FPBIETk0JsYoxfMsWoFaCjl9N5mzM3qtmSVrenwOJgJu2FnsNr62skeaMbZxCvkH9EQfeTGnEVy
	WbKHLKJYy+hIt6tMRWO/HXThTDXoBLOacbV0M5Lc1YWrzhINNgmGli+CczZQIzCAV9nsCKQ5GbE
	oVsxCkjNP5Or0rjxP
X-Received: by 2002:a05:6a00:a257:b0:846:f517:ba5a with SMTP id d2e1a72fcca58-84c2927bf51mr8475798b3a.28.1784415579550;
        Sat, 18 Jul 2026 15:59:39 -0700 (PDT)
X-Received: by 2002:a05:6a00:a257:b0:846:f517:ba5a with SMTP id d2e1a72fcca58-84c2927bf51mr8475774b3a.28.1784415578990;
        Sat, 18 Jul 2026 15:59:38 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2adc5307sm3383434b3a.16.2026.07.18.15.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 15:59:38 -0700 (PDT)
Date: Sat, 18 Jul 2026 23:59:34 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
        dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org,
        robh@kernel.org, andriy.shevchenko@intel.com,
        Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V17 8/9] iio: imu: inv_icm42607: Add Temp Support in
 icm42607
Message-ID: <20260718235923.34ee1020@jic23-huawei>
In-Reply-To: <20260716182637.24310-9-macroalpha82@gmail.com>
References: <20260716182637.24310-1-macroalpha82@gmail.com>
	<20260716182637.24310-9-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDI0MSBTYWx0ZWRfXwTcQoMdejVTg
 aIFr53XTKDeqLbk9YgPf/zsu2rGmOH8aYwTTPwxainO2NAYc8QRCAQiR7uxfGf44fAGCYu+ZBxi
 Rd9VdMaYIDrPwOjNpb9sTYgQogy8c7M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDI0MSBTYWx0ZWRfX6ZRhBMFLLF9+
 YzwEsgB2kGQFk3AniqUVgEsPel2GovFuLqvPOSzLyLPUVf5XqgTPEpWssLfBd44ekpk48jSzMqZ
 uzEDtiX/RZsxc15pAUhWrSXjqCl97AOwwEFYUbZhPMix2RgJ54U3U1uMvcxJGg0ul1qaAw4Jj8s
 c+RtykbW3pMlFslxasLfzLS5BllccRRiKf52ITWM3LsaaNbA1NxjJYs6m0BXUcwN58VXgI3Uj5/
 34WY4r3wRvntvNHYJ1JXcH7nknDeLz7iJh4OKrIT+mxqvIlY/AUGJpA2syBkke5TCRSRLYXDK4K
 XGkQKhloWi9yw5bfoEgn+gwfkPCwvMbaYtbJKJKxbJk2KO5aqIam7lntsouqV3Vh7xbf1D5YSKI
 WJnhzX5rvbHtrn7AltI7q2BhDq4YQgvAkn7grgOLLqSzjuzM/kgCmkacoWGIkrcXv6YdM8UVKEj
 OIB4xqEFcFQl+b5XJsQ==
X-Proofpoint-ORIG-GUID: LH5tfizHz0-6o0IstMedXdehmMPI-jtn
X-Proofpoint-GUID: LH5tfizHz0-6o0IstMedXdehmMPI-jtn
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a5c055c cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=c92rfblmAAAA:8 a=pGLkceISAAAA:8 a=69EAbJreAAAA:8 a=s1U8IrETRtjjiv8cXCcA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607180241

On Thu, 16 Jul 2026 13:26:35 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
>=20
> Add functions for reading temperature sensor data.
Hi Chris

Before I take a look myself. Sashiko did have a comment on this
one that looks valid to me
https://sashiko.dev/#/patchset/20260716182637.24310-1-macroalpha82%40gmail.=
com

See comments on the the IIO_TEMP vs IIO_CHAN_INFO_RAW below.

The suspend one is interesting but definitely not something I'd insist
on fixing.  Might need some thought if you actually want suspend to work
in all cases.

Jonathan

>=20
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  drivers/iio/imu/inv_icm42607/Makefile         |  1 +
>  .../iio/imu/inv_icm42607/inv_icm42607_accel.c |  6 ++
>  .../iio/imu/inv_icm42607/inv_icm42607_gyro.c  |  6 ++
>  .../iio/imu/inv_icm42607/inv_icm42607_temp.c  | 98 +++++++++++++++++++
>  .../iio/imu/inv_icm42607/inv_icm42607_temp.h  | 38 +++++++
>  5 files changed, 149 insertions(+)
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h
>=20
> diff --git a/drivers/iio/imu/inv_icm42607/Makefile b/drivers/iio/imu/inv_=
icm42607/Makefile
> index 8e73385c8f4b..7b907e019601 100644
> --- a/drivers/iio/imu/inv_icm42607/Makefile
> +++ b/drivers/iio/imu/inv_icm42607/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_INV_ICM42607) +=3D inv-icm42607.o
>  inv-icm42607-y +=3D inv_icm42607_core.o
>  inv-icm42607-y +=3D inv_icm42607_gyro.o
>  inv-icm42607-y +=3D inv_icm42607_accel.o
> +inv-icm42607-y +=3D inv_icm42607_temp.o
> =20
>  obj-$(CONFIG_INV_ICM42607_I2C) +=3D inv-icm42607-i2c.o
>  inv-icm42607-i2c-y +=3D inv_icm42607_i2c.o
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c b/drivers/=
iio/imu/inv_icm42607/inv_icm42607_accel.c
> index 7bb67f232d19..9a44a180e5cc 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
> @@ -15,6 +15,7 @@
>  #include <linux/types.h>
> =20
>  #include "inv_icm42607.h"
> +#include "inv_icm42607_temp.h"
> =20
>  #define INV_ICM42607_ACCEL_CHAN(_modifier, _index, _ext_info)			\
>  {										\
> @@ -40,6 +41,7 @@ enum inv_icm42607_accel_scan {
>  	INV_ICM42607_ACCEL_SCAN_X,
>  	INV_ICM42607_ACCEL_SCAN_Y,
>  	INV_ICM42607_ACCEL_SCAN_Z,
> +	INV_ICM42607_ACCEL_SCAN_TEMP,
>  };
> =20
>  static const struct iio_chan_spec_ext_info inv_icm42607_accel_ext_infos[=
] =3D {
> @@ -54,6 +56,7 @@ static const struct iio_chan_spec inv_icm42607_accel_ch=
annels[] =3D {
>  				inv_icm42607_accel_ext_infos),
>  	INV_ICM42607_ACCEL_CHAN(IIO_MOD_Z, INV_ICM42607_ACCEL_SCAN_Z,
>  				inv_icm42607_accel_ext_infos),
> +	INV_ICM42607_TEMP_CHAN(INV_ICM42607_ACCEL_SCAN_TEMP),
>  };
> =20
>  static const int inv_icm42607_accel_scale_nano[][2] =3D {
> @@ -186,6 +189,9 @@ static int inv_icm42607_accel_read_raw(struct iio_dev=
 *indio_dev,
> =20
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> +		if (chan->type =3D=3D IIO_TEMP)
> +			return inv_icm42607_temp_read_raw(indio_dev, chan,
So this only gets called if mask is IIO_CHAN_INFO_RAW but look at what is i=
mplemented...
Sashiko suggeted this should be outside the switch and that looks correct
to me as well.

> +							  val, val2, mask);
>  		ret =3D inv_icm42607_read_sensor(indio_dev, chan, &data);
>  		if (ret)
>  			return ret;
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c b/drivers/i=
io/imu/inv_icm42607/inv_icm42607_gyro.c
> index 923d47d096bd..fa6e65c7ab6b 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
> @@ -15,6 +15,7 @@
>  #include <linux/types.h>
> =20
>  #include "inv_icm42607.h"
> +#include "inv_icm42607_temp.h"
> =20
>  #define INV_ICM42607_GYRO_CHAN(_modifier, _index, _ext_info)			\
>  {										\
> @@ -40,6 +41,7 @@ enum inv_icm42607_gyro_scan {
>  	INV_ICM42607_GYRO_SCAN_X,
>  	INV_ICM42607_GYRO_SCAN_Y,
>  	INV_ICM42607_GYRO_SCAN_Z,
> +	INV_ICM42607_GYRO_SCAN_TEMP,
>  };
> =20
>  static const struct iio_chan_spec_ext_info inv_icm42607_gyro_ext_infos[]=
 =3D {
> @@ -54,6 +56,7 @@ static const struct iio_chan_spec inv_icm42607_gyro_cha=
nnels[] =3D {
>  			       inv_icm42607_gyro_ext_infos),
>  	INV_ICM42607_GYRO_CHAN(IIO_MOD_Z, INV_ICM42607_GYRO_SCAN_Z,
>  			       inv_icm42607_gyro_ext_infos),
> +	INV_ICM42607_TEMP_CHAN(INV_ICM42607_GYRO_SCAN_TEMP),
>  };
> =20
>  static const int inv_icm42607_gyro_scale_nano[][2] =3D {
> @@ -183,6 +186,9 @@ static int inv_icm42607_gyro_read_raw(struct iio_dev =
*indio_dev,
> =20
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> +		if (chan->type =3D=3D IIO_TEMP)
> +			return inv_icm42607_temp_read_raw(indio_dev, chan,
> +							  val, val2, mask);
>  		ret =3D inv_icm42607_read_sensor(indio_dev, chan, &data);
>  		if (ret)
>  			return ret;
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c b/drivers/i=
io/imu/inv_icm42607/inv_icm42607_temp.c
> new file mode 100644
> index 000000000000..8681ef2b49e2
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 InvenSense, Inc.
> + */
> +
> +#include <linux/cleanup.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/iio/iio.h>
> +#include <linux/mutex.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>
> +
> +#include "inv_icm42607.h"
> +#include "inv_icm42607_temp.h"
> +
> +static int inv_icm42607_temp_read(struct inv_icm42607_state *st, s16 *te=
mp)
> +{
> +	struct inv_icm42607_sensor_conf conf =3D INV_ICM42607_SENSOR_CONF_INIT;
> +	struct device *dev =3D regmap_get_device(st->map);
> +	int ret, gyro_mode, accel_mode;
> +	unsigned int val;
> +	u8 raw[2];
> +
> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
> +	ret =3D PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	/*
> +	 * Check if both the gyro and accel are off and if so, enable one
> +	 * of them. The temp sensor cannot be read if both the gyro and
> +	 * accel sensor are off. Prefer to enable the accel over the gyro
> +	 * as the datasheet says the gyro uses 5x more power and it has
> +	 * a minimum run time of 45ms.
> +	 */
> +	ret =3D regmap_read(st->map, INV_ICM42607_REG_PWR_MGMT0, &val);
> +	if (ret)
> +		return ret;
> +
> +	accel_mode =3D FIELD_GET(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, val);
> +	gyro_mode =3D FIELD_GET(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, val);
> +	if (!gyro_mode && !accel_mode) {
> +		/* enable accel sensor */
> +		conf.mode =3D INV_ICM42607_SENSOR_MODE_LOW_NOISE;
> +		ret =3D inv_icm42607_set_sensor_conf(st, &conf, IIO_ACCEL);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret =3D regmap_bulk_read(st->map, INV_ICM42607_REG_TEMP_DATA1,
> +			       raw, sizeof(raw));
> +	if (ret)
> +		return ret;
> +
> +	*temp =3D get_unaligned_be16(raw);
> +	if (*temp =3D=3D INV_ICM42607_DATA_INVALID)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +int inv_icm42607_temp_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
> +{
> +	struct inv_icm42607_state *st =3D iio_device_get_drvdata(indio_dev);
> +	s16 temp;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
Only this case is ever called. (Sashiko pointed this out).
> +		ret =3D inv_icm42607_temp_read(st, &temp);
> +		if (ret)
> +			return ret;
> +		*val =3D temp;
> +		return IIO_VAL_INT;
> +	/*
> +	 * T=C2=B0C =3D (temp / 128) + 25
> +	 * Tm=C2=B0C =3D 1000 * ((temp * 100 / 12800) + 25)
> +	 * scale: 100000 / 12800 ~=3D 7.8125
> +	 * offset: 3200
> +	 */
> +	case IIO_CHAN_INFO_SCALE:
> +		*val =3D 7;
> +		*val2 =3D 812500000;
> +		return IIO_VAL_INT_PLUS_NANO;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val =3D 3200;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h b/drivers/i=
io/imu/inv_icm42607/inv_icm42607_temp.h
> new file mode 100644
> index 000000000000..18499b4d0b94
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2026 InvenSense, Inc.
> + */
> +
> +#ifndef INV_ICM42607_TEMP_H_
> +#define INV_ICM42607_TEMP_H_
> +
> +#include <linux/bitops.h>
> +
> +struct iio_dev;
> +struct iio_chan_spec;
> +
> +#define INV_ICM42607_TEMP_CHAN(_index)				\
> +{								\
> +	.type =3D IIO_TEMP,					\
> +	.info_mask_separate =3D					\
> +		BIT(IIO_CHAN_INFO_RAW) |			\
> +		BIT(IIO_CHAN_INFO_OFFSET) |			\
> +		BIT(IIO_CHAN_INFO_SCALE),			\
> +	.info_mask_shared_by_all =3D				\
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
> +	.info_mask_shared_by_all_available =3D			\
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
> +	.scan_index =3D _index,					\
> +	.scan_type =3D {						\
> +		.sign =3D 's',					\
> +		.realbits =3D 16,					\
> +		.storagebits =3D 16,				\
> +		.endianness =3D IIO_BE,				\
> +	},							\
> +}
> +
> +int inv_icm42607_temp_read_raw(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       int *val, int *val2, long mask);
> +
> +#endif

