Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795503026;
	b=g1VQwq2Cm5wWjfpidZGUMuz4kN5CAx86NeC0q9Jp/widdEPwFKDFRCSweDpIkH2j8JLo
	 qcuppBGt9fbMWN6Ec0dwGcgl8lf9pz9lxCfdQH94FjIaXUbb59KCMWIFmEoPt6dIVj+kD
	 1qTBzFwW5RpkL3/BvDh8slVG+elu9vkpjmTsbm8u/f8BwUjf1aAQHncpwMS7Sg4b7SlxZ
	 QxU/C9AoMWY0N1qmCYJLTCisv5lZ8iJLoRudWjFNcJZsqlydRSq/lvAgT+HrW9MKeuBbP
	 NZ85MztviDLIXEq7SAYB77ULaWVgjocdlLw3ukh84FNJ9T3SgROZxmOb0w+Tv76319w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795503026;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nWMZNkQRC5jUVx3esiXyQgwopDn0rW/+vZ2bONYX6sM=;
	b=sRWaFGSbwBCNIk1jrra/GLPrB5Y4PZrk2nPzSBJcEqTVGaqMvVJVNwM5mxBZfTCyAYCj
	 +6tqT14g0GU3tS/IMnHvqRe9QYSs2sUGqCp8EpW+InDAyhmXF4nLfNwlW8cwBOLCr57jO
	 9RDt+/g0xyH06RaWVhds9rFrgxQUgXv5XvhxWbz+FYiY9/5gXZpPwN+elVMPtR7WIKLks
	 J5D60WObTnMlZ4T844+4tOAw3t+88K9ceeRCdqGa3ZUQikXg/AY5EbtiPAXqcAIeBQ+rE
	 HzCJmlXG/aUIMpQhTOLdrATmcw8L7DsK7TcUTkpQXBBttbBvHshXc5I/93SNLx5k3OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iisovWYC;
	arc=none smtp.remote-ip=209.85.208.174
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023E7606A6AA
	for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 06:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 023E7606A6AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iisovWYC
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3adfc004920so38692001fa.3
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 22:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795503024; x=1796107824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWMZNkQRC5jUVx3esiXyQgwopDn0rW/+vZ2bONYX6sM=;
        b=iisovWYCGb8jYZuLMhelnOxG2FxoVTuoo3fPFkhnN+wnLKZ9CJVF/9oiQrWrKjIuxi
         joFuM5G6z3vi1NLYNXLf3ZwQVQu4cwrHPbZbDIYAysNNzKfl/31wLQLsrkMauJTQFZ+m
         gaAm+LDIStJY7gGLWhtyp7qnlEQdmbm2OlhmXUAQNu+W0+odg7MMl4mS/HV5UKZUsx3I
         1XOtGHdx9YbimrBUaZn9hcarQqWuZXOMt/eGZwtyMmm1ZHRC8r5v44UV6E+zkpOYfanW
         gbnfxpK9FKx6h1YTr0m8G14TkWnCPiD++XaWH8cC8a+Xinsix8984ufgal9+DNMFVBCC
         AvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795503024; x=1796107824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nWMZNkQRC5jUVx3esiXyQgwopDn0rW/+vZ2bONYX6sM=;
        b=JNsTIX2x9rsS7JbL9mYuUS8AIWS1ZBIpBt6OZSOozI/lP8ZJ+5KPiO84GLGjPaJFW3
         yZkIaTiNNBL7gdNLVZ+58BFYJidJpwb+eHDd5TmJRqmx3fimXMvfOn3XqQT/4GHIyw0m
         etu27K9ZE0cHcq12nJLaKnaNlIU/gnE49ZvTzj5dKd84stNikgPSEM8dXmlz4DfDSFpn
         Ngfn7uWmR//Pw41w44WAaIBQfMhtFcYcPWpRGDu5vpls7w0kdxA6YMUUA/jB5HeykT36
         /DP9nul8VsDv3fOR0rBLauUCx9bzBxGVReiwSWkj3rNqce3ctZY+zyTMxCA785of2lXe
         AnXQ==
