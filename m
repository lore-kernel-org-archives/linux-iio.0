Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12548368D4E
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 08:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778659685; cv=pass; b=c0B5wN98PyY+uRfCmuz51pdvPukS97Afmk4NQqQS+grA1CUi90Mz5TCf6p/CZy9cAVpaCJ9UGasg1c4cOUYhCHQYK7Ear/MawTIWWpJv5yEqExL6DD7SFxgFCzp3Wqa5SZMrjEua+glCeKSeVUJRRBHvB5vImSPjTXRiHla0UUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778659685; c=relaxed/simple;
	bh=o5OHLJcOxC7Fnsmq4GqMfsK7bdTelOza+cD1NXwktmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oAqJxNNFkB+conPIAnHVjXst2iimavOwm4Mp6Jj0rv0KRgpyCNaYskG9+7GKF7vBbhH/2RixVX7hJQ+DfC3QqCWfcgy8U4jnPvGE3NHCkO04Txglx0h0h5cK+bxfgVAV95mlgSuNB9aMyAdKVD6oQUTZK7VrkzvlB4pSA45EcF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5VKF50I; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5VKF50I"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so62243935e9.2
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 01:08:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778659682; cv=none;
        d=google.com; s=arc-20240605;
        b=F/mtSY/uQWaid5fd0KAOI5JQOIkon+Eeo1ivn39HPxZNfP41LjtE1XkOJ8NWr3lG0E
         pEuXVmCqMzBrCl0vzH2noTjs5Y27ox0qb/AHwRixZUWyJg8om40z2o2A0z3sswudRrOb
         /ysKlNdrnJiltfjHAGoHlfTAdDlGSNAp8TiUaE/DA54D91SMsakgh+IADvgh7y8/I43i
         4BGML+jZsg45kzJMx7THDtYplluh80xZ+/X5BO6GrSb1IjMdIbEbMog8zOF7r1TQoFQJ
         b/yQlqrnqy51zrv1gUNKd3UJfROGOOmdWrgLpcChYvtVMITCS6vNRqfR04lBHaQ2D8II
         gtTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HUj67/5/NXFLHIIXZ/GvpTp6xgEkKvOgSGVkKjkoapI=;
        fh=GXt3cBBlUAE7gFEDYzxlmmsXVqKu+zT+FinSAGjhl78=;
        b=GFi4L+6OTutqf1zG+zZG4dElMezfSw5emxEv1op//YN2rfZsUXTmR0v9urWnLhhyC3
         dfNe9Hi0eQ8vWl9riMEWMbnr/chwFFns01tFNul4E0h0YM8W6wd5LKIufNOdPYfuDScZ
         gOYApP0xIxg5js1GG4fdOnJWaWlV2dELdocC7lmp8b9/v+kyBrkFcJwSLDPWvhyDE9P7
         71PU0x6sSc8FRy0ch+Th2EG0hBYltrLD8U4vff4OFDPNAQlkaFHiQCYalp7lgZiHkbmh
         NRx/Z5cUK9SvwPUVuSNShuaH/yHxGu9GbecHChg8uehn2HQLIACOJT7/AnDJprI0aJlQ
         H9Gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778659682; x=1779264482; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HUj67/5/NXFLHIIXZ/GvpTp6xgEkKvOgSGVkKjkoapI=;
        b=G5VKF50IHjHV3f7ZEjSwDT9Srsh6isFMp0fjew0IMANdM+/xVVsxM5PCR1Y0E9oJsn
         uaZ0EDeqdbtcbdaETqc0rkLWGpnR6IaaSZqMRih0Arl17ao7M43PZkxQZ70tDgabGAGO
         7h6MAE5uI9xoOd9uTCmJQg3f7ZSmqG81OY6i+RwQsOJRCGGC2QCdOikUhlDD5/3kBXRB
         M6e7pXUvUYl5CnJy8MhkHvifJxZIzEZycMIxkWgKcRPVL0fmqwtPN3AKkQYdbN7i1vEK
         NdwpjLi2GmNyVKsTksB3+ZZfS84k3I0qEzqKRIUJePHK6ppdNgxECXSsjojImNXduunH
         JatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778659682; x=1779264482;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUj67/5/NXFLHIIXZ/GvpTp6xgEkKvOgSGVkKjkoapI=;
        b=XxBSUVWJpPFjrObvDqK2ubzLTZiXlpxCuHnLCPRlgHuzs4qrHNUsMKmXrMviwZxjw4
         h3HEGlDwf9L8oyQhjirNwOqUVH51vc0LXEf29V43UaAc8Zh8iQM0iX8HLexwvSYKeJYG
         a74K52B/bJjCRnVdzrsKKdXSH9scGo7TXovjtssDaZ00PzdOvDXRSr77KmYJrBIdtO3n
         +5C+ZB5AnN3h56FWvYSvbxQyNu76UEAQXUdaavIJSE3RAN55j+LaytE49nijnZt3mFuT
         f/iQO/Vk+Jk0T97YF2WP16ZRYBGYKUZUCJ7cxZIceLbDeOWb9xRZxyDtbzCtS+dTEMOS
         9fQw==
