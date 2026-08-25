Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4383E171F
	for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 08:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646500; cv=none; b=tlVXW8AcBtk8DQm505cp5zh1w9dpeyLQXTDL2iewmC9cVMBAUf8yJXO6CcZnzbEaJOlKup07+9zKexdponUPplrpYKI5lHBDrApDjlymy+a8T6cfNFLYeHOZb1VGNhF+6JWm1Yls6Kdh+g7j7UuLb86TrKiX+U336mYNvkiHXI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646500; c=relaxed/simple;
	bh=J6CKXdotQJvIeF+neKbCAV4H2dOi46lSn607hWnvJHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yq5/aDgnBLKTDO2YC5eJ1GlYLmA3vxAe/8y9SBd69WcSL9WWXvFFFaoOCkKId+stzwh56qNb8Diqf3UwPkXI3GopqI1EA697Elz4WX423ycIAK3xrNJ7oAD0VKkoaLUI5f4d6xRZ+n1Z8sNzYuw0zLHxT5D47XBDogV+EpyiAMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=vHowW50z; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="vHowW50z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1787646493; x=1787905693;
	bh=EarRR+97sPOUmJYkWqPaFQKiuHmjI0O2lNgzU7W0Ogc=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=vHowW50zwAULbZXsjftw84vpOWwQh8MzFtD+ckcMhBh8S340nLUcXYOF2DQ5Yg3U1
	 e2YphIVUM9i7Bvo3OxmECcBf/ew1G9UVow5iOTvm9vKUBWtCUi9C1JcL4YPLJYLUas
	 UkfinK+92xzxdGvSkIt7v19ynmaYxxH70iiazKefsYKPaUKzq1YxXEDKcgCR0sd13j
	 wJPe42qgUOukgjczEj8jfpRPiZ3rmZBzN3ZDbSAHm+M4yVCdatAp25IXnsJTVQ/Y/s
	 cC4jaqFWKnEFzAan3ArtqunLe9VIIVBF5zCWnovhJJWAExmRlQ9zZIWcMS3eEou1U3
	 OudfLERGMSzvg==
X-Pm-Submission-Id: 4hTgs80mXkz2Schg
From: Esben Haabendal <esben@geanix.com>
Date: Tue, 25 Aug 2026 10:27:47 +0200
Subject: [PATCH v6 9/9] iio: accel: mma8452: Use proper error code when
 missing device model
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-mma8452-open-drain-v6-9-9b252804ee80@geanix.com>
References: <20260825-mma8452-open-drain-v6-0-9b252804ee80@geanix.com>
In-Reply-To: <20260825-mma8452-open-drain-v6-0-9b252804ee80@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, 
 Sean Nyekjaer <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>, 
 Christoph Muellner <christoph.muellner@theobroma-systems.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787646471; l=771;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=J6CKXdotQJvIeF+neKbCAV4H2dOi46lSn607hWnvJHo=;
 b=NOF4eK62RTqiBQZ+qlLgEeH8D2SjUD4JILDi3yeONx0IBLUt6t0SorwASxs8J1XzaWg2x1OtA
 cxKDa5mlKIKBGo5c5v30UiQkRdNl5RstPWtTFp8LonZVQy31FwXxafK
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

The device is there, but we don't have data describing how to use it.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/accel/mma8452.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 4a1eb196589a..42e3371cdb1d 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1595,7 +1595,7 @@ static int mma8452_probe(struct i2c_client *client)
 
 	data->chip_info = i2c_get_match_data(client);
 	if (!data->chip_info)
-		return dev_err_probe(dev, -ENODEV, "unknown device model\n");
+		return dev_err_probe(dev, -ENODATA, "unknown device model\n");
 
 	ret = iio_read_mount_matrix(dev, &data->orientation);
 	if (ret)

-- 
2.55.0

