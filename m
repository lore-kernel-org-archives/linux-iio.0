Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793105407;
	b=IR5s5zos/lUCXLvpOWFAZnPBFFe6jf6nvFNSxaEG9Vktu9Soue1SqR+LyiwrIWoXoZ5u
	 zjqK3vBbJVtROPsMhfOLvU87tm9/LFy8qZgKP/fV9o08ftP/7325697JeJndFJ2xrqPr/
	 1WeiprOZrlb+WP2A7iWj4VZKX75TUSPdoPF3iCaq9cy/mt/iQzYOSIyE+u0ZDceAvjDWU
	 BhG1ItcQgVxqsnynRJq1KQ/gX/mUMM/B9u+9/CB7H8ak2oCDvHfTN1j/9nNLuY6vOf+G6
	 S4FFfy5UWHtg44+SpDzdEbLWxdTiK3cAfGK5XoAPwo8xMcStqP/Wlrn4m/jrnpdLbBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793105407;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EOmMLjMAFJxyM/LPyWQT2i9O3ojzkNgFK3nKjeDrayg=;
	b=JCzY4F4HaDp4C/IZFncJDSXWA0OuKMyjAc66UHWYeTEkmg0eQPAemDbCYIs4ZqJ30vEp
	 1St0PcBqGkfuvJqKGCgPEQTUGRhX/RSno7055q0Gip5UZ0DITvsr68We4IUF+ODSR2dQt
	 PrGAp0rcbZqQDB/f5fWtUdlNFgr7nRcEDAwxucVQwlu1KbcbEZ0a/FFQAwAyzwlEOmb2c
	 XnKmc+Lyjey/WXe2d1saxrfzWB2gcdjaEGb1K8jOzafC+h8w4sTQ/bm/q9jdfE6FO17IM
	 bE9nxtn1UkR2yEJe72zZp5xSBOrHZhxVQzZ301zMh9L3wogeiU9wup4DQ0HXOxe2mDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fERYkGLO;
	arc=none smtp.remote-ip=209.85.208.176
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7F3606A33A
	for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 12:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A7F3606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fERYkGLO
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3ac65e845a8so10164641fa.1
        for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 05:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793105405; x=1793710205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EOmMLjMAFJxyM/LPyWQT2i9O3ojzkNgFK3nKjeDrayg=;
        b=fERYkGLO7Lnu2DkX/7bn/afdYO23mp5qW9KVQlCZBoCzvajuqGp16A/e/h/SpUkTW6
         iwweSy3pejWkTe4JIJ7d/rRMtdk0WZo7r3nnujnmoq+etqZ2TGcZwdMmgQ1CcXTlaG/1
         BVwldr6P+tCD/NLU7BGX/JYjyMcnUolSSHFxg+VvGNjeSxDY1KhUazKHOYNePLjtq7nM
         0ma5UjSP4QWMJHwVCIG0bPfx8F2qGyss425ANUkTirPGVDwCuz5Qs1K+VKxCP0sksFVS
         4jnW0V+oDHX1yzOy/2/7To+LH7S4mkSnO/9rlTTPBM+5awfi3nRll+DARFWMg3L4D0gJ
         B6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793105405; x=1793710205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EOmMLjMAFJxyM/LPyWQT2i9O3ojzkNgFK3nKjeDrayg=;
        b=Q+4kG9EKBEA/wWx0U6igPYiDMXpdURRVSk6F/DAJLmPJCj2POyTssC9Mx3N69YTWcq
         Yl5DNA8Be9M4c77up66oJyGwklao9IUSSkh5jbXNq6AavYgxhsR0+2D8wF8pjXwsN7bK
         MLdnDo79n7vvNoL1jO91DaafARybw1XYYuH+59T72/o5KC+v+sdtHpZdRFgf5otmdReI
         SyGWhJOqNenSbHz3ft+njjhramrI0wziEyHoMxrdPI6Z2aq5JNcbudbMp3xX6wEN1pD+
         YQwA/k8qNEezAafaIb7aSf+5tznPcki0t0nq9HKx1jbyitOYffvGMGFZ/mVCIdrSkJhJ
         q1/w==
X-Forwarded-Encrypted: i=1; AKwUvBxaCCnPyJBG9z2Ejv5g7DhUJvlyV495aeHQpOjKM09wKxAg/5qIGEn8us+Gc+gp/INHihEdyQcLnvI=@vger.kernel.org
X-Gm-Message-State: AFq9FYK9kbR3ci1Ah8kJWMeuDEfTidzdjD1WgzH0C5sWmJyg5zsSL94v
	KhKFVMPGSPHBo9usL79xVajXFCfghNbGwD5avJi/QiBTyZ+Gc7rGTdkw
