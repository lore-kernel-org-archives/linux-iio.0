Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627290;
	b=jLBZ1zjRSgdSTuzSZQHDQt80XH+xTByV4c3Pb41LYxSTA4Zfvpfmn2y0BoHCTA8j8Pyz
	 hlTFD3QAdygUBw44rf0pi1SMcNAijpPeeVZLRc1Y0RdkAn5HqBppOxVEfLWKTMt6mAaRq
	 EbZYb48Jojg91rKdbqLsdH4o2t35aEDQlMWj1ypamOvNfEJssmI8ex1t1oscYLnxY4kDl
	 8GsulqA+JBNH/l6YQ8K0+61jbrQ4XkcLLXa4WRwABx2pOne7i07yUhuRj7w3PzlQKNv2K
	 WN0T+WKBH5oMFROIJLxKEKXVSCYMqW30vEYjkxmPXiSNbttgl5YWdWUoUOLOhzduowQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627290;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9rsuU/zpvGVZ6N3nvTXW6aQt3MLOdJQFmOTT1iINVYg=;
	b=4cZGIkM5mzzwpkBlQ/xhmNbJMAz7VaaSMDvsBEBQ+M1OHN21uma6FasLfHoO3QhvhIjC
	 BRDEs6DUtQITHrE0J6rkdjCKO/0dtMpWGaB/b5HtLVk8w+lafYMPbDCut5Ob8J4b79upM
	 oDg0DUCuPNUCD87UK4wJfB0Mz4DGmkgS+8+9HVYxIa3klm/XqyyRDC8g4XDTD0+r+PnQc
	 kOlOQtFaRz/AOuzun0wIz6ZSluCNz7aTj4QzgvUPshuc11W4KULhaOE9uMdXjpzE7qwUF
	 HNfdUFA/hllbO8DIJnRoAzcp5rTO0SGV/KSe9EyUUdaUmT+7lZpsGlORwch5P5p0SRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="EB/KrACD";
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A386960A2633
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 00:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A386960A2633
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=EB/KrACD
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-368581df789so455007eec.1
        for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 17:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792627289; x=1793232089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9rsuU/zpvGVZ6N3nvTXW6aQt3MLOdJQFmOTT1iINVYg=;
        b=EB/KrACDjlSMSNTE4aRzq04KRUl4fgwlFiqP7V5gtGC+IPuLRKoovHdoxpbOfx6IAr
         Y/rmOxbdrDq8gcsyzDydLX2iKq14GVVbaJ8aeOEn9mxg7P3mianuxc5v/UxlH2uu51ki
         OhJE2SI31wnbKc8VRU20h1E6c51rqmTCR2I7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627289; x=1793232089;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9rsuU/zpvGVZ6N3nvTXW6aQt3MLOdJQFmOTT1iINVYg=;
        b=z2i0KnPdVe4F0tmn0cdNO2m1RhcLgNanVik4J8T7OOdcWh3tSkR9FVaeoEfPDOMq+W
         WPfoQxSpJkPU3Pmub9W3R0tfu4bYxoxh6CxERlkzQCyiN36uzuFggxDMQA5zNwChJJSU
         1QjgUPXT3l1vb0tAwxJEasIWBVbqgu8E0iBkmfNWAo3M03i3muEjIgoTPp4PFArt0dpr
         jSQUxzHaFuZyModS6R4daZtvcrjTmDXMDzN9dC676WZItdf9WxNhIFTEwN53p4LktrwP
         0ej3g1LaZmOyEYQBZTOBb8NRlUFMXxM3z7qlInJDFctjIR6lwlI0nRA9ac0KrSbnmkKL
         vVEQ==
X-Forwarded-Encrypted: i=1; AKwUvBzocICb5tPQXvcjDvAprxIAdOYi6wBGxvNyBpNaW92KuN2BD0fPP2dMb655RM6tYF/RwkJVxHvtKmk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZtTXgC6rROLUErQdkT1m5zHyiWlJkNuEIVsTftpZDCtyf9NwQ
	0KCHDvRt7zNrULdWPRT3d62cuVntt2uA7hUXMB28RrG5I++dAJZmIpciHemu5A8ySw==
