Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117993;
	b=0J69Mc5Rnj8iiMp3N2zpgJwkjzak+HqTYoSsySxmzJG+VPMkcJJYfsSQZNxEqgo2pZdo
	 Vg1w9E/0Qy34RvUDoodxxowLenpv+EdA+JwlIWyLbgrZY8vU8RCcjU10sGfQjU8mYCGCO
	 Nk48kNAjgr7kK2Up95G+4nbE5Xspbv9qjcMNtNeeyMzjMIpXih4e2c9ewzP1u+LWgPHBu
	 j4P/d0VUTH4kaFHe3fp5Pmh+thC3f5wJXib+Ijwp3mrwG+LRlCwFDmZZ16GpRiEZtMW6R
	 gc/t5Wq4I412gemyevlIQqQgG3tS6Qhl4G9YOJcMv07qNgOctK62prwYo0/fVwMzmJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117993;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=OFJjFkZdzibB5A58QKF8LDurn2JAd1jMkyXCmJDkT2g=;
	b=aCjkZlngK+BeSSNgdpb3cGqzS+t/TWPvKN8M+XJP6mPpUyxccm/d8jHEaoZHos3Ciu4i
	 KdbK0mJEFtWx9KYzvcLjVbF/3QdZcqVN4MuYaOIsnAi1aNHzxNwgFQfzsA/+sTP+cIEeJ
	 dHYMeS7+yEMdwrUjcidC4W6ZjVosbGWsPhuWpMKTU0dP860WnThRdtmT+VH4mJHPf4Ywc
	 /dI4ouQYGpErNbM7QWFIg0wby5YZPexcANipdJMsUv3rY7cbURkhiMCFtL+GB0YToyDA4
	 RGyM6fUdRW5O9PCVIGfFV3uXl8FR7lTjEcMwN9sf/BkAb6aVbMiDNdYjVy116FSrGZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=SS7d1kpH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E9560A3838;
	Tue, 27 Oct 2026 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=SS7d1kpH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71951F031E7;
	Tue, 27 Oct 2026 16:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793117993;
	bh=OFJjFkZdzibB5A58QKF8LDurn2JAd1jMkyXCmJDkT2g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SS7d1kpH5zQ23c4d99cjfnX/T2vDnbdiBR8kLGbWzYjPH+axN3z7mo6mfG7vGwT8H
	 M2zf6R9a3mDSndFt520FqnkHHQTrgbsgISAV6vtcS/UYYT256d9GN8LON9bRDa3GZ5
	 +7CQJAk4XybaL0e+lAOTnng24TYyGSfVaulZXKp8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 17:19:17 +0100
Subject: [PATCH 13/15] iio: proximity: sx9500: hand on probe deferral of
 GPIOs
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261027-llm-char-misc-iio-v1-13-0d818334f6c7@linuxfoundation.org>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
In-Reply-To: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
 Siratul Islam <email@sirat.me>, Vlad Dogaru <ddvlad@gmail.com>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=3503;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=IJtpxjlyEDsdBGiMTEvYSBQO0IBMipNZgzP3WJE3uCI=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPzjO33tmfI/RrMmcVh8lRlZ4fvgu9G/Xvx8598e7Y+
 V9v1kX2d8SyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBEpn5hWHD5BMP8Y30HzizZ
 6BaXI9QdFLYkwZ5hfsr3xk2513Ud+RsP7BLveeyuGWhRDAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Josef Bacik <josef@toxicpanda.com>

sx9500_gpio_probe() treats every failure of devm_gpiod_get() as "the
line does not exist".  If the GPIO controller has not been probed yet,
the lookup fails with -EPROBE_DEFER, and the driver binds for good
without the line:

 - without the "interrupt" GPIO client->irq stays 0, so no interrupt is
   requested and no trigger is registered: the device has no events and
   no data-ready trigger until it is unbound and bound again;
 - without the "reset" GPIO the chip is not reset in
   sx9500_init_device().

Which of the two happens depends only on the order in which the drivers
are probed.  Return -EPROBE_DEFER so that the probe is repeated once the
controller is there.  All other errors are handled as before.  The i2c
core sets client->irq again at the start of every probe, so a deferral
on the second line leaves nothing behind.

A system that describes one of the lines but never gets a driver for its
GPIO controller now keeps the sensor in the deferred list instead of
binding it without the line.

Fixes: 45fd5f8e10d3 ("iio: sx9500: add GPIO reset pin")
Fixes: e53111ad5dea ("iio: proximity: sx9500: Assign interrupt from GpioIo()")
Cc: stable <stable@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: "Nuno Sá" <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: "Uwe Kleine-König (The Capable Hub)" <u.kleine-koenig@baylibre.com>
Cc: Siratul Islam <email@sirat.me>
Cc: Vlad Dogaru <ddvlad@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/proximity/sx9500.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index dadce9b44227..94cc577f4404 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -853,15 +853,15 @@ static const struct acpi_gpio_mapping acpi_sx9500_gpios[] = {
 	{ }
 };
 
-static void sx9500_gpio_probe(struct i2c_client *client,
-			      struct sx9500_data *data)
+static int sx9500_gpio_probe(struct i2c_client *client,
+			     struct sx9500_data *data)
 {
 	struct gpio_desc *gpiod_int;
 	struct device *dev;
 	int ret;
 
 	if (!client)
-		return;
+		return 0;
 
 	dev = &client->dev;
 
@@ -871,6 +871,8 @@ static void sx9500_gpio_probe(struct i2c_client *client,
 
 	if (client->irq <= 0) {
 		gpiod_int = devm_gpiod_get(dev, "interrupt", GPIOD_IN);
+		if (PTR_ERR(gpiod_int) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
 		if (IS_ERR(gpiod_int))
 			dev_err(dev, "gpio get irq failed\n");
 		else
@@ -878,10 +880,14 @@ static void sx9500_gpio_probe(struct i2c_client *client,
 	}
 
 	data->gpiod_rst = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (PTR_ERR(data->gpiod_rst) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
 	if (IS_ERR(data->gpiod_rst)) {
 		dev_warn(dev, "gpio get reset pin failed\n");
 		data->gpiod_rst = NULL;
 	}
+
+	return 0;
 }
 
 static int sx9500_probe(struct i2c_client *client)
@@ -911,7 +917,9 @@ static int sx9500_probe(struct i2c_client *client)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	i2c_set_clientdata(client, indio_dev);
 
-	sx9500_gpio_probe(client, data);
+	ret = sx9500_gpio_probe(client, data);
+	if (ret)
+		return ret;
 
 	ret = sx9500_init_device(indio_dev);
 	if (ret < 0)

-- 
2.56.0

