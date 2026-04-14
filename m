Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F039A189B84
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173625; cv=none; b=ncPPqY07M7xSgse58twutr7eZt46TdJSTjP1Y/g/jpNd2usJO5Dxr268HJUQTNhram3RZcXBZYbyO3Fax6lNnI/4GU/zKi0cgNtr5XRN925eNSU3Rmnt1nZIlO5fCx8le2lpX1KiSR+cOr+f6yvq2jhDvbkJ2v/JWGnyqtDsCFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173625; c=relaxed/simple;
	bh=U0thgPs3iFPY/UIGjVWHqrQHsFd8h6HWaEkLXa7Lbok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=duITluFCxkfVN8bgWDW/i87SaWBa+EtUeroEkV4rrMiieGc+vAqNMQFrHho18QqnkctR5nfJaNJT55PQLQcQxjtpF6C669bbHzbO3CNOIDsdUXTG8NQO+4p2k2o7fYCwHhrnzDBbRvR6M0AVhKvcp6HnxiqspiKnOhUPc8/MkLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=lVoJORNc; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="lVoJORNc"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-68a5e7b5b52so2305695eaf.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 06:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776173623; x=1776778423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K3sBeAdRcheJ57AeKgPv+bUh2d9hadJz8qaxyVYm8Lk=;
        b=lVoJORNcu7wBFd2vQjYzXuMSkMR5tdc6juve/CTKegvT4OmhfNLcEkWRCEwjN8PC4l
         u7S4Isfc/fTykXUk8a9dzOOJEJRJtSa9wZ1Zkvc9W4Yq9+e1ZqTk409jKso9m9AcNNEu
         igQVFyZAG2QUFHLWgPty4NpcMmFw1gQcpF80X6aDael0RIrAs/6TMBg2nh9be5Ksfvfi
         3aCSj0Wm+ULyqXL64dwJwoBxuWGwprSlfyn3p0nYh+HY/5s8nAtIVFRyWZguwtJ/RVaH
         9P6+ZWgFhBM2tDRVpAjoT+wHfbKgoyN/z4f8HX5gds7KpwnqkrxM9OiSAkJmIqYRLBsr
         H+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776173623; x=1776778423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K3sBeAdRcheJ57AeKgPv+bUh2d9hadJz8qaxyVYm8Lk=;
        b=LbZ9zrAhzERas2hmI/VuIkCLDCi6uhpQCT3EJTQEzDU5rlhIKWAHQViibkAA5U3vwt
         /chy3db22fQ/tAAnm2SzaT1D1MPAeeOvc9LgrSC1ooCC55jIs3/LqxiFBgm91P/QN8vp
         UE8EDvJNIHemkRHtnZIPfwFVKRd6f09eB1fGjvbEQtuUht6s+7GeBPfJ5lIk5PzJ98GE
         qy8WZvZMZ+eTswgiIuy0pQIID8ouzhIDKRbgH7zzRL6BrIRkOs7oExPoLr8dM45oGL4r
         ifoSbr0DD5MHBFJM89+VDAF5OYwSPIaMV3YORMSQdDFVCnpc7GRYD9ALV1dqXcxpT0Rf
         Mu7A==
X-Forwarded-Encrypted: i=1; AFNElJ+u/Xso64CqIURG8zkUuVKKDcyyeay2QrtfY/vI80pXLFJ5iN2HPWO6gnbUyVq+0DzJkEBm7Q4tWQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy596962ippmlaEUa0MiiEiSSFNLPWquoCYa0MO619Zxip/dOdc
	LJBz2b7tgDyLIIrUHJzkjstZZnuGjcuQf1wvlQHdt/cb4kocJS+5UmlV7d6xiXo/mVQ=
X-Gm-Gg: AeBDieuSVZFjDNTI0z+UaQ+Gtt+20mSntchfRMueSNMlDHxpabfnMffvTbgL2/20k78
	7SUQckxvctlpaudRBoH5SdR/79oKSfAgiazidfRt5BGX8noNUvCrL766imkLAv06XbmoHVG9AtM
	NnwXXbEX2BUtHraZ+yI0MOWLT6w/hpcb5jzq6hCu+jDf2ef4BYp2IR7QhVbaTw94Gc0//1nmJwq
	E0Q4Fp6Z37/cPlnczZb9cGl78jFnwTvV8bMaf8iC6OT2w7b42/6UhtN523iHL/Nh4pv+iiwZRqb
	0EM6EC0Ywx0x4+Fn7IQ5fe0aSQYMJz88E0CGfPczOlHDdls56dooD/JHrmhpKfR/f0VdCIj2AX1
	a6KvoUOwPbzJjIcgiWz505Pq/ECGTh0vvKy0kwth2zkTcMWDmOc1MEjWSvnIIezYgaR/KIK86Ti
	75qD1AIWEe6TbnVjgA87SJItdCQq+evByfsd/XMoSUgbTwnKAeUoacrh9i1l8eW6ylwlrZbB4IW
	A==
X-Received: by 2002:a4a:b682:0:b0:67e:3d3e:db54 with SMTP id 006d021491bc7-68a653e50d8mr7024671eaf.0.1776173622933;
        Tue, 14 Apr 2026 06:33:42 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:5bfd:a817:5527:c417? ([2600:8803:e7e4:500:5bfd:a817:5527:c417])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-423dd396960sm11509905fac.2.2026.04.14.06.33.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 06:33:42 -0700 (PDT)
Message-ID: <dbdc637c-463f-486f-91e5-f4b48af1094a@baylibre.com>
Date: Tue, 14 Apr 2026 08:33:41 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] iio: dac: mcp4821: move state initialization
 outside switch
To: Nikhil Gautam <nikhilgtr@gmail.com>, linux-iio@vger.kernel.org
Cc: jic23@kernel.org
References: <20260414092254.34883-1-nikhilgtr@gmail.com>
 <20260414092254.34883-3-nikhilgtr@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260414092254.34883-3-nikhilgtr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/26 4:22 AM, Nikhil Gautam wrote:
> Move the iio_priv() call outside the switch statement in
> mcp4821_read_raw() to avoid repeating it in multiple cases.
> 
> This is a cleanup change with no functional impact.

This is still not a "cleanup". It is preparing for the next patch.

> 
> Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
> ---
>  drivers/iio/dac/mcp4821.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/dac/mcp4821.c b/drivers/iio/dac/mcp4821.c
> index 29187f2a9d3c..102ae3718514 100644
> --- a/drivers/iio/dac/mcp4821.c
> +++ b/drivers/iio/dac/mcp4821.c
> @@ -115,11 +115,10 @@ static int mcp4821_read_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan, int *val,
>  			    int *val2, long mask)
>  {
> -	struct mcp4821_state *state;
> +	struct mcp4821_state *state = iio_priv(indio_dev);
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		state = iio_priv(indio_dev);
>  		*val = state->dac_value[chan->channel];
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:

