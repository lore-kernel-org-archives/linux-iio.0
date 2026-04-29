Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CF1376BF1;
	Wed, 29 Apr 2026 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475150; cv=none; b=taECChuvo/ErNHOXELVh0hJyGqVh8vh69RDrcbIlvt+dQNtntIwn24rPgRVPUZH5BgFwDCqi5W5rnDHKilif5mPAJMNzR3Yq//Urk24haD9HrnVhaTSAMpt95cz4Uh24dHiRfWdzhWQDAzONDo8KncStLXzErp0VgspIhFWeF4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475150; c=relaxed/simple;
	bh=J8mC8/qrjkHpf4CkN0JrZVGuozI8+Rsvir9tTe1ky/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZcPgLkiBtJFC4Qu7EFCObppFnXH8o7EGowdmG38RtnrBPwYQjRNeHqR28Ez3Y7/uzULvQ6aax+qcHrLDtb2QGj43oZKBq2ok/0G5lziNIG31MHl8Mrzoi7tfOHsaOXjO/9ejvmcFcxGLZI8ammK3NQ+3MJ1hN6M7bCiDrst4/Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNwn/w3q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNwn/w3q"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3523DC2BCFB;
	Wed, 29 Apr 2026 15:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777475150;
	bh=J8mC8/qrjkHpf4CkN0JrZVGuozI8+Rsvir9tTe1ky/o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WNwn/w3qpVc7vRm7q6+3D2YWRzT2MCUuGj6uXp1YgKNeG5h2imBWaM9MqyWCWC++m
	 MKWLKQIfKlCOUtsQ39H27BMAL39CQRIlOpfCwFwhnBMRyC0acrdxeCyk95Pvb6JPEP
	 qYToC9m+ElppYxaSFSjWLS1krz0CJmcfZvvroEmn2yNELB9DyTLCsLfYPy2Odey355
	 wGx4cZwiIbgS2dGxIPpa+bUwM5DgRBMSr6rlwCy4V5Gw1oKFR0Drf7kzKcliSlHyUb
	 zci7IE4FTN5AQNDyf+RHXkg5lq0g/0CTJ2jyCOt5exQdJ+P647MrpX0CbtlmsNL4Lh
	 ukZDfrAEVvyPg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E224FF887E;
	Wed, 29 Apr 2026 15:05:50 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Wed, 29 Apr 2026 17:04:54 +0200
Subject: [PATCH v3 6/8] iio: light: si1133: add local variable for timeout
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-si1133-checkup-v3-6-469f21d960eb@gmail.com>
References: <20260429-si1133-checkup-v3-0-469f21d960eb@gmail.com>
In-Reply-To: <20260429-si1133-checkup-v3-0-469f21d960eb@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777475147; l=1252;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=iQP88I6gwVGTwRDphxjIwdJr1kTAAQWffLw4TQszN6k=;
 b=zTiBost0YlvK3XbHuAiNx79dFexGpDB9KWK63Qka+PcE6GQD6XhW+PKHMM6eyCNfLjgXJ7BHP
 06HM54tKl7hC6sfSpF2FP3FsXH5J2ckEQCBn8mfnqgvksU3dwbNz7eE
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
index 939189d8c18a85ad64d8c05dfb83b5989f524791..471692057b0f16c82946507bf7d23a0004f80bf0 100644
--- a/drivers/iio/light/si1133.c
+++ b/drivers/iio/light/si1133.c
@@ -391,6 +391,7 @@ static int si1133_cmd_reset_counter(struct si1133_data *data)
 
 static int si1133_command(struct si1133_data *data, u8 cmd)
 {
+	unsigned long timeout = msecs_to_jiffies(SI1133_COMPLETION_TIMEOUT_MS);
 	struct device *dev = &data->client->dev;
 	u32 resp;
 	int err;
@@ -412,8 +413,7 @@ static int si1133_command(struct si1133_data *data, u8 cmd)
 
 	if (cmd == SI1133_CMD_FORCE) {
 		/* wait for irq */
-		if (!wait_for_completion_timeout(&data->completion,
-			msecs_to_jiffies(SI1133_COMPLETION_TIMEOUT_MS)))
+		if (!wait_for_completion_timeout(&data->completion, timeout))
 			return -ETIMEDOUT;
 		err = regmap_read(data->regmap, SI1133_REG_RESPONSE0, &resp);
 		if (err)

-- 
2.47.3


