Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793815170;
	b=SThfJ61bckez2YXGjO+CA3F0tjjVyTcaMIgWvRaAqdzD0IvqRxSRXimO3g7k7p6XmZZV
	 QXdGtmmazcMG+evMjbOfQvAYqCRQLFOjICn4Q75RWZn3kgxyzTK8B3lhjQM/9/viH3V0Z
	 HImfepCCrHJeEDZoFdo1cSwk63pTM3Is9vCYXPyG5MOP/QMLowbOKsk35iimHDCyqOXJ0
	 k9j4VDdoPW9m+w/OIG78bC+odYLrPq8Fk/OZqJZ9/knuaA+gbbo58bi0MdUIjfst4JPG+
	 RUEI/GN1XqC+wkNNI8o9qPFCJMW6EwldWQ1dQxh426hOEtZIHU+oaCEkOCHe7zoSQag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793815170;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Vxf/fpsGTPmXor2KAJYnDd1RKq6QCmVJtFSLmgZYXos=;
	b=bhy3cyFTQ5nI2k3AGA61Q4o836wJvGcsBXU/0+VD/OnWb1ICcwBGUS9bM3O75WxeqMnd
	 tsRr1GSHf68amXGy83Nff2wRLoo31QLsYPttr7nMIgc0El/38skwgJ5DQ+RNK9rqUouOJ
	 zygXxAw2pKYZZORbruI7QVnA6pY8LEtzFq23mb3bZ2IgEw1R7VeG5k55b1b/1xvFZmHas
	 olHZ+RViq/QEuAnbuM0PyfewZOzaA+DlI53yMqNlLzBjC02uuL8BLhAbofsvj6f1pOSBW
	 uAp5bwiJCDSHWDNOdXwF1uEVswhkp7YJD4MEupCnHKCldpicyJos/1tBHD6D349+1KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t+5CzAV3;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1162606B091
	for <linux-iio@vger.kernel.org>; Wed,  4 Nov 2026 17:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1162606B091
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t+5CzAV3
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36d6e342f98so986810eec.0
        for <linux-iio@vger.kernel.org>; Wed, 04 Nov 2026 09:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793815169; x=1794419969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vxf/fpsGTPmXor2KAJYnDd1RKq6QCmVJtFSLmgZYXos=;
        b=t+5CzAV3CvsGSufs6WujG7BIrkOcV8EagWHBsXCsuvvLNHgJK2bwpLP7oRIvtwJzWo
         FvAAhnlxfgcDJ2Gga15ruXBQRaknxh4ZXwAawgJ+FIE4fNYkhfwthJ9UG/+Cr2gpTtM5
         Lyy0So2M7HpS2SBetNkTKm5J+t3LQNwRoFyJ2793GZ2UobQ+Pz3wCtgqLjH8Oeap5HKE
         7zuD2A/fpjBglAHQW6S+wP7xznSP/yb/OPar17lJ7mDs0zuFMsCwl8Saaq9H/93It+a9
         43cJt8eTgacrZ1Ey/ozAVffU0mxSOP7WaHY56LF60foPFyQ1u+Vws2+jSPvSgSPrFBv3
         adtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793815169; x=1794419969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vxf/fpsGTPmXor2KAJYnDd1RKq6QCmVJtFSLmgZYXos=;
        b=fbYmR2U0sTkKgqPg+0iLlcTPKL8H7wbun8fSnKvYucJMizbe3VZj75PLGfwH+fNKLv
         6tviJJ5OPX+R4QCHK6a+bHwPzPDz3e8J+R1YH14E1yUdxVA0GkCYWFhO51evXAyDrkJw
         ns/ioC6rRH17HLe64ZwZ7pHVa7Et9fAM+hp+854y7JvziuEvgbPHgSXIZYRKa8inaNv8
         27GAx0NHhoD6333U7x5ETuNH5wwfSazZM1NPEASnJCbKT4lmFAE6tutpm17pI5ZqcS2u
         rYEEGK0AYMWXvj4aEUTitLx+hv74lW1l2FExYsCSbYIEAXWw3eoZgiyUq8jA3qOCRmEn
         Fr7g==
