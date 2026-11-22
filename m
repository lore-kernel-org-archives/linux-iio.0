Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795333637;
	b=EmMjrX/GeMRq9DySezAHsEa9kbb4RrS13m/Tj1W6Q8KMwwjNMiFikpZ1wO+ENeXKeDHA
	 cCYlc8GqIJxx1bT7EQ0rMefJikPef6nhuea7ibB3VMcM1ZPWlndetQIaM45cXWkaYMj9O
	 wbemSp5L5lc0l/qCogOXceDZAg1RpmpR++tazKo7yS/8hCwxjnOZaQOiQnCtLqZXIxhvJ
	 vvghsHabF2qbX73EFM8ajHqQH7+jtJg2W4BMwQ8Ri4D2RDF2/Eb6kak7YifHD0aAnxtNX
	 bOenAJ3MrhDXKkALuHqoCAL4VuogeAzt5e44d8arvk9UFvNgniGEtlNZsSUVZB7Zpvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795333637;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Qh/0vpNrSDEiGO0ko4VAWXQlYcy1VNvUoAPW9UaESQA=;
	b=Nh+v/kFMg/yn8oXpSleJdCB3X/CWrJytkZ2bugGD0VSMAJfY2WkAqtUiJIGbo2xSKjC/
	 3hTdcpa+4IUt78QEA/jd9OftN4v2xB0T/WgI0iRZH1RKOp38HdGQkHkzjysHxiPwSboCi
	 nuc0nobBLrv9YGNW+TayjeFHlsRLc66HJZRTlOJu6K26BL2u/iO2AIpzQJe8S4VzHljOe
	 2gcgjVzTWBUzItA4b6F3OzQYuELya0w/61OuWPhGShvPZan5ZO+/dKkBTxnr1BITAiFvO
	 JwRqS5bc9b4Mcl5F3epS9LToJaYfW60djrAaxVgEUiALUcqF9MS7Segl3tBjro2zi8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gUO6YFsg;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD06D606A320
	for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 07:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD06D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gUO6YFsg
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-380b40312e2so5263644eec.1
        for <linux-iio@vger.kernel.org>; Sat, 21 Nov 2026 23:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795333636; x=1795938436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qh/0vpNrSDEiGO0ko4VAWXQlYcy1VNvUoAPW9UaESQA=;
        b=gUO6YFsgVInPkq+IHrqj6D1z9R1U216T4pEOCjMUgzcFOgY3gWsOIj+S018b/g31Ji
         IX0VUXdq8aihKF+5ijdIE22fdlPaJD7axF/ITBR3eOLm2mvwZyLC2b3zrcqtxh44c59p
         /aCvN6McHAKLu+mu9EmFLGUqOhOITihumX6JzytvBF80O5DrKU2NW4HG8DFlfDghuT8c
         k6Bvig6VSAKRxa+sRt6xEe2rqcTG/VtD/BN+TKLCTqmXGGLQueNp/YuY182F3dmfldJz
         qexMOav5RQoIuWJjCCO5RaAj+nMnDZptkpQG5cEyUCN2BHxcigbonbTxNT/eijq/iRbB
         SrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795333636; x=1795938436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qh/0vpNrSDEiGO0ko4VAWXQlYcy1VNvUoAPW9UaESQA=;
        b=iS0e9rqtREuP33Cer3MBnr4G5vMWwefQjgU/94PqJSX6GAhl88Kb3nBYqMkdcavXVV
         xpPvrjGkLWQ6YCU4HRyDIpblNHrEYlO7m/CVV2+j2jEqqXFCUD8dbkAdY2ez2ELDCAGf
         GE368OXhkhfvoV1+wzhAfUVUJSp6pxj9sNyiZfVVoT7Li2XdgM8jBG11iCdWJpAwt1ii
         jdhKpixkoQPkx2liyxOC3l5za+sek+ZLTqcfKAymOw0uaNoIpD9x4Z0O9XDL79LTmANW
         41ICV9GicvDrAHK13sTTq0KmNeaihe0xQvlJO/40V7vyOuy/xGrsiKlblubpTU4bEnv8
         k3ng==
X-Forwarded-Encrypted: i=1; AL+hErH0j9X//T5XZfGJRt3YgP+qQn8Q+2DZ31R7rY4XAED/KoBNvBkMTEED2pePmfAQHYrWI4anDOrpDp0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+gilJh5tqHigaVmI8jflcrmKrHAs+PoPJ/JUb/EHFSeL0ZRFe3
	3Spuhl1/EchHLDhZWeZ5+cUsl06K8eWL6ZdL/baDAjXMpgFFrgTaWgEi
X-Gm-Gg: AZFdTZfw3eGKn1i/OHalTlR2C0X8dYHEgrRtQyY1hSPx17CiRY+YNm/CGX+OVM2TXFw
	pMKnqe5RHXqHbbRrMVMRSWGSWHzDW+fWp86Do8YXploA1LBZbgLlMbmQFbX1HGZ7rISCXbLnzyT
	QAAhG1y+8Wp2puy+yJdr8hNUR0xTi4K8OazF/Cr7beo7KHD3MItUOK/un25nuWltRQbZvXZnvMv
	PaJ1WapO6fVst5QQ+a6yXJ6giBwFQ50hi/eODfoObBtoI3Anrtwvnt/c8qjaVAewRsk9gGOSJsW
	6MAGwQ4tWxR41w4Cf7v6fXsw6B2fJcLLWEMfmvsOG5YDKlfm6GS6P/IzhbO05D6YIz2enYzJ7VN
	wdmIYsuG3Yb2Fm9B8bswSLug/odRK09iutdhXeY2F2Ga5K2OoIzlAz47eMr6s9KRJWPZMP0V5AC
	BfLR7oZTbVVVt5vnMlDM0IiYIK8hvTrdwoMI47xEXVz+NAX5dsPrNBJ1T8IMxFUqXIJAs2yFcYP
	J9nw6ZYwiZa9r3C3lhBXkpN5fxqlTcYll3s6IExn/l8SYVewV1Df5lX8ny+lBeXsVbL06Qgt97n
	0SoB5JxW1K0+1DvL1dfCr+RNAWYfAFElnnKkCZhMUtcGC/fdNJYS2nHoPaCyYhoxrf1rhFc1le3
	avjS2f/21ZE5nsVBDZwUjEqPAdSou5rvgfMtDLNgWfXpX1JWBTUW1HN7cVfU8xB2qBRiI51t9Ts
	domaoPWf60KIbXuZEQl04ArwcBmLYOuJWnG/WQatY6Xg==
X-Received: by 2002:a05:693c:41d1:10b0:386:9d4b:9403 with SMTP id 5a478bee46e88-3869d4b9723mr4003911eec.19.1795333635762;
        Sat, 21 Nov 2026 23:47:15 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385667decc2sm24898071eec.9.2026.11.21.23.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 23:47:15 -0800 (PST)
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
Subject: [PATCH v2 3/6] iio: proximity: sx9324: reject negative hysteresis values
Date: Sun, 22 Nov 2026 13:16:43 +0530
Message-ID: <20261122074649.239441-4-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261122074649.239441-1-kapoorarnav43@gmail.com>
References: <20261122074649.239441-1-kapoorarnav43@gmail.com>
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
index 57fe78089167..35f0cca5ede3 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -636,9 +636,14 @@ static int sx9324_write_thresh(struct sx_common_data *data,
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

