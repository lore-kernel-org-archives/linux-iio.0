Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C56C2FB965
	for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781802768; cv=none; b=usaLL+60GcdtiC35mD/N0GT+VAXkTbQ+nHqMlnDN70nN5PPqJQr7x6ploYWoGnYsOvIuzajhi52GTuIqjbvq50IOnCDAEsLg16wBoIGj7DL44sSfNiHkfJ21nvtMiwn4vxhirGZkIMQeDPuj16VAAQ2GTv9EdZpNRbH5TM0P91k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781802768; c=relaxed/simple;
	bh=XvyhWFfNg9ZTDu7ReKiTeTBhKhccySIyD/kmxK9wqcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1wKnMS376F9rSFhQyzn1euXOKdWv4IgO22zlhTI7U2as40+WFwIDV3Tt206H0GJfqQT7Bc7Nv5Rus/Q2ZUQiHkDuYdzxCBoM19fpoA/YGYDBtwB49ed6UpyDCe+n+MVsSjqTnA44px5xUhyyqeThS8GGsWCgoRVnjQHVZYHwZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsTR2mAJ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsTR2mAJ"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-462bb734793so974809f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 10:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781802766; x=1782407566; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OPYldehot7tz8RCFgz3HrFSaMMAMdN8VU5l6kfPYI9k=;
        b=HsTR2mAJjm9QdlJPx39o94YTkPgkk9NUDyDdNzCgq5ct/UDj+Xu2fzAYas60+z+uhO
         hGFNy4Pofz1w2wbVVfXuI1d5kfVzKTuo8jcz2TNxVfHOtxAPiH0auhz2xUXxHYDjVqsz
         Y5WfNNaYrgeY7FZm6s/fbdSofNiPLj/BahOxGSfLBAgSUmmehJblTLJEDWco6+t/OTf+
         2Q1Yh+wFIlvLgtYvXrESPIpqRJyVzGGbTfDFtrTwzQuzXvL16fvzaDSSN3puXL21k13J
         fyjIgmNY3lpFUr8m1u3pVwEjzngGSkXGLYm6PdIyst48osDAI6XTfvTapKEtiEQCUFK8
         SCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781802766; x=1782407566;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OPYldehot7tz8RCFgz3HrFSaMMAMdN8VU5l6kfPYI9k=;
        b=CFkztHcMF5jjuTDROoatZaITkP/4ntZjNgyCdAC9ovcPMOCdTYQHMWHcNl6p3rQ9Io
         c6WVv8BRMj0DNPrL4OauBREP1IgH317/Seg3pcDwSVFaxSTzqICSZNa3TYOBbfRV4Q92
         HicvdCbvJ2+m325SdunRWV1/68LLEW2q1nYZJqFNnBXXsFyl3JTEEFjqzzrucVxsmnKB
         DLM8Lt6tMNQmmIBR3ViEKesbn4ZbhJFVKyUm2x2JtF6rYgTZTNp54AJFLUZkIW0/Odov
         BK9Qbw5ere9FTzw8IXyHc5hlW+MBAwC5uNq97j0KEULq2GZLl2uQRtzn5vgP/RdL3cem
         nADw==
X-Forwarded-Encrypted: i=1; AFNElJ+ESjgYquCgD2k36UvUv1RlY0q9om8Wz/JXvlJ3rioVlFdty3EZfH89zlQFZBgZElT0rf9eI+iKuz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV29tjuLkv96YpcpSjt33BmkkKyB1lk0RLGuhWNXZQU1z9KAqc
	J3RVucj7vAZEzjE89/9tsUAyNg064WQhMBl+mLy7fCjPdx79X6IneJ+x
X-Gm-Gg: AfdE7cm6hrabrfPt3hyWGXqmWABRjFs4RVDDCoBXy84SnPjscx9fHTJHvXqmZEkDzi9
	bqL7rZi36F272nSucY0qi17Q/6///19b730cRgKqfgfJL5XK/PrWZW2uykb9KXinqXHVFsr49q8
	kZ/M0eoVY1OGRvC06KyW0rP9dWzH9QQjePADNqYTO3LBcRygakGaCE9Tq1c64UkRe6kSH4z4ajj
	U1W8wrbb1a58g0X52Ka9YNo2E2idJpX4B2CvpdwicdBXW6pQI4sv5F76Kh9dlz28MlvTCZD+MR5
	Diq/luGyQb7G29bt/MB4OHLWf9lGWOSi8E3bDLAdxfXWNktSgmbzaVHC/gmM45lZXyxge8lz/8B
	4zu1ct4zRbGN1xx0Ehn2o3beo254NeWLW1XY4AKeRWU8/MxdeC5fHqd52yGNgMPstgqiEm/bIwV
	x5dyvT
X-Received: by 2002:a05:6000:46ce:b0:45e:f631:2c73 with SMTP id ffacd0b85a97d-464ffa952e2mr467310f8f.9.1781802765447;
        Thu, 18 Jun 2026 10:12:45 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4650b76e7c9sm293604f8f.21.2026.06.18.10.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 10:12:45 -0700 (PDT)
Date: Thu, 18 Jun 2026 18:13:47 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: nuno.sa@analog.com, dmaengine@vger.kernel.org, 
	linux-iio@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC 1/3] dmaengine: Support address bus widths of 32
 bytes and above
Message-ID: <ajQnE0e5a1JS7IWU@nsa>
References: <20260616-dmaengine-support-wider-dma-masks-v1-0-da23a8dcb756@analog.com>
 <20260616-dmaengine-support-wider-dma-masks-v1-1-da23a8dcb756@analog.com>
 <ajF3p3Vu_pOx9z_V@SMW015318>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajF3p3Vu_pOx9z_V@SMW015318>

On Tue, Jun 16, 2026 at 11:19:51AM -0500, Frank Li wrote:
> On Tue, Jun 16, 2026 at 04:40:52PM +0100, Nuno Sá via B4 Relay wrote:
> > [You don't often get email from devnull+nuno.sa.analog.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > From: Nuno Sá <nuno.sa@analog.com>
> >
> > The src_addr_widths and dst_addr_widths capability masks encode each
> > supported width as a bit whose position equals the corresponding
> > enum dma_slave_buswidth value (e.g. DMA_SLAVE_BUSWIDTH_4_BYTES sets
> > bit 4). As these masks are plain u32, widths of 32 bytes and above
> > (DMA_SLAVE_BUSWIDTH_32/64/128_BYTES map to bits 32, 64 and 128) cannot
> > be represented at all.
> 
> This is problem, which should be fixed.
> 
> >
> > Introduce bitmap-based masks that span the full enum range. To allow
> > controllers and consumers to be converted incrementally, the legacy
> > u32 fields are kept alongside the new bitmaps: producers populate the
> > bitmap (mirroring the low 32 bits back into the legacy field) and
> > dma_get_slave_caps() folds a legacy-only producer's u32 into the
> > returned bitmap.
> >
> > Add dma_set_{src,dst}_addr_mask() for producers and
> > dma_slave_caps_get_{src,dst}_width_min() for consumers so that, once
> > every user is converted, the legacy u32 fields can be dropped and the
> > bitmaps renamed without further churn.
> 
> Good mirgration plan.

Cool! I'll then wait some more days and if nothing pops up will drop the
RFC and send a new series addressing some valid AI inputs and converting
more drivers.

- Nuno Sá
> 
> Frank
