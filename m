Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9602571B8
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 01:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784511499; cv=none; b=VEVjDZycd4CgIuXwkSyHWIdDCoo51Gv/YRBA1ri0pItuaUZKLOtYKLgJ8bBwvIhb1A7rYg6n9x7iLU5t1+ZvQpcVoZTbkPLZm05g9tVdkQqBHcOHkTS/l2lobDBg+StfeqI+XNAFfCqkIc0WzNrn9tArGaAMq3f6GXPYFNt7cHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784511499; c=relaxed/simple;
	bh=f8pkuRdBPEbhQYET7455SSZgWDzYxUPLo4Z0X1985X0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dg+x0hGqoEDV658EgjW+MQ1LP+cfecflvPgANBi+xRLDGmuoXf8cF2DjoQPCbqunK+QEBeX7NDFKN2Wd3uRMvZO667Upjw0vM9HbichL7UZwG/DZv+vG/Zr82QAmvUimpbj3y471d7xN18AKo7n9/mbMMNS42mpvU0+plCydul8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O5dRJ7nZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E5eP244e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O5dRJ7nZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E5eP244e"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JNupuh1024774
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 01:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6zwcLWitFcM7eTedEs2XGg0+vd4LGsIcns34L+sCzH0=; b=O5dRJ7nZqPUWzUCJ
	Jh/pRZVpsswK7qz01kdsiL3O6maynFfYHEdXGOqVNWfl/XR7TU2we6GSoUAdBEBY
	n44XMxZZdRr1r5f/u0qS5t0lGkTrviU7brOaAouJ8OW02EvcsZMhSyEHUkepbJpi
	JSQK3GpYzpAAjAjmknFzGTfzj+escLXAp5rZsPVf88YBkQTqqAHD979EPV0064cv
	Z55jsKzUZIBAaD2rtrFe6hn/Y0YzT4B7IEJBx5PIox4ppL4YFjI3IrTIJNn82RPK
	wlVF9yJ8Dv85Y55ls0C7yTjiSW88IW9XllwKpAt+rqySveHUGIarRPeU4d7lYBf9
	CnyYhg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2d93vgg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 01:38:16 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cf6acd760cso5705245ad.3
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 18:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784511496; x=1785116296; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6zwcLWitFcM7eTedEs2XGg0+vd4LGsIcns34L+sCzH0=;
        b=E5eP244et2o0ALBtnNPTjAc+dIgldlcOg416D4VGu7XvI1VOV/Im5T6DXywGePX5B1
         pPzeUKL+dQtGo5MOZhzWR2DOsco/4U4xM65iSzKUxhlcGnZiFwjj1kVKRiCBcgE3sT06
         XfDWibspuDHauja/KePzkqojwo/htohDJNEKef1azNTQiMnkiH2LM/TtKz2KFqPhD9K5
         AmYElfiXgUfBYzL/fOykAXSMQoZiQ9/12itQOeFtJ8+40rB51wEa+PCrieeXaTxtETi4
         FQIH+DTOaNtYdDXN9XkKqYSsWG8n2aTsCEdpv2lNym8WWeQ1o247oXQhfeJ/fScEayiD
         PacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784511496; x=1785116296;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6zwcLWitFcM7eTedEs2XGg0+vd4LGsIcns34L+sCzH0=;
        b=kVf5oE1IIkvhw7gdMS4syXdt7y7kjFglVtbylkF9+1o8hR9H/5q7xRsLC4s58HI+ho
         pWZgwcU+Lh3LwXiPsILcN1ZzECuOGxZxEJRv2EyHFGIxhkvF9pS6Dcc6/w01sYMi83ej
         YcvQoY+qw4et3J16nfghWvwHqPVt3bZKAIuT/C9vHNwo0CLUvWYbORf287niBPQ8olBB
         o2jFcrj59wg7z18RS4mRHcX5hiKj7tO5JeZQghMyw0B19YaJ2b9x1gV3Y3KzZU06Xtwm
         izAYxrdyLJftUg3BAfitbnOYkSWr/TqRPwHMfiZkXSLf/7JOEsj4fqR0pJjBfsWA+PWI
         h4bA==
X-Forwarded-Encrypted: i=1; AHgh+Ro4/x8vNc6Xjnxvg9XuLzsy5gOiEmv66K/lUB28vgPu9+Jlyn8Fna8Y5yb955JRqzvGncqcrKt3RyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM6Al7v6/OHOW0+khoxCE7pMWjL0qFINA4PijuHQ2ehH22C0VN
	A3L+qHAOEJZEJfrXVd4hFB8DVZfQCyNAS0c1bb15rv3+kraXZlG85F2sh7wlp/cGnkgWLBW7bsr
	LiSA2ICptAop83tNGhmztvyM8cJU47oFc18Jr+1umCGheB2ly4Q4B1yMu3p0US6Q=
