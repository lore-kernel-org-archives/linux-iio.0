Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B324C33F8B8;
	Tue,  3 Mar 2026 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772541666; cv=none; b=Sxn17d2PoQgmYsv7O1J+M26UzoMxt1nxk5JycpeyxGjgMxdHIhIN5ypzudNL1uJcNGrIaix5DAEiLw94yG8bmLHxVS5dxwaLhMYwGKqg5llJuBG/iCg4sO1p30dIKr2SoQBCgzhspTH1Kk4EZIkihXFlXDz/cZow700EIfL/rOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772541666; c=relaxed/simple;
	bh=dku9ClqyIz82+ydgdcwrWNpz+rR9MfDUOzZY/JGnHDs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gEG6G+SWcvRSlVrzvRYEc6FoEU4cc48/vPfwWMa7w77+J++EbyVAZx1uczeoXy1mn57a+0TzG6N07Bb8GPZPYDoylEkSIyO+H1qfMRyQbWtmKVZFP4+zHWOLgI+tKYAiL0sBANDclBMXhon6bNdQ3CX/n5GEEC2Whdq9YmPMyLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=XaM2fqDt; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="XaM2fqDt"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623A5IXq3241106;
	Tue, 3 Mar 2026 07:40:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=3z57r
	Xy5Qs2cbSdlcG6upTN5n/op/p4tnXdcEZGbfVY=; b=XaM2fqDtbaUgKN30BXyhy
	QiKKsLzYq0UOh/cQZrem4HI1ZT6T4xiiaUUoJmZIiNJ/fhVyjCVtMbaqMSNf6d+e
	4J0SeCuUSWxsXcMlTOebj2jd0LMTTc9HYKbQAQoVCLIgemPSRAm69Ji7NMiBx7zS
	aFxCHq7jcgJOahLeADQvc1ue3cHtHySn6OCeByshd0jPZ7nxy+esXuuglVG1nDQR
	FKNVD4JEKVE4Hq6b5w1zxbXdu9UUBu/qPW+kc6ld/qNA+vjuRFFIn8FK5DG6GpW6
	Cp2AffK0fidVuKkaiEFmsHkuGsTD+iTY9p0Pb0krajxd+z6XjR39/2R3KdaMHEpI
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cmn4kgq4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 07:40:36 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 623CeZM5053291
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Mar 2026 07:40:35 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 3 Mar
 2026 07:40:35 -0500
Received: from ASHBMBX9.ad.analog.com ([fe80::a11:40fc:1a6f:d912]) by
 ASHBMBX9.ad.analog.com ([fe80::a11:40fc:1a6f:d912%20]) with mapi id
 15.02.1748.037; Tue, 3 Mar 2026 07:40:35 -0500
From: "Budai, Robert" <Robert.Budai@analog.com>
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        "Miclaus,
 Antoniu" <Antoniu.Miclaus@analog.com>,
        "Gradinariu, Ramona"
	<Ramona.Gradinariu@analog.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iio: imu: adis16550: fix swapped gyro/accel filter
 functions
Thread-Topic: [PATCH] iio: imu: adis16550: fix swapped gyro/accel filter
 functions
