Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC181233D9E
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 22:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784499110; cv=none; b=ReQt1s0Iv/waPA9UIZAfxvOSHlZ0z65NQJ5yHbNiPNSrQWB0AifEBzw3PGdeK9msb0KTanxojl/49wi+0XshLMPldEO9w/oP/80aMho8/RxiJzMRMjqE72Hi2JCn/4xl7eweMs/kzYBaxCb+Gau/9GvwKsT9SRBg8gqFociq7HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784499110; c=relaxed/simple;
	bh=ZyBFa2NJlEVivnGX3TaXCQA9Xb+KkWSsCkaEDTgUBKU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DR4uNfgvTfxiY90SB8MtBpqcKt2j49LfxpegJKbUTCgwekK0MogSItYPsr1V3my3sIkvgGGcWRgBRS4Giti2mZqMzv842+uKORKoFyzcxUqhclKeW23UmjNyU5B6KKKotUAlrkUGb/7jdVvm8KOnGzNazDRXLlMDEfjVz3Wbjzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cavp9ncY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kfli9PL7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cavp9ncY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kfli9PL7"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JLeEfo137833
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 22:11:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jCEjfzQRmQt0QukCcwiEwIAzpw+HXl1QbOEgfA+F000=; b=Cavp9ncYEakNVclT
	1rSLp8JprRDvZzcxlx/b23G17Jwitcivd+zW5moLnnWyp5fKn2XtSltyswvGGVon
	t3dEwrFRn7oSo6LRDWx891a3DqRnx5LKVRqYO2NjW8dWbWIhr7tRRZw8hQZMnY/h
	6OrIQuXzdKW8SElFOlNNthX1/GMmUoAlmtTot7xP+suQoAizLybMUqju4vPXGVw9
	8qcv5Z83Hcit6psbzM2yOy1cZJ2/E+yu6wgavfIiNFp7An44T67WkWVRx90tGzzG
	pC6bqyk1YPUL2ITq+DFYybYvJXoiDs9UOfr8cDcvD81b2gz+HF50jqF204TVObhX
	AJeOBQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2nhkhwn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 22:11:47 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cca5e0a0c9so188157245ad.1
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 15:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784499107; x=1785103907; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jCEjfzQRmQt0QukCcwiEwIAzpw+HXl1QbOEgfA+F000=;
        b=kfli9PL75rChd4zLS/NtJI7/dZ84EE3T8u7E+vcBX0sIAbMnAoYJiDmoDYt39pHYqA
         NhE0wkQOh4Pa4eAxzvZerZqjZJOpzwHwQJ+HTv/bNWJSkgHzdROhE8iSzOssVInXT/qI
         NkpFYafYuZSZaHMLOwAudGSN1tDQ6uIhMRRF2GqVv5I1PG5AyALPi9ot5PXrgdeBR+Wj
         /uhXzQ73f4lPxf+jsMpoR4Tf5GJ4ir8BaabxIiBzzaoHR3ilqooNcSg2BfDp/yqFLilD
         tjofQthxJjgJQZmANtI/Edn1pxSDsTdbWPH2tAeeUjJTM20G2cOmet8WL6ZtwL0Wkc/R
         p30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784499107; x=1785103907;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jCEjfzQRmQt0QukCcwiEwIAzpw+HXl1QbOEgfA+F000=;
        b=kVOhXFkWXQj+Pl/ziLqVX1BV6Nflg4wOl11roun21UtS0BI9BzQwJvAmtE2FCscA1w
         DAYyY2j5SOyA/W5aeI0ZukEnM9XusohgBFCvUhHeM9piDaS4gxt0WBuhk7NEle2I4Ma9
         Awl799EtChD92VWpNBAxx9upLFMBVuRESColvF2fbtsn2elas09jGM8MnEL6AfWwtlfD
         GN1/gKuYEj/6QRgwq0q0mRlaz8x8t56fJrEciM8D2M2tqFJL7fbDc8qadACL1DZsMzhe
         lZS0LEOIRvT0D9hBxA/m4F63K5NKyt5rr+yhifpS4fZfnNyRksWKOX+LrwPDUC920Tgx
         Z0xw==
