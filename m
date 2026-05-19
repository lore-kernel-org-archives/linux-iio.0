Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C283E1232
	for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779178426; cv=none; b=YgoE1OcS8WK129Qnt80KkB0FZq41xk5F5E9LErBJlUuTJYSJ9oIw3dRESUCiR22+lQLPp9aCJE+Vyuz5pJHnsdW81Web3VsiR3gunpKpZKBUvc2MzIcS6lC9tZqjCU49vyaots0DXMC1rNXFEuCqHur/WrFiztH92Bbwdxvei5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779178426; c=relaxed/simple;
	bh=ZTwwYEX6xr2g/b/Nvm0VpdZ2RdFLiP3TZFzASNwU3wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F8oGdEbp0aUBaWrymTuhBLX3qX1qPNrZqezWMX1apGGQpfaR/lrG8C6N7683R+B5cBOfaJjH2o79uM7UV47adks5hKIJbsqKQkvdGjLkS99/ofQn7Uv2DSbfRKf8pHd7JqEd0adU8RJ1X1jli4UEwew8ECSpAOboOYG27othJ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=l0O53P0x; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="l0O53P0x"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d75312379so2790864f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 01:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779178423; x=1779783223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayRXGtKfFLUn3lxkZT0XA6FcYINv41aojJcQobRm1w8=;
        b=l0O53P0xhOFbS5Q8dqc3CdHh1TMymaAdPfCuL9xrK2LpDW1EnpniQN7uzox09UNDD+
         Aw5gx00mz+g34juK3r2+pe5tHFfV+AhB8+np97ZTEXIi8Tsz3sgJOUp5TXBG4D6RFh2t
         Ab/9yHFmriOH4Ic4glJz6hTglMWx+1kX8UeUtGd5bYH4LhcSTz8qvd06QbBOjZ/200rV
         tuSji1QgFKMagz21s8vLe4yTlKpxF0iMqSkOOJo7jLKrqGhn5nmlF79TLZwg+G+eNxMQ
         UQPmym9PpwYT9o52eJ7GKlCTkksYAkvGApCjv833ShMUVhlx9E73ykjWFHPoZB/s0KF3
         nNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779178423; x=1779783223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ayRXGtKfFLUn3lxkZT0XA6FcYINv41aojJcQobRm1w8=;
        b=RAZkZlRifDyTCYEbhjR9Wy7PUhliTzzXY/ZQHmK9nyd4CqponmEbZOarcURmC920M3
         jo8xTVcSop/+2xJVFzZ0WK+U+I4j1x0JBnOG4LTTS4lAkqRUxwUKTzOaQhd1M2TzLKOg
         94BVCpwtlHIlCnGnrnM96ia4/xfQLjBg2gQ/ue3xWbB7k77HdX9NIQk0FP3dEaPWmORB
         E1nROc/ukRYkKwm/zNwUgkWHlgAVMsGjbl6UfITURZS8pYUdXUAcMpXGMR7Zkfaio9Kn
         KnCIUEnTeiUuNR91GUqNToGGVvUQVFbODO33Qnv/YJ6fR+HKa65+JZmTQKoUMogUMq5p
         rLZA==
X-Forwarded-Encrypted: i=1; AFNElJ+/Cyvg0CiibnHxWJrRQlx0jdLW5l25Mi93q5mJARnTB+7SsZ6bh0UPa1VkEbc5Yss/k4JEmItpF2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpk/fBRZ7nINm2vvE7lD6yYZ0W0wDhQAye1gPjNpZIWEKZ3le5
	J1G0BLSbkt5wuZwkJbRCTVSisimrJzCI9R8LZVdLMMb2PfZvizKCFEvddQndpubjKaA=
