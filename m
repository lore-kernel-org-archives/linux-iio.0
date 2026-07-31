Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03984414A34
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 15:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785511994; cv=none; b=abH/v5HX0alvauGha+74fZu4/4RmBeAJZJ7gXMK48K9LMaWWhy9iV23X3ORoMWo3D9Ej9JKEQE/5f04ODJd9+18MuBGejIAHVQOafJAK5GRQTLdXRWPNglQVkylfG46qpYSRLA9xJaqXwpE/7Cgnk8dpvF6U2uq150LAo4cQCKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785511994; c=relaxed/simple;
	bh=Eeyk4ngv7/x3r+MuVtBUel4ZKl9tKJlExEAmuyCWtew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BW1tvIbxpp62Mipg9RCKinkNQkME0hMosF3mARq+JlQlGrX5M1GAd0y8B7gtYEkeKdKllR3KJMrjbn1cqO2j05gQ6D4FVNoC1GMAQ6apNVOZnTWxEaEHMYQGnftQEOdEb8Qt25fDpLhRpGNUi46DQQNI/HYeIESXTt+6xgOq4sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oeo0bQa3; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeo0bQa3"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f84023916so1158114f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 08:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785511988; x=1786116788; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7SrltwSyTrb/CKHnl7OEGYiMK0a6aVYvu1LZ/gmJo4k=;
        b=oeo0bQa3HSt238qrFd20lkPs3L4PvS+aC4fDjMo9mI50+udE12kQjY7U6CxebSzKDJ
         h9ladJMtalvGK28f8Tw98hzTUXfc5euVduZAlozdcNbyCoBQKCUDsO/b+L/igBD+BtLq
         +JXTsRx0iRRBN5I+fXLBPHVMOBVwHJAKwWuDdvzMXDEvtkKX0ruP9XxQeC3VkGfr08OO
         ENzsbbnPbGK5OBhVChBrx6j7PrwQoBqvpPIBECW9vXrfFXfz95C2UxrQCyOw3pMJhL62
         bv9zLqqPK6ynsADQqGxs1wRF9u4R8Ep2LC0okw9eNLgp7plzxm9nwSlK6aWCwSThBQlZ
         WB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785511988; x=1786116788;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7SrltwSyTrb/CKHnl7OEGYiMK0a6aVYvu1LZ/gmJo4k=;
        b=oAmeCZBQ8eSlw5+us3BnYBCZAyn87cZBk0KQF+yYYNNb58Mr1WhSSN9WZl2pmUdNoe
         tVsQ6CIxOjo2VP2ZYGKL2MPRlV0H1i5pOwFAqWpoPqUEDuVE9/LgRF/lpGTW12/OeRet
         Jk6hazFzjGavFPVdYcdj0GBq9pNuYjCVoCEIScZeIeN3QPnvSY512TUv863wkQzfpkjN
         fA5Yacrl1QPEHz+23J6hGA3BkNkfUjH2pwAPhLy/tOGKIfDVjOcJCeVQJQMebcbm3Uj6
         0+hj9VdEGf+5tJzWihilP+s00kiC96+hZAhiQi5PQX13CCRu7umTnw36c7Gh04s4ooI3
         T6RQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr/P5CbGKLOiEEL9KD35cnFHe0Do6/BlES/vKASaNNEGHtEN6wMpYcffTzhEUvxm4PzeZ9gF/Bkanc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzroOVB74oyIx0/KSCE74g0JdP5BloiayEZGzT9aC5ueJPFqm7X
	sCBvPiPpxn/0qgmZotRItAK+wqBzRPRHMb8HHnFJsqnEFuPWocSd/xa59SrCEw==
X-Gm-Gg: AR+sD123bVct6u+wKT+kI0pp4lkeUPAOhnz+Dca2R59ZbWAiLiIcJDSDo3elUS71tD2
	+iPUn4a534Ay7iFVRKNEw/5Ei6tYktWrvS5ux3SdYEPVKjdUEf665lePv7XyFvb78zqIy0Ild6U
	HivHKniqcy/PNKec0KK9zz6UdSpUf3vQU0WwV5nWwE99n1fD/4JLmDwE39yLVFhOUi+MPpOMaqs
	yW78VrhiJShIlRKVy2+AjP/Zi4kj0wYIDQd07lA394VVRzi7RB1cKMkH9qPb5xKUZT2owcPJABH
	2+OtPrap1R15dKrpRhW/DfzZAoJ9YQbPkgUuzmTbWmUapOLW+YEb+lFJhAa8nMaFDPhYoy/1Q7T
	BvSyja2NTEKorkighY5FOYydd1LBdf5jX63yfji+yZY2AotxH8XLWsD6iXnRx/mFO/ONaWcHA6r
	FpFmEtR6REpAXKsDCXJXdDLr0s28KD2LRw5hqUpju6pYtTC0hV9KL1
