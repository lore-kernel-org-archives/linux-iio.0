Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7053D8133
	for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 08:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672598; cv=none; b=JN3lwiWBbI0uLdAsindGpdyrlX6858+VMqcAFGShw10K15JY7+rq2d7KKQ+P6GgNYWr/4vF++ApnMm7ABJbPn++rv2TZbvDFEoyQEoRtDH8aN7YiwFhW/IB7WS6mmvot86+GLvnnM5Uf/qBpIbGDEvruhbeRPt0GeaDvd2mAZXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672598; c=relaxed/simple;
	bh=/nKSNbpEdL+T6GQ95kGzOqJewbxvRukWfExTHwG8WQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kR2DKe2b1XG7PzoJeNrpZldQreAvjrx1gcGjztBcL3eDoFF2aWpMYeRzGYdDTqxjpdSqdNDy6PN8nDUMKaoUQtOlHQ9YGSbOvn9j1G7IjzxLqWzoJ/lzNfS9FWFkt0czfKIjjKpfYdSDf9Q8kVC5uTC34mfb35N4WihlGCApk4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icFukE1t; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icFukE1t"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493c19bad03so5349125e9.2
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 01:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783672596; x=1784277396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pA1HEGDtcWaQ9J5As0L2Cw9LkRzBGT6/pW+NLlqfsl8=;
        b=icFukE1tGsSnIDjBDOxIlOJ5tL0kOU3LuQQ4l3mTnIKjI9ukDfSDHHy++EDNTb3lqW
         qm/flp1X8hgRa4r6wI2JzXGgRRTVz2vnrMx6tssRj6UNNJaDZHgOogv+9TiLw59wpa2a
         C+bAfXMQM2GltMPhzr18DMyi1CJDDfryQBnpDlFzrLuvuTv5GxEGzX2S06jnWmxSbAim
         9McOd93+hlfTAZ86QnXPZoQ3ojgSbAZxnNHzWvprLFWN7lwmccfes8fBi9pdiYDW/pNz
         NyndiY8oBSP6jQIsBhjrQqpHxTVqXOcksQcbvahzCagf+OfEdrVM+cSaNbVfVrbVXx4i
         Pn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783672596; x=1784277396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pA1HEGDtcWaQ9J5As0L2Cw9LkRzBGT6/pW+NLlqfsl8=;
        b=GB8GrxceG2AmT6IOxrRSHDMLJlaCyaqMENvJhZczPLcFWi9etmG88NVld0Qs6fyl9o
         LLzxejmyVtsp4KkLtFOAwZ67128c1Fhmzr6/5mGxJ4rp2CB4bHGglbI0wLx0gnudm+4g
         0nT6YcFbYfaQLHT/C6sZI07mOBa99+S0tQwPlTPv67cTV0zxdeD9LVMHMIS1zsxsuszL
         zDpnrNSskGE8EL2ioONhZ1CQDQ1nukLS8P/a2gXBvPjSCKoBa1fpgsTr4+dnDtAe10Wk
         eBbCEqgyQVp/ywrKdA6jX6BMWZAQMkTTBOvzfhh8TE0mM+PFEzyu4CLXWhzWu0Qvfww5
         4ciA==
X-Forwarded-Encrypted: i=1; AHgh+Rr62KPS77/5o50IOdsC2XVqzNwnktpvx14uDCpi7OLb5SDI1MB3sBVCuWc2SwTN3h0f4Bjnstlme6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9RK5qheaMaBI685fTt4Np1DcaJ5XD/OJJOL91Z+gd30I6muMD
	jyBCC3MED1Pl1SJXX87u87Qsm97fJj9zlETAXbuIK3l+w4GI8XRhC9wc
