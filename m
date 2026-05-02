Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074DE221721;
	Sat,  2 May 2026 05:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777701557; cv=none; b=D3Mp96TMfL6Q4gU8vbR0snz1QDnttx01zbRyNVrPGDt9+/gimN5k4bly5Fek+ftWTDnxDsC2bM+Ve6UusxWOG/F28Cj3bprQua82zMWeGGuUohcOXxLw4jEA4yydc3qyKZciCg5vzt1ubSVXuu2aXxNq7u1w53ppXW9pE1kh+SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777701557; c=relaxed/simple;
	bh=Vid1JBj8nCuW5dNpbsPqf85nkSqP3+GErdBE5ojAtwI=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=o1XkLasrZ4+0IAIXoFpbbojxXhqZakzmyH5a4qFpaaE0km8thaLkt4pR1/nf8RnFSa/21i0iClUDMEnraqub2K+Y5tfVpTjLW0dlcyLiz0X22QWrcTCAGxP+OmWDQU1/OZK6IG8fVjSWR2nyIflknkOJ9+JzGpPtIruHzKTnLoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=vLBc3V7j; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="vLBc3V7j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1777701542; bh=Jky+evJLIqJaEQMGtWnaMU3ymJWVi3lFosEz4lTsbq0=;
	h=From:To:Cc:Subject:Date;
	b=vLBc3V7jqzrcgSCfvYoY1bqFgAtwp0mXvhohzcwK+EFqIqXVIBsammbIY/SVGuRJG
	 ZGNNG7Gz1CSN3nLbIcDpUGjM4Lic1EpqviXz8zrxsaVwW+I6sty579jDmGHY2g4z2B
	 cKuiAao4lCSGuZMVgzYUBmUG3NlDbZEZu4XBak7k=
Received: from Lang.smartont.net ([223.88.152.211])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id EBB2F2C5; Sat, 02 May 2026 13:58:59 +0800
X-QQ-mid: xmsmtpt1777701539t9lvf3yer
Message-ID: <tencent_EC2F0940B397D1EDA5D60A1B371BE8251706@qq.com>
X-QQ-XMAILINFO: MTEqvtFah3ZeKgHPvQV7Q6CT/8jmwzwApgIIEnpgsII2XP03o2mjGpymKQxEV+
	 a/bGfM0IFMO3XrHrp4mYV7fzfzpQenhKB2UJ6bMyUMo3WzLccIdNa03d+kjbx8quU9T6lIKAGTN8
	 46x1xZmXfZqvRiaiXmoipvOdh2+fZUmgQmC0O/Yf5EO6vEvJHyaffSMf8feOPlcwvYDSibkKuKuQ
	 uc2CE7blH/rEI9CiE9QvawpPeglnVSxct7rgMwWF2zIDHsbw+JgQfvMdXiALOaIHBqNGKEevv8Bp
	 s41NT+Fyf225LICiUHr+lCqcRA8k0xorwPu3q0OdIGH4KW13/kXaUxgOR7zxxuDdco19UVLSvTQm
	 qJrrcEGKUO9BccKflFKWVN2lWqBszS6Nw5fyrfDbFpdxiXhcPzWU8A1wkGCCCo3+XcZ5mxllhI17
	 zipbM/j/kfkq1Z1sY3o/QphSXWOMpQQDbYoJDIDObX4bhLZ/FZK19XxK0goxsj/s7eBOaceQsM9s
	 Nk3Wgpe2TnTRADGDdumKckL6pJEJjFVC+Vsst6l1L3OyJgyACftmBuqtSsMiIZVq4Sz47510j8dZ
	 teySuIQiMFqYgAo/ejG4RxnOp/wF9WvurM7/QLFrbaqFJ4RG/HcL1lkS6otQYV51d2DNabBG3gyf
	 Vi2693WsKUfO07Rq1ylJP7t9wmdks7EyY/7z1Dc3T9J09HRF0wx4cZJBPLdTXtG4NvNRTJrX+YxP
	 o1qgTnfrD4v7rOQj9qscafXhQTTW8X48P1pZAFhSAAiL8wBxIffQe0OvhNZrASh4J3ohWWXa9js9
	 YIPeIbgIBAi73rQFELtxMY3pjYLkNu6632wqXgDXgGfkuE2cUB/OZ16oqXVWP/nts40KwULt+qKD
	 Z2e+UWa3Kyxp4vDZZumpSeDkqQkZW6oBUZTMAupY364Myuwcphe5ksPCAaNTQqx1KLVn+rFMIMHv
	 474A2bigjDNEKBytXipbegrpd/xDxxv91Jg2qy/3KcSDi8WqWzK0Q09O20YjDTdfRA37NBtF74fM
	 kZuYuZZkGyB2ErvGJ2y4qTujLYNWDh1uupbSamoDNadPciQKW9v+kpaL+9Vqg=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Wang Zihan <jiyu03@qq.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Wang Zihan <jiyu03@qq.com>
Subject: [PATCH 1/4] iio: adxl313: fix typos in documentation
Date: Sat,  2 May 2026 13:58:56 +0800
X-OQ-MSGID: <20260502055857.115293-1-jiyu03@qq.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add missing space in "ADXL313is" and correct "a single types"
to "a single type".

Signed-off-by: Wang Zihan <jiyu03@qq.com>
---
 Documentation/iio/adxl313.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/iio/adxl313.rst b/Documentation/iio/adxl313.rst
index 966e72c01..3662153a6 100644
--- a/Documentation/iio/adxl313.rst
+++ b/Documentation/iio/adxl313.rst
@@ -11,7 +11,7 @@ This driver supports Analog Device's ADXL313 on SPI/I2C bus.
 
 * `ADXL313 <https://www.analog.com/ADXL313>`_
 
-The ADXL313is a low noise density, low power, 3-axis accelerometer with
+The ADXL313 is a low noise density, low power, 3-axis accelerometer with
 selectable measurement ranges. The ADXL313 supports the ±0.5 g, ±1 g, ±2 g and
 ±4 g ranges.
 
@@ -112,7 +112,7 @@ apply the following formula:
 Where _offset and _scale are device attributes. If no _offset attribute is
 present, simply assume its value is 0.
 
-The ADXL313 driver offers data for a single types of channels, the table below
+The ADXL313 driver offers data for a single type of channels, the table below
 shows the measurement units for the processed value, which are defined by the
 IIO framework:
 
-- 
2.54.0

