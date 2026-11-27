Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795821761;
	b=5Yuh7WmcIIunacKsvId6mhD/4XAqIPRM1YBiDrYLr5ubYsQ0xmiHGS39giFJbABa30/t
	 w9dPpgBt8r5wL1+Zb96y0uwQRFQbvkbFc7n+Gokw6gG++Wo4Pz2TnqcCdOXjMmEp6bcgj
	 KYxXWO0x5j67C9r7S7p0AC+Ozq3XIYxhA00TZfhjJyVIbOyNSh6bN+nLTf8EAcwZGRsq+
	 779+DAh1T6H1pJdrDAxdx5ZVU4Uoy7g0UWCJ19TksBzNWAdVRM8T4V+i7hVCBVv7I4PdZ
	 m43E+2J9seTET1ZnNdQZc0pm7a35L0Ret6ErIlLX0gJ/AhjaoQjeJTy9Dndh+Jij4XQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795821761;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Uh5lY4ClrWrdxaB8GV0I9jHy5gwTfSUHKKjNSN3H2k0=;
	b=gFHIsAcI1i6I36X1DYidZZ7k3rlSpvZvWycIXIiJjYtnz9VZn/AlZECfALHy7JuxNhy8
	 qcCrMmNBxt6UqTIuwQbsEFUMOSTW0/zgYd6rH57Owk6WemgHHOJIUTOgEw2wLmpAe9yL2
	 994YXbCFBM/QHhIrWx+yM719yVYoyQ8enrwe+QVbfyRQUUm4jw4gFhgF4L3s1beyBqDkC
	 QLs3nbaSLZQpqq3TissLZl6jjlbnVANjXT/6TgOVACyVqBTjGZo5nYFMMfm3suDpKhtBB
	 1tGKDpkEjv9a7XQ07CoS0Df4QPnAW/VOqFzheQOIrjCciiITpllasVLpCZgxDWgCGEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a58VN8FC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEC8606A32A;
	Fri, 27 Nov 2026 23:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a58VN8FC
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795821760;
	b=yqomprzG6DAfSco0RgshznNe9wug3WDs6UdAAJD+173hTDpUAMIDykXSdXqFHggbNlqW
	 eCA/oxNgdzG25yGofDbwqFJtDXM6eYtXmoSul7/ZhqpxlOnBPoBy28xgsgeL7abdvXegg
	 BgsU/qm4BecxjoVm5B35Rt1psLFF/9n967fapX+vKBwDGR1KzFDd5RwEn2f0JGxeLoH86
	 RwoXoUzfOFbjXl6TXTpHYRJtG6qck243oKK/0EiGay07a9LxiEwYclxfGz77YropRrx0O
	 FctLyySOsowL0DrncO/N3AR/vMevhE8iGXXtHaVRwXDU9ERIVG14EQytCRTJJF1eL9Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795821760;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Uh5lY4ClrWrdxaB8GV0I9jHy5gwTfSUHKKjNSN3H2k0=;
	b=zzBI8q1yZ4tc3hpbDz8e0eA7iWrIhOC1K9EhYWm0UBYy9BYQ8yKiE1TZCJHHOwBi336v
	 VwEsC0vEFLVVPEf4cg/2062o/gJePDYd03dwkdiCUlTA0J5VXKUE0QtUjIvA+nnhPCmlT
	 9Q4wEkVCCyOznmGwFbE2LEKqz0ZzNXfsrdZK1DEqcBX3LXncGWDo5p/sLrwGiQT/vF776
	 S5OxG35qm6cNL3HGIFhtwmOpqVWuGrchBUyVwrxCg0mM8br6fF1uXAS5Coa3wrD9LYyqk
	 KFIvW/COLCsmnxpp83tTSt0/W3CHFQbhzvSiTixiJWfIEkv3WjD+aQRAMuKQ1G/r0ew==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 488DF1F00897;
	Fri, 27 Nov 2026 23:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795821760;
	bh=Uh5lY4ClrWrdxaB8GV0I9jHy5gwTfSUHKKjNSN3H2k0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=a58VN8FC//5l5Y1JAiBGPeKIIEiH+Acw6kmGXylz/DHxVUg9+jqYGg3YDNa87wYll
	 Z3hI2/BtkW1rOtEztWYLxHuqvGOOwqyc3U5Q+7m/S5ascuLgTQM3mB+UdvZZrUHfy2
	 OKvtnWhP4OgVrNkyyrXmXzx113Q/6j3RnlnNGd22rZBk8WsxLuNmHKYv6slsXj12cU
	 E5udOpybI/9DpCB+ibM8cAtIzzN86odMFX7Au+n6QnYJgzZK481CnHJ3GYxH6OKHM5
	 +5eXy8XuCqUXkV9vMp1JaUdMnC5Wt53chILDi1zOlweVvMKZKSRbvxHLEolot5pKQ/
	 KuuOy/3BHFzOQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C5F3B4DE7A;
	Fri, 27 Nov 2026 23:22:26 +0000 (UTC)
