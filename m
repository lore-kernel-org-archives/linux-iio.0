Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5765C367F30
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 19:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775849875; cv=none; b=RlmAXap13SRe9X9NYbakBUC63OJPVJv+Q0gg64GV00v11vgTDN5cu4DS00dpwKX9ik4A3TWI234PQFApjTNY6W/VJOF+LYKRys/LUohD6AAZ9UZm2aZypInVzrJDV2LiODf5uJlcYc95Qsy0ci6t/YcEfNhJ+dLdBiJMqRNbtPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775849875; c=relaxed/simple;
	bh=yJKbJbkAVuOUj3JAxXfnNi97qV0h69lZ3JxIWsmSdkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEd88mULanPd08FrN35vXgIWgE+1ZRDfJf6x7vu3tMDRVuRlfN3pnRysdkux9KiKJm6yz5gNGf7G4aN4nplLttns1WBuVICBI/XEItFUDeu8SSPV11tO6SPPp9K+NYCp3F+KZ3iyrKUiffxgXFw2A+qNiqHQFN77RZ49yQs3jck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3fTJduz; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3fTJduz"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48374014a77so33649025e9.3
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 12:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775849873; x=1776454673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjY89GCkU5DqVpzDvTAfESfcL7GOBsC3+TlxdaB6qnI=;
        b=G3fTJduzvl0SUTlSSvLsQavxKLGLPq33GGO+/LwBjuvF6N3ABrdWiuJiUfJQwCliy3
         TwcGoFt3aPdS1tCyHiPmiq3Z3px/HAQRyKIDxml8TzWFTjlqDl+yVzdT8drKvZUeaxfh
         yI/Ce+KjXJYsb3HneC62f31LOY8UTtWZUKgfl24p+w914f33bTeeRYKR1dKlaf6nESpv
         iI2WxRxD4C3dnIwTym5akjHBAzmPtghRq8ehd3ZAQ2EhYIvo18UN7dIwYnjHEYf0nHoU
         Ir16ER2mQowhR3ndpU6N2wSKSwnJQPkoJYPUzi477/ZP2XOJbpnsO5Iwn7GcrfRRx919
         DOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775849873; x=1776454673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZjY89GCkU5DqVpzDvTAfESfcL7GOBsC3+TlxdaB6qnI=;
        b=sZ8UGG5AmF4foDq6YhY9GdtP2gYIuQebWBpPa6/eeqKVZkCLL8b5x6SHexbDC0/UFw
         yo0A/f2RkiiKOnkHJbiUmRgdeMt625xk5ZYiWbNLdVqREMzSefsZsgZwjHqgQ2I9hv36
         fWLJ/YTPFIpJNv9Xo54UwfueCk4tTWlP4cLpiyb9lAYdodq4PMpa2jeHCBF08vGlfNEM
         9V2enkS5LY8Pl0rt7MUxoI5OmfAj+LSfzSeYfq91WjXcMQwNyByCZ97XdWXHS+8b+CdD
         nrkuFE1jRLTvx+u3DifVLmz5uwNLSySCmMyE2kDDqa0eS7lFLYWHAE/7GBNfn5CAoH5a
         WUsg==
X-Forwarded-Encrypted: i=1; AJvYcCWZCSCaJ4wyCqgVP4mld2V2ue1V2VvFJWDOdoCqfkX18AMuYUfbnIHymVTVXFOJyLst1NivWooHZv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQe3Tgsnv6uMO/ewe9Ud+pWF1fGYCOyqk6RtQ5zgV/D9FAPywM
	NtC1jg2Cg9tWSvYTz3fqzFnIPe+DPnly9eIxKAA+PECod4S3RDSuB6y7
X-Gm-Gg: AeBDieu/Iaqk1xlssEBP3yNDu32j1p5n5cszFHwiiHazMt6rG27jxHJ7bg+Cv/cyk4c
	LTRlPhFTW3Q5lzhoqYBObe9PjDGYS3AhyYWM4JxqXmeDH32CADPu+rdVQq5kq2qTP43xdpBqsNb
	prOF8jlNdn5bv/Sq8xtwvavfNjSP8JcNQKT8C99lYpV4jF17zrjGJ7vuPV+McYaUZCU6AJfO2d9
	YxmnfmDNN3NxizhwZ64HphH0AKoong6gadIw1djS0D+k23scwKGyr/H+Dnc0w2SdAL4Q0cM12w3
	4iamXNZuKOGbeTY8N4t6ObiWGt9ghkWCzqSQh72H0eWaBH5fG8n/B0RfIyNcIH0+wiFeqovRia+
	P0XUEOJ9kuLthZk5KIRoZ6/uUoiJppxB+ZAIJDoSVjYoBSxxGD69lW/s6NAjh5cvTxbLMQn/5u3
	48xtKGPDikRJpHqhF4IbpzsI3W5GHK8bzjHM8Ci73wL7XAwV+HZZ4amCKtKttpjoAFGnf53bZ1b
	YDN8926K0mH
X-Received: by 2002:a05:6000:24c9:b0:43c:fe59:6696 with SMTP id ffacd0b85a97d-43d642d9e29mr6966223f8f.46.1775849872719;
        Fri, 10 Apr 2026 12:37:52 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e50044sm9690425f8f.25.2026.04.10.12.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 12:37:51 -0700 (PDT)
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
Subject: [PATCH 7/7] iio: addac: ad74115: Use devm_mutex_init()
Date: Fri, 10 Apr 2026 20:37:37 +0100
Message-ID: <20260410193737.35905-8-devnexen@gmail.com>
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
 drivers/iio/addac/ad74115.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/addac/ad74115.c b/drivers/iio/addac/ad74115.c
index f8b04d86b01f..41e0b1d334cc 100644
--- a/drivers/iio/addac/ad74115.c
+++ b/drivers/iio/addac/ad74115.c
@@ -1835,7 +1835,10 @@ static int ad74115_probe(struct spi_device *spi)
 	st = iio_priv(indio_dev);
 
 	st->spi = spi;
-	mutex_init(&st->lock);
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
 	init_completion(&st->adc_data_completion);
 
 	indio_dev->name = AD74115_NAME;
-- 
2.53.0