X-Gm-Gg: AfdE7cku0tMl71Ef217IeaQFH5ShRzEP8dvos39yu6fROPvGaAJHkytu+S+VG9OjdDT
	s/Xwx49LkKow5ZImFUesRs/Kz39nwR7GRHboxos7osLqY6tLI1abgih4n57lRrMa7eSrHvjn5/1
	P3mm7ruqaFuwbR6/JYuODhC9YfeoRkqC4JU+p24KOBWkdBkAMmThY5G86b/Au902v9SOWSOvht5
	gEbsQZtnShNq0MwfqpNEZzfGDGeCj2kR+O1DawKzOxtEmVhgKiFmZ44b7K7D/kqmut/2RdWJ33H
	PO6tpv2dY08q21uOcqtu15ozwPWIwnRR5oPE5ZcHLIdRaFsNp2/sV4eKXg5sQW2dNC1e0HvhhUS
	nJK+hpAE/xp6jfFN3
X-Received: by 2002:a17:902:e548:b0:2c9:a5e9:c26e with SMTP id d9443c01a7336-2cf348546c2mr134300065ad.13.1784511495732;
        Sun, 19 Jul 2026 18:38:15 -0700 (PDT)
X-Received: by 2002:a17:902:e548:b0:2c9:a5e9:c26e with SMTP id d9443c01a7336-2cf348546c2mr134299635ad.13.1784511495154;
        Sun, 19 Jul 2026 18:38:15 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf346db113sm46824655ad.39.2026.07.19.18.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 18:38:14 -0700 (PDT)
Date: Mon, 20 Jul 2026 02:38:11 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: David Lechner <dlechner@baylibre.com>,
        Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Siratul Islam <siratul.islam@linux.dev>,
        Luca Weiss
 <luca.weiss@fairphone.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: magnetometer: add support for QST QMC6308
Message-ID: <20260720023811.09741911@jic23-huawei>
In-Reply-To: <20260714202842.340293-3-jorijnvdgraaf@catcrafts.net>
References: <20260714202842.340293-1-jorijnvdgraaf@catcrafts.net>
	<20260714202842.340293-3-jorijnvdgraaf@catcrafts.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HpxG3UTS c=1 sm=1 tr=0 ts=6a5d7c08 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=c92rfblmAAAA:8 a=GYSh3LzNAAAA:8 a=g-q4vcgDu0r2VoyuJZgA:9 a=CjuIK1q_8ugA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=GvGzcOZaWPEFPQC_NcjD:22 a=lWcdFasyL5yHfcDTNXXo:22
X-Proofpoint-GUID: cU3G_wfqHbdmBT22C6q_Iefv0QqRK9ZK
X-Proofpoint-ORIG-GUID: cU3G_wfqHbdmBT22C6q_Iefv0QqRK9ZK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDAxNCBTYWx0ZWRfX17OFopLqLRIP
 MJVcK4KLL4EKOcRWbC5Ca4VQMYUw/uVMUDV6dg/6P/cv8E5/MAbjbDODEi36tkZ4xYeyjzOGWzO
 RE+leQEAlUMFZ7MBDQ/CRc/cy2nhRAOGSPd7pbyaoEAC4kWG/ZHS6pIK59bY84x34vYR507DqbM
 wdgQubfVtcQ2L2pgF2x0/qmDRY/vvRISYBG9fXzzKudN97DwQUKnWnR+n1EHlaIOogCTif2oAtK
 qvYMbZG/Zl/GHbV56S7lbniHoSeLstlF36ChcOtyefvayXcFb53Ru0WgHZUvQcAYe6fwOuMAQgw
 baw6gddXFQwsHs1J9yQYus3lIjW101KKYRbxYBs6UaOO3BSCNzpVFLagvb9Djy9TWLnji4cMAXY
 q6ZoLSQEvOxek1VPCmMb7btcBnI8wQbRxefmLPOqSvSsY7eRDiZ1rThDn38CHzWvbs3lNxk/S1F
 Kw4Wr/sN7glzGTzjGEQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDAxNCBTYWx0ZWRfX5MyD7fcBedbe
 AX3sYvTDpt1sjJ4cwbAmT3riykL8kmhMD1eOoREjbMmsXigIPXatJCUE/MD3/VgQAnlmcjbP0iS
 Xf4kA3k7znamzSfUrY9rrmaqAb/6wgk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200014

On Tue, 14 Jul 2026 22:28:42 +0200
Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net> wrote:

