Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114292F3C3E
	for <linux-iio@vger.kernel.org>; Fri,  1 May 2026 14:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777646327; cv=pass; b=H/NXPyzUZ7j7jFAx8xFs1M2EYTRLSvBkDHJXpPvP4QTS1a9NHW7ey6RxCFjdecEFI9wZBfrcEOJ+ReevDNbB3XKQYwxqICizcJAPSiUIDjCBO/9/Kb6PLcWyN6LSNkEOpBSS4dOuXB2qEBIq2QyLeT1Rji3j48Gvxw+fXCWauyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777646327; c=relaxed/simple;
	bh=53PrtfoOQidvG09KqHiGVUgsw2/kfdjmDCQtxgDwqfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPHyi7iuqfpbfxjsQx8N/JXMMYOla/t00We0sME5sbAItYB5+GcNYFDrxlDdc9m2ABAYRT0TcUg82KCei3OZT0ps8oQboYUPVvjqqRuv30WuRKI1D8G/jWmDzsGnFotzCBm158rfHfi5yQG0oBClufN3Y7q6eiIrTkPQPu6G4jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pvWmVu9p; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pvWmVu9p"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-44b052142e1so257000f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 01 May 2026 07:38:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777646324; cv=none;
        d=google.com; s=arc-20240605;
        b=fHA+8fbUvfRuqsnVOVG/BuV6bQMa4yFsPr6tDN+bcUCjIJ8+j6JsLTngKss2nEgb8I
         nOXZB+0hZWtcEPyblzhTa+QTzl4l+scTh/HiqQnU04O/OSqYbmEnvcNuDxdHZB6qihR/
         pfI4XSNLwjvDJHEkFY5omeC/drb/itgAZSjIq321BzNl/SmnxSpBfLsc2kfw/MZhaszS
         5nbNY8+4p/UuzQS2i6vBeA1+7rXqzdULMwvWAiUaw55ZyMGK3aPbRfHA3RsN31Hx0PNw
         7fbOMDkMqtjmn67fandux4TOdifh0jiNMaMXy4Zuc90DZnuIRyOsJyHrMtJSb/kkMPB/
         8CvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EoAye/WZ7pkac+ZFcr9ApmVsBKGzKOHkAnJF7hOFJOE=;
        fh=CPti4s/SfqTHh5XGARxsX8fEUhGnIY2rIMVM5Dr10Pw=;
        b=TPuRmJSIZualflguWBRUaQrS7MyarHs7pPBYY5UcScHKYpdJT+0iJsgV8gd9ZxZO7b
         LK/fNPf9jKax+aRSSFoPKF7d5+O4SEb1BvT/FKf73kbe+PqhzVqXD4O/RKwGo+3hpRCa
         fXGJkYIYoabznZEgGBR3JaFa2G3tjwNZnom0XoOj1emkNBkD9Jj0egjgnJT1bVxL93fK
         LQm11lqCoH20ZNmPuCuCpaP7sPXkozODgq7pdD3QO9ScxSRnBLd/v/U1FP0hweANX84F
         iYTZz6IWXLKXsH8tDeirn84GpG1V91um8XiQhBBrFKNqUJMSRbQ2hML2xtMoDOOOjrA3
         eYeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777646324; x=1778251124; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EoAye/WZ7pkac+ZFcr9ApmVsBKGzKOHkAnJF7hOFJOE=;
        b=pvWmVu9pLw4/TeU1+azs68acy9QZI06meLrzBoXnmimYHnZ42hMV1If9Z5Tw7FMJ/y
         dYDUcucDfTHGeX5k87lTvNILEXmMZ4zkQXCOLsPj1cCGq9NasdMU91aZ1rx/wP+Wh6fP
         KFb9KdbPfTMQbBWBO4Xk2OXanObdfBPU87bLEY5AKqJGOJ6ki6O2wD/YYtilqveRDwgf
         lN3Au+84+3ZU35WQ26dYM2WlS2HrgEOZTfolrfSDEit1GQzkKab7J/3ufMu6mYQcMfKU
         lCDVHm8dO/XR3yuk7QukV9wtL9l55HeKjcl7gx9f+1DaLD2M/Jbh6t6K4IN68aZQM8ti
         GSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777646324; x=1778251124;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoAye/WZ7pkac+ZFcr9ApmVsBKGzKOHkAnJF7hOFJOE=;
        b=VEZfxdS39c0syyfS1Kt3VdGcodMnLtViITdgDCn1sKSTZgvZMoMJfdrzh2wW/uRPSX
         Ou2eNdntBK+eNAvZP7aJZSCqpM5dMxzIFBcSMbZbmiSBz49sQEG5/dKUPpz7dPAYO6iZ
         gmeLYQbRF6Fl5FrUlOxT7n2pKhjKWdX8s/nHgh18kblyIWg3b6tKxDtT1o//gVq5Wkhn
         yzowavkI6142MBTWOl801xPCDKskIhHB7iEf2YZ7wGvsmXY6aN3Cf2ycGLCwqJtZdDNP
         FPAXKaoKDul8JOXzTffyTSte2yxNV8RyBHNwYOt4lMk3opWr2M5XtzWXQERO1sCpov8S
         N9sw==
