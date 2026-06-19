Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195513B6C05
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884524; cv=none; b=hxzClRUMl2EQ2zWsFSycokm8vb+4yd8fZqP1LYn+CnVj7ABWKtMxKKDHXqAtjUl3srughsCCKL0n71ywU/tn0faz2j+BvdGTARJCyPjcSi+VU4JiJwkNt54xr6oHGXIOBhSvsjG/wsi9P9EEFrs8iGvBibRIZQGIAQlDzYgIWLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884524; c=relaxed/simple;
	bh=D/QKCbavfLYNx09LrXbgDPC/L79eEWPB5/ghbUmJIH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eAOvu7RV4SfpQiMXlawqvrEjEYZ8pHHf6Jjkga2l6SILF6nHUiv0wkFgG4eVgY75oyrTlWy61jOThCY9eT1ODGGgmV5sKH1b4FGQs+KHSGNYoN6b61FivdT/TXCv4OehqzE+XHCC8IdaZxXKUV3MWpTHE6edp+sEUX9zjIhLQGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=O2EPZ0e+; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="O2EPZ0e+"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-463b2f6fc9dso2311739f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 08:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781884516; x=1782489316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hYJtRsmpankB2fdFXy1nxiyXc6vRe6Y6eSBsNRxIfg=;
        b=O2EPZ0e+Nkcm9yUC6MOlAnsAN8zCKowu1D0T5yZBkXwAPAWn928lyQyBj3WLhJpeAj
         ojIzcm9/LgWxu5QdCrlW5goAJgNQYqMM6vFmBdEcc2zcamu98JNghOb62odMOCKTK1lJ
         fHfg+GwdRv0avTuU/QlqkhDc7uE0PXLk3mN5gQ14g6i+NgsFSyb8bySCd4spqng8BsVZ
         xR938zBEWowOQZ+/wcq9NoUpvnJ48oj4IqrIlDVBK0KfgKp+AzRbSBZrkmdUTA2pipa4
         ducbB7RclstLgFJ68MPZPR6QrWfGi9sAKsdjJeiCef07uvK6+rD+b3KH3gw3Y5qxsljy
         Yabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781884516; x=1782489316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+hYJtRsmpankB2fdFXy1nxiyXc6vRe6Y6eSBsNRxIfg=;
        b=X8eZ5J5Y0zD7nvUZWKPKIDYPjPP64z55XqWuHHseylmFY1PbbWM65Vc373tu0NPzhH
         evepAhBn8nY8i4u02BrFeocSrbfaKqlyOmxfS9BBAjg12a5m/Qx1vrN/WWL/M/+WolQ+
         QyGNaTakjuIixWIWTjBoVK1GkNMiQfNMXgVuF4+n3RRaapZqaoO8W58QuUOBJ4VcA4il
         s0a/bhJzc7r/D9uTRRgibmJBa8XgKoxZlqlpoh7ZgaMjP+OMSEkimoGW9i+pWUSYVK0l
         sE87XyltMVrXJnG31mqfF5/LIzzGHsJdQVReZ5hByC0NkHTJGxpaG0+gO3gEZGjOdwY8
         Uh/g==
X-Forwarded-Encrypted: i=1; AFNElJ+LZTgMKlMZEJQIyG6UFUVsyKPB0Az+K03ERZ4n4dNFqzZW62mDLDuyErfiIwfcst1bxSESk46lpo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPIkc1LpVavv8EbTlvLs4kHZmi1d9IK9ceefuMVa68OH63d+PG
	Ia+1s/EzGUhzLY4mGdlndioYGwdOGyU6BD3Sh5KemRw7rYEb3NyiKuHeOl/zIy/ghLc=
X-Gm-Gg: AfdE7ckDNRrPtUzrHzA6iUN8MdoPfkqclqhOHeWl9HepyHoLFcHZK77j0ri39o1V+Z/
	jJrhqair0ebbvaZlpHpwGeID8gC7COBIpKFh+7Nny/0DsbqsUucOUQE2FCuhLKQe4ddVM4HBHrC
	nDPEgpuHbibZ3sEW3sQj8+A1d+APFpaCOb5F9CIIqidNBi/ZvaE53GW5TPmWPQJwvMVuPWqK8/j
	lnhmvXAspU0+tGzWyu2rUu2tvsLCwswsPvhLdY5OvJ6hf4oTtPPEkT/WfyPzQq61LXPqg6w1xSY
	Br7KuCBSbaMAFic/NwITYKVsxAx2eR4BWe+qKgBM/KCXuD0TiALW6bYHQnFFl8ri3XHy4Cd04jn
	rHLGiYykcHh2e6ngireEe/ubWNWvdl7ammBkTx03eEeJYHNnx2L8XRaG48XxVJ5O7qAc9B6yDAU
	mKeKFQpBJFf4mjbQY2JU92zNiabijLBuhfsOQa5BbxjydQQMUXKWdmmSwynX9F8rDJkktywo8C9
	Ms=
