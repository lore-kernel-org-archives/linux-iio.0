Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2DC32F75A;
	Tue, 10 Mar 2026 03:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773114367; cv=none; b=C1aw37JqlJS/6CjlJWiDATBhO5gPTzN0otl3+FzIQ+tMUwzKd+CYcvEnTkikiDEk1WIUvN29F3OrRiktEfLe/4I0qJ6JHb85dlJOUxYYRTdZE3q5cwmcKJpLZKuHuFrCs9tx7RcCaUPQCCSQSXjTS84kT+d/TorS+7DUy3i7eus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773114367; c=relaxed/simple;
	bh=2+RywD1SG6fL/15LKr+bFwZWO5jS0RH8hcA1pPvJRyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NuKG7Onbp6PmtmNJprfY3UKsIfEFhTsMiouRkjm50l8C/NSjxrTgbHpnSgVzYUunxOx0ovu/luqHU7J+yWBoqDm8zSrPI2jkHBG5g9QaLuF+qOU4BazEePb/rg2VRHEoIUGjH1oCe4FtE3bHv4+CsrzW5ReyApl1D2NhV7uHjik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzyb44Ra; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzyb44Ra"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DC2C4CEF7;
	Tue, 10 Mar 2026 03:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773114366;
	bh=2+RywD1SG6fL/15LKr+bFwZWO5jS0RH8hcA1pPvJRyc=;
	h=From:To:Cc:Subject:Date:From;
	b=bzyb44Rael2QVt0lCwmDqUk+yf5E0BXMgTcHTZnZ01AT1b/DBC1m06x5rupjQVwp7
	 sXFAIlYsd2K9yoAgmdry8mzsXvR7pPWjws2USxi0HMY7ziXF/hrMn/mByCPAnE1tI1
	 OkhGARu8pm5mEibAbNhGyoIQ1dL6DxPanSFRCbOT8+Qif864Bzvm/LeC+TutfUJcw8
	 /uVhbrnwxWHWTb+fCIyujlnMkQXd9ZQRL0kkdwovZdx4TCgbktDXORI+aaBHNi7Mrw
	 mMguS9xISAx7Vx+wAc+u4eFfIVpRSqUel9aJfv3Yom/f04PDQ2PpuolA7kUPnudK1H
	 XgFAYYz4QKi4w==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2] iio: imu: bmi160: Remove potential undefined behavior in bmi160_config_pin()
Date: Mon,  9 Mar 2026 20:45:45 -0700
Message-ID: <fb653ed07fa99e3ebc51374bb367cba5712e4ca1.1773114154.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If 'pin' is not one of its expected values, the value of
'int_out_ctrl_shift' is undefined.  With UBSAN enabled, this causes
Clang to generate undefined behavior, resulting in the following
warning:

  drivers/iio/imu/bmi160/bmi160_core.o: warning: objtool: bmi160_setup_irq() falls through to next function __cfi_bmi160_core_runtime_resume()

Prevent the UB and improve error handling by returning an error if 'pin'
has an unexpected value.

While at it, simplify the code a bit by moving the 'pin_name' assignment
to the first switch statement.

Fixes: 895bf81e6bbf ("iio:bmi160: add drdy interrupt support")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Closes: https://lore.kernel.org/a426d669-58bb-4be1-9eaa-6f3d83109e2d@app.fastmail.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 drivers/iio/imu/bmi160/bmi160_core.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index 5f47708b4c5d..4abb83b75e2e 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -573,12 +573,16 @@ static int bmi160_config_pin(struct regmap *regmap, enum bmi160_int_pin pin,
 		int_out_ctrl_shift = BMI160_INT1_OUT_CTRL_SHIFT;
 		int_latch_mask = BMI160_INT1_LATCH_MASK;
 		int_map_mask = BMI160_INT1_MAP_DRDY_EN;
+		pin_name = "INT1";
 		break;
 	case BMI160_PIN_INT2:
 		int_out_ctrl_shift = BMI160_INT2_OUT_CTRL_SHIFT;
 		int_latch_mask = BMI160_INT2_LATCH_MASK;
 		int_map_mask = BMI160_INT2_MAP_DRDY_EN;
+		pin_name = "INT2";
 		break;
+	default:
+		return -EINVAL;
 	}
 	int_out_ctrl_mask = BMI160_INT_OUT_CTRL_MASK << int_out_ctrl_shift;
 
@@ -612,17 +616,8 @@ static int bmi160_config_pin(struct regmap *regmap, enum bmi160_int_pin pin,
 	ret = bmi160_write_conf_reg(regmap, BMI160_REG_INT_MAP,
 				    int_map_mask, int_map_mask,
 				    write_usleep);
-	if (ret) {
-		switch (pin) {
-		case BMI160_PIN_INT1:
-			pin_name = "INT1";
-			break;
-		case BMI160_PIN_INT2:
-			pin_name = "INT2";
-			break;
-		}
+	if (ret)
 		dev_err(dev, "Failed to configure %s IRQ pin", pin_name);
-	}
 
 	return ret;
 }
-- 
2.53.0

