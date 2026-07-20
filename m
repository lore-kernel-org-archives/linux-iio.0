Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626CC272E6D
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 02:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784513386; cv=none; b=WVPEY2m1HjUHLL1kFsQ7+FNeAnf5cao19/M/2jFi+VinEKP9Zom3x6IjluJHQEPcC3RG1OSNxM8evNZ2DO4n9rI630kz6xlA7AzJ+2KSnUe/ckQSPJ3SviqmTnildlW/LiYCOh4wp4e/nNzk/0Lg7WsSD4NE1pzegAK3m7F3WWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784513386; c=relaxed/simple;
	bh=LOq550oZdYMXzH9HST84dp+4UmnsdWmFQkhaMMLPCS4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mo9yAhbjxfEuuy4pMXLoo1+JO9qthc8CDAFu1U90w6VDN1tt8nK8GONtWpAb8QI6Cs3ChUGkBeAPgju8Et+cOIDOzfN0I/VuNZGtUPjRjKSl/i+Sy5vLpDlYQcHEgbKbnY/ZTRqhiOeRW4G2R+dPdu5jfVPYki+GPVMomhlLmZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d7zQVrz8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=azgtgalU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d7zQVrz8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="azgtgalU"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JNt2rM902670
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 02:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	007+nLYN72ZEaozMMOfz5QZ6KNBrKf3sjeslstsi8cw=; b=d7zQVrz8uw29Ce3B
	BDptq0dwrDbq1hD6RSEeNdasDtKHXgWEof8TlVOtabw1VM9pw/29jz68Bv5L+E36
	zBFU985QcJS+ZSHkiJHMNkSFqskZloENIAE/4yoN0Ft0YuzyZxLvn+Z5LbUQ6uYw
	e1Wvatyh+EFek96+CGPHS/p1gcv+JbKJhjBg93o0ebuem2NrOR/8hnb9hmFGOA9c
	/UUJGsH+2kPLnwg8JETZsDe9LqE0qkdBQuuC+MEL6mDKyvnh8eQQ/FNWvwWFFmIJ
	UgNt9qluv86zH6mlRsqu1vKpAILNi15yOOoAkYXyolcyGZAPI5q7cNjmDvWkptbs
	Fp+yaQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2bnkymd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 02:09:44 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc86a9ef97so210936555ad.3
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 19:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784513384; x=1785118184; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=007+nLYN72ZEaozMMOfz5QZ6KNBrKf3sjeslstsi8cw=;
        b=azgtgalUaOXBlr2VkcGknLNZED31adYOYKF7PImmrfrl4XlzpSMaZn5kuzMLiJd0aT
         2txYDSLqY/ZiTvf7oLFQjIIgLGc37R7B7vjm8ImswXPlFO45EmGShJW5CuK/GhmyuoKI
         b7JI7PUCqzsz1Sw2Mxtw+3hyLcBAdTJVRXWjp9u4jDAr1CELhT3Uq1odesyHh4uyukgF
         imlulX5gxvBduw9qK3QDZox5sA55MjK6odmON/3kVIPXpzPnn1QyvjnmRYBfPCl3cGr3
         puysV4Zh9o7duBxccMvawsA/jYoZdrDIJMRVLDaVs5AuQhjpRI2r3TDgykqvbblZwX0Z
         wCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784513384; x=1785118184;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=007+nLYN72ZEaozMMOfz5QZ6KNBrKf3sjeslstsi8cw=;
        b=kJRmwl1E675uB0zcYzzqVN5TNzuplTcGSqDHqEvwOYXZuMdg3c1GZU+NHP5dmDCjhW
         SyKRAmsiYrTlMPzvAkSq8AxIY5eLrVTJ1PS67zOGqF5JeQwReEaXHirtCBHP+FMxNwqX
         iMl7mJo29TvpVS69qQnGa8nj2HIE5qXsLQouuQsA13tvWugKOZveRHL4II23jxEMKv4o
         tc3MptEdRGqyMOmh8uMIpZMdMmJ77oQzkQHc10QEQ0obTKgcsPfKXxVIHMbBUWwwUfGf
         2cMkKnbYHhJ3rhOcTRfwnnxsKNJFAV6VEoopWe+INKx+t2ACZ8ecpV/+Uacn2POEb28g
         q+zg==
