Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D39C38A72A;
	Mon,  4 May 2026 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777888115; cv=none; b=MRm9d22Ls7VN65HMvvDNGoFB04K28Dnk0XVVoAZg8MhVx+w79S9//EMlfmiENvXrIer4eNpvBBPf2b6zPjV7PfP7WxIEV3SInJE5Vj/clyE7KLmIy0jKqykmui3kNme0jRCIGJ7Vufax4ohGZc5SudXmb801vOBrVmikgHxP1S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777888115; c=relaxed/simple;
	bh=My+1MqHY4H8Xr3R5BtJ1NtdFqxcnBifL4UHTNFv6AUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ePjU7KFhbBabnw72JNfjil97znh8cEDDT86Bt6VnTYMWWPlB9HkdkWgLy6PhAVd6jcAEntHV7O1yE/JvlZpcxPLiQUc7lTSac1rjuoXU4PMWfXu//08YsSBJFuTkoqHxLsqPROwpRiCN7sSlnma77fRK1wVRPZNs42/miNSmOhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BimbLoUe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BimbLoUe"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31749C2BCB9;
	Mon,  4 May 2026 09:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777888115;
	bh=My+1MqHY4H8Xr3R5BtJ1NtdFqxcnBifL4UHTNFv6AUQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BimbLoUesf9d1TxblymmLmT4gwGfDU2qEE9LCfXPXG2iKXT082i7sISSAK9yY1Wg6
	 HXm4QQxv/F49M1ped2RGfs/H4nm7/VoO3s5L9g9Z9rCvegytiK7XJIJFum65YiONEY
	 CjK32dp1h+mRwO/CJTlLo4tI0b8QvJ48VYSZCG4IfUcqeBO6fNK9bDRz0yIuj2czA3
	 o3ARMQq2sR3CKXqOqx4RQbJtRWwc+kbg4y7POpRPFDk0yRmsAUKFE03D5opK7b9Wd4
	 QpECoohDR8Zxr6xPXdItwo3HEpRBCJtw8ovbJJSS02l1y19Bo3XO45YtMLjw0x9/iG
	 UXc0LkWYL6veg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADA4CD342C;
	Mon,  4 May 2026 09:48:35 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Mon, 04 May 2026 11:48:22 +0200
Subject: [PATCH v4 10/17] iio: magnetometer: ak8975: remove duplicate error
 message
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-magnetometer-fixes-v4-10-a291c2a7c71a@gmail.com>
References: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
In-Reply-To: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777888112; l=1086;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=z9DRykPnGYvT6CD8nI23X4tG9TQg6CGBxpeXGPGfMa8=;
 b=YpFqTWYwylZsbWv8RaO4XMob29BCL15Oaz2iPgryOjSeEJOxIsvDE8rQ1DWuKR7OGoX+x9X6l
 QPpysEFvFvDChS9n8T66IfjQHmw5XH378fkI1WcnQdY1LE334KD4NZY
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The devm_request_irq() already prints an error message.
Remove the duplicate.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index b94b0486421873a4afa41949d956e0bb5dafdb9d..c354ebaba11c86c24ebe2dbc2b20c11f18015151 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -584,17 +584,14 @@ static int ak8975_setup_irq(struct ak8975_data *data)
 	rc = devm_request_irq(&client->dev, irq, ak8975_irq_handler,
 			      IRQF_TRIGGER_RISING,
 			      dev_name(&client->dev), data);
-	if (rc < 0) {
-		dev_err(&client->dev, "irq %d request failed: %d\n", irq, rc);
+	if (rc < 0)
 		return rc;
-	}
 
 	data->eoc_irq = irq;
 
 	return rc;
 }
 
-
 /*
  * Perform some start-of-day setup, including reading the asa calibration
  * values and caching them.

-- 
2.47.3


