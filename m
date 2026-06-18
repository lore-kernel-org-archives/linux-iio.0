Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693AA2D77E5
	for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781800086; cv=none; b=i7FcbyiCaBTLRAfgp6QHM9+5NYK5VhrZP+u0Q2Q/tqmp3vTBSw4RdLNtCsfo+4PWAEuVXqf186D5+GRvp1NOE42evZ2mrI+b2nTfqydWQEO5eRUQICdSmWnC8bUkDI+y4IIBocX1TOlMdJIx5Z6t3yzPoycS+hXLh8/Ky2ywjcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781800086; c=relaxed/simple;
	bh=87ejtw3rtGPx6KFLh7zznlL1SHSFuKKfVyFYiaHqGbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+d0h8PJkXOL+f0BjxZBohtuybXfv+R09oqE3d0Y0UW44pVb188q6sMQFlpX81WSy/yBODuFB3HPUFZWU03HsEYE+zsZvBK/KFZY79B+lEwJY9MbXbSRa1V3JTa+NPD4NipWYSVghD0dzN+P77Es9vYYNsy6gxvtHcixS1TxcLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZh8M6bc; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZh8M6bc"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490b613a17bso8935125e9.3
        for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 09:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781800084; x=1782404884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCJUs2t0WVrRt4cCouvaP6KYDyTZlyxgNOChJcn8QtQ=;
        b=kZh8M6bcVPEmfkIIE/PSslVE70ckQRObHLJAwKdp7qF5gL+bW3FwPVBKwTFSmsuntF
         EV5wzUEFpPPcSZyRkIqSmZ/+zkuR+XglV9ePwlU5IcYB+78RfC4ZwVhZrSoSV/cVJHVE
         QdjsDH/hQs5pJgpeFlSoWmoSKEctTVHZP6ZzDxXoPoVhA60tWZtUxqmaNADViUZs2wgS
         lzp2U+9FHm/qnaXL/eT3cVwycOE9ICfZIJOVzSFbFUz59OK2FmKWPeBLcO6bb8X+KdUT
         sHC9a0TCFejZdUff8F8JRPCh9lp4cdyE4TZ2uf0EHDomfseV8L+vNGqPZq0im2nasxEf
         koPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781800084; x=1782404884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vCJUs2t0WVrRt4cCouvaP6KYDyTZlyxgNOChJcn8QtQ=;
        b=n9nTxldLKoEva6sO/sDSxT3X8s0JO6GC6SLP5em77q2JyfZh2JKoijYCjqXEjQVhj5
         3RFQetfNO7HIEmG5VzYzjarSrlvpd6nX0ZxXNnws7Omqa0qq4kABT/oUj+o/RGMalF8j
         Ys5bJk6OX/AKfSfpJvXIT+Qdm7W995u+u3B3UtMZP8sUEQeapg0hHPFsTk2wM8aRtPzS
         HRhdDTq69g8mCg37j7yO3t0lzt0ZW7JwE3IcEPsgiYeeqczNGXN1DpR+cc/TtpOnnCDP
         hgXoiGzOSBqeq8dMshKPt3+Z1pnMiuNoOh2XVz36HYd1T060aIrBHRGpGBGa36Ix/IFe
         ekZA==
X-Forwarded-Encrypted: i=1; AFNElJ9stNu6bG9q8wZkC88ZrT23PiWwL/qu9CmgF0qKts5xmQyqd4ALiTLKrqamJhdFg6XbStyyi1cU+bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUPOeEnq6xDjkpIU6YjehIqyXelQLBTTxwBWJPP1opf8I7OP33
	Jk/gJDsHD/XZ1dLv1LPUTwB7CyCoVLI3ZyELqsybrIgLGMZfVSm7LJj9
X-Gm-Gg: AfdE7clrCXsmoKQMN0cz3tUNVo33cKGsN7t31bpfRoMGR/hoT+CnCpiLLyAVm4e3Q1Z
	uiyQHa092sg7yU4WkCKypLLQ/H8w2blL9p7ubHXAaPZVk6zWTVNHB2n5XnaRBkVfZd0MCoX9jHA
	AqgFai53MSQ9M/LO9nquc9BRiVkkKT/pBYkH+D1afE+j3rle5Ke2wPJCBlUfhFEIPaXg2aRozym
	QrJlUcnsxqWLJmnANVO6aagR81TLyjhJTZS39vTtuNVviOEzbiFl8LB1/6oiH08qRagIMi16/YP
	CHzkCzQ582m59aorlQY8/vE3ovkBvC7QwhnhcsXM9z+ST0Gef4T0nfwaF+78mFx7qWGZp9n7oTq
	D99p4xUQbzJ42TQUNZ33eZTvzE2FcAZPFItjVNnvGlT61OirVBSdXNLtpzSyKcUl3d5/PP50Zcj
	aXC0n7dmz5Zs8cE69ASqg4fFQVxpp4dzFftS/6s5zO7CHSl0JaKRk7jtp/ArnNbPIIn9M=
X-Received: by 2002:a05:600c:3b20:b0:490:b189:212d with SMTP id 5b1f17b1804b1-4923f5981a3mr4866425e9.33.1781800083483;
        Thu, 18 Jun 2026 09:28:03 -0700 (PDT)
Received: from arch.lan ([91.230.98.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fc47720sm2706855e9.0.2026.06.18.09.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 09:28:02 -0700 (PDT)
From: Tomasz Duszynski <tduszyns@gmail.com>
To: andriy.shevchenko@intel.com
Cc: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	m32285159@gmail.com,
	nuno.sa@analog.com,
	tduszyns@gmail.com
Subject: Re: [PATCH v2 1/2] iio: chemical: sps30: update email
Date: Thu, 18 Jun 2026 18:21:39 +0200
Message-ID: <20260618162139.124562-1-tduszyns@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <ajOXKKDWrTURPpro@ashevche-desk.local>
References: <ajOXKKDWrTURPpro@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Wed, Jun 17, 2026 at 07:27:15PM +0200, Tomasz Duszynski wrote:
> > The old email has been inactive for a while. Replace all occurrences
> > with the current address.
>
> ...
>
> >  .mailmap                            | 1 +
> >  drivers/iio/chemical/sps30_i2c.c    | 4 ++--
> >  drivers/iio/chemical/sps30_serial.c | 4 ++--
>
> I don't care much, but the cleaner approach is to have a separate patch
> for .mailmap and put it at the end of the series. Otherwise it's confusing
> that it's related to a certain driver, while changes are applied across
> the whole tree.

No strong opinions on the change itself, maybe except patch ordering.
I'd rather see mail mapping update placed before driver changes to make
sure it is visible if bisect ends up in the middle of the series.