X-Forwarded-Encrypted: i=1; AHgh+Rr8eQjX4cwIZh2KJ7aCYs9YrVOCKxbSqekM7f7sruZ1lIMv50R8pxuEoGWYPmOWHj7Y1IY5wbZGmkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFOzOgrRwxHppOp6PxTPtijYZc0Vn0EL/oMxaMAJfiVEZdKuzq
	dOhsZSZ2V8jc5ONXqM5MDTh4W3NwWJTF745W7XoacaSgfFl4B+PceDXT7O9mPPM+733TPHskHQi
	4BHOJyjFSVIoe7VLt5FRTs90hcD7nv98FCsXbF2tXSnpZEaysQO9EchNmqROKJdw=
X-Gm-Gg: AfdE7clMpm33KZYk1OLIRncKAA5RNrAyTEi9tcD9hWD2Iax3UvwZtT12INVstEejfoK
	Frmy86eqwaYDB3gFEfH31YJ7m/+PBx2DBHXNj/OpTFyoD4Zp08X/9rMmaCeqEXQdK1g3pifkoVZ
	UUsrIIhC90Z5DFXlUUdRxGHPBDfm1FtNjrRx/tryimYjvZEvGdoq/pVbyYlppjLN50qV9ZGS8Pk
	R/uWrPwXBqtLFEU1kHl/P7cZDLaza+5cjxQ6RbiS9M5bEbKZum8/IrGRF4RM2uPFT1CUaXxPpgM
	imgn8LTeVvnhqAOqzZuuzxAJMBl3bLXOh4ZySr9+jFK4EojzoGsG1stKSF7EaWD+N+9apnCsFHw
	xou4xz7blNvqjKzWF
X-Received: by 2002:a17:902:da8d:b0:2ca:10c6:f69b with SMTP id d9443c01a7336-2cf3482135fmr135999435ad.5.1784513383743;
        Sun, 19 Jul 2026 19:09:43 -0700 (PDT)
X-Received: by 2002:a17:902:da8d:b0:2ca:10c6:f69b with SMTP id d9443c01a7336-2cf3482135fmr135999045ad.5.1784513383225;
        Sun, 19 Jul 2026 19:09:43 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf346d9ba9sm48395085ad.48.2026.07.19.19.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 19:09:42 -0700 (PDT)
Date: Mon, 20 Jul 2026 03:09:38 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Biren Pandya <birenpandya@gmail.com>
Cc: linusw@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
        andy@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: gyro: mpu3050: Fix runtime PM leak and refactor
 trigger state
Message-ID: <20260720030938.697b5a2b@jic23-huawei>
In-Reply-To: <20260714131426.4257-2-birenpandya@gmail.com>
References: <20260615214504.38979-1-birenpandya@gmail.com>
	<20260714131426.4257-2-birenpandya@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDAyMCBTYWx0ZWRfXxXiVw3r12zVg
 GaPPl2QiTyNLPi6jJithtNRSh+r9/qdFmr3uaJA5cjO9/sXZxsgxOzchoU062CEo2ctu3nXDVZg
 xe+mFNfERM3ZOd+kFApWTq2SBoiFzGUoRUfzBzdll7pl4holgOHOOup7srDrOEXPvFcXcnCIFXl
 z4T0H0o3/Jc7FJZKc+C9XnI2N9yGI449oP13cjWmAQDsEm+m5IaR628utQo5n1f8z98eK346PZ5
 sBVLu4ri3oZpMtlJwqvyWrz0EfcjFskioPbcdqMXWvL2zA288kySijdOdz20UrpWZeWCACsTAc2
 Stvz7fj/nNOoPlNNM0iBNHO7hYA13SOcmAXnw1bczpHaTbtBF1AtHEMjqmWaR0hidPN0vG9fEKY
 LHTSyBjouDuKmo1NSzUq/5GI8KUZ59JIv5LcFf99Zi1zgAMiGwlUlfdHzkrj91lsRHlqP6ZYV1d
 3AGbS0veP2/vJodXbpQ==
