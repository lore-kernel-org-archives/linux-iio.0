Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3FB395D8A
	for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 15:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118228; cv=none; b=OPeoREzOprzbQug0dKImEiUq+MQVrS1V4Aed3iRIGBMfXB6nWCaUIaNCcGxfougi5yPBCiBX7pf0gkdyKUC0r6LnFgH3czurrE4kL9qFezQwEsGR4OCD9eq9qm9Lilk9X6ZZ0hT9+5uexhJMe2vjceEZGv/Si+Rp2gPFBSZIDDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118228; c=relaxed/simple;
	bh=uWGTAgDkfFzDF3tXt0jhGG9aVGDM99S2dXiFj5vGffc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N1jyzTKopexP4JKK5lEH4xTP/xS4piBAR6FoLiIlmOnsNTZnroBNanpFTrStJ6eihMaxP3EsTHrN3GCHtkvP/BfNQM/ihEjxg1n3j6nhs1HL5Q3FOO8TDzWQ4he1WMhEY+vG4tF4BYKjp4nvkcGCThm06MS2HEXyZeZYHvcj2vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2WyMJsi; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2WyMJsi"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48375f10628so6865805e9.1
        for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 07:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772118226; x=1772723026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWGTAgDkfFzDF3tXt0jhGG9aVGDM99S2dXiFj5vGffc=;
        b=h2WyMJsieyur+MmwL8iYJPZ9f9vteC/QxE35OMb1TtYTYoz68fMns6v9/eMPiow/A9
         fx5NccAMOsgoahWlEaYJ7+CY+9H0KqgBTm88wk7fvSOeb7wYX+JM26OXXALvAtmK8nMR
         /+nN0INa/kBywYZuKa7elESaxIR/mr/AyFEFsZ2sWhvRiijZh0bh+MXmrRcLEu18B7CZ
         MZJmf8Yy/mdYNoo+lemc5luFVuy2UAHjv/toES8hk/sXiOb9NiCspHFI/5O9xwJOIGrl
         38EA83Qnx6zYs81rc/3D3i6J/ogX/nci3BQn63gGFvF98WclyXYernwVtVsy3ayGM9KP
         ZxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772118226; x=1772723026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uWGTAgDkfFzDF3tXt0jhGG9aVGDM99S2dXiFj5vGffc=;
        b=IfSMVz27vXCMm4ATIiDN59OsyLK+Ztar73dX6dDJlHln+sQ8YgI+XIT1jNC2vsK/f3
         STIkqiHbiybJ03tD2DAPJG1n+LIdAVGHzKU8FQGKelDVEaw76tdzPyD+ieDQOVaPpPhB
         +U0ieSJdhbEFK8Bj6AV6nw9KZ0KMvI3xFDjQdpu/c36SdGwz+3ibLsJIBT5eK0ArLFRn
         8PPSOi5JCk6B+FLfLz8Ik28ug2+42v4c8UHZXRGuHUmoAQ2Fq1KB4LW0V640VNe8n7yN
         5XnGt+cUAbdSLAbksGGZXlm7LwXxvvlHqD7bdeQI+eithPDUdLQZe6GX61WrHFnMshAN
         FDzw==
X-Forwarded-Encrypted: i=1; AJvYcCWjjd1NB98TFRApXUjiclA7krj2ertfhXxWKduP0cn4kwlzJ9yinkuXYSei7+nYHCt4RVa7WnJWIIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOJHZ/tNFSSNwdVO5oIdHibRalU4Q7N9ROBHaNVaFjqWCu9/ca
	D8qdCgQIODsHIMCgxfEOEGUFWzfcZInGE4nrB/Vy6e153ccBqsRTVO8c
X-Gm-Gg: ATEYQzy40eCQOhoM302cgMeAlZ8yG3neUK461grQZ8jF9CR7KDUkzsykuZxzzTOQToK
	UxbanxSVBGQWsXu/pnFzGdvUSTTr6vIEkilRwk9Tu1mEHismCygGbOgoQakhxoEiO2sJK2P0VFo
	dcBojzpE2rAOSiYqURr2pZ7fRZf16i6TClJEF+fnED6xrPxSbeevQG5IpdKTCxjQ60RpsPTK83N
	JhaZJXQ2qizI4upv7QSOtAjW8MrqK3l16nu0DlJJ5pQfQ6s1gkSglz3jHBwPUmOk10IxPVIZPVO
	K5T6DOBSUJqbrHJyEjZuL8XtgPw2iweosywHIDeeYFVY39p+xUXBSBucGyVca2fJxA7K1kG3q+6
	vJ71rMbAdiTwqmqvWm8KkbpnwBCuqQq4CMS8l2Wllhknt4HbyV/P3z6lNhu3GOZIUw7ixVj5bmW
	fNHulxQE8Zr+q4AnDhuKermBaRZl+jyD2R7E2EcTL3cUKnz4PB1hqqpF45CfOirw==
X-Received: by 2002:a05:600c:1d0e:b0:483:78c7:e1c1 with SMTP id 5b1f17b1804b1-483a95bd940mr346655635e9.12.1772118201768;
        Thu, 26 Feb 2026 07:03:21 -0800 (PST)
Received: from db07.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7507adsm163504135e9.9.2026.02.26.07.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 07:03:21 -0800 (PST)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: andriy.shevchenko@intel.com
Cc: 0rayn.dev@gmail.com,
	Michael.Hennerich@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	dlechner@baylibre.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-doc@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v5 3/5] iio: accel: adxl345: Expose IIO_EV_INFO_VALUE for double tap
Date: Thu, 26 Feb 2026 15:03:18 +0000
Message-ID: <20260226150318.21168-1-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aZ29vjil1d7NF5su@smile.fi.intel.com>
References: <aZ29vjil1d7NF5su@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andy,

Thanks for the reviews.

Regarding the bouncing email: it is an archive address for the Linux
Foundation Kernel Mentorship Program. The guidelines recommend CCing
it for the program application to help with the selection process.
However, since it's bouncing, I've dropped it from my CC list, sorry
for the spam.

I will send out v6 shortly.

Thanks,
Taha