X-Received: by 2002:a05:6000:25c6:b0:47f:97a6:1334 with SMTP id ffacd0b85a97d-47fd731956emr98219f8f.46.1785511987589;
        Fri, 31 Jul 2026 08:33:07 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm5876828f8f.34.2026.07.31.08.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 08:33:07 -0700 (PDT)
Date: Fri, 31 Jul 2026 16:34:16 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: nuno.sa@analog.com, dmaengine@vger.kernel.org, 
	linux-iio@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 0/9] dmaengine: Support bus widths of 32 bytes and above
Message-ID: <amzASrOOjJjFun3M@nsa>
References: <20260730-dmaengine-support-wider-dma-masks-v1-0-3732f1f9d9ca@analog.com>
 <amugh4vtD4BIl3mQ@SMW015318>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amugh4vtD4BIl3mQ@SMW015318>

On Thu, Jul 30, 2026 at 02:05:43PM -0500, Frank Li wrote:
> On Thu, Jul 30, 2026 at 03:23:07PM +0100, Nuno Sá via B4 Relay wrote:
> > [You don't often get email from devnull+nuno.sa.analog.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > The DMA engine slave capabilities advertise the supported source and
> > destination bus widths through src_addr_widths / dst_addr_widths. These
> > are plain u32 bitmasks where a set bit's position equals the
> > corresponding enum dma_slave_buswidth value, e.g.
> > DMA_SLAVE_BUSWIDTH_4_BYTES sets bit 4.
> >
> > The consequence is that widths of 32 bytes and above cannot be
> > represented at all: DMA_SLAVE_BUSWIDTH_32/64/128_BYTES would need bits
> > 32, 64 and 128, which do not fit in a u32. Hardware with wider data
> > paths is becoming common, so add a representation that can express these
> > widths while still using enum dma_slave_buswidth.
> >
> > This series switches consumers and a small set of producers to bitmap
> > based bus width capabilities. The legacy dma_device u32 fields are kept
> > for now so the remaining DMA controller drivers can be converted
> > incrementally. dma_get_slave_caps() folds legacy producer masks into the
> > new bitmap representation returned to consumers.
> >
> > Once the remaining producers are converted, the legacy dma_device
> > src/dst_addr_widths fields can be removed as a final cleanup.
> >
> > This issue was discussed before here:
> >
> > https://lore.kernel.org/dmaengine/abkoXXbaxaiqbBuX@vaman/
> >
> > ---
> > Changes in v1:
> 
> this should be v2, RFC is v1

Ups! Sorry about that! But I guess now we keep this path? I mean, I
should not bump to v3 next right?

- Nuno Sá

> 
> Frank
> > - Drop RFC tag.
> > - Rename the new capability representation and helpers from address
> >   width terminology to bus width terminology.
> > - Convert all current dma_get_slave_caps() consumers that used the
> >   legacy src/dst_addr_widths fields.
> > - Convert a small set of DMA controller producers and the stm32-dma3
> >   per-channel capability callback.
> > - Add helper documentation for the new public API.
> > - Link to RFC: https://lore.kernel.org/dmaengine/20260616-dmaengine-support-wider-dma-masks-v1-0-da23a8dcb756@analog.com/
> >
> > ---
> > Nuno Sá (9):
> >       dmaengine: Support bus widths of 32 bytes and above
> >       dmaengine: dma-axi-dmac: Use bus width capability helpers
> >       dmaengine: dw-axi-dmac: Use bus width capability helpers
> >       dmaengine: qcom: gpi: Use bus width capability helpers
> >       dmaengine: stm32-dma3: Use bus width capability helpers
> >       iio: buffer-dmaengine: Use dma_slave_caps bus width accessors
> >       ALSA: pcm_dmaengine: Use dma_slave_caps bus width helpers
> >       spi: dw: Use dma_slave_caps bus width helpers
> >       dmaengine: Drop legacy bus width fields from dma_slave_caps
> >
> >  drivers/dma/dma-axi-dmac.c                         |  13 +-
> >  drivers/dma/dmaengine.c                            |  20 +-
> >  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c     |  39 ++--
> >  drivers/dma/qcom/gpi.c                             |  11 +-
> >  drivers/dma/stm32/stm32-dma3.c                     |  32 +--
> >  drivers/iio/buffer/industrialio-buffer-dmaengine.c |  15 +-
> >  drivers/spi/spi-dw-dma.c                           |   6 +-
> >  drivers/spi/spi-dw.h                               |   3 +-
> >  include/linux/dmaengine.h                          | 234 ++++++++++++++++++++-
> >  sound/core/pcm_dmaengine.c                         |  14 +-
> >  10 files changed, 323 insertions(+), 64 deletions(-)
> > ---
> > base-commit: 7524fe142b5a772f8421aeee2132cf7e21a00103
> > change-id: 20260615-dmaengine-support-wider-dma-masks-5aac12497e27
> > --
> >
> > Thanks!
> > - Nuno Sá
> >
> >
