Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8720A2147E5
	for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 22:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783809273; cv=none; b=Glqnx1p2+czum1iknVNXyPqBwcoqBZlphY9hWGDhgQ+FuB0L5GZIfoi1kwuUVZdX50r+WtNN02vmymvd2D57Ry6qoAdlC2gMXzIr3OYTRMxlJbRayK52H4lt//EEl+2jvvduWZ5JAfCWVSFBnEm6LE2xOWzbh0TV5K6EFJbvgWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783809273; c=relaxed/simple;
	bh=Gh9sKno6AmbeIwQ46lHygKBUmSdT3X+8aPM5EN4c23w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pgu+ilWhpflQGe9UMBJqmyT23KS1DntFW4CcoZzc90fWnBaSq0l8kKKf4s6uktU+LOipxzDrUH8i0wmDR35DFegBMK1ncUQKvGRJ9cyE3Lo0yI5JaWc6STUII2qkMDCypJN744FcbOwgpPAJI6Qgw6DNvdcULOGhKP3U/ryHvHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fSW75h3P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fn7JMjS8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fSW75h3P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fn7JMjS8"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66BKx8m3480212
	for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 22:34:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	84W7ov0j976NPWd0rnDPYjpg/tgfZtWev1qXMOfcg/I=; b=fSW75h3PYuPMIAdW
	hHX9j0HDn7D6dBuUm6obxklo1y7NFfcp1KQ6YnZWw1+4UMQcfNBvO0Sgm9b0IOMe
	SL/prE7JViVNvfUwepLJeiHGhUmdnQDYQ3RcVvonVTAHfdDfJOHzy9gBY8ng55If
	Q11yvBixBsJRsNqLWERfkj3bCXkSc+Frx2Z0xZj/Y88VjxmdaGy0TZqkclbvRJoO
	GH+y8UdgfXr6UM3oRvH3EpTr0IgLxKfDAAwgg6apS5Y1kaClGyWT93ThaaMfCxFf
	taHVh8VSfjVm64vJDjQf5HEJNeQYvDGo2UoFo5MjXBddmH1B+6FFpDi+JHFQ9y+I
	6FXAzQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbf0ghn2k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 22:34:31 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84240683a82so1866534b3a.1
        for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 15:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783809271; x=1784414071; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=84W7ov0j976NPWd0rnDPYjpg/tgfZtWev1qXMOfcg/I=;
        b=Fn7JMjS8ORtN7zEDPPVllAC5vdx6y6C1CXWqhr3BnTn2PnuHHMYClocUm9cdfo06wq
         io17clHtN5hQXT4tzS+/KTArekWYLmmF6TVsyCBN4KaKroaTEU+1vqJ0cbKIqCjZkb3S
         En/jWZfqu2lLLXBPwvuRaH6b0c7n/NVRUthsX8Wlr3z6rpvj+cOYQSpo0F5taAiyiqMy
         s2NaHFuk+VBGc8GVqWR6nsj7GveY3FHFT8AsaZ5Wp37MYHR+1Ju2TnQKZjCaq1hY0zHR
         FDwaQH1gdKZLpBPNaQqM/E7GGPR8yC+4lVIoswXz5uC/RxrdcTJ9UKlAbkE3h0+j/SPA
         J57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783809271; x=1784414071;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=84W7ov0j976NPWd0rnDPYjpg/tgfZtWev1qXMOfcg/I=;
        b=EFZuNUzpOnM8I/bjP1yu76RcLfnz8YbGSShuxhsYPlwn3LWqzV6oDv0OkFv9OvUjBJ
         2FgVlu1y/f2xy0ADy3rtmvVHCwdWB7Iby92q2K+PPpjoE/hUb21TM6ThvmfAD2D3LDf8
         WvnypPdrZKNwCTfwXlsWEeUfxfxQAdSpW1C/hXhsckO0vw9kR6f1GzZhxbUYq2s+jHOj
         DWI8gHLEL2oiSVdeqfjHjkYA7uyfuGPqvca8XvDzN+ya2dyo3Rog0OEjrBw/EUg8Lh26
         EEKkAXr9b4WoRQs7lg3gdzA/pfr7svUIEkj+JuLgDofhks24BvB+bsHOILO/x4jGpKwF
         EiGA==