> The QST QMC6308 is a 3-axis AMR magnetometer on I2C, a single-supply
> 4-pin WLCSP part with no interrupt/DRDY pin, found e.g. in the
> Fairphone 6. Its register map differs from the QMC5883L (chip ID at
> 0x00 instead of 0x0D, data at 0x01..0x06, and the range field living
> in control register 2), so add a separate driver rather than extending
> the QMC5883L driver.

Trim this description down for brevity. Drop the package, and I don't
think we need to mention anything it doesn't have.

> 
> Support raw X/Y/Z reads, output data rates 10/50/100/200 Hz, field
> ranges +-30/12/8/2 Gauss, filter oversampling ratios (OSR1) 8/4/2/1,
> the mount matrix, and runtime PM. The second-stage decimation filter
> (OSR2) is left at its power-on default. The package has no DRDY pin,
> so there is no trigger support.

As above I'd not mention what we aren't doing. Also not sure there
is particular value in listing the values each parameter can take.

> 
> Run measurements in the chip's periodic "normal" mode paced by the
> DRDY flag rather than in its one-shot "single" mode: the datasheet
> specifies no conversion time that could bound a one-shot wait, while
> normal mode is paced by the specified output data rates, which also
> keeps the sampling_frequency ABI meaningful.

This is a little unusual.  Unless single mode is really bad we'd
normally just use that for sysfs reads.  Still I don't really mind if
continuous makes more sense here.


> 
> Runtime PM puts the chip into its suspend mode after 500 ms without a
> reading, dropping supply current from tens-to-hundreds of microamps to
> 2-3 uA (datasheet Table 2). The suspended chip retains its registers
> and keeps responding on I2C, so resuming only rewrites the mode field
> and discards one stale sample, and configuration changes can be
> applied even while suspended. VDD is left enabled across runtime
> suspend: the on-chip suspend draw is already negligible, and register
> retention is what keeps the resume path trivial.

This is a bit verbose but I suppose some useful info for reviewers in
there.  Maybe take another look at cutting it down.

I'm going to assume fable was busy here. Try asking it to be brief
in the patch intro, or just edit it after!

> 
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
https://sashiko.dev/#/patchset/20260714202842.340293-1-jorijnvdgraaf%40catcrafts.net

Has a few comments. I may or may not remember to call them out in
this review as well!

Nice driver in general

Just a few minor things from me.

Jonathan

> diff --git a/drivers/iio/magnetometer/qmc6308.c b/drivers/iio/magnetometer/qmc6308.c
> new file mode 100644
> index 000000000000..ceb4b98402bb
> --- /dev/null
> +++ b/drivers/iio/magnetometer/qmc6308.c

> +static int qmc6308_take_measurement(struct iio_dev *indio_dev, int index,
> +				    int *val)
> +{
> +	struct qmc6308_data *data = iio_priv(indio_dev);
> +	struct regmap *map = data->regmap;
> +	struct device *dev = regmap_get_device(map);
> +	unsigned int status;
> +	__le16 buf[3];
> +	int ret;
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret) {
> +		/* EACCES means a read raced runtime PM disable on suspend */
> +		if (ret != -EACCES)
> +			dev_err(dev, "Failed to power on (%d)\n", ret);

Whilst not a permanent issue, why do we care about hiding the error message? I'd
just print it whatever.

> +		return ret;
> +	}
> +
> +	scoped_guard(mutex, &data->mutex) {
> +		/* 50ms headroom over the slowest ODR (10Hz) */
> +		ret = regmap_read_poll_timeout(map, QMC6308_REG_STATUS,
> +					       status,
> +					       (status & QMC6308_STATUS_DRDY),
> +					       2 * USEC_PER_MSEC,
> +					       150 * USEC_PER_MSEC);
> +		if (ret)
> +			goto out_rpm_put;
whilst this is technically not a bug, cleanup.h has some guidance that
was written with maintainability in mind (and a few pointed comments from
Linus Torvalds - no one likes making him grumpy ;)

Upshot (and sashiko has this right) is don't mix goto and anything from
that header. 

Here, take a look at:
pm_runtime.h and in particular
PM_RUNTIME_ACQUIRE_AUTOSUSPEND()
Don't worry about keeping it powered up for a tiny bit long than strictly
necessary.

Added bonus is that then you can use guard() rather than scoped guard
for the mutex and return directly on errors.

> +
> +		ret = regmap_bulk_read(map, QMC6308_REG_X_LSB, buf,
> +				       sizeof(buf));
> +		if (ret)
> +			goto out_rpm_put;
> +
> +		if (status & QMC6308_STATUS_OVFL)
> +			ret = -ERANGE;
> +	}
> +
> +out_rpm_put:
> +	pm_runtime_put_autosuspend(dev);
> +	if (ret)
> +		return ret;
> +
> +	*val = (s16)le16_to_cpu(buf[index]);
> +
> +	return 0;
> +}


