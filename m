Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6B1379ED5
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 08:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776587518; cv=none; b=kuE50ZH7x9RVCtHSPbdGkbc4vKY5OExT+iwa86WmkehJRWE7TsjhcaatloE8txHgs+jZ7YjWJ9h4b8wE0oiwpWafmAxTy4JMxfJX42FfyBDwrdl4ji76X6cLXLre7yqu0sCjSMS8PIDxe1oWcpEtFwboPTFBPTjHEhv2D+85rIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776587518; c=relaxed/simple;
	bh=ToECUiy6IO+Oym1nO2YydJJYfMv9Ti7cR0ZGWkKhXvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Woc+TR2H7bbsqVQFkUNkLUIJNMdOjAc/kAbtvnKjyQO93/ar2O+CzyIORusZhSJNtltgMRndLERvOGFdQeh5iQHDsKk2xDUwO0Ts4lTU2dw7nsiAkkLRJOnvgapJ5i0PSIzTRQp16oqPK3cBeMhnghwgGCBJO07jjIIjy2B1xAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMKbqasm; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMKbqasm"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38ddd8d3b7fso16245131fa.3
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 01:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776587512; x=1777192312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKUPlAlvFmlfkR1oHbcDc9OOKBpu5sVGNnqNv91gVHc=;
        b=QMKbqasm3q8gyVoc9dQtQ7meBR5pc8W6yceOsf6EYUCQg4oppSafICrF1uHxsIrUNf
         wZD+h9i2r+VBkYjmntdbV5GTAXMg/RPGNPZf9LjLaj9HRzGKKJGR4sAHtMkTLrqdCj4G
         Bcyy2Qt1vAl+MiL1GS89Scmsxi5yxelfaJbwvm/U+mSIHQ2UMUuOk5RMUtwx5N3beu+p
         S5njZ45LgKBdTtrroaFgjtpVXKEnVFSi1IqYrcLyPENF1SxHTDgWRvwlep8pamZQxRb4
         dYxuFdPgv2iddaLS7Js1qz9Uc0AQBjqAbVHR09W23vkLGc8ZEOmc78t2GwAtLvrvEjxW
         UNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776587512; x=1777192312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vKUPlAlvFmlfkR1oHbcDc9OOKBpu5sVGNnqNv91gVHc=;
        b=D3CEm/SYGIbOoVFIOtmVr0VLE4cOhLuKKqKgR/epl2zSQV06oVw3ga/EPvbx1eWmba
         9uDPwZCEntFTfr/vfMMixL9D1aUtV4/ERcvDwX4Owqnaf37K1oKcMiZQeZS7kvRWCn8w
         atslab4U878G5l+U3fCfi6TWQ9xKcz9iAVf2tSJ9zxkHKjmCpwH/yK1CKpI0Qw1lMbMt
         nNAx80LDoMuW4xbWfUqAy2YdBBfooMXsoBLDYlZ5CLVlrzyK/7XgFi3qrqRCvwSVTHU2
         SFT8Cz9D+EmotHCLX+DUKnBHQxMTuPK4wcHysc2pMHyLxHj9kflID6xWNaQfgTItVKlT
         kHCw==
X-Gm-Message-State: AOJu0YzOFMkiOqfTiIFv965q7FJ70+jQfaarFWrgps6qmhz4yQ8QF1HK
	emhDrk82rRCXCskb55Bkqih6Mh2IxEGXKWQA7TVKRmBGhdUQMZqcbRNW
X-Gm-Gg: AeBDietwDA82ILakbXL6gwo/HoQj46LhUxgSUudZGRS4NDFA7kYNvn7r9K83YnEiSo6
	f4g6sX7QNdh5c69wOU07CGaZst7vo/fFJKIQlYpuJC4e0L3c3x88A9vUMRGdy6JRgrXyDtN/cKz
	oRj4J7xcTj9QV3pXF3T9oQh34gAvUEtiK8nnUz1bymQw6nYds9RMvMZARo53O3GznuAFAUrHkN2
	l50ixDtrreStYlEMmrlW2ia56XTHVgr5EB6fSAZFQMhkoCe5pGSOdGGJF1utWIBtdY2Q8ucFNeB
	3b8LZDlY5+ihLFTMTMmE0oTHAeoHD11tH0dv8O44fI7cs7Ol72/o8jlgpnrMZNsI60ZHIB2459f
	wLUy/b/3KGuqou3d9/E/UFBiMWOAiCJh02Ji/AT51o25XkUCiv8R3GhkKY0HE5umS3GDSKV62S1
	3UtYdBVY1VA02WPRLCa0ZZQfgBYcrJNIOflg==
