Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795866963;
	b=yPSmEs9eyiznQSjdXupDcwK/gOXOiRlRPSioNN/dhTS6DiX2KEiv+HkiZ1YwkYUvU2vy
	 WbEzvig+s2pHOrYqQv7ZTajNgdDzQirSzPuW+4w8ZknvgXUlkLSU7Sn98djm69A4EH+n7
	 xQEADfynwTuRPKCJptlcwuxPGXJfsc9aDJMlRBmgpYqiIZa1eqSUQt1GX8KucrewVRxJw
	 PoCTbSWsoRD5l4JAqg32pKVWj9RLSq9NEtTxEUIsF7DZwK1/ryJYBPwxquyolHuy3aQwK
	 WO3OU3pLRCjKLQxvfqlaVN3cA1iAvp3qkWjdQDx7Pwn/AJavQFeX+k5K/Xtt7PiYOyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795866963;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=X1Hzhs8fYb1fQ1oUlgenfJRROOf7RMffeqTjveqBOaI=;
	b=ssnOQ0sC2gKrPa/tkit3C5yxU9mslCQFEFTgCpHB1F6kSMfyfMveXB3/s7AxgzjTDpMu
	 Gc1wDGePh5jBRT0uTtJBEtiav+5W3HuZ9g666d5mYjfqaULHvohyrXDye+0nFF6kJ71HM
	 gTjvDzGVYUVjGuXJRoEKGJ4peF6H23eR0ny6Esd2w3nVA9bdcw1t3zDtLgB4mhJZ2vc5b
	 1kB65SxI1TyrkTNvDK5L1JFEPcf/pxpDZFdnUiU4SNPa6Z1IER9cy+MFxe2b3XuY5J3V0
	 Hz+iZCz/aZctN2ZJQeIPLuxzVpUQuXriyikQ6KTOt7h5ylcJ0lITzdQjhUwjN4wVRcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="oy/klHni";
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D694D606A324
	for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2026 11:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D694D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oy/klHni
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-386c4d2e2ccso7313308eec.0
        for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2026 03:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795866962; x=1796471762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X1Hzhs8fYb1fQ1oUlgenfJRROOf7RMffeqTjveqBOaI=;
        b=oy/klHnivdkIkK4JB9jm9eWj/LKK6kc7sZ3NPnjPizJux6HKVdh4vIUuL0qZZlSTY1
         abggi/U9ATsPi/1pHINh8jLMilecWtQP1Ip14CTJ5E+PoEqlpvB66yZA9ezpzFlYfn7C
         kN3s7H2ZKVLsyWcDrEjLWIpLPWxXUMW10v24ZZ5xkOFLzgbMWsYcZ5w5enQdt1kHrqIx
         sjWXkOHJmAxftvqOsSaraFP30Cq9a4H/ploNhKVO183VVtwxuq3+A4UKM8xO2c2sIkfY
         ALAdAOuYOAHGhpbJaQw/RZd5lPWNxJlV79cDpY/7+3Nn8wB6yprDAWJsxjkVE2cA0u0j
         jh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795866962; x=1796471762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X1Hzhs8fYb1fQ1oUlgenfJRROOf7RMffeqTjveqBOaI=;
        b=BTENRDyrkciZrFf+RM2yUgiJ49RW5jVD2i5ezlV8O+VSrvBM717ddX6+gpcdAFhQiB
         sHoXEWZ+y89D+N6mHGalsLeWZfl+ndikhWHBkCNnszK8AzYvjrCvEDdiDBbwp9nKiqCH
         JvHPLyByxaH5CER9cpo0aPCmQIs9UIdLVgKNS28fHbiEi54rmVpImw7qmLIYCOrcD/76
         1MVNrtxSaORenSJPrBDlVxt9OoAtS35gh2h1BkxYgL05VKsKsNWqu4PN7HLb81PSABDr
         5FV+tf/RVnb0XnN6HVw4GLDpT9KeK7uGaUqGcZDs7u/0kmq7+ag0l5BJWdhmCs2C4aWw
         bwig==