X-Forwarded-Encrypted: i=1; AKwUvByuQfMrUwotQXwViWm7HUPXY0HhpdaRTjSR3C+v7yTzQZEwQ7L3Nky7c7yCKcG83v49zJ8+spWTvlk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+NO/LBvG+L26ZBxTsLJISEYqTx33o9XY8D017j5O4rCeA7Aspj
	VjhZdkYOaTDQy6lN6LyREqzsE2nGBmPJXb5uGG6kJZx4bUctmABm0y+G
X-Gm-Gg: AYBFou3QMnOAB6+MgKTXjvFHsg0gwM3y+4fU3dMWd37RoSx7PgOMDhwNh3HPlmtqD0J
	0ZpGzYlRZkOSFcQ3FJWCSl0gDfRR/8FpuFoQmCH8i50hY6DnpYZ8YeUGqTB9RsJtuE4FGHMcPBL
	8aByLxv8klGEcIgNjBxYFVXnLI6ftoYcp/KeILnzBvlE2yaWl0mqVcHZAvc+ts8SuR9PHRluYgd
	cXaczy4NZV3WiZYlQeCgaR8oCz76tmn2iFHX9sGka16qXKe/DZnVL2Hqto5PPfng8xM6d88MrXi
	zvOnWZXz/5/ddXcZ2okOBeBAvTbZT6/9lDc+fgaXtKOiod3jLrGOahAOd9qecGSxLuOdPWcDo2N
	zUH6wa5AdF7kmtGTIhktMQQvDpKhuXRskeHYyJBJQ3T7MoO2VLmHFgw35z/FA3FJshfUG9XEFsS
	vI+ZeJAmwHoCBN+c49hfJVqNpDwiI0DZAPjlNFQYUe5oWUQiemrL8uAxcGGHE3KJNTcwd9qR963
	rlifzStC73t18euWjCLDZeUghLTQWjsd2ap4W94EkD7Y/VtuW9CSafs4cJ0JUrdkiwoe8PHjT8Z
	CuKvgkXYluKK9BEFEW7D7596HSL3HfJ4HbYIKnjzvNt1AVrbCj97qr7HbCT4TPRRxRV2tY1OBCZ
	KMHS5ELQLNaFXOYgh/Ie3RL6E/nrFEeUYdz5TPW02qpm9ew4H5YO6fhwVz82o7fO+AsDlezKLpy
	UuDXk/nbnHJFXxhwzIDOtLultYta0ZSf1MhpNuDVno2w==
X-Received: by 2002:a05:7300:1897:b0:361:167c:2364 with SMTP id 5a478bee46e88-36a42362348mr33935611eec.8.1793815168526;
        Wed, 04 Nov 2026 09:59:28 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.212])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a67edsm8945310eec.8.2026.11.04.09.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 09:59:27 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH] iio: proximity: sx9324: reject reserved gain values on read
Date: Wed,  4 Nov 2026 23:29:18 +0530
Message-ID: <20261104175920.207384-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
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

sx9324_read_gain() is meant to return -EINVAL for the reserved
PROX_CTRL0 gain codes, 0 and 5 to 7. But the range check sits in the
else branch of "if (regval)", where regval is always 0, so codes 5 to 7
are never caught and are reported as gains of 16, 32 and 64, which the
sensor doesn't support and which write_raw() rejects.

Check both reserved ranges before converting the code to a gain.

Fixes: 108e4d4de2b5 ("iio:proximity:sx9324: Fix hardware gain read/write")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
Compile-tested only (W=1); I don't have SX9324 hardware.

 drivers/iio/proximity/sx9324.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 1c8ba28c030a..95e7315314f8 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -404,13 +404,11 @@ static int sx9324_read_gain(struct sx_common_data *data,
 		return ret;
 
 	regval = FIELD_GET(SX9324_REG_PROX_CTRL0_GAIN_MASK, regval);
-	if (regval)
-		regval--;
-	else if (regval == SX9324_REG_PROX_CTRL0_GAIN_RSVD ||
-		 regval > SX9324_REG_PROX_CTRL0_GAIN_8)
+	if (regval == SX9324_REG_PROX_CTRL0_GAIN_RSVD ||
+	    regval > SX9324_REG_PROX_CTRL0_GAIN_8)
 		return -EINVAL;
 
-	*val = 1 << regval;
+	*val = 1 << (regval - 1);
 
 	return IIO_VAL_INT;
 }

base-commit: 340d44bdf9db0f095f99845b5ad8628781d79b6f
-- 
2.53.0

