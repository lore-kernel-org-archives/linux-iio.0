Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9C9383C9C
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773651684; cv=none; b=eJce28UpacMhbknwZwC7GiikZ3npStpQPgStdjeuMBp/Ys1bZ5fvr9oIKXdOMr09+4nKktovbJ/x1O+xmi5hj8GgU4C/0pOHjk6bDN1ybGEOKMuslsL7nMom+OXm/M09I/B8kHlLb9Sq6Nv9PK2eI3JmDKGNLpdFVwCIePL4c7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773651684; c=relaxed/simple;
	bh=ZaA88DYpvm2paOsVMP6lUg/oM7kobf2QggwDt0wLzJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQlTyqnz5uLy5hWdB7t7yY5QaCR4CumE8mkbEFEDTevcIouqq86fSd2Mj1+KgjUxIX84j7zA9xQcQfQBxWGRGNW/nF1wBSttZW2iwHFlKRfa/fF+OtrLbWvJS6IrjovY3KARspZu7aR1y6PQbrEyUWTqmniu4F1OkzkP4WXGmis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMIZHC0O; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMIZHC0O"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ab232cc803so19874855ad.3
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 02:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773651683; x=1774256483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1J6P+nBUFnn2G2dOENb1P2owbGwV8u/LT2CgQCE4qrM=;
        b=KMIZHC0O+hnMqjHHSxK5mxJPjx0iTQDDe5re1zdoueamKLU9KEx5nFJmE3n1UGRdys
         fyjWtFdTA9e7XXe0rjI1ea5yW5ENWURpI2uzu4rkqsLyU1wLBPwuon7Sq4Lk6FiNpVmp
         hm01BiVPI+VpnRjCi6yFzn2q2FdqhYWTF6B4wnIQQ2mkTMN1sOYvZ6lrssgycDVo/hkg
         zO3g+j4PIvVgL58jj4PhHlnZwZLC25PfXhGmIoZCSORYtFXEfDSNe7prq3+WW8U0i0VS
         Z9qGLWI2SdpN2ymxUOBgJVVXUEHZwmDCGbGLndO5/iUr3B3akONsXucpRhwX6TzY/FnV
         qmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773651683; x=1774256483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1J6P+nBUFnn2G2dOENb1P2owbGwV8u/LT2CgQCE4qrM=;
        b=OMRW3A4c70+5lH0lvBfnmqO/mmnrHvyBp1G61iow8SPUM9lO/QeGEXEcPG4mSQwS/+
         Rr+XUUl+e+dNFZvFW+A4StpSn3/bCQdDnDHXM7JAPymJeWd0AoOjpNzbepcn8kTbZC+Q
         xOQQGTe9/7PONiLKPEpmZ/7uMkZzyd20Zy/vT5aI8xw8BYlQiBjakXskaJKiFLmdIHw5
         E0lF+QJO06ya43P5UTvieqhk8iNwByegzetVjUhyT9Yk6BIM7uL3mUlbXP7d4AMKmNME
         s7BZmxli7BmsvXR7vPuz3dsiGdJY2rHVhSAKGBtWdcyXjTzhJKgUS7WiYT+GnKse701L
         a/dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVesPI/c+WONLVRHsWojiKwuQI70HWWaFfeLRXNM4ASU7+3pS7oarXtdqesAhdmqbOJ34YyAHUEjwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhKQWVW6i0FeOjoqKqGWu7Ewu/+5KwOj0JFcNfxR8oZ3dgHH/A
	+MT2CFcIU4mvpNc5Mf4yEA/1zIUt0DyfiU45por2C1DXqyN+ws6Wb7w3bMNp+g==
X-Gm-Gg: ATEYQzxkeznzBiIUSoKFoijLZnXKmZuKpvtn0Y22iTvyPCX9IPo9K07PWFH+GjjhrsG
	OgsYv82ywn1gAhEQJhala46dCXn00ZbnZvZhYLx2d9rb0KONd05UvW1NbIi3oQdy1SNl30WD8Pf
	q4h4f8v2x6/y1Sj58DKb8Bj0Jh0jzoKTJeamrmYbjB/vDQmLWBTZqf0eU1SlStvju20prcqWmfU
	QVhEzQ+t6NEuQnO3YIsOk9wOsd9v9MQy/nRP2J82FKhLjCry/Y0XVlQ8vC/pXn1X+Ec2553s642
	BnBlfRweRtTOvJfhpLqXNpVc3PQaAUYHVMohYtMHSI8BmQAuf9vXE/R+9Be7vuSvsSWi/UrBFUA
	gfWA83fWt/Fipu00ki9Sw7QuxLJr6fWoRJ/iias3Hlly8EBko7wF8aUuUjA2Ju+kyD/CK+Dapuo
	6FeuGgQ380lbxn2nJ+6QX5KeNV
X-Received: by 2002:a17:903:124f:b0:2ae:803e:6c12 with SMTP id d9443c01a7336-2aeca8ef52bmr120796565ad.6.1773651682802;
        Mon, 16 Mar 2026 02:01:22 -0700 (PDT)
Received: from fedora ([2401:4900:1f33:4eeb:289f:fcde:6da5:35e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece868172sm98105835ad.89.2026.03.16.02.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 02:01:22 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	i.shihao.999@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mazziesaccount@gmail.com,
	nuno.sa@analog.com
Subject: [PATCH v5 08/14] iio: resolver: fix typo from degredation to degradation
Date: Mon, 16 Mar 2026 14:30:16 +0530
Message-ID: <20260316090023.14691-9-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316090023.14691-1-i.shihao.999@gmail.com>
References: <20260316090023.14691-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix incorrect spelling from degredation to degradation.

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/iio/resolver/ad2s1210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/resolver/ad2s1210.c b/drivers/iio/resolver/ad2s1210.c
index 06d9c784f93e..e87175521ab4 100644
--- a/drivers/iio/resolver/ad2s1210.c
+++ b/drivers/iio/resolver/ad2s1210.c
@@ -899,7 +899,7 @@ static const struct iio_event_spec ad2s1210_monitor_signal_event_spec[] = {
		/* Sine/cosine DOS overrange fault.*/
		.type = IIO_EV_TYPE_THRESH,
		.dir = IIO_EV_DIR_RISING,
-		/* Degredation of signal overrange threshold. */
+		/* Degradation of signal overrange threshold. */
		.mask_separate = BIT(IIO_EV_INFO_VALUE),
	},
	{
--
2.53.0
