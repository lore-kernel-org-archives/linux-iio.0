Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A491D18C332
	for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 10:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783852476; cv=none; b=NPtPJYJZZQjGV3zr9CerpJQPKGeEih716hu5kvuSSKI+qdlimkERuTEQUY47OnhY9xGDZfbnTB+y092IHTDa2jEaFs8hsQ0UqUv4aBlZhyFg6pW+iLbS1RwMVgp0+dxf1veQRfc2I8kgsXRUc/+k0B/9xVR1PLn1bfzQGrqQPBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783852476; c=relaxed/simple;
	bh=k3iQ7k7CZ/fc8RVS1aBldA+0Cpm0GyNkzfs5kTyJpyU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dA8XULIjkVGX5vv6qIXCvr3iMAijH+CT11PAY6ClYnBVFAPGbiFF+URvw85s57cBmAK+UMsdsgJtKxIKilpAQk1dWHleL4mgVDHsib1q+ZZa09uKLvNN2CFdh9+24YpMYDV227ZrykWnJPfm7A5dGX1L04DAJ9wHDZR2ugAGhhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWu8u6bt; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWu8u6bt"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47362928f65so2198856f8f.2
        for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 03:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783852474; x=1784457274; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cGH0CHldg4jiiPBZJVYaKTOv1+yLE6ScqD49SVU+0Wk=;
        b=KWu8u6btyrTBUGiXxVBNYJ1GzR/D9GpyUG4pQmq5Bq3fs16d3Oo/5KqSyso6BRf3FP
         5IwZIPjq73V/r8iXuw1IS+HMe875MAXQEYHmLa873hWXnM1qRoT9/nlDH0WsXWnU+UFL
         qiylU7Nss+Ceo+vKJ1R+bsGCx0HGqS0fenYXbnuxTh1RidZo8Z01BYqxAk/6tJk2uMhw
         Jt3a0/475Fsd7GWtHMro7b1oTWY3XfJ2MIf5ewqFJXbmDJZgEDq/ZYTvnGMnBjqVW1+q
         lOXt06+NaPmPYr6Mwbf21b0AuDgJy1mONT/JtcNd6AOPSb1qp0uYtIW2t3GAYt0+wYDs
         VkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783852474; x=1784457274;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cGH0CHldg4jiiPBZJVYaKTOv1+yLE6ScqD49SVU+0Wk=;
        b=IHxxwEoVFL4+aMjYlN9lk8SNjnBksWaFVNaEXOK+vh5qONiqe2CBrs4qVrANJ9xXAu
         6T5h7ZhkVmTefZSKvlrBmGDVjtpJblj3RydZFTMlr1GIqEtN4LnHNFsFKsmh7h+lvYqI
         esBPZ4cUQz7ZN/sHHgPvAlnEN8fPoEK1d+I0rQC1EUjR+j9c3vUsGLmbJyfDiSyAj1OG
         JSXDPHYK2GIk44FPzvJmioYnXKeub1+FcipUw/dZDCjbBMO77DUILOQD9tRQSyMGvIL5
         J9e25jRLrjZa4o4h8NNaHRvk/g89QKl1OrkhaIncFgfYDAYgggsPDLRrDLNgK4DZfRUL
         NImQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr4z19wYl4SHxpK3pLv/RvgCiT/QKtaWnHi192a1iq1dcoZ/xO5LRWE9B8Zi0FDUr8VggIfufXHPrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV1zYSPkpTPF/HIS8EL6o72UXpx3+Nz9+dO3eiqZIKv0zYDdFe
	1O5IzH4a1usG0NHTJKV3kEzQViHdasnFeMyTGTs9tBh/fml5kb6wFz8+
X-Gm-Gg: AfdE7clntegBkpIXI+IS8GpL0t3q7aJnr6xVm+fBVen17oVzqZ33VyGZx/XGehouexQ
	sA4uIK7tHC42Z08BqHaUqoae2r+Ht25gVHEgPqKlB26OtcSVqpZ1uSKdoh7TmUh73E5ws8le+yr
	S6jBIoOCyZt9Y62mWwlNvdwQcNnuvNyee/PQQ2yh88UaWfcO6sqVyRPq1AurkqD+rV6xzOffidx
	F449PArhGy6LL8YiAcuwgFA/uAhwKY3S+ThdxWyKj+gucTYTwbg6IQBsM332/EcXhlFr+GDX7tk
	wwQ4vcaBYxKQ8WfpF/ls5zLPrPFSEKN6p9xP4ek7+jRry3Gry4mSjknRQqFNfYEpKBmnZrV6w8s
	TqE69fBsOKRLYrOu/qgA8QzOHXSngGOA7/AcEvKvyZ5YtDdgeVuNEHIrYagFV+Xlr209vJSCJw1
	Cv58USjXIaiokW/CSOfJ6ANhJwe3kaJJZrAXZLIeV0wOPwZ0Mh4PXCkjbSh458UKXGuCcAKOg6M
	+mqmCcTwAVBhxqEk2aYKZ1he7NI7Oi0fSPTN/vtyh5CAKRqHZsupMnKFG2J7kA3zbJR4luqQ65d
	fNzN6dM+rIx/IEWK6XwUnlDmv8v8qvhsq4roDNvOU0JWigEj6g==
X-Received: by 2002:a5d:64ce:0:b0:47d:fc33:df0d with SMTP id ffacd0b85a97d-47f2dcf78c3mr5789388f8f.58.1783852474054;
        Sun, 12 Jul 2026 03:34:34 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039af67sm84880696f8f.17.2026.07.12.03.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 03:34:33 -0700 (PDT)
Date: Sun, 12 Jul 2026 12:34:32 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Cc: rva333@protonmail.com, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?=
 =?UTF-8?B?Zw==?= <u.kleine-koenig@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] iio: adc: mt6323: remove unused header
Message-ID: <20260712123432.15e39bd9@systembl0wer>
In-Reply-To: <20260712-mt6323-adc-rm-header-v1-1-d96395d1a323@protonmail.com>
References: <20260712-mt6323-adc-rm-header-v1-1-d96395d1a323@protonmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Jul 2026 09:26:36 +0300
Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org> wrote:

> From: Roman Vivchar <rva333@protonmail.com>
> 
> Remove unused mod_devicetable.h header.
> 
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
