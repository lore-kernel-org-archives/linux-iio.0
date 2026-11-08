Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794101665;
	b=qUMeo7sgHqG3lRzwlRLdMEM6qSFe1nipP52YT8QPB774dgijJnCPw7ZWWcJwzlZeCJAT
	 ZKueikimwLUBOn2MTs/MeVFOgdM4pl/ZdlkkvVKysud6d9sj6FaYFW/BhSSXKd4NeBrRS
	 pxqSbjvvBZdWeBbXSACJhELya8TX7VHOjrcQwxHF4+eMclrWC88Q2r/w2dg27s/bRz5ou
	 Vf0aKRX+/KcIK6enCeXCJDGIK2xy3P6njPjRp8ekqV5gGYj+XzpuxtYwJ0DBQN2kykNxZ
	 aBYkCjGky3kBS27deJ1Zno2LZx3xCzlVKKe7fOhf68s669ZrcMJ2lOUfT+e22PSW1Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794101665;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JGXeoEcc3kDlzKja01AIsaye9Z/+QuBp1KBLpsLMndA=;
	b=GEAqL/1yBhZD8p13yMwWh/nsZc8vcUx/5Q9JvVBLKY9i1qq9pgq5HqKJZvXr8mZNMSQw
	 l6DNZmHF1cANntxP7byRflLmK5kwLUh4S2Q89JxEDFgXIK4a5ERS9mlWZTYDO2EA1uPRE
	 2SDXtKJs7BbhEwnHLocr6ONapbSHMnsCVHEca032MfeEJ9bNK2FRxPMthjgWxdEt15Wh3
	 umNn93F//1bcTY/Qjx5UTLJRjB+waRWg+7/s7c/V/uLFfuWWSKzK8YGNunhfwFMj0/Se8
	 2lSYi1Jb48BwVRz7rgL8+ZZvbdK5sSlTxc5exVlIcvVgcIrm1HNKh2IOjJXHTbkLRCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ByKYzU9H;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED310606A330
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 01:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED310606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ByKYzU9H
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so817405e9.3
        for <linux-iio@vger.kernel.org>; Sat, 07 Nov 2026 17:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794101663; x=1794706463; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JGXeoEcc3kDlzKja01AIsaye9Z/+QuBp1KBLpsLMndA=;
        b=ByKYzU9HB5DT/i7Ko829srtaxHhCrNZi84hheOwMY/9oJ2W4O1VIM01DuOraqtoTuX
         LE0SbPtd0jXqd6gQbXxGph0tr066fVgGGlZD0nked4HX6OPrXhxCyFyP2yHGeuDFPvsP
         mvFsasV27hKylXDrJh79101nD4FERPbSO0f36W8nQ36EIdcEkTKeM9JT6BbRPhPf77GL
         W7GBY3j4NX0I045bPbzfceR7rzDUtBNslNf8KCI9kQMpqFH1DEB3GnSNEBWEy4D8l8Dl
         oj6RUtgP/jXwFRVqLffZvmTUsw0eG9xLQZcOfj1OvU5JOg7Ki/7acfX5nZNIIpcDYIL5
         8oMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794101663; x=1794706463;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JGXeoEcc3kDlzKja01AIsaye9Z/+QuBp1KBLpsLMndA=;
        b=Bz4358yqz3q6rffYDX+JB1vD/sbdnb2LZh6XWluG8hR25cj2MZjO3Vr2GfuSPyAzJC
         JTBJMMTz7j+8aaVryKfnWE4Gem5TmWoCjCZVHBmPnp8S3WfgB/XHaQZEPwK5Oo+FTS4k
         VrUPNjdB4MhLN5gcn6l9vAFCf047seMhk0abkhDksn7aXNUVaY9OFsgr9S4Ym/lvCyNl
         wYOd2LSUtsuk6pZJ/lmwy5kJ70ObaSaPefBfSapcCG1Cu5eFyqla0xr1iYsEcxyLQCjQ
         AxinuWBAslQRmL4raOl3dpgx7LssNAmCIYOBVZg7c6x8fqF/YaI/K6dHHPNpbyjrfgMj
         fDNA==
X-Forwarded-Encrypted: i=1; AKwUvBzsHgRGKCEUQ03+p/FwNLyEDyZmdjURNIQhiJIWggEJtbiZXMssa3WrmPzw2u25DB/cPj8d6RzCngE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9F0qJ9OM7qbdbrjFl1+K7yJq5ya9Ycxbfu5s34Wup1SPnLDrbv
	IMYBZbDR0GU6+Zgj4+aZMzk4HO2y7AVHE5cIKDHFmRFRx5ifxD3lfKHG
