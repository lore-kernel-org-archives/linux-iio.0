Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DDF448CEE
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 12:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784118476; cv=none; b=Fm5xzcgmUk2MfxrvTYPF/oLnEsfQxKZsO3AXcbKk3YYGaaxaZZEOD0htMzZOcF7MpTf0cNBs28pVgBvr5mjj64CvgK98ucL1RWRDvvB246ZAc7TORpw62ONPgqC3CoiSLfT+GCBQb46+cvHi61kHAAxsLgpv9LWL+Tcq9CtfpRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784118476; c=relaxed/simple;
	bh=dm9nW2iDC7Blmz0joKHenTSW6fNAAaYJo3/DVFapXIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Akh0AH3Z1TYl9rUPTldZLKGMNgAvKO8iagbIEXsXiikxwsMbooPSFGipYLVJKdcEgyYSac3h0BDO+lztMBx9mKGLCMUW0VxMjZWQtKEP1DsmRWV1TuvI7FFIufsL6nvtkgPShhhVukonhWx7DhDxb+aWQMqVRjw+SNBKMbWpE1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=eWjIJNJ4; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="eWjIJNJ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1784118469; x=1784377669;
	bh=4txtrKsUBGLy0L51a+7SG+rC6dcravOeIwVdezpahkc=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=eWjIJNJ4p+ARsZSDSHgfm40F5QxSLm6tJ0+ImSUc3HKeC9TCwFSgEMYgW1815akil
	 KML0ia1Ob0JHtwxJg311BQ3+4UD67amiE4OxTysmaYhweLs5Q0I7AzsF4vjp4oTlCN
	 1QyiatlJQm+QEuRtM2OKWyrbUcd/rw0QeUmwksTHYyznMEcmf4O5Hf2NO4aGPSY5qH
	 tOseTPqteCeaOHee+eAMg2gaPNobxGysM8OZ0C78Irb+aUbDNoOtPOSsXD+BRNY4Qh
	 PTiOURVjMHmDX7iL7We932SWXqo9Y9P8MmZHw2JoRGnMJwNWonRyG5+s8nCUwy0q5Q
	 M0H1Hq2WoxlPg==
X-Pm-Submission-Id: 4h0b6X0DNxz1DFDy
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 15 Jul 2026 14:27:26 +0200
Subject: [PATCH v2 4/4] iio: light: ltr501: Power down chip if request irq
 fails
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-liteon-ltr329-v2-4-d18af55edab5@geanix.com>
References: <20260715-liteon-ltr329-v2-0-d18af55edab5@geanix.com>
In-Reply-To: <20260715-liteon-ltr329-v2-0-d18af55edab5@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>, 
 Maslov Dmitry <maslovdmitry@seeed.cc>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784118460; l=718;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=dm9nW2iDC7Blmz0joKHenTSW6fNAAaYJo3/DVFapXIM=;
 b=T/VRQqT4oI8j04k00nlKb0rWxgksPtiTaFn4spKAZbU2YUgcxIfXMB5Ua2gu/qqy40cDwvXQQ
 lSiho35B4YQBzkpgzC1KdKdp0J58q4C4bEZII/l311sY1X9gUVR8Ngs
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

In case request irq failed, we were leaving the chip powered instead of
powering it down again.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/light/ltr501.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 379e57ac5f5b..9d4de798e5ab 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1571,7 +1571,7 @@ static int ltr501_probe(struct i2c_client *client)
 		if (ret) {
 			dev_err(&client->dev, "request irq (%d) failed\n",
 				client->irq);
-			return ret;
+			goto powerdown_on_error;
 		}
 	} else {
 		indio_dev->info = data->chip_info->info_no_irq;

-- 
2.55.0