X-Gm-Gg: AYBFou19AMN3lQEvZxoJ41eI+MIeyDjI2DpLd/60w0GYczvABazqjnnQBFD45W2O/84
	d9K4oLN38HtPx4BoAiyibGJtoXfUKZlfdkGpZISBO1c00waQCm2tUAXNNG0smkRhVTDrPQ2ODAG
	dHKbj0/agBqPAHF6gyKE/q9eLyJvZP+5lCnyFkH/rzYO9Mp612gEeyt7E5hXLXQPPVMpO7ED06p
	kBEdwiWEXT4troczrXRIAIlD+ne0YHo/g49KIsmRzZNr9cA1f1CDmZk+xvgTwaDnzu5HhN0JelC
	MD37C1R/JwgV0bX4IiglVnV9Haas3bp82KFNv6T1N8lffigF6udG0n7LYJlz+KY9FeABgnE8nKr
	08Cw1yT8gXRsvMx1hU2XhVseujoanqYp+iQJJbTmUjeshz6IymoQpNZWyfdT72KZovD5Naa8eq2
	oFhCz5u8UKAVY1iku8i3wPd7PgAwzlWUZfRKvrGi8pqjIYuu09RSyo7dS8nv0KqHnDWiAwNhU5J
	gp3A/laxGWLCFv94NiocnvjrgxBTze2Oq3q5DjVlolLtNeoH1v0jcKW0xFOOJpZIrI4BX1hQ+xp
	/YSv+wG7JUKdcwlQcDZO
X-Received: by 2002:a05:693c:8102:b0:351:606f:2832 with SMTP id 5a478bee46e88-368ae2d4b25mr1068928eec.3.1792627283594;
        Wed, 21 Oct 2026 17:01:23 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:14ab:bfeb:ac88:458f])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-367411bc89fsm13245730eec.16.2026.10.21.17.01.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 17:01:23 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-pm@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 06/17] iio: adc: rcar-gyroadc: Discard pm_runtime_put_autosuspend() return values
Date: Wed, 21 Oct 2026 16:57:07 -0700
Message-ID: <20261021165858.v2.6.Ia4649c7263a5733426a8778ac4b2dc459f3ffef6@changeid>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261021235818.3059519-1-briannorris@chromium.org>
References: <20261021235818.3059519-1-briannorris@chromium.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This driver propagates the return value of pm_runtime_put_autosuspend(),
which is not particularly useful.

Returning an error code from pm_runtime_put_autosuspend() merely means
that it has not queued up a timer or work item to check whether or not
the device can be suspended and there are many perfectly valid
situations in which that can happen, like after writing "on" to the
device's runtime PM "control" attribute in sysfs for one example.

For this reason, modify this driver to simply discard the
pm_runtime_put_autosuspend() return value.

This will facilitate a planned change of the
pm_runtime_put_autosuspend() return type to void in the future, similar
to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
type to void").

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * Split iio patch into per-driver patches

 drivers/iio/adc/rcar-gyroadc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
index d38cf3caeae0..0d3b061d6ec2 100644
--- a/drivers/iio/adc/rcar-gyroadc.c
+++ b/drivers/iio/adc/rcar-gyroadc.c
@@ -199,10 +199,8 @@ static int rcar_gyroadc_read_raw(struct iio_dev *indio_dev,
 		*val = readl(priv->regs + datareg);
 		*val &= BIT(priv->sample_width) - 1;
 
-		ret = pm_runtime_put_autosuspend(priv->dev);
+		pm_runtime_put_autosuspend(priv->dev);
 		iio_device_release_direct(indio_dev);
-		if (ret < 0)
-			return ret;
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-- 
2.56.0.218.g1ec904b173-goog

