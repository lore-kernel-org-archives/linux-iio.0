Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793105409;
	b=DiRk4Ep/ZmI0av+E1p/xRDlwPNA4mhgQLPev3VRa85fOop9QvfuZoBEI9e2PAtLFIa/p
	 mxkL7GY0FzysC6R8ps/MdYo0K7FmavP34u2mvbGCqvPTmh7M+2S0xNcGuWucdWoQLXhy1
	 P6ghFj2wsqz/38r0nYJAOC1czrmPju5K8KdYdps73uoG4550Wo+FAJZ3wIC2OL526RaUY
	 sp5pk51flCXBWMLE91R4JGQrDzHbfPwEDePYnFvEVJvGrN5mC8eikwZlc83wzx6t36aKz
	 8g/jC8VSKGzQ3Tn7WJQDzrb0j8Xq1BvAgr3dqGfeFBu5D/OlRHLv3Oglo8ZRejdU+hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793105409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FYHn/wr28N2yNDPHhw1evl1S59ARQnHWvpuXjgekTs4=;
	b=Oi4nNCaYP2aojd2v2P06be6fRJhq0F6+OqlCV5oTKnFaKmTkOQKdeYbaEQsKakaIkpUV
	 Yssj9BkB17Ud2SIzPVKqEVZNuc3PGQ1u/+kUiDY+BUc3NsFvh1jIzxFn5Yw0x7c36itdU
	 VrzzX1g6UpGhNZnpcsdTE0oZ6HX73xnrrbrxbfwAGV52WpmxGzP5YNi2V5Kf8VlghEDmn
	 BBH6LpdF107K2Js4g9E80aj1FTXGVfDpE9mXkqeztTvmH8cQEKDWbNEUEKCU7+THEVO3d
	 OeoK1InA5pt+sDxy9+MkGd3hEJE6KzAHWZXkVz7FZzxMTUDgi90H3ChlLDm5dT9+aFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ez0oGccC;
	arc=none smtp.remote-ip=209.85.208.181
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA7A60A2613
	for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 12:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EA7A60A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ez0oGccC
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3a595487d43so31598801fa.3
        for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 05:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793105407; x=1793710207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FYHn/wr28N2yNDPHhw1evl1S59ARQnHWvpuXjgekTs4=;
        b=ez0oGccCIQwAhOEXNUKq4s56IEy0Key822YezRkU3GlBMBzMxj6sk7iUMGGKSFhI+f
         Te2gzPvCY286PbONIgL9EKJvrxdMru9G8rdz5dZayZqtX1YU3uq1p2YGC4y4yV7Mi/54
         mF7weiIuV2V8cwgez4F+iS6F5PbHdv128WWUuCOxz1yT8RFIktAvQGwrFzy/7couGtMA
         sXB5/VRlJXxGRhi5REiehlpoUlFDWYWOfHxiNhheodEl6ncPNKqRGSs+9l4iSQA+09Ez
         bUIKzTtcDZihGP44DwSZU8dfP5tH4GQX6jEFgjiHgdDzEOI3SQJtcB5vomFk6C7R6Y18
         kNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793105407; x=1793710207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FYHn/wr28N2yNDPHhw1evl1S59ARQnHWvpuXjgekTs4=;
        b=tQoxcT0u90aneLaQGiGWh9gLZt5KA5+Gais9YmnJ1U+R3eM0pI6u1xMDNeFjHpkoyG
         gOuANvY/tHW760ncTh83mOU4E+thEFIHNH3EJpBng2F2OQyr4ELk/11+4+z3gFIJINOh
         q5fj/+8E4ZFsrUkZLPOK+GSwuefOd1OLCvltpy9qIH+v8/r6fF6pRS+MMtAtmagdwZPy
         J5863VJBVU7dHnTy+giM6FrGWD4Csezwmb1U3eUDTlBd6SCzVfHphCzVfy/T/sOFLHqo
         25pJsgiFCYBLT6ZOF0+fJxbVsbjX6b95nfnOBxV000YF+hk/wGUunBpkzCioGcqRfEBM
         rh3Q==