X-Forwarded-Encrypted: i=1; AFNElJ+iqzd9OV8p1oAkaBiuXIrPnSJWpk2YkD+Bq4F6E4CcKfvTQ+RbP8B2lNVHTDWFjflTs5ilseX//kk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw75X3BZh/7DkhmSr31HcRD6zvyOTRjAAs5U7xZj99gAZlBnksC
	15dpLc6BfjztNs4iMxn2CRNEgBiMGTNzAQKP8IZhbi76FQOACvntnkl47JxCDTP4bIuwCfwLHtu
	PTdElirORjM13Rrgdi+X636x1AJbFM7E=
X-Gm-Gg: AeBDieuACUcxv+/bQno+yKA8tkGfdoFCrU1wv0/a5BXXUWcHri+4eXUkvdgaAuMCtq4
	FOLX976mYcqHxfRNVkJZS+OBGgyjPEhZ+YGtE0XS5FRrDY+cK4f+08rgzK1F5cf2GAfcTimMh48
	0xvfSItPb/7nsEgpalowG1wRTHrFWGzCajIkDisewaWBr9rG1Nv+baM88OMj+5w0aSJZdRpfqmo
	9iGTZ3R9DfwJ3Z1y77+ms4k2gXUSSA9lavNw13/xV8VduzeQU035KfxSPLKPJIlQibgvV95TXpV
	Ygs9cIPBhm0kTnvFCvk8QPeW9PgosGU1IJQAD/3ttlJCJEo5WmNtl+Z0Q6z+vYW++S0zkA34W63
	LRKY8GutyKWiLWjIDkqrvRyFqB+YoVq20mShPwZJeM/RonouBQD55lGIBiXbFmA8iB8SfLBp9Vu
	4oUF2p2T50NvS8C60S7XrOx1vMugwTXqqHtZGUwzBYXup4ybsvEA==
X-Received: by 2002:a05:6000:22c4:b0:441:1c18:f779 with SMTP id
 ffacd0b85a97d-44a88be96f3mr5479293f8f.37.1777646324349; Fri, 01 May 2026
 07:38:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501011548.15369-1-santanarl@usp.br> <CALoEA-wzsykL5V675HFYNn-xZpuCa+XEOa-LbJ0KqrVSR=ZUnA@mail.gmail.com>
In-Reply-To: <CALoEA-wzsykL5V675HFYNn-xZpuCa+XEOa-LbJ0KqrVSR=ZUnA@mail.gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 1 May 2026 16:38:33 +0200
X-Gm-Features: AVHnY4Jap6NdILF5CqHyzlWQjWo3KIXxElvTjlfjCQ6iIsyZtrIGCfC0XNIP9RI
Message-ID: <CALoEA-ycuys-pNg_HWZVrkoiAXVToWouS5LV0GX1UsWz5G_Mvw@mail.gmail.com>
Subject: Re: [PATCH] Replace manual bitfield manipulations with field_get
To: Rafael Lopes Santana <santanarl@usp.br>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 May 2026 at 16:34, Joshua Crofts <joshua.crofts1@gmail.com> wrote:
>
> On Fri, 1 May 2026 at 03:17, Rafael Lopes Santana <santanarl@usp.br> wrote:
> >
> > From: Rafael Lopes Santana <santanarl@usp.br>
> >
> > Signed-off-by: Rafael Lopes Santana <santanarl@usp.br>
>
> To expand on Andy's review:
> 1. fix the title of the patch - you must add the subsystem + driver
> that you're contributing to (in your case "iio: proximity: aw96103:
> replace manual bitfield manipulations with field_get").
> 2. you're missing the body of the patch message - do not send
> patches without a description of the changes you're trying to make.
> You should describe what you're doing, how you're doing it and what
> difference will the patch make in the future.
> 3. the macro used is FIELD_GET(), therefore all mentions of it in the
> title or message body should be the same (no field_get in the title).
> It's also preferred to add parentheses to the macro name to imply
> that it takes a parameter (in this case, FIELD_GET() does take a
> parameter).

I made a mistake - you're using field_get() (since you're not passing
compile-time constants), so lower case is fine. However, adding
parentheses is still the norm.

-- 
Kind regards

CJD
