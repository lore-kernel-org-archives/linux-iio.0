Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117321;
	b=PxB9BMygDUWmqNk/utlA1gTNPD127VuLkWsujLcHXInTqTtNl2kHoRB12GakMhqmMj9h
	 23JGVlYSMdjioMYV57HMjvd/zfqrS2HVlZmKbsSOKlAnIE5knGEh8pGocp3cAqQAdMvzk
	 XHK6nPqIyqEYxFpOI2c8EwahfpQM+cyHdLejzcJJxMz+SzoETHvX0gt5C3ZqaPCVSx8q2
	 cJMGlCNX9yuQwY15xQ/DjjrWtrlWsJr364BmIZ7R3YBoMJ1Hzxtji6u8ozznQKx9dWaGL
	 uMP8BEXJKQb0y0vFqsT2FzgaaEkCD8ApHkTFfhkiH4Nrnx0CC38vDLRHbpsvuuuj5TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117321;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=meYMluchLM94txKJXWt+qZDyf5+PbHP4r+z7ZzwQ43Q=;
	b=rAYMdHTpbeDy7cCU2nSqLms7CGRW55Jq8yqZFQB3GH3M1jVU6I2UHh928aQoGGDX0TeW
	 mGjIv+9IWMD+ZB5ZtDV3jP/VBtu+u3RfyLWJoq+2gMLsPI6gQm89/urop6M4cpL2Fv8bi
	 LwVmt53EqD93TmooQqEyl0/FIgOhBNhotRJun8Edqxe2/VQ5NqigGCVCh8pYckaYM7oZf
	 xE3ajnP7jjDKY7ZFINGmI+HQCYwngxHv45xFOmpd/QUkChumnhZxzubgqLcaj+okYsPrm
	 NE1JGLLZNeqjDyC7yLIDGDubBBRb3O1HE5XfA1yIge/6BCDT3cEqAitOidtRY3Ab+tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SjUyCblg;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852BF606A32E
	for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 16:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 852BF606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SjUyCblg
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1846bc43c28so5031363c88.0
        for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 09:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793117321; x=1793722121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=meYMluchLM94txKJXWt+qZDyf5+PbHP4r+z7ZzwQ43Q=;
        b=SjUyCblgG/1Djb+mwOz6qpkcGEHvUZm761hbIBVwebRU2BtXt9bKxMPzQ431rjzBKU
         UPOpNNSq9qUS/tJ+CxoWTR9MJh/Dw91pQUYIBCvInoxzmhdX5JTLhh1TiWF8ho5m+t9g
         gI7iPBg/PZc9ErLuq4YX9Q/jtjxWfTy6X/Wms8ar8hU3bo41YqtTZISuqAE0eTbQBuhd
         5rl9v4ndVonZRYWAf9qtnDOAjbvOSecQFkUWIJTyuTQRuV0dFtklfZ+Ts8wV25CAJ2LF
         9F25CDdP4REWEOnXLLVQzYQLQXuQJwILPjIXMhFTIAWbH9GB3ezf7pAsz+cQ0xgPdMCD
         kK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793117321; x=1793722121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=meYMluchLM94txKJXWt+qZDyf5+PbHP4r+z7ZzwQ43Q=;
        b=xDxD+3USPxTZzY+Pd9lNpsrew7Ky+Ebhq+dbGCgyQ3GQTRxZJKVnTxuHbMwLIQCvrI
         wvJBa3GuMasNQNA0TVp+eJSk/appO1p7Df1Bg+X9XLNL2oWh193LTnIj01lqSmp0DRjk
         Q3NudVBUOpmHoJ9askoMhrgcEjrvux0k11ZLb+cE0v/o58fWIL8jNMTif+xPgRZ5aLFS
         oUu8uzu2m8sS1KtuaLmamxU3bTsaYfKVzlUe5dKOQQm+k2t3Za7fosNVtOK7xeJkV5xS
         M9qKi2fc3QVpNuOLHcsbhBDh9ytycdSU2GMSuCLEa8/MqbrfgyhqCZYPYdbu02n74gM4
         Myug==
