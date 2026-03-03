Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF87438C40E
	for <linux-iio@vger.kernel.org>; Tue,  3 Mar 2026 09:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772528674; cv=none; b=kp8ApFff9LMuw6qGdn5P5hCH8OL5dA41qmJO73M7DIgTZands5matTmZTjYTgYybJGvOn9xEOpX9uqMv1UvomgTtThKAyKZIL0DTMGmAVnjFYwgeCyk3Q9f1ZKpixgyD7sUGhSQwth1yqKKsPKMtA3+3jgnjNIPPwFzIOvybqBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772528674; c=relaxed/simple;
	bh=+SjfXXKp3c0wc8KEdqgR9dPREkkj2LhhEMz0XvYDYRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IH0PSivs7W209TtkXvQDzLQw2B126E3FVUb2Y5ccCxjr+M5G3QkkMk8j5g5z1XQDaE4xGp2e7g2e5y7GFjdPymrmaI9n9foeN9vWjRN9MubldGcTPdXB8B01YfnIkkcfwr/FDqwyQgkBxguWHQcbXbX8gIgx63/Wo/YczyAgV+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c70bb8ffb24so1982267a12.1
        for <linux-iio@vger.kernel.org>; Tue, 03 Mar 2026 01:04:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772528673; x=1773133473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0L3t5+5v1063qWjRief/SwRioE8DmiEkQhc2hG7+TeI=;
        b=fWXMIhhsH+dS94GUm5YoGL4odYvSEOyoyaKC1DYnZb7KQxT5KhYudr6QYpBVOuNUWb
         BkHDAWkyJIWuE+tsxDSM7fndJNyKj9PHRZs0mpIvAlyRLqrshXvNu5+b71s2p66yOh0o
         JY/qBe/94LUHC09hQeSTeNiHc8kMhtMu/PAsBG0Sa0KQQZWTBGturZN/YIWmdC7bJASi
         nCM20AIYSgpiUoSfjojv6AKb0e3nlmKLskzqa2zdXP/ETDagHwAHNj2mkuOAPB7ta1JM
         PHmbSqTh1WjeGw45pI7RuOKvLlR+pKbe2ZYXVvd79do63hh6e5Gb2kktQHgWCA+LZdIV
         6qsw==
X-Gm-Message-State: AOJu0YyJ/YcoOy/fQWxTH403v92mhYp1+W04coVSAh71bKmtC6s7s4X5
	wJ0y6O9LIHSRZf0mW9YbgIs9X8SxJXKdHA4G+3oV4duELLXfFxZy7llcQEGGAgqehPQ=
X-Gm-Gg: ATEYQzzA18JvXpjYuuPRau8xdKk1R/5K0YbOSHyQKHjS56ijakFdRFpuNizEECi5s9Y
	m0kAL62iGCxTovdfL8Bk3HtfurFxz1l2e6A6kEhPAn+L61/EP6z1nQAGvltWwH2HX0g2LmAlTd8
	z7+o3yIDIpdPWy8bBRdzJw242bAxeArCFJdoxZEd5DLDjgJm3YAIcjvjGU+36Az+9kAYPbYOsf3
	ZFH4SgayoYZBSJF+dP10Vj5/NExjb8mkhjGbejHzfMdK/NwYuXoMfCef/QUldTKHaUZ2bqgI8P4
	64znHv6/FEb5ExhAAF77WMkqumd/ANBiwwZN9qTA7X8Ej4sKqLEptOLZfnswsrTgY9tQvmhFDsK
	GnML/AaQcDA/EKPowQzual6JER1NMCbhxsOI74+eHVNexvbakrwJ0EMVkg7jhVXxmTQOPUK6kS+
	Gpax+/Yjh9PHa4+Wca
X-Received: by 2002:a17:90a:d40b:b0:359:8f4b:6ed5 with SMTP id 98e67ed59e1d1-3598f4b6fecmr4980226a91.15.1772528672828;
        Tue, 03 Mar 2026 01:04:32 -0800 (PST)
Received: from archlinux ([59.152.111.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0792sm1638259a91.14.2026.03.03.01.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 01:04:32 -0800 (PST)
From: Siratul Islam <email@sirat.me>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	Siratul Islam <email@sirat.me>
Subject: [PATCH 3/3] MAINTAINERS: add entry for ST VL53L1X ToF sensor driver
Date: Tue,  3 Mar 2026 15:02:42 +0600
Message-ID: <20260303090253.42076-4-email@sirat.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303090253.42076-1-email@sirat.me>
References: <20260303090253.42076-1-email@sirat.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add maintainer entry for the STMicroelectronics VL53L1X
Time-of-Flight ranging sensor IIO driver.

Signed-off-by: Siratul Islam <email@sirat.me>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 61bf550fd37c..cb8ee607fda1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25093,6 +25093,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
 F:	drivers/iio/proximity/vl53l0x-i2c.c
 
+ST VL53L1X ToF RANGER(I2C) IIO DRIVER
+M:	Siratul Islam <email@sirat.me>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/proximity/st,vl53l1x.yaml
+F:	drivers/iio/proximity/vl53l1x-i2c.c
+
 STABLE BRANCH
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 M:	Sasha Levin <sashal@kernel.org>
-- 
2.53.0