X-Forwarded-Encrypted: i=1; AHgh+Rr1etpJgOcjTlktbFLE3NAkTAgOmCFffLpFu4VK0AEBhQtXOZGzO6dcf7KUbZLbCiG++w7g+0kTU74=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzYtuE84Qs/8BPDNMK41zuB0jIh+rCUQdW4oIzv1Ffht2xBOKX
	c6PNKV51KiY+lfkPQ7K8tLTRj08rA+8pMw/mx0WtVEfMZocB0OLo+w69mxnEI8PJOajW8u2H/gM
	Ood04sBjvUscYbsm76pjVihZxTnI5lqopxdK3y68T6gj07iBaT9CTfw2hg8tSyYDgrMoJ/F0=
X-Gm-Gg: AfdE7clJRsV+Q8FfeBSk2hHzN5aRWTbxcf51hiANwlTrx93W0QMZRJapgvydZfe9ljG
	aCZJIqXrYrcgoZLQ6/Po1WliM1nyKqsSLeDdKOTsbqySSaP2wDxEASzqPTR5WLpLth3Kv47kaP2
	fTMJadiMmwYGB0rjQbdXLY7mPtfSA/K4dRSG5f3batYd21N1vz21rVhlanJs+WIuXQCozv9bIf0
	y0yT0WjC9OvAusZtkkIAcFng1xliHsxkKYC7vjLMkcyhMyJngf0kkk6HXXsQHLleZMB6ttHIQru
	926u6egJS3jQJ1RC5UAHaVfzI/pciKVcaPiJ8mhYPfkQEmx6sKAPHYTDv4CrQk5QV2SWWR4UnR5
	UJuvwKv2c86ubr0Dd
X-Received: by 2002:a17:903:13c6:b0:2c9:cb1b:64d6 with SMTP id d9443c01a7336-2cf348686a0mr124796785ad.19.1784499106912;
        Sun, 19 Jul 2026 15:11:46 -0700 (PDT)
X-Received: by 2002:a17:903:13c6:b0:2c9:cb1b:64d6 with SMTP id d9443c01a7336-2cf348686a0mr124796535ad.19.1784499106379;
        Sun, 19 Jul 2026 15:11:46 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344f61ffsm45728865ad.33.2026.07.19.15.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 15:11:45 -0700 (PDT)
Date: Sun, 19 Jul 2026 23:11:43 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
        Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,
        Petre Rodan <petre.rodan@subdimension.ro>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Akhilesh Patil
 <akhilesh@ee.iitb.ac.in>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
Subject: Re: [PATCH v3] iio: pressure: dps310: add triggered buffer support
Message-ID: <20260719231131.2a6b2364@jic23-huawei>
In-Reply-To: <20260718235203.73699-1-zoone.rupert@gmail.com>
References: <20260718224455.38acd927@jic23-huawei>
	<20260718235203.73699-1-zoone.rupert@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Le0MLDfi c=1 sm=1 tr=0 ts=6a5d4ba3 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=c92rfblmAAAA:8 a=pGLkceISAAAA:8 a=qVBPLa-YRnM7n1ei2JsA:9 a=CjuIK1q_8ugA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: TfG945F_5rFKXiLvd-bJZq_KHB65oOnY
