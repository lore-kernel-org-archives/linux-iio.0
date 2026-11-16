Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794869309;
	b=IjgpaxGwgB0jsIGMsNzj7I4DaKnWx6lVmYNs7Z4F4VwdU38RDEghX3lVdEA2edx9Rnux
	 zWpxQnCC5KBxvMWPKafMIFih8JpsS7SqorDPnlxtqNM5ZAyr6dqXy/es/HrQAUfvl2ndg
	 2VjHsu3/qR3SCJIWZBPpBN1s4E3A+sAn56Hvpa9OoX2Zr29RwsGL+ln0XjHm52PQqKWGu
	 XvquY6/qzP0f9VmcmgddFuKWwao5XGYBplQpzJ+T2euDKTA6W/SV1gP8NBD6dt5QQnu00
	 sApoD/2YEjTipJUKrfjH+9s9cpYEL9v8/6MwovdBGTnqnRashPEHamZ5Xau8ilUHhZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794869309;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bZKF6TYd/oNwfZR5R6RX8KffmVrf3Im0dZF68ZrZGqU=;
	b=CgqvDx3glJuuvUHv9t0CBPuGgAiSb1jZa60ife3Jl2EIhIHMgDzBbJk8Uy9ZLIPkFBJS
	 W/Th3xkke1h4D0TjQYVNGZAjEtp9LByo8apIAfw8/tJlgrFeGjZiXXiyWHF1XCmCzwgPW
	 FF2HZtZ894PoMoJe2GhU/DDoIFFYwGQ3FtdFmFFdY39tTeMqI9KhBFGtdCrKf9Q0rUwOX
	 bOTbML1bxWoUsL4U+QoqKsynJ2Y5KWl+a3KTYb3Uhpus+PYjPaffUlAoPpz2wSrPY+OgA
	 TPkFKFLHLXrnbRDOGvURvMnE7HdsBx+CEmYHyt+Pv+L7iEWN15TLsqZWmvKM+t9+img==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CqrdJtqq;
	arc=none smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EC8606A333
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 22:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47EC8606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CqrdJtqq
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b0dba37a7fso37780317b3.0
        for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 14:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794869308; x=1795474108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bZKF6TYd/oNwfZR5R6RX8KffmVrf3Im0dZF68ZrZGqU=;
        b=CqrdJtqqlqqFTPvG21v5VfgDwdnkGw0lkRHkWExpiZRr2MveXfoFTXtiOss415VbDE
         u0dXEJCO3aQ8kiJmmBLtdTEt0VLMkD5XQLKI0wp28opEfbSXx+VFRomGLHOeREoxsdqd
         V0NljsHCmwqNU/130gTTA1L42Fs9uosV9qbGjsyB63I0/JnvJCHgOi0yBW8laDzORAuw
         Od6Oi0w0sFbjIbKgiwANjzFHkZxFODojpGcDwN9BeHhcyOX3RIXeXjT7daBwyKjiWK1K
         mAvd/JwJZyI8dM4OiD7TAznZ7Cob8zennS5HneSbMejsiYIAKr09WIqzhQrZmJ6CiTZe
         bKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794869308; x=1795474108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bZKF6TYd/oNwfZR5R6RX8KffmVrf3Im0dZF68ZrZGqU=;
        b=C3aaYUCT9LyvlDM73yhJ5mFGAZLvNj75JpMZTyRErMIb/fFpU626sCqKejx2a8B2xm
         9X63w6ffqizSCWcALKiELVWX2usjLrWNxyVoI0HCjAKo7ZKB2zCiv1nfbMAEyeX0TRdy
         KFre+Dgzd0I7uHXoNNPK1DhbdA3rl6abKxhziVHGPNBJ2iDHeCAjvD2XG0UK4PBW2m6J
         8A3Ha4ki2feq8+ClWq47oc8EnCLtc1TTsMuMsJej+KYGSF7I1q1BYFTJ+m2Wlk7u5t7H
         mIsYN7IIj3n3K/8n1YSnLARTaffBmSIg/eBCYEBh5psy8zjGGfgqaMOgzuU49LNNrVSl
         I3yw==
X-Forwarded-Encrypted: i=1; AL+hErGY+Y8hY+FyfCcI5YOvJ+3xPgRW2qi9yel8FrE+agxhnOK9HbhfZHjhNoV0VuzweaKECLwoK176WxE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ZqYOO0a4fZD7EMyZW6Ndsus+oTW66FYRHiG3z17nAV2MQdiDx
	nFpNHpLTmLeGJ8iR3czAP/4vSq1SyuEFzD6D8Mwi86y5CgPghYB6cCsO
