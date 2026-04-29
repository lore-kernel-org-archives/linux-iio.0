Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71D21DD9AC
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 01:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777426737; cv=none; b=iV+Z9SIf6xb5hf/SiIAlNJmbNXbae4qyoZSj3AkJVWKHd0V9Douzof0u/+obMMJXRRHUhOB07ri2ImoH1STRdBhNppUGcE/KVGjATXuYCiQd+grOD5/eh9njjXaWLoriFZeqGb+nsPK2Liqb9OZwTJ2bbQtn5KQkBCCU3f/Loc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777426737; c=relaxed/simple;
	bh=ILy9aqUZ1VI9sn/haLObfzd4n7eIfcI2zRg67Lca9c4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRmMempgBib2wL7mcFG0KjsM1t9VeG1VRR/sElRMOgHTjXMr5vfBJCd/yHJ5S++iD+WiAYUMAPKFO+F6EbR0rX2CjdNql5rqSJ/F10cW61Q+muUGFluIRFcRakcTheEUBYl9dbzHe2AQXLkrgx7p750aVrUQzdBu4Ea1IxsbEkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=J069KSmi; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="J069KSmi"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7986e0553bdso118562067b3.2
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 18:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1777426735; x=1778031535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26g2OfQ4PIM99m0xytDipXqxgdcfDqIsm5Jvzu8E/CE=;
        b=J069KSmioUCyJ7O3O4jVNmpWXmktwR/3prGHKuX9KGuv90oIr2vpJlEvuoeXQAtaki
         HYHR8zUmVUdZTTGsK+gF7k8rxDWWvtowlGQVOqFy77smOsvjyTeEro37YCXhS/55fVvV
         EDAfRbv0UNMiEOrRh6QZP0EbUzO+lZM4ljuYV5r70vbPLG/F+yLTvLuCVGp1k4kEGMC/
         ZwniY9fKrNEwVyw+t7ZRcdB887LOzjWkm2OllqF/7JnJni/GOPzHXUHBScFqbThYQE4I
         CoH4L8/kxyN2bYx1+3yJqV6F3GJAgFEcL+GdTd96MzRlv6UqwRviT9trAoi4UXl6001g
         05LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777426735; x=1778031535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=26g2OfQ4PIM99m0xytDipXqxgdcfDqIsm5Jvzu8E/CE=;
        b=S2S/avBT++Wnn7RbpW22DBxyDk1re8+lc+qM7COmClvovCICGf8clHBW+L9OznE3cH
         2xBGDci6356cD90zf7BBtndh6OMvI5UKrUjRSA4O2f+u9WaR0ZNpMakGBkJAISYeg5n6
         jo+nGWpG4YdStxcgiFQOgpfSWKe/sqbChqd20lCo/kRVL1RrpglMaRbEJBCRCkFMUL8P
         j0rPYXUP3sOL6Ly8a6UknGeNYhpRIvTu7HQ4aTNNIq86FsmCSI7B9wagljjFaUeMc0PY
         c7jRL8ToPmF3iCPi/ldyTx4mdf+9+fBWxVGKHPCrRWw5ZmKdJlv+URMjzYYdsvBHZIDL
         JVuw==
X-Forwarded-Encrypted: i=1; AFNElJ9zVC151pLofuSqz9GRRooJJiDl2Q4omtw6PlA7OTnzzmywccwod9qDdOzSBqDJDU+OSl0pS362k9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCsGqr94g0sqy5Jfjk7GJNtuVaaUMS6xmkLQMlMH6GOw1hK5/p
	Iz318nrCkwTHOooTjlDK/BKqDfsU4I2gsBURn1nenlCxXFMHv8muFLTEtk2/9gN217Q=
