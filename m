Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E303F65F9;
	Mon, 31 Aug 2026 12:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178664; cv=none; b=aWmCRpekRW/ZNIwGvuyGd/Y57sA4SSSorFj5seFH/Jo6AOK3bqfTRjmp1Ld2jS9zuxTZJ4rvw4m5yEanGLIMQAwMSKIIq6LuyzeCUU5ftg0BN77ET+EeSxVWkFAR9z8Q2FB2J/v3eqLyXNTeenfYFvsPs/C4NpWHl+zkTF52OiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178664; c=relaxed/simple;
	bh=AWHYlcyimQjHCbUfTxECGxpmKTdCKYrmlVvAMK6JI38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g2p7jWGlBD496BL2FXHwPufBGQZezuIjyPwO4Y+y21MWbNibzsKPBrwd1WyinMc3Q4LfZRjvkocCgkRrbkMlCT2DOSmvdWqzX9TVjsqUuurg6myusJnbVuYf55fcX66p3iju2ApxykhSUQ7AUUDhqFlY+APSvlDNQ3ot1MuzejI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=dHg7kXyI; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="dHg7kXyI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1788178649; x=1788437849;
	bh=OwE8NpkZGz+F7fv34BezQkEN0ja6obEPsXaNt76y2dY=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=dHg7kXyITQma/muVpSjmmdWdfPD6ZNq38YENY5rbQy+1AP6F3L9IxASt1pCnVIYUz
	 Cw6dWYUn7ndwY/16GvZMQTMEpiBEhNg+SXXE42HSmGhge319KahDGJi+QIgXNRfT1r
	 0a8nRN1tR25ep1LfayFskBhSE1BnO/89je4764jIj5XPPFxKmH776I0s1QvKrsAisj
	 uZJ5qf0vnz95VroSdwmDBMpW9p+0ngZQ+IrMPd0ko/aO7zc0bmv+r2lKEKh1Ql3v6E
	 hA2ZqE6iAptnHpUxdCTrlJjp4+YxMRT+rD17RkA5SK2WwRvDIB10QQc741fD+5f6Ak
	 5gZSGYKPKVaig==
X-Pm-Submission-Id: 4hYSfw1kyCz1DFG1
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 31 Aug 2026 14:17:11 +0200
Subject: [PATCH v7 8/8] iio: accel: mma8452: Use proper error code when
 missing device model
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-mma8452-open-drain-v7-8-22946812c928@geanix.com>
References: <20260831-mma8452-open-drain-v7-0-22946812c928@geanix.com>
In-Reply-To: <20260831-mma8452-open-drain-v7-0-22946812c928@geanix.com>
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
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788178627; l=855;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=AWHYlcyimQjHCbUfTxECGxpmKTdCKYrmlVvAMK6JI38=;
 b=KKwueta5sttswppcOEXFm1pzYgb0Ihn9jIW5JhYGZt7GRVeUGdN9DwlIJGpXE1CuBqzBHXYZR
 IjCc/9N/ZkIBRijIK56qHyGyuxrDjqQVY85SSvywa1+ATmTrRQ9EHnS
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

Switch -ENODEV error on i2c_get_match_data() failure to -ENODATA to
satisfy the IIO coding style.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/accel/mma8452.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 9619b200fa5a..9eaced6bf242 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1597,7 +1597,7 @@ static int mma8452_probe(struct i2c_client *client)
 
 	data->chip_info = i2c_get_match_data(client);
 	if (!data->chip_info)
-		return dev_err_probe(dev, -ENODEV, "unknown device model\n");
+		return dev_err_probe(dev, -ENODATA, "unknown device model\n");
 
 	ret = iio_read_mount_matrix(dev, &data->orientation);
 	if (ret)

-- 
2.55.0

