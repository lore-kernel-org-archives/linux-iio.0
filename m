Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C72D47AF67
	for <linux-iio@vger.kernel.org>; Thu,  2 Jul 2026 11:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782992830; cv=none; b=kz2ZVc8V+nqNgu+kfBQwDiLVp4WWtGsPH8E441m/4lwsucNXRDJjZJd0z5UrIiGdhxM145TKq6CiS4w7V+LG/N3j9DMydf6GbYSwKbvl8KqbHHNbTZmpTkOth/sj80RUZGSlcxhzLnCsxFYeR+9TAcH774k5Jq9V/Oi9+8M2otI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782992830; c=relaxed/simple;
	bh=6KwVdXym8m9VmBu/yZDbGr4sR4go0nT/ImlSsY/m7K0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F/C+YGuCKbE20W4kPxCGQixUMKQ5VL/SlICT5z3PqP266XB84cBeCC7HnsXm0ouRN0OwhzURSOwdKPwd0iqEoITnvhPFZD8olt/jCZS5HYCxTsAPnmk482iomIAWTW4yiW5rRp5K0mvRCkpykoAtnO2u+uzdM5Zp3OrsZ3fOvjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVDToIpu; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVDToIpu"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-37fdee9276fso1816181a91.3
        for <linux-iio@vger.kernel.org>; Thu, 02 Jul 2026 04:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782992829; x=1783597629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJM+v6mJ9RBfgqnA3JaL3CQXECHO5LJ7tpDsIB136Js=;
        b=ZVDToIpuLzePiJ5Nn9uNMlxzpz5fuAw/gYVBtHOrwx+0JtFYeugV78F3hc4t+nPm5c
         zOoUvuRhEKDwwRZpg6AxeiSzEvcSjhzPGbqUjgT+q2i1oaf7FZQ1ZG9GZWZylIvLPfjU
         mCTOBjckXeBgbVSqPoI6kXXlI7uDUVAnK8owzfum37YjcnjZamKkv407vs4L/QIMYXXS
         bQLMrYKrRziNmud1tglSQKTw9RdEra5ykum01Zc1zBlbUErFFEMnSetPjtF8c396nAJU
         6WzRt/wnh70S0YYJIRDrsCoymkjiA5tcxPVrL+c/wHS13/f8wYnx/Xf67F7niy11ZsXu
         oMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782992829; x=1783597629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EJM+v6mJ9RBfgqnA3JaL3CQXECHO5LJ7tpDsIB136Js=;
        b=kLqVRjOdp9MoAZdvaXIF/gYC7XAJTsUpfa2iKWmJH88shi8v2rB/EBmhtQ8bGHwQGP
         eEUxoVhW3VIH/VIVhZke2iiTa8YPKBTbsQoUOu3VcEUN+dqxlTSU0ZBFwenZVXzHYQP3
         zD+waioTjMb3Pvi8n+r7H4wczxI2Q3A9BvJ7ugj67EoO4zoLyhlgToO4/clQeOaP5eUN
         OrWqXufhrIEUg9vNLwIXXY/c3WftFH4an3gGPP/RYslHDAwxFWoiYz/3dcgPbaZXKosi
         EhGpzyHo+yUBqGohgMG4J8BEbRb3+le3ppjUnVb32dP3kmKgvSSDVPL/aR9P7k8YWNuN
         WkAQ==
X-Forwarded-Encrypted: i=1; AHgh+Roz3u2qZgn77TnFLfrrLQ3qswJfA4gtn8zQoT+tQiTYAqrmWbdsh1jZcEyaIQkvTrW3UdqDVNB/lFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZKV9r6XZe5/G07niucUrxN4cAsaZOH7Dlt3j4Wh++FthzsZ/V
	f4IoI6W/12XxgIRna/Jf+7lMhTyOgYkl7y2n8nXgNUuutWynB7AC3Mr3
X-Gm-Gg: AfdE7cmLRwTK+5/2TQCVojG83VrNXYXe04KrZMBzkjC4DdkBCCG4eV0MJeg0g1gPXFx
	GGj/RHCpYI7+CLJSXhaiMp7TVyEd9yLvDCuRhON4bcV2TilMoYeLAAM0px33xXimElx0CKaIf8w
	TWkpAVtWgi0fzTSbJsoGESjBCQbhBxYTdDmaSwZhClZ4TXvWHUzs1J/HT/KrFAkR1iXSM6wue1/
	ceKoibYB/iRRe0IOQWfsz1t/iIzkgpeduYc8InG0XcMfGegf5Q3t21W8GyEXteRP+1mu3By59PH
	Czd9NGM2kYlaPXgn/Ca1UTivgt3llQVDI4kIAHK+MDyhXC1IUkzruTfOGQ7esVM6f3IlNfCboPa
	1d15sneV4faFnEu2l3Fa1AOcUJ9Qi9VoJ9IYrOC6JMeWKHUXmDAc789fCZT8+EQF42vJjSpyrGB
	9AAsB4dYhkCi5qSl98HbPzazv1sFD/uufYdoSbx1RgELfR6SFOl0aw5v+giakfVQw5j3xk
X-Received: by 2002:a17:90b:4d05:b0:37f:c2a8:ce45 with SMTP id 98e67ed59e1d1-380ba84ba5bmr4978091a91.4.1782992828439;
        Thu, 02 Jul 2026 04:47:08 -0700 (PDT)
Received: from moksh-Nitro-ANV15-51.. ([2401:4900:c12e:fec4:e7a1:6f69:20dc:cd96])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bb84405sm12313834eec.17.2026.07.02.04.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 04:47:07 -0700 (PDT)
From: Moksh Panicker <mokshpanicker.7@gmail.com>
To: jic23@kernel.org
Cc: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	joshua.crofts1@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Moksh Panicker <mokshpanicker.7@gmail.com>
Subject: [PATCH v3 2/2] iio: adc: ad7779: Remove redundant dev_err_probe() after devm_request_irq()
Date: Thu,  2 Jul 2026 11:46:49 +0000
Message-Id: <20260702114649.9758-3-mokshpanicker.7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702114649.9758-1-mokshpanicker.7@gmail.com>
References: <20260702114649.9758-1-mokshpanicker.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_request_irq() already prints an error message on failure via the
IRQ core, so wrapping its return value in dev_err_probe() results in a
duplicate error message. Return the error directly instead.

Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
---
 drivers/iio/adc/ad7779.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
index c1a99b4c1256..a5b8bfa99a74 100644
--- a/drivers/iio/adc/ad7779.c
+++ b/drivers/iio/adc/ad7779.c
@@ -842,8 +842,7 @@ static int ad7779_setup_without_backend(struct ad7779_state *st, struct iio_dev
 			       IRQF_NO_THREAD | IRQF_NO_AUTOEN, indio_dev->name,
 			       st->trig);
 	if (ret)
-		return dev_err_probe(dev, ret, "request IRQ %d failed\n",
-				     st->spi->irq);
+		return ret;
 
 	ret = devm_iio_trigger_register(dev, st->trig);
 	if (ret)
-- 
2.34.1

