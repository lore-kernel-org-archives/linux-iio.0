Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC8635676B;
	Sun, 11 Oct 2026 18:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791745014; cv=none; b=cQSrPCXku6grDcCerUqKwNHoD/8EBcYUaDgCx5jgiFG3lbZk4tPBQdG0MYHIoWHr+qczUisohhE77V8EMizIQVbY4r9oL24MAUXL4JvJkObUkFQgC/l8e8qSlJaznGyRVTGnpN95TFNJrY8wMT2yEkLz89JX3KzurOnzlN+dtZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791745014; c=relaxed/simple;
	bh=ENl/ZNAP1kppLySWNkEdZQonwNQjsVUGN9xUAGobsDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=j/7qYxtMQvEu2TEjxHGd0cuTIsC6JB1VD8qaryf5OOSnerJ3NDgfYL2EJod3yuuFDkt6kld4zgr4/CkWS6oqHaMQxy/AWe4rd7YvlX70XqBlnqWFzUiKRV4cocdXl+ua2GNhOmn1XDYuz99d26utVu+jPwX1ScPmOXK4uHARrdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CY3ivjFm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CY3ivjFm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C53CBC2BCF5;
	Sun, 11 Oct 2026 18:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791745013;
	bh=ENl/ZNAP1kppLySWNkEdZQonwNQjsVUGN9xUAGobsDo=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=CY3ivjFm59WQTi3DdwLA/fmwuV5WlSbILggEXJtC8Kjrxlq/zybMn4dTq1eV3Fn0+
	 xvF/nNsivXUo+q9uhl49q/3QKDahbjHvJtMGzm7gyH7wjhsrspCeILMsjg+g9y0rAj
	 cZ0rv/mVRVWjPectnxAPYW31pLQste2Lkh5B38aqfCU7GC+CEkZmScrB0HLwDUwo/T
	 TP/c+Gzr6KF0sJuGd6K4nEakowKwyxFZqDwKaB2DwTNvWHqqW8RIQXRGrudUhZaiNI
	 G+18UKOmH/OyxOEg8q7hJo8+swscCZUy2Rn5kj0lzyxo5LSR0idU6PTttD3f1zJOzM
	 sT4rVYM/p6yXA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A248DCA9ECF;
	Sun, 11 Oct 2026 18:56:53 +0000 (UTC)
From: Raffaele Tranfaglia via B4 Relay <devnull+raffaele.tranfaglia.gmail.com@kernel.org>
Date: Sun, 11 Oct 2026 19:56:22 +0100
Subject: [PATCH] staging: iio: addac: adt7316: use dev_err_probe() for ldac
 GPIO
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-adt7316-dev-err-probe-v1-1-27a4a8ac74f3@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBG4auQWTtJpwoar2JcUPoXxwWQKRITw
 t2tsPwW762UYYpM92olw6JZx6FAThV1r3bowRqLyTvfiBPhNs7XszQcsTDMeLIxgG8phRreX8Q
 5Ku1kSPrdv4/n4fwJb3Tzf0bb9gNMbRGeeQAAAA==
X-Change-ID: 20261011-adt7316-dev-err-probe-8ffb5e224100
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux@analog.com, linux-iio@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791745012; l=1387;
 i=raffaele.tranfaglia@gmail.com; s=20261011; h=from:subject:message-id;
 bh=b9texfP1vjXc9iYJeYxurlQBJ3RyvvggOaFq0fR0kvo=;
 b=Ml2G6laG6UKHKDMNpCXGH/kQ0Vv3RYgblFQ8M7uDN0IAGoxakP9rTZs++Aqz0rWPNXWEOOAug
 xd4kel0/UlBAHfRapKDyCjwHCtIJKlyRtKikPDhaPc5jvAGgKIV/slu
X-Developer-Key: i=raffaele.tranfaglia@gmail.com; a=ed25519;
 pk=mweuSGNM6vguCTdqa+aiHwMXdgk70suj2wolzCp6XGM=
X-Endpoint-Received: by B4 Relay for raffaele.tranfaglia@gmail.com/20261011
 with auth_id=1160
X-Original-From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
Reply-To: raffaele.tranfaglia@gmail.com

From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>

Use dev_err_probe() when requesting the ldac GPIO fails. This
avoids logging an error when the GPIO controller is not ready yet
and the request returns -EPROBE_DEFER, and records the deferral
reason. It also simplifies the error path.

Signed-off-by: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
---
Compile-tested only.
---
 drivers/staging/iio/addac/adt7316.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 20f6052cc7fb..8ca6def84584 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -2142,11 +2142,9 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 
 	chip->ldac_pin = devm_gpiod_get_optional(dev, "adi,ldac",
 						 GPIOD_OUT_LOW);
-	if (IS_ERR(chip->ldac_pin)) {
-		ret = PTR_ERR(chip->ldac_pin);
-		dev_err(dev, "Failed to request ldac GPIO: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(chip->ldac_pin))
+		return dev_err_probe(dev, PTR_ERR(chip->ldac_pin),
+				     "Failed to request ldac GPIO\n");
 
 	if (!chip->ldac_pin) {
 		chip->config3 |= ADT7316_DA_EN_VIA_DAC_LDAC;

---
base-commit: a22dc7ebb21a6bd4c8b63bc2c1dd46a24945aae7
change-id: 20261011-adt7316-dev-err-probe-8ffb5e224100

Best regards,
--  
Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>


