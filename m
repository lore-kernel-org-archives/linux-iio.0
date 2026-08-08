Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C1A3B7B97
	for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2026 09:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786179665; cv=none; b=GxUOYZHYiZCnz5MJrLrVywgl1hrDK+ZJ7SM+XpA53WjE8zdKFTvhpHFeiS8BbazMoKxarGkQ+ONA4jp7gOXqaKb2lcNBSkwHXIuXl46lzSrNxzm5mCzAUiw3tpERBZdtxZnLpQNi2FgAVqEwMtxonEHaqHLSkcFN9PW7pS7aruI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786179665; c=relaxed/simple;
	bh=Al+keQgNW/pNQNnVIlyN6dMkqxOCg3QqdJNuM9v8JS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3L6VSN1q8pKNH53SIW01u9/BPrfhWKzDL2d0dMUewGTmeGmOo3LLVrCvoM3p3/Dr0hWWiFPno4fCgKH9pcdTXebDfqpoRO0ajyLMwv+pY9AdXs6/K2Q2Ncc38Z/OwlokUHrNxUK4kPA8THUejt6ruP8mqq0L9R1IVDYxj4cxKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Br0L/tVg; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Br0L/tVg"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84f38f3b36eso196514b3a.1
        for <linux-iio@vger.kernel.org>; Sat, 08 Aug 2026 02:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786179664; x=1786784464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kF/b+Gd23S8p1kMd//04QDrp+FqRSM+cdSuEkId8c2c=;
        b=Br0L/tVgEF5jRdZCcCHaxnOkaQClwNrY/c/chdEK046dW3g5ptmmjs/RxdWh+Hg+XQ
         oUB1hPshHRGv9RPzLaxD8aIkMi9XCO7lojGKEU2mEu+whO3Rhrr8udm+JT8xWcT4nwob
         5IrYRfaJGH7HboTqsbxq2pGO5oUM/0qShnx+6IaHt31N16cNK/bGklEdJVud1IqYh87P
         pbXvpg9Kb4a9OfbNjs+Pem5iGtP0Uxe7k84ym7umqGEXasYAYc8wruT1k8+ir0A9bnWX
         90fKdZTKr3br04AWxwpkgCkr07dKshUGjPX7/MikXChpfPJZtDIX4+lc1iwKe4ZWBWVM
         5fiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786179664; x=1786784464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kF/b+Gd23S8p1kMd//04QDrp+FqRSM+cdSuEkId8c2c=;
        b=fjXvmVIX8YJbNzHhmi7W6ApoKAlLpLBCf0fK6AR/7TibvVk6ZsHAhWdyJwvuNaDwIJ
         w1B9Rpx7Y+ukcXyYE3mMxI2TvV2Ojpbf9pThcLOdjZHHxTWW15C/Pj+Q7xIXadUCxWmo
         XjI9fNV1LQAGfRBuhPsuKtVEQbahodTOd0KVlVj7AR8WF6Mq4i+LJ8bfctitFAk+SbLf
         sOcvgC5jDTi7fXcCHr0GkAKnb/sp7wzKC3yEPepK0RgmLmNQ3nREVWbNW+FMdzZVe6lu
         GrPBzUsvlH/bmkWCc9JuZzwAPP0y9qHI7SMbLVnpe1M9ui5eTq+3i+boj4G3HVeIJl2P
         U26g==
X-Forwarded-Encrypted: i=1; AHgh+RqNSgN8/EVjzvR38kwiEyeVXx+g5OdYyi9+7iCqU64cnJGuiO+cD2oPk8LLF7gB3VNgd4twD34Icds=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD/pvOibhrw8FCBVU4OuLpysDSvMdCT6sGz10NVjWdVDd24DC+
	hpAeEcOnFdUuV870EMEz+liB3z3qQUFwy0sNSC1/vGs6hXRwrZFov5te
X-Gm-Gg: AR+sD11KrOBELlo1erOp9cNQR28lAolnKLkGhHmN+awdiJqPFjRR4KoNAzMt226ddBA
	qw4GHgBmIJN5yqKqZ4uxP7sEbi4vehwKEMDlVMKNlpwmXTDdJI5AENsgKr35CaQhoKeEr+uoaPm
	kpCJaCz0qosATnHEyuQUrQEowS4lOlzfaJgGJCIkefTxSYxNVj2HYHoVg+kae+73iQYRL93NISf
	H8VSI41bLLtoM8n0uo9JaSZdcNwRNwU3SDEQdiSDJnsyff2kWh1F0Bz53mjqryciXDMoUAZc9t9
	1cgNa+W4uEt1XiEw0t9FzSEgdF19OiZNj1NNa0UIKBXQvBhT+e1wIS7dNEtPnnOm1mPtIPZn0Oh
	nPK2XRCegiysfExoX8kWNKt4E9IaPIX/BgTGfTF/tRTchqe9iLlYOH+BNorfXAmxzwpr7MJbwhe
	Zrgkmq/t5Z4Jz1vHeJh0mojx1bT0LiWsOtedkysCJ8KSsjBYInW8vqVq9EcAgQVn8+7BbPKYKAz
	S9Vl1qXf5neYUcgz/TVOpGoG4sWfJwfvTH/y7vj9wu1rpeB70RYfVbirHT+ng==
X-Received: by 2002:a05:6a00:399f:b0:848:42a7:1854 with SMTP id d2e1a72fcca58-84f4fee21bemr16602687b3a.39.1786179663846;
        Sat, 08 Aug 2026 02:01:03 -0700 (PDT)
Received: from debian13.localdomain (bb219-75-96-14.singnet.com.sg. [219.75.96.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a51e9f0sm1973871b3a.28.2026.08.08.02.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 02:01:03 -0700 (PDT)
From: Adi Nata <adinata.softwareengineer@gmail.com>
To: lorenzo@kernel.org,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linux.dev,
	Adi Nata <adinata.softwareengineer@gmail.com>
Subject: [PATCH 2/5] iio: humidity: hts221: Add a blank line after variable declarations
Date: Sat,  8 Aug 2026 17:00:23 +0800
Message-ID: <20260808090026.34187-3-adinata.softwareengineer@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260808090026.34187-1-adinata.softwareengineer@gmail.com>
References: <20260808090026.34187-1-adinata.softwareengineer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve code readability per checkpatch warning

Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>
---
 drivers/iio/humidity/hts221_buffer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
index 4d03db19063e..c868549d09c0 100644
--- a/drivers/iio/humidity/hts221_buffer.c
+++ b/drivers/iio/humidity/hts221_buffer.c
@@ -194,6 +194,7 @@ static irqreturn_t hts221_buffer_handler_thread(int irq, void *p)
 int hts221_allocate_buffers(struct iio_dev *iio_dev)
 {
 	struct hts221_hw *hw = iio_priv(iio_dev);
+
 	return devm_iio_triggered_buffer_setup(hw->dev, iio_dev,
 					NULL, hts221_buffer_handler_thread,
 					&hts221_buffer_ops);
-- 
2.47.3

