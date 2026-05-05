Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A184397688;
	Tue,  5 May 2026 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777981562; cv=none; b=ljceYs+BjGFrJyCbPmLqTMkCYS0xzq4Ol7UMGo8ioBZE5rRJxgXSFnQ0WJnedHZSJxBC3M1C+VR0DNOVLNrGUcoaqg63xdO8HSBA42y7iCTnRraY5ZPSI9I0MDh6D630F4zzJ+bq89S3DcFbYMu+0kMLJ5DzhU6kpYWeJq/wjP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777981562; c=relaxed/simple;
	bh=LzFzwM1vVt7yzGjBEJMTkXfLayEfGMNdWc3OJe6lpjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=liOgbPEBVm/aehDTJXEZulZxwLuZGheX4YN9AfesvHWVOob4t8UIbEtBUMrWz8wRIYu2N0++Res+Nf6ymAdhnP3vz/E5uE6XkzIdqYQeJZHocK0mlaLHGXRDJlrmfii9AQnJhM7rI200nj280Ci0TKyMB1SylV8bVKOH3u8GSpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OunIMiE9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OunIMiE9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DAA3AC2BCB9;
	Tue,  5 May 2026 11:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777981561;
	bh=LzFzwM1vVt7yzGjBEJMTkXfLayEfGMNdWc3OJe6lpjQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OunIMiE9nwynj+ST5l49FSWNPGfeFRfFpxzurZI0T4x9x+gCVC60cOqJMt1R0ZTU6
	 eNi+9Rzv8aDhJHH0FspSgnEbIO4/dxC8zUMymiJ2kztbJ97p7ZHwZ+KWbSU/uidJzJ
	 oMGa5kpEHQH1ywXTFHMoYGzGYlNxXziDGpvSjv806f+X8gC1wQmQ5e05F/C4qNZ0l9
	 1vfjgUItL8TGcwzx+nTJo+wRpIx++tjtL7DEX6TFHuBB7hzsJMMbSKkt7RXxLsp0xU
	 Pdb0ZLWwc+0rt7v+QJp7bsb9FBpTUuMVsGQHqkhsepwKxVx1gb2bESBmyyJd0dogWO
	 AEkxDKPpgWnvg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0391CD343C;
	Tue,  5 May 2026 11:46:01 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Tue, 05 May 2026 13:46:00 +0200
Subject: [PATCH v5 04/18] iio: magnetometer: ak8975: change 'u8*' to 'u8 *'
 in cast
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-magnetometer-fixes-v5-4-831b9b5550fc@gmail.com>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
In-Reply-To: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777981558; l=1056;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=Wdt8KANnDoSFXBcgrJIrMksQrP9sjlwOf4hExOFf40Y=;
 b=M7KAiGPTTXPM3TeKKNkwu0h0VKki3nc7Ksn7ZOWxI5nq8pa0kF+5UyDj4bc4dvZQGC2NwY1+f
 06jKMy6kTxHDwVmsUGmVWfVohTE0uk+C0LTNdF7yLbP4BEhB+5X6SM6
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Change 'u8*' cast to 'u8 *' as the former triggers a checkpatch error.
Also fix the indentation of parameters in
i2c_smbus_read_i2c_block_data_or_emulated() function.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index a84a05a1b64280e26c428e9752a39380e386c234..6ca8c24b9fba452b6fed8155957a8e5fcbc6511c 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -759,9 +759,10 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 	if (ret)
 		goto exit;
 
-	ret = i2c_smbus_read_i2c_block_data_or_emulated(
-			client, def->data_regs[index],
-			sizeof(rval), (u8*)&rval);
+	ret = i2c_smbus_read_i2c_block_data_or_emulated(client,
+							def->data_regs[index],
+							sizeof(rval),
+							(u8 *)&rval);
 	if (ret < 0)
 		goto exit;
 

-- 
2.47.3