X-Received: by 2002:a05:6000:2088:b0:460:67e0:563c with SMTP id ffacd0b85a97d-465097867e8mr8353492f8f.38.1781884516255;
        Fri, 19 Jun 2026 08:55:16 -0700 (PDT)
Received: from localhost (p200300f65f47db04359fc0e70763236f.dip0.t-ipconnect.de. [2003:f6:5f47:db04:359f:c0e7:763:236f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-466648c53fdsm43091f8f.10.2026.06.19.08.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 08:55:15 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 02/13] iio: adc: ti-tsc2046: Simplify device abstraction
Date: Fri, 19 Jun 2026 17:54:30 +0200
Message-ID:  <da70cb6c053d44033a7f941cefd8e0cd8d382c1e.1781883685.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781883685.git.u.kleine-koenig@baylibre.com>
References: <cover.1781883685.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1768; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=D/QKCbavfLYNx09LrXbgDPC/L79eEWPB5/ghbUmJIH4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqNWY6/H0UfH0Rlo3N7ejAtJ+zEo1z49dqZ4Nc2 9cTbfS62cGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCajVmOgAKCRCPgPtYfRL+ TlknB/9kdxaPjNWUc2yXSOQVxp1XijVaa6YcMR44ATHJMYLV9RLdU3+481cP1joNQFmAKNV11ve RhtgAC453OmvSXuaHzFyYVbB7CCs3Thrj+KnhNWVOX0C+KFmYmshoifiyp1pQ+Acmr4bj4EPGZ/ 2yE25wt3iq51fQ1zwMZewAvKtNQaEDQqPHsWQg8RnN2mq8U+DLUSFL2lOAUvmwuWAQtOvJHpOVV nSGytm/D51d7+7nXJoZeJd9BSPS4pWD1/eobwP39hrVJIwX4PFFLbZtQ56TmytrS1XVl62TOyaX nSR/orwFuX8+d0LT7owcnDU2UcoLWeh/hq1NgsqQwNfRfZDF
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The driver was introduced in 2021 and since then only supports a single
chip variant. Simplify the driver by hard-coding the device properties
instead of using the id_table's abstraction for a single chip type.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ti-tsc2046.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
index aba4b10a17ac..a2e92ce363fe 100644
--- a/drivers/iio/adc/ti-tsc2046.c
+++ b/drivers/iio/adc/ti-tsc2046.c
@@ -739,7 +739,7 @@ static void tsc2046_adc_parse_fwnode(struct tsc2046_adc_priv *priv)
 
 static int tsc2046_adc_probe(struct spi_device *spi)
 {
-	const struct tsc2046_adc_dcfg *dcfg;
+	const struct tsc2046_adc_dcfg *dcfg = &tsc2046_adc_dcfg_tsc2046e;
 	struct device *dev = &spi->dev;
 	struct tsc2046_adc_priv *priv;
 	struct iio_dev *indio_dev;
@@ -752,10 +752,6 @@ static int tsc2046_adc_probe(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	dcfg = spi_get_device_match_data(spi);
-	if (!dcfg)
-		return -EINVAL;
-
 	spi->mode &= ~SPI_MODE_X_MASK;
 	spi->mode |= SPI_MODE_0;
 	ret = spi_setup(spi);
@@ -829,13 +825,13 @@ static int tsc2046_adc_probe(struct spi_device *spi)
 }
 
 static const struct of_device_id ads7950_of_table[] = {
-	{ .compatible = "ti,tsc2046e-adc", .data = &tsc2046_adc_dcfg_tsc2046e },
+	{ .compatible = "ti,tsc2046e-adc" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ads7950_of_table);
 
 static const struct spi_device_id tsc2046_adc_spi_ids[] = {
-	{ "tsc2046e-adc", (unsigned long)&tsc2046_adc_dcfg_tsc2046e },
+	{ .name = "tsc2046e-adc" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, tsc2046_adc_spi_ids);
-- 
2.47.3