X-Proofpoint-ORIG-GUID: TfG945F_5rFKXiLvd-bJZq_KHB65oOnY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDI0OSBTYWx0ZWRfXxijZ+JOSjJ6M
 Kmmhq2wEZVzTbYDzPF51MwO9KzfMGGwmGYjplTXa7yoMG8x22Ykqrjywt3/+YQkocvCH5p0Qk+2
 VFwD9GZaLFC04bYdLWpUIWoAzSHIxbxeBawrzwiI0YLIBvCvzCwPf3XfhNwDIGOTZJBD9vEXv6h
 ZGybH4fbU3LluIQMEkvd1uQjMN94sBjWQToEy9rEX8PgAF0hl9ouKyc8NrEJs3nxtsS32RnvSfw
 dEEotRfUfnfNJvjI7Wo5GBEeGO2yPCbpXN3gs6wV4W8MEEW963JKFvOUNSUckL0ByKiuOLhJxWZ
 ZO5moX2Mk+Fs0gqJpU8Mm5Xv5Euevy4RhsvOPdej1e0uhFAlOk2nrNI2CY8PdXifbt6jbha12wz
 Ftmqv29bO0tDQp6knGmADzIo54DW4LVM94y26VdQArFK7785WK7EEhWCTtQBhqv9HRZ7SbILSXi
 KXtlaKOPT2Ezdh+8OPw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDI0OSBTYWx0ZWRfX3gWlr3t0gMiO
 9CjUJ4597t1f3rszYDl6Kp9rL58/JU7aRpdskeuQ8NcH+fYp5cjD1DB1ETiQiB3w7zd9rdt1dHm
 eMiZGnm4N1oKEHxIwf0wZ0wbxF36eYE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607190249

On Sun, 19 Jul 2026 02:51:58 +0300
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> Add triggered buffer support so pressure and temperature can be captured
> into a buffer instead of only through one-shot sysfs reads.
> 
> Pressure is a processed value in kPa computed from a non-linear
> calibration polynomial. To keep full resolution in the buffer without
> disagreeing with the sysfs unit, add raw and scale attributes for
> pressure (raw in Pa, scale 1/1000 to kPa), following bme680; the existing
> processed attribute is kept for ABI compatibility. 

Hmm. That is unfortunate.  Ideally in original driver we'd have only
output RAW (even though somewhat processed) then this would be the
same.   Agreed that given the constraints, this is the way we'll have to go.
Can you make sure to add some comments around the chan spec about this.
I don't want it copied into other drivers!

> Temperature is already
> a full-resolution value in its base unit (millidegrees Celsius) and stays
> a processed channel.
> 
> Pressure compensation depends on a temperature reading, so both channels
> are always captured together. The device already runs in continuous
> background mode, so no buffer setup ops are needed. Sysfs reads and
> reconfiguration return -EBUSY while the buffer is enabled, as they share
> the capture path's raw values and configuration.
> 
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
https://sashiko.dev/#/patchset/20260718211727.39752-1-zoone.rupert%40gmail.com

Some stuff in there to check. I haven't looked closely beyond checking
for usual false positives (none of those).

> ---
> Changes in v3:
>  - Rework from just enabling the FIFO into proper IIO triggered buffer
>    support, as suggested by Jonathan.
>  - Buffer the pressure and temperature values; add raw + scale for
>    pressure (bme680-style) so buffered pressure keeps full resolution
>    and stays consistent with the sysfs unit.
>  - Drop the unused FIFO enable/flush/read helpers.

Ah... This wasn't what I meant.  I was expecting to see the fifo
stuff but coupled with use of buffers.  It may not make sense to support
triggered buffer for that case.  Often doesn't for FIFO equiped parts where
the read out of a fifo is not reading just one 'scan' but many and where
timestamps are either not provided or are the subject of non trivial
interpolation of interrupt timings.

So does supporting an external trigger (what this does) actually make
sense for this device?  There are drivers where we do both but I would
expect to see that in one patch set as the mechanism for choosing fifo
(and watermarks interrupt) vs direct reads and a trigger is the complex
corner.   I think what would make sense for this device would be
that fifo mode is used when a trigger is not provided, but disabled when
one is.

Anyhow I've given this a quick review based on the fact we might
want to carry forward triggered buffer support as part of the solution.

