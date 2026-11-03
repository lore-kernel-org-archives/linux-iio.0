Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744596;
	b=WT3DWMx/GzMKPpQysMQtCbdKTN1jTmQOYNhQRULMCza6DJKK2Ssw2zVBPTKzV5iFUMxj
	 Ma159ma2OWFWbGkE0VHodqdLRu+ddxUjVt1uH9U32Pjl0+RqX4DflW56ZKbUzTNSZ6Fo7
	 9BR0i3yulVctuJ/03aQsdA9tBYu8RFz99nhUNMaULSAg7oypbqoKxMCjztfdOTFtfR0v8
	 FWM8MjOtlDcetEqZyzOprLS6F7/Ry1Bq0/GUsVMM1c+zY2thtQCAWH5QyWqKKlZGfM4kD
	 6j//3iZAofXmEBEut9zwI12nA8FPS/InYUU9DJeFLhRc4cHYe8m61ZUlAyHwIQ4O65g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744596;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=mtVdxBGNK8oHTFOTDJC4ciOsojwKNf2YHH+u+jkXh8g=;
	b=t9LpVAIoWQ8HIUima7VTyhIIsmOWdITb618H1TMAZd4S9XLVqP5TK8Fm8laBuiN6yHQw
	 dVcqNub3qUI1MIZ+cPvx7q2ZZMOOh7rURDA7+2eSOoL42HYy0jG4zgeOZwDGcf4NxtHDi
	 TwQRuBsRDrw0ySr9PNFPcP5HsES/jI5aRTIol8YX51OkJ+Qb+0zGwudYjDlamPtKJ29NO
	 5KvRY7DOzXCroWeIi5VyN1bhhayku5WWm2JOM9lFnUGzVLhfSeyBI0S3AhhhsbErln1Hx
	 DS6mAHVHj+g0ahl4HscySVBSA0ruo49tfd7HUW2sKGhnHy02noeEgF6afDFtlmTUH/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WI9KvTyk;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE19606A33A
	for <linux-iio@vger.kernel.org>; Tue,  3 Nov 2026 22:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FE19606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WI9KvTyk
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-15943c9c005so312441c88.1
        for <linux-iio@vger.kernel.org>; Tue, 03 Nov 2026 14:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793744595; x=1794349395; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mtVdxBGNK8oHTFOTDJC4ciOsojwKNf2YHH+u+jkXh8g=;
        b=WI9KvTykKKOoDsf+ULZVClTlXCFT12vjawevA+tAVPFVxcjA1lb8GA6wFRQW4E1YAr
         nJCH3oRGJdIu6cd4ZfETInJ2MLLkJd0O1DpjV+Ze4JrRG64qzaYEzNVSOJm+Jw6j0piB
         C0T1yd1lHdmh5L3mfpTIiS8wzn1qQTQewEp4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744595; x=1794349395;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mtVdxBGNK8oHTFOTDJC4ciOsojwKNf2YHH+u+jkXh8g=;
        b=aAZEKXrVKn5o/HUsbUHRFS/SU86wOgL6DnOMgrARY7LTXsKGKxNDOYHNARNdfmctYb
         Ol/wF6AHn1svKeVmUWxlZ9Te+LmtyujRtJlhO0s9CRYbNPaj3F+2h9rEKJ4vo7LoriEY
         nDFg3k2Osxc15CmIbqpcTr9TAAwut8YrXWiwW1NvaAp9t9jJzlg7OdUHIAO6ONzehWi6
         U1Ok+AuRrA6FPRfIWCOW6FgqoAaI2cE40cPrMWDyXehISOLPTvRTJDUedJ+0NQyWEgO1
         0zRf7WvgWIZXBSIsMJR+INdVd56uRQidaaUyyWf7wgCpjcPdTlsGpSA+AkE5Wbve8Xjv
         OV4Q==
X-Forwarded-Encrypted: i=1; AKwUvBzTPLpxpa2I4OXmf7jGWz+s65Xy//ByKjj2k+R+gxGX6qdoRVUKOfogGf6GHs/aR8fx+fC5wYRxw2A=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3QDPJJUqv4YrSOdxeI/rJCoXZX8R2uDUJQTvP0/zGhLpN33mc
	DBmhE1kcupmApo7+iG25hnVTaPHxfnAjuRa3SSpe9X7SdTwQ0ZDCMy4OEjVfYy8GPA==