X-Gm-Gg: AYBFou1VJ/eMe1tuvwZ1alAcOSA4VjmgzcfQQESXJV47QjLBcAo+CHmUrXqtnhsMfXP
	phBnpk7GGbr0qp/IQiYj0DVdfqDWgRgnoV+kQYgA8m5cQAM81oJsAXtES5ihSd8xS3iF5y35YSY
	q++7VRW31ZcrqhCXPrEoB7ir8in4iVdsndfwIyT+si2G5Y0nat6OIe3gC1cozzPb64pLNG+wrPO
	SJxqq9nq9yJheiJbGPv2KQpJrFsTGMuRz7w55VBII/ecrHnzoOPFW1NLmcM3+736YCAkqsh8J+g
	BtQSR96QyLzovwqOoEfaJv/yAdr+5e5xq4MhMM/pIqXr1ExYm8emjL0YZEWrNJFmYcqiRCZBJa5
	cg7TlyiFtUpFKMSEhSXPCiEY3X4EUiLs8qXlyCtgTh0FSRAauwvWyifWjsCA9yTEIGGi5lFPr6P
	qMNNfXxr9IttfPpwU5MmkRxBBBZhy4uczRPELtcHK0y29PwoEhpsbRwiF600pLBMqZK5bPmnJdo
	7aj89rSHJfEOl1IcV53P747ysgvt+pPwpTyjbZcHWEbGdrOPGGHjIXJ1LmrGwoqG6KDMfZw9X3S
	dhKMlkBtlNpvP/ApWiSplSC5lrhJm+Ijr46BxAceebTBq0M3fPR4rmtzbXO+tlwH
X-Received: by 2002:a2e:a883:0:b0:3a9:7c85:a16d with SMTP id 38308e7fff4ca-3ac908e3716mr5518161fa.5.1793105404928;
        Tue, 27 Oct 2026 05:50:04 -0700 (PDT)
Received: from yantra.. (nekmmqtcmoboczbkdcs-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:55c8:a52b:6ba2:979c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfb7e7cb24sm2052803e87.25.2026.10.27.05.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 05:50:04 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	David Lechner <dlechner@baylibre.com>,
	Guenter Roeck <groeck@chromium.org>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Jinseob Kim <kimjinseob88@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Remi Buisson <remi.buisson@tdk.com>
Cc: chrome-platform@lists.linux.dev,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v4 2/9] iio: core: annotate the conditional mode claims
Date: Tue, 27 Oct 2026 14:49:47 +0200
Message-ID: <20261027124954.110697-3-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027124954.110697-1-zoone.rupert@gmail.com>
References: <20261027124954.110697-1-zoone.rupert@gmail.com>
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

iio_device_claim_direct() and iio_device_try_claim_buffer_mode() hold
the mode lock only when they return true, but carry no annotation. With
context analysis on, each caller that releases the claim is reported
for releasing a lock it never took.

Mark both __cond_acquires(true, indio_dev), the token that
__iio_dev_mode_lock() acquires. Sparse no longer reads these
annotations, so drop the comment about it.

Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
Cc: Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>

 include/linux/iio/iio.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 9b63785d5aec..ca91f5a64626 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -707,13 +707,6 @@ int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
 void __iio_dev_mode_lock(struct iio_dev *indio_dev) __acquires(indio_dev);
 void __iio_dev_mode_unlock(struct iio_dev *indio_dev) __releases(indio_dev);
 
-/*
- * Helper functions that allow claim and release of direct mode
- * in a fashion that doesn't generate many false positives from sparse.
- * Note this must remain static inline in the header so that sparse
- * can see the __acquires() and __releases() annotations.
- */
-
 /**
  * iio_device_claim_direct() - Keep device in direct mode
  * @indio_dev:	the iio_dev associated with the device
@@ -726,6 +719,7 @@ void __iio_dev_mode_unlock(struct iio_dev *indio_dev) __releases(indio_dev);
  * Returns: true on success, false on failure.
  */
 static inline bool iio_device_claim_direct(struct iio_dev *indio_dev)
+	__cond_acquires(true, indio_dev)
 {
 	__iio_dev_mode_lock(indio_dev);
 
@@ -760,6 +754,7 @@ static inline bool iio_device_claim_direct(struct iio_dev *indio_dev)
  * Returns: true on success, false on failure.
  */
 static inline bool iio_device_try_claim_buffer_mode(struct iio_dev *indio_dev)
+	__cond_acquires(true, indio_dev)
 {
 	__iio_dev_mode_lock(indio_dev);
 
-- 
2.43.0

