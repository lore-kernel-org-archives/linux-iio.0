Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087C7396B73;
	Tue,  5 May 2026 11:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777981562; cv=none; b=Dnwe3L8VhEjeNHQIIHcXvHFRB77wJdVodiLbpo/t5YaPad5FkVZcBbfzMm0d439/aYG5TvF8XkH9nvVeMIGRh00tUPLaDLzlRJQJVDnF8Yi7+0CVN0jPffXVMNeORHAiAi77SlM7atq57B/9ExptGOG9cVxXvZ5M7HTj1E8gE7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777981562; c=relaxed/simple;
	bh=IQqw8dqzN87N3kyvLEEH/hIdLkUDhN+PIO0XcgQOetQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZVvjtHfU0x7H44DJDxem5SoZcm8LL9wXeUPJoFQ5dgVdB7A3YzPrDojVlkUyoD7H2KKKmnKyXWuwYWXEKCzGVx5DYOkIOsS1nk0p2B34Jb0QMy5wBEbiV1V23k80YSK4sOB06iTCo6mMaVwVQucYXQFuqMtsYtpOBG51syDZEZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFG3K0de; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFG3K0de"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA615C4AF09;
	Tue,  5 May 2026 11:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777981561;
	bh=IQqw8dqzN87N3kyvLEEH/hIdLkUDhN+PIO0XcgQOetQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qFG3K0deDUufe7Ch18mPxEFdeX4CQbEdP0ukXDku7VRZdsDISaUKX4PfzIuujk5uZ
	 pMgLkqJ/dF/Lh56b1qRHREuCn79e7zmGiL+XTBO6hjfiIfmQuwPaWhhJSr69WbH1ii
	 NrjYUv1m4fmJvLb34aOHeenpQHOAl5B8IQWWwZVt6qZyoit+/sJwcGJrIW4zRsn+7r
	 tab4wDi1AcSem/9Yns+S2RDW16tfx1Pt4lCCQuuBzKuBIAgQMdmzV1FynNB+t5esAt
	 T0rLG4ViBQTRmuvGIarStGMv4mOvfnWPtUQqkAAetslOlmOpNBZLsHYIiDgOVB91J0
	 KGimHTv4JDBfA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4CDCD3430;
	Tue,  5 May 2026 11:46:01 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Tue, 05 May 2026 13:45:59 +0200
Subject: [PATCH v5 03/18] iio: magnetometer: ak8975: replace usleep_range()
 with fsleep()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-magnetometer-fixes-v5-3-831b9b5550fc@gmail.com>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
In-Reply-To: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777981558; l=1188;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=pYNXSLcsScB1UFEjU4yV7Zvmf3IflZ84nydrNj+FmrM=;
 b=wvpjzx4+gaHs/FYy/Y7NJ62of+Dey/92o5FsA17FklklNFHVdaMH8Lxy/O65/HU3+uEwXljJW
 DI7Cq5uhJ7jD1QsR24OGh/SpwMqY9G/kipKBhBloPNaIAnKMN+wPLoZ
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Replace usleep_range() calls with fsleep(), passing the minimum value
required by the sensor for hardware delays.

fsleep() automatically selects the optimal sleep mechanism, simplifying
driver code and time management.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index dac0a90c33eebd43f8aeed846c9cbf5fd1a6ab91..a84a05a1b64280e26c428e9752a39380e386c234 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -461,7 +461,8 @@ static int ak8975_power_on(const struct ak8975_data *data)
 	 * and the minimum wait time before mode setting is 100us, in
 	 * total 300us. Add some margin and say minimum 500us here.
 	 */
-	usleep_range(500, 1000);
+	fsleep(500);
+
 	return 0;
 }
 
@@ -551,7 +552,7 @@ static int ak8975_set_mode(struct ak8975_data *data, enum ak_ctrl_mode mode)
 
 	data->cntl_cache = regval;
 	/* After mode change wait at least 100us */
-	usleep_range(100, 500);
+	fsleep(100);
 
 	return 0;
 }

-- 
2.47.3