> 
> v2 was a resend that still contained the v1 FIFO-enable code.
> 
> Note: this touches dps310_probe() near the separately-sent fix "iio:
> pressure: dps310: fix NULL pointer deref on ACPI probe". It was generated
> on a plain base tree, so applying it after that fix needs a trivial
> 3-way merge/rebase - happy to resend in whatever order or branch you
> prefer.
> 
>  drivers/iio/pressure/Kconfig  |   2 +
>  drivers/iio/pressure/dps310.c | 141 ++++++++++++++++++++++++++++++++--
>  2 files changed, 136 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> index 838a8340c4c0..cef8b90b9ae7 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -112,6 +112,8 @@ config DPS310
>  	tristate "Infineon DPS310 pressure and temperature sensor"
>  	depends on I2C
>  	select REGMAP_I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Support for the Infineon DPS310 digital barometric pressure sensor.
>  	  It can be accessed over I2C bus.
> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> index f45af72a0554..967a2043550b 100644
> --- a/drivers/iio/pressure/dps310.c
> +++ b/drivers/iio/pressure/dps310.c
> @@ -20,8 +20,11 @@
>  #include <linux/module.h>
>  #include <linux/regmap.h>
>  
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  
>  #define DPS310_DEV_NAME		"dps310"
>  
> @@ -90,6 +93,12 @@ struct dps310_data {
>  	s32 pressure_raw;
>  	s32 temp_raw;
>  	bool timeout_recovery_failed;
> +
> +	/* Buffer to hold a scan; timestamp is naturally aligned */
> +	struct {
> +		s32 chan[2];
> +		aligned_s64 timestamp;
> +	} scan __aligned(8);

See below.  No reason to have this in this structure. Just have local
instances on the stack.  + the discussion with Andy, that __aligned(8)
isn't doing anything.

>  };
>  
>  static const struct iio_chan_spec dps310_channels[] = {
> @@ -98,15 +107,38 @@ static const struct iio_chan_spec dps310_channels[] = {
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
>  			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>  			BIT(IIO_CHAN_INFO_PROCESSED),
> +		.scan_index = 0,

Andy mentioned this.  I'd generally prefer an enum used for this
as then anywhere else we can clearly see which scan_index we are working with.

> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 32,
> +			.storagebits = 32,
> +			.endianness = IIO_CPU,
> +		},
>  	},
>  	{
>  		.type = IIO_PRESSURE,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
>  			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> -			BIT(IIO_CHAN_INFO_PROCESSED),
> +			BIT(IIO_CHAN_INFO_PROCESSED) |
> +			BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = 1,
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 32,
> +			.storagebits = 32,
> +			.endianness = IIO_CPU,
> +		},
>  	},
> +	IIO_CHAN_SOFT_TIMESTAMP(2),
>  };
>  
> +/*
> + * Pressure compensation needs a temperature reading, so the trigger
> + * handler always captures both channels; keep them enabled together.
> + */
> +static const unsigned long dps310_scan_masks[] = { GENMASK(1, 0), 0 };
> +
>  /* To be called after checking the COEF_RDY bit in MEAS_CFG */
>  static int dps310_get_coefs(struct dps310_data *data)
>  {
> @@ -583,8 +615,14 @@ static int dps310_write_raw(struct iio_dev *iio,
>  	int rc;
>  	struct dps310_data *data = iio_priv(iio);
>  
> -	if (mutex_lock_interruptible(&data->lock))
> +	/* Don't reconfigure the sensor while a buffered capture is running */
> +	if (!iio_device_claim_direct(iio))
> +		return -EBUSY;

Look at the ACQUIRE stuff in iio.h
> +
> +	if (mutex_lock_interruptible(&data->lock)) {

And similar ACQUIRE stuff for this one.  Given both are
release in all paths just before return it should simplify the flow a little.

> +		iio_device_release_direct(iio);
>  		return -EINTR;
> +	}
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> @@ -625,6 +663,7 @@ static int dps310_write_raw(struct iio_dev *iio,
>  	}
>  
>  	mutex_unlock(&data->lock);
> +	iio_device_release_direct(iio);
>  	return rc;
>  }
>  
> @@ -735,6 +774,23 @@ static int dps310_read_pressure(struct dps310_data *data, int *val, int *val2,
>  		*val2 = 1000; /* Convert Pa to KPa per IIO ABI */
>  		return IIO_VAL_FRACTIONAL;
>  
> +	case IIO_CHAN_INFO_RAW:
> +		rc = dps310_read_pres_raw(data);
> +		if (rc)
> +			return rc;
> +
> +		rc = dps310_calculate_pressure(data, val);
> +		if (rc)
> +			return rc;

Maybe wrap this up in a little helper given sharing with PROCESSED.
Will make that a little more visually obvious.

> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		/* Raw pressure is in Pa; scale to kPa per IIO ABI */
> +		*val = 1;
> +		*val2 = 1000;
> +		return IIO_VAL_FRACTIONAL;
> +
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>  		rc = dps310_get_pres_precision(data, val);
>  		if (rc)
> @@ -804,12 +860,10 @@ static int dps310_read_temp(struct dps310_data *data, int *val, int *val2,

...

> +static int dps310_read_raw(struct iio_dev *iio,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct dps310_data *data = iio_priv(iio);
> +	int rc;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +	case IIO_CHAN_INFO_PROCESSED:
> +		/*
> +		 * Reading a sample uses the same raw values as the buffered
> +		 * capture path, so only allow it outside of buffered mode.
> +		 */
> +		if (!iio_device_claim_direct(iio))
> +			return -EBUSY;

Maybe add scope and use an ACQUIRE here similar to suggested above.
It is more marginal but might make sense to use it for consistency.

> +
> +		rc = dps310_read_channel(data, chan, val, val2, mask);
> +		iio_device_release_direct(iio);
> +		return rc;
> +
> +	default:
> +		return dps310_read_channel(data, chan, val, val2, mask);
> +	}
> +}
> +
>  static void dps310_reset(void *action_data)
>  {
>  	struct dps310_data *data = action_data;
> @@ -843,6 +923,46 @@ static const struct iio_info dps310_info = {
>  	.write_raw = dps310_write_raw,
>  };
>  
> +static irqreturn_t dps310_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *iio = pf->indio_dev;
> +	struct dps310_data *data = iio_priv(iio);
> +	int rc, pressure, temp;
> +
> +	/*
> +	 * Don't hold data->lock across these calls: the read helpers take it
> +	 * themselves and the mutex is not recursive (dps310_calculate_pressure
> +	 * also grabs it with mutex_trylock to refresh the temperature).

Would it make sense to provide a version of these calls that doesn't take the
lock then take it here to avoid bouncing it?

> +	 */
> +	rc = dps310_read_pres_raw(data);
> +	if (rc)
> +		goto out;
> +
> +	rc = dps310_read_temp_raw(data);

Given temperature and pressure are effectively independent sequences I think
you would be better off not providing available_scan_masks() but instead reading
only the ones that are enabled. Lots of examples of how to do that
in tree. 

> +	if (rc)
> +		goto out;
> +
> +	rc = dps310_calculate_pressure(data, &pressure);
> +	if (rc)
> +		goto out;
> +
> +	rc = dps310_calculate_temp(data, &temp);
> +	if (rc)
> +		goto out;
> +
> +	data->scan.chan[0] = temp;	/* millidegrees Celsius */
> +	data->scan.chan[1] = pressure;	/* Pascals */
> +

Drag the scan in here as a local variable. It's fairly small and there
is nothing stopping you having it on the stack given no DMA to it
or anything like that.

> +	iio_push_to_buffers_with_ts(iio, &data->scan, sizeof(data->scan),
> +				    pf->timestamp);
> +
> +out:
> +	iio_trigger_notify_done(iio->trig);
> +
> +	return IRQ_HANDLED;
> +}