X-Gm-Gg: AZFdTZcYOYOg6qUeP0wkjRzWLnQWH2VvCSArgUBqZJjKIK7bLcRK3wy7L+75xk96D8P
	7pLl54YyR+jvSJShLrbsVE8Mf2E0nm715imQrBeSKi7tcwvka5cBLzzWHUPhojBTw1AKJdCEtYa
	MEHklg+hwQbrHrUJ8qqs3C3ZB+3YrXehi9rduW84G0zlZtC8lhNQ7Jmd3bylvYPylSAUo92Fi9L
	GSdp1VUvpanWYpTSaP24X/MZi8csUGiJ6TQPzEfd7GE7yczYonHfiBkd1VGcqMxp6mBRUcc3kKX
	HgRLJLCVMP5LDpZuo1gFruICw+C64yF+nuI91TKP/HvhFCoX0Ko+E/D87xdyWeo5K758IXKdLIU
	94bHQU4wMvMAsC9C0PlBVv3aL5waq/b0NyruM9BVfiRvRwiD6WJF4bM7N6osvPsiQbh01lDQ/vn
	u+DcOc7zlqVuTrhIc+g/tMkCZB8zDEvMPAAbxVAnoM5DqYubTNPAY8hRlIt0UEHP0zdvgyvJIp/
	C/685d9qnII/pqU6csPfkvuEZ29vPeq5gAuyawTE8nUVS3fkuVkvsAzDUgXS4S9Q1dXE/KCxDU2
	qYVkUXUYbUU/TyUcmXQSJpEN28Y88ArhaI6Ky/xrnsT6rci0kkoes0vS6nDQzx8OI1pIVgwr0tw
	CigPrG82KFKCurBGLCWQfQWI=
X-Received: by 2002:a05:690e:d42:b0:67b:e822:6ccc with SMTP id 956f58d0204a3-67d895e5aacmr4455238d50.33.1794869308071;
        Mon, 16 Nov 2026 14:48:28 -0800 (PST)
Received: from fabio-X870-EAGLE-WIFI7.tail2bb604.ts.net ([2804:1b3:a803:1afe:e1c3:da60:db44:d0c8])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67db0361f39sm5259534d50.19.2026.11.16.14.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:48:27 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: lee@kernel.org
Cc: maz@kernel.org,
	andy@kernel.org,
	jic23@kernel.org,
	dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-iio@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	Fabio Estevam <festevam@gmail.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v4 4/4] mfd: mxs-lradc: Convert to devm_clk_get_enabled()
Date: Mon, 16 Nov 2026 19:48:03 -0300
Message-ID: <20261116224803.61154-4-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116224803.61154-1-festevam@gmail.com>
References: <20261116224803.61154-1-festevam@gmail.com>
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

The LRADC clock is acquired with a managed helper but enabled and
disabled manually.

Acquire the LRADC clock with devm_clk_get_enabled() instead of a bare
devm_clk_get() followed by a manual clk_prepare_enable(), so it is
prepared/enabled for the device lifetime and released on unbind.

This conversion makes the code simpler.

Suggested-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v3:
- Newly introduced.

 drivers/mfd/mxs-lradc.c | 35 +++++++----------------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

diff --git a/drivers/mfd/mxs-lradc.c b/drivers/mfd/mxs-lradc.c
index aa55f88399ef..c3dd2d80e7f1 100644
--- a/drivers/mfd/mxs-lradc.c
+++ b/drivers/mfd/mxs-lradc.c
@@ -160,17 +160,10 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 	if (IS_ERR(lradc->base))
 		return PTR_ERR(lradc->base);
 
-	lradc->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(lradc->clk)) {
-		dev_err(dev, "Failed to get the delay unit clock\n");
-		return PTR_ERR(lradc->clk);
-	}
-
-	ret = clk_prepare_enable(lradc->clk);
-	if (ret) {
-		dev_err(dev, "Failed to enable the delay unit clock\n");
-		return ret;
-	}
+	lradc->clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(lradc->clk))
+		return dev_err_probe(dev, PTR_ERR(lradc->clk),
+				     "Failed to get and enable the delay unit clock\n");
 
 	ret = of_property_read_u32(node, "fsl,lradc-touchscreen-wires",
 					 &ts_wires);
@@ -193,8 +186,7 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"Unsupported number of touchscreen wires (%d)\n"
 				, ts_wires);
-			ret = -EINVAL;
-			goto err_clk;
+			return -EINVAL;
 		}
 	} else {
 		lradc->buffer_vchans = BUFFER_VCHANS_ALL;
@@ -204,29 +196,17 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 
 	ret = mxs_lradc_get_irqs(pdev, lradc, data);
 	if (ret)
-		goto err_clk;
+		return ret;
 
 	num_cells = lradc->touchscreen_wire ? ARRAY_SIZE(mxs_lradc_cells) : 1;
 	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
 				   mxs_lradc_cells, num_cells, NULL, 0, NULL);
 	if (ret) {
 		dev_err(dev, "Failed to add subdevices\n");
-		goto err_clk;
+		return ret;
 	}
 
 	return 0;
-
-err_clk:
-	clk_disable_unprepare(lradc->clk);
-
-	return ret;
-}
-
-static void mxs_lradc_remove(struct platform_device *pdev)
-{
-	struct mxs_lradc *lradc = platform_get_drvdata(pdev);
-
-	clk_disable_unprepare(lradc->clk);
 }
 
 static struct platform_driver mxs_lradc_driver = {
@@ -235,7 +215,6 @@ static struct platform_driver mxs_lradc_driver = {
 		.of_match_table = mxs_lradc_dt_ids,
 	},
 	.probe = mxs_lradc_probe,
-	.remove = mxs_lradc_remove,
 };
 module_platform_driver(mxs_lradc_driver);
 
-- 
2.43.0

