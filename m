Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792747010;
	b=RiuNlFUSG3JLOGnSXTKIhqTB3s0g493LGDXyJRNJ/7IjNJQTUAdtc0+ASzI0MG2lTegp
	 ZoEf/+UjARQyN9zPTGkd9a7z0tX5F9M4tNu5YL3nwLaJRENkYsAQmwYEmK4s7HSWb+V6f
	 KlgWYjgqSQNUsGf+3Gizheh/ibLkyfdwRC+MVwMDOMZCC1I0kvgEtCRpdX1BCiiL/TqHk
	 wt1qHSIObD+j7LBkDSnD/DtXmv6rVHvMPkB7zOgEYBOsZ87XXud8ufaBvscCMyaUBBRLG
	 hTmES9OoPGDvL6OUEyriRNzUS23qh8fVDZqczJgjVRZe3BbFfpPrTRVH7nKiHs6jBdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792747010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7QbAvKZlHDd3AEbAYJ/zukbrl6OsuWTPpYdirZ5iLSM=;
	b=XxcW9SZAN9rD8h4NxC4tk+INDIFaJtADfgiH5z7konzvS9wbM9GFVXHp69OH+vU0h07k
	 O1qsGmFBBigcvFupRj4/h6ycLwhtwEkmrM2iR97ofIzm8nTPeUODgyaaFU/G1lwbTxSSt
	 fPx67pZbS6i0+pWyyx/WJMz3QKhzpHmxfvfFOu9DUDOEKw3K0mNex8UsQLUwTOpkjS4UD
	 0PPFJhrMCddRZoydq0Gne+HqZfvSpL66xUMjgfBafgveDNnAugORelPDhAzFbpRPtjh2t
	 58afIuVSm/aERmIrTL0+9v7BLUCGrkTorMCk4NAsGMZK5k4pOT+87dsTvmQgWTlk/5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mW+avd+h;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FD7606A320
	for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 09:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5FD7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mW+avd+h
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a210470b49so5196185e9.2
        for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 02:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792747008; x=1793351808; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7QbAvKZlHDd3AEbAYJ/zukbrl6OsuWTPpYdirZ5iLSM=;
        b=mW+avd+hjO8+1Rstd5HMROdiarYwWClCmO+5Kd4xM5ZoI3CKxiuXaywpfuOj6Os9S8
         groA2rZBSGzxCF4MYRQGf80pez30iNfMrhBRjFZTb08jpPeOqxcJfBnVLD4+KPmHrbwS
         kOm2rvFEl23NAbCROpt/y3G8MTyHGaXeV8yskvIvmEwxVp2O3TVbH5Ft/zecFQQc4SJT
         khNsF0eriWubmgTIwxXYAv58AR5f7oWNaonNlCrTIrfLZMMqz6SHEtnFIv4GKV6w+PVz
         AD7rxCI7/kxEigsMZvlFq0Fxn4dRFZR6+79WXXMCe5HU4rY/L9SWZBQ1T7nZTjAG5J85
         hz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792747008; x=1793351808;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7QbAvKZlHDd3AEbAYJ/zukbrl6OsuWTPpYdirZ5iLSM=;
        b=yuNDULNcPLnMtmQku94QO4EqDsSO0rd+tk04reDyhf0QHypE2dIovW0Y9VwU6psfvp
         2YUIMZ6EPyf6tFwh/FHsrqLai0Y6LOgjpVvlE3oQA8H2msjHcRcRQNV2YQMwdN4yShV0
         joT6OBeGjI9yWRrKHv7cg0xu4HPKCpJYzLVWvo3qOYFwQIL8/0dgfiyyC9yg3DUGup7G
         CysOYzHqBnjv3DfbF23KSI/SbpG1noQGISPbiXLtyEE0w0lN2iPvNZOXyJQlA1SqlVnG
         lmaof9yvvwWIJb5dIRUwmAG7adWjfLcxBwwOYHkGwCrac7t3krhpYZlLArL8te6q3Osn
         f6nw==
X-Forwarded-Encrypted: i=1; AKwUvBzzxI3oKGmaWExvRf3hkdsvQO/KSVhq4v/YOkfHQDar/efoMul+v8zUmQSKDKORk/ONm9NmtxcMGcg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLLyR3fEuayoAs44B/F7wFcJh/Q+khtyCzVm1l9+pktUaOxOU/L
	Y/8+uiIWYl89uP8rHPFtzIOte3ozXpR60ahA2Ejf1CIz24aLf3TfHu4T
