Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BFD280CC1
	for <linux-iio@vger.kernel.org>; Sun,  2 Aug 2026 01:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785635073; cv=none; b=ZJM9nzPGMyTMIfgLU+iTHeqhs7uGb3XPUdvL9pvjv9JV3u9dPXoDYfWbkH7bQm8IUrqReeyn6TIomL6oueAZ5UvZKCCT4TigjvPEse4zgyNvGcrqifAX2saauYynI/CzwRdp/jcIZuIdNJhcVtQdsYnrtjFRIl+rFSDQ3BnPG1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785635073; c=relaxed/simple;
	bh=mHlmprP4/+isuQFq01dfKo3OTEQ8iFHihf/kdwIvxGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eCLxQAm89qQLIf9aAzO+48svi/jmMHSpIWIpj3DYDn+ygbgV8oO/kN7DvlELcoQXgP7kOJa7s9Fq+fntD3mmDFs6DYGXK/PymZpmtcvfbOP0ssYvfuXVJcVn6pCdIyn5FA+I7zhU4ECsivPELZYZ05PVp4hzNN3NHFBrK47wtdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFNAYX8R; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFNAYX8R"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso2146496a91.3
        for <linux-iio@vger.kernel.org>; Sat, 01 Aug 2026 18:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785635071; x=1786239871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hPO1lD2amifsUr2YFmGY/nZKEN1sQ3UfJ2jRMstq/IQ=;
        b=LFNAYX8RrsHB+30dRnQYWGrF718LbesKFHu2hiOO8NR2BoSYVdNjb39jKJZqr8OQBV
         D02pefkhSy2H4H/X728Uw1mdG5nUmeuIH9BTk7BP8w3hcjfe7tZ/3u7MqiEmTjCzMV7i
         1DBoND+g7Ydb9Xk/QUFjK7EteTvDG7IBXDQfVv5gLnHfcthU4xvigaaI+uaLPlQ3mzss
         eeUOCIQYq20J6xF6S9zXqELY+mrVZAUtck5N4Df4cHrNDFV6zXPdkRxp6kWvqmSWbu9I
         rdPFEu/sEoV2C21cZKbnKqOk9aRAy/qnFfdWTpTAVJFWXS68DR5TwSaBi1T9dTsfEYjf
         78uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785635071; x=1786239871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hPO1lD2amifsUr2YFmGY/nZKEN1sQ3UfJ2jRMstq/IQ=;
        b=MKhitdt0wX9ZjIErQlf9WY/RmUAJjZ7Oo3UhfSYh8D77QGqqoLupNcsDtDGn1/JaVr
         GZxBtRGXtYW/jCtQBQ7ipLAB/Zhv61WXeyO4+6nHV0dwRrUsYxRwsoxHlJQfanWYgPJJ
         7YSTXX84H7dKHMi1/QGcJkd7HzXykthA9mKoe8gCplzu06iGyH1UD9xl+HzU0IycpozY
         jGB5hDaAI2wIMRmx2UejkL/FD6Ha7pwUMiEsmR8BBWK/iNbu78ZcChrda1hbrzDD9ypB
         jrz3vNEt1iLbOgU6AH0ifjjIKiaYYZgMjf0/UmZPYj1rrt2qsYmMhB3HXW70//8QXh5m
         R4yw==
X-Forwarded-Encrypted: i=1; AHgh+RoWSzekLLDV0NoSI0RzMNEGknVBCnGowc8OS6fdVdH7ZfLX16gcG5DDIlswh++syIYrABO+aN/mp0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3mc68NIBOoxDQTkrMFIvdKDTkY1VvcLp/CeDAPRswdLobdufr
	rNHDJt+jujWh7f+Ij80CN9eGtaJdFg5P9v91iuW5D5egrWzrBID+tbuZ
X-Gm-Gg: AR+sD130z2w0FyxLNnUeb2MjdM0w47UsrGrfPWxnfu8b+6bmw6EJrem9mpd/0W8PdZJ
	ZLmNjDIC+YzGHBe/adry5MpkGJVW7SoVKpg+bccU4VoV42SmAwYbZ4wr30KeLL+WKq5UmWp80jz
	pys0yNcwaazc13dFzOKQmz+6f1PqJCUZtZ0/ET1UHzAuwbs51brjALUeVEEWuchaxFuKlNVuxdC
	o3zbiR23mMu5CTfSM72Lsd+Sr/iyHqIfUlW0JhxCVQhdXor/FrG6BQ3isVngVAkKL5Zxrhp9AhT
	mTVnN0JHbU2tO4H6IUtktTTdgiljCjfXNoKKgOfLwkcT9+OypfHTXSIreI5ufEm2ET1YvwBdUrq
	62wlQ9VSbTaV4C4jPC29DhmJtXbAUtoGoOKb4g1G5GjoxddhYmPZmcXCe1jbOIBWMB6+1mVk936
	kXSODUh+vO0qbADIq40VZ7FS/k50aDz/31MUwDMg2YlCTcDar5Xd1wBR7d1znYrpn0b6PbsAbuT
	t1OA7HVff4V9OwsCW/64Dro03kkU+XPtZ7lS9iaG51/5tdqVqlCNGoZJVKaKA==
X-Received: by 2002:a05:6a20:c786:b0:3c3:6af8:ab24 with SMTP id adf61e73a8af0-3c92a8f54b1mr5192950637.56.1785635071305;
        Sat, 01 Aug 2026 18:44:31 -0700 (PDT)
Received: from debian13.localdomain (bb219-75-96-14.singnet.com.sg. [219.75.96.14])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153ddd7a33sm19692525eec.12.2026.08.01.18.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 18:44:30 -0700 (PDT)
From: Adi Nata <adinata.softwareengineer@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	u.kleine-koenig@baylibre.com,
	adinata.softwareengineer@gmail.com,
	mazziesaccount@gmail.com,
	bhelgaas@google.com,
	o-takashi@sakamocchi.jp,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] iio: humidity: htc100c: Fix checkpatch warn unnecessary else
Date: Sun,  2 Aug 2026 09:44:15 +0800
Message-ID: <20260802014417.15485-1-adinata.softwareengineer@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Checkpatch warning:

WARNING:UNNECESSARY_ELSE: else is not generally useful after a break or return
+			return IIO_VAL_FRACTIONAL;
+		} else {

Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>
---
 drivers/iio/humidity/hdc100x.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index bc452cc8fbcf..38903239fb9a 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -229,13 +229,11 @@ static int hdc100x_read_raw(struct iio_dev *indio_dev,
 		if (chan->type == IIO_TEMP) {
 			*val = 165000;
 			*val2 = 65536;
-			return IIO_VAL_FRACTIONAL;
 		} else {
 			*val = 100000;
 			*val2 = 65536;
-			return IIO_VAL_FRACTIONAL;
 		}
-		break;
+		return IIO_VAL_FRACTIONAL;
 	case IIO_CHAN_INFO_OFFSET:
 		*val = -15887;
 		*val2 = 515151;
-- 
2.47.3

