Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D9A402B8B;
	Thu,  7 May 2026 14:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164570; cv=none; b=t1Eptjab0lrRj05shqnWy3xYlUD0YvYQUjY68JLbSPI4UTX/C2MyTOQi95bEITg0FDr3P7SwNkfwHLVMivqvGEfwbs0lzvgkCvyYJt15sA9w/9ZUL5u6Xn0qqQ+BtX0RI8S6icNBJINannI/QeSfeNfLsQOr1dXHJ9gSlT6x4uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164570; c=relaxed/simple;
	bh=BAgldrNgFqY/UdPfT4z464ow+eRyyMd2E/es+wb04tU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V+Xd5OzI1L/r3RG2gz9CpdR31ZCX6NHq3wjCOVfu57mC7XdlA+323U9naEDSQ10ueonUtfI4YfozKUDyX+vArZeQfb/h5evAwIk2rjHiMn6lT3oGH6RVAcdyvEoF0fMsIAYHGlmOOjbGDo69YPmGll3/pgH2L3US5YGALM2VwTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkYWBmfM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkYWBmfM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3EF3C2BCFF;
	Thu,  7 May 2026 14:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778164569;
	bh=BAgldrNgFqY/UdPfT4z464ow+eRyyMd2E/es+wb04tU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nkYWBmfM0P/7RuNeiqFrE+YbKpUNfwHQJT0VtsQdBw2568hT5e1JGjx2otfE08hpb
	 vgI9VMNk1B87dn5KHX5suiOvHBKl4xF0JcxHMVZjmZHMbE8azxFq8z18s+E/uccOST
	 /B/fzCPw6Bcenvuy/mu9fbRH/kPPxn53j3Q55czQ27MdMiqi6Gwh261Kr8k/ROCesK
	 AC/X818CR5p4H0Dkrx9JjmcIru0nyLh9KzJFN++fRzD0XcVD9QyXQmPioy/7azYu3E
	 tpR0C/iTXh659R75qhMx1VJzPqW7W5/M6PzO2kw7XA1xaZroucw0bMmu5ZO27YBR1y
	 WhVNhaaX6aFEA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5AFCD343B;
	Thu,  7 May 2026 14:36:09 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Thu, 07 May 2026 16:35:54 +0200
Subject: [PATCH 5/8] iio: magnetometer: ak8975: unify messages with help of
 dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-magnetometer-fixes-post-pickup-v1-5-37827ca68fb3@gmail.com>
References: <20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
In-Reply-To: <20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778164567; l=2364;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=DwBNoYdjw+pyVB4LkpMEXnJ7TcOCwJnLd6lf/i0u+OA=;
 b=nAmRauS1RnRKE50OlR+YmyWxpM3nnI/LzHGTVVvMOUcJma4zqPNEWddZGdrVPDxLj09ES8yGn
 PtUdwzHSm1mAe1/K5b31LeFnKA1Kc3npKZu6nNTqJbvdXxxhKTovF3/
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Unify error messages that might appear during probe phase by
switching to use dev_err_probe().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index e575d252076acc3639cfbb718a76811636fe56d2..394f930b862e82fd41c02d81bc6fdb3cfc8b729f 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -495,10 +495,8 @@ static int ak8975_who_i_am(const struct ak8975_data *data,
 							AK09912_REG_WIA1,
 							sizeof(wia_val),
 							wia_val);
-	if (ret < 0) {
-		dev_err(&client->dev, "Error reading WIA\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret, "Error reading WIA\n");
 
 	if (wia_val[0] != AK8975_DEVICE_ID)
 		return -ENODEV;
@@ -996,18 +994,14 @@ static int ak8975_probe(struct i2c_client *client)
 		return ret;
 
 	ret = ak8975_who_i_am(data, data->def->type);
-	if (ret) {
-		dev_err(&client->dev, "Unexpected device\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Unexpected device\n");
 	dev_dbg(&client->dev, "Asahi compass chip %s\n", name);
 
 	/* Perform some basic start-of-day setup of the device. */
 	ret = ak8975_setup(data);
-	if (ret) {
-		dev_err(&client->dev, "%s initialization fails\n", name);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "%s initialization fails\n", name);
 
 	ret = devm_mutex_init(dev, &data->lock);
 	if (ret)
@@ -1022,16 +1016,12 @@ static int ak8975_probe(struct i2c_client *client)
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
 					      ak8975_handle_trigger, NULL);
-	if (ret) {
-		dev_err(&client->dev, "triggered buffer setup failed\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "triggered buffer setup failed\n");
 
 	ret = devm_iio_device_register(dev, indio_dev);
-	if (ret) {
-		dev_err(&client->dev, "device register failed\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "device register failed\n");
 
 	/* Enable runtime PM */
 	ret = devm_pm_runtime_enable(dev);

-- 
2.47.3


