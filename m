Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A67F304BDF
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 06:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781071421; cv=none; b=jxrJU6Et3DGb9iDNtZizqVxG8f/vxDY4BJXYHvWrxfY8pk8aKjB+t9mBApgonvF3gbZuO0MHrb6ov9q2KAkhkQIS2uI32hOqrhsdgi0yH1PtE6yH3pP0S8zlUiIYITeJkfLJvv2ahpjy9KWR3j7FSmVOg/rMKbeK7dhZdlXckoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781071421; c=relaxed/simple;
	bh=U/S3I/hhcX2w2yldzv7nWi27s4GvcwZGx8KdYMdU/ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fik4O6kJze5aUMoQw6PF6PGbDhZD/5DAWtkC4VpVOXjiAGAZ0uIVILvQr77xSeRLJUL/bHLTmK7miyyIN8DNW64+TQSbUVbpFlwthcMRhOq34jG0gloFpGoc9Xw5i5dKouvsCVgYOg6+8NgJOIQTxWWSBZU3sX5CqVRpHKEK5jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bt9lP4rD; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bt9lP4rD"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45ef41adbc1so4694674f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2026 23:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781071419; x=1781676219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zp6TdQ1zqR6y4oT8Xzag1Tfx2wqHJYDgJIq2iiOliLo=;
        b=bt9lP4rDCZVVwn+ZEiirTvW4ZcT7Ac3ENueti8tVhxzFmyhnYMksT6D47ooZpVr6yv
         Lj/8ZK8qhf5NGm5EeBjknAxzPbA5VTF1VT1NJfDvGksSj6vqNAh/JmuVN7xnsd0ulCcS
         AcpRxqK7ib/6IGK6CddIsAOXpHJMOLYyWCcHGXhAPBpJHOnH9K1hcR5HyNoJRNgeN4cz
         hgBQf7Hssak6gFmdKmLq0xK6yH9HvijQcsArfd6+/eU4DA6sMF2Uez5HKZDZlC4Dwecz
         iflP1yPwUVPO9znUIF3HQTvah8C22hNpIp7rZXSMdoiPqQg9gG+AZaTY2JYG9s6VQELd
         RW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781071419; x=1781676219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zp6TdQ1zqR6y4oT8Xzag1Tfx2wqHJYDgJIq2iiOliLo=;
        b=r5kgqsanVWRFsplF8P7Tw2AOJlaatx5M0idUS5Jbmew7O1gxXR3DhaWMWkEsRKVFQz
         HK/RTueNNw03GbbnICH9LDy8mcDaOCu45hcvvnE5XJEP78j5L4GTF/ILahguyiSG0sLO
         y+J3SejIu0UtZf/9501DwJULspSB3GyhtsJSADOigeObtrzeLXB+nCCMRZL63ZWWUKK9
         KREIx5lYTpm4THzaCEi0IgdBWH4XfGlHvb0iaQ9YtdG8Vi3XrtDHCffIco4L9n1oGXHM
         bogANp79nQxdXv1d4ul4sWO9p8xckdO3KQWxzM+5NAi9BCrLJTsSVgzaRtg4GmACy350
         4KLg==
X-Gm-Message-State: AOJu0YyyV77b7gyf9CN8rPEbUSvood/V1PCT64tjpDdJvKGxqgMNrXrB
	qJT20eDgpB0Iq96cfjFhU2SlNoG/Omm1mTWHxmLGKj5DVsMIF4pHdo2UEM5LyA==
X-Gm-Gg: Acq92OGUxdXefARD1Wkok3ZraX0xLI21eQioWPjV80N7K1a9fWayV0pDbONg3I92gU0
	SYpIapjKxyb9kmEKpcM69UWasyePjg4wtdx46UjmI1wz+qC2bruIANEqg/I/4wtgKVVfGhkkpkz
	//dDF6gO0jJK5fNEE3tvMndjFgv+94mNua/+aw6Qv29G4PyAa9Jv5JDYOyO/7fHypSSsj4so7HF
	sFBaeHtOoLbWr7GlmyLlLKYeWe+hF1GAsNd2OOSkeVchRH8fueGbgErv15Hh4LgRaFWdzdnDnlh
	CVppORHZmfdo+1gnF8iHTc9hT5e9Wl0arRyhMcCSnpQX6TOW9p9vRJB7A86MPdveveNq/9rMC3W
	ajNI5xF6RcCqFVMpC6u4a6rRbIKUXHc2RdtVz4CXRB56cEBHuet+NGQhvZFIrQzYmopk1yw8dnV
	kWCaWcWD93+oRtLedEvbC0ZP9+n8asb+NEBdS4DW9vTc5ZgyXhFTivs8i8yYL2uQLUzfoFWAA+e
	I6hMLBJeALFs9hntzkmpvRKM3UW4/XIq85RMmHh8/hBGZnB5WD+mohNYACe6Ys9lBjfu0g0gDgZ
	BlzAGFIdc06XWYTRKlrqftFn5xmF+Pk4f8Mnmmb4h66vgSci53pAPEx4wNvSFj9xUTItyLYLZdZ
	7
X-Received: by 2002:a05:600c:3f0e:b0:490:d38c:7836 with SMTP id 5b1f17b1804b1-490d38c7867mr133818815e9.3.1781071418967;
        Tue, 09 Jun 2026 23:03:38 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f34413csm67753321f8f.21.2026.06.09.23.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 23:03:38 -0700 (PDT)
Date: Wed, 10 Jun 2026 08:03:36 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: core-trigger: correct CONFIG_IIO_TRIGGER macro
 name in #endif comment
Message-ID: <20260610080336.00006388@gmail.com>
In-Reply-To: <20260610040501.204967-1-enelsonmoore@gmail.com>
References: <20260610040501.204967-1-enelsonmoore@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Jun 2026 21:05:01 -0700
Ethan Nelson-Moore <enelsonmoore@gmail.com> wrote:

> A comment in drivers/iio/iio_core_trigger.h incorrectly refers to
> CONFIG_TRIGGER_CONSUMER instead of CONFIG_IIO_TRIGGER. Correct it.
> 
> Discovered while searching for CONFIG_* symbols referenced in code but
> not defined in any Kconfig file.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
