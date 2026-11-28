Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795866968;
	b=IatRsrrO+oykTOwocdnQUUMINjt/mnLDaT46qBcM+Q/1iSNq/9ibkDG6DGQ0cwEJiNOv
	 302ivJukZhDQ0K3wSRSUV+dPQK97TnVSYZrXNJP2HAYWyJ9z/OYD6JVY6r30WAJuYzuUD
	 /wLrANvhnETF4LEoPqI8YIGCe9jxhzBEd3XSHMjXPC06fLpYTskbMCSeOt0CIovW15cN7
	 Jdn3TWjL4pdyJUhKP+57FAXCTmC1L4ac7LliFbvOhO/z45OvuvJdNXL5tvsKUYy8UBrbB
	 cWbnrAgWcBlaQ5QwcnS/dRh7H8LHG50Lis5vmsoffcSpQgAaDx7mi1J0NLFCw4zZ+pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795866968;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cw7BTPmciG1UZFiqYKRUb8L88t/V4Mf/TBRXyRsQ1mI=;
	b=QwMxEE6Zwnwl44ztSW12IPXniMdtmHd9j1e+izO9Po0jSv5MCvBrexDxOvpGGWhdzZv5
	 JXV7viLeCaU7qTZO54hVIEzqejE51seZ3k0y1MgeTmpKNyRZkCnhJV8zOKQv4gE+tNjA6
	 jgj/hyJsfSVdMFyGOdzHalj7gLOt14uxbza3V8Yrjl1LHj/VvQAb84FthKM6bohs3MSKr
	 cFxEd9tCdJFzDRDta7cnB2yEsQdBXheqhz+yVN6KRBsWyQnC5a/dgqJCvqtK6x3yS+bAE
	 Ndl7xdk7dGwaht4L9DQ4HF7iK5P6dgHJtkXYgtmOszg9xdOgPqQKl9V5hID2cznZvCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UEEYWLC5;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D878606A32E
	for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2026 11:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D878606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UEEYWLC5
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33fb4680717so6699889eec.1
        for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2026 03:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795866967; x=1796471767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cw7BTPmciG1UZFiqYKRUb8L88t/V4Mf/TBRXyRsQ1mI=;
        b=UEEYWLC5Ii3d7cz+BOvAPRcfL+4xkHX6oX87k3gQ/VlO8nGuOqGjMO5xQ4U8JrggbI
         ZBj50bjYgss8PFXqXP5/i+GRsoX+1NWEnuxGB4/d08TD868hTTXauZfr3CYfnE0/40jZ
         rAH3CSAHc/EFjvKJkUcxMONtSEkFnhpcJthk1TD/pb2oeUc928l0wccS6jcEDCLlMWsT
         9s7Q/DdWwf+9uSj5Do02vkiUBG8+OpbI4sR9lqcrzynd6URdXJvL5stWTC4HcwqtYkwc
         pHz6QV3ZA+f/qAuFAozy42jL9gDzzb0vhE79QaA+1OrS6KNSEtFsUtQnHoqyr8MvATAU
         YqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795866967; x=1796471767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cw7BTPmciG1UZFiqYKRUb8L88t/V4Mf/TBRXyRsQ1mI=;
        b=KVo/Qf2LdTcI5qerhtnOvOr9lihru1tqvhDpIOC2Q8G8phw2phBvRKlaHfl7AihRdM
         Q4ziI9pujQRD7SKGjLayNhcCXyFu17ZDwL0os5WQVVzGSjUm7OK/4JNgF3JiOLgg4Se3
         Tpkylv/0vfXBXpOX7NkU8d8Z8BgU3HCA3IMnPyqaEpqHsWSxEJBl49OuL3rY96/6frMT
         P9Ia4x2G00gl8inAZf9CwI6BFrS/XVzlsJtfTyR4bfI1+QY9y3oqIWPdY/eXR/zOuGUo
         AmQcaBinA9Chda3XjMFc+4V4bavXnGaCfjv3TuHxWu+yj7tbi49fWCFH8RWs7e19YVxj
         jrdg==
