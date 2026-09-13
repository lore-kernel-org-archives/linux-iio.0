Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE761D5CC9;
	Sun, 13 Sep 2026 12:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789303881; cv=none; b=SP8858HKnDYNjA5ZY2BqqnwgjcBf9zCiP6ndt3tjGQZNNrcRsdFbpVmbAGsq1Yv5Y/HM4vjL1Bd/FeOUSuXZCaZuB86hidYjwmtnJ8itN2Md4q7UHZIrmkW/e0mEro0Oa1/ndr5doh0I7SEWUZX/GMppJvTJtnnNIF4ty7q4F7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789303881; c=relaxed/simple;
	bh=WcQwIcXbEq3u3QiwMxFJrUcilFjfCrpS/TuesJWFQLc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cD5uUv4/hLYASjJjPPnMkeBJ2rdwlHHxZPuMDjNyXsMK7gEcKFIU3dIbgBIdyDRsuCCQIWqO7ixh4XX2CvohfvgFuQvDfBh+uepMrNcsUnOEVIx0tyfF3Z3e4WBdDh06ey2Ew2sxm6x1bmc8gpB/gJaHv11XPvWsEQfehgxcFEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=eu2u/G+C; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="eu2u/G+C"
Received: from seu.edu.cn (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d907a3c8;
	Sun, 13 Sep 2026 20:51:09 +0800 (GMT+08:00)
From: Slavin Liu <bolin.liu@seu.edu.cn>
To: marius.cristea@microchip.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bolin.liu@seu.edu.cn
Subject: [PATCH] iio: adc: pac1934: check ACPI label duplication
Date: Sun, 13 Sep 2026 20:51:07 +0800
Message-Id: <20260913125107.109723-1-bolin.liu@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa09ad24fa803a1kunmc3e4c65d25110f
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGE1DVh0aThpNSxofQh5JGFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0
	NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=eu2u/G+CSMAlD0eBl7qrOi2pB2nZA6LoUeP3dh1mZeQTsI9yECe+MvzpRVlpqSje0Mbp4aN/XQnmyhRsuYshRy3VzPiozk5fGuVX7TSxJ3GUC6EhfibJfBGMuFXBbvw8Tshma/WLMFIvdcuTMPYTBD5uZkn1j65YjpejiwyJjG4=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=qzyfClCYC46SHevKcApJiToYYzWScGrpRSW0SLCVfl0=;
	h=date:mime-version:subject:message-id:from;

A label duplication failure currently reaches the terminating-byte
write. Release the ACPI result and abort before accessing the missing
label; earlier labels are managed by devres.

Detected by static analysis and reviewed with AI-assisted source auditing.

Fixes: 0fb528c8255b ("iio: adc: adding support for PAC193x")
Assisted-by: LLM
Signed-off-by: Slavin Liu <bolin.liu@seu.edu.cn>
---
 drivers/iio/adc/pac1934.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
index 23055405a6e0..de59dc27c440 100644
--- a/drivers/iio/adc/pac1934.c
+++ b/drivers/iio/adc/pac1934.c
@@ -1108,6 +1108,10 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 			devm_kmemdup(dev, rez->package.elements[i].string.pointer,
 				     (size_t)rez->package.elements[i].string.length + 1,
 				     GFP_KERNEL);
+		if (!info->labels[idx]) {
+			ACPI_FREE(rez);
+			return -ENOMEM;
+		}
 		info->labels[idx][rez->package.elements[i].string.length] = '\0';
 		info->shunts[idx] = rez->package.elements[i + 1].integer.value * 1000;
 		info->active_channels[idx] = (info->shunts[idx] != 0);
