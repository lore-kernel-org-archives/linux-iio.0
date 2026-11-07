Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050252;
	b=O0Xljv4dmo5x4gS4LLEBeZm9xqcgUZX2g4aEUc8iz+uRCWZTXYK/hHf1ghRqyzkxUeB4
	 ajRmfdpvZ8a+WwWGGvfDnxyNKunL/g/OCxIjV2K5dDbXyUSOR7MZ7F6+q1lRIIB+CvpgM
	 pQsd5dCkqumkyJOzO2LZjfK9lTvb7YsqtxomYah7FsLui0xLgC7PJy6O3dj9WB9QfDjXo
	 w332tYq64bxJl4zUKIbU2jEAXeq+/K5UNyt0XrMQFbSoaccOkP7lQhDS95DoUEFOFfhwu
	 yKyU11fHUBbGsiSP3uMPNCOQ+ZC35+tH7FacNU+52fhD9ulmHWckGg4JbKew3QRGuRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050252;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zaZSGZGlIIPoCOd1I0ste11xtmQPi8WmEaIUIAvrRn8=;
	b=w6aCUCqBSN4soEpgpv7MDoB/ZXRa4r9XYGydSBDlsaWdJQ/EoycU2PpUWNxcjTFN7TwW
	 nqwZtv2ZHAFRX8dYaZKjC8/wgFM0yXwNzAQdFAB6LZkMN6hRaES4IigdQhEePkBzJ5pVk
	 bmQYILph/h9qT+0SjkPj3lS9GcsVGxn8vNaYNsHKopF5R7/JiLzHJiSmIoVw+xciX8mEg
	 6FLO8nxLiFGKxoae5lwTPJMm4aZ5kWZ+2dCN6JkxSv2gwE0tr8as5ufAYieKMLXoYV+s9
	 Z3KmnT4KEbZWDubYLdZn9MwCenNvZJ1Bm8vywkQ+mlMw37m2EMi/QBD8f98PtXjilpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cx0p7bDA;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6713606A326
	for <linux-iio@vger.kernel.org>; Sat,  7 Nov 2026 11:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6713606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cx0p7bDA
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36e795af1d4so411266eec.1
        for <linux-iio@vger.kernel.org>; Sat, 07 Nov 2026 03:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794050251; x=1794655051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zaZSGZGlIIPoCOd1I0ste11xtmQPi8WmEaIUIAvrRn8=;
        b=Cx0p7bDA3F8PbgKgZFuQLORgMamvoHdpZDwGVHJOu1VynlCJsRppkzT+DduzZs3f/A
         luv+JhYbCBICt6ovhd/jYYzWA32azLdiwpjS6cOZ2F8HzP8N5JTCzpm+RSJnsLkd5iTk
         BetYDQbMfipGXaJDzqdzBEVhya2MfMyo64ryYp8UySXsHowGzhNYKcE4VjtGIWt7EVHF
         Z7IYnIodIXoG+F3vRCIJE9SKhuU8uPM+li2k/ZdGU0iJ4o5X0ODQ7YMir8tBrW5nXudr
         uBSS8ObNLHws+lt2r3WmrZYZcr3J/mj6guz+PxmwLlDylDtauBPbeqrhswh0njsopGea
         G1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794050251; x=1794655051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zaZSGZGlIIPoCOd1I0ste11xtmQPi8WmEaIUIAvrRn8=;
        b=TwQWVxNKAAYC6gGEnSg3lH4Fhsooog43nLCTjKIyroHGWQe1KW5nFBVBUFv+nNKtWQ
         ObvWNXKO6s8Uf20INeIC84IjPhFCIsXTaSsAhGfoSEDCg1sy/5aHj3jpRrk/g4IGCm7l
         X9MbL4P5mbqq0l0c3l3jmp/FFH7P+ETmGx6TCwCRmdAVIRQXxXMrVt5p4+hlg7Kba5Dh
         oQvywbRT+qVPYxb8opfcpJcgEwwfYzOV4yQMewnVaFUMIYpW+fCAcJvVu5I0x7Kb3RMI
         6W4LPadZEJE9r7ibJrtoiuWxnpL+6E7WX3k4iFpracwrJq2XEfpbvwglYoTdpN9nROgN
         qsFQ==
