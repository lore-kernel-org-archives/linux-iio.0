Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD1D36AB43
	for <linux-iio@vger.kernel.org>; Tue,  3 Feb 2026 21:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770154042; cv=none; b=H5fpeh7WdfLcDRNt6nZVwzUSavOw1sfqE+g5uHIBsZgCK1hZIy8ZdhHjFK7J0rgz6Cp46Ayh+LjJFKDUsreFUO/XzGjd+uDzYl1IDNXvfvOSVC/QSdTihsGdrtW4lICo/qqYF4iivtLmvMq0wWfxPW+YwZhzNDIakRM7gcCZVp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770154042; c=relaxed/simple;
	bh=Mp6KLWqDJNIzivg+ATPnuuQb0xj0PaFfzng+BzjEpzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmfDRexDycYxMeUaIbqTuAk7wmn3gt4v4v+d6J8vG2ALSXhwt07TcXg6aWFkSt+RILFsYwmjX2jtM79dEH4pxlc/tQf9kiUN5u01NJ7O6Dy/UMTFhNP0eCISLpVB/t/9U3jefk9fMDGG/T0AnNxULW25MFkw6AbLxQ4d2tqkmK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IuNQZRm1; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuNQZRm1"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4806e0f6b69so44862815e9.3
        for <linux-iio@vger.kernel.org>; Tue, 03 Feb 2026 13:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770154039; x=1770758839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bm+7p7YrkIiNyY7c5t1EbZ1yEwPub4qYgyJA/T6vNqk=;
        b=IuNQZRm1u8ih8urJ4eVCXNY0BqQDEASAerdc9zbdqsRcdDiq8xp/q/LGR+H4NNi+DY
         3Atvb+ZTUH/BiuFgsn3coZ+q2jaPWTkPosYTDrTn4Y5Rg2Zq83eAIxl+yoRcerGEDzpQ
         hCfqgf5WgpfQhLC8rRaCP8bV6ErtkcFgqtDE9hGWIfrqbxjvePTc7hArVAU0gIqRk7Bk
         RtSQuAjDQNUf1VvmBQ4KBg2mOycIwW+qoH1gkAFr+qPF3odYrYhzaAO5Yoe75YCj7kSe
         C9ksAsbINDnKXHP5BcM5oMq2wqXImTkdJNnoTxggwuKcPNpaRXWLuSzh3HiygsWJuAdg
         QBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770154039; x=1770758839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bm+7p7YrkIiNyY7c5t1EbZ1yEwPub4qYgyJA/T6vNqk=;
        b=X8+4iD4OZunBMUkPPG65YKvpavDPtOttKjc3zJtilWWWRD0zQXNkoW1bne6qZFLZf5
         eIQLNtlbbN063HQGEvCw/xZgrchPd4syK5y7oL6InCKDostpzUoY6roEte60cWNm2S+q
         qxfbr3Pl43/GaG4W/xYbmk+YhfyxgIEr6HwjGVlxdPz5xgZYBGmjlIMBe7JnV8Na7Kup
         6Jd+lR28CjBpEZSmKc1AVmnJuv2GgOSunraqm8nVrRmJbm6Ig8CKD8SUUQJoFlXti3vJ
         EkHUlmyN3s3adyeZ/J7UhtiFgomnTfPSI/TjT81SGiU7iEUTJOoKaMGFUKQtic1T4gdN
         Zg7g==
X-Forwarded-Encrypted: i=1; AJvYcCUXjTerSZnUmhGgaDCvrUDhvfICn1izQDnPbZC2b67Vtsk7fz+nanpp/ayl3Ax+/PUXSR14maxBqdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoLoE+MB9zCS3r8Z2OoQogC3wSKAG6a2NK6w9005hQUIfBaHxR
	FKiTbiqy+AFIVdIH8eUzZAIhlC3yy9aIC8J2pTfFuygMfAwGVT5hjvX5
X-Gm-Gg: AZuq6aIjHwF0aEDdmmpw1EMyAK60KbUvlmBKPDUkG4In+oknNakVqN0Mn35ud8zh7XD
	KeWAk1SgBGFoPk6SybTUGvltEcfE0XD1xqGiwTAyKXW0c5nDG5AtGAmHl6IjRc6WaTaYTSq+nfq
	dITJrrq/T607aoB2KJkto0jpqqdUATtKLITbrMnuN6swyGDreyCDJKt/IDLRugqp+mf3fPYiqBs
	FmW5fIKNNePKD8CUFyP1Kga5lH6qqelZMbHrJ/snaaPq5q7sjqnZO2NOhXbUTod792J5kRZ3AVM
	lx9hCcykdfBEM/rL00CA5bgdrMHU/Iq6D3WTGCu+iTpBEUqJ9b7PB3XvfnlE0fd1OeuOxqwwnWC
	Z5eqZ8KaJq5Xp5JKKXiSeFj0QMnxyR1xnPBTz1mNZwL2e2QUCCoTif2FpI0LaGB5PxawewICIyX
	FaSMYTCd1K66BFg2bBLqJr
X-Received: by 2002:a05:600c:1f16:b0:480:5678:1fdd with SMTP id 5b1f17b1804b1-4830e94c923mr13628375e9.12.1770154038912;
        Tue, 03 Feb 2026 13:27:18 -0800 (PST)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:3ecc:4803:755d:9b16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830511ccd0sm78225455e9.1.2026.02.03.13.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 13:27:18 -0800 (PST)
Date: Tue, 3 Feb 2026 22:27:16 +0100
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: Chris Spencer <spencercw@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: bme680: Fix measurement wait duration
 calculation
Message-ID: <aYJoNO1SffHnsSxV@vamoirid-laptop>
References: <20260202073843.11225-1-spencercw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202073843.11225-1-spencercw@gmail.com>

On Mon, Feb 02, 2026 at 07:38:42AM +0000, Chris Spencer wrote:
> This function refers to the Bosch BME680 API as the source of the
> calculation, but one of the constants does not match the Bosch
> implementation. This appears to be a simple transposition of two digits,
> resulting in a wait time that is too short. This can cause the following
> 'device measurement cycle incomplete' check to occasionally fail.
> 

Hi Chris,

This is a good catch! I didn't have problems with measurements in the
past but that is also because of the entropy of the sensor plus there
were some series with "buggy" sensors that were behaving a bit
differently. In any case, thanks for finding this!

Here is my tag, in case it is of any worth:

Acked-by: Vasileios Amoiridis <vassilisamir@gmail.com>

Cheers,
Vasilis

> Fixes: 4241665e6ea0 ("iio: chemical: bme680: Fix sensor data read operation")
> Link: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L521
> Signed-off-by: Chris Spencer <spencercw@gmail.com>
> ---
>  drivers/iio/chemical/bme680_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> index 70f81c4a96ba..24e0b59e2fdf 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c
> @@ -613,7 +613,7 @@ static int bme680_wait_for_eoc(struct bme680_data *data)
>  	 * + heater duration
>  	 */
>  	int wait_eoc_us = ((data->oversampling_temp + data->oversampling_press +
> -			   data->oversampling_humid) * 1936) + (477 * 4) +
> +			   data->oversampling_humid) * 1963) + (477 * 4) +
>  			   (477 * 5) + 1000 + (data->heater_dur * 1000);
>  
>  	fsleep(wait_eoc_us);
> -- 
> 2.43.0
> 
