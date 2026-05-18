Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD6E3FCB15
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 13:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109623; cv=none; b=rrbZaa+WfLwjeMulCwNiDtdHwYXKzZlC8flZmEptK4isP57puEmDYcJLVYRjXIj3/UbxSPuPPAU4xCjI3nvhORiPs30Ow3BNzsC/tOIUO4F3jPnSnL5DEFwYT57xHTel9A7hdrYDEmt7XooJrpuILd8ZXiW6VewFsIOh2+THGW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109623; c=relaxed/simple;
	bh=Ya02RhlqEZpt7PO2wzq7RoXZ3jq5BLY2qWaxfoLcUG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bpzw0Ty7u6nRpz3nVWD9AjczBQq6wlovgMqUBEVr/Qk3MGrmJPe/BUGwfnLjmjIQC1VQksXVlq4BpiFNFVhS//YibTabIvQHw/DDUimqtdB7KB+C16Gi4zDHdDZiGVrwe/DsT80mW8Em+n9poQ5oFgJrL3ELEb4IAwZuB7zm+1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZjmHy9y; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZjmHy9y"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-393a44854d2so21539841fa.3
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 06:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779109620; x=1779714420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vUiMRRSmY+S3AmG7AOP23s7PvAi6QEqj5i/lCE5ZaFI=;
        b=SZjmHy9yKIvkTmQ4HMkgRX7Wv10JqQHA9wJi2Z6tlqVzrh1M58B0QMt4f27EArepy6
         eTqUMHA80581sUiSe4j6U7OskACtRSUA8jnvz3IFl+W/b1Wjr2ZLmoRrMv/K95v0mhJT
         MzQTkae7EBaZnT0MagNsy6mF2AhI5j5G/7KC2BelW2wmwIFVqvLqSvxC82Fzbjr2Gdgt
         cqfyb8XGMEJe23f8v/bDMbNhMDmHjUufbSL3F2kBUzjwBuj0kybWxGMu4SYXk5h4vQvu
         kBxCjv3HetS4By+3tb5FDrHxgPt9Q36Kgj0CdMmC3doBfFPX9xSXLZSMjRykee+Sjc6U
         D0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779109620; x=1779714420;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vUiMRRSmY+S3AmG7AOP23s7PvAi6QEqj5i/lCE5ZaFI=;
        b=SMNIYDAXowQRGI57lG93Wddp1T5fRFCnZP1+yzkW6YJNIVIgHM5W4p3dHuDunAxhCn
         XyY1szOWQMGaQAgRfboGlSH+0Yrt0kcfwNCtsgdWJhONnx/F5t7XmJ8neagMyvoGaVdJ
         ZhXABqg8XfLY9zLd7vqrdc+W61jJurRny8l2HJxaznFB4FsUGfG4zh1V/MR71QSRBxVi
         oV3nb74G32QdyjEjB3qgJupyuBJ/w6xG6+RoX1a4imI6s8cy6wURL+v1g+rYxhBS5SVS
         XPjaNveIbzEgG97EL+/iEPdEdieBExNU3cDOKrWrE/fpQLaSgvxGYyi2jC6bS6m2ySeY
         snCw==
X-Forwarded-Encrypted: i=1; AFNElJ8xL4Hhs5GHHpq1RW3KtRgPrj7OCGHSeunRZ7noVcZrum2w2Qo7Z2gYZrfkJtNXp94O2TWQApsBnXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGvqApxSjme+Nf74eYPxP4nN8hGLDtTL+94yJ3f85iP6Lu3ywn
	7CpR67nP7DVR8zmUxnaB9azY+S2qvwqOOF/zm5Pg1MidMW1yCsXt3fue
X-Gm-Gg: Acq92OH6BDdufAeV7KbJZZE/wRnQPqS0pMCb+bnUrxgKPww2KYRpIwwz1JgVwxhaOiY
	i96kEvmSsA7ZaIa06IWoBb8XGod0nqP74/Wqv2IWGMi0sgsoPBop1f6seqxxj/9jOSA/Ymt8NT+
	Tx+4AR6Fsf1tkH5/rHFkapc07+ZruvSKe54wLFCmOJMfLVzNrbFcD/gQg0p0rkMD9ddPnXqmUG/
	dHRPKIIKnTUDl9FZk8isNndol9m0zQNIQNT1LxZwIQX2u6GqIcYS2txvpnoQDqb/sC7KNu+bFcv
	qpflqlck/jKe3WktWe8U4ro1aFLISYdsToIoIobEQr2qxwfh98HL7SJd8Y+aGNkM0j8UN+jqGoM
	OCMu4qbBremgPfZCO1Nsh+FYO0w6ZSarEtV7OeVEjx1fZHYZv38BO4vSi+tTTcfNuX37k6DThQA
	F/lgRljm/kmrRu20EnA7xlgFHx1MYO6DHF