X-Forwarded-Encrypted: i=1; AL+hErHej6FFqT+u767n54Ev8gj5iq0XhRUaCh4U2SANZ1FYbRL0W2N2WoSB3TxURD/yjILBeHa7FsvNQlU=@vger.kernel.org
X-Gm-Message-State: APuU4Z99dLxQ87J41PrSHyCAgeyd04zmH9ZMkm7Zs+k2GyFI7AcsVr2O
	GnaVKUJg+QO6qDZqWlG/jh6F9dCREmDtphsIva1coM6T+td60rAzwdKa
X-Gm-Gg: AYBFou3zSqx9O+sSdRD2WQQ+UmkcF1yTOEJ9vku4KAuWqk+RjLU8NeWkmNyUoGXHb8d
	V00hQ0AFh5uJPx/FkGUNxIwVzt2GfKDP3ZzXVRRZc4EBZrFZnUsFvtBFiB/kUgc/fH67qgL87GF
	oZQQ3RnBGzt+Q16FfMN15K6D0YSOJERSvY1rN++zo/xlWO+sQml+a4y7HwQO7LoZWMUukVa839B
	jwpWh1sPq7O6cfepvHdbAh87xgmLQjRujWoQIi7TCu7v8xD3cj2KpsAlt6DnO13Vc+vf/k11jC9
	AczHb88WvOUDAxP+pCJZxj45ce9WAZqRAsAk+7G5Cq5h3i55kG0SLq4Iz9iShBbnvyUW/UJkJv5
	nl5d6gpBSkY5ak8G33zj2NLadHBn6I4HYVWFDEKIDq/xS0YqtVxhX6L3pPtsOPjR++CnFvyu4kq
	4+nCMdSsmgmvDblSLK7R+4E6sV8NRBViNhq+JrLhKY2WAzkVsW2fRdTsmq5uI4PiQtHkR4xE8wi
	/XrhcoEOBnjzd1206ULZxlhbhQ3oa4rkQXR9riL+XYkn0KPeKMzbSoczeN6hFJl/t8T/PvZ4hS8
	p0bV5WvLZrOyEabzbKoUXTLBVb5XTHbCHACz9zwI3VuVtqXnQX0P+SvTd0bqx0w3TVKQR3hDNmj
	5ikQz76ivor82jbA7q///yDM4dbKaXeVCbOHvyWiCBGOHAXpadrYdLU+5oFot5IC4mFo8Lq14mh
	IcLhOHU5fzxHhj23Atm6bWZOZNnIdlX8ibSshP+BSFo14=
X-Received: by 2002:a05:7301:719b:b0:36c:a39e:fcf9 with SMTP id 5a478bee46e88-370f5150135mr2891995eec.8.1794050250700;
        Sat, 07 Nov 2026 03:17:30 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9fd0000sm13284120eec.21.2026.11.07.03.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 03:17:30 -0800 (PST)
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
Subject: [PATCH 2/2] iio: proximity: sx9360: reject unsupported hardware gain values
Date: Sat,  7 Nov 2026 16:47:04 +0530
Message-ID: <20261107111710.442318-3-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107111710.442318-1-kapoorarnav43@gmail.com>
References: <20261107111710.442318-1-kapoorarnav43@gmail.com>
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

sx9360_write_gain() passes any value from userspace to ilog2() and then
FIELD_PREP() into the 3-bit PROX_CTRL0 gain field without checking it.
Only gains of 1, 2, 4 and 8 are supported (and listed in
hardwaregain_available), but other values are not rejected:

  - 3, 5, 6, 7 are rounded down to the next power of two;
  - 16 to 128 write gain codes 4 to 7, which the driver does not
    advertise, and the next read reports gains of 16 to 128;
  - 256 and larger wrap around in the field, e.g. 256 sets a gain of 1;
  - 0 and negative values write code 7 (read back as 128), because
    ilog2(0) is -1 and a negative int becomes a large unsigned value.

The write returns success in every case.

Return -EINVAL for anything other than 1, 2, 4 or 8.

Fixes: 1cdb4c47f7f5 ("iio:proximity:sx9360: Add sx9360 support")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx9360.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index 2a9b37df8f62..c6e5b3e557bb 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -625,6 +625,9 @@ static int sx9360_write_gain(struct sx_common_data *data,
 {
 	unsigned int gain, reg;
 
+	if (val <= 0 || val > 8 || !is_power_of_2(val))
+		return -EINVAL;
+
 	gain = ilog2(val);
 	reg = SX9360_REG_PROX_CTRL0_PHR + chan->channel;
 	gain = FIELD_PREP(SX9360_REG_PROX_CTRL0_GAIN_MASK, gain);
-- 
2.53.0