X-Gm-Gg: AYBFou034TOk6o9ObiVf057oJm3JTrxycK52gQhDf3GBsGoX9HqeJ16WeUuYzSFRAdu
	lEO0qjItZ55RiSz7wzo9PHldWcrygo3wzoYXvRqeAoxp0w9qnSlZ2D/gBPm8G72y5H4SzK4yBAE
	OdldE3PpRmw21viZ0lqTA+CQKtuPc8dwtxlNi45GLNc+OuL45V6t4Ykavu/6yanMfVo2f73krWg
	ZPySsCuQvG5fcoZpYhXMLC1DWvflcQx0Y0eG0mLZDtFPw/UxXeXsZGY1Grus977goHRVxPe2SCq
	LNV8tUtFSytYZl7fAOISi1m5CtM+WyEPqIA+kqykKiBye92LEIUGSpKijSo590mFV0tIBxW9wDV
	dNXseFrodNa6hkEYAB+UddpVPoZcQJd7tJY5ZG4rYdjgu2x0UrioPd8b2nDuyj+vuy01jbOWWvb
	LRhh06lJj34u/PtIhbCZZwa1+HWM0gMN+1mRC3to/57WzNr0sq4o2yovIdVW/cHS/m30QEcCW8a
	6RHF9GxssXT32DsF8MJufxIwSn1+w7J8+8pcwkU+WDMV16ggYXSVPhbDLlFQHWvc0wo3Uw8jW4I
	wzICTWokX7kqTZT+aCM9R6dOGjLPM7TYZnItSfNDQcEFnRvGB7jdPiFODXlTlzuyJszWOVg0j1h
	yxr/zklVePb4ZBAjslp8kAw7ZgT9lt+Oo0EM1irDWNSDcziRnyzJT6fL6kNjzXigJF3RTWzihe5
	jQh+L/6u5mNJAtMWQOs/jRHLTjd2dcErCz5+8fo1+5Q9i2U4kjv6QaHdQfrG0uDQ==
X-Received: by 2002:a05:600c:c11c:b0:4a2:167a:c93b with SMTP id 5b1f17b1804b1-4a2167acde3mr10151235e9.30.1792747008186;
        Fri, 23 Oct 2026 02:16:48 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a211ba3ab5sm55235845e9.7.2026.10.23.02.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 02:16:48 -0700 (PDT)
Date: Fri, 23 Oct 2026 11:16:43 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Jesper X Nilsson <jesper.x.nilsson@axis.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Stefan Windfeldt-Prytz"
 <stefan.windfeldt-prytz@axis.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel@axis.com>
Subject: Re: [PATCH 2/3] iio: light: opt4001: refactor driver to prepare to
 support more devices
Message-ID: <20261023111643.00007823@gmail.com>
In-Reply-To: <20261023111032.0000019b@gmail.com>
References: <20261023-opt4041-v1-0-45227f82d05c@axis.com>
	<20261023-opt4041-v1-2-45227f82d05c@axis.com>
	<20261023111032.0000019b@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Oct 2026 11:10:32 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Fri, 23 Oct 2026 09:48:14 +0200
> Jesper X Nilsson <jesper.x.nilsson@axis.com> wrote:
> 
> > Prepare opt4001 driver to be able to support OPT4041. Extend struct
> > opt4001_chip_info with fields channels and device_id because OPT4041 has
> > two channels and another device id.
> > 
> > Datasheet: https://www.ti.com/lit/gpn/opt4041
> > Assisted-by: LLM  
> 
> This tag has been deprecated.
> 
> > Signed-off-by: Jesper X Nilsson <jesper.x.nilsson@axis.com>  
> 
> ...
> 
> > @@ -388,19 +411,19 @@ static int opt4001_probe(struct i2c_client *client)
> >  		return dev_err_probe(&client->dev, ret,
> >  				     "failed to reinit regmap cache\n");
> >  
> > +	chip->chip_info = i2c_get_match_data(client);  
> 
> + null check and return -ENODATA on failure.
> 

Just noticed that Andy was faster :)

-- 
Kind regards,
Joshua Crofts