X-Gm-Gg: Acq92OEkbbuZl38MyXy0ja1wmnJwmpmWqXPEIVZabLP3YL+HBhCEEM/698IW6tHfgDG
	W8xJksXLYrVzF0mFKKM1IJt0Hh0rWL78FPoHwJmvtO9xxyeX0lY2GIMZV4XGMVLe+SbM0dcTGvw
	xUJODdsLIHFxTn0HKLtjWlMiY6vabfhCzw4MfwYve0nBsip9Lxm6dWGmrtByDwn7NWutT6uCdpR
	HpXXhqH/2tw+4gfPmYxP1FUgqcIFy9xi3x9yIcKl/odjIr2UeHtn8btgqzGaFADkTpQVBpAj9TY
	v2cKTbkUcUzd/o19uYYhCbJAvscxGSZjWaJIOUVtoS2l8KpYGyEJjop/tLrT7wfX7JwJRbazAqk
	HdOz9tMwSYVhfWygCzBV0D66atlW0uUbLu3d+zrL8kMAgjuz2aWHbzz2ojbStspMjdGgqucs0vQ
	CdNhLuvvbpwuiiBoyCv5ap2TuXuZwQ9zFa9ghd79MlAPRcvz9c6jBMyl4dOQTy5M2dY/MhdvqzC
	0Fnk7QjnLmO5fk=
X-Received: by 2002:a05:6000:4b07:b0:44f:69f4:39b5 with SMTP id ffacd0b85a97d-45d9502e84dmr34571900f8f.29.1779178423491;
        Tue, 19 May 2026 01:13:43 -0700 (PDT)
Received: from localhost (p200300f65f47db0428dec7b135f55767.dip0.t-ipconnect.de. [2003:f6:5f47:db04:28de:c7b1:35f5:5767])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45e6a135f0csm25082952f8f.27.2026.05.19.01.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 01:13:43 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Shi Hao <i.shihao.999@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] iio: proximity: sx9324: Drop unused driver data
Date: Tue, 19 May 2026 10:13:07 +0200
Message-ID:  <b5093a1ad184c758855e737926553e34bf21ad59.1779136001.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1779136001.git.u.kleine-koenig@baylibre.com>
References: <cover.1779136001.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1341; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=ZTwwYEX6xr2g/b/Nvm0VpdZ2RdFLiP3TZFzASNwU3wo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqDBukK3uCsJnrWIW3MWjRwgpV59K8Z7XO9fPRF xs8BH9ynHKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCagwbpAAKCRCPgPtYfRL+ TjMiB/9Ip4Uze1V0UI9/5b0MVIRTYBbKQ9S2qHGWHaGkmA6GohgCXaFmKEbvCTnT2qBNBDab6Sc lzDKz946rXWuCzqNNMVWbB2e00LXQPTGMP6UPnuj6Dvt9mMijN0r3/tiFhfv6rdP3eSylaG+zw9 XNGK09f4jpIbi5CwNyTlhVDvI4s+tcsfNvNt5Mop4RTwJLQ4xc7SQB8EPMNiqGVBdjagcfs4tsB mJxAVnUaFqfZrg9HFVj6fmxbdBRq8UVyd+lXnmb4VEb37Qw3cjeUQjDMZwTxTHUUv7lmAbZUkM+ bzsVBjholM4F8w90pGzpKqKUxY0rRKHTcHLeJWxZkRRuKyrl
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The value assigned in the three device_id entries (ACPI, of and i2c) are
unused, directly in the driver and also the sx_common support lib. Drop
them and while touching these arrays, convert to named initializers.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/iio/proximity/sx9324.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index f61eff39751d..36c45d101336 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -1123,19 +1123,19 @@ static int sx9324_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(sx9324_pm_ops, sx9324_suspend, sx9324_resume);
 
 static const struct acpi_device_id sx9324_acpi_match[] = {
-	{ "STH9324", SX9324_WHOAMI_VALUE },
+	{ .id = "STH9324" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, sx9324_acpi_match);
 
 static const struct of_device_id sx9324_of_match[] = {
-	{ .compatible = "semtech,sx9324", (void *)SX9324_WHOAMI_VALUE },
+	{ .compatible = "semtech,sx9324" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sx9324_of_match);
 
 static const struct i2c_device_id sx9324_id[] = {
-	{ "sx9324", SX9324_WHOAMI_VALUE },
+	{ .name = "sx9324" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sx9324_id);
-- 
2.47.3

