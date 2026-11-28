Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795877762;
	b=A6ZuA7uatDidanT2PwDwIMTh+EnjD8lP11BIV6ZuEa3Dd4pcB/3W6CxSJIQU6nJkEtFi
	 3cy3N+Tmefh8w0bXVRnDMJs/pxJKSZJFUEZCl1Pk7z1o9EsUxzsnPWmduK8Mnr4E0N5Ky
	 SzLSkDR9i548tCEMIVqyxv1YZVuffQf0wRnKco2m99UH/98foEoqWy15vECg0qKOYcNLY
	 TMS/uA0p1Ggj3jRCKq1snxj85Kv04aA4c+xSNt28OvkdFePeZ1YubKNoSXRW7de98Zoq8
	 DouCnXvLY3y/7Mpelyn7G3KxksamWe5GESDYx3IBJVdOVT8UCD+LTV1fmUZTS2BaArQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795877762;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dF1xy4UlbGgU46u1ZBn9Wfi17OLjsP8FeQQWUgWQlrs=;
	b=Hak5/H9oWzqQ0ibIr1rze8BevhCq1/E0YgiQ28Al6CMNeqzVby75NgjB0DEyvcsy1keG
	 X30chz4mRJuBa1HU2IaB1DlPT+Cgri9lAgjleuSic6ua7hquSSwObanamD7BC1BmL8L/N
	 uypaMEnNB4ri3h1Bhx/skFYTsvt8PKfdIYu4VX04vPHOn8NgE1vz+iOErw/clpA6XYnkM
	 UfGU5n9A9t5ErsZpY3dr/jJeuWFQkM0ITlTtSU1+8Jl2mVRiYX4BR1TMfOoshrg5jtzuU
	 rCjGQAgnK2FeXQWsvYmVH55tsAg2FMmTdY0dtujG/H71yvjfGH9vXt+CLcX+4bLogtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AsNlU3bO;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16AE606A31C
	for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2026 14:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B16AE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AsNlU3bO
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-38431138772so11901474eec.1
        for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2026 06:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795877761; x=1796482561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dF1xy4UlbGgU46u1ZBn9Wfi17OLjsP8FeQQWUgWQlrs=;
        b=AsNlU3bOVKeh0pfx7qsHGMiLvSPyc7oJii6HgC/cUV5wMDVohbjgKq7A9TNTXXEaLK
         7oHFnUd4OredwVsBnUOFoyFFSsfKUXp0MZx21rs3R0w77xsF1Ms3S0E+LD9OpBQMNqRI
         nM4/3j4wQxQ00lHTgY8zHmkwiLSDbh9+l9fBfboQQGeSXB6sbY+0S/a6qlAzQTO/TRZz
         HGA7vatB7RTJ7ip0/TQjlYVu7Mu/FOqPiWcHXnT28E+hKz9gH+gBVqOxvo0EYE3CrCqJ
         DhagkJO3U6ZxGliILrPzNcj/kGWt1S+TsgW+FcRVInI3cxRD1eLBFARXqayBRYrncYLM
         rL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795877761; x=1796482561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dF1xy4UlbGgU46u1ZBn9Wfi17OLjsP8FeQQWUgWQlrs=;
        b=01nc5iO4bUmAvvDQ80xbCH4oB0TMYsHv0ztvH4yw5sFXTWP2Y085Y4hs6daB9pvKBj
         7gx2SqlcsTbtmCCrsRW44tLygLjIQnZWnwp2OOhRQBAwd/yNG7ZJt4TlnTIGVpxIUq2V
         8yj5NCvERUTpXpMoPxItwrjxe3Cu2jnV1g7MS3WyB/C7CLZt5Fm/TuW2BjcEFUSjA0mO
         0oTRTUm25KxmNmeHIXmwvrkMA0a+VFn5jfacfLoMgsMEOvzOvezmbq3nZwEdr2GlA3Wv
         NJNQBHWdzbsBKgxMcUJshVZAczdELrLA/pmQt7Pu3fzGDvrB4fxXJUKX2nsh9l0qDZHV
         7i6Q==
X-Gm-Message-State: APuU4Z8bEPSG7BPg9J5b/oNyAwsBGE5kt9lrM14sfOWuO+i7BlnA8j1l
	gPpLvok0j3/xKa3iHTC8KTDTNP2qKFxiMG0jjrvd8obE2bbokFIZBCZA70+tcPI=
