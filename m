Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795866727;
	b=Wuv911GOO8vAbRJNyjuFsfpHfJrFi5NA6F07yvLwu/fae70z/JzqvSrbuiA+Yptcqzft
	 HlBPsB6D7I0c81smq1jy4ndPFbvckUXTgNlMwsB4ye2eNJwwdWalI0U8ichwnTpBwyaze
	 8vsQdfy2Z0nbcpiX+yXLUifOkfLhLowuAtkyx8Ru8HUUK8j1o9OEQPE4Fabpma9FGAncX
	 1E+7rd8RM9wwi1GMHPNP5qztPz06SlVs8NUCmdDrkvms7sz9AhAw0iRAYK9Yn62giwjXL
	 oYBqUtuKCPbFPr8Xu/cLa4r7VHe+rn8jYsl+814mSnii/5eV2vnb2zkqHRPwu5EUQrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795866727;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SWTA87kb3BnC5vtYNbhLJFRBLMPszC6ScY1egL/JZXo=;
	b=cxxA1JvGnA93d60GtYw+PP/JxM2iJIgsjixkzMNwtr+hwimz+DpX/1Ga2panKJIapxtQ
	 4lB1/gn4UTAFkbh3wtVXkDBMXAnvELxVRbrhUjoXhTUs1YTLDOyMmQZ0dX99W26AZb7vO
	 yyQ3afWCHtBr5nGbiqU2hwNk2DwpwVdj4/L5ohmZS3lSALNSRd6cc7k6rxVmq1LL9K3OD
	 Up0UFoGGddrGYZPKod8IKCXKn6rvXXbbEQAhKk1zi8KBZO/km3fnYOuPPgxXrYPSXOc+s
	 jYMVhfy7ccV96ZuComzpuz4pDF3HI4TPhQmgpUGpu98/nEdkjjcPQcoYkxxdAr2frlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fMhgfKBY;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CFB606A323
	for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2026 11:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02CFB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fMhgfKBY
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-38190551625so16959427eec.1
        for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2026 03:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795866726; x=1796471526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SWTA87kb3BnC5vtYNbhLJFRBLMPszC6ScY1egL/JZXo=;
        b=fMhgfKBYzxaPTciEXKI8CG743tw8X0JoogxcQTNWFgJDOQzywO2nIz1BSd1cKuzcvA
         TXw6af9heSOOYxWdt4Xd/5pTf9eJlQf/w56sEQsF5sBlmp8Hf7MJTotCC5d9TJ1cs0N7
         6zoBPs/70kkwO+f3Lz6+FezDa+hAG9QJQBEq8Dvfmj3SIcBHyISB49ZgQryOsRtdX2HM
         czOTS3xV71YmxMNpHWaGeCgiqt1cAjXVxP5htsiI7e2a8WkGYVMhN8LDue+dMkBdrkoB
         ig4ti6ZbDzVgwWUoqMs0FMf74uq5r5DmSMHZYN5MFdbg2f8MmPDNVN+8QHEvef0//m2v
         BtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795866726; x=1796471526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SWTA87kb3BnC5vtYNbhLJFRBLMPszC6ScY1egL/JZXo=;
        b=QWXoKzNUfeNuWfthJ8iV5UoiaKOq3q1dBSwJ2aVy3qe2ZlVr1Pqfmq6ujEvlCJQg27
         JEMmwKuuAHwI1hM//G4lP75sRy3umYPytZm375ArJaNSYd/6t3fTRp2y+oUFArwE2Im3
         HyHpAXmcWyaaCxpsdqBve9neIY2Wb1vGTthPSH9NeUlSXl7S2R5gKJDeYweL/qx31vRu
         SJx6Owr6xyHTNqyBLq1NXjIge4NCnuhFqdpDUW5Ti22wuElia6H7rtHj+VUx1Cjr/+He
         X17FF8sz1+ud+bBjPGcf91B4dqZfll6JGnUVD8kUFrwDPAMNeq1njQ3QfGF+NjwopC+L
         RG5A==
X-Forwarded-Encrypted: i=1; AL+hErE0bwM2DqEFMrTQgXcg+H/jMO9YxfiSkAPJXvdujVQuxYaVMa3Lg+lacHFZiWeCUZJJWE79NFYCIFs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/heG56QF+8kQZnqOF63w1+5q/6USbneyNuWcsQKgEgzkUMILAL
	wuPL+IJ+5ovs7Mflt4jIShp+aJXuYkhZ4VuEboYGeY62Dn8WtBVS+7ix
