Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281B33DEFE1
	for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776090828; cv=none; b=ONN+R5fnVfMo+s35y1fDfLs/DThZ4sTlBvrQoGOH0BCCP/2ksiHYcvrrpLreOH9g7y2vZfy2SP0Lw3+3dzjTMAZufEIX+wRFqlUgii9pn3rR9xxv7yK0Z8spoDDzO8vPyWlf+5/70A6IKcOB50rT/I8COpjHsJdUv7PssBNG8/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776090828; c=relaxed/simple;
	bh=cANz3M5iEMRrvUFZhUDiPtpFJrTvNJBMKSqXbbaMbNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RIIO4X6fkTy+C2gFvois4fXEQa6fVSGyuZydWM/fc+owu4gubKbaX24M5whOuJQ6nOIOWSLvAfW5orq8lOepDLqB7GkM6yrUT8KaaNMjblJI68nMdrjMVCOSA/PU+pPqLlwBhFWXGM6G9Z+9oEjmvuxFzSk5s98EsOxb8jIyxOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=kCrVcP2n; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="kCrVcP2n"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7dc3d28e2f3so1732922a34.0
        for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 07:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776090826; x=1776695626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mq4QA12GQ8dCgHErbS9z6LmOLAtV+V22dkeL3y/gRsc=;
        b=kCrVcP2nxG26Y7AHeC5/6Tsm0Bc0oQRXrTPQiYDgrD8PXkcHNFIUtyFnXmBcM5P6qP
         SwaNJ+3f/7bQnPVbiyLWv2McD1NBNhtGUnw71KB1IksC4XvbrTKO5/vppvHnSA5ULsHt
         TtxE9VLz+JDmF7cBSKabpNJEK/pzIrQ6tvUFpQRYmrYIZNPDjSp2y6jXZhiwC/fTBKO1
         cMBvnHOtvJrjs8QPxwFDddQlh/2jr+Qlno74LSwxZAk93i/HIo9FBN1PPFNLm8YqsMMQ
         s4UxCHmaeMAVY3dR9hcoRs6zIj0cxCJVgcCsmUpIppuWxZi6xaKkwgJtDSHkITTp57u9
         V5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776090826; x=1776695626;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mq4QA12GQ8dCgHErbS9z6LmOLAtV+V22dkeL3y/gRsc=;
        b=oa8ygZzhytjc5TJX8JHvP5Z8tnae4wo9jS/qXnB0AJiw/PIeAeOFJum/Dv4WETbiPN
         UfItvHkUV4BrAc/JYVEo+jJmwDDGIErPsjkMS1uPnhjoxdsk04y1ic0BZRzO+P/wqcll
         RBfkxHRW0prA1yutBJXyMo32JbN55z1YmH8RIIbB3nALo3EIN/EKBU67a/OsA6yZL0NJ
         23Cs2JSj2uhD13ycyFbPKVgIQmOMQW5vV1R6lf4bX96EevZ42QDLSW9NUM/c3w0q9eTr
         poz550VZ9iQvFe/Xr5HbPLwWXFSCTC2IgRZUwWKpCb27cUuKbejSo1xkUGrMdsBGyHWN
         gXkQ==
X-Forwarded-Encrypted: i=1; AFNElJ98C4XiUJhLCgKZ1Hcvtal48f1tCcnTz8fDOTtOpq/B/6B4dxEWApDfnou8i1wiAg1EQ6H/1BO50oA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/PuHfz2Lqrs9oknj4CBL4pf4xhBoaFxFgu2XOMF5CNRebemqQ
	hSJpoTaOpztPNhC/9ZksprMRRtFjdq2tpS/Tvbie+VtUYWhJQrfzp+YcHjv6Y4CSk0I=
X-Gm-Gg: AeBDiesGB27S2SBzbaVqDxjt9VAdIa0sCXheY0cEeTVCj604nOs40gWEa1fk0DhwwnH
	AwyI1zjCuKMzlWGq7iy+AlU9n0vjrEJDEt5RHHZGAco85yq87b5H4rzDQ9ufcyaekucvPCodXbj
	LN4123faYvEmaODirkno8XkJIvUA4GfrzbapQ2sqm6AJNrFcOZzTIaV7aNyjLxClhzeIFbXYhSd
	yirpN2cPlOKxEzn55jExeVVXNR6bp7CtOYbsKbfQbjUe5RX+p4F4ETO7/gaO67JJV+RsMhENKm7
	2TnDMQAJriupRETYUNKeF/cd8bBt/N+WS9dhCtVNeuMUwyNGoxVOeWKM3pYBdrLgZfEQc9qLrlY
	f2xvxHrpoYL0gR9qPJGCdqem2/ejdQaDied6KlrxLWXRMDWkSN0D3Pr1eHMcq3/MqRFLjM84isp
	N0DKCUA2Z5ckIlq0JhndcK6+xEmHjRf42IOCMFTIxWwz1YMtXa+xOROyM3dFzXs5/zSHcMk6c=
X-Received: by 2002:a4a:e905:0:b0:685:3561:8923 with SMTP id 006d021491bc7-68be7ee230emr7103058eaf.38.1776090826095;
        Mon, 13 Apr 2026 07:33:46 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:1963:d48d:f7b2:862? ([2600:8803:e7e4:500:1963:d48d:f7b2:862])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-68bc7dfd5f1sm5577516eaf.1.2026.04.13.07.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 07:33:45 -0700 (PDT)
Message-ID: <77697480-8ac3-4d63-a23e-b3be28dac7c4@baylibre.com>
Date: Mon, 13 Apr 2026 09:33:44 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] iio: dac: mcp4821: move state initialization
 outside switch
To: Nikhil Gautam <nikhilgtr@gmail.com>, linux-iio@vger.kernel.org
Cc: jic23@kernel.org
References: <20260413094449.18837-1-nikhilgtr@gmail.com>
 <20260413094449.18837-3-nikhilgtr@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260413094449.18837-3-nikhilgtr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/13/26 4:44 AM, Nikhil Gautam wrote:
> Move the iio_priv() call outside the switch statement in
> mcp4821_read_raw() to avoid repeating it in multiple cases.
> 
> This is a cleanup change with no functional impact.

It isn't a cleanup, it is preparing for the next patch.

> 
> Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
> ---
>  drivers/iio/dac/mcp4821.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/mcp4821.c b/drivers/iio/dac/mcp4821.c
> index 29187f2a9d3c..6b732db1cf49 100644
> --- a/drivers/iio/dac/mcp4821.c
> +++ b/drivers/iio/dac/mcp4821.c
> @@ -116,10 +116,10 @@ static int mcp4821_read_raw(struct iio_dev *indio_dev,
>  			    int *val2, long mask)
>  {
>  	struct mcp4821_state *state;
> +	state = iio_priv(indio_dev);

This should just be one line.

  	struct mcp4821_state *state = iio_priv(indio_dev);

>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		state = iio_priv(indio_dev);
>  		*val = state->dac_value[chan->channel];
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:

