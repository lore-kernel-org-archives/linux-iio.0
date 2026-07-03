Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235FC3D332B
	for <linux-iio@vger.kernel.org>; Fri,  3 Jul 2026 13:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783084083; cv=none; b=HenHnidc/d9ORb46FIDXq2Gu/yJ3P9tizUJKhOMGbSLxR1rwuh8WxgzA6Etxotuc8eHavZlO50G59SgJFMBIKXlmjovRg+cuvlqOJLarw+jAgWKasytq+VWmXkCqL5o5/Qro5UhZxu81HgVp5Y9/ZGEUS53xljRu/j38HPk4jPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783084083; c=relaxed/simple;
	bh=4ogfN3MXX8DMvINQWghivt+ldmgDBePlr/kTO8AYRLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gNCDuJeryCKDb23AZuA0dICF3xogHT31p+DQgDbMvi+rqJId3lpxPPqApOFHxM0mG6YtgCq7gYoVp6t9fgnNR0HMyQgEILqbg7Ny/OG2vi4rgo1eNu/9fk71d175XOTB5NA95WdLwKhax02SNn0hO7fFf4vjtEf22oOi9hOVRiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjYEOUq+; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjYEOUq+"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4798bea72f9so393427f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 03 Jul 2026 06:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783084080; x=1783688880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DxRNBoqpGYHynuTtnl/IxHgTru0fDqnGX6aVFVw36SU=;
        b=JjYEOUq+8BUYg0cr8rBoshnNW0xH+cL8qpZbxrV7wNgJtNM05nfTYWLX591CEgx6au
         OiQRK+TXSiK3aIDErielouX/2EO+jCFHef42Qs1D7H+Xix9GFKF8gRBEKIbeJse5WSNm
         tRVTlP3MELpm3/5QX729bHaULp9T9txB8pLy96lv28GxA5I0HlBYgzTIuzwxzIeEdUXg
         ZU7xT24eNI0nDEoWWvo9t5wWUA/yb/MzDUYvHqY2RAryJiSqQTSgTy0uNFvfXACBLBg7
         4VroEkXSEDo2bGwC+Z+bjY3TH88JkaJeWS8aXVkKmBLM6/Qd8/x3wvUMg31ZzPLexF9F
         RTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783084080; x=1783688880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxRNBoqpGYHynuTtnl/IxHgTru0fDqnGX6aVFVw36SU=;
        b=UP9J0uu99U5fX1BXpvo5H4+5XfCuQGmFmClI03j8eAz63HsDwsbFzUSYcn0vAhno5/
         XTdu8y0N1HIuHQgM97V+oP1CA8j09K7ytqINi6OvjzVCU6nVXod5oVdUkSY/8HPXQSBG
         XJVD70gpGw3Y1gIWpiWbmxi0xGxMNCS95St++45Xtnv4WXFHAhGlsw2N00oRO6yEYkuE
         WB/LkSeVEkiZAbGLuQSR71H+Co2kw2sCUbYFRbWO3KCeTnDFLMoMg6aBCKiZANqfxG5g
         iKANEkA9XW4Ds30A0mx4a3G0BhiqHL3Ew7wnk5kHiGzujfFOedcrf/ai6SecFQeoowGy
         w6Ow==
X-Forwarded-Encrypted: i=1; AHgh+Ro9p8ZBi6PIK1ywnD0jOz0mnqa5/XeGEce2Fs+gxxJjN1XTXHaNn/z2Ec+ilHUgd945tu62DI+ssJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhY9kKQhXGfhpYxMq2MQkNfJlojb5sQL/KP2SLIX8x7bIQCmmT
	gvJYzRTH8fbXKcWCjjwZ1nTNRI0+18BVmroMAn8GK8iiS029h4ZfcBPC
X-Gm-Gg: AfdE7ckIZ5QYE/hQ0wHs+baRMKUzSgPWClKnJQwCSnqypneGYpS1a2aDHkTC1/hcDmM
	YgmKBksLL/VtNwyRGeNAfH41knU2SEsvnqt1NlACO01TW7zHst4zVtEBNWRUywzDHrK4WBablHc
	Evef2//mkjzLqyqCx13I+B1CQPvonsURj7ki5pg3mcNBGql3q5L64mRecAQGmA1VEyyKGECeB7V
	LiCqdwM6WXwJJF8X7hp3YkBgLuL4TRMtnqa24YN+xWaNis/sS9jtZnyyYLd4LgRPRuqKTL6hxoN
	me+M4qVAP4qdCEH3rnKrzLVu1By8IJeRa9eF0iDsc6p3N6j7gGPL4kja7jzy5wVMsrmXHh5pnEP
	CqOmd1ydQVEZkmuDebusZcRvD6IRPJySwSPZEKRabbY9W6RSv4aQtHTDfH0zkEl8Rh3mIuU8Wcm
	OHhYzFc0caOfAEPTm0qJyKmdxMcih954wtZyTdAb6T9X/UpAqHF1LGf47X4MpAClMud0KQV9CcK
	mAoYRkyXGD04kHcybsX3bkMuLzjxQ==