> +
> +static int qmc6308_init(struct qmc6308_data *data)
> +{
> +	struct regmap *map = data->regmap;
> +	unsigned int reg;
> +	int ret;
> +
> +	ret = regmap_read(map, QMC6308_REG_ID, &reg);
> +	if (ret)
> +		return ret;
> +
> +	/* Allow unknown IDs so that fallback compatibles work */
> +	if (reg != QMC6308_CHIP_ID)
> +		dev_warn(regmap_get_device(map),
> +			 "Unknown chip id: 0x%02x, continuing\n", reg);
> +
> +	/* The SOFT_RST bit is not auto-cleared and must be written back 0 */
> +	ret = regmap_write(map, QMC6308_REG_CTRL2, QMC6308_SOFT_RST);
> +	if (ret)
> +		return ret;
> +
> +	fsleep(QMC6308_POR_US);
> +
> +	data->range = QMC6308_RNG_30G;
> +
> +	ret = regmap_write(map, QMC6308_REG_CTRL2,
> +			   FIELD_PREP(QMC6308_SET_RESET_MASK,
> +				      QMC6308_SET_RESET_ON) |
> +			   FIELD_PREP(QMC6308_RNG_MASK, data->range));
> +	if (ret)
> +		return ret;
> +
> +	data->odr = QMC6308_ODR_50HZ;
> +	data->osr = QMC6308_OSR1_8;
> +
> +	return regmap_write(map, QMC6308_REG_CTRL1,
> +			    FIELD_PREP(QMC6308_MODE_MASK,
> +				       QMC6308_MODE_NORMAL) |
> +			    FIELD_PREP(QMC6308_ODR_MASK, data->odr) |
> +			    FIELD_PREP(QMC6308_OSR1_MASK, data->osr));

I think you mentioned in your discussion with Siratul that you'll explicitly
set all the fields.  Sashiko noted that you say you are leaving OSR2 alone
(in the patch description) but then set it to 0.

> +}



> +static int qmc6308_probe(struct i2c_client *client)
> +{

...

> +	ret = qmc6308_init(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "qmc6308 init failed\n");
> +
> +	pm_runtime_set_active(dev);
> +
> +	ret = devm_add_action_or_reset(dev, qmc6308_power_down_action, data);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_get_noresume(dev);

We've had a few cases of this recently and there are plenty in tree.
However, it's unnecessary - follow through what happens in dd.c
after probe() is called.  Ultimately it checks the counter and if 0
I believe it will power it down without needing this increment / decrement.

Dropping this tends to get sashiko confused, but will resolve the compaint
it has right now about raised reference count on exit.

> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_set_autosuspend_delay(dev, QMC6308_AUTOSUSPEND_DELAY_MS);
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_put_autosuspend(dev);

As above, this should be unnecessary.

> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static int qmc6308_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct qmc6308_data *data = iio_priv(indio_dev);
> +
> +	return qmc6308_set_mode(data, QMC6308_MODE_SUSPEND);
> +}
> +
> +static int qmc6308_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct qmc6308_data *data = iio_priv(indio_dev);
> +	unsigned int status;
> +	int ret;
> +
> +	ret = qmc6308_set_mode(data, QMC6308_MODE_NORMAL);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * DRDY may still be set for a sample converted before the last
> +	 * suspend; clear it so the next read waits for fresh data.
> +	 */
> +	return regmap_read(data->regmap, QMC6308_REG_STATUS, &status);

This feels like a solution in the wrong place.  Why not move it
to the read_raw() path after the runtime resume call?
Sure it will add a delay on repeated reads, but they are coming from
sysfs so we don't care that much.

It is fine to do it here because nothing else resumes but none
the less it does feel rather unintuitive.  If you really want it
here maybe add a note in the read_raw() code path that says it will
have been cleared if resume occurred.

Also if this fails, you should put device back into suspend mode
so as to end up in a consistent state.

> +}



> +static struct i2c_driver qmc6308_driver = {
> +	.driver = {
> +		.name = "qmc6308",
> +		.of_match_table = qmc6308_match,
> +		.pm = pm_ptr(&qmc6308_pm_ops),
> +	},
> +	.id_table = qmc6308_id,
> +	.probe = qmc6308_probe,
> +};
> +module_i2c_driver(qmc6308_driver);
> +
> +MODULE_DESCRIPTION("QST QMC6308 3-Axis Magnetic Sensor driver");
> +MODULE_AUTHOR("Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>");
> +MODULE_LICENSE("Dual BSD/GPL");

Why BSD?  Coming from somewhere else or you have particular reason to
prefer that.  It is relatively unusual for kernel drivers.

Jonathan