X-Gm-Gg: AeBDies0c/zCRJyJ5hNjnlts8k12gwLV9lOa2EuL0VOpwu1lnvXllWaUA2bnQKPOMN5
	/QxpdZBbTq3JIUzShqf4xF46hchhORQxMSgOa4cDbremKr/ZaMl7NEmiBohJgOmOZlpi8vEpgvh
	Emrcsh5RbnFTJAZzlANp6yLVOFjjII5xV37NuEGfcGrwSuIF6lxZTB5sReR703SArj/dhLbsyoP
	iOBZR4F9l8LZi9KEANeeUCHbfVlaBUWsg4jP+DjQ4Q6hZwsW1bPN7CGCuKCRXah51RmhKfjI7cW
	pATM+WvY4UK0n0IBOHcvVvTi/h6Y7h/AZVeIvwiN+3Z8iWqjBHvCwA53ntwTgHjtZCpKCGrGxfu
	cp7hXqYNAfONExwWHbeL9g+knR6n9Eo8crc042JkE3SnrUgVs60G5tVZ3SEv/Fl70jtORiUHVdE
	kXw48unEQvNOgqWe98HmoHRCOMtC206vPIbhriFK3g9kKqMQRZGPcx2rHJX2rSX+D/
X-Received: by 2002:a05:690c:7406:b0:7ba:f186:fb2 with SMTP id 00721157ae682-7bd1d483632mr20245167b3.2.1777426734955;
        Tue, 28 Apr 2026 18:38:54 -0700 (PDT)
Received: from pedrobgennari-Aspire-A514-53G ([191.19.131.187])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd259dc229sm7182457b3.39.2026.04.28.18.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 18:38:54 -0700 (PDT)
From: Pedro Barletta Gennari <pedro.pbg@usp.br>
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	nuno.sa@analog.com
Cc: pedro.pbg@usp.br,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 2/2] iio: light: iqs621-als: prefer early error handling over if (!ret)
Date: Tue, 28 Apr 2026 22:29:55 -0300
Message-ID: <20260429013640.26870-3-pedro.pbg@usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260429013640.26870-1-pedro.pbg@usp.br>
References: <20260429013640.26870-1-pedro.pbg@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle errors as early as possible by replacing 'if (!ret)' with the
more common form 'if (ret)'. This makes the code easier to read.

Signed-off-by: Pedro Barletta Gennari <pedro.pbg@usp.br>
---
 drivers/iio/light/iqs621-als.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/light/iqs621-als.c b/drivers/iio/light/iqs621-als.c
index 25a655b328fc..cd5843e3e2c3 100644
--- a/drivers/iio/light/iqs621-als.c
+++ b/drivers/iio/light/iqs621-als.c
@@ -273,18 +273,22 @@ static int iqs621_als_write_event_config(struct iio_dev *indio_dev,
 					 iqs62x->dev_desc->als_mask,
 					 iqs621_als->range_en || state ? 0 :
 									 0xFF);
-		if (!ret)
-			iqs621_als->light_en = state;
-		return ret;
+		if (ret)
+			return ret;
+		iqs621_als->light_en = state;
+
+		return 0;
 
 	case IIO_INTENSITY:
 		ret = regmap_update_bits(iqs62x->regmap, IQS620_GLBL_EVENT_MASK,
 					 iqs62x->dev_desc->als_mask,
 					 iqs621_als->light_en || state ? 0 :
 									 0xFF);
-		if (!ret)
-			iqs621_als->range_en = state;
-		return ret;
+		if (ret)
+			return ret;
+		iqs621_als->range_en = state;
+
+		return 0;
 
 	case IIO_PROXIMITY:
 		ret = regmap_read(iqs62x->regmap, IQS622_IR_FLAGS, &val);
@@ -295,9 +299,11 @@ static int iqs621_als_write_event_config(struct iio_dev *indio_dev,
 		ret = regmap_update_bits(iqs62x->regmap, IQS620_GLBL_EVENT_MASK,
 					 iqs62x->dev_desc->ir_mask,
 					 state ? 0 : 0xFF);
-		if (!ret)
-			iqs621_als->prox_en = state;
-		return ret;
+		if (ret)
+			return ret;
+		iqs621_als->prox_en = state;
+
+		return 0;
 
 	default:
 		return -EINVAL;
-- 
2.51.0

