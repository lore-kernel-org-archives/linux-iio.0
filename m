Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652AC3C140F
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 18:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785178150; cv=none; b=PJ537YhmIkC5NlZ3e9Q6WudULVNG7rlEv98JJ5NcXSYi+/IAxjcN2YjwEBWLsSd5CMwFGCkee3op20s63waX0EDoiQ0OrzlmxsfVIBBfAJWDgkU95T8JnRkVcqoGY3HQvcH/NGwg1drHUnZe6JPVRC0UY1DEwKRZHHwiCEIm2g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785178150; c=relaxed/simple;
	bh=rKOAAYQyYvlJHUE5zQ/NDNkP/X7OHqNgJixqY4e27g0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFWYxCHPsXIyBfrRfTFv02W/7EswzhIIJnv8IW3w3AcK7Dq9uNBtm+ScvOhj6WCr4uJcFJZjJRsqs5mNgpGktSHR195N0AefuSk/me35cyuIVUMt4NSzhzHcbBprkCrh8MIZeHJiWtatvtoBM47YQMYkoxKWXmFKeUzGkOYMa9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7HtsaI/; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7HtsaI/"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ceae1ed204so33176225ad.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 11:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785178147; x=1785782947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6EDXKH8jSGJJdFz50H6zLBCj10Gz0wDcQVs/mVpJjkw=;
        b=X7HtsaI/UTMCtkbMdHzyJDTc3xI9Db0N8zEp5Dw4GaBtnyaYdBXCYddnDz+Mk5zzz1
         UZkMlSUnYRT2kLTG28uTF8zatextCbT5T4IW0W1cDEyOqlCfgiaR+oNo1hzbn/OS4dX9
         ICjZp2ZpzwOb049hi7TvC2qmikNJHFQrV7u8gNN55ZR0KRCWInrGvQQyjstfS4S2A2fT
         kFM4xa+PeoklvJBBqzsnAoYUOTFbJRPAkiU8Hx8xEb1nZtXqjLEoZ10TGjGaIPb+Sm6i
         XE50CvCQFH5EKuwqrL/GFQB9Ix7WwI8C+3r2fpvxq6y4DXoYnOXwHA7D2nuytEdYYNoG
         Rqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785178147; x=1785782947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6EDXKH8jSGJJdFz50H6zLBCj10Gz0wDcQVs/mVpJjkw=;
        b=THgFftDpxO5VGIWk4foRQbPyrH9uR0XS2LS+NU2rt7yOcnl3F18iVXkwXZ4USQcVyn
         eppT1ZQExce/jWxYiSfvLqhM6mMbebE+22N0ZW0n/zchCfm+vLUNmL+eeprTGigjmLIe
         O/VgHg9gMQFwmaFO7hShbl7D807R9GLWsa0n9IkJY+2nAL+fazkMetaQpSKdHQWXBIuG
         ygzmv+DrE8ea63lBRgZV1VE58GuiH7bXxmkRohLMnH206qV55/LaHX4QA29uEXcrRYEl
         DddYgZQhXXgimu+WLFzYO6rJfOKaArUkeH8oPYNosx5j1jkiJgQLBTn9lYpLip8iVFZk
         eyBw==
X-Forwarded-Encrypted: i=1; AHgh+RrBGUis/FMIELVRVUz5Who/TuOQRN8n8WYVCxDZe88Y/DgGXnobBogDiFSgS416l13c7km45KSuoz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZNT5U4CjzrNrlEHM/2KAmQfCloFRgmG98Jv3hdVdxbF07UY2r
	e/BwIcuReB7md4Kniy70Fn1F1o1mPXhdYj5aCgbBboyF8HVoCcTb0LTR
X-Gm-Gg: AR+sD12hhfajbvKoMYpV6VciCGpwrfQhbes9v8Qbco/3ZasF8A4fi3cQsgtk/JU7eUU
	mzxSRST5oMBo3ZIgwgLH1p1pXF5dJEekXCGXgOk3qEtndoMjaLUozTIAm0cV0+aig7rI1OfhDPf
	L+GdLNsNy5kftNrGui8wr9xuerCwFne6v94fSNrmYWhdaHKpgmSDmR7H9qEqGOILHuUpEocoOrp
	PBN8uO1lubuY5FimCCEniGn+5xhI04yNRgevuiJvp7r0qVJR/FClRrB2Yp++zbpsZalAPkiskaY
	8iNmzKFIc/0BJe+9sQcKxNXJia8P3UDr7QMfR3JTmHOKt7TFXt41HYrn8OhSjLjkgrY0e8DnyEX
	pFBdcy+Nd9iZ+gjQNzEZaoi1sMJKV0xL3JAY0yiZMSZ33eS6QThrZq1kpmUTSEkMkm7b/V9vEdz
	diGBnhT4tm0IqeeDBvVw==
X-Received: by 2002:a17:902:ea12:b0:2c9:854c:a45c with SMTP id d9443c01a7336-2cfde8669bemr93468355ad.34.1785178146524;
        Mon, 27 Jul 2026 11:49:06 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7d7b87sm40186245ad.57.2026.07.27.11.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 11:49:06 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	Brian Masney <masneyb@onstation.org>,
	David Lechner <dlechner@baylibre.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linusw@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH 2/9] iio: light: tsl2583: return zero in write_raw() on success
Date: Tue, 28 Jul 2026 03:47:39 +0900
Message-ID: <20260727184755.2055414-3-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727184755.2055414-1-ekffu200098@gmail.com>
References: <20260727184755.2055414-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tsl2583_write_raw() returns the value of pm_runtime_put_autosuspend(),
which is 1 if the device is already runtime suspended.

In that case write() on the sysfs attribute returns 1 instead of the
number of bytes written. Make tsl2583_write_raw() always return zero
on success.

Fixes: 371894f5d1a0 ("iio: tsl2583: add runtime power management support")
Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/iio/light/tsl2583.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
index a210d87a1519..54fa426c5755 100644
--- a/drivers/iio/light/tsl2583.c
+++ b/drivers/iio/light/tsl2583.c
@@ -794,7 +794,7 @@ static int tsl2583_write_raw(struct iio_dev *indio_dev,
 	if (ret < 0)
 		return ret;
 
-	return ret;
+	return 0;
 }
 
 static const struct iio_info tsl2583_info = {
-- 
2.43.0

