Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793528746;
	b=II5wNqBRgUv5GNEgOTZulfcKt09Nx+Qc7F2hkmY06K7vDeSeV+wvkYbiAxPmNrtDA+b9
	 bgI1ohvfclIFEgyGLEtfmS3L+2mUwSzNoYdHGlJI2Y2N/PkWSFbg4RVnsTlvexv/BRYC1
	 SVe5mtDZIBWorOeHdfG+zmu4yJB3jGoauu9gfvxZrBHL1qgEmBAoFBXwgxWmPx4Yb/J/T
	 LNYIT3f9XuU8f+fKPn6uswmq8RuPxI73tdBppLjO2Ka72lcYTmkkKMrPZwyQbYjEcrrwY
	 Pj4E/bFpZsL2Dyf9AnDh3HoACHlyDhZdsY3+rBiYGQPoq58eU9QGhTdMvaXiAPSLpAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793528746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0WNWdAH/5+xVZy8kDLSNEMLIm1NWHJIuWvqvMrdiB/Q=;
	b=ioNSqYtmPwOi4mnSnzMSKVqkVWQsb0O8rdWvtU2sAVMjx8AVhry9XMforMhMOz2Y0Z6K
	 I602zi7OitfMRLq6tjmtxk3Df1+PZn5U0UhEQIs29PAuh8HQJN8DEfzkkeuwF+lXnlJIt
	 LZ/TwGidhGdMmFNoHQxi6X+HN5UNiOLL4lmQEXoOzx5hVwlM2d57SwBEdh+XhRb9e/NuW
	 cYH5kPo43O14aknsnxwIFS5w2zJzgRqInV0l3FEaw/DsU9tNpUe/7aPeej6EdbFqEEbkK
	 pnESh3C9nJnXWAnWuhdCWijIigrrgCg2DqYEameseaR8D+jPeKQmsusP71pmsTlL47g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b5CTssnI;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32E4606A330
	for <linux-iio@vger.kernel.org>; Sun,  1 Nov 2026 10:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E32E4606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b5CTssnI
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-15943c9c005so301368c88.1
        for <linux-iio@vger.kernel.org>; Sun, 01 Nov 2026 02:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793528745; x=1794133545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0WNWdAH/5+xVZy8kDLSNEMLIm1NWHJIuWvqvMrdiB/Q=;
        b=b5CTssnInoLalaKG7mYWQqQTj1jvMnkisvs/9OXE7YcgV8rSQXzSYMWHGzE32E0naq
         uuGrTZrCiikAdzdZalQzj6MC/nMR23/yWzhtoSyeoIB6zbZQSjMeSeWI3dySdGPDQktN
         U5FDt0JZVis38IaTzwGZMt2QI59/fkREzd891W+FshvnRCZc+++7Vj73NrbTUTToSqai
         45m7K0KBeViVkwkCGehTfm5gEh8wlsARcYxvbf1jcp3rKX1GrVYN9R/S+/7JW9xiQ/I8
         nx/NvYJTrpDm2x2ToMPjVz9w4dEgKDxQxRfCT2YbysMkVQbaDfDgEjKP1n/g+0sYE4fY
         kuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793528745; x=1794133545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0WNWdAH/5+xVZy8kDLSNEMLIm1NWHJIuWvqvMrdiB/Q=;
        b=ov57iIFKtOTp2gZIQRWSdNN6LWf9+Iml3Qa1OzEXtDZPnU5r0UE+aioNGubJM3+rx9
         3gzQlUrbZ0q8tELswpiTSmRxFh/f6TIaA5lGRVLCPapaPZZgtBvQe7HI/fNZ9Aw2GBx3
         3CjmzLNiS4wdTl6AcBdGS8VpCpjVZqRPq0Tj8JVsuoC9mO6AjA/6sq9ahqQfk3tG8HuI
         H1qhw3u/YtVPxKy6rCWow2+ODfmwpXhx9MJphXkZdLqZ9xFdoNzERFawhmZlncpwMdkm
         aSnpAHV6qy6WC5XKKQQNIfNmENYXVDelR36AD8+H+2ISue7gtCN1bPLeHC/oZsMxGp6r
         oCsw==
X-Forwarded-Encrypted: i=1; AKwUvBxDMwpgCVCbTw+vkXwO1mNtLJydwbBE13adbd91jTtcStw/9cv3e5yBQmPLaGjqEUeGEUUrl7TzgHE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKeI4bGSSAyW0QVO6sbAibj2xw1RRQy6eIdmq0KAAnjDG5h6jfu
	V/1NZY5DtM0qc17DA5/aZvmbHScDXjwYWncgpTiyEXp2OdKhEWCJAN8F
