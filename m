Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3EA6FC5
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 18:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785178157; cv=none; b=AuLwD0T+SAQgqibBpj04oqDtNPT2S4UNA/EZuxSYe/mDSeI0wPjMgq/zzbx5hJNSTDElqsk6YHGp98/AAgGfzuPBHt/pipk2I1K/EX1GRs5dzCRapGx/HmGpRPeVwFWVzaZIFKMHEBqv8ryKBkGuWW4k/DnSvv1TdGw0O815Xqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785178157; c=relaxed/simple;
	bh=fiezkaJGJxXczHYOm/sTNZx+Hl7nM2Yt2kbRzZHMh0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oNU0f6XT3eSH8QuitS/hVCfbfb3cLqGMJEfWR3nmC7QZ2inTVQwz8SsOaJSRq3+iyNXi0Q9egbWphhfTZ7rNAJIPRYgI7mnstr0acdZICgZ+DOqjAeIbWd/01PsWAEGaoiBNdPmLC+Yxz3ZMHhHXmXF90tvV+lY5InUcK5Fivlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RT4p5Qb/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RT4p5Qb/"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cf52d15d88so31218895ad.2
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 11:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785178155; x=1785782955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WISQE5wCB1uVyIS21pc5n1TL5kDVY/0ueF6BiECd4fI=;
        b=RT4p5Qb/TtLtoP3xmrHfRtQMA1vTjuyPUMBcq55QmSwtcKu5WReBfn+arxWCWQv32g
         6uvohSHk7fwTmEKjM6DVNEzQ5hhY3Hkcs4lMeVxABsINJzX1gi7M8zlYM8cLpznACg45
         Wb+0BGLXvulUXaPBTo78XKIS8Fp6wH62zb4xn4BWJVmsR/wTplHU/zoq+a5PqmK9ZeCA
         h1kzXuSa8luwMnDtfccFrpfyh9vjwtkHMslwWwvBmP5ZZzi1Ni8AfXIpHg4Bh6L7n3bo
         5XlcUEmMblpaJkaHKTw7MCs5ta0R6XKPDGoTtZ9/RHX//dFYRNiyImF9q8diakJk7z5I
         2gVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785178155; x=1785782955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WISQE5wCB1uVyIS21pc5n1TL5kDVY/0ueF6BiECd4fI=;
        b=hXqFzTe5H4FJoPfP04vpLtzfkEw3JlVVUVQB5wfcNKj8zb5qx6SDCX9/kZ45hbW5XF
         AgQUXShu2CnkEmbGO71OcJGVbSSND30uVW2CKhuE2/1NpJgn5MMDI3J+feGitd3K6llX
         YiOfQMwLXca/eN6zm3hftrH/0Pq4sH+IcT63hCZLZy8qd6DcU5AnkRkB4x6GKckp/io8
         EtQad00Ac/mwkFkvuHsGpKsQjGabhEWHKXM155HtC11xKO/MtUQvpT282ddevdEuqHSK
         gzDnMqwdd1/QmXaHbuwVxjjLoGAUdGU8uAPKkUreSUWJiJV7acvgpDgKwhPyFJ1Lgob6
         tL2g==
X-Forwarded-Encrypted: i=1; AHgh+RqC9GjUgjB/IGA1XVVWWZ8Gr0zaiGScrFJRCJ5ti/kTOvxpzGOrSsZx8GzKod9ie/Gg0RFCzRCrB9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuKMesJn1hbF3mGAxMe8Xz8vBiNgHceTuOL2Mryp1bUMhd7PzA
	Rrga2Eph2oakjwSflCDz89HE7mv/+0Q8e+PTJNJiVbTSPopKGetcCXls
X-Gm-Gg: AR+sD10ph0zJWAuH6jJTNUP4HL5csqxIOsOMhvec87auSJRAhrGou/YjOezHXkan1Fl
	RATNwePtnHXAeBSDtGXqjRzu7xTLcZW4MrL0P9Rehqyqv0O4AhsXXjypAbdJov1oiQ79SFhXZNW
	IpdnbeZMiDnnnlbJ/3mJ/c9q12hSCZnArh6PBfLrK0b1nzopx2ejvGetvSGauTgHfAVaO3fc9m7
	FXYlpdGC6g54AjRFqeG6azrdftJs2E42dTMzrH7x4rKfT4jjk+vbcDUMejmWoYAHYkGIWNB5hNW
	aVxX49IQQzcqyXWncIlt3iSgX+lcBfOmFJjl4scuGL0UXb9JVI1evod/ZVE8lcl85IsXb3+ssPX
	3KKnigFKHbnu+ZazjMKuGYXjNZgh+1ujb4PN7QvY9ClkSFeFApzhI+1patu96nSiTLZjS8QKd
X-Received: by 2002:a17:902:d984:b0:2c9:b8b7:5d1c with SMTP id d9443c01a7336-2cfde798cfdmr88120275ad.16.1785178155039;
        Mon, 27 Jul 2026 11:49:15 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7d7b87sm40186245ad.57.2026.07.27.11.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 11:49:14 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linusw@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH 5/9] iio: light: vcnl4035: remove vcnl4035_set_pm_runtime_state() helper
Date: Tue, 28 Jul 2026 03:47:42 +0900
Message-ID: <20260727184755.2055414-6-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727184755.2055414-1-ekffu200098@gmail.com>
References: <20260727184755.2055414-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vcnl4035_set_pm_runtime_state() just calls pm_runtime_resume_and_get()
or pm_runtime_put_autosuspend() depending on its bool argument. Call
them directly and remove the helper.

No functional change.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/iio/light/vcnl4035.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index d13c5ff33e07..ce1bd42b0c7c 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -145,16 +145,6 @@ static const struct iio_trigger_ops vcnl4035_trigger_ops = {
 	.set_trigger_state = vcnl4035_als_drdy_set_state,
 };
 
-static int vcnl4035_set_pm_runtime_state(struct vcnl4035_data *data, bool on)
-{
-	struct device *dev = &data->client->dev;
-
-	if (on)
-		return pm_runtime_resume_and_get(dev);
-
-	return pm_runtime_put_autosuspend(dev);
-}
-
 static int vcnl4035_read_info_raw(struct iio_dev *indio_dev,
 				  struct iio_chan_spec const *chan, int *val)
 {
@@ -202,11 +192,11 @@ static int vcnl4035_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = vcnl4035_set_pm_runtime_state(data, true);
+		ret = pm_runtime_resume_and_get(&data->client->dev);
 		if  (ret < 0)
 			return ret;
 		ret = vcnl4035_read_info_raw(indio_dev, chan, val);
-		vcnl4035_set_pm_runtime_state(data, false);
+		pm_runtime_put_autosuspend(&data->client->dev);
 		return ret;
 	case IIO_CHAN_INFO_INT_TIME:
 		*val = 50;
@@ -237,7 +227,7 @@ static int vcnl4035_write_raw(struct iio_dev *indio_dev,
 		if (val <= 0 || val > 800)
 			return -EINVAL;
 
-		ret = vcnl4035_set_pm_runtime_state(data, true);
+		ret = pm_runtime_resume_and_get(&data->client->dev);
 		if  (ret < 0)
 			return ret;
 
@@ -247,7 +237,7 @@ static int vcnl4035_write_raw(struct iio_dev *indio_dev,
 		if (!ret)
 			data->als_it_val = val / 100;
 
-		vcnl4035_set_pm_runtime_state(data, false);
+		pm_runtime_put_autosuspend(&data->client->dev);
 		return ret;
 	default:
 		return -EINVAL;
-- 
2.43.0

