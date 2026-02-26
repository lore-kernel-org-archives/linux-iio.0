Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5145239901C
	for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772098172; cv=none; b=GZyNeLQVBrYiuS4g+Ckyi4tCn50VulAihXcpJZav/g95BMi2YNwbFgtEJB6mkThVDPylpDCBcCjRulSxgnsy04gyI/GCTv9a+op/q69B2hUmQ+5h1xFBAQhIQ2pgOcIVhghQKMbHMdd4asVtZ4+Zpzzo4oNujSciuTLezQAVjHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772098172; c=relaxed/simple;
	bh=Irxnb7Px1CdiDpiCHg0OA7UUlyGHeHynLgeGSJJTNnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I8VY2J19GRGjCWoMoQ8crfnkSyMM4B1OAdPD+BPKwXLDD0QNvywpzjoGi5/ncXz8NwS8isJZMdtbK4m3ffYG/IlS1i+oSHMRWM7QBeox5AupZ63lJT4wC1F9nMessE8tj+cW3Rv70msZwRt0GWbWElLWLFZmxP1+3HPFhghEtWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9CQR3Zs; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9CQR3Zs"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4837f27cf2dso5648165e9.2
        for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 01:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772098170; x=1772702970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ps0w77eoJtCh1+nrBgZrKJWaWmd1BOvQ+nplYIYeBpw=;
        b=k9CQR3Zs+NrvjbS5lxKejfHhaCLOXJwXBDulX4m12AoqRCjgiRVLApAz6GCorfMIdK
         liLX12igf4WEq0USyrXfN1tYWZSPxFbLpIoxmPRe29Go8s4bsy8WQvChCUmzH37Biln3
         oH5na6k+Ya/wXYqGU+gnJ+gOYVYVVx/atvQi5ksIbmSv0dEuVCk9jU7RKn5D2r057E62
         fuV8baBF/NxL1dIzKDCOQsrU1fUNGjdlJzT7n9u5xAI1FaLvyg6v0h05SO2Qa0vGruin
         VkFWKwewJ1djITQ4qdUaiHfTvLKXLXcwgoP5/QzHzXFDKwQeP3y82ESCULnxpbmfu+WK
         7DrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772098170; x=1772702970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ps0w77eoJtCh1+nrBgZrKJWaWmd1BOvQ+nplYIYeBpw=;
        b=RVEy04glYNo9nKGitnJ2VD4Gdv+K55IZmcLyR0793k20ZqtpsV435J92qBTi6KkhTR
         Os3TCoBxT0T7HGvAfq4oP3Pd9AqceXRqgeY/7GP+X3gu+9DSxpkzQ/vgbDkZw7lgJS77
         0r1XhkxG4Od/w2bSudodX8vJMcxTTn7h5Mru6XM/Pgp1S7FN/bmLgocc8uds7uTRD3cO
         WpaJs8kyna3L89/zJlNUCui0ujnM7Kb3Hd8A6/3ccCNWBJ93qa4A0uxxpqR5qkdeoyPm
         oA+WLwOJm4tY0wbDuhj2+hiLFuPC4PAIPf+vq+1vfxqB0nEahW3ybuNMAzL3iIh6Gsk4
         1cZg==
X-Forwarded-Encrypted: i=1; AJvYcCUYOnd7XHFghffwQQOo1t2w/B2RJpz8D3zU9AQ6bJIFLTK/8ZiwS9s6akFNhqUd1QY41ShF1FrJI+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1BjbPq4MuxMxoiXUF0bDLVr1AsSpXgcqQI3KF5Q0T7B5QitiC
	+54HZ86SdzudlMbjuFT+nwtViCm37K4Nb3vm1a4BHTSQmSiZ7BPRXuVN
X-Gm-Gg: ATEYQzxF4dQd5MzL4Bvg8bDseCIE3QT4tQkmxW14IpV8pxBDVo8HJIPVulQSGUWA9sD
	dK1CAWxZe+jf7OOgfBpZZZufOG9YK5lPxWTCwmSw4AAZqMTZkGpid28aud4FsHRySpSeUzsX0FU
	g88Q0fdsV/00514xdefgTRyyb9Gw7topFdg5PfO0tWrxEYmbqh4ZG5jyc3EpVbGALAbjlnPJh5S
	LeXMKAuhD17E7L1jutBrXroga9YZMD6igrZfWnoEcHhoRHBnot8AYWzagLOf5u8i2W442jnwKhq
	WW3rs+BosT5nTSS2+wFbSJzjUKD/UafV/VytJQZL3Or7IzW9ESsdVjPYiWggNWYCc748+kjLeHG
	nejouC6TpMTWXk2hWnI7NRWpks8n/4XiRb5zvTiamOIFndWVpX+rpSWk2eHv5av6gHGpstmPW0F
	lplthvITjz
X-Received: by 2002:a05:600c:c3ce:20b0:483:c12b:fe3c with SMTP id 5b1f17b1804b1-483c12bff86mr50611595e9.4.1772098169492;
        Thu, 26 Feb 2026 01:29:29 -0800 (PST)
Received: from kimsufi.. ([2001:41d0:303:6f54::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfba9a5esm76482175e9.4.2026.02.26.01.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 01:29:29 -0800 (PST)
From: Ruslan Valiyev <linuxoid@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ruslan Valiyev <linuxoid@gmail.com>
Subject: Re: [PATCH v2] staging: iio: adc: ad7816: add timeout to busy-wait loop
Date: Thu, 26 Feb 2026 09:29:28 +0000
Message-ID: <20260226092928.72639-1-linuxoid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aZ_9x4q5BZRJi3ue@smile.fi.intel.com>
References: <20260226052615.65734-1-linuxoid@gmail.com> <aZ_9x4q5BZRJi3ue@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Feb 26, 2026, Dan Carpenter wrote:
> So this is only from reading the datasheet and the code?  I had assumed
> this was something you experienced yourself in real life.

Yes, purely from the datasheet and code analysis.

Ruslan
