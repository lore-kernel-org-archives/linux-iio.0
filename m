Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D0B443312
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 17:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785520031; cv=none; b=GmpP93LOqMtXopS55IYbX2Y/1TcWxop9v4QeJfKeKSp382G7apSCBn3QOG4+ToK40mSUrvEkYIj96xV9KXhWh9QzzX5p4geYPARxLYJlIBYso+gC2f0wBElCjcIzJy/lhzh4DjcqM6HcXbo/Yxq5XsY5V5j2eBTzYX7pA47/ipE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785520031; c=relaxed/simple;
	bh=FsuPZDWqXGxX46n/pEPHzrnYfaWIScIJvloWWEiHOQA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=oIZtpaddZgF6vdOjhVFtVa2vNIyGw4xma8FtYXPGHFGD9avdLvcKxLO4wZ8sQYpcWqUa9Sd4wrX0MOJ0eJKOaHXS+K5iBgu5DT4Lzf1tBuc0Av/FX/0K2D9sgWg3CPlkdrD0Pnwhtysz27RgnWfRuH6dOEm6kZzM0VWQqjjv9bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=LxM/wflu; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="LxM/wflu"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-69fc9f25118so1527411a12.2
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 10:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785520024; x=1786124824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JPtXFtSkvfcYhidzWrk864HLGyhGQ/ltDGTuNZlMMlY=;
        b=LxM/wfluR2UWlMPCoDt9hRaI90rd5nEoI/zHTEPTTLDayRpKRV8J2rHA98w2jd8XeY
         h5aaZGLEnwf1kcCM8xv+aJkjeqoorJQq0uBKSpszSK5765avI3/W+kTgcNf8+2WVmO12
         Esq8GTe5eWCiF548Cq+LtQoqqWoZKMqhBEMwpr28Bydg1/anjSeIjPlVxYHq+9lT8WrA
         gqCi1rBH4cG7lZbFwML+styFzKxcySjuJeP0stc68USbaNLd6ofz1UAvbE6tjhDRdo0W
         qMy+zQl3YhwYOE8vS3ULX7WKsPRBLgI7/7GhMceVAuHlQ+5EPzKu4Kxs5Ti+7cn1I4JB
         xKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785520024; x=1786124824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JPtXFtSkvfcYhidzWrk864HLGyhGQ/ltDGTuNZlMMlY=;
        b=e5USAUov5l8BNG9mioTfED4BKJ/juzcCbmzvp8n3oVWZ7XmxRB9fMnLhSxAuZy/b+3
         RaXZgxRtWCq9GvThMIy3Apq0QLDoRTs1FxCkJXm89opRFMmw0l34WzS2LRaLmxCaulBv
         mLEjMeN4JmJqFosjVVi3rQdcuFbljm74mQQ8oBI4cjEsoOyvBV+ZBTBy3ut7i+zGMBML
         bwOhimfPM/3J0BiFma2w8N/zjTS9LRNrAztuIQrmKp5YyT9WMmNxkJkeY+sjw/MIDiCe
         VB+TWKH5prsC1BxNdMomlb9R+uBQUNHg1POh6u3WLJQkky0A4ZubaZExB5b0l9CMKBgY
         ewyA==
X-Forwarded-Encrypted: i=1; AHgh+Rrt0yxHAFzUbw4r5HNO2DE/UdkRHUZTyYQxUz3x6nLmDTEHrsndO15vDQRQL3ddkT0II8z20Xj9kQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMOBxa+3osySQDb3YAAQvUE4SNztEfw1Vxk0oZby1G4SAeYbGN
	Ukqx+wQfdfiigmoQ57bzSsk2zXdvsXJmfA9hwnvoAx/XobFZmRG9JsyKXo/CL5xHA1E=
