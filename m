Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD31729B78D
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 15:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778340008; cv=none; b=mS2noN+2fn2uD3eM19WQfNL4RjHHhP19q+S68UUSG9NK4x8FAlqa1ZJxOl7ad413OblejCNjsOWiFpSptQn1z0ngR6bNlTmPDFvlEBi/sUSLDnKHvaa73kFKNmtNZzK+GPsWVC9jmhHJU/Tt0RSZcAUc96E3vpy46iDhgM5UOZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778340008; c=relaxed/simple;
	bh=H08BrTRalR0jUvy/90S50ZaX5dzgHvM0nJcBr5ocsmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEiOp1dSwu2j5KvIzH5/XQJtaRURZGtVdIcBF0OV+mpoFki2T8N0+W1n3pQKUdQkhUrJzAPkG3SPtya9alPD/3SoJjpFU/ckx4ufLHswBBH/bguXM6oc7KwZfhNO+SsDyWHPPQlaVrZZM3SWTxzEdkXQnkeQj5LZU/RtttYi07Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMg5l84l; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMg5l84l"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a85b30dd54so3057212e87.2
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 08:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778340005; x=1778944805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnRfUwgP4GDJT73gEU34kWTDXjMinDYaY8kcXfNdp88=;
        b=cMg5l84lng+0+onmHTBQ6QMwpCQYP+ssvrxiiZfPQBGd+gEuCeSCGrkh++q4fJDr9e
         f4oQdJJzt+4cDgoeBW8KOLr0tX9l9h3FqUlL0kvuHfVNC6/Z5I9yTaMKN43MkyRAz5uw
         hk3Kt9qIbmczbNAnMHcvaRRbyGYNq9KN9nsTBVDMw1dOPvYThbJyjxyxozwq6kRU5nhe
         2V2xz0uup7SLS4sVbYho5QhQsmIck4pdYTU2/OHm2Iuh0wraz8q+my4EGs7cH3D7r7Tx
         PurXMmaiTMAhCK7J2Ai1q7Sv0HbQe+3o4juDzJB9kbsHmZbG2qymMwN/hvq8hk10539y
         i4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778340005; x=1778944805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qnRfUwgP4GDJT73gEU34kWTDXjMinDYaY8kcXfNdp88=;
        b=lJ/OryPW5tiVCTxZl1VCMBCCYIHBggKe3Tm6HDBEuoQTxrv/831yD6Ta0yPI/bQpjP
         JHgZc4ZcqKQoeimdHuqV5tYG167SdJfc7UQE2nfF2rrcDFNn23arln+S/ozZyfHPz/Uf
         ItWwLqdayivY0zGCx71eLFSj6/MNOMvVtDdArtctEtOxK1RzHAF7wgDkw208NfP2i01r
         V+nCqEAOW3jvixsR1JJu7KFsqIsPFLsF/y2PD6dJ4T1Rf+c8cUSj4urICqyn4sfoCzXA
         bcyporc6WLbEUwE20Xxr5r7BCdVrf+LVXSbBwLi1Xsmo+TOddDXojcxCWx6Ic3Wa68GD
         Y08Q==
X-Gm-Message-State: AOJu0YzKwG/swhlecwRL+NaReJcufaycNDhe0ZOU9klhgQpgNEQ3Ds4l
	xYkXDIL0aFQa8y8V4yMOK3q8lIHRfwBIgfN1yw0/nVZy0vRwCzBi+C7qwCRHQ046
X-Gm-Gg: Acq92OFlXbmw8zLgHaA09zLWNvBaIk7b+MLAtvb4+iIPRPAtGh0lvRFo+uvb8ByJJFL
	2eBb0voKT8KEfPxw2CClKmeTR3ZtcJoGf65IeaRm5QMnln0ANBfc8mWLnCjESmmPUajmi6TMx9W
	Ghss/WZF7z3aWMvlWG0LwKVJSbYdOQZE0zjSA1RvOql8ufDraSQjNzUqIDbEpR0uQQcMUUkiipi
	hn5jMVKcXHlCCThJ+mnX9aVAorT0gsddUr+OdZufhcuTBiZeB6EOE0MRDKksfwSbnSJ8XJTy5uh
	PiHTMc3WEMKlvQjwjtzWKIbeciVoCMCBvnfjcxsgqgNQWQbM2+oBOVsofugMCoFlMl0jzfPgV/H
	GVcCptdOXXCOxIKxc7LqNDhRF6BsxoaCgSSWGX0qx0tyISINHumxZT+2p/0qVUyd4lc96L3pfJr
	rpxffFSqorNR3niWYgy5kBaW41K4pXIG15SGUDPg5wIiqh97Fp1gX8UW4NNzHKN2CB
X-Received: by 2002:a05:6512:128d:b0:5a8:6b81:6694 with SMTP id 2adb3069b0e04-5a887ce5e99mr5594650e87.30.1778340004274;
        Sat, 09 May 2026 08:20:04 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a95664easm1301975e87.70.2026.05.09.08.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 08:20:03 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org,
	mike.looijmans@topic.nl,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	andriy.shevchenko@intel.com,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v4 1/3] iio: adc: ti-ads1298: Add parentheses around macro parameter
Date: Sat,  9 May 2026 18:19:57 +0300
Message-ID: <20260509151959.3475-2-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20260509151959.3475-1-shofiqtest@gmail.com>
References: <20260509151959.3475-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ADS1298_REG_CHnSET() is missing parentheses around the parameter 'n'.
Add them to follow kernel macro coding style and prevent potential
operator precedence issues if the argument is an expression.

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 drivers/iio/adc/ti-ads1298.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
index ae30b47e45..cf5f954206 100644
--- a/drivers/iio/adc/ti-ads1298.c
+++ b/drivers/iio/adc/ti-ads1298.c
@@ -66,7 +66,7 @@
 #define ADS1298_MASK_CONFIG3_VREF_4V		BIT(5)
 
 #define ADS1298_REG_LOFF	0x04
-#define ADS1298_REG_CHnSET(n)	(0x05 + n)
+#define ADS1298_REG_CHnSET(n)	(0x05 + (n))
 #define ADS1298_MASK_CH_PD		BIT(7)
 #define ADS1298_MASK_CH_PGA		GENMASK(6, 4)
 #define ADS1298_MASK_CH_MUX		GENMASK(2, 0)
-- 
2.54.0.windows.1

