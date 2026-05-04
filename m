Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D9938947E;
	Mon,  4 May 2026 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777888115; cv=none; b=PNF1cjoCTpNe0BvOfvsqdsNVyn7woxWr1fVGcoXGPvpZnj0i6rvDpzs1Mb8tj4auwbcfQc1mJNI5GqAgyj2eGU0iZwbZ/D+laFVLRIAvTU/1iqI7Qmltt9vBI3GIzTzGJjD6kYvgIhbgrtpPdBL3XrtJ0ib77Yy+zaybsJp7shY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777888115; c=relaxed/simple;
	bh=lyuOXTCmxft3eK+xg8TLAw16AK1VgQDtQvcn1KArv9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NpwU+hain1pCDZq4EAd0SjltMVqQ70DvyIkZhBGfsaCLF6qsA8vQi/n7br4ss4IMbiWL+Y6o6UBEIJr1oF6BqD7VHIc6yD+wGra09au3UzpHIFUWDBwgg6crmzD2o7vl1b4HXQKnAx9+Tw+3wSLjfzLV5rLcfymTW4ikns+nPOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2t4XQNV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2t4XQNV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25496C32781;
	Mon,  4 May 2026 09:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777888115;
	bh=lyuOXTCmxft3eK+xg8TLAw16AK1VgQDtQvcn1KArv9c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=M2t4XQNVliQxsrNCp31w7xNSKir/XqGJRt306adT+tVYNg3yPYxpEFWm1b4hp4Hcd
	 N2ic0ZLU5TyCtVXcn5jdkOyvs3ZQQGZ/6mDwo3ZdYHuRg4fH9KUh7DsaxM024jOEMA
	 SzpBfxd/nduBtw89BKljVL2hk2IJ3UD7BRqHabjHnN0wuErw003J/2jBOF/XfVDgn+
	 lQOoJVt3zVMh2C0Jnsjf4fSyT3lwlLC88UeQW5ZMUbsLFH2ZdvZ8Jjhxk5A+Zy13ak
	 cnOZfP+jJNnMZHrTfAuHR+ZE+bxWRkVgD1h6d83Wt2ahA6jnHjLUh7qa9BM4y0f90V
	 C6h/Zi9H08DLQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3C1CD3436;
	Mon,  4 May 2026 09:48:35 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Mon, 04 May 2026 11:48:21 +0200
Subject: [PATCH v4 09/17] iio: magnetometer: ak8975: drop duplicate NULL
 check
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-magnetometer-fixes-v4-9-a291c2a7c71a@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777888112; l=997;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=e2CslTguZFmECHppHhG6NXJjVTcak+Q+ZmfU6/H6/tw=;
 b=wVYp6pg8pGZRPku/IJeaLIlVYeKFKmI5Eb+i2xowE+v/WJpsssvOKlwPcmiLV8TIR2yVjbGOL
 WTuSECFwctHBrG+dqQrfPa4m3qi0evCA8t+eCRL2hVznoM8j5IL6mTE
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The gpiod_set_consumer_name() is NULL-aware, no need to perform the same
check in the caller.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 00bee434432f07e8e0bd7fb2b4c97cd2995af7a7..b94b0486421873a4afa41949d956e0bb5dafdb9d 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -916,8 +916,7 @@ static int ak8975_probe(struct i2c_client *client)
 	eoc_gpiod = devm_gpiod_get_optional(&client->dev, NULL, GPIOD_IN);
 	if (IS_ERR(eoc_gpiod))
 		return PTR_ERR(eoc_gpiod);
-	if (eoc_gpiod)
-		gpiod_set_consumer_name(eoc_gpiod, "ak_8975");
+	gpiod_set_consumer_name(eoc_gpiod, "ak_8975");
 
 	/*
 	 * According to AK09911 datasheet, if reset GPIO is provided then

-- 
2.47.3