X-Forwarded-Encrypted: i=1; AL+hErEaz1xkcDZlpWyo7LZpfJQGZ2cSTd/EW2TZmK4NVCUJzjrZi4tX5D5c8wUbEilyTc4BViOsy9DO1qI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/7p7e/NDNWYdeUUGoPP1Lx+PCZYmZFcZn7Bt7/QUylAD84IhGc
	ZJaiCvBrOcRE2KQZli8GqlIc5IldQg/4VRnWd3kgNAiLgsp3BKb0+O54
X-Gm-Gg: AZFdTZdue6C0/qZhCynlhwLOYPKKsUOCx79Bf+s6VtJwRDXJuraQZrRSOuJ5CjL704Q
	qUufKIcavcMRmWSmHGzCMUf08vrBoZuwpOvcJFjwFjk7FtcRqy0V4202aqlPXZ5eMLkQrLB6eri
	u9LXfdzLTaeTbTWoHxBYFY8aLG7FGN0OoInnfAg7uMnMkqeZ1pz+rTbQLky6IpxislT/bH3RwVQ
	8zh+jJFQr9d3xP3Agx63R8l5ag45wEbQt0prBo7RuIxjv64WT7CmJRXxbmaM5kjOCX5Sr9vSZKj
	erd1/8PCDum/ijHU95HGdd9KMfRtQzn7KoQl6wA7OZYakU7a+LlF2YvVS7HqJjHMlRkVp8iwVAZ
	Ar5MKNYmnoSwKLOPKd6MdZnIwdrSmlXxm/jbci1IkJrS0jyUC8HgoGKqX4OPVWXRent0LWfj187
	qe0omc8cQ+tFk0R7waP8GT9mQtOBtNjsDcVT6VPxQA6cyNIN8821xhKdJJ3wgfcOTkAMDnIF7jY
	3HvxRf8wMo66bkxMw8HYN+GULVbkfjSa1Aejx/6fhNRmlJaWeopvsywVLc2twMyr/xrDLNTJVDD
	mZ0kCYlM5nHLFf/yF99aUcXTxuzSJI/MqT+clW6c9Pc5SJI4UpAS/RdZ1SVFErl1YwtIu5iai7l
	BhzmrUKO2PT1uwLrrLfQc15HaT/Ab8d1L1vRiH9LOi0UTfPvexEylqOZhNmxmezXWp7vcpXG+q4
	K2H6GuT3d3XvNwjB54vQ6wx1NP++RO63z5eGkNrFBxoF8LOfBSO9rtRJAF+R0uOJU=
X-Received: by 2002:a05:7301:182f:b0:385:cf42:9b9b with SMTP id 5a478bee46e88-385cf429e7amr26702208eec.8.1795866967370;
        Sat, 28 Nov 2026 03:56:07 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385f68bc0adsm76783178eec.13.2026.11.28.03.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 03:56:06 -0800 (PST)
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
Subject: [PATCH v3 4/6] iio: proximity: sx9360: fix hardware gain encoding
Date: Sat, 28 Nov 2026 17:24:52 +0530
Message-ID: <20261128115534.558478-5-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261128115534.558478-1-kapoorarnav43@gmail.com>
References: <20261128115534.558478-1-kapoorarnav43@gmail.com>
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

The sx9360 PROX_CTRL0 gain handling was copied from the original sx9324
driver and has the same bug that commit 108e4d4de2b5
("iio:proximity:sx9324: Fix hardware gain read/write") fixed there:

  - The gain field holds ilog2(<gain>) + 1, with 0 reserved, so a gain
    of 1 is 0x1 and a gain of 8 is 0x4. read_gain() and write_gain()
    use ilog2(<gain>) instead, so every gain is off by one: writing 1
    programs the reserved code 0 and writing 8 programs a gain of 4.
  - SX9360_REG_PROX_CTRL0_GAIN_1 is 0x80, which sets the reserved bit 7
    and leaves the gain field at the reserved code 0, instead of
    0x1 << 3.

Semtech's own SX9360 driver (shipped in Samsung Galaxy kernels) decodes
the field the same way, codes 1..4 as x1..x8 and 0, 5..7 as reserved,
and programs 0x09 (gain x1, bit 7 clear) into both PROX_CTRL0
registers.