Thread-Index: AQHcp+OPKWEzQUSSUEypENWyQaPuCLWcwiAg
Date: Tue, 3 Mar 2026 12:40:35 +0000
Message-ID: <d1274cf4b7824cdea509d6ad5a48c291@analog.com>
References: <20260227122046.46710-1-antoniu.miclaus@analog.com>
In-Reply-To: <20260227122046.46710-1-antoniu.miclaus@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-adiruleop-newscl: Rule Triggered
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA5OSBTYWx0ZWRfX74u4ZTsVaz7D
 K5V2DaFHO8lyFM8563ccUNa8ZGaipgHCMQKAmEKFTYbXW5ZkZgREkvgUrDLQURQsaJJyYAC0xHv
 yrDZZJnhEAoUGGYdazjngNuWbQqZhkl9oSNSKyMYzeG+Ul+ZKszad83A2yQHn5hTo/ZZTLFJ2w9
 4AJ1PjISufYNWb9LhVls3wot5RWSm++cYFoM/p17n0Au+k5p58aBsCGWzGoyTp48DV+2HIvKUII
 1xpHxDNRcU6G8sr/+VLEcvS1Xf2MMEXGRNxVa/UAoP8h8RkIPPJLA4Raif90yeBQfb/0S5ctz8n
 V+d4eG0uQf0ErZGofiyeiZgiLPYFvEEaKWv95u1L17574cPQKfwCtDSEed1HxRLtUB7mFDSjdhD
 h40fs5efD0LjJwp5JP6ahBMoFQ6A9BKfSdQHfdrqENZhP8kBF4dKwUjrCpwooSz/P496qgpvshM
 3VLNO79bgZGI+CzOlkg==
X-Authority-Analysis: v=2.4 cv=Y7P1cxeN c=1 sm=1 tr=0 ts=69a6d6c4 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=xqWC_Br6kY4A:10 a=OAZArwk5CoAA:10 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22
 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=Ei31wznoqjZzguDbTf0A:9
 a=CjuIK1q_8ugA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: iTyEAR3JkOrOTOoGgna5EK5iOQkN-j22
X-Proofpoint-ORIG-GUID: iTyEAR3JkOrOTOoGgna5EK5iOQkN-j22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1011 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030099



> -----Original Message-----
> From: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Sent: Friday, February 27, 2026 2:21 PM
> To: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Jonathan Cameron <jic23@kernel.org>;
> David Lechner <dlechner@baylibre.com>; Sa, Nuno <Nuno.Sa@analog.com>;
> Andy Shevchenko <andy@kernel.org>; Budai, Robert
> <Robert.Budai@analog.com>; Miclaus, Antoniu
> <Antoniu.Miclaus@analog.com>; Gradinariu, Ramona
> <Ramona.Gradinariu@analog.com>; linux-iio@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] iio: imu: adis16550: fix swapped gyro/accel filter funct=
ions
>=20
> The low-pass filter handlers for IIO_ANGL_VEL and IIO_ACCEL call each
> other's filter functions in both read_raw and write_raw. Swap them so
> each channel type uses its correct filter accessor.
>=20
> Fixes: bac4368fab62 ("iio: imu: adis16550: add adis16550 support")
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
Acked-by: Robert Budai <robert.budai@analog.com>
>  drivers/iio/imu/adis16550.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/imu/adis16550.c b/drivers/iio/imu/adis16550.c
> index 28f0dbd0226c..1f2af506f4bd 100644
> --- a/drivers/iio/imu/adis16550.c
> +++ b/drivers/iio/imu/adis16550.c
> @@ -643,12 +643,12 @@ static int adis16550_read_raw(struct iio_dev
> *indio_dev,
>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>  		switch (chan->type) {
>  		case IIO_ANGL_VEL:
> -			ret =3D adis16550_get_accl_filter_freq(st, val);
> +			ret =3D adis16550_get_gyro_filter_freq(st, val);
>  			if (ret)
>  				return ret;
>  			return IIO_VAL_INT;
>  		case IIO_ACCEL:
> -			ret =3D adis16550_get_gyro_filter_freq(st, val);
> +			ret =3D adis16550_get_accl_filter_freq(st, val);
>  			if (ret)
>  				return ret;
>  			return IIO_VAL_INT;
> @@ -681,9 +681,9 @@ static int adis16550_write_raw(struct iio_dev
> *indio_dev,
>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>  		switch (chan->type) {
>  		case IIO_ANGL_VEL:
> -			return adis16550_set_accl_filter_freq(st, val);
> -		case IIO_ACCEL:
>  			return adis16550_set_gyro_filter_freq(st, val);
> +		case IIO_ACCEL:
> +			return adis16550_set_accl_filter_freq(st, val);
>  		default:
>  			return -EINVAL;
>  		}
> --
> 2.43.0

