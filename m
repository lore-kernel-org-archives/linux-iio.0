Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881030;
	b=K1fxAnDwFMf6LRksgGSIWA1/Ew1ro+B6Ij6g+XV5RHVrXqzTXnqJlBER7vfUdNgaoS0Y
	 z1RNdEPvXBb2xHSTCbQi7JYAvOYGU+Qs6Ht1Ez9rGTrloBVyXN8LUBj+Cm66G501k0Yx4
	 AslP1vrOEosJMMhYbn+rIEI84eRQJwHMVXDA98udKQShiJ7uWEtAOSBtPeTJ+yu9C1GPm
	 Ys55RMFVET5s1D0oaB+KT70bQe9nziDf/Rq95xLDbppLiiYDHm3BJE+Gm40hF1nd7FSHy
	 Qz2/5R3I4d0HwlSDxohxZ+402DBwP710WRydt6HMafFkiA0SzGsB8H/0vjXm5cXBzBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881030;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=w/G/SZ3MRS0nVkYZ3P6OOxY7K1c3qFCCUcF4ElPyBrE=;
	b=N6/x7fmWDA82iFLrnFwqLzmiZNZz+WTtRVoLbmPjhRrx8yOLBV+AwtlaKKz6uhpZMov6
	 TQ+i3aZAbhhC2pSBNM/hsoKc2c6kaaLVSoTIQs3I3vRrrih9l5o5QIyTq2CeRy+khsAZ4
	 d0qE0ze9WNV/x2zseJNeygGk5KiAU6hZiUPLorbTO6/GoLSxVIdMn/m/7n7Jv+IT28ZGj
	 yFCzlyFx/p+oYB65ndt/gGSoCjwntx2+bjO6MBVZCzddyP6P5qfOmleJFAzXBdvuohcup
	 uXYTVWOB+wmd0rvD9Oa83/5NdzevQsKLynqe9I9hTsu3CbsIiuUdBL8yTK3VRs+HX7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V7dJGiwY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789E2606EEB4;
	Thu,  5 Nov 2026 12:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V7dJGiwY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3C71F00A1E;
	Thu,  5 Nov 2026 12:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793881030;
	bh=w/G/SZ3MRS0nVkYZ3P6OOxY7K1c3qFCCUcF4ElPyBrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V7dJGiwYtoT4G7lSSHhbBlz1rNcR+P+46KzdFRg2BxsIuLIj2e0owSc2Uz/vWzWg9
	 QCyENJd4jyVEN9GXt3rhFfQDVdIulOCNr7wZr55IuCnJmlb7rAxFjUib64YtKYb3kh
	 CxfHqO1PrpJkI/8i1YjWnyRThSIzwz+SFW5dV9M31qge7DMMhalvfny3J9zQvXplAv
	 CjGTWyIGVAnZA8841kXHI/kd2lkTXbONXrdxgESdw4JSoS/oYL/rkXxLoqgi9HFfm6
	 0L0S1cqomF22mLQmn8zG8dCbQT1khczOT2pQbBq+yBN4txf+c7dLm/aOcrXsr/YGXQ
	 9MF7k1l9uvgAg==
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
Subject: [PATCH 03/10] iio: accel: mma9551: remove redundant pm_runtime_dont_use_autosuspend() calls
Date: Thu,  5 Nov 2026 12:16:28 +0000
Message-ID: <20261105121635.1612-4-crofts@kernel.org>
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

Remove the redundant function calls.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/iio/accel/mma9551.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index b260e294606a..f1a39a9acd06 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -485,7 +485,6 @@ static int mma9551_probe(struct i2c_client *client)
 	return 0;
 
 err_pm_cleanup:
-	pm_runtime_dont_use_autosuspend(&client->dev);
 	pm_runtime_disable(&client->dev);
 out_poweroff:
 	mma9551_set_device_state(client, false);
@@ -500,7 +499,6 @@ static void mma9551_remove(struct i2c_client *client)
 
 	iio_device_unregister(indio_dev);
 
-	pm_runtime_dont_use_autosuspend(&client->dev);
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
 
-- 
2.47.3

