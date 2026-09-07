Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4395C4FDE78;
	Mon,  7 Sep 2026 14:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788792714; cv=none; b=B+ea+2ojFT8jGbMEDJ8SY0K8kQSd1NelTKI7WTEJUlnmXKyqqH34UOhfJ3rhnKsiqarrEAshBoY2F4bamPSw+44nvtRspPXqOlPCuDM5Kt74CFb8Vqy6kY7dbE/4rm4eHDMeweRiKgsz1CvMRaOBNjaX89m4hG11Xgryizfw3q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788792714; c=relaxed/simple;
	bh=YMUh/CZnOrJNlDcvQGl6NX9gWyC0FcabPLF83G7xim4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qcp4pgwsI0eABiryHtpTQmtM/2J30A3WDGFRsLjGxx/9iERorl5QeId7lXrFJayY118N2Lvv71bC1L5CjSKPNQIg74SfWzyeBdmjzxOWW/cJWO86wMLUy/Eth4E3WFBDlZIJgQvyvOO1+fjQgJi40/phiSyhYEFqzNeb7Gv93XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=WG9lzDY1; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="WG9lzDY1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1788792690; x=1789051890;
	bh=hZ8NkLxsb0aqcM9RjB1a62QpnBhkF5zI8oO1WOkPQXc=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=WG9lzDY1FwO/AvGgCIyx5I7r42vsIfkC3tdk2UEh5oV9ZlR4VyymYOCRlWTX8SlhQ
	 RrEqNirHbYVVLnL5WVR8pI9XtQJbBIFCtXO5d/rDxJM/ZnuBRSWM4ZGa//9WA7eF+b
	 FLb7WqepUENYxfuaugAIcEIxQ3OvY5JXSyAg8rpoLsBpbtkbpKzo9yFYqZkQWXjium
	 NxbMxyRFTffVxqt4vfSc0frsH6SngTQtVp5TlCTNnhB73/WUXj8p8kKE5P/nGgPzPJ
	 ssVKh2o+i1B0zGa+FxhIr8ZRVyeT91jYp3HmQ25EweRg5qlgFUGaw54a/f0F0j9Ag3
	 4EUHCMZU6+f7Q==
X-Pm-Submission-Id: 4hdqlN23S0z1DDnS
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 07 Sep 2026 16:51:03 +0200
Subject: [PATCH v8 8/9] iio: accel: mma8452: Use proper error code when
 missing device model
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-mma8452-open-drain-v8-8-c17407e22118@geanix.com>
References: <20260907-mma8452-open-drain-v8-0-c17407e22118@geanix.com>
In-Reply-To: <20260907-mma8452-open-drain-v8-0-c17407e22118@geanix.com>
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
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788792664; l=915;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=YMUh/CZnOrJNlDcvQGl6NX9gWyC0FcabPLF83G7xim4=;
 b=ACW3w2nL0o3Gi0RJ9J1uUFWnGe3rNRlzCSDDtO27Szdeo+B46oTTIDOrLRgnopkHhpVmyPKKY
 TUXS2EfllgMDdKuxOvgf3GgkzqpS7awUMzbifiRrDiV85dArC9C4lYc
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

Switch -ENODEV error on i2c_get_match_data() failure to -ENODATA to
satisfy the IIO coding style.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/accel/mma8452.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index b5ab85a86e72..fda29df5d109 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1591,7 +1591,7 @@ static int mma8452_probe(struct i2c_client *client)
 
 	data->chip_info = i2c_get_match_data(client);
 	if (!data->chip_info)
-		return dev_err_probe(dev, -ENODEV, "unknown device model\n");
+		return dev_err_probe(dev, -ENODATA, "unknown device model\n");
 
 	ret = iio_read_mount_matrix(dev, &data->orientation);
 	if (ret)

-- 
2.55.0

