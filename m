Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A3A1D63F3
	for <linux-iio@vger.kernel.org>; Thu, 23 Apr 2026 12:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776946723; cv=none; b=JPG7uWEDj3M6JF34Zl31CH+yQogyP3niXNT98CnRJTB9xz3VsZ6dE9+tW/1kWi7UTprvb3uQtsopd0xHPZqxzEj/IWPGxivqnRZM5QXVDlE7Km6tGWXBnI2H3VT2crY6G+LZCImOl4qP7JFgIxzVeF5T0/9292KdUi4gaUt/IC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776946723; c=relaxed/simple;
	bh=Zx3uw9D+fTa/jIj8OsgybVssg4Q+lgPNAp0XNpRwRRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RZp4qmf9audFey0FG6jnk85youzhPC7OoGryxmvSp6t2TGnTAJf0ByOugJ1CPbWlP5IlJVU5OWlZFmdf0+inlTTXKP37XTJ+nDsraHBjcx4/KeFpSYFv92FR9obWQRTIbx5tVqDBGxLddePvdSs6IYpANSOO9tUrU2Dj2DzWxHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M28591iQ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M28591iQ"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3614826eca4so5965796a91.1
        for <linux-iio@vger.kernel.org>; Thu, 23 Apr 2026 05:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776946721; x=1777551521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tyRQHJ4JEAzDxa29RX3a/zAFFHEnHY4sZmNEKAG9C20=;
        b=M28591iQ7hoQmBMdGz6QBd5M6DrFG0MHpG6Dmp28N5YBepm5/uX466q7Ig7tKBIRza
         yk3SOw+edjolq9vt4wKvzxBaA++S7A2ZmpNrsEGWJgdDqMiZpGJ07yrYsS7uOhYCr0Qj
         K3EOHcouFV1fLvq/F8mgGMZP2PM7Qxeaue5vxrTkTwtMX9epE8D2sPFQfJguuekNLaHp
         vgpXXLx8GxYqH2NH8hN8IvsIXjNyo5wR0Y7hAr2uYfdkShIyJSVNdLszWZgt+W4NYC1H
         Uc64IH/4iFqrmGWY4b7vui7IjakkQJLA2UHtiYTKYD05Aim3+2ZWdJbYE3vynVbj8+KY
         h+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776946721; x=1777551521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyRQHJ4JEAzDxa29RX3a/zAFFHEnHY4sZmNEKAG9C20=;
        b=RECEHcY1Wnm7BNfAvhieAtBDksvB73guUdYLuPssfDvkP5/ZT0MlqIwBir9DRyppq2
         xVjClrJK0NV/1c88M2DBc7WKBrEkkF6RTb4/dnKNDqQDSTl4T+r31PInee/OntgMy+V4
         rKIDCzTnLsl8eWGnbjrn1KEutfTbgjj5HyqrTHftKTlHseptWS6bGqcgkG04hzd3nGDR
         MU51N24huLB96dy6Ns2ncJ33dLQlV30ds4uLp3wg/IStXpkUfNxu1lSJIkjmx+JQ4L45
         k/wCk5zXazO3Q1gpXNVF8JwxlsUN9Uj8W3qn68o18mvhzVpo/SLITx75fBWR1m2CmqrK
         TEww==
X-Gm-Message-State: AOJu0Yxxu67xXqlsPeg/6drbz55e2c5oB8phwpYMO1dVV5uLpXzQhLMB
	oKEYsXEfsuNBFJLHHvLYKqEWuI/CF2B/iU0/Nxk0vD32eU4uggtjJy2hdk+S7C2pQg==
X-Gm-Gg: AeBDiesFoy+mEX1lnytnfDIxo/a88Y4krvGD/lhVZUetWYTY/pbdvfJ/39bSRj6+Ehs
	O5kw++7K9LeN1ngmZZ4Nt0SodU//A89CULvdks6E5libCIMupJkV9rTuD21kdKfmLXZT3kf8x4R
	vCzONE0uZ6yThEBaoCUy12hczyoKCULcucLpN1Zdc4YWY/AirxFkWmIMffvgItB6KjK6XJVvBpW
	qHqdLc06GBYjhc20pQJDCkvgP/U6oGCBPGK+TAPnQG1i0437x7kKDsmvwKLVFST/exS8Vtmpb+m
	8D4NOiMvzMX7q4LeSe875kgjd856wyt7aPY7wBZK/f6E0u+jARaF1W3xrgFwzZ1+sa83554evOj
	+f0TyQSJA1Bq3z+2pfXoUnyjZ2R6w0vanEnCn1kRlSg1hirQc5tVtrf1zcRWq+Cl9F4F7xf7GJ4
	LLYFX/u/u2sm077/CtPjc/GOmjG2FfhqJm4MA/MGA5C1cuYcFxAl+mywI02Dl8ig==
X-Received: by 2002:a17:90a:d607:b0:35c:30a8:330 with SMTP id 98e67ed59e1d1-361402339f2mr27461168a91.0.1776946721143;
        Thu, 23 Apr 2026 05:18:41 -0700 (PDT)
Received: from nik.. ([101.0.62.27])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36146ae9cd8sm17850741a91.11.2026.04.23.05.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 05:18:40 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [RFC] iio: magnetometer: mlx90393 - regmap vs command-based access
Date: Thu, 23 Apr 2026 17:48:34 +0530
Message-Id: <20260423121834.4244-1-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I am working on adding support for the MLX90393 magnetometer.

The device uses a command-based protocol (e.g. SM, RM, RR)
rather than a traditional register map.

Before proceeding, I wanted to clarify the preferred design:

- Should regmap be used in such cases, even without a linear
  register map?

- Or is it acceptable to implement a custom command-based
  abstraction layer?

My understanding is that regmap may not be a good fit here,
but I would appreciate guidance before implementing.

Also, pointers to similar IIO drivers would be helpful.

Thanks,
Nikhil Gautam