X-Gm-Gg: AZFdTZfitE0p+3XaW5VmMSW3jMnBLQFbM4Sfm3MWMuxDTyhi6ItwH8pXFoPmKEBYVPM
	G8GOWOBClCavyb6GdC27VHC7Vf4TUyo1JahelygTeSPb3MjgwJNRfByzx7/Ck4eLfw2fU/xFBQ7
	a/3aKqym59Bdz+Z/UCAAVhHby7YTV0+VtmLxNG7sVVoRshAoaZTmcazMTopDuW9sK2aS4XPbEfr
	09Q4DBSvZ5TB7HC/90B6IMuqsGIDAlKhUyPanKGEGZVduuhskWTsPqE+2KzWcVsHSIuSS6N1qjZ
	oI+H6e3CJTx0BsqDZ51crJ9UTfMx/qnYB/wJ7w58jutznpSg8tjhD4ZqUXS7oVlDpjVTFr8Nhwh
	xs9OTcrXtvslkWFEBpLxKb4/MXwBOeg/vlB+tvfNhoo3lkZmJgkeTBDVBkekJXDaZqpPKKtX2wn
	GuCq5QjfXVTkxk7EuoTZC0zJ0Epvq/Km1t4Vl214WMB7QTRrYc1sccPoec0z59Jg4OcXD+K+X0a
	4CvDxFzLZGOgt7h9Ikg6D/1uk2Qk0kmGXzL1U6e7KjR9I2Acyok4ocsmMoeRvjTxrGOfoI4kN8h
	N9moY+RnktQ8RVXkYDTDsf0PJiMKQREjwpBSRei2YM9jozHfkYsalNJ7DPsk90TyzLFr9xA2GA8
	82TIM5FYDak0pOv/Mm1JM+J08aXujB5gh4Uk98nKeo3wti04YgXR+oWCKhVJmlhxL2+yXdScEr8
	wJsKrRdAvD0frEItX3EsrX3AcK0mbAkiZUtD47PTdZJm4=
X-Received: by 2002:a05:693c:69dc:b0:386:aff0:6109 with SMTP id 5a478bee46e88-386aff061f8mr18853178eec.2.1795866726050;
        Sat, 28 Nov 2026 03:52:06 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385c6830815sm74256544eec.20.2026.11.28.03.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 03:52:05 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v2 2/4] iio: proximity: aw96103: use the default configuration without firmware
Date: Sat, 28 Nov 2026 17:21:39 +0530
Message-ID: <20261128115144.557411-3-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261128115144.557411-1-kapoorarnav43@gmail.com>
References: <20261128115144.557411-1-kapoorarnav43@gmail.com>
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

aw96103_cfg_update() falls back to the built-in register defaults when
the aw96103_0.bin configuration file cannot be used, but not when it is
missing: then it only logs "No firmware." and returns. In that case the
chip is never configured, the channel scan and the interrupts are never
enabled (aw96103_channel_scan_start()), and no channel is marked as
used, so the device registers but never reports an event.

Load the defaults when the file is missing as well, as the comment in
aw96103_cfg_update() describes.

Fixes: 07b241262dca ("iio: proximity: aw96103: Add support for aw96103/aw96105 proximity sensor")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/aw96103.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/proximity/aw96103.c b/drivers/iio/proximity/aw96103.c
index 483b3bf18d19..4f205d6ea030 100644
--- a/drivers/iio/proximity/aw96103.c
+++ b/drivers/iio/proximity/aw96103.c
@@ -589,12 +589,13 @@ static void aw96103_cfg_update(const struct firmware *fw, void *data)
 	struct aw96103 *aw96103 = data;
 	int ret, i;
 
-	if (!fw || !fw->data) {
-		dev_err(aw96103->dev, "No firmware.\n");
-		return;
+	if (fw && fw->data) {
+		ret = aw96103_cfg_all_loaded(fw, aw96103);
+	} else {
+		release_firmware(fw);
+		dev_warn(aw96103->dev, "No firmware, using the default configuration\n");
+		ret = -ENOENT;
 	}
-
-	ret = aw96103_cfg_all_loaded(fw, aw96103);
 	/*
 	 * If loading the register configuration file fails,
 	 * load the default register configuration in the driver to
-- 
2.53.0

