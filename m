Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C695435E936
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 23:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776899636; cv=none; b=fMMetyyWnAG+Rptarh2tk+f6JuIbIxcGRx6dr4mNfh8GyaXzimcWiK9tf5XAoxvkNqgxDglpjE1rjxUD6f0C/87TwpUDfGscPH9Xjky2bwDCiRT+kmK14kkguXYe2qI0/U+IVhGF5bLriFaMa9K/p2KUdWk+eBvDR+VlQe8kvrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776899636; c=relaxed/simple;
	bh=dpv6fHgDLq0iPcI0voJv7oyanUj94UpkU80BmQsN9M0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtM2TpteTGVDFprzBJA+mUuPDjRCZCy9l6+dbaWF/w5UbfWDjlbon5jgyiKsCv4zeNo/6a14h0El1H5Ot2bTlaQQyJO5K7sD0VgB129Xs0ha2w078oGsIOLAeA/zPseEcorhJIw2cyCVYoeY4wjOAg3Ln8IZYBfEwg+cMkORywA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=Hg98IbKT; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="Hg98IbKT"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-56f70865797so3309966e0c.1
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 16:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776899633; x=1777504433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fy0FBtaoLXYN74V44cY9vtNObWtERC6ZqFTzsx2l3io=;
        b=Hg98IbKThxp4eiq2YBv/bh3VRCOet70nIqvY+jQ/RgY2XxydN0PF+NqfEybZPImSQ8
         ra+EQ3ffMj9OTPs6kj+hxwEGXEs0GjjV2WtUFDiV2ENgiQbbl+qYQFlodCyFSGpYq2uz
         wQ9RfsuMPYUQc/VQmh8yTcgtMVMeTjpW+3AJTRZ8cTsHJRZs1LYjxrYu7rxrRMziTLrG
         EnBGNqu/oi2DT3rRTH0xEUZktAQgp0pYxGKbXYnJZSJricFgBMcvJnjlrEgGokTAjV48
         pHrVrV+WswlCYWcBpySc9/S6lcWThzTE/c3EhRdwvlNY5Qv7geK59c5njl8KJhkbwXmG
         jo+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776899633; x=1777504433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fy0FBtaoLXYN74V44cY9vtNObWtERC6ZqFTzsx2l3io=;
        b=XwFgwvG6M9gv8nyFQIxLK2X5J+z8Kks2FMZbmFOpbopwlQmWwRpjt+zqPk+pRHvfzQ
         tMT/fx5GILTWSDdP1kyLXo8IB356bXuEujC927q3EtwYX5UPdSZHtVNX+Y6cBmi691Mz
         R15u86+oTxYzA6OCLJYfUNA1WrRDpUotJrG91gaqRxYmP++83LwMJfSOJvC1s7IUUfi/
         68uBVcsvZib41cJM/Iks7CdxPPY0vd2la+ri2JWOVQzEfFRTSPuMGB3sSExbQ7Jrs0Ni
         uvhkOE/HkokvvyzmG24JuHsNqMyGhs5MUHO06MI6hTCTuSuCCq8r+2023rScMNS+8O0u
         VG5A==
X-Forwarded-Encrypted: i=1; AFNElJ/xOSRV4NMq1neAT9MNfdsvsSalkryskPbuUZNENpeBcwKtXoPSiYdz8P9xAKLN1hA1Pi3gLNOeaAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/hNi9VWC6QCPPM2xBti0asK25x23vwoYo46C4o0coX7svtRPb
	PdBSWLle69MqkCj3zgOKAAouOUsrf2/JfC/uINbyZeON6YTEXboVm/acN6CBHEzqcSo=
X-Gm-Gg: AeBDieuDL1l/5/FxOTxLeHXRpLLXnQKyUVQ0j37DCpLAmZzsoANfvbYlTQHg3ZF3/Mt
	ptKPVPSxsPuOUwtcqWPncrWc6bpx+d7tEJzSGL00VLUzFeMUCtuHEbQCxWlTUSENk/QT22qvLMi
	GfHqxRW05Iyznjo3sT/kAy7XSspBxa5T+fqmGye0dGPRrrqP2Z43sQ3PaZWvQ6DfytUVJWIW5R1
	EHLESqT9xrhSO+M5e6CpkYmYZx5jDDn+gdIQN/W1zcyWq3iU51zqguxv5rkXiEsb+0an0wj/5+Y
	hGInpIYc7Xk4hnjLeh1Vfq9oJ5TR6gDoT+oN70BU2H2zp1n1OQqVXvIURrYM1jkaC9mf0x57RRs
	jHE1YKCNzFYzSTX3PcnhTpzcpstmwbOXQprQVoGO7EIOfY4pksqcg7w3Qc+y5B/WNzTNrlOQBoS
	MNQFBsvL9XO2PBdbdN8bdWG9db4ykQOg==
X-Received: by 2002:a05:6122:4d0d:b0:56b:5893:d042 with SMTP id 71dfb90a1353d-56fa5a8ee80mr12723854e0c.12.1776899632749;
        Wed, 22 Apr 2026 16:13:52 -0700 (PDT)
Received: from sales-arch ([2804:7f0:d889:b103:1320:e321:eae6:2f6e])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa91ea606sm10669834e0c.5.2026.04.22.16.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 16:13:51 -0700 (PDT)
From: rafasales@usp.br
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	nuno.sa@analog.com
Cc: "Rafael B. Sales" <rafasales@usp.br>,
	"Gustavo C. Arakaki" <gustavo.arakaki@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 3/3] iio: light: ltr501: use `sysfs_emit_at()` for showing scales
Date: Wed, 22 Apr 2026 20:12:57 -0300
Message-ID: <20260422231305.677778-4-rafasales@usp.br>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422231305.677778-1-rafasales@usp.br>
References: <20260422231305.677778-1-rafasales@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael B. Sales" <rafasales@usp.br>

Replace `scnprintf()` with `sysfs_emit_at()`, which is
PAGE_SIZE-aware and preferred for use in sysfs.

Signed-off-by: Rafael B. Sales <rafasales@usp.br>
Co-developed-by: Gustavo C. Arakaki <gustavo.arakaki@usp.br>
Signed-off-by: Gustavo C. Arakaki <gustavo.arakaki@usp.br>
---
 drivers/iio/light/ltr501.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 81fb35cbd56a..3866aa2c8abf 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -9,7 +9,6 @@
  * TODO: IR LED characteristics
  */
 
-#include <asm/page.h>
 #include <asm/byteorder.h>
 
 #include <linux/array_size.h>
@@ -1114,7 +1113,7 @@ static ssize_t ltr501_show_proximity_scale_avail(struct device *dev,
 	for (i = 0; i < info->ps_gain_tbl_size; i++) {
 		if (info->ps_gain[i].scale == LTR501_RESERVED_GAIN)
 			continue;
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%06d ",
+		len += sysfs_emit_at(buf, len, "%d.%06d ",
 				 info->ps_gain[i].scale,
 				 info->ps_gain[i].uscale);
 	}
@@ -1136,7 +1135,7 @@ static ssize_t ltr501_show_intensity_scale_avail(struct device *dev,
 	for (i = 0; i < info->als_gain_tbl_size; i++) {
 		if (info->als_gain[i].scale == LTR501_RESERVED_GAIN)
 			continue;
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%06d ",
+		len += sysfs_emit_at(buf, len, "%d.%06d ",
 				 info->als_gain[i].scale,
 				 info->als_gain[i].uscale);
 	}
-- 
2.53.0

