Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795821752;
	b=pGJTxaGOprzBRsho6wXMiIRUf8ovgh5H5VI6uWdkjf/u6SoGCM75d7EpTYR8nuL5Mg2e
	 EG4zkeSVbNW3lrIG3T1yeAsTFxGMxFjYPWkVhRnrhHOwdc0rMMfi3xgbIYvBgssSmZiSn
	 Hxla/13T3bqZoZHaxMleL1VPAiAhoTrKK1x4RahpIm2R+2ABXj8DatXpFQP6VN+V1N516
	 s5dPli/Xgzab7TpAyPh7cnIyq6M70smiEp2vHXu5GhTkCYM4+x5HR6Qn0sm6eC/iKHaMW
	 Rced0BeMXenyQBeV7morFkpkcDeOcJEQ2pkuJ1mEtlP7kLPAcWPK/q2qgPU6+xqKS+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795821752;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Hq7rvbsRcaxo41jm4Qo6/SRz5oMAIKkAB0MNhxGYs5o=;
	b=dZSjZn2wAjEh/z3pvwm+Ano7Mb2Q7ONb5RG8Rwnaa30JDEusZR/iXqvdTJLt/dePtpH1
	 CGtc3H+76xtBCWHmnSiaDPDGANqcqQ+Utof6nqF7ro2bXIn6pK6pi2nkW09dwp3sLWuYX
	 Ad7xKvOKHenai4q0rfaIp4qY8HeznDpnQqyyZcvQHpqZFOnSNh7V/gKhOEZtwwUo7Crr2
	 taNpnknTDHEb7H3jBDKfsrtO0qUum1MWP4PvoB1JySelsPR7wMffbcDd3Q+GMb7k1z9Wq
	 FjqbmRyaJoecX44bDdnEeL2+ZD1U1Li5CjmrCvg2S8232pU2FFrr8qKi/bRSiBIlCEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VxP5UCAe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DC4606A32A;
	Fri, 27 Nov 2026 23:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VxP5UCAe
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795821751;
	b=mr13ppgv9LKgmAb3OZJy4SmLbGK9HP3lWq3wOHaHWAMhMBlms67ENooazDWQfMJzK69U
	 IaIczn7/LnAPsHSVc9bv1Aw5FxZe5/PtEzI25XcFa+C1s/f5BxaNzfpi4piAMWJ+qyB1i
	 V7HfHI9H3QWuczve0h3AgnTXvaRKwgSvKE0BGPn5qhELLAk0V3+LO3QeVtiEju4Ouqx3d
	 NPZtxnW+5NTvdm1WYnngur+Ou6+zGM6OxeBSiw/FSvt0FYQmz8Q/OmF0xpTw5Z+oMkQVZ
	 XATso+J0A69tlM3SMb0whjfF0CqhmOvTFnMCPNgZLEChBVDkTGeWgYm72/eZm3CEBwQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795821751;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Hq7rvbsRcaxo41jm4Qo6/SRz5oMAIKkAB0MNhxGYs5o=;
	b=rWurylWSBi+2jduSd2uvr2vyaavrc2XrqS+/vqS6yyom96JmNXxtzVL0Tnp5MPkFKG7u
	 MeI5fPS2QXNIL9u2ZzEaFN262dehiSPMJTcMvEsz4falmXuH7ZMwuItOtPBDxt+BqYnCQ
	 oksjFEXo2+AG/XeZT/PixY+GY6BX90V2om5U1pNuqr+ODUeCNEApSJwf0lCwZ4CGvYT7T
	 tCTRtmWyZAwwUbAV3L4xAh/7PIsT+SMm7n74HlCrlm1Yq98BoLzIIIOImwaUjSjxfcvh8
	 yhSDava1k4mxfYO0RD8S1NmEUzm2vFgz3SFjU+w+4fFseTJCnDqoNCGx/215tOBHd6A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2584B1F00893;
	Fri, 27 Nov 2026 23:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795821751;
	bh=Hq7rvbsRcaxo41jm4Qo6/SRz5oMAIKkAB0MNhxGYs5o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=VxP5UCAeHfEiijQ3u8reoNxXBHWmCEzKCbHTCvGE7N2s1j3xogKiR2jykENy8ZPCX
	 TFjMb9LfXvRfa7xhmPfR+zTjGdJBdLI4PMABECcvDNxfQ1YC+No8DZDjR9L/3m0ec3
	 R3TKVkw+aGcziXUuaw1A+OOsaZgKztauo4P9QFdQYrKLa0YLFt7zcZo8HO80PECCNF
	 J4RtoqNsbpqu34aJcAww33LcXWrfeM1PHPir/B5X2Xgu2K4c0lqUAZgMUXpa/gdnSa
	 +WhXqrOKrz46n6w74V6dHVN3Id1WJsaKmWgv4u3T5EByQuY/GpT1KZG3DFfQgOeZSK
	 ipVv5nkeMoC2A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A33D24DE66;
	Fri, 27 Nov 2026 23:22:26 +0000 (UTC)
