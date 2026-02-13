Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBD036213D
	for <linux-iio@vger.kernel.org>; Fri, 13 Feb 2026 15:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770996125; cv=none; b=FDhthUdiWA9zsmVO7m7H05wZ+/NaEQfEtBGDBzCtDHFxZxnqGwnRF9BsXE94CaBPS+O1TS2qF0YSp6ml/Yjk5N/Pwd1c0BnnLXWSj3f+nj4LHONgiR4PhLZlMsrC60cOu+OEz5raGnUI6Cin6VW6BQDHFSakPllFX/zRh/Zcdtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770996125; c=relaxed/simple;
	bh=MTOwoKcxAPZFSxZSEyJ02B9TZtaimRRkuonsCTf0d6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gnoumrmG4bKDsBKTXJL4R9Hp0UjHDYhqJZfIogEV6Kkla+zQhOH1LDlvbABOXQeja9QJMqxXLF27vHJqhcJaGjZL6zZOjJ6Pjm2YBvNy4HpBJKX5MRyHgb+7WB/mgM5j1c33EnrF1uzCIsGxApvB1ia2LQGIWgkAneSp6FmOGDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cI8oMsnV; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cI8oMsnV"
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2ba85f77203so153107eec.1
        for <linux-iio@vger.kernel.org>; Fri, 13 Feb 2026 07:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770996124; x=1771600924; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=24xeLq4glj44WmB+Xh6EwNPiqaMVqiDvD+zsYj4BBKk=;
        b=cI8oMsnVwcnJrfwFkdU9cZCuOUpb7VzYLBytx9nKaBZlgvOAvA5pvDo70oFyD8G9ui
         l/BnUVWMF0ndXNKyaBFQcfrTdr9t+8OHI1yPKXiH56hq9NF0FCJjCrc3djSY7ew0+Y4e
         gtlE8oHCcLXawFaQEdlpQXZTfLqHxGrocVOSv7Qyg0Y9E2OGozdohztrIdP+wXLgcxRJ
         whXxZODzPGwdw51VFgNSZfLAfM57fhCjRN4uycOE7rv3z40pNqPEjx+jIwdNn8ae7Kgd
         3L90ArZ7TB2k7dgmwyZdcImL6seCSWw1MdzTEMOtvL5rI7sVKDk+8yFB9kjZAgDkqKSP
         57sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770996124; x=1771600924;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=24xeLq4glj44WmB+Xh6EwNPiqaMVqiDvD+zsYj4BBKk=;
        b=v3qSd1GPncikK4zgnDb6YfRyxnMOe2lKwuoKWBqfKEOzEunfQGY+Bl1qXAV/gDxfQW
         NrtM6idqO66cDRZHTW311yp34OBOg1R/uB9QcIGrjE1RBM+HJsi6vaTMYcOXrvxt5YpO
         TCiWElKWV1I09sM6Ame9VRGKlIhXjJs02svwUakdMJaUDsRWgRSpuxwZcu1by8B916a8
         lpBktYFWNMy/V7enNqhzVAHNKX+PCbYQncwQ85Llzmq2kVaQz4guA3nDxt3gf2/7MTxc
         DEa6PPLQiA50SqCv+TPto0+xTS7JyJNw3BiAs3LWHyhJ/nL5ngcVTmqvBazVOB62IRr7
         b0gQ==
X-Gm-Message-State: AOJu0YzHbEEOr7Mhm2Qzfw0oF2D/az88Ncx2kmHOaaUxYwmDPG/I0vbi
	+U45Hp4qgwG9auyvUiUjov1bhYYoyYSTimg3aszRJlxSWieZNRyk4NRV
X-Gm-Gg: AZuq6aKoTjMql7d3G+DSbh7LtFA+iH+vpytkb6HFrXmdutofo62N/brGIE4SYQ62Wlf
	sCosNkkvi2jQgSLtAW3fhjzaZlhNjeFhVUdOxDSMKIqbFdeOuIK0DhsrhEvMx76AXICFVld2ip/
	YZualG7u7PtcO84Ud/9Db4cNsh9FU81IngQW2Knabln4hMDik1BpkHDo5G7CX2ebNAqlXV7ZrF7
	mGcHlSUT3LawCuFLnVNbIy88yS7+BdEtAhcCr6z3uUuYnjybqQGd+R2bT74j2ph5bB4gg/YJgdy
	pCT0PjomdXu4RbTbfeTgWxz0ty0eHKuFhEQR2VJOs+bB3L+4wrPME/gmDwfxO6dquYlvAiEBvLC
	yj6zTnX4DtpF22U7tKda+/wQMbveBBzsswyE0RRUH2ewOxy0wkjVpVibm48q8X3RHzPZ6r7MOe7
	3DKhTSgyZeOvV9oXbz3rjSDitUQcQzJou9S/hULGWwQTmEDKMTVBiQTg0=
X-Received: by 2002:a05:7301:10c7:b0:2b9:1375:b551 with SMTP id 5a478bee46e88-2bab9ea9ca8mr567430eec.0.1770996123873;
        Fri, 13 Feb 2026 07:22:03 -0800 (PST)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dcd01d1sm6755006eec.17.2026.02.13.07.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 07:22:03 -0800 (PST)
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Fri, 13 Feb 2026 23:14:43 +0800
Subject: [PATCH v3 1/4] iio: proximity: hx9023s: fix assignment order for
 __counted_by
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260213-upstream-20260219-v3-1-df9371d29f5c@gmail.com>
References: <20260213-upstream-20260219-v3-0-df9371d29f5c@gmail.com>
In-Reply-To: <20260213-upstream-20260219-v3-0-df9371d29f5c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1033; i=yasin.lee.x@gmail.com;
 h=from:subject:message-id; bh=MTOwoKcxAPZFSxZSEyJ02B9TZtaimRRkuonsCTf0d6E=;
 b=owGbwMvMwCEYyfeRr6Zs90zG02pJDJn9jr3zTC3joxmO7vwuXis83fjKJl/x20J5xjqKr9tLl
 m3k+3yho5SFQZCDQVZMkeXM6zes+aoP9wT/ds2AmcPKBDKEgYtTACby6hjDX8Ecu59/Vn8XFJq8
 1FGqe8Jit6myRV7zEwLU3ddJpgvtKmVk+DI/NXlmt59fLW/c9cmJa/+ytzLmKFf0hz5Ievr2yOu
 4hQA=
X-Developer-Key: i=yasin.lee.x@gmail.com; a=openpgp;
 fpr=CCEBEC056F25E1BC53FB4568590EF10E7C76BB99

Initialize fw_size before copying firmware data into the flexible
array member to match the __counted_by() annotation. This fixes the
incorrect assignment order that triggers runtime safety checks.

Fixes: e9ed97be4fcc ("iio: proximity: hx9023s: Added firmware file parsing functionality")
Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
 drivers/iio/proximity/hx9023s.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index 2918dfc0df54..ad839db6b326 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -1034,9 +1034,8 @@ static int hx9023s_send_cfg(const struct firmware *fw, struct hx9023s_data *data
 	if (!bin)
 		return -ENOMEM;
 
-	memcpy(bin->data, fw->data, fw->size);
-
 	bin->fw_size = fw->size;
+	memcpy(bin->data, fw->data, bin->fw_size);
 	bin->fw_ver = bin->data[FW_VER_OFFSET];
 	bin->reg_count = get_unaligned_le16(bin->data + FW_REG_CNT_OFFSET);
 

-- 
2.43.0