X-Forwarded-Encrypted: i=1; AHgh+RqGpk4uF61ZCbKWDSsmNazHthZrjg17XWbbCuaGdXuwjRIKytWjAdq/u6MSDoL1pDvv9JZ1+OkQWAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU2pb60jqPRrXGvfpeTMzsUmJnQlPSPf1PSSSryZdAr/pkPQ+Y
	OXt2FX2uHfSPDWoxWaNZom8fKqxGPBvz7ROcXzsvo84NrsuK9pizMIdlWasbs2OBIZj0UfZPgwI
	tBEqkl9P5ghfjo24HMNHvpyjmdTuE38tckN2U4Jowvb3OEBtq10MecLovZQ33hfBctdmUZsI=
X-Gm-Gg: AfdE7cnFTq7TMDpo2xxoEQCQxdJG6u0ww4yYWlPsILxCwtuulFA1enzB7kWc1h23hj9
	zBOo9k/z/pPnfmuNur8KdOAaW4JOAIQYT2pt8OLs1GYsIkCB4LOWchaGn32MjJRgxSj2Vlwiz9H
	t6qC2C0MNjQNhNUHcNTsdG5rErHs00lyzzNkoCZRfMGIIH2XEMMCLEi3FmH4eff1ih1XfgFfKOC
	A9Rh273jVPK10rJd1XvWjdhaMtC9/ormptJOskDsbEOy0c2k5/WzjwSwjtdyG0EatCCf4yhsq2D
	PpGZs7eP6U70v2kLiapjUbjeV0cBbkhkAwFOKwLIXuTFKRHcz8w76CPlH4lPghEdZR78fE3CrKs
	tMx+oh+N4/oinJLMZDs81RX3aISE=
X-Received: by 2002:a05:6a00:3d12:b0:847:9d6c:a56d with SMTP id d2e1a72fcca58-8488ab957f5mr3457091b3a.12.1783809270838;
        Sat, 11 Jul 2026 15:34:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d12:b0:847:9d6c:a56d with SMTP id d2e1a72fcca58-8488ab957f5mr3457077b3a.12.1783809270439;
        Sat, 11 Jul 2026 15:34:30 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8494b279e8bsm897046b3a.33.2026.07.11.15.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 15:34:30 -0700 (PDT)
Date: Sat, 11 Jul 2026 23:34:25 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Erick Henrique <erick.henrique.rodrigues@usp.br>
Cc: andriy.shevchenko@intel.com, andy@kernel.org, dlechner@baylibre.com,
        nuno.sa@analog.com, joshua.crofts1@gmail.com, sashiko-bot@kernel.org,
        linux-iio@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: dac: m62332: Fix regulator reference count
 imbalance
Message-ID: <20260711233425.37dbb268@jic23-huawei>
In-Reply-To: <20260703205236.201834-1-erick.henrique.rodrigues@usp.br>
References: <20260703205236.201834-1-erick.henrique.rodrigues@usp.br>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Nq3htcdJ c=1 sm=1 tr=0 ts=6a52c4f7 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=t96C2T9Hioxnv_oDNh8A:9 a=CjuIK1q_8ugA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: 37ctgXXte-mtrjEDPUdTz2zfTIh7F5xo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzExMDIyOSBTYWx0ZWRfX9imR8M1l4m2M
 nMvVr2iDUgud698XswxLcTOUz8TRV5gPnW8h48NTyWD6bkkSBX+OBBUE1D2ZoxQxya+F7rbzX+O
 xab/Xd545F8TZm4P9C0Incy9xGfoBmnAySG5dk1dlTfy90DiAeypWMLPBoXtQ/oDydZXCBeVK+v
 9eQ/9O7lvSMDc4v7bZUs6QA3FQXnroNIzDdAPzaJsQKJcRdXq97/S2fMg25QBFGvZ6+UrgoXkRs
 5L87Cn9aILjtOP6hYNl9laooAP7fYU/1xh5SLwx4Q8zM+wesB38SgdBmh9dWJKnM3KSmB1WxERk
 Sdi13EARTbz3ephPi48fwoohaGGwteSX+6VajBc8ZkOLNU2vqowUsGt5AUlrDSFyQ17YInD3GaC
 GMKbKlj1K2GybB4PD/9B0wJbDcDEojxWBkKXSsnyQlB3V+NW2Fa/kUKCMwM4Hj9TRb2lveoZe+M
 zF48W9NNMiE+yXqys4Q==
