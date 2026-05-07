Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26B13161AD;
	Thu,  7 May 2026 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164569; cv=none; b=PJivxLtuGzx9AXFJadyLaOt3pSciG19ms1pSUVjbzxcXE5ztbCNNmFv/cSQHeDKdb4/scaJIZShlTLa5s3Q76MmyXBTUcvOnCkLCjpkBX/6FVdD6hhDGf+OvqrbH++2f/qwCvqVfxv0mtPE76/SzS09YsSsJM8QHltoopmMsmbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164569; c=relaxed/simple;
	bh=S8zcjYqcOkQGiBJsJ14OTpfEjFyAY9C0atC0kOOLrM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KymrVuVDJTXhRvB+KSGWUhbdvt+ZwFtpM71MKBeIj2Vz/wPsc5fSmNblKZUjhR1ZapHrfc2h0LfiiC+0gEiwWbQUaEKKqYKBl2qyW9STtY+dwilmujCRti4Fipx/7vm4PDPuSfb1GHnoOV1TJAzaa2OVwccDVzYqZZMyM06A/og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COOHizHZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COOHizHZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 999A1C2BCC4;
	Thu,  7 May 2026 14:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778164569;
	bh=S8zcjYqcOkQGiBJsJ14OTpfEjFyAY9C0atC0kOOLrM0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=COOHizHZ95C4AZcKaPv9A6I7qTbYxhtdqWJ0m4ILpvxXlVpPOl6TEYgfuiCkEzigZ
	 HU50cCP4I8xJKqXJv/Bud6ki72wRcUPvgXx7G3aeaKxq5XNNr+sUmV1mysCaKhgekF
	 BJ+CpmaTXEUPO0IEv+rEl0HE+t6EsaHjIh/uU4zWxO1TquynlFbJsurYNkrOR7GnnE
	 SBS6H2acoFTDkTITC89ZteI5haGmR1HkMEV0jybD++BRCwpeo34cRlt+jZi4SpDjeE
	 0Rb21BtEGvCNEf/VkzXEM62DjMxKyPft7zBRGufBqEtgGT9fN6EcF/ho51pTJOMnUE
	 WH0bEcTHeoyrw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89958CD3442;
	Thu,  7 May 2026 14:36:09 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Thu, 07 May 2026 16:35:51 +0200
Subject: [PATCH 2/8] iio: magnetometer: ak8975: check if gpiod read was
 successful
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-magnetometer-fixes-post-pickup-v1-2-37827ca68fb3@gmail.com>
References: <20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
In-Reply-To: <20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778164567; l=936;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=rgh2T/BraT11/1sDogsM03wH+GIDtJpudp0bLFkpppg=;
 b=kw14rqVLrLwHvzqYtMWqjVGldMXWJUomqSjyqG61K4vLS/7Ka67Bzq6yOzxmV41FVGQreapZV
 4eV+neL0kYTBvgWhS4KY2yovbAT6BZ6w8CKaGkG41bAO9Ilred5zCCp
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


