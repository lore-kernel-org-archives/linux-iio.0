Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC88420475
	for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 08:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787041444; cv=none; b=G8sygUoLHcIukEZE1aByo9gpN9/bbkH/KBJw+RgB3KlOFr+5VY4T2bP5hX/hcf0yjV7IpZ6DCl9jwkjawxJzkbcsjPjVqzwpfQ9WnOz/QSh1xLYr9NmZoo5ButGf6xhxAEsCVGeumjZ2Tq4Gkrtt9wyXF5wk76lJIIiUNvVa83w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787041444; c=relaxed/simple;
	bh=TZ2WfPOcZNh60X/5u88ayyjzkA7MyHMs1n470xQcN/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AoToB36gPHVbL8K4EkBL44pmlmV5zEjju0vCQUlxY6XbayI2k1bkjYDtgS6ZeCvxKBvIHwsiKs2Ugh7RyacesBrfgVE1DWcvVBWHe58exPIFT3HATKECcbqk38P0H+Q2VxpWzAhlCH2GCV5r74U/zKs0FFmfw4tD545Z0HUeEIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjNqLRjk; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjNqLRjk"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493b966dd74so28994395e9.3
        for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 01:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787041441; x=1787646241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TZ2WfPOcZNh60X/5u88ayyjzkA7MyHMs1n470xQcN/s=;
        b=DjNqLRjk/79/uL6ZFtf+TTalXSYH6EOASw9xa+lCZfg/vbfMx/dKA+vVuZV24/ySzx
         Wdoq8po+ON2k4lERg6eRK523D6ujr1UWYkuosOqZRoioYNHsyVQBN7/lHcUEY4SElNGY
         7okdrC1Iqn6d8X/5bnHoo+QRO/he5qSEwzN84O+UF9LCJe7ZOH6qPOEf5x/sRHazUL9e
         qpKGg08SnNH6OodUJjhkoiTaFi8P5p4COISmiSMOMhP9jGwBMxxAIiZWX5Bx4Te8ol67
         CN38MrYQ3jOW9pqw1rgp3GzYCBE0azMcI7bqovOtZGS4s9jBaAo24BXlv1jF1HrLik1o
         MOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787041441; x=1787646241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TZ2WfPOcZNh60X/5u88ayyjzkA7MyHMs1n470xQcN/s=;
        b=Y363ZuDqPdF9iW9I4Y/LKiaemMb1Z3ZRtfLfgB40eAgSMGr2wF2d57T601XvHviwc0
         zLtVi6aHLtj4fsZQRNdNODptjoQKYizn/J4stUFTT60aQJqkTZNsCeKKkho03R9VJrJu
         kFnI0M8hR9yeH5LofQBCZgFE4gVcBUXxTZeaPe3xvkAvY1uiGQKBGsMTDEr9gQH4AeS7
         mtgIycPjNi4/iDl9W+Fu2FZunSP3rCU5G0j9fcQcUrfwIq/SQTW6RAzLea55Zzy4RZ7V
         OLxqcoEG3939bwuo8V9sTltYZS8r7Kce6rLhqCo7oDgrBr6a98BSMyDga2WMcitK0GtJ
         0HpA==
X-Forwarded-Encrypted: i=1; AHgh+RqsC6bstge3yVRGNu3GX4B57737XuRuGCG7o9vKWTMYMmPWIFWM35KwE9G1I7ReRSQpEiODKlNvuk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB/y1MKrRW/rVd5W9oOTufDMFWn/v9pbEh2AOfTcF4PaXC+77u
	aVuDkHo+yn/JVX5dz9dSFw7weLt3WgNyoshDd4A9cc2h7kr4lPqIKItP
X-Gm-Gg: AR+sD115nWCtR/l4IFxwLHVw8se4TYLJkEoD9tvfEsX0E+TG3lBSPHYV8WRqylFr8HG
	x+cTR17u0maZlSTqgKmFIG9pG2Zmg2O/nHF1a2Z9Bl32NDCBj0VoEKsx6Fnmo/ziIBz4EyR+fPV
	QBVgHiaQn74x2+YrckwIEJ3MGUweIjYNF9p7WpkOkWqGsoF2VumSDFStbqXT+alyOW+LGxk0WMO
	WDpKunlqDKCqU/ohatTaSqeVNQmvkDfTdTNQPvjoOqBqE/6ObZMtHiiQDKHOJdPKTAwx3YIMmY5
	DsRiE2PL3LF38Md9Ay3zdiG/EEXyQ1J2EcCGAfYEKhmfgO6yNtwcSoA66sA1CMXBdhT9L0EMPb4
	FOo/peAgQFTLTt2EZo2yjEvOhAhu3M3RwtU1s1j+63n3B/f/Qbr99VRFMv6xe0aEij7YoDFmPES
	Rg+fvS+2eXGFHEO+jyGMBLG3rOhbhJdLJKhn/dJRxMoyzGWVMi9hWDWXvhcfxqsAsBmkw5wyf9R
	9wNsrS43kNk
X-Received: by 2002:a05:600c:3b1d:b0:499:79b9:e226 with SMTP id 5b1f17b1804b1-49988057986mr474592265e9.0.1787041440924;
        Tue, 18 Aug 2026 01:24:00 -0700 (PDT)
Received: from fedora ([105.71.134.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999d10be27sm138748235e9.14.2026.08.18.01.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 01:24:00 -0700 (PDT)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: andriy.shevchenko@intel.com
Cc: 0rayn.dev@gmail.com,
	Michael.Hennerich@analog.com,
	andy@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	krzk+dt@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@analog.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v4 6/6] iio: dac: ad5504: support scale via output-range-microvolt property
Date: Tue, 18 Aug 2026 04:23:47 -0400
Message-ID: <20260818082347.13382-1-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <aoP8DQitMiLOSOor@ashevche-desk.local>
References: <aoP8DQitMiLOSOor@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 18, 2026 at 06:30:00AM +0300, Andy Shevchenko wrote:
> We do not need a Dostoevsky novel in the commit message. Please, make
> it straight to the point. Don't blindly use AI, you should understand
> what the code is doing. Same comment to all commit messages in the
> series.

Understood, will trim all commit messages in v5. My workflow is to
draft the messages myself then use AI to check clarity and kernel
mailing list conventions. I'll make sure that doesn't result in
over-explained prose going forward.

> So, the change from 1000 to MILLI is in the line that is changed
> again in this patch. So, no need to change it earlier. And again, it
> should be (MICRO / MILLI).

I started the code with a bare / 1000, then replaced it with MILLI
thinking it was the more readable form. I wasn't aware of the
(MICRO / MILLI) idiom for expressing unit conversions explicitly.
Will fix in v5 and drop the intermediate change from patch 5.

Best Regards,
Taha Ed-dafili
