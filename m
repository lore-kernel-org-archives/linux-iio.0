Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881045;
	b=akqWS9Sq++g4KexB3cVvf34oij0TrtHm6hFA95LET3+FGL3t+HMpTbHB8TnLF0EX6z3r
	 qmiLVI0b+VtWecB9K0c3wK5tCIvRgUUJ8kT4WiIjCxxrzQDzqZSN9cEPKNMEi01WVEVA8
	 EQz63K86uX0Aoi1XOKH6Ex8IH4C7o7EwaapRrcLid+bz71AoYx29h8Hi0EDHwlMzmsk57
	 NZX57u0Ivu5FYjvpWKaYWCyz4WmuAqgk9+QFOf5kTCTCn/lYMPScDbQI+euVPvJxTtXFh
	 hHuF7U1OROIlFBl0jsYW2Hshzqwt0d8D6+Dr8Fy9pIRoxmIdvuG005jsQk4ZQnYm/6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881045;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7VlBoOECwIyEF/oYh2BB6rvaEtQ85D/IgkCWg3P1M34=;
	b=TW0Cv76cn+umKNinGOPBI/FUQ55a0ANJ02RvoWuI+hI/e4+yyYDgdtJK1pmTqlHt/fAB
	 wg4Doxwb/Nf5IwAnM1V2f5v6oL2mxOtEa7e3uG2QHdb/MIPyKYREkgRH/KBDv1Bxs8kKt
	 WVRZYZVfZQ9Gj6CcKZ5mBCYrBPKXHtiRcW3mDlw5hjVUuRk9RVIX8ZM+E81ZL6NmLK6Tg
	 Iq0jDRup9uVxzoQnWtVj9X1Jyi0X8FdTUpP9RfB4R/1JQ94iDPuyUCIs+id0L4AhS/Xd6
	 W331Dp0NYpeFQ0WBWzrwFWVhJkQvVXiiHynae3XJk0HNonEhYnfyEOMuPjWsMBv10NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VpTGiKDR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57083606A339;
	Thu,  5 Nov 2026 12:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VpTGiKDR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8501F00A02;
	Thu,  5 Nov 2026 12:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793881045;
	bh=7VlBoOECwIyEF/oYh2BB6rvaEtQ85D/IgkCWg3P1M34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VpTGiKDR6bBKAch4lgZlUDWYdY0UC3upO6lVewOG6iaRwuU+h9wSnpgBz958Dcxq5
	 jBlupzi2jLLB2S3uZYGVexzwwiw+cdLAkklosewF2GLcdIFOweAw2mwjLp9XtJ3Dfg
	 XActJH25+5fEva19UOalJF4qSq8EV4eYtq6V/gTGjf97u6dS/r/u4iPnElOqCtyLvt
	 BAipgsX5MtoNytG2kYJEbZ4F/i7TOKU8gwcWmRvR1ORCLxtqkBMgnaNY3mSXbVMGx9
	 xS2vFaq61K/vYw+j0vX5QUufHwioSZAwV5PVAO8DTGhdgTIcHDgzfSpheuqD8yHHDD
	 CWwlTVUHlVC7A==
From: Joshua Crofts <crofts@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Eugen Hristev <ehristev@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Haibo Chen <haibo.chen@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH 08/10] iio: imu: kmx61: remove redundant pm_runtime_dont_use_autosuspend() call
Date: Thu,  5 Nov 2026 12:16:33 +0000
Message-ID: <20261105121635.1612-9-crofts@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105121635.1612-1-crofts@kernel.org>
References: <20261105121635.1612-1-crofts@kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
driver core is now responsible for undoing any
pm_runtime_use_autosuspend() calls on driver exit.

Remove the redundant function call.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/iio/imu/kmx61.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 1ca998f44eb2..bc8e88ffe430 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -1388,7 +1388,6 @@ static int kmx61_probe(struct i2c_client *client)
 err_iio_unregister_acc:
 	iio_device_unregister(data->acc_indio_dev);
 err_pm_cleanup:
-	pm_runtime_dont_use_autosuspend(&client->dev);
 	pm_runtime_disable(&client->dev);
 err_buffer_cleanup_mag:
 	if (client->irq > 0)
-- 
2.47.3

