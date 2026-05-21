Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC05394797;
	Thu, 21 May 2026 09:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779357343; cv=none; b=ohiBsqkIADFyobVV5O0zzVEEq3AA/KXOYEgaI99mSCA+ch00VqReNbVR9gIiOyuqlPAkZcLxMQ9IC2fv6F7RkpS5r1fty893Z570+EwFkFCyROjcc2eRby26RussbarMEDGtipXKCt8UWJcFLXk2hVQkdPuEXHb10hdfLHrbaaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779357343; c=relaxed/simple;
	bh=YDTOmsNMf9fU/jAbL6ARj7TZi6hplK0WfcjYEAuQsdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gpQ0BsLkQnRu4eHJqo2AUhIEUGONnooJ9kPtDvXu1Di9dG6++n8ewZcclt1NUfaKNbLvDIfORHYYJViXUkrJ4kULRFOTx8KnNGGhx6ywl/WN7SBd+5PPUZRgZdCm/a16skd5pwfq5HFMoMs9YoUSl7jp4Y40DdBZydyrL5eGM9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZYBHhDy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZYBHhDy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B58DC2BCF4;
	Thu, 21 May 2026 09:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779357343;
	bh=YDTOmsNMf9fU/jAbL6ARj7TZi6hplK0WfcjYEAuQsdg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CZYBHhDy1TmSOOOtO0eKypuYmTQtC/VcN2DeBk+a2pesoZGCIDOg+90odAEZxgov6
	 v3uJTfjnyicpEw0LuXhltA/pIdrHgZz+qa18ntF4QsNqn8MhgrYLnIr3Qw6YE/clGX
	 TRy0LoG5Ro0qeXYtgefx+CSleV6Q5hMT2NgoFRDcB8pwlTl7HZCGnR0hlEVSPndHBY
	 PAbc20xx2m0W0o0nl2S6MZR0JvhjqoONM44CqbJGOS+0rYpxD+U50zF8575sj2s2BZ
	 kKxvlUI7ZGuEqb5R8RFnWRMAT7vZyUFt7aJeHCe/aRczdNwERclKhwsnw8BWlRHWUR
	 SuB1o6duqE6dg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2253DCD5BB1;
	Thu, 21 May 2026 09:55:43 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Thu, 21 May 2026 11:55:42 +0200
Subject: [PATCH v3 5/7] iio: light: opt3001: prefer dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-opt3001-cleanup-v3-5-820169dec8c3@gmail.com>
References: <20260521-opt3001-cleanup-v3-0-820169dec8c3@gmail.com>
In-Reply-To: <20260521-opt3001-cleanup-v3-0-820169dec8c3@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Alexander Koch <mail@alexanderkoch.net>, 
 Michael Hornung <mhornung.linux@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779357341; l=3534;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=n6UK1FtuY/AoXkTO1stwerQ6zqA7TUslq0yf910Zmps=;
 b=MVmuiiT2wrZv0hCyktrq/y5Cxiw8ZGCs0Ka3wiy7NTj49V5THaf/Jf99u93j98pnJRnhtaNbo
 WxmPwDqkwLyDtNqJL8ps2UNXV6PVqaxP/oJKDUS7kKpuA5LlUsCWwux
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Switch driver to use dev_err_probe() to unify error messages generated
in *_probe() and probe path functions.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/opt3001.c | 56 ++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 22a73c1afa74988dabf9db10c3b55bd07529fb20..d5262488dac889066a53d3234762e0557f9e3cbc 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -706,21 +706,17 @@ static int opt3001_read_id(struct opt3001 *opt)
 	int ret;
 
 	ret = i2c_smbus_read_word_swapped(client, OPT3001_MANUFACTURER_ID);
-	if (ret < 0) {
-		dev_err(dev, "failed to read register %02x\n",
-			OPT3001_MANUFACTURER_ID);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to read register %02x\n",
+				     OPT3001_MANUFACTURER_ID);
 
 	manufacturer[0] = ret >> 8;
 	manufacturer[1] = ret & 0xff;
 
 	ret = i2c_smbus_read_word_swapped(client, OPT3001_DEVICE_ID);
-	if (ret < 0) {
-		dev_err(dev, "failed to read register %02x\n",
-			OPT3001_DEVICE_ID);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to read register %02x\n",
+				     OPT3001_DEVICE_ID);
 
 	device_id = ret;
 
@@ -738,11 +734,9 @@ static int opt3001_configure(struct opt3001 *opt)
 	u16 reg;
 
 	ret = i2c_smbus_read_word_swapped(client, OPT3001_CONFIGURATION);
-	if (ret < 0) {
-		dev_err(dev, "failed to read register %02x\n",
-			OPT3001_CONFIGURATION);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to read register %02x\n",
+				     OPT3001_CONFIGURATION);
 
 	reg = ret;
 
@@ -766,28 +760,22 @@ static int opt3001_configure(struct opt3001 *opt)
 	reg &= ~OPT3001_CONFIGURATION_FC_MASK;
 
 	ret = i2c_smbus_write_word_swapped(client, OPT3001_CONFIGURATION, reg);
-	if (ret < 0) {
-		dev_err(dev, "failed to write register %02x\n",
-			OPT3001_CONFIGURATION);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to write register %02x\n",
+				     OPT3001_CONFIGURATION);
 
 	ret = i2c_smbus_read_word_swapped(client, OPT3001_LOW_LIMIT);
-	if (ret < 0) {
-		dev_err(dev, "failed to read register %02x\n",
-			OPT3001_LOW_LIMIT);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to read register %02x\n",
+				     OPT3001_LOW_LIMIT);
 
 	opt->low_thresh_mantissa = OPT3001_REG_MANTISSA(ret);
 	opt->low_thresh_exp = OPT3001_REG_EXPONENT(ret);
 
 	ret = i2c_smbus_read_word_swapped(client, OPT3001_HIGH_LIMIT);
-	if (ret < 0) {
-		dev_err(dev, "failed to read register %02x\n",
-			OPT3001_HIGH_LIMIT);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to read register %02x\n",
+				     OPT3001_HIGH_LIMIT);
 
 	opt->high_thresh_mantissa = OPT3001_REG_MANTISSA(ret);
 	opt->high_thresh_exp = OPT3001_REG_EXPONENT(ret);
@@ -894,10 +882,10 @@ static int opt3001_probe(struct i2c_client *client)
 		ret = request_threaded_irq(irq, NULL, opt3001_irq,
 					   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					   "opt3001", iio);
-		if (ret) {
-			dev_err(dev, "failed to request IRQ #%d\n", irq);
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to request IRQ #%d\n",
+					     irq);
 		opt->use_irq = true;
 	} else {
 		dev_dbg(dev, "enabling interrupt-less operation\n");

-- 
2.47.3