X-Forwarded-Encrypted: i=1; AKwUvByV0RnSOR5aD4rRDAuYJHMeU6SuWgYeiPQTcbtoqNNfm1YYpMub48TnuOmCDpk08LpuWrH2EDwJyis=@vger.kernel.org
X-Gm-Message-State: AFq9FYK68EavhYjjrtDou0BbHOayZGX+g+o0eNNILd+LehSzr8VjYq6t
	HCtun2KeLy7uXlbG9dHrP51wjQyoAABJzwhLgZG93Nz/bQCWZGyxnYH4Y2+SyU0w
X-Gm-Gg: AYBFou22AKJPiLR1Ap2qfFaIqBB98J4lVLLfK6iJyGfaVu+ejH48QeTt0rcBfCPLlVP
	+u92Qg+NUEQrfksp1EqzNAMvMkqLP6kGWOGoyW7T4YbveGCHwXTc4Qq6p8xKNmeMZA64L6Q7yK6
	CSXxJN24Q1Bqa+E5sAQGU+LEnV1oeWFLfzNOAZuKmpw5dCpagIys6qsHZwAMjoMSUZUIO7zgXqv
	48XTT3jJWh7UPb9F1dLXIr8ore907LSU02AwXvlX2joeCQj12FuTXcXQUATtqgtM/u8ngOHfa9Q
	sPr01tG90MEgk6cYgVtzteKiECXCBz+czEy7mvn74MGkfmyqm0Put3HD0RGjtYAHV7iJbBBRevP
	Sgc3NY5SwYZWSr2R5Vsn6y0nK/GKSveW9hIP8HDAbMim5Tf23wkXLFkNw0CzP6TMNxTwLUZI7za
	//yJgPbaujJloUJDVrjl8Q+huvZRMtWO0+Z1Xa0QScjNMSDeHSueWsScYYfbhjuNbOkt6ouzS0u
	U1ikbVYuM/nI4EbtmoiVibQmDCh02ch/aWFr9JvF/Utg5JAQMoFe6QppGKqZuV1/cAY9rwMmAf1
	1aF3tzcrLNCm4PHLmVs/U4NyW4lS7sUJDxZWn+v7LzNQtkT8Zr+LBj2GLmncJFeCtg==
X-Received: by 2002:a05:6512:3409:b0:5be:50f5:f789 with SMTP id 2adb3069b0e04-5bfb71c4555mr3678914e87.45.1793105406758;
        Tue, 27 Oct 2026 05:50:06 -0700 (PDT)
Received: from yantra.. (nekmmqtcmoboczbkdcs-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:55c8:a52b:6ba2:979c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfb7e7cb24sm2052803e87.25.2026.10.27.05.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 05:50:06 -0700 (PDT)
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
Subject: [PATCH v4 4/9] iio: accel: kionix-kx022a: annotate the lock helpers
Date: Tue, 27 Oct 2026 14:49:49 +0200
Message-ID: <20261027124954.110697-5-zoone.rupert@gmail.com>
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

kx022a_turn_off_lock() returns with data->mutex held when it succeeds,
and kx022a_turn_on_unlock() releases it. Annotate both so context
analysis follows the lock into the callers.

Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
Cc: Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>

 drivers/iio/accel/kionix-kx022a.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index add89512af79..a132af87fb5e 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -484,6 +484,7 @@ static int __kx022a_turn_on_off(struct kx022a_data *data, bool on)
 }
 
 static int kx022a_turn_off_lock(struct kx022a_data *data)
+	__cond_acquires(0, &data->mutex)
 {
 	int ret;
 
@@ -496,6 +497,7 @@ static int kx022a_turn_off_lock(struct kx022a_data *data)
 }
 
 static int kx022a_turn_on_unlock(struct kx022a_data *data)
+	__releases(&data->mutex)
 {
 	int ret;
 
-- 
2.43.0

