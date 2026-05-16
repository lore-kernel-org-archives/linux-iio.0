Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A278F35E957
	for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 22:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778970633; cv=pass; b=PRrHyrodtu5MLCQgpwyngYDWWtzgM0n9gZxR0r5xKVPzQ2oA6gFcmhsN2j9mAcRBpfr/rfdq2ADKZahhYyxV15oGhRz8DK7m5M1X8EoCZJJ4SRKEW95bIYjYXRlk1qN9LEdqJ4qjWKpybwuN/T8RMc+z3/+db31x9MaX+F9PjPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778970633; c=relaxed/simple;
	bh=4N0XsN0VuRkZQnzr3+qSDKa3Co8A1IW1OZR2iyx6Je8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EGZSXQuYKts6+kjuhdVcUJyzPQ5A1XrvU19L6ItqNBg7EpuHnZ3sfLA78JdDzgN6WJe6KQiHeFkJH0jlM1JZSOxYZYPbqJ/vBG1aghttWH0IOEjAcuB+b5JfwkBT8SQmL/InPMmiEdkVr/5FiBPsr2QjExqWlb3zomqTwRFoVTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rQ12Tt1b; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQ12Tt1b"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-453903ee4adso794339f8f.3
        for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 15:30:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778970631; cv=none;
        d=google.com; s=arc-20240605;
        b=Tv4opo46C7iIwQzCQALrfMrZvD7Gm2Rf0o45LbT8oAy1IWKxmj4CVmTMhz+mHp7Q/c
         zjdCah7pyy/uakuk8cRFg610sfIAhMGS6ETwS2Eyu7sk095+e9YJt3ZLliXSNnPV+I+c
         y5FOx2NcmAyZu1dOGg7jLSgICR1xEjnxshC+6l0cMIHglkxISuTMDkaJclqrqxgpErjB
         GyS4kRH36gHzjv+K6ea+SjKGBUbc21VJWiSf3I/w8TZY/Kv7Hp3GDwbivTh5/WyAgrAq
         qNlFa4haD+FNLfy+T3iDyA6d6nzCL2e+8Wms0HypJdFYJti0Lmyxkd//cL2s+Vd4VFfV
         vEdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=y5Yq0JJQpBu8DnC+ofcLBs/0uhKdeHTP9RImpArBW50=;
        fh=d15LiGqC+DGWm8FwfFF9RucvIslvpdvdldVFKiNYn6M=;
        b=dB0KPhw43IlIO71ItQF8JDvnyGU107/tFvgV3jY9NaDzOD2treTNA+zkEP85UrE7vs
         Rd84nadvZ8rI/a0E7BtU3LMjGZ4wP2PWF/QKGONQwDqK1R1unLdmLYSbiykulGMR0PiM
         bzlkq+tMXrz6x3SzgAEJu2bx93AynujZpVsDRNPy93NqZzy+4i7ttUdRUfREypBB+tRd
         jNdEvZRiLSmkkwNlBsWTjdvIIHcWwIpIZ9ZcQC6XZvQcWfI7/jZn0MUBoubhLk5VECaO
         0kbYVcpIxbvz0azFOroxGeTdIpP+UKWybzhcLkCQHykhG+xnUkpYDYXR8YyowP5bsEgx
         Ik8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778970631; x=1779575431; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y5Yq0JJQpBu8DnC+ofcLBs/0uhKdeHTP9RImpArBW50=;
        b=rQ12Tt1benHreEIJaKKS8xYQ8sOK/FiRHbcYzO/ntzsNWfdlikKiOwRFJH0xP7V9ZA
         nc+k60s0xHsEjXGj1XfNfJlzAGVKiyFq7qbGVfzBzPJBbTasCzMI3dCeMgkhxN+QdzvC
         K+v6768fNki52cJ94OOQXeq70gF1kq3eqY2XCAougjaOdf+NZumI4fpd6nW6KZ4Poul8
         SFy2CxeV4DWSLxiY2VkFeChD9/kUMCOyQSIsoFmTtZyAnUvzUDuDDDDU1ZVAEytu/LJW
         Ll1WzXrYLG0vygugUIs2YaVHwXS7IzxNwfw4/Xe68yOdhZ9D0YqEkimDhMCM1CR6mylj
         Zg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778970631; x=1779575431;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5Yq0JJQpBu8DnC+ofcLBs/0uhKdeHTP9RImpArBW50=;
        b=VLpYQSVFf3qvgJzLuPYoZzoMeA6f4K4lCVFxxhBp5xgjC9w+btd8AjjJtvFpNz2wG/
         4OqbzJrRZVRjDiu4zf+xJMiLPdJC3HmCfC5TTMFkWWsdITe1vZfq2Hc7bsQyo8qCBmvh
         KOHfT99Di5b0d9bu+r5zOyWIUHDYQ5ni0T6wktqdsTeC+vToE8LaCpdFlZxpVahybWD5
         NhCR9PLmh83wKOsmICM6nqbrSdocE2z4yzvPRWD+9+DHbQCiPHGHEFSTlQ4nLm/BVlMR
         5N51nrKvWLIfszwufKXPnB70efaWfdf1n4KLfyzx/ba4dT5Cg+uww2ZTa6F1KAXfsWfe
         PkhQ==