From: Fabio Forni via B4 Relay <devnull+development.redaril.me@kernel.org>
Date: Sat, 28 Nov 2026 00:22:09 +0100
Subject: [PATCH v2 1/2] drivers: core: platform: Add
 platform_get_match_data() helper
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
Message-Id: <20261128-iio_rescale_platform_ids-v2-1-4c35f16c4f77@redaril.me>
References: <20261128-iio_rescale_platform_ids-v2-0-4c35f16c4f77@redaril.me>
In-Reply-To: <20261128-iio_rescale_platform_ids-v2-0-4c35f16c4f77@redaril.me>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Johan Hovold <johan@kernel.org>, Peter Rosin <peda@lysator.liu.se>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Fabio Forni <development@redaril.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2613;
 i=development@redaril.me; h=from:subject:message-id;
 bh=rc/1GfvZE2caXdT5SgAYu19YzMLIslhAQZef0ezkqlo=;
 b=owGbwMvMwCXWeKho1tqFWemMp9WSGLK5BDYmlpf3L+LeVz9x/Vt1ze/S6WsKGX/GM2W56R7NE
 pcSu+TSUcrCIMbFICumyPLfyWhTt5mJ0a1+iVqYOaxMIEMYuDgFYCJ60xn+R/H1XtZSOhpTMUvZ
 qj7YLfCpWuY7/3ctOV2u07T+3Vq9kpHhvYLQdrG9UVJRD1fqTFc7lvLu8tvlZS0/JD6nsf2v5Op
 mBQA=
X-Developer-Key: i=development@redaril.me; a=openpgp;
 fpr=FF4232B28B363432DA8F187D81C2729AADA16A67
X-Endpoint-Received: by B4 Relay for development@redaril.me/default with
 auth_id=1033
X-Original-From: Fabio Forni <development@redaril.me>
Reply-To: development@redaril.me
Content-Transfer-Encoding: 7bit

From: Fabio Forni <development@redaril.me>

device_get_match_data() retrieves driver data through the device's
fwnode. However, software nodes don't implement
fwnode->device_get_match_data(), so for a platform device that is
dynamically instantiated, device_get_match_data() is of no use.
platform_get_device_id() can be used instead, but this doesn't make the
driver code abstract enough.

Add the platform_get_match_data() helper, so that driver data can be
retrieved from platform_device's fwnode *or* device_id as a fallback.

Signed-off-by: Fabio Forni <development@redaril.me>
---
 drivers/base/platform.c         | 28 ++++++++++++++++++++++++++++
 include/linux/platform_device.h |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 3593d45f4a7a..7db56ffbb6b1 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1090,6 +1090,34 @@ int __init_or_module __platform_driver_probe(struct platform_driver *drv,
 }
 EXPORT_SYMBOL_GPL(__platform_driver_probe);
 
+/**
+ * platform_get_match_data - get match data from fwnode or device ID
+ * @pdev: platform device to get data of
+ *
+ * Get match data from fwnode if available, otherwise get match data
+ * from pdev's platform_device_id->driver_data. driver_data is
+ * cast into a void* pointer.
+ *
+ * Return: -ENODATA if no match data is available.
+ */
+const void *platform_get_match_data(const struct platform_device *pdev)
+{
+	const struct platform_device_id *id;
+	const void *ret;
+
+	ret = device_get_match_data(&pdev->dev);
+	if (ret)
+		return ret;
+
+	id = platform_get_device_id(pdev);
+	if (id && id->driver_data)
+		return (const void *)id->driver_data;
+
+	return ERR_PTR(dev_err_probe(&pdev->dev, -ENODATA,
+				     "no match data available"));
+}
+EXPORT_SYMBOL_GPL(platform_get_match_data);
+
 /**
  * __platform_create_bundle - register driver and create corresponding device
  * @driver: platform driver structure
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 3bd0f1f0d870..426148768b38 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -326,6 +326,8 @@ static inline void platform_set_drvdata(struct platform_device *pdev,
 	dev_set_drvdata(&pdev->dev, data);
 }
 
+const void *platform_get_match_data(const struct platform_device *pdev);
+
 /* module_platform_driver() - Helper macro for drivers that don't do
  * anything special in module init/exit.  This eliminates a lot of
  * boilerplate.  Each module may only use this macro once, and

-- 
2.56.1