Use the same encoding as sx9324: add one when writing, subtract one
when reading, return -EINVAL for the reserved codes on read, and build
the default with FIELD_PREP_CONST(). SX9360_REG_PROX_CTRL0_GAIN_8 used
by the range check in write_gain() becomes 0x4 accordingly.

Fixes: 1cdb4c47f7f5 ("iio:proximity:sx9360: Add sx9360 support")
Link: https://github.com/TeamWin/android_kernel_samsung_d2q/blob/master/drivers/sensors/sx9360.c
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx9360.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index f9cf4994a17a..f89b18778f91 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -67,8 +67,9 @@
 #define SX9360_REG_PROX_CTRL0_PHR	0x40
 #define SX9360_REG_PROX_CTRL0_PHM	0x41
 #define SX9360_REG_PROX_CTRL0_GAIN_MASK	GENMASK(5, 3)
-#define SX9360_REG_PROX_CTRL0_GAIN_1		0x80
-#define SX9360_REG_PROX_CTRL0_GAIN_8		0x3
+#define SX9360_REG_PROX_CTRL0_GAIN_RSVD		0x0
+#define SX9360_REG_PROX_CTRL0_GAIN_1		0x1
+#define SX9360_REG_PROX_CTRL0_GAIN_8		0x4
 #define SX9360_REG_PROX_CTRL0_RAWFILT_MASK	GENMASK(2, 0)
 #define SX9360_REG_PROX_CTRL0_RAWFILT_1P50	0x01
 #define SX9360_REG_PROX_CTRL1		0x42
@@ -292,7 +293,12 @@ static int sx9360_read_gain(struct sx_common_data *data,
 	if (ret)
 		return ret;
 
-	*val = 1 << FIELD_GET(SX9360_REG_PROX_CTRL0_GAIN_MASK, regval);
+	regval = FIELD_GET(SX9360_REG_PROX_CTRL0_GAIN_MASK, regval);
+	if (regval == SX9360_REG_PROX_CTRL0_GAIN_RSVD ||
+	    regval > SX9360_REG_PROX_CTRL0_GAIN_8)
+		return -EINVAL;
+
+	*val = BIT(regval - 1);
 
 	return IIO_VAL_INT;
 }
@@ -629,7 +635,7 @@ static int sx9360_write_gain(struct sx_common_data *data,
 	if (val <= 0)
 		return -ERANGE;
 
-	gain = ilog2(val);
+	gain = ilog2(val) + 1;
 	if (gain > SX9360_REG_PROX_CTRL0_GAIN_8)
 		return -ERANGE;
 
@@ -680,9 +686,11 @@ static const struct sx_common_reg_default sx9360_default_regs[] = {
 	{ SX9360_REG_AFE_PARAM1_PHM, SX9360_REG_AFE_PARAM1_AGAIN_PHM_6PF |
 		SX9360_REG_AFE_PARAM1_FREQ_83_33HZ, "afe_param1_phm" },
 
-	{ SX9360_REG_PROX_CTRL0_PHR, SX9360_REG_PROX_CTRL0_GAIN_1 |
+	{ SX9360_REG_PROX_CTRL0_PHR,
+		FIELD_PREP_CONST(SX9360_REG_PROX_CTRL0_GAIN_MASK, SX9360_REG_PROX_CTRL0_GAIN_1) |
 		SX9360_REG_PROX_CTRL0_RAWFILT_1P50, "prox_ctrl0_phr" },
-	{ SX9360_REG_PROX_CTRL0_PHM, SX9360_REG_PROX_CTRL0_GAIN_1 |
+	{ SX9360_REG_PROX_CTRL0_PHM,
+		FIELD_PREP_CONST(SX9360_REG_PROX_CTRL0_GAIN_MASK, SX9360_REG_PROX_CTRL0_GAIN_1) |
 		SX9360_REG_PROX_CTRL0_RAWFILT_1P50, "prox_ctrl0_phm" },
 	{ SX9360_REG_PROX_CTRL1, SX9360_REG_PROX_CTRL1_AVGNEG_THRESH_16K, "prox_ctrl1" },
 	{ SX9360_REG_PROX_CTRL2, SX9360_REG_PROX_CTRL2_AVGDEB_2SAMPLES |
-- 
2.53.0

