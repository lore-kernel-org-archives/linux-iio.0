Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCF945A2A9
	for <linux-iio@vger.kernel.org>; Wed,  5 Aug 2026 12:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932485; cv=pass; b=ElYGcI0v4EFXUNVZWKwb9WNOHIsUmTyOQmi/zRi2rB6/VnJGhi70mVmRmg3AgYzttyPiDefYpkJM5GocbZc67sbFhY0fVCcdJvLF+2bNDG8mPzV8iT0ZTYlIrwlQplKwtT0Faaqd+6GXCpH0e9W/n60yMmcCeAWP1iIUBORlkfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932485; c=relaxed/simple;
	bh=if64cjS4p31TD57G6MH6rJ/WMnsRmXxyelTmiS8nHm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=agPFjOWrA73IXcKkUQ0On7igclha9EMvQnpelNVaSBaSBk5ijwtPid0M+8ALH3qgCN486asfBVX6Wqos3j4gSSJ0KEHHohyHeSy+FgDrmAGWw73oULWg+cuMAXyicCMFAkNISKLkvSH/EYQzLU325Cs+hbghMh8VH5FTuLDykTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9uUFdoT; arc=pass smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9uUFdoT"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4563ac048f4so501655fac.0
        for <linux-iio@vger.kernel.org>; Wed, 05 Aug 2026 05:21:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785932483; cv=none;
        d=google.com; s=arc-20260327;
        b=qBEgnlqw0E2e1unHuz1PaQUcpCvMGY/Lf7QZXcbpz/Gn4/hwIDLVyXivht5WpP5YLJ
         Lrfa8729indudVF2fvZ2LbaFENUfNbJfdXX9wCpbLPgMtHVSsd9cOZmR/pc4dEp1eUBX
         n9/T1/UJKo7Y0OUI6C6t6jZtpnE+82UAh0k1ZO8cLvLeo1C+EEAI2zNF1lDeS11z3K7X
         3ESyL9SYCjaWJhyP7BIgQ+z6qsUrVi4X3jHLyfvEfYZLvS4w1FKmMrI5vwIZwSLY53ue
         riAjg0Tr9t4MZhf3aMs+zCmMD28M3doHzkEHPfvbcaizzGp6fjnsrLoEVCK7CaDp+3kf
         DjEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fU4eh11MrsmdYZGuYoz+asnYhVdbu0fo3WzOayJtn8c=;
        fh=tuH/lMMs9qcAODcfiV5MnPLmoqbo4XykocfHqSbhofk=;
        b=XcdCUZYSqOsFGJvqVZWsbQZWrCFB+lW3SX1NGhg65CCglzdghktNBcX6eVjGPK1cGR
         +WdQGOfcWvYRBKqE/sF6DvPbI7v1txc1eykUVAJzC9/uS17xUKz66iGbLP0/+LLV3LNg
         8FtJQWgWsbpyVMtvjlUzBTBRFTuhcSj/SUR3JGu4I5CnNEGuu7Zp+IolybncE/B9/cB2
         qtvdgtzQ48d+K8+0DyS5V7u2SFe3SB+6JZLuuJIlTi7GukijJLzNrEIuajX/42HDYq50
         M/Y0InA0XcDJoSfDFEw+lrNkZ1ALydNI6WH68KOrI5rsK9An5svBaJaOEMo1SxT2J0X9
         NjMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785932483; x=1786537283; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fU4eh11MrsmdYZGuYoz+asnYhVdbu0fo3WzOayJtn8c=;
        b=W9uUFdoTbXt041sbfHxCPGiozWmpBZIdXM0aBl7qrcykI+gNK44tVwIU/7bo0tgqut
         oul1ZWZWOQik7ISkKzXaAP0AyeRfYw1RhEn5sYfZt9s69gIbUis/gxkD7+d8m74E2uo5
         FI5Lhjd29lpu63SW+g1DAB/Qwx02Y+an+h0dnYlJWOmtfrgDYodF5T0g2IqpDtEdX8Dx
         59EXv8g37wTgR13dJur8HujERA8hdGp2+xA3Eemr2lp/4XEQ7r26LHiLDLapgMWvmqml
         Poel4bsHxEglc4GxU5i2kI6PIyzxgbIklCiotyvIoImYxFlD6KAyePQbJKRVu9u+WAi5
         FLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785932483; x=1786537283;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fU4eh11MrsmdYZGuYoz+asnYhVdbu0fo3WzOayJtn8c=;
        b=mKn4mIFUghcG77r73J9zfkDk7BePR4YR/v99R/moo++vtwNuNfwn1g63mlZryQxFcp
         G1m4TpwfQGiQgv9ZWpt5NX+t73PxIe0Q5gAJcwjXMgpZspJ7haPiZ4fwjVVcsnWfhA7o
         YXI4NXY6YNK9UTl+UZwRU2wOCbtBmugGVlUFgpJKeDvHBzV8wcWCKw2wpGNuAg3R+BXq
         O0D3k1HX/aBd5415s/ah7qilpWDopOZBhPVbCijNadv0zdHKwT1ruCSEgmh0KGV30Bvc
         z8LtPg9w/blF9qs0OBT/mJLYcZiljoIujrirVf9uaNA7j2/tN2hae5gdeogZZfmXMi1o
         w9Nw==