X-Gm-Gg: AYBFou0xI4Xn/oCsfebl6hdI6fTTfDEdtECvYK4+UV5hVNAKqnXppK5TTboL4kcSNtX
	fCcSUpuH3MTbLAR2r+hqKN2ciCE0biBILGZeSFNyMMVUHTVS7NVmeDSgLu8qlUSwgbD+MPdZ3Es
	LV7dxuNJ7FC2Wg5LyjskMYHrwzW3gSn+OBbhD37wXpz/hRnJSicHNrNQLuEBFwyqX3WqST0Mosj
	3uO/dGCmaPZpirkOnOTQl0Bzmtt64f6fz293n8xbIctjIIKdkPvSZ0J8kysGzmlHhpEYUNgyesc
	cmIVe2OxJOttgbajtwa4ivOkGObYwuSuuIypONjoE5eTD8/KGP4hRz/IQDfq1ufq0nKcuhqq3f0
	RTt8G17q41qXToiCDPg3cS9Lgzn9i4V/XFP0IxudNL5Ne6UB9E5z1HBbPAKO63T1cDGVuhU5Xzg
	zMqqaj2cea14eH+2/tGKk8YI6iT1Bpp79lNIPBQ5xy8p09bocWxsfyZsONyYa25VOV1XvytiFOE
	qxFIYq/ymbtR9TuqAwq3CXG69l8TstDmDQH5D7DMReMcDx4AWMZ3LGj1wEdoJDv+T1KH1xDgSTn
	nHqQfD6aMISt5Cu5TM11hFPIEenc+mZ/hrBuYTtjZWdaDU17ZmFFtvA=
X-Received: by 2002:a05:600c:46d3:b0:4a2:cbe:bec2 with SMTP id 5b1f17b1804b1-4b963c9197cmr5815975e9.32.1794101663125;
        Sat, 07 Nov 2026 17:34:23 -0800 (PST)
Received: from legion.. ([5.43.81.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4959783e39esm1143137f8f.45.2026.11.07.17.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 17:34:22 -0800 (PST)
From: =?UTF-8?q?Adi=20Kadu=C5=A1i=C4=87?= <kadusicadi1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Adi=20Kadu=C5=A1i=C4=87?= <kadusicadi1@gmail.com>
Subject: [PATCH] iio: adc: ad_sigma_delta: use __free(kfree) for temporary buffers
Date: Sun,  8 Nov 2026 02:33:28 +0100
Message-ID: <20261108013328.125069-1-kadusicadi1@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Replace manual kfree() calls with the __free(kfree) cleanup attribute.
No functional change.

Signed-off-by: Adi Kadušić <kadusicadi1@gmail.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 119ddc5a13e2..66aba39f68a7 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -203,21 +203,14 @@ EXPORT_SYMBOL_NS_GPL(ad_sd_read_reg, "IIO_AD_SIGMA_DELTA");
  **/
 int ad_sd_reset(struct ad_sigma_delta *sigma_delta)
 {
-	unsigned int reset_length = sigma_delta->info->num_resetclks;
-	unsigned int size;
-	u8 *buf;
-	int ret;
+	unsigned int size = BITS_TO_BYTES(sigma_delta->info->num_resetclks);
 
-	size = BITS_TO_BYTES(reset_length);
-	buf = kcalloc(size, sizeof(*buf), GFP_KERNEL);
+	u8 *buf __free(kfree) = kcalloc(size, sizeof(*buf), GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
 	memset(buf, 0xff, size);
-	ret = spi_write(sigma_delta->spi, buf, size);
-	kfree(buf);
-
-	return ret;
+	return spi_write(sigma_delta->spi, buf, size);
 }
 EXPORT_SYMBOL_NS_GPL(ad_sd_reset, "IIO_AD_SIGMA_DELTA");
 
@@ -249,7 +242,6 @@ static int ad_sigma_delta_clear_pending_event(struct ad_sigma_delta *sigma_delta
 {
 	bool pending_event;
 	unsigned int data_read_len = BITS_TO_BYTES(sigma_delta->info->num_resetclks);
-	u8 *data;
 	struct spi_transfer t[] = {
 		{
 			.len = 1,
@@ -317,7 +309,7 @@ static int ad_sigma_delta_clear_pending_event(struct ad_sigma_delta *sigma_delta
 	 * shorter than the reset procedure.
 	 */
 
-	data = kzalloc(data_read_len + 1, GFP_KERNEL);
+	u8 *data __free(kfree) = kzalloc(data_read_len + 1, GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -340,11 +332,7 @@ static int ad_sigma_delta_clear_pending_event(struct ad_sigma_delta *sigma_delta
 	memset(data + 2, 0xff, data_read_len - 1);
 	spi_message_add_tail(&t[1], &m);
 
-	ret = spi_sync_locked(sigma_delta->spi, &m);
-
-	kfree(data);
-
-	return ret;
+	return spi_sync_locked(sigma_delta->spi, &m);
 }
 
 int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
-- 
2.43.0