X-Forwarded-Encrypted: i=1; AKwUvBwFCtFhCAoiR0a3ASR4KGfxUtkdypwqm58O2rk2xcy8sxfd6ZOtaNWwCBmCpKEOoiKhY51bAfZ7Fao=@vger.kernel.org
X-Gm-Message-State: AFq9FYKoPlfXEgvzHhRb5Gxely91mHvSF9FnUnmoPmnZGwoTyqqwZtAx
	eHhft82BI5R2Wo+IYNLeasvBRP7nM/8R8AsiUg7wZabpTjNVVBCWZfCk5tGpSwue5DXJkg==
X-Gm-Gg: AYBFou2oQwjZhuAgIcehz+RjdQ/75XzQpi7taFy36nG7VJM7hG7HgvuFfxyFUpEx+v8
	3w2pe/6WwicehbSth5ve1pXySOUJYd9CB2aycrCTaHd2TDEME5/E+R99HUCFIhuav4q1csawWV0
	9IJa1l8bwc5DGrbrrpe2r4HNNR8LrtmAO06yFVIHiItn1FqN/KrqcbgpRNzjyZXiCOInDTFp3Pe
	AgQhKq+4D52JT4lcfONr81jWzHWJ6DDeV+FXoH5btiMMmPmUTDPSSdJ5Y6RdPhg/x86ei+Xn0In
	AlS5HG9/QG6t/FEEnTig0S7Z/wqK9bCMNgvxITdkjIavWOIF86xYxwgEcaZZAkKVgMvyue8sUqZ
	EIgQnz8SGE3O1xsAGTTwWs6a4Go1NfA7LcHyZNVc6QxWQFrk6iBLH6MbQltytULvwQY90Z1jp7z
	faZpVSKWM8NBay5xWIPnsTeC9QUHV8huDMu1srxKFTeMc43vq8Wt8asCL4JZivN4VaFs2umwjRg
	qLJ/XhcYZHsIOwrbx8xu/XxKF5m6Gc/ojWVSDPWb0QIOXWFHVVSc+NHJ44tTRT3BPAz7YJ9K3n4
	KkFRxkvXZMuO6fJX0ZTu0IwBqw==
X-Received: by 2002:a05:701b:230e:b0:1a0:b650:5c93 with SMTP id a92af1059eb24-1a0b6505d9dmr7245819c88.41.1793117320361;
        Tue, 27 Oct 2026 09:08:40 -0700 (PDT)
Received: from NithishVelan.localdomain ([152.57.85.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a0e8d700sm40053759c88.10.2026.10.27.09.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:08:39 -0700 (PDT)
From: Nithishvelan M <mnithishvelan@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nuno Sa <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Nithishvelan M <mnithishvelan@gmail.com>
Subject: [PATCH] staging: iio: impedance-analyzer: ad5933: use devm_mutex_init()
Date: Tue, 27 Oct 2026 16:08:29 +0000
Message-ID: <20261027160829.1731-1-mnithishvelan@gmail.com>
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

Replace mutex_init() with devm_mutex_init() in ad5933_probe() and
check its return value. The driver already uses devm_* helpers for its
other resources and has no remove() callback, so this ensures the
mutex is destroyed automatically on teardown when mutex debugging is
enabled.

No functional change intended. Compile-tested only.

Signed-off-by: Nithishvelan M <mnithishvelan@gmail.com>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index c05a5f4b4..51d73c5ab 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -672,7 +672,9 @@ static int ad5933_probe(struct i2c_client *client)
 	i2c_set_clientdata(client, indio_dev);
 	st->client = client;
 
-	mutex_init(&st->lock);
+	ret = devm_mutex_init(&client->dev, &st->lock);
+	if (ret)
+		return ret;
 
 	ret = devm_regulator_get_enable_read_voltage(&client->dev, "vdd");
 	if (ret < 0)
-- 
2.53.0

