Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23514331215
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 17:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773682090; cv=none; b=JIEYPbUHgyeabxVrwG5AOKuG+VT3Kq2+aH1ecR9UuLSpra2KdVQg4GjoYnRp+yKKV+Ua5EjooP8Z5yB1r0Vn6IloyEUoUJM4fry9mz+2yLxSnRGeGQ25BHqwo5APUeejh27/Od8Ct2RhqRz3dqvqLMHBngNgnasida27CjF9EM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773682090; c=relaxed/simple;
	bh=5YGtrRDq8ooKXsX8CiLRFRvIdmuPExPvepOdmFuD5qI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=suSr7wdeq9ifiIpGwWoCb5Vwns6QySRSDWtcjHoduQyehLPIo1xmz0w6KJ3xBk39cVAnG8h2D8/pu5DjiAPMPB/p0c61KUIx92kb6vSJr5xOm/VvwhkowzcVtwBhyer0JV8bcRgE0EdSln7QEsZAdvH9uKU5urflUbMBqliF2Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDR/Ymhp; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDR/Ymhp"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-829865a8471so4564246b3a.3
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 10:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773682088; x=1774286888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrniVMmfDN+xSnBB54KhdubfbYa2sZYHaW9MDFzlvxE=;
        b=JDR/YmhpjpZwLjLQtzd4YjB+I44UL0oieBipg8g34IfxUwGNq16tyJUP3Gaq6uKk2G
         csq7o4SX/c2RA0UoEXF2x3nrV2C2bZNqHauRmRjisnSCC/hNU9Pq5UxcCVh5UXdIjOxC
         gzpUQFUqO5OR1w/7KtQPXbTV5bRslIF50r8tQ4b44PsAoR8gAhjlQpD3BXBsgqGBcXAz
         fzBX2GpCjeINnS1Nv3iVpc60ao7Rx7ofuII0l3jK2RXcBLsO5ll4xNaU2nCmRGg7FYOc
         AKpiqas7p2tX1luCJRh3WzWg3yAoKtjrSYTgvo+HjFcs6W5Uj2/7xu86oaakiJj1Jhdb
         cP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773682088; x=1774286888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BrniVMmfDN+xSnBB54KhdubfbYa2sZYHaW9MDFzlvxE=;
        b=hVOpBz7F6bnq5L2UWCDc+SQ1qu4cRPDOIX7uUYEspahU7P9Yiiyq+JwjbuLzD4R/A9
         UNRNcjD6Sk6Xd7w9qsoQq3Wl+q0xR2gmCyEixEkN8bYTHmV7/CCh3TZpaUq/+2lyWdWo
         9wCUsLSfypRK5Ms+mvmwqKqyKTfITxUOkzqWrZ3X70/YiM/SEzBV+kklOhLeRogb6Q1t
         QFo6/nJpYs0F/4O982Q6Jqjp7IGzKpfY5KkLb94fJWICGx3SZ/XBfMpDi5c6VApO48p7
         EjKvURtNrkas/1YRoSRWRu4JSZ9XK4W0+wqmVhR4ML7bqPg/UYEYE/6+tNSPbKUdEEdK
         4kqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzIRApDzWMxpI8yx4jl2owl6IfBSWUYKYeCpo+c2+Bj3BU/jAvmmnYctooLc1mX6FpoG2hdJGe7Rc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBQytfULG6XfVtQdRl/MuZBdC7x4hQEMf6BsXHOFbKtmD0nfF0
	E4dauBQFt6x5T/bcfNIatHGVykchpuARk8UgzsW2tAiK/JvvkLB3VUUL
X-Gm-Gg: ATEYQzwJSh2O/mSeKMpiV8mN79yEVTmx1Um7N8aLHSjQ2ql3eQdx+HPha1mWdutmzuY
	JgHvbpbABrQ4y6OBG+AKJWPTFZlC/lbs2TqQYBwpq21/Fkce2DBHWOxFkd/vm2zM374Yz2Fj7lZ
	Yxs4o3vhoNXxP2AQ7ke6Fb1bAZGVqqWoCdf0jPQcTPg9QNE3neQ6hrRfgUnuaHtO4gKa/ec+W/R
	thTFXOA6Jn7IlZVDBWXy4X3/plL/nxOw/jOxdfc0ddMO5dEZt4CjBj6B0/BUJ/VKrQOt0AUeLsj
	NKxKtY1gGl9+9eBZ1BKENhgeqPj6XNhR/V54Spq1e2aNajKbCJqEm/mGXxBDtuPEI0KCian9ZuJ
	CYAa2/tf9ewSs1U+vW8thgqSyZjSWEIOy1TFdJCtzxDONcSGSa5uswYFWBdtms1eJRP6x8ztfka
	CGyBteDDkJ6UO4WNVoW/LMaMhhRCOIaS8SusLAJ9Rgm9tJyIh/CliGU5qgvjtramUf48C78wvCE
	wlU
X-Received: by 2002:a05:6a00:bb84:b0:81f:52d4:a5ec with SMTP id d2e1a72fcca58-82a1990d95amr12392968b3a.43.1773682088359;
        Mon, 16 Mar 2026 10:28:08 -0700 (PDT)
Received: from atharv-HP-Pavilion-x360-2-in-1-Laptop-14-ek1xxx.. ([103.216.213.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07341986sm14016183b3a.32.2026.03.16.10.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:28:07 -0700 (PDT)
From: Atharv Dubey <atharvd440@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Atharv Dubey <atharvd440@gmail.com>
Subject: [PATCH 01/11] iio: ad_sigma_delta: replace deprecated iio_push_to_buffers_with_timestamp()
Date: Mon, 16 Mar 2026 22:57:27 +0530
Message-ID: <20260316172735.11430-3-atharvd440@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316172735.11430-1-atharvd440@gmail.com>
References: <20260316172735.11430-1-atharvd440@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iio_push_to_buffers_with_timestamp() is deprecated. Replace it with
iio_push_to_buffers_with_ts(), which takes the buffer size as an
argument and helps avoid potential buffer overflows.

Signed-off-by: Atharv Dubey <atharvd440@gmail.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 7852884703b0..73f3069da987 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -636,7 +636,7 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 	 * once, there is no need for sample number tracking.
 	 */
 	if (sigma_delta->active_slots == 1) {
-		iio_push_to_buffers_with_timestamp(indio_dev, data, pf->timestamp);
+		iio_push_to_buffers_with_ts(indio_dev, data, sizeof(data), pf->timestamp);
 		goto irq_handled;
 	}
 
@@ -662,8 +662,8 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 
 	if (sigma_delta->current_slot == sigma_delta->active_slots) {
 		sigma_delta->current_slot = 0;
-		iio_push_to_buffers_with_timestamp(indio_dev, sigma_delta->samples_buf,
-						   pf->timestamp);
+		iio_push_to_buffers_with_ts(indio_dev, sigma_delta->samples_buf,
+				sizeof(sigma_delta->sampkes_buf), pf->timestamp);
 	}
 
 irq_handled:
-- 
2.43.0

