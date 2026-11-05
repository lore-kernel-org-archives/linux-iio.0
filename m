Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881048;
	b=GdHjXYpbYCuWRtp6hjELDuIZtOUm/ypVJWBS/qzhfDQZiZa2NpHwoV84711hs6wDMG1Z
	 MiU+uHM7wDm87EPU8wLDTxSjSr+LCF+sPgORXk9eUNHNXiZUyLBPFdQEF2WnABzm9NnLy
	 Hvra5+1LUyNI6B/h8fbjFYfKRfv2vquVhc4T1gFutIMj+u74MYqRV9PNim0S/+6nr9LQO
	 zyWSUwXEuvJXcLGZaKvdm8lUshnQn6HIFnVQ6i9PypEQ/qiCrE/05biWNssvr+qKOhv1o
	 jpU4iqsMpVSnnedDSEM8iqHH2ooIh/wBBur4ncINH16ZXg/tP/pInSA/KonVx8rh5Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881048;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=i/6zR46dYGjFw0n/4PpbA5N+Te6DN9VonOFVqLNLWQs=;
	b=jWsr/5YUzdzhnCiUSpVFcELOHQcRi80eQVesNh+9cQyDozZlBQ8wqaf5BZT4GXW1he+y
	 2mrl5lqj97zFrCQwAVsGUJaik/3oYPQKqbZ2bYO+/6fCgUJoIVdFAcuKNTrqeROGpfFG8
	 cSypCkgFm+N0jHAySVKlkYxJu3g/hxdhOHdUa2zPq0Y9Y54Ez7iCFB4qMfQ3VvvTdsjFi
	 pOVx9zijCCmsClLGhOwiT1Xt/td2lQoHuAaFC1eKfiX9zN6i+KLc5wihcpvWlhALhe8Zz
	 XlKVdCl8BvOXgE8zDxbTmn2zmadVjjYbkYj9VI6nCqiPZ+K4gIkdvOfwWFh/APQnkAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YUoirBPX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB09606A331;
	Thu,  5 Nov 2026 12:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YUoirBPX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A3D1F00A15;
	Thu,  5 Nov 2026 12:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793881048;
	bh=i/6zR46dYGjFw0n/4PpbA5N+Te6DN9VonOFVqLNLWQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YUoirBPX+0MBci2wP+U5q5aEM9AZBSWaRXbCjqYXEtTEub3LEfepgLooGdhQhI8HB
	 G6KpjHm22BaBjsXyFoPI4NzFlRVn+m2Rj7foza6gC9VXW41puhvwj9f/rJT/SNvy/7
	 I6hlrpqYbqhsmTXsImuMB0hdRL4a4ZIZmvYtMLljiCnweArnarBv6n9tlg8oB7668r
	 GE+sDUN0EEPUQybdh95fxKTQAiwrqbrJlVHXvzwYEgSLZMkc8cyjpJz+HiUAUTILoz
	 UE7sDAUTOmeiO7zMC4WPSMoMaMmldy38v0NUwZjmhaho3ghEv756TW2tV4uJ3kMx1s
	 B562/QtvZ3tIA==
From: Joshua Crofts <crofts@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Eugen Hristev <ehristev@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Haibo Chen <haibo.chen@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH 09/10] iio: light: vncl4035: remove redundant pm_runtime_dont_use_autosuspend() call
Date: Thu,  5 Nov 2026 12:16:34 +0000
Message-ID: <20261105121635.1612-10-crofts@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105121635.1612-1-crofts@kernel.org>
References: <20261105121635.1612-1-crofts@kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
driver core is now responsible for undoing any
pm_runtime_use_autosuspend() calls on driver exit.

Remove the redundant function call.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/iio/light/vcnl4035.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index 23bd0d42363d..c34a2ab073a1 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -607,7 +607,6 @@ static void vcnl4035_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	int ret;
 
-	pm_runtime_dont_use_autosuspend(&client->dev);
 	pm_runtime_disable(&client->dev);
 	iio_device_unregister(indio_dev);
 	pm_runtime_set_suspended(&client->dev);
-- 
2.47.3