From: Fabio Forni via B4 Relay <devnull+development.redaril.me@kernel.org>
Date: Sat, 28 Nov 2026 00:22:10 +0100
Subject: [PATCH v2 2/2] iio: afe: iio-rescale: Add platform IDs
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
Message-Id: <20261128-iio_rescale_platform_ids-v2-2-4c35f16c4f77@redaril.me>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2198;
 i=development@redaril.me; h=from:subject:message-id;
 bh=+PVgHL+3DkpqptfD2E18XEnVam67vefeMn6aj+Kl9CY=;
 b=owGbwMvMwCXWeKho1tqFWemMp9WSGLK5BDbNlek/4JOwjClMI4CvsbQ2SJLH1idQcLPmqWMvT
 9884abbUcrCIMbFICumyPLfyWhTt5mJ0a1+iVqYOaxMIEMYuDgFYCICsxj+l23g6Fk/W40ru0Ux
 c3V21z53Scl3XydmrZfj9GT4UHloGiPD4hkFVfE92gFFc9hClzXavJ2xduU3bam7TxibCheeqOV
 hBQA=
X-Developer-Key: i=development@redaril.me; a=openpgp;
 fpr=FF4232B28B363432DA8F187D81C2729AADA16A67
X-Endpoint-Received: by B4 Relay for development@redaril.me/default with
 auth_id=1033
X-Original-From: Fabio Forni <development@redaril.me>
Reply-To: development@redaril.me
Content-Transfer-Encoding: 7bit

From: Fabio Forni <development@redaril.me>

When a rescaler is dynamically instantiated and configured with swnode,
device_get_match_data() will always set rescale->cfg to NULL, because
device_get_match_data() is unimplemented for software nodes.

Define a platform_device_id table (a replica of the of_device_id table)
and call the platform_get_match_data() helper, to deal with both
swnode-based and non-swnode-based instantiation methods.

Signed-off-by: Fabio Forni <development@redaril.me>
---
 drivers/iio/afe/iio-rescale.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index c01292a15a29..c268dbaaaea6 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -518,6 +518,21 @@ static const struct of_device_id rescale_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rescale_match);
 
+static const struct platform_device_id rescale_platform_ids[] = {
+	{ .name = "current-sense-amplifier",
+	  .driver_data = (kernel_ulong_t)&rescale_cfg[CURRENT_SENSE_AMPLIFIER] },
+	{ .name = "current-sense-shunt",
+	  .driver_data = (kernel_ulong_t)&rescale_cfg[CURRENT_SENSE_SHUNT] },
+	{ .name = "voltage-divider",
+	  .driver_data = (kernel_ulong_t)&rescale_cfg[VOLTAGE_DIVIDER] },
+	{ .name = "temperature-sense-rtd",
+	  .driver_data = (kernel_ulong_t)&rescale_cfg[TEMP_SENSE_RTD] },
+	{ .name = "temperature-transducer",
+	  .driver_data = (kernel_ulong_t)&rescale_cfg[TEMP_TRANSDUCER] },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, rescale_platform_ids);
+
 static int rescale_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -548,7 +563,7 @@ static int rescale_probe(struct platform_device *pdev)
 
 	rescale = iio_priv(indio_dev);
 
-	rescale->cfg = device_get_match_data(dev);
+	rescale->cfg = platform_get_match_data(pdev);
 	rescale->numerator = 1;
 	rescale->denominator = 1;
 	rescale->offset = 0;
@@ -603,6 +618,7 @@ static struct platform_driver rescale_driver = {
 		.name = "iio-rescale",
 		.of_match_table = rescale_match,
 	},
+	.id_table = rescale_platform_ids,
 };
 module_platform_driver(rescale_driver);
 

-- 
2.56.1


