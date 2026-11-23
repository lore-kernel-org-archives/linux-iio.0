Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471627;
	b=4PaAfEBc8n275ogGt/ZVnVU0AA3zz1TJ6oAOORLEoux4RjVgMISQ4Q64ey3fYkMD2kOv
	 5NSaBwgD7Ks5FZ59XzYB2nPToSymSuNrIROgxx/KENJWft3c4Zf5PPfkicP5sUJyrGncQ
	 aq+rB5ZFzdx7PrHJEwsH3H/HlI1wJSDVorx8s9jpNBgWLiUpzAzHXe7BeCapebBsX6V5y
	 H0MRx2jiTYZWzdKWUOAo84+IGddR2453UYWxjpbTydhkNADIfoiiNtMH5i/Ux3zeSA3fl
	 n+SK2fNCXmSfB6sLf0u4kKv8MDa/9fL3/+mrzfrv3kJheDQst4RgMNyN2PjKVJ8d9LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471627;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2Wn4ycrprsEYpxFTIDDs955RXGY/aWC7MHO3eiRlG/o=;
	b=JIBwaAhgRpJIzyE1pVfuzMZL9fsAdkZ35tM6hs1Z6SeSdMXAVriBtDzxcTYDjrZPlI5c
	 OMzJQWbGArONvk35k9JKDhvtg5I8JoA/JTdcCF5HKceLzdkXyG4f0H0s1g8KlhhHESaxP
	 4LdJxYG6V/kGaj0OyIc82GqnMrq1020PVgoAE4FlDrv9gWMFe7NEkSbEdWLdgndN+N+MZ
	 YEhcgZWpcApxS0rnFt6mnC+MR9iFRM2MAN8321qi1Jno9VP51Ptd4hPy6zrb5KPSgIXvb
	 KT0jmqq/AWgCOmKaA1t4PQQs3vhBSMy/h1b2ii8LmeH/FrYM0FAJIDmo9mEgwimnU5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vALU0pa3;
	arc=none smtp.remote-ip=209.85.208.181
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64414606A333
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 22:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64414606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vALU0pa3
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3adfc004920so35734731fa.3
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 14:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795471625; x=1796076425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Wn4ycrprsEYpxFTIDDs955RXGY/aWC7MHO3eiRlG/o=;
        b=vALU0pa3OkQ3O0/W6aBnzPoek0F7d4qs+6AW+aZxGHgGYfGS/alpvHfAC5xqC4gm/n
         1/LcjFnf+GGRL1aV0Ksi6uYTku6OJQrHBClxjdLoOiGSfgkU+J5RttnWC5vXCM5IALb+
         B2J59J+UTE0DRo7pl8aIrTdQY4lis8p8B/nwKPEqUux2Qcwz8F4kowX7adylH6Kgsfaq
         tfy2IBnc00opNDTyXaxXzeJgQ9gjc70WKN1/BST0EPNXzsi4vxU2INikAAF5xgG+lkLR
         Uwbn3ibpfhlLxPlWlQFdH3/gybG2CWwKgo6GRaRKdXTU0annEPkizPhUloyCou9HsPJi
         t1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795471626; x=1796076426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Wn4ycrprsEYpxFTIDDs955RXGY/aWC7MHO3eiRlG/o=;
        b=A3AZnd9R9RLRJIZI1k97wrt2vEpYslKGdXijJjLk+iYFATeWSdhreDsHLkB0LUbsOU
         Wm+u8xkIVZ0QN7tRgSRKSp6pr0bb9Zb1v2U5hswiYMCzyRQxB3/zqCgAY90e4XEQqBPm
         1sMlEIclH1+h3pGCyOzFs/D2yWBrBsNc2TUAqaWEKtOVEQdg8KDJNco3+FZGpYCNp/e1
         sbO1patJDLFxWbs64ws/dKWH1kkxoOWM0gv+NInpfNyr9Tca2C0PR1x7ZiuBCOJ1Z41j
         jD+cZiN+XmK435Mn3EJwkJZx+p3PQVqdIieXaRDh6AqD4nST9gq66A8DaaP0Vdk13EpH
         N9+g==
X-Gm-Message-State: APuU4Z+PxfJ+AgBBoGRzHrIDc+EIBkbdZcHrUnkmI/2/cw+zdEJQ+LAX
	WV50B3uBS2HLna6p2zcLfh/yJeul7I116m9nzU46JnN648g5J3nyORE+
X-Gm-Gg: AZFdTZdr+r85NUV4hEfQsZzkz11EKRvIlFTNNy3fvgHQR1uBo0lEWK6LhCnUARQWibV
	HYRUzzGMkm629Pt/HQJsQ2b//xvl3Z8qUWcaCDC7Cac8laTKaPMYV/wRYGiqWA+6k9yDRvMrJR8
	7wasKe+2NeIRXoyFlUSJXGlXgq+kaDcu7ZRHCbf1nhIDUoagcuYlQTr4QPJYhoLdzhQhfMgaoEu
	y/nziOxnY3X6WgiQfHNlVnFScqvLbmRoXDCLzziWbIo50XeZu/fqExTpSPx7J4jv5OWyxhigr61
	y1ll23T23At0DMCpbIkWjtKZc0yAzV3yFVYJtjsXJQUeIF/DYFbJl3+6rpiHZ/fjF4Ykfwb3iUZ
	Avlbu89e0Vt9SaLwg10s1iTixVePwsUyXzxNC5K1HgiZJxE2BtZnKQd3aehnm1jhKZRoco2ireU
	7Py5uo4QsHJ0agOlfwDEXPMy9KkecO+6/mnDlEAVNoF+Lu9w+CsX1Yns1btiHbH/FsFSF50zZc6
	grGA2OPClIfkUTuXdI4oXh3MzQWJEDhlLCdkl0JgzGz8V0pxXLlZZqM+qAYD0yGZM2EDa/1i1N5
	dUWLvVt3Tzj3eDBhGySU2c+zJY674v/aNyReIoMwgHB1myfUKPNVfixHv4OUxdy6pCCStn56Te0
	QsndZ1TNIhfoNfXP4Nclfkxpx1cMBGilmsMPfuQ==
X-Received: by 2002:a2e:a9a5:0:b0:3ae:25c8:dc3a with SMTP id 38308e7fff4ca-3ae7f9a6918mr42861991fa.8.1795471625467;
        Mon, 23 Nov 2026 14:07:05 -0800 (PST)
Received: from yantra.. (nekmmqsyyquzw1lm5eb-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:3cd2:d52a:a1ef:5dd3])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae805215ccsm34272021fa.21.2026.11.23.14.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:07:05 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH 6/7] iio: pressure: dps310: drop the unused i2c_set_clientdata()
Date: Tue, 24 Nov 2026 00:06:48 +0200
Message-ID: <20261123220649.36887-7-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261123220649.36887-1-zoone.rupert@gmail.com>
References: <20261123220649.36887-1-zoone.rupert@gmail.com>
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

Nothing reads the client data back.

Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/dps310.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index eb5715f75e9e..7581ea4c99ba 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -1633,13 +1633,7 @@ static int dps310_probe(struct i2c_client *client)
 			return rc;
 	}
 
-	rc = devm_iio_device_register(dev, iio);
-	if (rc)
-		return rc;
-
-	i2c_set_clientdata(client, iio);
-
-	return 0;
+	return devm_iio_device_register(dev, iio);
 }
 
 static const struct i2c_device_id dps310_id[] = {
-- 
2.43.0

