Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24CE3BD63C
	for <linux-iio@vger.kernel.org>; Tue,  1 Sep 2026 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273661; cv=none; b=K65GRwJ1X02vYHqbb8Nr+FHZCmabFGH3Iitbi3yLqMgsX+pXw18x73wvlvtCtcFklKVqGvNGbjRUVjfMI7DsSASYtXfSxC3/IJVcNLHEXFkGfzmUOoEbixekjZyGRauiJr/4ZDgRE37jBRmwdl/G1MckIE9j+5W1HpounDBylpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273661; c=relaxed/simple;
	bh=Ezvosh3epb6WJpYM2KLXc2S+pP6dIFTIRWSni20yIT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFezaCnU5EpqCn/+qRK1DxaqKFHSUmh504puT67RoqQmqmhq91DERBuvHorHqrnus56Rwkx9HFnmn/kZrBq2iVXqPWMkbT3qo+ify3TfnYmE3F6TgwttuND6ClKlSTVVflcSUJxstb9ZW63zmre4cvBQdRS6QpGdfeNCpPpb2uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P72qjCbF; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P72qjCbF"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-39675172593so4354276a91.2
        for <linux-iio@vger.kernel.org>; Tue, 01 Sep 2026 07:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788273659; x=1788878459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8XjVam93oa3spMQHjTS09LkSETmO0biyQOMZVXxMvCA=;
        b=P72qjCbFrqn3yw8Wh4O+iBDGNn9KhR9qgOchFWMdaIEVQl9ke/i3NNQiZdSEFLjGke
         zm+EitRWyXpOE7Axn7i3BFqX77AbdktSchbVKP/+w5mYW+jFqFU6HiOXljza850YszPG
         yKYSVeu3ctAJbPnPgwmGfHTLU3hvD1q0M3FcBIbqhvPvH2HRIBrfsEGY7sLgeCQY3nCC
         UrEicKxmzljXaiTIyr+uwdECeIu+CVQXRmFXM4Cr8R4YctQRU1WjUFb+dIknJUZooxNx
         xFo+vJdfQEua2mrZrUQNuASgBZkOn3osdoRlj1VhSGBZ5nS76NRm6xy6EnLPQvzKNLQS
         cmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788273659; x=1788878459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8XjVam93oa3spMQHjTS09LkSETmO0biyQOMZVXxMvCA=;
        b=Nl8rdujUZg5EtcCxNDw0BcbngU6XTQs6DPEHblB3A6//33YqYUjDqvMhpLJ6BwsVw3
         GfwYkLePIMUqWK1650FxDIkCq51H9asvtVxaFo0CU+ejH5EendoFOX6rcvLy2K7Gyanp
         0hMohB5Xe5+ntBWTbq0yXGthyn7DU3FdvJLU+UEYY35ljo5eYIf+eTr7rR8oWuThKFWT
         Ft/R8aZZi5HELrVxrkECKYHjB3GyvTUBJlyPrAmgRoufOC07oi894R+IsRzQ2Gtl8yZi
         2F1c5evAfi9vnbhxLmUFlmYVo1x1PrxKTsJ84dhoaiTOPXEWhM6IuQoHV/GywYS/xbTZ
         Ny3g==
X-Forwarded-Encrypted: i=1; AKwUvBxdlp+ObR8jnxX9wx9l2C5MFTRjM02TcFwI+4puQYM+PAe4+0qvlJHG25RjGvOnZYjpLiyFiWJBhIs=@vger.kernel.org
X-Gm-Message-State: AFuF++m5GCvP9cHH7GGD099N9NT8Y07XKSaIBNiAy4pX1INJ33EiZWZB
	gBVex8Ukdbbi5dmg0aUma+GRYngwHYassVd4CRLgHlPQZdzBq6vFW18O
X-Gm-Gg: AYBFou35BBz2H5RPFNZZvaS9++f7HMmUXFsvEf7Y6xYp12HSUgcCDjmEdgTXWifoi2o
	rpYTn8wi/dVgCLg7x6n0wTk/H/0Bc8KwL4OPx+L598BxtGYQMJYcIszW9si5UNjkE0EVxw4DYLD
	Yj9K6cJ2nQPExouQ0SNBWWLqi8VbTDrv6NAG6TTB0q5qNp+Cu2zXJJjJY8YruZfmw4mJMEWFuUe
	u/2Hr+zkNRvfL14BUkjzO0DgaHEazb0pRZY75wz0X+dq6O7Brq8+cZnD2VSjLEwJNsOXOyUWSkn
	JKYldbz+yc+kiyRbAnHkMXCzy838lwws6Ws/oRAXelEOxuoohcz1B095hD9un/CzyqCB4MM+1tL
	N1arfKESOgh/zEbXepPKgiRooDNgF/rgyTGLyS6XGx8U0gWkiI/r7Z718bIBtejCGSBDam2VNjs
	ogDkl74MWINA9z5RB3w6gRisOa+KJNW5PU7V1QqoSRaRGtK7bIpWr++WTn2Q==
X-Received: by 2002:a17:90b:3985:b0:398:e46e:ade3 with SMTP id 98e67ed59e1d1-398e46eb068mr20470492a91.23.1788273658460;
        Tue, 01 Sep 2026 07:40:58 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:bf00:62c:e311:6048])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae380d7casm21027a91.10.2026.09.01.07.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 07:40:57 -0700 (PDT)
From: mdshahid03@gmail.com
To: jic23@kernel.org
Cc: marcelo.schmitt1@gmail.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	rjui@broadcom.com,
	sbranden@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] iio: adc: bcm_iproc_adc: use device-managed resources
Date: Tue,  1 Sep 2026 20:10:30 +0530
Message-ID: <20260901144030.509802-1-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260830170919.470974-1-mdshahid03@gmail.com>
References: <20260830170919.470974-1-mdshahid03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Thanks for the reviews and suggestions.

For v3, I will incorporate the following changes:

Patch 2/5:
-Add the direct includes for <linux/bits.h>, <linux/types.h>, and <linux/array_size.h>.
 Keep <linux/device-id/of.h> and <linux/iio/types.h> out, as these are already provided through the appropriate headers.
Patch 5/5:
-Remove the now-unnecessary platform_set_drvdata().
-Return devm_iio_device_register() directly.
-Remove the unnecessary backticks around function names in the commit message.

For patch 3/5, I understand that splitting the ADC cleanup into a follow-up patch would be preferable from a patch-scope 
perspective.I will split this into a separate patch for v3.

Please let me know if I have misunderstood any of the review comments.

Thanks,

Shahid