X-Forwarded-Encrypted: i=1; AL+hErFrp/ZdLEH7G2CgxcZQQ7TGDRVBGiH/If8y8cEdbBc6zGaGYg1wV9HtKBfi7pz/cDIu9q23G/LzCqI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9/0oGCwbmEuCwaS4FiiHNTEjgfTOFFx4M9fzGQ/aFyf4yfNQnh
	LI8EUDjhUUzdVzTt2DzGBDgcVhwVHpJ1kiDgMvPGf88KXNt3RELjPFe0
X-Gm-Gg: AZFdTZddTLIUFNWpw4qDfv2s57gQ0DM4tcSZdO+wVwQPyLd5Qq4j77hkR3ZZ4AGNnuq
	HpIMM3L7JgK8Hs4bOeCKyjVIU16w5dLnGm4fKYGlb98WulGvlm6+v5Oh9aWOZnlq9B8D5hW1+61
	ALUbj3k2HD6u7sazsiOVPq2calst4MNrThw1jRgm4UFpb1/5rtAr53u0aYkhlgs7lyySj1Ta8uV
	rhLUoNiwapCCL3HyN6DvKjnB6Xi7ETdIVq97t4RbY3BMMWjrd6wPLdpvuuTjmC5h6LtDPNnBcNV
	J3UIXeLx/R3LGV8ZP1nG3cNxZjbP7p0eS1iviwTZibSSajMumNvNIsWjX0IqKgcZwWrDSy9xMzx
	efOs0saeQyu9L0tXJ05ZWOUohLdUsxfkb1+7kLAUH80PhfrexjeOAZfrIVAwUU7m3AgXgytOiPO
	CgZ3v/DmIgMu48i0ArOBRrQEt+Fnt3eDKMnWztJHK4XA8H0MixqUmbwuQ407mURYeEGYitnGkG5
	B2x4GTmflE+UWm3gJzuydxBU2CablVYjSLhyU6I+OY135VZyB8lAXRWLdrhaElxGCrv2kiVopwU
	KshrRgzelYh3tsd1x8COkh0/dMerwGHXSkqhGTfTBFWcF3L+I+EKKDO5G7mpKlwnijKU+Y9+UzF
	Z9hjC20553NOiz9atccVEgdUNhhxMTWvAaWUsp+0=
X-Received: by 2002:a05:6512:32c9:b0:5c1:5775:d1ea with SMTP id 2adb3069b0e04-5c1bc7c3c50mr4798419e87.11.1795503023960;
        Mon, 23 Nov 2026 22:50:23 -0800 (PST)
Received: from yantra.. (nekmmqsyyquzw1lm5eb-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:3cd2:d52a:a1ef:5dd3])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bd018b45sm3538556e87.41.2026.11.23.22.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 22:50:22 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lucas Stankus <lucas.p.stankus@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH 4/6] iio: accel: bma220: use iio_debugfs_reg_access_regmap()
Date: Tue, 24 Nov 2026 08:50:14 +0200
Message-ID: <20261124065016.185124-5-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124065016.185124-1-zoone.rupert@gmail.com>
References: <20261124065016.185124-1-zoone.rupert@gmail.com>
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

The debugfs callback only reads or writes the regmap of the parent
device, which is what the core helper does.

Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/accel/bma220_core.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index 23eff578158c..d2f21c0ab491 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -369,21 +369,11 @@ static int bma220_read_avail(struct iio_dev *indio_dev,
 	}
 }
 
-static int bma220_reg_access(struct iio_dev *indio_dev, unsigned int reg,
-			     unsigned int writeval, unsigned int *readval)
-{
-	struct bma220_data *data = iio_priv(indio_dev);
-
-	if (readval)
-		return regmap_read(data->regmap, reg, readval);
-	return regmap_write(data->regmap, reg, writeval);
-}
-
 static const struct iio_info bma220_info = {
 	.read_raw		= bma220_read_raw,
 	.write_raw		= bma220_write_raw,
 	.read_avail		= bma220_read_avail,
-	.debugfs_reg_access	= &bma220_reg_access,
+	.debugfs_reg_access	= iio_debugfs_reg_access_regmap,
 };
 
 static int bma220_reset(struct bma220_data *data, bool up)
-- 
2.43.0

