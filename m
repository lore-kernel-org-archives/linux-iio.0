Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6673118A6CF;
	Mon,  4 May 2026 03:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777863924; cv=none; b=VXme9KvVM7gx/erZGATVXsAaKgADpjEizxxJvL5OS1lwYQQItJznp+w0En2rH3jGf0Q3pzx2lpXK/qGfWq8vKa6o7JhkP1VmTnBryBRCugA79q7GIf4jfetvGk/FAzOb5LWs8Ob5eM0uNzpbGP970rxGA2wlaxNYJQqUJYxsQzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777863924; c=relaxed/simple;
	bh=4tUDiHewklMnnYJsJxoxFTvpGCB/TtqtG6K/kMknxcM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GdgkOxWMNUqeoS5xvZy9bE4Vd8+OpNX7/QlDlFHBWtmpJ2OZBMOcu0JJCJGebwvD6LCLxCJVBBWr381u8sTfQa59m9OaFu6pVMY9UkPKKFmt0Uv0MEAQf3mprN/P4HW6fTQ8MMFHAu13E2rKmUCbuSTju6JLlabDocc/Q2j3Ezg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JpO+Qs2o; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JpO+Qs2o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ma
	w8hV/NSqLcLCp/h6NnoRC6tg/lPAJ5qVCp8kuy+Q4=; b=JpO+Qs2oRMa4Yl+qT5
	b2r7M3Rtinif233b3JHa90Hu24DyWS5kVxQFXaYHU4B9jNFNX1seNP8sYP5VYeo+
	mKmdaD9u8T9ZENvd0kvcyk+2zU4StEk4WZkbFnHxp/NAMQXms4RP0twXJRhVllV3
	KfMJpRPBKpfBMcnShw5pQKCAI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wBntLOwDPhpacQZDQ--.45044S4;
	Mon, 04 May 2026 11:04:43 +0800 (CST)
From: Miao Li <limiao870622@163.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	waqar.hameed@axis.com,
	dixitparmar19@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	limiao870622@163.com,
	Miao Li <limiao@kylinos.cn>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v4 2/3] iio: light: stk3310: Replace uint32_t with u32 and reorder members to eliminate padding
Date: Mon,  4 May 2026 11:04:07 +0800
Message-Id: <20260504030408.105762-3-limiao870622@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260504030408.105762-1-limiao870622@163.com>
References: <20260504030408.105762-1-limiao870622@163.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBntLOwDPhpacQZDQ--.45044S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr4UXr4kCF1DAF1Dtw1xuFg_yoW8Gr18pF
	s8J34SyFW7WFWkWrnrJr4jvFyYq3yfJa4akFWUXw1avF4avr1qkF18JFyxCFnIgryUCa47
	Jw4v9FWUCa1jk3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zMksqUUUUUU=
X-CM-SenderInfo: 5olpxtbryxiliss6il2tof0z/xtbC7wzOnGn4DMwj-QAA3+

From: Miao Li <limiao@kylinos.cn>

Replace the uint32_t type members in the stk3310_data structure with u32
to adhere to the unified kernel coding style, and reorder the member
variables to eliminate memory padding holes.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Miao Li <limiao@kylinos.cn>
---
 drivers/iio/light/stk3310.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 86cc6e8ec..0447fbf1b 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -115,12 +115,6 @@ static const int stk3310_it_table[][2] = {
 struct stk3310_data {
 	struct i2c_client *client;
 	struct mutex lock;
-	bool als_enabled;
-	bool ps_enabled;
-	bool ps_int_enabled;
-	uint32_t ps_thdl;
-	uint32_t ps_thdh;
-	uint32_t ps_near_level;
 	u64 timestamp;
 	struct regmap *regmap;
 	struct regmap_field *reg_state;
@@ -131,6 +125,12 @@ struct stk3310_data {
 	struct regmap_field *reg_int_ps;
 	struct regmap_field *reg_flag_psint;
 	struct regmap_field *reg_flag_nf;
+	u32 ps_thdl;
+	u32 ps_thdh;
+	u32 ps_near_level;
+	bool als_enabled;
+	bool ps_enabled;
+	bool ps_int_enabled;
 };
 
 static const struct iio_event_spec stk3310_events[] = {
-- 
2.25.1