X-Forwarded-Encrypted: i=1; AFNElJ+pxxq1y0Cxf9a+1h4fLDZ15ovS9+4BrH2qCJu8Y9aGjrvLoIhcdBNRc/CLzVD4kugcf46aeO/i76A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdMWksLY/lUdZ1dmKdkpb9/fXuambfJLnlj+mc/ndPfK3lDSaD
	nI8hgEpuT4fgYcEeygOTt6NJ8LerLCa6Ju7uqcAA8SjP4wYh9FW+kaQXr5BNS3NKg6WRwkUX+HG
	A16q21W31TzZjKA4/Kgx4YXkUmwzn/HU=
X-Gm-Gg: Acq92OGCweI5UQ35/gpUyR5N/j/iFXipcbxfmroKtGBXcT4cU6V30/jeT7bUbnJCWKs
	9CBrd2O0yuUHeuWgyLetHKvoiw0ouIpwWwhHDB80pvHRCoDiWumUPHcgmDDowec4BwIBSoo0OQP
	VHSx72pqTHOAOtifmAnh0etIunaS+XTDFYJjFg5ZTzVkQ5YOi+QIdduu257zKbeU+YERSmqeUBF
	8biTq8lJAXm9oJ6NddqzgwbtbcvQzXxKWlqrEQ3a6EqOUBFD4jsWX/UGIkJT0DGS6eoyow9viL8
	pynx1k3il+PQ3bh2ccA/tMxTluckpPdPsBuFLp4rAjc3JqrpUXd1VtBZRInXhR+4CWpdu+h36LI
	RV6Re/DdSJstsYO7ffira0sIOCYKN1LJn4gtudJGf3H3voXdQlJSRBN8i45g2LcwwSUusbACXxQ
	+0CB3MfA==
X-Received: by 2002:a05:600c:44c7:b0:48f:d2fc:d042 with SMTP id
 5b1f17b1804b1-48fd2fcd1fcmr1702915e9.13.1778659682565; Wed, 13 May 2026
 01:08:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512223215.25596-1-aldocontelk@gmail.com> <20260512223215.25596-4-aldocontelk@gmail.com>
In-Reply-To: <20260512223215.25596-4-aldocontelk@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 13 May 2026 10:07:51 +0200
X-Gm-Features: AVHnY4JIZlyHMUEtu8JAG8Og1-Jhw8uH7BQkFJ-WmDJC-mCDgjabVWeU1G_IkCE
Message-ID: <CALoEA-xdQJPR35WAtsU+4Wd1O=a=1Yg0GSYDOHRLRKLY2XcS1A@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] iio: light: tcs3472: use devm for resource management
To: Aldo Conte <aldocontelk@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 May 2026 at 00:40, Aldo Conte <aldocontelk@gmail.com> wrote:
>  static int tcs3472_probe(struct i2c_client *client)
>  {
> +       struct device *dev = &client->dev;
>         struct tcs3472_data *data;
>         struct iio_dev *indio_dev;
>         int ret;
>
> -       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +       indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>         if (indio_dev == NULL)

Not introduced by this patch, but `if (!indio_dev)` is better if you're checking
for NULL (checkpatch.pl would probably mention it during a run).

Since you're moving the driver to use devm_* functions, might I suggest
moving mutex_init() to devm_mutex_init() in the probe() function? Something
along the lines of the following:

ret = devm_mutex_int(dev, &data->lock);
if (ret)
         return ret;

-- 
Kind regards

CJD
