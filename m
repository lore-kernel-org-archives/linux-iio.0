Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5222D7DC8;
	Thu, 30 Apr 2026 15:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561517; cv=none; b=KXJ2QqFcrcur8Cg+SQUVjLgXKfGpNhba0rG0U/HTh3MVMnDdwNJzICLaTF2CehT8/Jb2fzQG1FQoqiCoBPYi5csNrh2k4+xnxlE5wGso51GLLqTwGy2Mci1uda1Sd8sTRtsSC7uNsH2l8gO2svYOVgQMXr1hMS5a635K9DHHvyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561517; c=relaxed/simple;
	bh=pmpyJeIflePapL/RApE/hkgCQoa1DmdL+rEhiYpEbeg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UrXFo1ZtLh4inOU5QQ0LlxNPMrlKr5KBx39/MeJdkDPk/A8TB7hKW67Jeq2omdu1YQD5b2dsKA2T9IQp3Hbc/hm1Im4iiEZhQikLxlABL3n+8HxkDfFntan+uJ1IF2XDj2Swc3i9UgNuA5EE/jBzyQXAvk0b2CBPE3mz4uFqK9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaAVMUkf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaAVMUkf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5079C2BCC6;
	Thu, 30 Apr 2026 15:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777561516;
	bh=pmpyJeIflePapL/RApE/hkgCQoa1DmdL+rEhiYpEbeg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iaAVMUkfdpt+j5fnTmC3y6JHlPYMS753eHIahlAp3P75XbwgURDROB5UC22KQpuZ6
	 2qngCNfq7O6sy/cKs3GHTFcYBWwxFEss7q3SW67DP9bs6A+OXI1PAyYCE6pxwiTzmc
	 7G0Qr/8ra03xi7/34VXn92owxsMq1m6BckRH9dPi/ZTBTLHOGGKrhYyf+U2vtiPhir
	 z7+XKuUgVfeuiQFN03HSe7m3x62mPnu+Hx8XP5UHW6ZkJsS0Ht+oA0R5p+UIS8kepj
	 hNGhHAbO6lb7Lv+5ad/of6lt8P2kAPlAEmTKQbY5pVPxYQ72UWfvb9WJn6rFXdLBvC
	 q/C0JLGJQ75qg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF685FF8873;
	Thu, 30 Apr 2026 15:05:16 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Thu, 30 Apr 2026 17:04:27 +0200
Subject: [PATCH v4 7/8] iio: light: si1133: add local variable for timeout
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-si1133-checkup-v4-7-fb3e9dce41bf@gmail.com>
References: <20260430-si1133-checkup-v4-0-fb3e9dce41bf@gmail.com>
In-Reply-To: <20260430-si1133-checkup-v4-0-fb3e9dce41bf@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777561514; l=1250;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=/XJFGcdvil+2we7+TC+ip157GN0rAXA5yY6shTe6uEY=;
 b=qc7vESqAYJ7OClprO/OxaEbdS0t5aHvvJREc+18PKy6wypT0amXWx4S6T1d/jSO1UG7RzBItS
 In9YBRYYvUwBnP8kJ49618ejEuu+3fTaCgB/xu7FkF8vZpyDpjdF4AS
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Add local variable for timeout to improve readability.

No functional change.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/si1133.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
index fdffdee16e493277d95c369ec2f6c0678cf9f61c..a3e4ab25acdc105d3800994f4391a7e4291e1c74 100644
--- a/drivers/iio/light/si1133.c
+++ b/drivers/iio/light/si1133.c
@@ -390,6 +390,7 @@ static int si1133_cmd_reset_counter(struct si1133_data *data)
 
 static int si1133_command(struct si1133_data *data, u8 cmd)
 {
+	unsigned long timeout = msecs_to_jiffies(SI1133_COMPLETION_TIMEOUT_MS);
 	struct device *dev = &data->client->dev;
 	u32 resp;
 	int err;
@@ -417,8 +418,7 @@ static int si1133_command(struct si1133_data *data, u8 cmd)
 
 	if (cmd == SI1133_CMD_FORCE) {
 		/* wait for irq */
-		if (!wait_for_completion_timeout(&data->completion,
-			msecs_to_jiffies(SI1133_COMPLETION_TIMEOUT_MS))) {
+		if (!wait_for_completion_timeout(&data->completion, timeout)) {
 			regmap_write(data->regmap, SI1133_REG_IRQ_ENABLE, 0);
 			err = -ETIMEDOUT;
 			goto out;

-- 
2.47.3


