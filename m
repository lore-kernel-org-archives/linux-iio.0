Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFB738F935
	for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 21:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781559672; cv=none; b=nuxhJJedY1aEfpgdb030HuuWRBM7p13fzvbDhhQt4KYqiGW8MFAiw4whmTnu32UuiCATYrmD3AR4l4JETbADlbvcPq3mQ/scXhKHvO9aInp8ABB9rDzDrR93eVsxzDi9ujCTFM2q2SrhMkgr2JQMPcv/PPGQZVRoi2KgQpyXP9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781559672; c=relaxed/simple;
	bh=fKGrDpUME6Ng+py7r20D0XW6Rq0dPJnksNb9Y9SEqyc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G7f34PzoFBD4muEPENY0kRewtMGHy4mSsHywY6E64SoSiZKJJAFQ1wEfXJfqtJSusQb5KQq5xYOAgVznW0U5vvfIkekRw11GEAHUasqGb3MuVWtzB75tUALntVZqzWg5FSWZUmvtzp98BRD0RjUq6ZI9g76caLdwq1tjXaIVDNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ftf+uNhm; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ftf+uNhm"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e6ec655c80so2087632a34.0
        for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 14:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781559670; x=1782164470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TxobOw7dV2c4GSBHIzo0G0zoqQdl1bC5wTgPD/6nwk=;
        b=Ftf+uNhmQnxHmSHVlW61tjgKV/c4e2SiJ4q/BFxKIz9aN/5c5fCqTH8uUiz38tfKtJ
         /hBiRFJRfwyF6KoFLeb6QZOaSJaESLFxAvZk0wQ4XqJ9o0Ta0lP0LNVwYvdrhaYY4l0m
         zteT7ZHJt1D8DK3iMxbLCTZ/feC5NzrmhNKSVbAzD9irBHhsGsZrjlnLSItnPsiATllQ
         A9OuMUkM6t97LrESVN0V+w8kErCRoqxuLw2oWYFKWCjX6oiN4xBGU29IVn5YFlWBb1dH
         gWliuajRK3Kxfr/+9+N/VCVMPUMwEo86jbaDztkl+WkjYOZ1wBQ5CHKqMN1WrL7Y/g9G
         zPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781559670; x=1782164470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9TxobOw7dV2c4GSBHIzo0G0zoqQdl1bC5wTgPD/6nwk=;
        b=pdDjJ60u1X69/v5vze+6U/qepPR9FtwG1Z4JXa0H9L1QT0h6a9ymJEep7JJEsbu+A7
         QVHwZ1yU+f9jE/HIAvnucECSJFPAuyf1nLjubOg1Uckpw637GWk2vQEJXNYX4bJ08LeR
         VpRiJDUmGMpdtn5joZjYFSIJuQy8sLMUzkvuxJWny728IG1UqaIGs2LMeakpxx80QAOH
         CfJ5y9MplxlGaONPqE6rHu9Lcxy2+LwE01cCx8puilOAvppT4jkbs4JlTtAG95GZZFXE
         Rur2Q5sgn8FmIxaXBRXN3aQUOiGtGUKo/qr4L0fkRz1kpC4lSpDJ5P2wN3Hab5i4OR7m
         bxdA==
X-Forwarded-Encrypted: i=1; AFNElJ+DUPgvS5BtAQfq4RPL1AH0cQciOIu/XFwXWnFz6zbtPZArD08GpH4WFWLcKeRIweBZvfQLJsB5yUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzff4jBhkd+WmsGKuP7OQDVFy1pTXVOCG81KOtAG5+C+H1enoim
	pdKQN408K+1v/0q0qODkLuWhck0GKi8iNO3XOkMLjZrYDCOIu65EJFaQ
X-Gm-Gg: Acq92OEF/lqv6JcPyktGST0t4yFY3CtOgtM3VxdwS/rXev6SL8SHwbTVPzDKYOYXRAG
	HvXNuo/W7DGIzk1xpJ2uUER4MmwZmdCd5Keh2byxMno0DP0rYQAuB1DJ9tk1Xtu3WAA2r3lH0L8
	yHuz1Qj4sCTSABM0+dmPEikTzYCcxFG5j1aO2nKWRDqdXEXi1+s4c50T5lzK17F/p9dUG9ujKad
	7EyuvjzsKw8XKfVJO8NOuv+20r2+YvLfpty598HT5tugLZuwkg0xXMmLrYbnGsGgcAtaJrwNfCv
	0ISY0KRWRTJ4HLaxviSDvL/FkikvCQWaNUsuZIbvUfhXKe19WbYBmOQMu4YlVCsUQmjvNhQRxmW
	+pZcDWHUMhG+SiEOoRtvuC7ei+jd1dNHYff4njuLg/6aiIeKvLIzndj6OXzdNSZgjC29gAOBKAO
	CjqCSGiQHhwyjDO4kwxyizMxckQIAQ4n+lqFK+6dE+1hFNEptE9ZOB
X-Received: by 2002:a05:6830:914:b0:7e7:45f:ce3c with SMTP id 46e09a7af769-7e78e6fd699mr10132472a34.14.1781559670522;
        Mon, 15 Jun 2026 14:41:10 -0700 (PDT)
Received: from linuxescape (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f5bb344sm5234009a34.7.2026.06.15.14.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 14:41:09 -0700 (PDT)
Date: Mon, 15 Jun 2026 16:41:07 -0500
From: Maxwell Doose <m32285159@gmail.com>
To: Tomasz Duszynski <tduszyns@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: chemical: scd30: update email
Message-ID: <20260615164107.5297f7c8@linuxescape>
In-Reply-To: <20260615200459.8272-3-tduszyns@gmail.com>
References: <20260615200459.8272-1-tduszyns@gmail.com>
	<20260615200459.8272-3-tduszyns@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 22:04:59 +0200
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> The old email has been inactive for a while. Replace all occurrences
> with the current address.
> 
> While at it, add myself to MAINTAINERS as relevant driver files still
> hold my address.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> ---
>  MAINTAINERS                         | 1 +
>  drivers/iio/chemical/scd30_core.c   | 4 ++--
>  drivers/iio/chemical/scd30_i2c.c    | 4 ++--
>  drivers/iio/chemical/scd30_serial.c | 4 ++--
>  4 files changed, 7 insertions(+), 6 deletions(-)
> 

Acked-by: Maxwell Doose <m32285159@gmail.com>

-- 
best regards,
max