X-Proofpoint-ORIG-GUID: p5bghGurqLnU5LK-HvV8BWR2IfjJ05Ev
X-Proofpoint-GUID: p5bghGurqLnU5LK-HvV8BWR2IfjJ05Ev
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDAyMCBTYWx0ZWRfXzPA1jDTPIezM
 4POmBeRcshQHhBquNPOB4OltfbnPJYJqa+zqiAEonwrB6mE8tcrEAeCosTPmIqSF7HEM7RYbvYb
 dx1VQgE1Liy64KP2cWKTZOHu7KRuGxw=
X-Authority-Analysis: v=2.4 cv=deOwG3Xe c=1 sm=1 tr=0 ts=6a5d8368 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=mUsWOzX0D04toIqhuc4A:9 a=CjuIK1q_8ugA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200020

On Tue, 14 Jul 2026 18:44:27 +0530
Biren Pandya <birenpandya@gmail.com> wrote:

> mpu3050_drdy_trigger_set_state() calls pm_runtime_get_sync() when the
> trigger is enabled, but several error paths in the enable branch return
> directly without dropping the usage counter again. pm_runtime_get_sync()
> increments the usage counter, so every failed enable leaks a runtime PM
> reference and the device can no longer autosuspend. The driver state flag
> hw_irq_trigger is also left set after a failed enable.
> 
> To fix the error unwind clearly and avoid an asymmetric goto block inside a
> monolithic function, this patch breaks the trigger state handler into two
> distinct helpers: mpu3050_drdy_trigger_enable() and
> mpu3050_drdy_trigger_disable(). The enable helper correctly implements the
> error unwind path to drop the PM reference and clear the flag.
> 
> Additionally, pm_runtime_get_sync() is replaced with
> pm_runtime_resume_and_get() for robust error checking.
> 
> Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
> Signed-off-by: Biren Pandya <birenpandya@gmail.com>

Hmm. I just replied to an ancient version... Reason being you keep
sending new series in response to old ones.  Do not do that as it means
simple date sorting fails!

Anyhow, some comments inline for this approach.