X-Forwarded-Encrypted: i=1; AL+hErF3RR0/SBexW6L+UTb7SKo5xO8LFW2c9kHDsH/DL2cRYVZ/++GZtfGc2xrUka/Hdu8xBV6mJKaEOCY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+xO6fx+trbJovElMFOKITL/OW4SLN1L1FR5io2wuxi88oLIBut
	DLnOy9awScG0TqRVUOpImfnxojwOe+9jpJ5O5teuk2GnWxSaMzpboMr4
X-Gm-Gg: AZFdTZftrFxPKNHbzYX9tvAt3HCh89nwulNcfqqZvED/tJS//lwBnAf8TYh1s6LRcY/
	9743jOLUoKuB8h7CgQRQYyj4YEHr5TfB5b2XDq9gTm0+jw+RFujMTrArMzVR3KlLB1dXsgrmmVh
	wtQyf7QsLuJQk28ln6JqxJaSx97Yymf1z80SIs7KSVViayXGyf+CJbzPvr41jjgRH9wfUntorqP
	Bz/VUeDo3ZULYkP0U7KZOS4ViS0ED9Z0/UMvnhySZ6VDvVmPg0ieqrHgRMZmFhRkiO9jPg5eDkG
	ezSUOAtHK7ibB5EQv4fFz8Vatzt5za2zOsilKJTWrCliYt9DjNs3uK0B51QbYxowDABAexhYAjN
	mfk414q+jm8vrteuq9TXHVeKS58jFdG6dhE5VhDtFX5mO6syozu9+bJ/YqZdzuDygWZH4uQwHQK
	AvyeZlyxmbN9KV1t1WJ0sU27t97MxBBrXEqFnklyR93YnSqu4dpBBJde3QSs6Z1oFfVOUIy/MSG
	EOCNRkSF4r4GUo0EnNP3rEjoZ/MRLrg0tyRgvObcjnM1rXops179bJUaPdT3BzEHQr79Zw4qSZc
	SR0KGQPWMx4+Z5RkfbW8ntGh1Lxk3RZoQyWttWaN8ppP8CSsAFaQMZtcwL1NO2lN0vbi+p1wCN0
	XGQcvV+xV0Y2AoDWit5+DBbTl4+ALM736CzNiRJjGO5E8aE84vS6f4pUk7c42dnMTTJ7BIz/Gib
	Q4Y+ZWA3DzSLtnd57cIRe8MYBNNu1Q8vIFqWv7kMOwPg==
X-Received: by 2002:a05:7301:182:b0:386:b4db:74d3 with SMTP id 5a478bee46e88-386b4db7924mr17117493eec.21.1795866961878;
        Sat, 28 Nov 2026 03:56:01 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385f68bc0adsm76783178eec.13.2026.11.28.03.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 03:56:01 -0800 (PST)
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
Subject: [PATCH v3 3/6] iio: proximity: sx9324: reject negative hysteresis values
Date: Sat, 28 Nov 2026 17:24:51 +0530
Message-ID: <20261128115534.558478-4-kapoorarnav43@gmail.com>
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

sx9324_write_hysteresis() copies the value into an unsigned int before
comparing it with the threshold, so a negative value becomes a large
one, passes the "val >= pthresh >> 2" check and sets the largest
hysteresis instead of being rejected. The comparison is done in
unsigned int, so this happens on both 32-bit and 64-bit architectures.

Return -EINVAL for negative values, before converting them.

Fixes: 4c18a890dff8 ("iio:proximity:sx9324: Add SX9324 support")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx9324.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 3f2f15d237e9..ef217f055472 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -646,9 +646,14 @@ static int sx9324_write_thresh(struct sx_common_data *data,
 static int sx9324_write_hysteresis(struct sx_common_data *data,
 				   const struct iio_chan_spec *chan, int _val)
 {
-	unsigned int hyst, val = _val;
+	unsigned int hyst, val;
 	int ret, pthresh;
 
+	if (_val < 0)
+		return -EINVAL;
+
+	val = _val;
+
 	ret = sx9324_read_thresh(data, chan, &pthresh);
 	if (ret < 0)
 		return ret;
-- 
2.53.0

