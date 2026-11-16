Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793850;
	b=sCteQM2tW20lMLdPZmchG+TVPR7MZCVpgTZ2ccuBbKq/UjtClDQVysFqxiats9gozVdB
	 DO2AIVncPvONo8T36ziry7zMHfrK5o2URPVr+jJ16yB6oFDY9vX97mW5KgbrJdgG1m1yE
	 68ME33FxjRRuqeHOyp+psJDTPBHvX2w+DaG1+Bk2i3i44UAis0gaarKOJOv27obCEGEXG
	 1wdzWPfNZOpXVkj1fF841jB5Uhy71+dTsh+zoTOkiOE5aOWwtMYzAhly8LLMMBrkAHPf8
	 0YpAvdeRL9veJE67oYiqjF8nTRyrHr9hLrS2GZi577DIot6/QbiOn6Nsqiz9/TDNK2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793850;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jFwk4Zemtrm4ht3jnJ6TydPD7rUeTLMMaLKzdtozJkI=;
	b=aDz1PHbRoRgGh2sG8LLa/G0r7FK4CLK3Cbj4Mu++iXtdeJUfC11mFO2+Dpw2sLm92Llp
	 0cxCsJHtyJu7ywya0mEq0B6Kv0hQpblVQs6oGG/LFS6PDNcJutBngECxABnkb6OTZNwX2
	 QuwHy0r73yv+7ypZnhqMw/EZWAinSI2+SF0wwG+0Af3tLHOvlIdTeJTaEq5zAMvkr4YAY
	 jtxjVHk7Qnxeqi2SUlSZM4kzX+0hCm4IWelyBy/UuBxs8dIzdM5fFTwjiCuZRNfvBp1f7
	 s4Z5FdTA5naRxYqjafchOnj7+kthBarwzLi57nzUD5KQ4PCElHNI5dfHRghy6hEcU4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T03CegPC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803F1606A89A;
	Mon, 16 Nov 2026 01:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T03CegPC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5131F000C9;
	Mon, 16 Nov 2026 01:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793850;
	bh=jFwk4Zemtrm4ht3jnJ6TydPD7rUeTLMMaLKzdtozJkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T03CegPCwiJYMH5rnwgyAQ3l2rOxgKrkB7cLQlbNbUUo9mdpkJCSdMphpcKw8jpcG
	 R+in2e4otv/A9TKH45G6ZS8JACgKQq1q4U4QGAYBiQEYGSKuXcRb61hQuHio59gcm3
	 ASiPSw1GymkqTOqLtCL0/++ObAQQnIjuQ6ETWauXLnrXQQl/JOfzZgOzP4bzMdjsk5
	 /N1zqBIzPeXJ9tPxJ9f5JSxth4oudPgxlhE4pcdwzJ4bpK7R0ad/EVPIweTYSfVwtM
	 fgy5hgmpPTNeqbOAiH9sVB1J5maSjbyaR/5oj6okyTz4JOCfXLaEK+dD0scS4KOlP9
	 Vc2WQUZbwBJHg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Martin Tuma <martin.tuma@digiteqautomotive.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	Gustavo Silva <gustavograzs@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Tomislav Denis <tomislav.denis@avl.com>,
	Jorge Marques <jorge.marques@analog.com>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	Dan Robertson <dan@dlrobertson.com>,
	Jianping Shen <Jianping.Shen@de.bosch.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Maxwell Doose <maxwell@maxwelld.cc>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Esben Haabendal <esben@geanix.com>,
	Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Abhash Jha <abhashkumarjha123@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Linus Walleij <linusw@kernel.org>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 24/35] iio: common: hid-sensors: use default_trigger
Date: Mon, 16 Nov 2026 01:48:12 +0000
Message-ID: <20261116014823.3132576-25-jic23@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116014823.3132576-1-jic23@kernel.org>
References: <20261116014823.3132576-1-jic23@kernel.org>
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

From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Set indio_dev->default_trigger rather than taking a reference to the
trigger in hid_sensor_setup_trigger(). The IIO core now takes the
reference during iio_device_register(), so it is not leaked if probe()
fails after the trigger is set up.

Set it only once nothing else in hid_sensor_setup_trigger() can fail,
so the error path does not leave it pointing at the freed trigger.

All users call devm_hid_sensor_setup_trigger() before
devm_iio_device_register() and do not access indio_dev->trig.

The ordering in this driver ensures there is no leak today but
this patch will make that ordering much less fragile going forwards.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index df6c07d6a6b7..44fb4bd1d316 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -278,12 +278,13 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
 		goto error_free_trig;
 	}
 	attrb->trigger = trig;
-	indio_dev->trig = iio_trigger_get(trig);
 
 	ret = pm_runtime_set_active(&indio_dev->dev);
 	if (ret)
 		goto error_unreg_trigger;
 
+	indio_dev->default_trigger = trig;
+
 	iio_device_set_drvdata(indio_dev, attrb);
 
 	INIT_WORK(&attrb->work, hid_sensor_set_power_work);
-- 
2.56.1

