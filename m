Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117971;
	b=XJ5nr9SpRvQszeY/dY/r5WbTTMmuWg1G9LS+LKvzu4IWH43ND09HPFJwkM+KMEj6pWDG
	 sxLIpsUMBp6ggqBljG6V+VTb1Qm1Cdw6BG4s7J26n+aaF9S4kHJTh937IYEyaEgAlzPXa
	 H7Th12p0N1cJZPezM33ZzIcW81MNXkZ4jEtAyozODw4ORLAUohlSbbXbPrSJSoI7+mi4C
	 X6ieWK99654IiKJB2PsAudSmr4jiufyJaSL7eLyzeLPVedqL8OOsxojGbZfQ4wBdGGgrZ
	 rTlyYxLHCJKA2v2tNEtgHNwVW/sdCox1Cx0tnlLah9oxc/YH9uTEupYfNLoz704Rgtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117971;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=7FVJUt6DChYyR/z/d9sihJj4FHFwTfYOz/d6P7c+40A=;
	b=c0Le4HWvcyMxJro6+tYcd2ejET4YmCEMMva4fzkWvLsDoPh3aw2iIdmUzQ0H4HGLtGX3
	 E3PQ//jARXRkPiTpv+vaA0KRON5WO98LDu5Ljru8gk5XpvLAixVD/9h5qw9HSXk+93rE/
	 SqAHvNQfWgzVtYKpbRtxgebth2WO47NL8V2kB3tKe13Agiff45BNEA2c5ZtaLXHcTvhuK
	 0fX7q+qL+FeeM1aPSC7YCRG20Ff+pVz+xwQ1OdTVAoOoIK9n0NUx51Y35KL0oAb6ELoTW
	 3UMTUZnx4w4hgFoA6amdix1ukEy4co4J2LGNX+JZu7Nsgw2ksyuRzThMuMNJfwx7RtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KDboIyhB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DDF606A31F;
	Tue, 27 Oct 2026 16:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KDboIyhB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA271F031E1;
	Tue, 27 Oct 2026 16:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793117971;
	bh=7FVJUt6DChYyR/z/d9sihJj4FHFwTfYOz/d6P7c+40A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KDboIyhBSlzi65wWXuseHMZs4EjM6MgNc9KhKRNQvbyyo2eL+8yY+ARM9CVsqO+9N
	 SLOS6+sgUl+8wzSgW4BzCS3KFGI/0jq8L1a/K3NzXUMdz4gGnep/tt4CZdrpr/u6K9
	 pYfsA8Z/4FTpNJbMy2vBEdihRjbia4Cr+QmNkPrc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 17:19:09 +0100
Subject: [PATCH 05/15] iio: adc: check the result of ad_sd_init()
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
Message-Id: <20261027-llm-char-misc-iio-v1-5-0d818334f6c7@linuxfoundation.org>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
In-Reply-To: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Renato Lui Geh <renatogeh@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Ramona Bolboaca <ramona.bolboaca@analog.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=3596;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=VvMG1d1Fm7zK0vuCzlL59P7HMuBWsCmdTHCmpuM4/EY=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPzjNt3eAh/m5zgUjqpDdVC6QDCy+cEBeYdatVmkOiX
 Tz2wq+MjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjIc2GGebY79nHUm14V2SNg
 3PmCq0DcjlfxN8Mcntl3WQ89ZjmiIsbCLvOgZV2MAF89AA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Josef Bacik <josef@toxicpanda.com>

ad_sd_init() asks for the optional "rdy" GPIO and returns the error if
that fails, for instance -EPROBE_DEFER. The binding of the AD7780
describes such a GPIO.

ad7780, ad7791, ad7793 and max11205 ignore the result. The function has
then returned before it set the driver data of the IIO device, which
devm_ad_sd_setup_buffer_and_trigger() dereferences a few lines further
down in these probe functions, and sigma_delta->rdy_gpiod holds an
ERR_PTR() which ad_sigma_delta_clear_pending_event() takes for a GPIO.

Return the error, as the other users of the library do.

Fixes: a87ef09b1fdf ("iio: adc: ad_sigma_delta: Add support for reading irq status using a GPIO")
Cc: stable <stable@kernel.org>
Cc: "Nuno Sá" <nuno.sa@analog.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Renato Lui Geh <renatogeh@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Ramona Bolboaca <ramona.bolboaca@analog.com>
Cc: "Uwe Kleine-König" <u.kleine-koenig@baylibre.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/ad7780.c   | 4 +++-
 drivers/iio/adc/ad7791.c   | 4 +++-
 drivers/iio/adc/ad7793.c   | 4 +++-
 drivers/iio/adc/max11205.c | 4 +++-
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7780.c b/drivers/iio/adc/ad7780.c
index 1cfad70320fe..c1428f30241c 100644
--- a/drivers/iio/adc/ad7780.c
+++ b/drivers/iio/adc/ad7780.c
@@ -311,7 +311,9 @@ static int ad7780_probe(struct spi_device *spi)
 	st = iio_priv(indio_dev);
 	st->gain = 1;
 
-	ad_sd_init(&st->sd, indio_dev, spi, &ad7780_sigma_delta_info);
+	ret = ad_sd_init(&st->sd, indio_dev, spi, &ad7780_sigma_delta_info);
+	if (ret)
+		return ret;
 
 	st->chip_info =
 		&ad7780_chip_info_tbl[spi_get_device_id(spi)->driver_data];
diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index c2688307bbba..10aa40ca35e7 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -435,7 +435,9 @@ static int ad7791_probe(struct spi_device *spi)
 		return ret;
 
 	st->info = &ad7791_chip_infos[spi_get_device_id(spi)->driver_data];
-	ad_sd_init(&st->sd, indio_dev, spi, &ad7791_sigma_delta_info);
+	ret = ad_sd_init(&st->sd, indio_dev, spi, &ad7791_sigma_delta_info);
+	if (ret)
+		return ret;
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index b0f44c144f20..937c8b09ad45 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -796,7 +796,9 @@ static int ad7793_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
-	ad_sd_init(&st->sd, indio_dev, spi, &ad7793_sigma_delta_info);
+	ret = ad_sd_init(&st->sd, indio_dev, spi, &ad7793_sigma_delta_info);
+	if (ret)
+		return ret;
 
 	if (pdata->refsel != AD7793_REFSEL_INTERNAL) {
 		ret = devm_regulator_get_enable_read_voltage(dev, "refin");
diff --git a/drivers/iio/adc/max11205.c b/drivers/iio/adc/max11205.c
index 53ac2f4f383e..e46e90400bdc 100644
--- a/drivers/iio/adc/max11205.c
+++ b/drivers/iio/adc/max11205.c
@@ -114,7 +114,9 @@ static int max11205_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
-	ad_sd_init(&st->sd, indio_dev, spi, &max11205_sigma_delta_info);
+	ret = ad_sd_init(&st->sd, indio_dev, spi, &max11205_sigma_delta_info);
+	if (ret)
+		return ret;
 
 	st->chip_info = spi_get_device_match_data(spi);
 	if (!st->chip_info)

-- 
2.56.0

