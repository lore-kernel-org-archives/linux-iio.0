Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B8B48CD77
	for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2026 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786635115; cv=none; b=lKAR5Dd9E3ozMw3RWwKNs3l1XnDJZou/Y3FQx2FfC9IZ9+gbxRr+1VQzlfbfOIwiqkL8OjS7z3hXF5SI6TVOGR7Ez9gn9xnEiyXWhoUOn8LADOVHpdI73486vghjUH7pCIG8SFu5m0WA8gbb8mj1pfwmubixMo0nmbPRGPN6Fx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786635115; c=relaxed/simple;
	bh=NX1mj7lWqmufaNh1/+yRMHowMT7G1KD8ApMLqE2vOgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fV6HERy7EcFKBKjIVb/2Gtt9LSZKi+NqXqADj0BGEFllWPdCS0RuyYT53+JOCBqUcn+MjzCNt/HIWiIkxbg22g59W1UkcdAK6ceqx+TzXE8jut8BD5WgLHdyiznwrB5lDHZ7Hqv5k3OdaHy1A2aWFQJT0Lp3FAtun5ZUKXZQuWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWX0tb7o; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWX0tb7o"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca7bea5e5b3so759506a12.1
        for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2026 08:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786635112; x=1787239912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cLBFetwFpohNSM2IPfXMfUKp4/p+7rRpSzLCPfNU/RA=;
        b=aWX0tb7ocDLCDLcO2tqQDPDJkSBNUGsv6K03NtxvZDP9liLTmFVpVuE6vdQ47L0wcE
         XqEZg/gD4WBzFVGXhBrPbSBNzObgclN7IIlpYOCn54gfWhqaRYZwFeTlV2Wf9QRQlrBh
         mejoNW9tErj9RULkOB7Q/yOb546tw672+k9xkLST0qG89vCxkd/U7dOwRqeFYHeZZcSf
         E4v2Xon8r/6cx/YpI8QhGIK+A1lUQs2Gy/XyPmbd8A+IRk5Engh8O66VLBHEjxEYDxAS
         3iXePwrzrrzJPtzbXJX97DWVpHxSwAMrrFOVjRzgFbftzNJGkfU0VLT1vAv9toDAOyap
         C48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786635112; x=1787239912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cLBFetwFpohNSM2IPfXMfUKp4/p+7rRpSzLCPfNU/RA=;
        b=pX6CiO3FB3tK5OiSV2pIVh+ghsOKkSDryYwojvd/R0R+B8A+kqEq2Bwr4VBrqtrhFU
         IRW9U79tf+YBrR/UyDl4TWkNGrdBt8Qbeyn/ZR5Flb1aWofVz+SBlRdlSvmMlqMaUWS5
         LLgrE9SpuJvYxurNMAu+mQ0Ie+zMqreXumezJbctoju1jo0/+ffkEXz/zrUcK5ajcr/Z
         gz+H7WPUkzftvZY+rYLTq+NFWuIsueVVGYYt21CCKI4qHaS3O9R5p+x/PCX99O5JZRH4
         9gU9CrYPcbWxljHVYpAVbAerJo+c60+Qxbk6y5i+BsojCQK3gKk4nxvcxvgK4MhXI54r
         WCIA==
X-Forwarded-Encrypted: i=1; AHgh+Rr7NfRyYfipS6qCx/SqijTX1R5v3bZ07TtxGxdLv8HhNWTgT9H7mJFe2Zbr26/cvneA4ugMXWIwBwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz3VEyFEtUMRhi4DolwjcTFk4tzWKoxvus/yUIxpFY37ZGEfCi
	1ZOIX/EVniDkBeiK9iFPcSnCc5l0/hGwynJtnbaCRDvVj02bYb1wxFuk
X-Gm-Gg: AR+sD100/zAGWPpnep79sN/+ALdysg5tIqQTpW3ZrL8ryaqtrRHckB+PyHGjAZrC/sy
	bkc5hO4MYHS0vCC9wgqSG7p5TMG0kKjKl3dco9PX2hTfuuZ/z5PSY5ITW9rXRYuI5LxlkXTU2ce
	xjHJqJMKZsim18rgAAhus3HNUvpPI6Egwts5mTZVGYCoX3m30V+NBswzV+mwGLAhZncD65g5/bP
	9jpeYoRRzKc1XjC9S+pa0+t30fLMqtkcOZq2OgEiEL29cDK+YB0CtapNjlJ52JDqUScMwos/HBD
	ttYR2mwq19kT7qXViXRfkt0zpQR3z/bIs9Fk++0MeVBdqsQCb/yVJ9LHsZRsSQR5EdpXL6129a3
	vUwFEpL22BekCkZCVpbvVOJRMZtJc6WEd9BjbZg82xwsQXzP/MIPfQRNp+qkajPRRA/5eQhw0lC
	4Or67MjYNL/3nC1kiKzuZfQC7GXXAyOcXCN9qfNPWFN7gbqllifm0JU/bTygHvbSH2TAGMNbcIi
	Sl+cavfjn+3iGUiQdMbVjrSM6lVMMex1Q9iq13rKu/8/dtrdB7A5D/Y373TLw==
X-Received: by 2002:a05:6a20:6f8a:b0:3c4:4272:b400 with SMTP id adf61e73a8af0-3cc5524204cmr10350676637.18.1786635111712;
        Thu, 13 Aug 2026 08:31:51 -0700 (PDT)
Received: from debian13.localdomain (bb219-75-96-14.singnet.com.sg. [219.75.96.14])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ec082943fsm7960604eec.29.2026.08.13.08.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 08:31:51 -0700 (PDT)
From: Adi Nata <adinata.softwareengineer@gmail.com>
To: lorenzo@kernel.org,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linux.dev,
	Adi Nata <adinata.softwareengineer@gmail.com>
Subject: [PATCH v2 2/5] iio: humidity: hts221: Add a blank line after variable declarations
Date: Thu, 13 Aug 2026 23:31:26 +0800
Message-ID: <20260813153129.12423-3-adinata.softwareengineer@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260813153129.12423-1-adinata.softwareengineer@gmail.com>
References: <20260813153129.12423-1-adinata.softwareengineer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve code readability per checkpatch warning.

Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>
---
 drivers/iio/humidity/hts221_buffer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
index 4d03db19063e..c868549d09c0 100644
--- a/drivers/iio/humidity/hts221_buffer.c
+++ b/drivers/iio/humidity/hts221_buffer.c
@@ -194,6 +194,7 @@ static irqreturn_t hts221_buffer_handler_thread(int irq, void *p)
 int hts221_allocate_buffers(struct iio_dev *iio_dev)
 {
 	struct hts221_hw *hw = iio_priv(iio_dev);
+
 	return devm_iio_triggered_buffer_setup(hw->dev, iio_dev,
 					NULL, hts221_buffer_handler_thread,
 					&hts221_buffer_ops);
-- 
2.47.3