X-Gm-Message-State: AOJu0Yz84cLzJIiV2q8HshOJ7qsYcHd3dJQn9/noAYvW2zWh60OVp1BA
	G1WEgKbjVburBaQKSxxnMkz8oJeljaTKa0EHQaZfr2gNH+gpbKCD+BXPr+Pkar+UimaRAX28Z6Q
	ta0JOH54tpwpimJxWOagmEckqQPCsgb8=
X-Gm-Gg: Acq92OGiurJjT0ilP/B6GBxg/afxaAw89g0ev2Rldg8xFjtP90CunsHW5ixYks6QYe+
	axJzIF+pDP9aJyQ0Dtb7WztWB3yTkMNC8Z05ca0S/ZXMfHgg6ZzSAbK0ow0HSgNe0nIgkIZR3Aj
	zu4eIPNfFoOWDRmxRSrJa3mJ00IbXO+oq0gMLd/viRlJwyNx2nU+h6jqlW8YwkQFu8KZieQZV/f
	ua+d5pE7O2rJecpM1NOkIVND8YSsU+Av4qWX65BZ6v/t6Huv2Q0xPXRGeg07ItiOp1XBZL3FJiT
	ldsx0GjOCto+2e3MCP9CcIl5TSDsHrDBMcLIFxhOk0aEqELf8g0OMdee3kuf0iDMAhsBnTDvnpK
	6uQ/KtJrJfhPrSVw6ECCA7G0hBJp7/Du9jRV4u3i+ORQhEoCa6A7a4ofv6vZeilByD7IIHNgHRy
	QCE0Eogj8=
X-Received: by 2002:a5d:588f:0:b0:43d:77e1:6a69 with SMTP id
 ffacd0b85a97d-45e5c5a4dbdmr12881250f8f.38.1778970630729; Sat, 16 May 2026
 15:30:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516-veml3328-v1-0-1d4b663e2fe3@gmail.com> <20260516-veml3328-v1-2-1d4b663e2fe3@gmail.com>
In-Reply-To: <20260516-veml3328-v1-2-1d4b663e2fe3@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sun, 17 May 2026 00:30:19 +0200
X-Gm-Features: AVHnY4Lpol2xQpPg-FvHpHXw4L9P-zNi4t7sdq2UPd7AtkX1kD3dRlVETsYARkU
Message-ID: <CALoEA-zCjGUnUfjUGLKgET-Vua_6MpsYpYWPfGf5xmZhBipCAA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: light: veml3328: add support for new device
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 16 May 2026 at 23:51, Joshua Crofts <joshua.crofts1@gmail.com> wrote:
>
> Add support for the Vishay VEML3328 RGB/IR light sensor communicating
> via I2C (SMBus compatible).
>
> Also add a new entry for said driver into Kconfig and Makefile.
>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>

Oops, Sashiko pointed out that I'm mixing goto with guard, will remove these in
V2.

-- 
Kind regards

CJD