X-Received: by 2002:a05:6000:4694:b0:477:80fa:f462 with SMTP id ffacd0b85a97d-47780faf939mr9472050f8f.35.1783084080128;
        Fri, 03 Jul 2026 06:08:00 -0700 (PDT)
Received: from workstation.speedport.ip (p200300d5070afe1af6868251d71bd2b0.dip0.t-ipconnect.de. [2003:d5:70a:fe1a:f686:8251:d71b:d2b0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477db3dbb01sm18002460f8f.1.2026.07.03.06.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 06:07:59 -0700 (PDT)
From: Mert Seftali <mertsftl@gmail.com>
X-Google-Original-From: Mert Seftali <mertseftali@web.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jelle van der Waa <jelle@vdwaa.nl>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mert Seftali <mertsftl@gmail.com>
Subject: [PATCH] iio: accel: dmard09: Implement IIO_CHAN_INFO_SCALE
Date: Fri,  3 Jul 2026 15:07:50 +0200
Message-ID: <20260703130750.66549-1-mertseftali@web.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mert Seftali <mertsftl@gmail.com>

in_accel_scale has returned -EINVAL ever since the driver was added.

The channels advertise scale via info_mask_shared_by_type, so the IIO
core exposes in_accel_scale, but dmard09_read_raw() only handles
IIO_CHAN_INFO_RAW; a SCALE read falls through to 'default: return
-EINVAL':

    $ cat .../iio:deviceX/in_accel_scale
    cat: in_accel_scale: Invalid argument

leaving userspace with raw counts it cannot convert to m/s^2.

The driver was written from a vendor source [1] without a datasheet, and
the scale was declared but never implemented. The vendor source carries
the sensitivity: its conversion is

    acc = raw * GRAVITY_EARTH_1000 / sensitivity   (then / 1000 -> m/s^2)

with sensitivity = 32 and GRAVITY_EARTH_1000 = 9807 ("about
(9.80665)*1000"), i.e. 32 counts correspond to 1 g.

That sensitivity applies to the value this driver already reports as raw.
The vendor processes each 16-bit sample as 'data >>= 3; data &= 0x1ff'
plus a sign-extend of bit 8 - a signed 9-bit quantity from register bits
[11:3] - and dmard09_read_raw()'s 'accel <<= 4; accel >>= 7' yields the
same value. It is self-consistent: 256 counts / 32 = 8 g full scale,
matching the part's +/-8g range.

Implement the scale derived from that sensitivity using standard gravity:

    scale = 9.80665 / 32 = 0.3064578125 m/s^2 per LSB

[1] https://github.com/minstrelsy/mediatek/blob/1f49d8c87b839651bc89afc870277e8e0f2e2d55/custom/common/kernel/accelerometer/dmard09/dmard09.c

Fixes: a4fa6509dda4 ("iio: accel: add support for the Domintech DMARD09 3-axis accelerometer")
Signed-off-by: Mert Seftali <mertsftl@gmail.com>
---
 drivers/iio/accel/dmard09.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/accel/dmard09.c b/drivers/iio/accel/dmard09.c
index fe35a1270786..a61943120d07 100644
--- a/drivers/iio/accel/dmard09.c
+++ b/drivers/iio/accel/dmard09.c
@@ -27,6 +27,9 @@
 #define DMARD09_AXIS_Y_OFFSET ((DMARD09_AXIS_Y + 1) * 2)
 #define DMARD09_AXIS_Z_OFFSET ((DMARD09_AXIS_Z + 1) * 2)
 
+/* Sensitivity is 32 LSB/g; scale = 9.80665 / 32 m/s^2 per LSB. */
+#define DMARD09_SCALE_NANO	306457813
+
 struct dmard09_data {
 	struct i2c_client *client;
 };
@@ -79,6 +82,10 @@ static int dmard09_read_raw(struct iio_dev *indio_dev,
 		*val = accel;
 
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 0;
+		*val2 = DMARD09_SCALE_NANO;
+		return IIO_VAL_INT_PLUS_NANO;
 	default:
 		return -EINVAL;
 	}
-- 
2.55.0

