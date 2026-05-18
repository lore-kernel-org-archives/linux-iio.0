Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F313E008F;
	Mon, 18 May 2026 07:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090641; cv=none; b=h/0ZtAloZ8XHoYSFlLSs8eEsvFHJ7eB9zzdq+V3sEh3SD5656dgR7FqreMhpnRv4qWVGlvYnGaKNmOQXtMyAhcge8grQLEO06sQu6DSQGOXasJbbLWD7vWXoxKV3h+F3qOJN6f0y9mwRrm9O6Su2O8Jn/UDeen0emRqXi8HxE0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090641; c=relaxed/simple;
	bh=Mnmhc1i+rUaMv1WJoCZYdV0Or5n5ypryVDDth/klZIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b3eRLO5oneT96zSTu0Ggs9UdsPl4mmoWHg3VhFAsTUEqea0BCONgQ+uuQwGhunGAcKQecqrxX9abVAl3DrdvdAgafqoRMyfSpOb5DW6QbnWM4QWxXj1qiZMGnFWq8qFMytQICpJsczT13RN6it0EPyBQRCPb+Wq6UJkxND2hDh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaTd4Tul; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaTd4Tul"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E361C2BCFA;
	Mon, 18 May 2026 07:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779090640;
	bh=Mnmhc1i+rUaMv1WJoCZYdV0Or5n5ypryVDDth/klZIU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VaTd4Tulu2iS6Abwqunnq473Xmh3odnqnwaBejJdT3rauy0tbenvsAIGGeF9RBV2/
	 NYNsksNH4AKEBsXcaliM6mcSztWL0oS7WDs6bJz8KOXELKVHGB4AqTiUhNscMa0fjm
	 gCRy7VnYJ++XpQUTLRZJ9WslXZ7rZutkW66zTgOVNJu0veh91qeIx9rEcXdTkeUZb/
	 j52mdy2KR57LMoPR4e8yjMccW6fWgzvctK/Vct3zrepsypIRDx/W0KBioMlR5q4DpB
	 RdyWB2+D1fYb4zNvRiyCLPB0V3436zwcey0rh9aHyEefLHTzYKfSEQi/x8nB+se+7v
	 9u8gm8txsfS+Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527D9CD4F54;
	Mon, 18 May 2026 07:50:40 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Mon, 18 May 2026 09:50:28 +0200
Subject: [PATCH v8 4/5] iio: magnetometer: ak8975: add scan mask index enum
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260518-magnetometer-fixes-post-pickup-v8-4-088d610108a0@gmail.com>
References: <20260518-magnetometer-fixes-post-pickup-v8-0-088d610108a0@gmail.com>
In-Reply-To: <20260518-magnetometer-fixes-post-pickup-v8-0-088d610108a0@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779090641; l=1586;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=TmoAemhwd8JQBfZ8GJE0sULb1oyi4FJkAG/PLV6TJTE=;
 b=AEkn6/f5/FNkApGWmHTJ/oCxFVuAMvlycm/wMbQJOWnfzv/dXZObVasGCSrVy6XfFHPnXjY7t
 LzsRhZ55wgkD25PxOSIlyqh9dJY6I3ZsNvbC+8d8WviC95b+wbmu+qS
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Add an enum to explicitly define scan mask indexes for the X, Y, Z and
timestamp channels. Also, update the struct iio_chan_spec to use said
enum for the .scan_index parameter.

This prevents magic numbers from obscuring the hardware channel mapping
and improves code style.

No functional change.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 7ab4c4d69d8b73c6f367f6e62fee3017d8691b67..a140d352bad663a138295dc0c44084a9a18a4c24 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -238,6 +238,13 @@ enum ak_ctrl_mode {
 	MODE_END,
 };
 
+enum ak_scan_index {
+	AK8975_SCAN_X,
+	AK8975_SCAN_Y,
+	AK8975_SCAN_Z,
+	AK8975_SCAN_TS,
+};
+
 struct ak_def {
 	enum asahi_compass_chipset type;
 	long (*raw_to_gauss)(u16 data);
@@ -845,8 +852,10 @@ static const struct iio_chan_spec_ext_info ak8975_ext_info[] = {
 	}
 
 static const struct iio_chan_spec ak8975_channels[] = {
-	AK8975_CHANNEL(X, 0), AK8975_CHANNEL(Y, 1), AK8975_CHANNEL(Z, 2),
-	IIO_CHAN_SOFT_TIMESTAMP(3),
+	AK8975_CHANNEL(X, AK8975_SCAN_X),
+	AK8975_CHANNEL(Y, AK8975_SCAN_Y),
+	AK8975_CHANNEL(Z, AK8975_SCAN_Z),
+	IIO_CHAN_SOFT_TIMESTAMP(AK8975_SCAN_TS),
 };
 
 static const unsigned long ak8975_scan_masks[] = { 0x7, 0 };

-- 
2.47.3


