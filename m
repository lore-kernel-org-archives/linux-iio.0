Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DC63290A6
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 08:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777019024; cv=pass; b=OM/jcXPP2ujBjg3FNVl8dJKOJ3VWGhX5ILmAoI+m7NlUot4LZp3tKLcvVw/I/eMV39pykuwXouabKcxPajuj9ExgKM11YZe2gRgI+i0d/pFbogrCCuKY+PUK6DMdhTeFsCpCLRvf2vrDUHQD+437bXEyWZye4zUon3RuvUl1e+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777019024; c=relaxed/simple;
	bh=QofEkjd8FMH5RFqe1MHBSi4gM7v44QFHJL+ngo8T/Jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WxCjUneT+OOk0ptumvHyST8eY46TidRCZ1IdUznhTg65e8H7HYyPO0/rjdMEqyduRa6wEUkEl51yDt+RNAr2UQ4AOaW10F35hzCD9KEDuHlax8qV9W1J6Ue04fiekSkowCVphdzWQRY6kA0H+bya9aFhJFgfttzj7yRuUEP6H4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJMhwHeG; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJMhwHeG"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43cfd1f9fd1so4631531f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 01:23:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777019022; cv=none;
        d=google.com; s=arc-20240605;
        b=NkT7rFVNHseBqx4plz/gP+0cR9JAWFCqSN27e/b4rYMwqMe8g3N6j00q59oenpAMCk
         JaPMoDz5hxVh1XH4OicBJaYiSnC8f684kaqzRWy62lUrzv7hWo0lUY+iaJpb04k5Y6Pd
         rRhLFLHTdKfCCjJpsTCeYVdsiKmG96//YtZmvGp4opMawZ8nJqWS8zBQ63w4DUJkzqg+
         3JVCSTf16hiaBdg0Ejz610cXSvfBG28JvAfDMw7rKn8oQPL4Zqawu4P160Dceq4X3tVO
         zyoKvySeGnRQawjswMm5Cb+fZtZ+N2NXtK2HzA+tdWanjwDWrDwnMiUuVRaiGDysBKCp
         pzQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NbjBm5UVHCZcVvdf0NjFPirO3zRx0wYmA/bGZ1WxQZ0=;
        fh=wzoYY/xZ6VvyOgraTZdW4zXAoPn0IFVHgwl6YCQc+/Q=;
        b=Y8hSlrh6GLd5oee/2hll50wYs561zurA0gDWLmXTiteSGIu7r7fsbmU/GcHbwn00LB
         yeJZiO6SxIHnDZa3q4FFpj+2Fp1kguSdR5rfaNLva5zlWvlqjWH6JpyEg/ofzwjOpCJJ
         ACfKz8Db+86T9fN0bOsDadMeXhZ3VH5qUQjCy7SmBU0F3FOIWkAgGsovFHxIvtgOmCqh
         z/YhqkLlSXj1YjwqNchv2/ZXalIiBbnD8w+bzFILbn/jJK+EXqk31caQsx/0QQQ41SC4
         i4v1rlP4fLF9daorXtjfoaHE8sXuIXTFjoJhg4tVB3vSkkjZhpzXwivPcJ7A6REe8cTw
         edQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777019022; x=1777623822; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NbjBm5UVHCZcVvdf0NjFPirO3zRx0wYmA/bGZ1WxQZ0=;
        b=cJMhwHeG75umJaAMoo881MvsGToHZUzLXd17RVAylVlVW/WNjV4+1lYZq61K0ydaf8
         0QcWw3BmG0ZqvUgD5bhqi6e8iEDaHXi8z006Z13+Ja+7nj4T/j3GdZiuT5xztx9K/5ET
         TK+L66Gr7OXNNDWCxtZHZ2ieeywLtRpQXr3CFz36bcmY7smwk7DM6g/AeWBujIPP/55R
         1YQVAO2F6ZIMJUI/tcsZKJ+Qw50RypCCNAchS3aV+SUXPhR8RZZci7PrfAeAxX5q8reb
         M51V4y+To3eEzpwt0mVEixnUsGySVfTFRX3lKjyWe4k+PeY/d+XO+XiPi4ofrQqQv8JH
         kIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777019022; x=1777623822;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbjBm5UVHCZcVvdf0NjFPirO3zRx0wYmA/bGZ1WxQZ0=;
        b=AVL2SznRxe6659g7mNlQUiZrYCGrj+C6VEePUEkC7oX8dbVvfw0mEcvpIeM7asKU7b
         QQMnOjjPZgmdn8MhuSLFptBys3qX3Keg3hRHrgWQyCQRvzgSgsuukRmrZ+olv8kNdcir
         2XraO2rvbePVVE2xemwyCJyvVKSQuUNbPX4agw97t5dJL/TdMOXESYWaaANgNbB4bnxD
         leGcx7951vfiFqcVbsPg10n5kFpQI/cmJd26mufefALV5fJMo/gSYHhwb1x1ZjwhdC1n
         jU0jMDQNGPipR2UFHVHJ/LbOLsTJeb6tccNpi41NdokANbYDkcnSpWc78G7VBUkacDNl
         wEiw==
