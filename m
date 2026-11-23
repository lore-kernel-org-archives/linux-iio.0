Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442163;
	b=C1zGUXtwvcNAHXxo69/LwirtSnJR73kR3ykzG1jmQib1PzNgWDnBvFcD5DcuiE/dtzYG
	 zxcwG0TWgFw5BY7G+WTVSEoPex1Tczsbojhjn4gZt17oP08EIzJ7pi3vJNkcS2ZtqdLHF
	 ymGV6dgWHWOnyYBr68EA9AMW53yRdloBUsvWZsS9IPbEWce04soi/PN6eweVdQvGmf9PS
	 0MsXPOAJDxB18P9bJJf69nqd2Sgva/HIV6X8VM0Eiec4d4MutHObJJEc10JjmplWSWfwr
	 ikRVoxqyAGjddOvSlF5XtRnPbwg7NgDOCOvfwrm+xV8x5LavZ2Hvb4bQcOsvdajOcKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442163;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=rc/V0dJCb6+p+/Z0dODRaNY7UxcLqfzdO5HgyNDg49E=;
	b=DTrjnXXS734mXerGyp3HzaFuRRQE12qdOUmLICXNHb1LbEDNrNyUQoLJPpM8VD6wWP0T
	 cgu15UoqivkmUZIBm2PQ7/6jvGzGBYaQCjdgoJ/+7ZUiB58R0eS/FFcoU+J3zQQccfiTW
	 ofzAiwot5EHU7YbybWc+1o38F/UQ9XqO+Ue68X0YK6t8IQI9dDCTidgsPFe8rBvc3bBql
	 X4LS9mxzcF8bnxmxzEEVysHl1ALDYFD9IVZrm2KBPepUy2FNXjVKsvLaqqccX2d1Fn5m2
	 39zl858SGkhchH0lYUdRezl4Sud5/vpgj7auJe+7PZDUvppLJLTf7cNCBfr0tFejUYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="hb/O6mcw";
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287DE606A31E
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 13:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 287DE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hb/O6mcw
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1b5786e099cso679266c88.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 05:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795442162; x=1796046962; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rc/V0dJCb6+p+/Z0dODRaNY7UxcLqfzdO5HgyNDg49E=;
        b=hb/O6mcwi0lIK2EOuTHewZJw22l1B/RxbCNRSTLx+ujEASrHWjCi/2tNBWEdV3Ljh0
         psXy0o/y2F4uRvq5BUNBgV9ZL9Rr8/LuiAGcJGFhiTZCcOdDm6PugNc8bfXtgGxSWRHn
         11+imdc/Ve1A9/K9E65Sh4yp3sIFrNvxKkb64pawKADtreqQznFOkEFxMr/IDqkRZ509
         K6EwgmnDExwmFyr/gTbHH0WR7Oz4GPA4oFxQ5Wms92DCE3JYaADITQrAaeeGqGjsu62G
         PERpAwR/jHvBU6sPOuOo5yZxrW5QT8wvIvThQ1IR28rNCdeouIA8B/e2GlDjYgJ0Ja9b
         bimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795442162; x=1796046962;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rc/V0dJCb6+p+/Z0dODRaNY7UxcLqfzdO5HgyNDg49E=;
        b=t8AJZTeZpJzuutJeQyxobxC3ASVHn1mVfeGD+uAN0nqc4BUyFa+W93HYDk7GAXdlNu
         GKnZg5oGbSivl3nIdgf9oqKXDpdcdGJLTv1mkTC/ZYXWoCXoIYZKNz1HB/8qsM5yFRdO
         t8iNzfGLZGp44ec/3WVHGi1dRD3Sk+JY+c10P6p3bHO9lBvCrPjqzZRdZm6lzySWtTEe
         oTb8X5XKLlbYWUsKuTn/ebcnU2sBXSot6b91DD4Z9waa0cLSAzxI2jFw3DESv2D+9Cn8
         aF7AE2IqiHybNnEoAGJHYzPxNlhRZXQKaT9aaCJssA0/w/+aE3VWoelYySDlExul0vTL
         ir5w==