> ---
> 
> Changes in v3:
> - Fixed kernel-doc warning for mpu3050_drdy_trigger_set_state().
> - Fixed the Fixes tag title to exactly match the target commit.
> - Link to v2: https://lore.kernel.org/all/20260615214504.38979-1-birenpandya@gmail.com/
>  drivers/iio/gyro/mpu3050-core.c | 166 ++++++++++++++++++--------------
>  1 file changed, 92 insertions(+), 74 deletions(-)
> 
> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> index d84e04e4b4314..9de126c3b4350 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -945,102 +945,120 @@ static irqreturn_t mpu3050_irq_thread(int irq, void *p)
>  	return IRQ_HANDLED;
>  }
>  
> -/**
> - * mpu3050_drdy_trigger_set_state() - set data ready interrupt state
> - * @trig: trigger instance
> - * @enable: true if trigger should be enabled, false to disable
> - */
> -static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
> -					  bool enable)
> +static int mpu3050_drdy_trigger_disable(struct iio_trigger *trig)
>  {
>  	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
>  	struct mpu3050 *mpu3050 = iio_priv(indio_dev);
>  	unsigned int val;
>  	int ret;
>  
> -	/* Disabling trigger: disable interrupt and return */
> -	if (!enable) {
> -		/* Disable all interrupts */
> -		ret = regmap_write(mpu3050->map,
> -				   MPU3050_INT_CFG,
> -				   0);
> -		if (ret)
> -			dev_err(mpu3050->dev, "error disabling IRQ\n");
> +	/* Disable all interrupts */
> +	ret = regmap_write(mpu3050->map, MPU3050_INT_CFG, 0);
> +	if (ret)
> +		dev_err(mpu3050->dev, "error disabling IRQ\n");

If this fails we loose the error. Just exit on each error we
are effectively in an unknown and probably dead state anyway
if only some of these work.  There are some error paths
where the only right answer is to reset the driver by
an unbind rebind.

>  
> -		/* Clear IRQ flag */
> -		ret = regmap_read(mpu3050->map, MPU3050_INT_STATUS, &val);
> -		if (ret)
> -			dev_err(mpu3050->dev, "error clearing IRQ status\n");
> +	/* Clear IRQ flag */
> +	ret = regmap_read(mpu3050->map, MPU3050_INT_STATUS, &val);
> +	if (ret)
> +		dev_err(mpu3050->dev, "error clearing IRQ status\n");
>  
> -		/* Disable all things in the FIFO and reset it */
> -		ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN, 0);
> -		if (ret)
> -			dev_err(mpu3050->dev, "error disabling FIFO\n");
> +	/* Disable all things in the FIFO and reset it */
> +	ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN, 0);
> +	if (ret)
> +		dev_err(mpu3050->dev, "error disabling FIFO\n");
>  
> -		ret = regmap_write(mpu3050->map, MPU3050_USR_CTRL,
> -				   MPU3050_USR_CTRL_FIFO_RST);
> -		if (ret)
> -			dev_err(mpu3050->dev, "error resetting FIFO\n");
> +	ret = regmap_write(mpu3050->map, MPU3050_USR_CTRL,
> +			   MPU3050_USR_CTRL_FIFO_RST);
> +	if (ret)
> +		dev_err(mpu3050->dev, "error resetting FIFO\n");
>  
> -		pm_runtime_put_autosuspend(mpu3050->dev);
> -		mpu3050->hw_irq_trigger = false;
> +	pm_runtime_put_autosuspend(mpu3050->dev);
> +	mpu3050->hw_irq_trigger = false;
>  
> -		return 0;
> -	} else {
> -		/* Else we're enabling the trigger from this point */
> -		pm_runtime_get_sync(mpu3050->dev);
> -		mpu3050->hw_irq_trigger = true;
> +	return 0;

If it failed in any way we should not be returning 0.
Sure there isn't a lot we can do to recover but this hides the problem
from upper layers of the stack.


> +}
>  
> -		/* Disable all things in the FIFO */
> -		ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN, 0);
> -		if (ret)
> -			return ret;
> +static int mpu3050_drdy_trigger_enable(struct iio_trigger *trig)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct mpu3050 *mpu3050 = iio_priv(indio_dev);
> +	unsigned int val;
> +	int ret;
>  
> -		/* Reset and enable the FIFO */
> -		ret = regmap_set_bits(mpu3050->map, MPU3050_USR_CTRL,
> -				      MPU3050_USR_CTRL_FIFO_EN |
> -				      MPU3050_USR_CTRL_FIFO_RST);
> -		if (ret)
> -			return ret;
> +	ret = pm_runtime_resume_and_get(mpu3050->dev);
> +	if (ret)
> +		return ret;

>  
> -		mpu3050->pending_fifo_footer = false;
> +	mpu3050->hw_irq_trigger = true;
Seems like an oddly early place to do this but I guess this is what
the original code did for some reason.  If you can figure that out
add a comment on why this isn't left until we know we successfully
turned the trigger on.