X-Gm-Gg: AYBFou3Y4DDJqSf6mvpCxLIafi19DmXv84kXJUozjK1JpHcxGaRwsTlp1WVFnzKT615
	pgipbzsQTwtMcZd9+AhfTrF1WjuLTilpD/KCLM+h8o3jqp1KFGEeJB0OSqSewg64Yz2MbCFWl8F
	SU7X8lht9z1I+JD3pFh6ThMfzy9sfSDjqEA7kfxQbxtF5Hx2sodO1/l6mAlzyRz2MVhBLYLq3j6
	FUzBYVzs6ADRRWUsDmAeM1dl02Ed1Mr+WiBVi98ZA8jwHtE257zM7ZdI0y7J7+3ezSmn6OAbVg/
	czvifIIiYiX3TPF3lH62Ga4B7f1poeYRMAe70Vs5jpQNG5e/h8BL/kr0lvyazzzzAChihAexzL9
	TybEiahh9oBIPtoyEc0xsUzjXQGMpezupq4xy1Zuof3ZMDEFTe+Gde3+oQ98ROCMJBllXm0sOI5
	Rzqgf7mk1zX3ZCkqEskx+M9wfFGBTqcBdsXqhHMZ0vx48icwiuxpSZBqEgXgnlyMmnSAV9blLyA
	SfTwOZnOUO0xkIZqVjyAOa8R+osiKDfRusdiWdwyh6etdCGkyS71fObgke+A3ZmK/i8JHg6Bl8g
	AFet0j8LXGSQkie87MQio7YMnD0sfhYx2rLazyQ53FXFck1yjsufucKGVfNxw1lU7kLc
X-Received: by 2002:a05:7022:e27:b0:14d:cb67:afc4 with SMTP id a92af1059eb24-1ac5e8e1e4bmr29270005c88.41.1793744595232;
        Tue, 03 Nov 2026 14:23:15 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:ab71:b3df:693a:fbf2])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1b245b8822fsm2254589c88.2.2026.11.03.14.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 14:23:14 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Brian Norris <briannorris@chromium.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v2 5/5] iio: adc: stm32-adc: Drop runtime_idle()
Date: Tue,  3 Nov 2026 14:14:43 -0800
Message-ID: <20261103141442.v2.5.Ica1e32ae51d7975844386684d2b6a097f3ca9122@changeid>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261103221717.3840215-1-briannorris@chromium.org>
References: <20261103221717.3840215-1-briannorris@chromium.org>
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

This runtime_idle() implementation was added in commit c537d3457542 ("iio:
adc: stm32-adc: fix runtime autosuspend delay when slow polling"), to work
around a suboptimal behavior in the runtime PM core. It should no longer
be necessary as of "PM: runtime: Propagate last_busy from dependent to
dependency".

Signed-off-by: Brian Norris <briannorris@chromium.org>
Tested-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
I do not have these devices to test. I have tested other drivers, and I've
verified this behavior in unit tests as well.

(no changes since v1)

 drivers/iio/adc/stm32-adc-core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index c409edd3a827..0193db7a2a7f 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -873,17 +873,10 @@ static int stm32_adc_core_runtime_resume(struct device *dev)
 	return stm32_adc_core_hw_start(dev);
 }
 
-static int stm32_adc_core_runtime_idle(struct device *dev)
-{
-	pm_runtime_mark_last_busy(dev);
-
-	return 0;
-}
-
 static DEFINE_RUNTIME_DEV_PM_OPS(stm32_adc_core_pm_ops,
 				stm32_adc_core_runtime_suspend,
 				stm32_adc_core_runtime_resume,
-				stm32_adc_core_runtime_idle);
+				NULL);
 
 static const struct stm32_adc_priv_cfg stm32f4_adc_priv_cfg = {
 	.regs = &stm32f4_adc_common_regs,
-- 
2.56.0.398.g882cbad275-goog

