Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25CA3D47B3
	for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 12:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774354817; cv=none; b=YLs1GUlPPHWwrClTBlqHjGbswK3HDD+Y+1oKbd0T/TE2O+BQ12kWPY1ilhFqhDgliuonhjRb87TkTlipYtu0n5YyzaCTxnhIe/C2mGKGXA3HTRNFzDmc0hs8VrbUMlq/39c+1wH0Y7PR3gTitpKNXBAEULY8V2OZLhxIcJdPNgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774354817; c=relaxed/simple;
	bh=IZSFWjpLodOcHEci5VXtmGLypfW5W7GfYU8AHacgrf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CyVJjtVGHLJNPDWq79AgSLRNgsU5ekgE9AYFIP70VSVPnlLEdj7Y3uK/bHNhof/Q0mj9avuIjSjvkgRiwLL7B1X92Rof0+X72clF+RWqhXJZQ+/CTc/NEIS3nrDgtE+Qx/8QFByurCr7NGzcf0i0uJ0/ao+fOMv1mLt/OLiGiKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCVSQuy/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCVSQuy/"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48704db565eso30263045e9.1
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 05:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774354814; x=1774959614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZSFWjpLodOcHEci5VXtmGLypfW5W7GfYU8AHacgrf4=;
        b=fCVSQuy/Z23ONWPlPfs/4eG09dc1E6Q/y9sMD74ljmkdJYP/UHBNVXDfIOfqOp7n19
         uw4miJ71La3Z41PA+O9tJrODH8BYrRA6mfxM55gKOlXhssaIEOZ/pIMVRzdy47AX4PCi
         QUViOyPDXkqsp7FEP9Ly7Tiq+VKcseLXoZ70e1u+qlpIe19M5u0bNOZejw5Voy1MGzl/
         NjL9h1kdbkV3OvdKshws0yKhNfglQf1ZlwvpfNo6xx2gEURiDyQWZra70XFJQO10PpRo
         iYbYdW3VBVSzELS6T5x8ycWUDo2PkJWQeTvZHKyBNDDCHgGbVs+HhzvrKb5GptIScpKr
         C7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774354814; x=1774959614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IZSFWjpLodOcHEci5VXtmGLypfW5W7GfYU8AHacgrf4=;
        b=qnYuNrzfQMvGFCvhujDDlTWukRlsjTaulxIu1JEH6tWCFK3D4zq3B7jpWzd5jY6prY
         crQ3FTd/MHUQZX73AL4id3jZM3lVQZcawP9ICTZNEOTm5aREgLNSTbGdad8sPYRlqGpX
         GHOfmJeaUPGiPPDPIt68xClMEfznTRJosTXBvg8j9GUCZBCDVAWPpednoGDh3DxFfHDH
         XeOIqku4a1lYsbPXFVxzhOFIAjR72U8LiNmYFWym3tOSAwgZ3WTgFRPWu1+m5OJIZDnC
         H0io8u3HHdwdF2oYC26nU8Y1aSh1vtc6ELnK8dS/DaXw29fXBlgmm3ZSC7+UPdVC9FEH
         3V6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9taP3OSmg/Dfa3RHLtLe49mC8saypcleUqqJU5EH9SMhLQ+hUTROPKMUv1QbsBG2Ia8lRJqP2Haw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/FVrdEckpJ/A96vVIbwrKbn7EjsKyeIOLRdNoWGDD/8E2Tg+k
	Vp1S6k/wAFPix3qzeHFKSfO403hRpDIopfL9pApxVQekEw4fBAL5zHQc
X-Gm-Gg: ATEYQzyNC7Z/iYr+rpXDVqw7nQG4t60o79o3krm3Q71+1ki3Lr2Np7u7r1Kdd+9Nwnl
	wGqnvO9+api3hyKW5NcunU1YJqzFonOXu1EeB4tNVdzk+4dY1f7ZqQCYmPzL9vCdNpDtqJEtFE4
	CZ5BBqE5X2thNxJj7htQbQyhw4id5bhrgPc1ScVBzn113IiW1401CtPC/osGZo5MROOGzn2gbId
	U4ZgGu6Kl2hDw2l35RjAb/gKZ69EhI0w1H5sV9cMrNjDXhkmrM1iFi6l7WPiW8W52vMtHXQBm56
	2yKzLzyTvdFWGQ71viOuBBigZYpYvGkextlWcVN+coaANf18nBhiV1WX0hRVymMrFJKjbsegM96
	sfUjzXEK/FOocc+zEZSCkMNOl4XULIKiKkrUd9e7by5g1pt9KNdJ8UKHbVSbkvdPL9MXgnDBUDT
	RW9e1wKwrmHawdl6FzpsJEwAP7dULttE/3hmGpLQd3H8uRqC4XmlU9WJBAAlSDmns=
X-Received: by 2002:a05:600c:35c1:b0:485:3b50:fe54 with SMTP id 5b1f17b1804b1-486fedb2545mr263998595e9.11.1774354814093;
        Tue, 24 Mar 2026 05:20:14 -0700 (PDT)
Received: from MacBookPro.localdomain ([2001:8a0:6c9b:a000:e561:a158:b78:a92e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48711701804sm49750915e9.4.2026.03.24.05.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 05:20:13 -0700 (PDT)
From: Gabriel Rondon <grondon@gmail.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads8688: use read_avail for available attributes
Date: Tue, 24 Mar 2026 12:20:11 +0000
Message-Id: <20260324122011.75902-1-grondon@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <b980b8ad92cf560021a8b428ed0134ca582895c8.camel@gmail.com>
References: <b980b8ad92cf560021a8b428ed0134ca582895c8.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 24 Mar 2026 11:42:36 +0000, Nuno Sá wrote:
> Reviewed-by: Nuno Sá <nuno.sa@analog.com>

Thanks for the review.

> These days you could just declare i in the for() loop and make it
> unsigned int.

Will do.

Gabriel
