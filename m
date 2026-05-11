Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B609F36E495;
	Mon, 11 May 2026 11:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778498779; cv=none; b=K6ZE+BD+KPsOoMdPopxs2JhlzJvHJyuNmH90LF8U8B2CBW+GCDy86j+5gdeJOB6VNxrvsJV32NXo1DsSSrOriXH8O27Yp8+QprNbDAe6likTD8Zk0Ij1OUYU7PVi5ddIYWheV1E8qs0UXhRem8kqFfB7LZSb7nRxg6S14BZeCgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778498779; c=relaxed/simple;
	bh=1RLA2ZYiCGApABoG0oT9B+X52DsITGoUfZDk73uTbqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RW01b98ujgfnzrfmR1mAAI7at9bPNXn92Q45PL294x8ygaozjslcV/jR4+iaBvfUe5BMRz3yDCTCeCIZDd7xu/7VUzySelELGcvx/gzPQByYWNgb/cdznL/pr6pXuzjOMkV2YWo9DWMHXo2wpLnmaUW6ELIgUHEKZe4OKcBr4u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhmQ6slM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhmQ6slM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78F95C2BCF7;
	Mon, 11 May 2026 11:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778498779;
	bh=1RLA2ZYiCGApABoG0oT9B+X52DsITGoUfZDk73uTbqc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lhmQ6slMgOHsFs1omNsANikG1biMGMahzbu1Sm/Lg3Xxnk320soWjjb/WXc2e38lG
	 ZT2lBjbtlVZB9M5rwkgn4G+20n7jkIuKVG2M2ZEEj5F1g431P0p2SSpWR1BYe7ZttP
	 v0+VGP487kkbaXLrpAgWSEM1hGh4vUzaXfOTBqERA7CAhArbqe2wkljVCqp0eRbV0D
	 eHPh/ce/Gi80RMh+GYYPbFFIZvOFdMM/qwm9IhLClSJNT23lgHyqs/7c2+xML/HCwi
	 vBuC/o2OJjp3kXJh1UAVlCK1WVA+LnddPy0mcG2ASD0SG5nHfotfblFd53iRYW+PZc
	 nnqkB/4r5n2Xw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA11CD37B9;
	Mon, 11 May 2026 11:26:19 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Mon, 11 May 2026 13:26:11 +0200
Subject: [PATCH v7 2/8] iio: magnetometer: ak8975: check if gpiod read was
 successful
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260511-magnetometer-fixes-post-pickup-v7-2-9d910faa28b6@gmail.com>
References: <20260511-magnetometer-fixes-post-pickup-v7-0-9d910faa28b6@gmail.com>
In-Reply-To: <20260511-magnetometer-fixes-post-pickup-v7-0-9d910faa28b6@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778498777; l=980;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=PyQjnvF0PpS4nXobxpIewU2LXJTfC4o4a1SiBwlJi78=;
 b=k90+TeY6RHr7y1bvPgQMCiY2GUzJNuDFeNobWT56H17FPV0TiD5/IIujMwnj+itd4y3CkGmtr
 bZGgb91MwYpDB2G/9ifC4LmXWXZMRIMe4YIbf+figvkW5R2P0eaI65k
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Add a check that ensures that valid data has been read from GPIOD. If
not, log an error and return the negative read value.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index b990c123e2808c2078abcfaf6b2ef86c09393e6b..63b6e8465f5f3873841550a1cd03ce86b95d1d67 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -658,6 +658,10 @@ static int wait_conversion_complete_gpio(struct ak8975_data *data,
 				 timeout_ms * USEC_PER_MSEC);
 	if (ret)
 		return ret;
+	if (val < 0) {
+		dev_err(&client->dev, "Error in reading GPIOD\n");
+		return val;
+	}
 
 	ret = i2c_smbus_read_byte_data(client, data->def->ctrl_regs[ST1]);
 	if (ret < 0)

-- 
2.47.3


