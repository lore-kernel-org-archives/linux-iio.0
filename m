Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881033;
	b=3aadR1lrbQ+RKSxFP12NTe80wzGz0apUXCJ6BbaJ3KG9hpzI16xag1JKbC3BLuXUy8GG
	 yx4XnrYpP+Xd/3g8SknmvPhY0VD6zIimXk/Gjn4SeZrGeBc1VOPn9cYPGyaw9fZCqvZoS
	 oSFnqE4yRYow9VyhVirdzMM+AnAm0NnpWw494T7WZ+Fb7JTnAPZibEdykpsQHSKa6/wOH
	 3cYmShR+vyNW0s3CTRKyRDh66UARjggF0G1bp8piGqEH6CzlcTWHbw/NS+iIh1mZVvC6H
	 DPICWVCrgiSi0lcWDBUetrEP144g0jvCKlMntEcztIDGydCJLci2nIAumOqGVRq5Adg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881033;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wQ5jLWVoPk+bZDBKkEyUn0p6ouIdE66a051s+AWfEdk=;
	b=2zah1FGgpsW3a1lMXDSEwmwRow7chXH1JTzlPugicYHqlJlN97G3kp1nU/okBU5JROVa
	 eyzV41mDcFQJk/rTGckHIH9AAkM21jHvJgRFF9IENN2LlhUMutYn1FVRvxDboaGZ42nYP
	 2wU77dFjMbWPlA/IZtOO+gz52XbGHd09wPO1YmTS2RiRlfFqRnKJrveDSciz5V/QNfe3x
	 J2OZmn16ldr+Rppte2jEAXnfLkuXe+9YU+R+BiTkemJachlV+l83kmBvG7YF2FQy6HHtl
	 kgyl9ZusFVEAHos+j/I6zNEDsHfQnrZ5qDVUGu7W0V1pYvvTgP42NmLD2gFxNqwAcLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QVYaD0st;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FE5606D824;
	Thu,  5 Nov 2026 12:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QVYaD0st
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772CA1F0180B;
	Thu,  5 Nov 2026 12:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793881033;
	bh=wQ5jLWVoPk+bZDBKkEyUn0p6ouIdE66a051s+AWfEdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QVYaD0stkBJAL7+LUNRABRwwlbRtG/XafIDfJlTD8/E7Z7kdyI2DtkorRNi4COiJC
	 kbRSg52AAdqgJfrsv79tOEjCzJDnhfewpcAm7K22ZlWnOCgh+nCdu2S9jY5URh8DhK
	 OANsjirk9Uzv+JEsAH9B06YbHS4ZIO1gk++TNnOkxuS3BMRdAcO5Zh4E9iQUtxeTfD
	 sCZZireYV2Re0t3ukMCHCEB6ohYsctpCjQAsa4gpU/QD9HgvfiGop5NS+y1/2hDkRs
	 0cSKyQ4kKAol+RB4QNV5WrzTZeK7X4IR9H3PdoPoD0DYrbcMvuMRlFoCZgbavze/pK
	 QvDFepXb3IsgA==
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
Subject: [PATCH 04/10] iio: accel: mma9553: remove redundant pm_runtime_dont_use_autosuspend() calls
Date: Thu,  5 Nov 2026 12:16:29 +0000
Message-ID: <20261105121635.1612-5-crofts@kernel.org>
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
 drivers/iio/accel/mma9553.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index f623a0ac6f31..dacea12d702f 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -1122,7 +1122,6 @@ static int mma9553_probe(struct i2c_client *client)
 	return 0;
 
 err_pm_cleanup:
-	pm_runtime_dont_use_autosuspend(&client->dev);
 	pm_runtime_disable(&client->dev);
 out_poweroff:
 	mma9551_set_device_state(client, false);
@@ -1136,7 +1135,6 @@ static void mma9553_remove(struct i2c_client *client)
 
 	iio_device_unregister(indio_dev);
 
-	pm_runtime_dont_use_autosuspend(&client->dev);
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
 
-- 
2.47.3