X-Forwarded-Encrypted: i=1; AHgh+RoTx0PvvWJxfoVup8BUenhKYEUlvXCQRwa87s3vibbfqV855f1cPoa/P7SecWvETGC94kX2yNA/BXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaWxe2jBwZ/KjJ75DAWg8mcKDJ4KNwsYeZ8bovbTvfq9GoIjjF
	3ArZFkTPd9kiWr8w8MxGAxHtHLJH//h1stSiKB5Xrtz3YrFQjEBe0kCdYyv6cXFSld0FEA+T7Jw
	S/qYKMSMGYPSQUbohPvvWkQzStYT11M4=
X-Gm-Gg: AR+sD10s3FYa21040lXbR+1hvRXFp4SxniJpyV4SMdxI/mkDpO8EU9UXDlUV78YYm4u
	MLDVNMYTK1un8Xhdv81+dVr7Wlaju6qnaD8+jKeQVdgZ1Y+j5IYwZNnROZufSruTFdvCFtEVec2
	3ZzGs9e18IZSh5qotQbAdXDZV4PKVOooSdmVvJY8R6gSpFv3CaTEk7MSN23m40jzjlKVKaYLtPT
	5p1Q1bEpI4V1rZiz/JRo6eytVFho61OIXzopHIsn/CDoCjMKdZkFe04MKy+rXzVvsuK5KRHBKjD
	tH6OaJRwUk1JYJ5zQYmyRO6tJMbGHVfus4dnBgOMs9+D0g==
X-Received: by 2002:a05:6870:31ae:b0:44a:f310:407c with SMTP id
 586e51a60fabf-4599ee3caefmr3310941fac.15.1785932483345; Wed, 05 Aug 2026
 05:21:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803134346.6733-1-abdelnasserhussein11@gmail.com>
 <20260803134346.6733-5-abdelnasserhussein11@gmail.com> <20260805010550.4c513e22@jic23-huawei>
In-Reply-To: <20260805010550.4c513e22@jic23-huawei>
From: nasser <abdelnasserhussein11@gmail.com>
Date: Wed, 5 Aug 2026 15:21:12 +0300
X-Gm-Features: AUfX_mzTDC5AfrDUK7aBJKOJZBoL4gq_YWGMQeztk_yvMBB-oUyfqrAHB6WJjCQ
Message-ID: <CANpqX3aC0a6Daps-Kgc2gXmjKdhSWAYW0J_T1BVuMGNru=ZVgQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] staging: iio: ad7816: avoid DMA from stack in spi_read
To: Jonathan Cameron <jic23@kernel.org>
Cc: nuno.sa@analog.com, Michael.Hennerich@analog.com, 
	gregkh@linuxfoundation.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi  Jonathan


Thanks for the review.

> The ad7816_spi_read() path performs a sequence of SPI transfers and GPIO
> state changes that must not be interleaved with another read operation.
>
> Split the two ad7816 out as a series on their own.

Sure, I will split these two patches into a separate series in v4.

> +     mutex_lock(&chip->lock);
>
> Use guard(mutex)(&chip->lock);
> and adjust the rest as appropriate, including adding cleanup.h if it
> isn't already there.

Thanks for pointing this out. I will update the code to use guard(mutex)
and devm_mutex_init() to handle the cleanup automatically.

> Move the buffer into struct ad7816_chip_info to provide storage with an
> appropriate lifetime for DMA, align it with
>
> Why is lifetime relevant here?  The on stack data was fine lifetime wise.

Right, I'll update the commit message to focus on cache coherency .

> Fixes: 7924425db04a ("staging: iio: adc: new driver for AD7816 devices")
>
> No blank lines in commit block. Sometimes I just fix these up when picking
> patches up, but sometimes I get grumpy and bounce them back to submitter
> to fix up in a new version.

Noted. I will make sure to remove the blank line between the tags.

I will send v4 shortly.

Thanks,
Abdelnasser
