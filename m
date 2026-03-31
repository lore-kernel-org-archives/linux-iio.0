Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A88D3A8FE8
	for <linux-iio@vger.kernel.org>; Tue, 31 Mar 2026 10:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774953840; cv=none; b=a70qQPmaOCn13LwTTB/qGMKJcteUVpH8lo0R1Gqz5RPkUNGwFrLOBPkkovkRpO0j6nVzsi8/4gvR2iluiaUikmRBZimSe7sG6Tu3u4gJLoxE2Egm0XCVlRMjwbdEco0Dkmvc80bhgoZbgiu81xauLIK/LufM6spjgvfzpzsQhc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774953840; c=relaxed/simple;
	bh=T4dAxUI8gDhHZ2BiVXZk4vJKREBwCTcQixKEVO35Yto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8wXfWYbxUm7Vzh92ktdKWyjAxluRwbvfYrk9uTOUGSBusAUKRN4t4b9Hr5Z8ze/szEIhoiUB8bmodxWNjAunhPtFUNzvGXGCxWg5kcn7DoRpmAr9Pf/RfJ4RyGQeyyNAJN13fPDUm0p8HVCPWM9dmiYd/9zVrUOIhtUumoizhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQjoUwrc; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQjoUwrc"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-486fd27754bso54741815e9.3
        for <linux-iio@vger.kernel.org>; Tue, 31 Mar 2026 03:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774953837; x=1775558637; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nEcpPzSvC6ZEWdsfhWv80i/L2DAqClOncDeDEa5gXFU=;
        b=KQjoUwrc1vD1lXby2MGB/1QXjeHcYpbMdGF8bycclHJVKyPdnW3VpjVUliMZmVK2zD
         KlYVoxX6Xk3K5cJGW292M1jAWd/q/R2wTGaVvvGeghq44kFvVV9o8dcLGaoLOntM33e4
         Yjk4OTIikW0UWjP42xAEn66S4RmOQPN123cBgYg5vXWZhiF0hzzTafn9abDqr8iGPCJx
         V0kT6jf7pW526AKWnZq04re42jUFHgZnDYtWp7dNSXeLRxuMfXnzIB8vKC93nDPvuh7g
         JLWZdoj/DeBVu+2JtMRoC8xZVgYw8UhI+6ONYUDagkz2a/OZO7Rq1T/AXcPGqDNjX7PR
         H9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774953837; x=1775558637;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nEcpPzSvC6ZEWdsfhWv80i/L2DAqClOncDeDEa5gXFU=;
        b=qxKM7zdqoCIABMw0QOyf66GqWsIS1+mSsyXZ4EiwJ0GP4DkgXx1L7108NtLd0GC94m
         X4bYcnXgOmJvwRDJxj92KW1fINJyJf3ubnTlMyo8vfCBcIkU0a9KPvXyUTdOZZ8xxjIo
         aURlxcWj2GpANFWLOOOxjMx2M6N2GTXMedydq7OpvIc0jd/0nCqui2DV0l1z3HdJW2Kh
         vq/CM8DNGCH4oFdQOYX/Uz8TowwAxkUoYZpkoyTfPii8WTxRJL5fMATRdmTrwbLJLmig
         Gh+r70VqfZF0NxKOWYwJCA6/t0LUgqfg0+uzx5KPq8Yy+nfdfNB8WVAPx0+3L5zvACQL
         BMtA==
X-Forwarded-Encrypted: i=1; AJvYcCUERC4/DWIx+SqPDn/wFNIt+rqJew2rUmqaJq63nE5GS6GkGtTDPxCyS7xDZdIDVIZ2YYD+r2CqCUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr0kq37LYkzU+c5OOcOY52nmb5s8DCQ76NniAV1hgB1o3AZ9rt
	Mc7Wjlxru8bO/a6nsFQ551RNd64d3E2W6PHFa87Fl+F8S8wMxHf9dxmv
X-Gm-Gg: ATEYQzzfV9eWanVmWvSnk1zjYycb53AxP+KFWTaLHQgz/g9tslcsoYXf10DwYz7hVaX
	JlghyzlbHjGWFeBR+c8Di3A8PpBrxoJP7LGK1seYAvESmQmvo3bdsDwjPssQYmck4WADZvE9gg5
	P4dvVBqeV7rySfwgZ6Tx0ELK2Jb+8k1yRWZJ+DKEg8+/4kyEhPdNeoQLCRzeUEIgoarJskvEKl7
	IZ9OCD167oBGLLlWQV7APJsHIKR9gtqkKAZReSC9oAwrWJL8WswEUW/GVZO6AQIVEUb4fW4skdf
	tHcCsWmFyWQKK1x6ux/Z937sB1zJ066w1bVsS2xb6s9mNnW+syhkdgmYDLndCzEDZ365S74yl8h
	qJl51pC3FF8rLojhjWPOLzWBFOQxsGOj2Zx1L80BMqcsaXLOrZNqVz1diqqP+CXMTUdRhYavBlg
	7e41aRBDxtMfmK
X-Received: by 2002:a05:600c:a292:b0:487:2439:b7be with SMTP id 5b1f17b1804b1-4873d34639fmr72310625e9.6.1774953837486;
        Tue, 31 Mar 2026 03:43:57 -0700 (PDT)
Received: from nsa ([185.128.9.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e83682fsm28409995e9.7.2026.03.31.03.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 03:43:57 -0700 (PDT)
Date: Tue, 31 Mar 2026 11:44:43 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Carlos Jones Jr <carlosjr.jones@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Liam Beguin <liambeguin@gmail.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jorge Marques <jorge.marques@analog.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: adc: ltc2309: Add LTC2305 read delay and
 optimize chip_info
Message-ID: <aculeDmH0eojSpwD@nsa>
References: <20260331012457.9324-1-carlosjr.jones@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260331012457.9324-1-carlosjr.jones@analog.com>

On Tue, Mar 31, 2026 at 09:24:55AM +0800, Carlos Jones Jr wrote:
> This series adds missing read delay support for the LTC2305 and optimizes
> the chip_info structure for better memory safety and efficiency.
> 
> The LTC2305 requires a 1.6μs delay between I2C channel selection and
> data read operations - a timing requirement identified by the hardware
> designer that wasn't captured in the initial LTC2305 support
> (commit 8625d418d24b ("iio: adc: ltc2309: add support for ltc2305")).
> 
> Additionally, the chip_info structure is enhanced with __counted_by_ptr()
> annotation for improved bounds checking and reorganized to minimize
> padding.
> 
> Changes in v2:
> - Split into two logical patches as suggested by Andy Shevchenko:
>   * Patch 1: Read delay functionality
>   * Patch 2: Structure optimization
> - No code changes from v1, only reorganization
> 
> Link to v1:
> https://lore.kernel.org/linux-iio/20260327034159.15545-1-carlosjr.jones@analog.com/
> 
> Carlos Jones Jr (2):
>   iio: adc: ltc2309: add read delay for ltc2305
>   iio: adc: ltc2309: Optimize chip_info structure layout
> 
>  drivers/iio/adc/ltc2309.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> -- 
> 2.43.0
> 

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

