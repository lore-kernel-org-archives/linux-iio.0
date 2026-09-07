Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E084C0433
	for <linux-iio@vger.kernel.org>; Mon,  7 Sep 2026 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788793465; cv=none; b=WZwAd6+CjygfOGRPDJr+eO7mBgXbU8NuxswkT7pGIp5QwH5rSIWo11T10cKgcly2N7Km7mGULbBQh/U4xkSLGNITbjRzCrTFEuXBlN6f0A38DKhaJRcsTRMeaWCILEBF1uknoGaoMoeuKXttus0sVa6B1ItLgIaKmtdLPm5DQLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788793465; c=relaxed/simple;
	bh=KNMVQC+0iDccEpQ+h2CPp+7RsmXBgouseN3dW7gRxc4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJleIRZHequJQABFPHlYx1C/QpMnpQP+ewL7CZ0tFGW0BA0Vk36SqojV+bOha1P62FWT7Nz7vkBIp0C5r6MfSexrf6knL6l0WNeJrCa8/l0lp88ae21FiMJnAEHUvEOghvBYh3iR/Cu/YEylmHkRxMnBPUqeIvQ0q7ytRtRDyeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFkNTvvL; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFkNTvvL"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49d0726ccc2so13997495e9.2
        for <linux-iio@vger.kernel.org>; Mon, 07 Sep 2026 08:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788793462; x=1789398262; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rHozVKxaETh27XlRQJCL5N6I2hRb8EdRmazGxj/Cnp0=;
        b=DFkNTvvLtBQOQ4BuvIB68rPMSCDqbcSlk/ROkIIC8cfY719oZ0LINbejNN+Ro/3Prv
         RYmOxJGWRosXpL+aFsIaDOoTdhuy+LJBibJ37ZIP1gyM10FsrL2czULj+LLrOEvCRE+T
         iEzKb0mPiMPlH4p9q+tqOVPXXZ5dXSHXEKTapYlvLxBWsJdiRU49TIQ3D3JwXcwkTaog
         rCXIBDyip6mNdcUvNFyOLdiZOAhZmhg2ONcLPP5xK5pmmCwZXVMx/w0+yoKvwEDnSOT0
         F5ag0BHA3TcOEOdAJNUkhsuw8qmzVSujivXip5C75s8CUD5R28yJx8jEm1fqFCnPsljG
         uoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788793462; x=1789398262;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rHozVKxaETh27XlRQJCL5N6I2hRb8EdRmazGxj/Cnp0=;
        b=Y735I+PUfUQdBgaiayw+Nocox8i/y3NM+o1XD9yl8MmZD69r6E3a4MCSygC2RwHieC
         F6wpeU2T8uu1bxbhzfjGjya2uVA9PQR9FpwrFUVrVBIHs4lY/Juuzegxbb2LSW28t4FD
         u7zQa7WZauRlRBtXmilcplJv/lX4b57R7we3ZfM+25q1BgiGdBxcUaG3GkLH+ggoVGQ2
         jbXw6FJtvnRkDDvtojzAcQlLAw123Hz++9eIEHcStejngRyO+18vicH+pngPO1GWclgw
         LcLnPO2hF04WTKz6i4RK0kyRl+ewXoe3bN/nMu/cjgPZT1HLjBN94UwWtgDeodxxKvRA
         BHfg==
X-Forwarded-Encrypted: i=1; AKwUvBxVclp7U2DIrVjNDSQsRGsSui5268qyEq+iXmxXpCEkIXNSHkOtNRk6ksvb4etJg3SOMrD09sGJCh8=@vger.kernel.org
X-Gm-Message-State: AFuF++kqLxfVjkDgn6C0H6A/f1ZsG+TrWwWKp/WXHQ1Q77WG4p3zHADO
	YzEQTYJKLTmcJFJhB4EB81MSBkI+h5rkKLASReBOCl2rMLS0kME4gYzT
X-Gm-Gg: AYBFou1EIv1M/x4RroU+qPosSdhT0q46PJoni4r9felb0YTjY894T2xrgrIECcsAYpI
	RUly2l36q5MeE3jH8Z/LD0SYDFhLVM31XMH3Hk7U1uMYg2nQbMx3FXwiNx0UCQYUVWoqBX7UQT3
	SCbTVWiPMmsnHriFPPGh9F6qjByAjcPnz9U5VaeQseXWGq1DNBfvvo4vf4/21z2TVDBYjIvgVUT
	F0vk/gauKF8kHYei9nLM3KnmXp80Y6plCmJCyKHy8B7B91QSgxGCipjJU5/jPEaQYiOw8Kebwu4
	qlW4RZkAxrfTABhzLTYoAZB1qwyWrnRZO+ssFzdpAsbQyBcPT1QSKDz450Lmxd0V9FF6iCMbRXv
	5IAvtNYUV9JEAzUBYekyv6v587TxeAnP3y77mJhEp8snEg7U19eqJYdRwgzWQs3s8QHfqjNpZw0
	0dNA00AvoINEnLdXknQByEcJcMP6ZH7oFU9ldGfTPl0K7fWMcM8bISHUOwOZtcbYcxK0485njjN
	wPHsz3pJZkrg+ocGu75JYFEXQYtFaOd5cTgJy8upy7Uan4InWkZ9ApjNO5Q+nJejQtH8xvqSV/p
	K5THUNoTQK5vzQhQad8Wx9bAXQ86VIn/dRpRTlkSWYSce0UkDn+QvMxfE+GBnFv8y2TeCeANqy0
	vf4Q7jvJmmS948oWEViFvBZVKHkniJmLP6ceJIhu/iofGK4aHTERh4vePNisOfs/P78nFXA==
X-Received: by 2002:a05:600c:3d92:b0:49d:726:cc9f with SMTP id 5b1f17b1804b1-49d0726cd2emr281885525e9.5.1788793461845;
        Mon, 07 Sep 2026 08:04:21 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7736132sm310592495e9.12.2026.09.07.08.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:04:21 -0700 (PDT)
Date: Mon, 7 Sep 2026 17:04:20 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger
 <martink@posteo.de>, Sean Nyekjaer <sean@geanix.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Martin Kepplinger
 <martin.kepplinger@theobroma-systems.com>, Christoph Muellner
 <christoph.muellner@theobroma-systems.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/9] iio: accel: mma8452: Fix unintended comment
 indent
Message-ID: <20260907170420.00006312@gmail.com>
In-Reply-To: <20260907-mma8452-open-drain-v8-5-c17407e22118@geanix.com>
References: <20260907-mma8452-open-drain-v8-0-c17407e22118@geanix.com>
	<20260907-mma8452-open-drain-v8-5-c17407e22118@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 07 Sep 2026 16:51:00 +0200
Esben Haabendal <esben@geanix.com> wrote:

> The extra space this block was indented with looks quite untraditional, and
> does not align with the common style used in the kernel.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