X-Proofpoint-GUID: 37ctgXXte-mtrjEDPUdTz2zfTIh7F5xo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzExMDIyOSBTYWx0ZWRfX8+5yHX8kITVN
 EeFqiO71LdaKjR1K/l/UwBtoK9bBqhz6s9Lu4+iBE/RZi61P5r03iLXI91RWxYSiRpPUhKZ18SG
 cX/r9DtIs6/W6pR8S2KoLfgGmrn0wOw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-11_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607110229

On Fri,  3 Jul 2026 17:52:36 -0300
Erick Henrique <erick.henrique.rodrigues@usp.br> wrote:

> m62332_set_value() enables the Vcc regulator on every write of a
> non-zero value and disables it on every write of zero, without tracking
> the channel's current state. Because the regulator is reference counted,
> changing a channel directly from one non-zero value to another enables
> it more than once, while a later write of zero disables it only once.
> The reference count never returns to zero and the regulator is left
> enabled indefinitely.
> 
> Only enable the regulator on the transition from zero to non-zero, and
> only disable it on the transition from non-zero to zero, using the
> previously stored channel value to detect the edge. Balance the
> regulator on the I2C error path so the reference count stays consistent
> if the write fails.
> 
> Fixes: b87b0c0f81e8 ("iio: add m62332 DAC driver")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260418130322.106769-1-erick.henrique.rodrigues%40usp.br
> Cc: stable@vger.kernel.org
> Signed-off-by: Erick Henrique <erick.henrique.rodrigues@usp.br>
Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan

> ---
> v2:
> - Use local enabling/disabling booleans for the edge conditions (Jonathan)
> - Credit Sashiko directly in Reported-by with a Closes: link to its
>   report entry, per Jonathan
> v1: https://lore.kernel.org/r/20260630021309.36636-1-erick.henrique.rodrigues@usp.br
> 
>  drivers/iio/dac/m62332.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
> index 3497513854d7..2c13feee8d61 100644
> --- a/drivers/iio/dac/m62332.c
> +++ b/drivers/iio/dac/m62332.c
> @@ -32,6 +32,7 @@ static int m62332_set_value(struct iio_dev *indio_dev, u8 val, int channel)
>  {
>  	struct m62332_data *data = iio_priv(indio_dev);
>  	struct i2c_client *client = data->client;
> +	bool enabling, disabling;
>  	u8 outbuf[2];
>  	int res;
>  
> @@ -43,7 +44,10 @@ static int m62332_set_value(struct iio_dev *indio_dev, u8 val, int channel)
>  
>  	mutex_lock(&data->mutex);
>  
> -	if (val) {
> +	enabling = val && !data->raw[channel];
> +	disabling = !val && data->raw[channel];
> +
> +	if (enabling) {
>  		res = regulator_enable(data->vcc);
>  		if (res)
>  			goto out;
> @@ -52,14 +56,17 @@ static int m62332_set_value(struct iio_dev *indio_dev, u8 val, int channel)
>  	res = i2c_master_send(client, outbuf, ARRAY_SIZE(outbuf));
>  	if (res >= 0 && res != ARRAY_SIZE(outbuf))
>  		res = -EIO;
> -	if (res < 0)
> +	if (res < 0) {
> +		if (enabling)
> +			regulator_disable(data->vcc);
>  		goto out;
> +	}
>  
> -	data->raw[channel] = val;
> -
> -	if (!val)
> +	if (disabling)
>  		regulator_disable(data->vcc);
>  
> +	data->raw[channel] = val;
> +
>  	mutex_unlock(&data->mutex);
>  
>  	return 0;