X-Gm-Gg: AYBFou1waa0y2b2KaPJD4Wxv1SaA+8Yem6Jf1tMmSMWt0ggExDOZRACBckqrdHMycgY
	JtIsg85h7ssl/EL/GSGWQSXyFSGg46ec3Xzd7cRxQeJ12xM5n5UwSUStkuPZ/3cOnqmlKvtD0wQ
	NdeaUdMhALJuqwZ+IPUabAs6lW/IfykBIkk4MvFA/N8W9Jud+P6j8mDx7Kwv57eUcDU6086ioBR
	VJ1YPaTKWiHDiJeFE0YOBlh1P+96QwleV6IBZM96DPpEb4whK3oNVi1rofE68fZuulC/vZ1wxt2
	QS7IldwBc9Nycng8mlMrlGcaKObHxQbRyAUGHmNr9abgsdB/HPvKpqTqIJ2Ixt6T0sjO5XO0rWR
	9LYaGyJWjReljooGKubCdiQyTHq+74qdm75jOr7lo5w9SkwWB9EFsPjaP7fSwvhTCBcBtayDDt1
	7LpcEuVHkdU8npt3wL1Kqaj9FjcG1feUKMJmCgG0QZpw8EiXFMSZq6L0AHvuMY3DhCcUP+arwwU
	UpU/ntYs819Y3HW+f9/OlO1YHkZZZN71UhaNLaixznnSmQSdn2l6FqM2VKSVvTMYuDft/iKCSR6
	EUEVmdZ38wWrGDIQ40ZG50pN5v4v1CqG1Uk25FlBlGHF4jPteOlbxSZ8rNZx60yiJyEVqMqgdvY
	lyLyPVegpLaLgia1cLgI180ZEfO1uKaC1m/Rmu8G6sIMwLhHrHTjQ/KM4qctfBTZERNrKnx3J/S
	Nbq7JgWaZQkLqQKS+1RtsnTGq3qvbbliCoApZPoVtILw6L7cRR5EoZ3k52kq5UD7Lx
X-Received: by 2002:a05:701b:4244:10b0:188:ed6d:ebc9 with SMTP id a92af1059eb24-1ac5e6f5225mr10635487c88.38.1793528745096;
        Sun, 01 Nov 2026 02:25:45 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b106edc7f8sm6767163c88.9.2026.11.01.02.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 02:25:44 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v4 3/3] iio: proximity: sx9360: keep the IRQ balanced across suspend and resume
Date: Sun,  1 Nov 2026 15:55:04 +0530
Message-ID: <20261101102518.22757-4-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101102518.22757-1-kapoorarnav43@gmail.com>
References: <20261101102518.22757-1-kapoorarnav43@gmail.com>
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

sx9360_suspend() disables the interrupt first and returns with it still
disabled if a register access fails. Resume isn't called after a failed
suspend, so the interrupt is never enabled again. sx9360_resume() also
returns without enabling it on error.

Make the two mirror images: disable the interrupt as the last step of
suspend and enable it as the first step of resume, before anything can
fail. The driver works without an interrupt line, so skip both calls
when client->irq is 0, as sx_common already does.

Fixes: 1cdb4c47f7f5 ("iio:proximity:sx9360: Add sx9360 support")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx9360.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index ed83d809ecf5..f89c556e0989 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -797,8 +797,6 @@ static int sx9360_suspend(struct device *dev)
 	unsigned int regval;
 	int ret;
 
-	disable_irq_nosync(data->client->irq);
-
 	guard(mutex)(&data->mutex);
 	ret = regmap_read(data->regmap, SX9360_REG_GNRL_CTRL0, &regval);
 	if (ret < 0)
@@ -809,23 +807,29 @@ static int sx9360_suspend(struct device *dev)
 
 
 	/* Disable all phases, send the device to sleep. */
-	return regmap_write(data->regmap, SX9360_REG_GNRL_CTRL0, 0);
+	ret = regmap_write(data->regmap, SX9360_REG_GNRL_CTRL0, 0);
+	if (ret)
+		return ret;
+
+	/* Last, as resume isn't called if suspend fails. */
+	if (data->client->irq)
+		disable_irq_nosync(data->client->irq);
+
+	return 0;
 }
 
 static int sx9360_resume(struct device *dev)
 {
 	struct sx_common_data *data = iio_priv(dev_get_drvdata(dev));
 
-	scoped_guard(mutex, &data->mutex) {
-		int ret = regmap_update_bits(data->regmap,
-					     SX9360_REG_GNRL_CTRL0,
-					     SX9360_REG_GNRL_CTRL0_PHEN_MASK,
-					     data->suspend_ctrl);
-		if (ret)
-			return ret;
-	}
-	enable_irq(data->client->irq);
-	return 0;
+	if (data->client->irq)
+		enable_irq(data->client->irq);
+
+	guard(mutex)(&data->mutex);
+
+	return regmap_update_bits(data->regmap, SX9360_REG_GNRL_CTRL0,
+				  SX9360_REG_GNRL_CTRL0_PHEN_MASK,
+				  data->suspend_ctrl);
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(sx9360_pm_ops, sx9360_suspend, sx9360_resume);
-- 
2.53.0