X-Gm-Gg: AZFdTZc//Nq+mds5XvQmCxxfwG5MV1LzgeiiZhr8O69fqCHReKRUNN42KkRgCg6hdaQ
	ngGynb74qnZDHTmKRfUxv2eBpsK42jkputgI+no8NPIa6LqYvovDySRNR9DqmO7fZ+EBkLWGyPz
	mzJkCp6Gs2pJudCzQNF4TFx194ht8CjiSjnguR0l+78Fq85x0ZXbhidzPsV1ooVYYnvonMR//tB
	w+86SA8/TQtUv61ePrP3EneMY74cdCgmyJP9QrNstUnKbNgJLZBDrgQ7atEGLRWhMjdJUYZBGVs
	SlEppVfykGFwd/NQyA97J8iUNfh4EO0+04iN1rfL2T29OxrCEW0QoQvcoVnZDu3rnVNbJXFg99V
	Yy8r8DrWXPYTvRyDbIJkdChVLIBZJMyST45ALp39Ki7PW1l+lZY1ldEkLyv3ez7BkvVzbHUe8g/
	E4715T9gJX5wboVvIRXEnDLSC2fFDPLG4sxfmGDo+wY+lJytWz/5XyJkvCj52SGymlX/5dyUJaa
	0vgQcTYvdTC9thjy0SrUyNFZ2lu8RVG5Wz37691Ft0zJHo91inViKECu3MNtEGer5+ZDwqpeuwh
	R2DMB6fzMl6Tba6x4oq6GJsRNopTDGVp1KR9ZZ+URSSbmTx/PxaPyJFPjk4C0ZtM+Ojqd8+coe8
	=
X-Received: by 2002:a05:693c:8211:b0:36f:202c:48 with SMTP id 5a478bee46e88-3857045092emr29007389eec.14.1795877760668;
        Sat, 28 Nov 2026 06:56:00 -0800 (PST)
Received: from ryan.localdomain ([223.231.174.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm98454305eec.5.2026.11.28.06.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 06:56:00 -0800 (PST)
From: Mohammed Rayan <mohammedrah1289@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	songqiang1304521@gmail.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Subject: [PATCH] iio: magnetometer: rm3100: correct TMRC 0x9e sampling frequency
Date: Sat, 28 Nov 2026 20:25:35 +0530
Message-Id: <20261128145535.17308-1-mohammedrah1289@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261128034156.773f1e07@jic23-hlaptop>
References: <20261128034156.773f1e07@jic23-hlaptop>
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

PNI's RM3100 Breakout Board User Manual lists an update rate of
approximately 0.15 Hz for TMRC 0x9e, with a 6.7-second interval.
The driver already stores 6700 ms but exposes the rate as 0.015 Hz.

Correct the advertised rate and the lookup table to 0.15 Hz. The
register value and timing stay the same. As discussed on linux-iio,
writes of the old 0.015 value now return -EINVAL.

The RM3100 core, I2C and SPI objects built with W=1. A host test
using simulated registers verified the rate mappings. No hardware
testing was performed. Codex assisted with source analysis.

Fixes: 121354b2eceb ("iio: magnetometer: Add driver support for PNI RM3100")

Signed-off-by: Mohammed Rayan <mohammedrah1289@gmail.com>
---
 drivers/iio/magnetometer/rm3100-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
index 8e80cf679..4e13921f0 100644
--- a/drivers/iio/magnetometer/rm3100-core.c
+++ b/drivers/iio/magnetometer/rm3100-core.c
@@ -249,7 +249,7 @@ static const struct iio_chan_spec rm3100_channels[] = {
 };
 
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
-	"600 300 150 75 37 18 9 4.5 2.3 1.2 0.6 0.3 0.015 0.075"
+	"600 300 150 75 37 18 9 4.5 2.3 1.2 0.6 0.3 0.15 0.075"
 );
 
 static struct attribute *rm3100_attributes[] = {
@@ -272,7 +272,7 @@ static const int rm3100_samp_rates[RM3100_SAMP_NUM][3] = {
 	{600, 0, 2}, {300, 0, 3}, {150, 0, 7}, {75, 0, 13}, {37, 0, 27},
 	{18, 0, 55}, {9, 0, 110}, {4, 500000, 220}, {2, 300000, 440},
 	{1, 200000, 800}, {0, 600000, 1600}, {0, 300000, 3300},
-	{0, 15000, 6700},  {0, 75000, 13000}
+	{0, 150000, 6700},  {0, 75000, 13000}
 };
 
 static int rm3100_get_samp_freq(struct rm3100_data *data, int *val, int *val2)

base-commit: 39508411b82d4dc29dd245bb471ec9ecc1111c9d
-- 
2.34.1

