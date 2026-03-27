Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB8B37AA65;
	Fri, 27 Mar 2026 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774639539; cv=none; b=J7oBbteKLKeEZh4NH1e8qedIWVHPuk+fiooYPH/LEppL98bBj0sAP2QGLFJhuFFth0BNXNwtWKX0RtTQ9YfuPHKU88IE2Qyd7E6Yk2jpGT7eaVu13f5jLvrAkbYBfuXcakFlqgjh5OYywRn8eAgXymU+4twsP2Mmuk6wDX94e7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774639539; c=relaxed/simple;
	bh=AouEMh+9qJXDl58MVHSWloHhKYSV4+RqC/aq6zCjMd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmKZLGqJZsMMtIGNhFas3Oh19awD6eeRKwrQn1twFD8jXbGqtCzqWMeMJT0F4pxcUcSmsEejhXZBCLXlQqdq8tPotI+cp2HrxMsidGLgyGog8HkSsjtuYp+dxkiUq7i7kl+o04+i//e9bcFEX5wYWl9Te4c+Hi7XxWbPHQx7np4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: vPqx8N+5QQOJfx+gkyvYwg==
X-CSE-MsgGUID: s7ktMOKQT+SGdbVWro2JdQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 28 Mar 2026 04:25:37 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.36])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 891EE4014C3F;
	Sat, 28 Mar 2026 04:25:32 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 03/11] mfd: rz-mtu3: use device-managed mfd_add_devices()
Date: Fri, 27 Mar 2026 21:24:17 +0200
Message-ID: <20260327192425.438263-4-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327192425.438263-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260327192425.438263-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace mfd_add_devices() and the custom cleanup action with
devm_mfd_add_devices().

Remove the ret variable as it is now unused.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/mfd/rz-mtu3.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/mfd/rz-mtu3.c b/drivers/mfd/rz-mtu3.c
index 6b9c6831dffa..3be6f6c900b8 100644
--- a/drivers/mfd/rz-mtu3.c
+++ b/drivers/mfd/rz-mtu3.c
@@ -300,11 +300,6 @@ void rz_mtu3_disable(struct rz_mtu3_channel *ch)
 }
 EXPORT_SYMBOL_GPL(rz_mtu3_disable);
 
-static void rz_mtu3_mfd_remove(void *data)
-{
-	mfd_remove_devices(data);
-}
-
 static const struct mfd_cell rz_mtu3_devs[] = {
 	{
 		.name = "rz-mtu3-counter",
@@ -320,7 +315,6 @@ static int rz_mtu3_probe(struct platform_device *pdev)
 	struct rz_mtu3_priv *priv;
 	struct rz_mtu3 *ddata;
 	unsigned int i;
-	int ret;
 
 	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
@@ -353,13 +347,8 @@ static int rz_mtu3_probe(struct platform_device *pdev)
 		mutex_init(&ddata->channels[i].lock);
 	}
 
-	ret = mfd_add_devices(&pdev->dev, 0, rz_mtu3_devs,
-			      ARRAY_SIZE(rz_mtu3_devs), NULL, 0, NULL);
-	if (ret < 0)
-		return ret;
-
-	return devm_add_action_or_reset(&pdev->dev, rz_mtu3_mfd_remove,
-					&pdev->dev);
+	return devm_mfd_add_devices(&pdev->dev, 0, rz_mtu3_devs,
+				    ARRAY_SIZE(rz_mtu3_devs), NULL, 0, NULL);
 }
 
 static const struct of_device_id rz_mtu3_of_match[] = {
-- 
2.53.0