X-Received: by 2002:a05:651c:e18:b0:38e:d8a3:e08a with SMTP id 38308e7fff4ca-38ed8a3e2bemr17458471fa.3.1776587511839;
        Sun, 19 Apr 2026 01:31:51 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb7613a9sm17852101fa.41.2026.04.19.01.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 01:31:50 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 2/3] iio: tsl2772: add support for Avago APDS9900/9901 ALS/Proximity sensor
Date: Sun, 19 Apr 2026 11:31:23 +0300
Message-ID: <20260419083125.35572-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260419083125.35572-1-clamor95@gmail.com>
References: <20260419083125.35572-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Avago APDS990x has the same register set as the TAOS/AMS TSL2772 so
just add the correct bindings and the appropriate LUX table derived from
the values in the datasheet. Driver was tested on the LG Optimus Vu P895.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/iio/light/tsl2772.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
index c8f15ba95267..8dab34bf00ca 100644
--- a/drivers/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@ -127,6 +127,7 @@ enum {
 	tmd2672,
 	tsl2772,
 	tmd2772,
+	apds990x,
 	apds9930,
 };
 
@@ -221,6 +222,12 @@ static const struct tsl2772_lux tmd2x72_lux_table[TSL2772_DEF_LUX_TABLE_SZ] = {
 	{     0,      0 },
 };
 
+static const struct tsl2772_lux apds990x_lux_table[TSL2772_DEF_LUX_TABLE_SZ] = {
+	{ 52000,  115960 },
+	{ 36400,   73840 },
+	{     0,       0 },
+};
+
 static const struct tsl2772_lux apds9930_lux_table[TSL2772_DEF_LUX_TABLE_SZ] = {
 	{ 52000,  96824 },
 	{ 38792,  67132 },
@@ -238,6 +245,7 @@ static const struct tsl2772_lux *tsl2772_default_lux_table_group[] = {
 	[tmd2672] = tmd2x72_lux_table,
 	[tsl2772] = tsl2x72_lux_table,
 	[tmd2772] = tmd2x72_lux_table,
+	[apds990x] = apds990x_lux_table,
 	[apds9930] = apds9930_lux_table,
 };
 
@@ -289,6 +297,7 @@ static const int tsl2772_int_time_avail[][6] = {
 	[tmd2672] = { 0, 2730, 0, 2730, 0, 699000 },
 	[tsl2772] = { 0, 2730, 0, 2730, 0, 699000 },
 	[tmd2772] = { 0, 2730, 0, 2730, 0, 699000 },
+	[apds990x] = { 0, 2720, 0, 2720, 0, 696000 },
 	[apds9930] = { 0, 2730, 0, 2730, 0, 699000 },
 };
 
@@ -316,6 +325,7 @@ static const u8 device_channel_config[] = {
 	[tmd2672] = PRX2,
 	[tsl2772] = ALSPRX2,
 	[tmd2772] = ALSPRX2,
+	[apds990x] = ALSPRX,
 	[apds9930] = ALSPRX2,
 };
 
@@ -530,6 +540,7 @@ static int tsl2772_get_prox(struct iio_dev *indio_dev)
 	case tmd2672:
 	case tsl2772:
 	case tmd2772:
+	case apds990x:
 	case apds9930:
 		if (!(ret & TSL2772_STA_PRX_VALID)) {
 			ret = -EINVAL;
@@ -1367,6 +1378,7 @@ static int tsl2772_device_id_verif(int id, int target)
 		return (id & 0xf0) == TRITON_ID;
 	case tmd2671:
 	case tmd2771:
+	case apds990x:
 		return (id & 0xf0) == HALIBUT_ID;
 	case tsl2572:
 	case tsl2672:
@@ -1898,6 +1910,8 @@ static const struct i2c_device_id tsl2772_idtable[] = {
 	{ "tmd2672", tmd2672 },
 	{ "tsl2772", tsl2772 },
 	{ "tmd2772", tmd2772 },
+	{ "apds9900", apds990x },
+	{ "apds9901", apds990x },
 	{ "apds9930", apds9930 },
 	{ }
 };
@@ -1915,6 +1929,8 @@ static const struct of_device_id tsl2772_of_match[] = {
 	{ .compatible = "amstaos,tmd2672" },
 	{ .compatible = "amstaos,tsl2772" },
 	{ .compatible = "amstaos,tmd2772" },
+	{ .compatible = "avago,apds9900" },
+	{ .compatible = "avago,apds9901" },
 	{ .compatible = "avago,apds9930" },
 	{ }
 };
-- 
2.51.0