X-Forwarded-Encrypted: i=1; AL+hErF1ZvJszsUDiZilOS25AirHKL3rCsyKIs1hF4POAeap8ngLGfbNJhrGXNQlMhpFeR4+WYILM9KV2qI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/BK5kO/Llo3yFXcKK1ncjdlLlS5BQouo+424DaZC93sExPxUXT
	PmLl+HOjDiXmyZGlSNOIBaXVNxNLK7Eow5I2mfWHAhCWD0dSgGlbAJQu
X-Gm-Gg: AZFdTZeA27gxyBtHMTVmtv9YS+Qj58llOHlzjtd+Ywasvp55HHF+vwZ155mSV1+7aEi
	2rGSz7PiXfYMlAD4qbvzBZAm7aw1Gg8XGLyVRuxJrxAEOHIvCR3uW9TRV61hCSmXMZFDhgpi7tI
	Xdy1W7t2we3SZ/USsz5EW6O/bEsaSxyeUerixZ3a9EDRTHHTBWJBC96jLGnBJI1QxaYuqh0TqTk
	gY86m9eWFwOionTgCSBlBNaG710sEtW/xrda3lTysCPdiqmyANqbLHyUej577y12UydV0ZyNjxS
	bK0q5PCucHEpc66CrWDw91HCnevOVz11wbgHw4YBO1QQgW9fLXiOQbc5pl+xh/FijyNdmO0OZVT
	bRgWMPWVikHfOQUW2cuer3HrtblFb5whSAvaPyviCxKTh8ATpq0tLNNmOImF/XOVjb6ADDTtxgA
	Js+UsMbqvDT6RaqtMMNRSpcervLob0S/0on2sURII7s1VLUhR09EH/rSmx6h39/lCzTe8v5WPoD
	ZJGz/eRV+hawASbo4vecI2JPFWQ0i0HOtyxtvOwh92gB4+6NbjV0XAMevS1La5SKfcKQBPGMI6f
	AGKnEY8qT7wwTp2PGBKJd7MueTfhkOoETu483ZiZrf/MqPtvluL8vA==
X-Received: by 2002:a05:701a:cca2:20b0:1b5:3417:9bc9 with SMTP id a92af1059eb24-1b5568ffe5emr11099273c88.26.1795442162281;
        Mon, 23 Nov 2026 05:56:02 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b562a82b3fsm29310267c88.5.2026.11.23.05.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:56:01 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux@analog.com,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Andrea Merello <andrea.merello@iit.it>
Subject: [PATCH 1/3] iio: addac: ad74115: check the rate code in ad74115_get_adc_rate()
Date: Mon, 23 Nov 2026 21:55:52 +0800
Message-Id: <20261123135554.2983499-2-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261123135554.2983499-1-maoyixie.tju@gmail.com>
References: <20261123135554.2983499-1-maoyixie.tju@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ad74115_get_adc_rate() reads ADC_CONFIG from the chip and uses the 3-bit
conversion rate code as an index into ad74115_adc_conv_rate_tbl[]
without a check. The table has five entries, so the codes 5 to 7 read
past its end. Without the adc_rdy interrupt, _ad74115_get_adc_code()
divides by the value read there. The driver only writes the codes 0 to 4
in ad74115_set_adc_rate(), so this needs a chip that returns a value it
should not.

Check the code against the table size and return -ERANGE.

Suggested-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
Found with a CodeQL-based static analysis tool that we are developing.
Reproduced in a userspace harness under ASan and UBSan, which report
nothing with this patch. Not tested on hardware, only compile-tested with
W=1 on next-20261116.

I used an LLM to help write the harness and this patch.

 drivers/iio/addac/ad74115.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/addac/ad74115.c b/drivers/iio/addac/ad74115.c
index e27c39b06e44312..289dfdff8f5396f 100644
--- a/drivers/iio/addac/ad74115.c
+++ b/drivers/iio/addac/ad74115.c
@@ -784,6 +784,9 @@ static int ad74115_get_adc_rate(struct ad74115_state *st,
 	else
 		i = FIELD_GET(AD74115_ADC_CONFIG_CONV2_RATE_MASK, i);
 
+	if (i >= ARRAY_SIZE(ad74115_adc_conv_rate_tbl))
+		return -ERANGE;
+
 	*val = ad74115_adc_conv_rate_tbl[i];
 
 	return IIO_VAL_INT;
-- 
2.34.1