X-Forwarded-Encrypted: i=1; AFNElJ9dzJC7Kh89IIXhcJ5PL9ErbYbgSxFqCoPH455Zi+1fzZAD7nGrBcMwAMJ0p17JmMkrZqVC9W8P6cE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOaUIdf7gAh+arYZv5KoZDiSc098wOKu3bcai/iUV6itWALui5
	KCt4fjUV2dfgY953brv2cebA2pfMy8SFqqyVAtelzKd8tW97Epu/yekGL3p7e+qq11/7zx1kqI5
	pBZb73fhLH9BTRB4IXgZM9yDH67GVepw=
X-Gm-Gg: AeBDiev3YwaqZ3DhvY0ReJtBdACkTg/TH2u0yX4Htf7ICX7irYLJHgYPEfbnM7FmSau
	YfRJU6ecI6xPEa2arc/06IqsZdRk7qmkrt+qFVeICmTiurguQoxAWMiGeZmWoKFCFyrI7JRJL3g
	HmHwvUrt+GQ4YCts6bvzBrbKGvV2SeGe8jBPtLWt2eFWhdaYU4byqewUpvmXNHsgJ7MMCtjNMbA
	wLglnKUV6XRX0otOiNc1WInlrN/QDGjSDr1QPlZxrxFAX82gDJpPuLF8x0WdOglWLydA4DtbL68
	+hu2QbHbOp0fIquuwknp4k+JZ/om0YYvqHewfWBm7qXya/MQYrFLKR+DdJnq87LeMVc9hCKpWod
	aOIsX0t0/JE8lt7Reusc4DNBlk6FjVXwH1PNdp7d1spJkxV76PA6dnshFVsJdh4P9+p7xWDmJYB
	BsTzm0XIFWYCkN2imw
X-Received: by 2002:adf:f34e:0:b0:43f:e42d:ece with SMTP id
 ffacd0b85a97d-43fe42d0f73mr30050235f8f.1.1777019021449; Fri, 24 Apr 2026
 01:23:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422112207.1313-1-joshua.crofts1@gmail.com> <aejKKKD4JdxIzlk0@ashevche-desk.local>
In-Reply-To: <aejKKKD4JdxIzlk0@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 24 Apr 2026 10:23:31 +0200
X-Gm-Features: AQROBzCjfq5y0fpdv49zdWxO4g4o8sfnb03ky10FgAbYkOAMun0WhJQ7MCGUVP0
Message-ID: <CALoEA-w=N7ch67R+DgdqCrSy+5GtbuGkiAbJtnf-9c=Q2Mb6CQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] iio: magnetometer: ak8975: modernize and cleanup driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Apr 2026 at 15:16, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> 5 out of 6 are good, one needs a bit more as it's a new patch in this version.
> Also, wait a bit I'll send a couple more that you may incorporate in your
> series. Btw, are you familiar with `b4` tool? If not, good time to start
> playing with it.

Just checking in on this, since I haven't seen any changes on lore.
Btw, b4 really does save *a lot* of time.

-- 
Kind regards

CJD