X-Received: by 2002:a05:651c:41d7:b0:38b:e6c7:2c4d with SMTP id 38308e7fff4ca-39561c68693mr44652781fa.12.1779109619856;
        Mon, 18 May 2026 06:06:59 -0700 (PDT)
Received: from [10.38.18.54] ([213.255.186.37])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395882c41c1sm11742241fa.12.2026.05.18.06.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 06:06:59 -0700 (PDT)
Message-ID: <02a983b5-3527-4dfe-b8b3-55b5435f1c9e@gmail.com>
Date: Mon, 18 May 2026 16:06:58 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: pressure: rohm-bm1390: notify trigger on all
 error paths
To: Stepan Ionichev <sozdayvek@gmail.com>, jic23@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260517160801.269-1-sozdayvek@gmail.com>
 <20260518094238.1986-1-sozdayvek@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260518094238.1986-1-sozdayvek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/05/2026 12:42, Stepan Ionichev wrote:
> bm1390_trigger_handler() returns from three error paths without
> calling iio_trigger_notify_done(). The success path at the end
> does, so on a single transient regmap or read failure the trigger
> use_count is never decremented, and the !atomic_read(&trig->use_count)
> guard in iio_trigger_poll_chained() drops every subsequent dispatch.
> The buffered-data flow stays wedged until the trigger is detached.
> 

I still believe the use-count should be decremented by the IIO, after it 
has called trigger handlers. (Unless there is an use-case where the 
use-count is not decremented.) Well, let's wait for a little while so 
Jonathan & others have time to comment. I have been wrong at times ;)

> Funnel all returns through a single done label that calls
> iio_trigger_notify_done() and reports the outcome via IRQ_RETVAL().
> 
> Fixes: 81ca5979b6ed ("iio: pressure: Support ROHM BU1390")
> Cc: stable@vger.kernel.org
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> ---
> v2:
> - Use a bool and IRQ_RETVAL() instead of irqreturn_t (Andy)
> 
> v1: https://lore.kernel.org/all/20260517160801.269-1-sozdayvek@gmail.com/
> 
>   drivers/iio/pressure/rohm-bm1390.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
> index 08146ca0f..81368e578 100644
> --- a/drivers/iio/pressure/rohm-bm1390.c
> +++ b/drivers/iio/pressure/rohm-bm1390.c
> @@ -626,12 +626,15 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
>   	struct iio_poll_func *pf = p;
>   	struct iio_dev *idev = pf->indio_dev;
>   	struct bm1390_data *data = iio_priv(idev);
> +	bool handled = true;

I would inverse the logic. At this point, the IRQ is _not_ handled. 
Hence I'd default this false and only toggled it to true when the IRQ is 
indeed successfully acked and data is read. That should allow you to 
touch the 'handled' only once after the initialization.

>   	int ret, status;
>   
>   	/* DRDY is acked by reading status reg */
>   	ret = regmap_read(data->regmap, BM1390_REG_STATUS, &status);
> -	if (ret || !status)
> -		return IRQ_NONE;
> +	if (ret || !status) {
> +		handled = false;
> +		goto done;
> +	}
>   
>   	dev_dbg(data->dev, "DRDY trig status 0x%x\n", status);
>   
> @@ -639,7 +642,8 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
>   		ret = bm1390_pressure_read(data, &data->buf.pressure);
>   		if (ret) {
>   			dev_warn(data->dev, "sample read failed %d\n", ret);
> -			return IRQ_NONE;
> +			handled = false;
> +			goto done;
>   		}
>   	}
>   
> @@ -648,15 +652,16 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
>   				       &data->buf.temp, sizeof(data->buf.temp));
>   		if (ret) {
>   			dev_warn(data->dev, "temp read failed %d\n", ret);
> -			return IRQ_HANDLED;
> +			goto done;
>   		}
>   	}
>   
>   	iio_push_to_buffers_with_ts(idev, &data->buf, sizeof(data->buf),
>   				    data->timestamp);
> +done:
>   	iio_trigger_notify_done(idev->trig);
>   
> -	return IRQ_HANDLED;
> +	return IRQ_RETVAL(handled);
>   }
>   
>   /* Get timestamps and wake the thread if we need to read data */


Yours,
	-- Matti

---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