X-Gm-Gg: AfdE7cnicLjQiqtGXi1E25tWFgeGREwvjWlIIb6K5bfeCU/9p2d1hF48F2iuYogG5++
	mXOErP50ueqM+RMbRapDgTbDpVWVZyIe0dAkTyayM/VQDQuE1UJLDQDO87Expa6sFR0QyXHDRMD
	uf1GPOMnyGDM5yFPIY+ZqNoySCekNxurSwoehdF4zGnLnA1TKBWs/UL4VzBToonsk3m7cvWUlQp
	jTlc5jzh1QUJUJiuUSYCEfRiXYuUMpStjzdWtpIcll45oS/XP4uWOCIsHqO7o/7106pUIpFdIxj
	mz6xVpHTKsyDQIUq75Mm54hJmHS9xr9vDyvRjdF9F76DEHUpqc1mcFmO/QfvtoZIFfXQvzXL8CB
	FK6414S9sx/1Cw/BDqv7cd1TKL8q5JOfOHxFbTFZjz45Enp5MMeDqKxK/7z66uZSsiuPCSeuRY3
	Z3NWHH1mglaCSdaq1ZI7/Jhl9uv5NdpNa2PxTc2VTzXBO6A2pVKntjbvP84HC+L8t078gfCK6fe
	rNpc2po+MqmHf3BEko=
X-Received: by 2002:a05:600c:828c:b0:493:e460:1f6 with SMTP id 5b1f17b1804b1-493e65f1b02mr104587255e9.0.1783672595783;
        Fri, 10 Jul 2026 01:36:35 -0700 (PDT)
Received: from workstation.speedport.ip (p200300d5070afe7db3148fa84ed2ac78.dip0.t-ipconnect.de. [2003:d5:70a:fe7d:b314:8fa8:4ed2:ac78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6e8844sm134592985e9.10.2026.07.10.01.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 01:36:35 -0700 (PDT)
From: Mert Seftali <mertsftl@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Jelle van der Waa <jelle@vdwaa.nl>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mert Seftali <mertsftl@gmail.com>
Subject: [PATCH v2] iio: accel: dmard09: Implement IIO_CHAN_INFO_SCALE
Date: Fri, 10 Jul 2026 10:36:23 +0200
Message-ID: <20260710083623.84243-1-mertsftl@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reading the in_accel_scale attribute on the DMARD09 has always returned
-EINVAL: the channels advertise scale via info_mask_shared_by_type so the
IIO core exposes the attribute, but dmard09_read_raw() only handles
IIO_CHAN_INFO_RAW, so a SCALE read falls through to 'default: return
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

That sensitivity applies to the value this driver already reports as raw:
the vendor reduces each 16-bit sample to a signed 9-bit value, and the
preparation in dmard09_read_raw() yields the same value. It is
self-consistent: 256 counts / 32 = 8 g full scale, matching the +/-8g
range.

Implement the scale derived from that sensitivity using standard gravity:

    scale = 9.80665 / 32 = 0.3064578125 m/s^2 per LSB

Link: https://github.com/minstrelsy/mediatek/blob/1f49d8c87b839651bc89afc870277e8e0f2e2d55/custom/common/kernel/accelerometer/dmard09/dmard09.c [1]
Fixes: a4fa6509dda4 ("iio: accel: add support for the Domintech DMARD09 3-axis accelerometer")
Signed-off-by: Mert Seftali <mertsftl@gmail.com>
---
Changes in v2:
- Reword the opening around reading the attribute and merge the duplicated
  explanation into it.
- Describe the sample as a signed 9-bit value in plain language instead of
  the register bit operations (the vendor code is in the link).
- Turn the vendor-source URL into a Link: tag.
- Express the scale via the IIO_G_TO_M_S_2() helper instead of a
  precomputed constant.
- Add a blank line before the return in the SCALE case.

 drivers/iio/accel/dmard09.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/accel/dmard09.c b/drivers/iio/accel/dmard09.c
index fe35a1270786..6f0497ab6133 100644
--- a/drivers/iio/accel/dmard09.c
+++ b/drivers/iio/accel/dmard09.c
@@ -8,6 +8,7 @@
 #include <linux/unaligned.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
+#include <linux/units.h>
 #include <linux/iio/iio.h>
 
 #define DMARD09_DRV_NAME	"dmard09"
@@ -79,6 +80,12 @@ static int dmard09_read_raw(struct iio_dev *indio_dev,
 		*val = accel;
 
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 0;
+		/* 1 g / 32 LSB, in m/s^2 */
+		*val2 = IIO_G_TO_M_S_2(NANO / 32);
+
+		return IIO_VAL_INT_PLUS_NANO;
 	default:
 		return -EINVAL;
 	}
-- 
2.55.0

