Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8F93A5445
	for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2026 07:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786088201; cv=none; b=WT9uI9LiJlM9Mj5Zi8s6LPEDCdwn4kNOh7WBebE9YeR8UdYG7FS6kMuJGcp0gbXxsnBhr7ZS8wnJqD2H6HgFQRSAWEmiIgViOSNslnVfZBNZMSFMEGK0a6OznzhIUX8imnDXppu69Lrs9Yp5JxH2wr/Wkmicc4XsaNV2a6g1VTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786088201; c=relaxed/simple;
	bh=wQAVvH1tNXlAzIGB7zvqrPD5lgABH9gvcOKmiSO8R/o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ou4+R2j0NpMiyykydh9qL6tOyNVW4hcJ2sW6Eb2ap4HMn2PqDmPmMNYPxkSSd19285uCc/0jGsOQ+1Vh1/qEBeVweLenf4QgoUNsTvATnpZ+sVjsWi8u2zL2ZNyD/+KEZS1QiaHA8wnrErySyQfJm91ZK9WKY+SBM0NxRxGEjjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccRn9nIz; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccRn9nIz"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f96c5b722so1878463f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 00:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786088198; x=1786692998; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z/WXJlREgBQORjV26H3RvXyQimV7YRpmumUNnx9xtAU=;
        b=ccRn9nIzx7L9Vka7iA+tdMHJbYrCwPzXJVWb+B7rSbCXRv88t9sU5uKBhrBS9lIepd
         o2s7AuTZURm+YzcfMvROXpcLZzsxBG1KBq+WaOgPFuKItIS7/5yjAfE/xD6TjOcIl0pq
         J2OfKuvHH5jhl82EqjCfaUm7YZ2JdYfmHjEO+GiebA1HMrE2ETZGFME+kuxZjIzLqZxA
         yDb85tfXfBC+LegcTY1K9+cC3EAIBWygx/DkImskR5x3M0KOHtkRUwJcUPkCpEcorENi
         NwCRl5Vn1kodIVRTDe6Sdw+Oy757ss5bzEseePT3wm8wmL4YLAvqNqLbNe5f/HjwiI5r
         G3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786088198; x=1786692998;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z/WXJlREgBQORjV26H3RvXyQimV7YRpmumUNnx9xtAU=;
        b=k9wEvUojB3v3EdxQE5kL/GLJ777z8MtDMfXUHyL6vxqqSS8fWSqi2yURPrGuV2i8Gd
         xKRa2Zj5x9QFDjYQwuwhb6Bwfv1Ail9pCEQ71KnlGU0uk7AZDSA1n48ZatGlT2rz1nAY
         /vPD4lL7g6wjhiDhTLmcOzfCEx89thW3w/lTOkmDzlBUw1nBEiub6//8c1V4h/YervVO
         3lCKxnQb/NjwTw+PPiQUmj0C9H0wQ0TgostVcJUUKz8ro+VhI8Xi3x7oX3nffD9pKzes
         i4kE3UZKUVkFMpbobvPoLHK36QGVtmfubUEnyA2NusRwGnUqCy3Hi43EfErIgpoIqUXD
         iVOA==
X-Forwarded-Encrypted: i=1; AHgh+RqzabOXJoTxTRWfL10ohyu3Py9O+HZSIZudMwGwt6ssdq6kbUJrUukeSnw38Kian9XtmRDZWxHCBXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGgK6GStobmMiChEFArQ6CdfKqgB6WwaUEqzqUAztyOzzkK3qU
	mxLgALxY7xcloP19qXSQyW60sSGmDSAt6OqpuDwqTspkQjB0S6/Dtk3p
X-Gm-Gg: AR+sD126TaLYmAU9nNv26dL2pDUcMvD8trQIq9pG45vQ03tIa6Ky5UZ4sht7gTshzRB
	dJDLenEzdjN5FGt8/ptKScBt+WVVr6sOl49h06bx4csqLlxJOdY29Y8omiCG0AJcr+deUtYp+rU
	udzKa0UB2w6FGITSpObfZFS64T2tFL76PHWPFWPMgzDNY8BAtLwml0PtE+RTM4vYpMmjBIBQdT1
	nblSyJM4XFU/t2iaqkuLDAQC6yD+A2m3V3JMtAIaxvYaBUfaoxNOezLrsGNSg+pJsgZuYUO2EGb
	VEGtzxfjJOd0VizXMi2ZWAj+3Ds6n7CMcYdlYxABSKApmlZXbr909DnXuDHsksHhktXVxaKtw2s
	PcNx8vjGPkE8uZIE+29IPJFL0L4ZM9gASWz8TYNlPpQYWhM3t7Qeh18ubmHQmzG29AcY7fPOTSa
	Ac7p5bhvZR+7r5nG9woUR3K20dL1yvyM/jIsaKn83pSLZYc9gy0AkftJT77tfnTQzku8tWaM3fo
	pGrHTSqocasf9GWspzbCq6W3zMcqGjTPxX6qNV0ISnHY3NPuwVMdR15mVnQcK/1viEt2Qlw1Xbj
	d+LiBgLXLgHNMSqH2SP15DGwnhz4Zv0Kdl/sKaHqJh9cW9WOitSyziQZQjStZAofPCKOogyafnr
	C6S5fn090RC+zrWTAtBxaozCGgc8g2jJDrn8YHacTWjGb+pUiMuxPS2m47yis3ZlecsWQBfs=
X-Received: by 2002:a05:600c:c8c:b0:496:c18c:f9a3 with SMTP id 5b1f17b1804b1-4994e79dc76mr250053215e9.5.1786088198056;
        Fri, 07 Aug 2026 00:36:38 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995e9f0230sm13148745e9.6.2026.08.07.00.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 00:36:37 -0700 (PDT)
Date: Fri, 7 Aug 2026 09:36:37 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
Cc: andriy.shevchenko@intel.com, jic23@kernel.org, dlechner@baylibre.com,
 andy@kernel.org, nuno.sa@analog.com, gregkh@linuxfoundation.org,
 skhan@linuxfoundation.org, me@brighamcampbell.com, jkoolstra@xs4all.nl,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: iio: frequency: ad9832/ad9834: add comment
 explaining do_div usage
Message-ID: <20260807093637.00002bfa@gmail.com>
In-Reply-To: <20260807060348.6477-1-raizudeen.kerneldev@gmail.com>
References: <20260807060348.6477-1-raizudeen.kerneldev@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Aug 2026 11:33:48 +0530
Mohamad Raizudeen <raizudeen.kerneldev@gmail.com> wrote:

> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> index 33dfd723923c..85f39ceb3c4c 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -103,6 +103,12 @@ static unsigned int ad9834_calc_freqreg(unsigned long mclk, unsigned long fout)
>  {
>  	unsigned long long freqreg = (u64)fout * (u64)BIT(AD9834_FREQ_BITS);
>  
> +	/*
> +	 * mclk is an unsigned long, which triggers a Coccinelle false positive
> +	 * warning about using a do_div() for 64-by-32 division. However, mclk
> +	 * for this hardware will always fir within 32 bits, so do_div() is

You have a typo here, fir -> fit.

-- 
Kind regards,
Joshua Crofts