>  
> -		/* Turn on the FIFO for temp+X+Y+Z */
> -		ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN,
> -				   MPU3050_FIFO_EN_TEMP_OUT |
> -				   MPU3050_FIFO_EN_GYRO_XOUT |
> -				   MPU3050_FIFO_EN_GYRO_YOUT |
> -				   MPU3050_FIFO_EN_GYRO_ZOUT |
> -				   MPU3050_FIFO_EN_FOOTER);
> -		if (ret)
> -			return ret;
> +	/* Disable all things in the FIFO */
> +	ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN, 0);
> +	if (ret)
> +		goto err_put_autosuspend;
>  
> -		/* Configure the sample engine */
> -		ret = mpu3050_start_sampling(mpu3050);
> -		if (ret)
> -			return ret;
> +	/* Reset and enable the FIFO */
> +	ret = regmap_set_bits(mpu3050->map, MPU3050_USR_CTRL,
> +			      MPU3050_USR_CTRL_FIFO_EN |
> +			      MPU3050_USR_CTRL_FIFO_RST);
> +	if (ret)
> +		goto err_put_autosuspend;
>  
> -		/* Clear IRQ flag */
> -		ret = regmap_read(mpu3050->map, MPU3050_INT_STATUS, &val);
> -		if (ret)
> -			dev_err(mpu3050->dev, "error clearing IRQ status\n");
> +	mpu3050->pending_fifo_footer = false;
>  
> -		/* Give us interrupts whenever there is new data ready */
> -		val = MPU3050_INT_RAW_RDY_EN;
> +	/* Turn on the FIFO for temp+X+Y+Z */
> +	ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN,
> +			   MPU3050_FIFO_EN_TEMP_OUT |
> +			   MPU3050_FIFO_EN_GYRO_XOUT |
> +			   MPU3050_FIFO_EN_GYRO_YOUT |
> +			   MPU3050_FIFO_EN_GYRO_ZOUT |
> +			   MPU3050_FIFO_EN_FOOTER);
> +	if (ret)
> +		goto err_put_autosuspend;
>  
> -		if (mpu3050->irq_actl)
> -			val |= MPU3050_INT_ACTL;
> -		if (mpu3050->irq_latch)
> -			val |= MPU3050_INT_LATCH_EN;
> -		if (mpu3050->irq_opendrain)
> -			val |= MPU3050_INT_OPEN;
> +	/* Configure the sample engine */
> +	ret = mpu3050_start_sampling(mpu3050);
> +	if (ret)
> +		goto err_put_autosuspend;
>  
> -		ret = regmap_write(mpu3050->map, MPU3050_INT_CFG, val);
> -		if (ret)
> -			return ret;
> -	}
> +	/* Clear IRQ flag */
> +	ret = regmap_read(mpu3050->map, MPU3050_INT_STATUS, &val);
> +	if (ret)
> +		dev_err(mpu3050->dev, "error clearing IRQ status\n");
> +
> +	/* Give us interrupts whenever there is new data ready */
> +	val = MPU3050_INT_RAW_RDY_EN;
> +
> +	if (mpu3050->irq_actl)
> +		val |= MPU3050_INT_ACTL;
> +	if (mpu3050->irq_latch)
> +		val |= MPU3050_INT_LATCH_EN;
> +	if (mpu3050->irq_opendrain)
> +		val |= MPU3050_INT_OPEN;
> +
> +	ret = regmap_write(mpu3050->map, MPU3050_INT_CFG, val);
> +	if (ret)
> +		goto err_put_autosuspend;
>  
>  	return 0;
> +
> +err_put_autosuspend:
> +	pm_runtime_put_autosuspend(mpu3050->dev);
> +	mpu3050->hw_irq_trigger = false;
As above. Just move the setting of this until just above the return 0
and no need to reset it.  There might be a reason though so do
check the driver carefully for how this is used. 
> +	return ret;
> +}
> +
> +/**
> + * mpu3050_drdy_trigger_set_state() - set data ready interrupt state
> + * @trig: trigger instance
> + * @enable: true if trigger should be enabled, false to disable
> + */
> +static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
> +					  bool enable)
> +{
> +	if (enable)
> +		return mpu3050_drdy_trigger_enable(trig);
> +	else
> +		return mpu3050_drdy_trigger_disable(trig);
>  }
>  
>  static const struct iio_trigger_ops mpu3050_trigger_ops = {