X-Gm-Gg: AR+sD109jWTRHTmsmAWXT9ci11zLrcPPAyEPOVRBfUgPXDW8xecUZIQJrp/FtJqJNz6
	6s9KGoTR4gm2eNcAvzzHMCO9JkNmzVJ+at5y06R/fJT92MHHxg/towqRukLKXXSTbRoRxNcKFTF
	nap/3N4xrQAOBFmF+IfhV7jO0ow23k9b+DVASrzSMZoMTbWKkLmYk5CSlE7hFqXbisUm4slbbPJ
	7w9Fu6gMRYjvt6jeKQAJWDwbOSZjM+BoGFyQgJWl7kTiWqGZZMSWqwdsFBNTjIWlS5XzZNeYTFK
	cZu2AyiMSjQ0xHDVBJJPAY/X0TxOvpYhgD2Lv9tjS3VHpbUjQZdkhmphSy8zBkubTh+PzUrn8Vf
	m97nEiEnmmwc2yhREKkop0BE0p0WPQOzLA3ilNhbv6k2YE4PcxX2lGfow8yccKX43hfK9qDUs+L
	Bba9g48CaspNxolBZNfgYd0EBu5HNDwJlVTHpckeLGWGaJPHlPAg==
X-Received: by 2002:a05:6402:1f48:b0:69e:9755:eceb with SMTP id 4fb4d7f45d1cf-6a0a7cb8c07mr353143a12.18.1785520023919;
        Fri, 31 Jul 2026 10:47:03 -0700 (PDT)
Received: from localhost ([151.37.160.27])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c63daf7sm2230073a12.18.2026.07.31.10.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 10:47:03 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: imu: st_lsm6dsx: Update enable mask when using sensor fusion
Date: Fri, 31 Jul 2026 19:47:02 +0200
Message-Id: <20260731174702.2665870-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1257; i=flavra@baylibre.com; h=from:subject; bh=FsuPZDWqXGxX46n/pEPHzrnYfaWIScIJvloWWEiHOQA=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBqbN8v9xN8oSmOG93f96/RZrqnxMSQO5dYU1wzo 9ixp5h0ycaJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCamzfLwAKCRDt8TtzzpQ2 X3ThC/0ZbTVybaiFM+RM+ptBB7WqlPbU6KgrYDl4Bt2JBJmJxjmBNyaKDIa6HGDEmYjeJlAdf7B MMnQUO6r47TKB0zCxyldedy48hW23Tz0niHBacNtDWg2FkfLonS93Ibt9o+EsYwCZkXdJiAOt6K Nc8CTkYSZeHZYtIxWhjszzWS4svsl5jED94dQw/GxTpdxiTNBauk9mv8ujVk/kv3lKhq2R17uj2 G3kh4829L30bURHqH+v20rxTePk6EFDkttaWw0gLjlRy/iIwQLt0kWh/0XqCcxW+Vo3ezuJT3iO pkaSigjsL5hghuW8Lm395xdR6TqWJFhW2vR//FQuLfuuEdue0HKvuElSg6pHecpCoZd3xSD5Qt+ v3KNxDj0KgJtHwlwVWPQumIBbkd2Pn6bnal/lPgecAQjZhBglnmWLO+oXmMIqixhdE6rolLPrDE YhxwEpn5tf16usgrVvkUyPd7NTqgWSiZLWk0DsTkX7IJrh1GHvol3N0DqeSMVGiWB/Mds=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The enable_mask struct member keeps track of which sensors are enabled in
the IMU. When enabling and disabling the sensor fusion functionality, the
driver does not properly update this struct member. This prevents a correct
calculation of the number of samples that should be read from the hardware
FIFO; as a result, reads from the FIFO can be unnecessarily split into
multiple transactions, some of which can read past the FIFO length.

Fixes: cd4e1141bff8 ("iio: imu: st_lsm6dsx: Add support for rotation sensor")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
index 2e72c7ba94dd..5321033daebc 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
@@ -112,6 +112,11 @@ int st_lsm6dsx_fusion_set_enable(struct st_lsm6dsx_sensor *sensor, bool enable)
 		return err;
 	}
 
+	if (enable)
+		hw->enable_mask |= BIT(ST_LSM6DSX_ID_FUSION);
+	else
+		hw->enable_mask &= ~BIT(ST_LSM6DSX_ID_FUSION);
+
 	return st_lsm6dsx_fusion_page_disable(hw);
 }
 
-- 
2.39.5

