Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93D936E488
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 19:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775849874; cv=none; b=SrqhTpnwUKSdTb50Sy1E0UOGOASpM9nmurlWYHCZ+OgTzoo0jRBj+UvJ9qwPeyfmsQOLifaD8Bz9SO+PZ+/zHVNzP1ZOHKXkzybbY/UeTht+sARY0RzOJPnMKYNMqc86mrQlIIFJvAMA0avqWJ93Bmy3t5ZlgJI3X+ZPFdThUCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775849874; c=relaxed/simple;
	bh=fMAwD2I1nqNHxQ/MJjBKyjiabc1gUhJnTmFHU2u5apw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tw6beOZXzEwerKz4PsfaU5lsSiLvUqc2pZ3MyYE2b+v/hkWQ1eQjETko14azT0vyKUvi1/N7Ut5OxrAVNg7BHXk9ZNLGbc31oklJi1qvglLB1GE77iwWYPBDxWszpX+hDnoni1UCvwY2EPtZ7ARAbRm50/xUWovcciOMi1k3us0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aq7UaBw0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aq7UaBw0"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488ba6366a7so29879655e9.0
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 12:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775849869; x=1776454669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVJ9H0mtBpp7l9DrW0xwQzYltqQ/fqPBkzGQcJR7/7s=;
        b=aq7UaBw0oGu9vxOT9962bhPDJapcVR0TYUxgj+fUctB6wmwsqb3rytdxKlQP/4HgfU
         t3KftN8ybrQyJEHxbjuUAMvkimeDEGa+AybuPwfEl7M860H6od8SiJCe+RHCwD1R7Y5h
         P6kfiYZc5Zm3mbMdAV2H/TI/LHS3cYayAsm2X11kttm8/pbTnq4WiZO4+nXixiEVDBgJ
         q5m6GwkTyDpC1xkQPbbRS2GForB2ySsEStL77yu/5RM/3tr1z+6OYdAFJjcqDs3bU307
         rg4/p0rYLEuOiJSJ6qVk2pN5rTO57pIYSUTk8pDu57hikasthkLrq1BAv9KXO1ZPEm+G
         1AzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775849869; x=1776454669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IVJ9H0mtBpp7l9DrW0xwQzYltqQ/fqPBkzGQcJR7/7s=;
        b=Nu+wUoG1Dlzr5vjol00jslBtmJbrN9JjBfonpyjp0+/tyCo4yYtCYqY15By9I5WHHW
         7CRrZj8WIjk9pAXjwpg02EkQAFj4+z0HSKbeH9jt/4Sro5Ui25gcrdqupQWRpD3cqvPW
         Lm8zY7p4UbvljCINAQHjj9NmlWrXMGEqjeZY/rJclMmyw8f5yE1j0kwEb59CMY5RL10z
         iXmd0oJRvmXZp2J86c5VtM4UYJS3yC4ICk0CtNtLOamm1bbWXrDQsnudneGfn3SB3APN
         qHJceA5iXHysITvjch7YdbSsu9s0LpKKOzucIg0HTg39o3tj39QIL3UkKZqnQ+qOymal
         vxOg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ/DHbgiZMQD/NpLWf4DikqbqPi3YGCv8KRCllb9GlqfdwkLKt1yAQCgS3aEQifmQGlSAZjsEovQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR7V3G11WXoji/gxkOpzQBXGfk+ZWYWOQiV4LHWXUEQTQcx7oJ
	MJdm6qOMtJiZzvkHvhd07mbYHSQJafzBCERL1eQep83CIxs9TBIPpwO0UpRfqsOpKTSgKw==
X-Gm-Gg: AeBDieu4E0plsG2mEhOLlQLRXluQxi9qlDZUCXkNlRPWXWch7tXpvyCA5EuPYXpEWox
	+yY3sOhSplzyIaK9SZ4j75mpaq1q9R9svzstj1G28HUbACe/h9x4zpWlj4dHtnCMnbR2MkuIcyz
	PhjZgidVUMr4SYQ6NvDYOdqbqE1yNBKqvkjYpGf7vH7C16gzEdRxDw6EsnndYbXwdE6CYXX3h7p
	wjBQVBMmw6xOLY/K2c+B3EN1UX58MCNEzKdfy+s7ckk5SLPyg4DovUP2VH5xzjGoWR1IYCmxMlq
	jcRowc7E+eX8wUrg3BLMpX7lxuOoniqUQcon5OlUgcmpXYk7gkMP8i4lr9PvMxshQogmC/wKKN3
	VOER34cArbpKec7+YzYszq+YTY8JsDFTxr7mm4tpgzuyBIRaOhaTY2K7htiEgbupLQcBO7VzxPU
	EG8RrTQYpLSuc+mYhmcqHYhPpgcnt0s+TLA6POngNWxBePhaW/TeL3p/MTm0vqS1fLaSNdU0K7G
	roj/QQCCFy0
X-Received: by 2002:a5d:64c9:0:b0:43b:86f7:2ed1 with SMTP id ffacd0b85a97d-43d64235d0bmr6763555f8f.8.1775849869021;
        Fri, 10 Apr 2026 12:37:49 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e50044sm9690425f8f.25.2026.04.10.12.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 12:37:48 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH 5/7] iio: dac: ad5686: Use devm_mutex_init()
Date: Fri, 10 Apr 2026 20:37:35 +0100
Message-ID: <20260410193737.35905-6-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410193737.35905-1-devnexen@gmail.com>
References: <20260410193737.35905-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_mutex_init() which is helpful with CONFIG_DEBUG_MUTEXES.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/iio/dac/ad5686.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 4b18498aa074..9a384c50929b 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -494,7 +494,9 @@ int ad5686_probe(struct device *dev,
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
 
-	mutex_init(&st->lock);
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
 
 	switch (st->chip_info->regmap_type) {
 	case AD5310_REGMAP:
-- 
2.53.0

