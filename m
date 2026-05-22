Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6CC3803DD
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 12:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453272; cv=none; b=kPh/rSVhpnYw72/GoRhAmbUXBI/l1pfc0g9hEv8SCluBsSoFeyL8VWuftRMgVjszFbUYXREeS+WXt0RvoiEjPvrTnlAdKgXXrkC/hC1VfGnvVkuQ2mBJcNCiQWVZw5wpJR7wsFGRaRwEwtHokGfXNJ5eksirSD327FfTC/6kzKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453272; c=relaxed/simple;
	bh=HrONuiDMQBsyQKK/Qw9EDIlYqlICs8puzZEsFzw3q6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LtC1pflSvYM6HtoFo+EV81LNCEllooM8bRZ4+Notu/TWA0/ywsFCrs60z4R9Y6cINls4ki9R8yb2Uz452YcCadrpT2SfOttoMTasEI8NnTk3D3CeUe5E5KWWiTvc6e+q/7ChwR7UPI7OXSoyIXsItNsuTw5e5qUsK8Wmw4cpa5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+8zUTAY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+8zUTAY"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4904127c32cso6634685e9.2
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 05:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779453269; x=1780058069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhPK+WD3x7b1l7d6v6GZpCF931oi4rpE7Ri3gLPt+mY=;
        b=e+8zUTAYeTtU7iRnrBsiA4h6lrmOS8t56vvnTk4OaWHmQUv0vl/RN5cAGZ2AoBP0D3
         gv74p0j3+QApIZvAvMYTtUcpoY5GxreuS3MXHN6F1V9sZ+h8kOfAD6BOuw1zrVoJeXua
         3h0ryIK4DLMzUP3zdBi5L16bOGLwuMbtzV/zQl176JBdLd8fH5aGNjYMiGP6mURWjJNj
         KiCoxAtF5g5RIA9JtrkvVJLs14H5XE5anJ2Z9cLqGa/Yb4RA/j4C+dL2t5qxKzsSzXIU
         jl0dlcBjnlOcLtH7ZB0Q4nrF+Yh0IVE26g969hGCQAynTmhC5vjR608KAaNftR4tM9pl
         Hc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779453269; x=1780058069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lhPK+WD3x7b1l7d6v6GZpCF931oi4rpE7Ri3gLPt+mY=;
        b=iYUJiCvqq1PUcQYCcll1WA77eWMqoenhXw+zcdJftnFMHdPqV3kv5bHUf7QvXTMxJD
         hbHsh3Tkbi0hVbWTGDtbs/J5ZBkbBjAI/tP+sjWIlmRqe9g+a/SQFKx4hQgWfkHPUQxV
         gNMiXb0Xhdd9lluWQrJ61nxI0MvTI0c2ykzeHKoIVjFnE1vOT1zppkSgbOb8Txl9srUY
         Ywptn9vcFU0vCXIFO2nMMS9aG5KHgBK6Xtkpdh1o4Zqu6RDJA9RX/TNubqrvnpYurBzn
         f86TF9gY6lyl9/Rg+GONbjMIc8pen2Yd4pkZPQaxV3Z2YlgqY6YuB6fF7/eY6JhqOoeZ
         L+Kg==
X-Forwarded-Encrypted: i=1; AFNElJ8gvbdqIlSj6Mev4boKtT4g5uzZVmB+EeaB5h1aq2XjXlio3cJCrSqIYRT7A6mfCE+JHkb3NV3uadM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSy2EAXgvBCnF+sEgaxcdmDn/5278wQr41EBfnuuZHGEUVzwHm
	RsxpE0zwOPnaV+iE5HBJFP8u2HAijP7PpU04EjGQv94x07ymWzZS9KFa
X-Gm-Gg: Acq92OEWljNaeTgGHVm5tw3zIS0iqbksb+lseXgzOW9z9VUJlIm16CRQV3Tne/vqjSk
	DEXTQQ4r4jSE6opnOIhh6z4aHe+nq/aaa3YtzKV0dE7XnfQ0FIejF8uxLdxPKhW33gzBMsZL2IU
	62lGv4eP9r1e0HPpi2JxZQrPb5Em6GCZt7u2Gpu0rwL18JA9bywF3Bdov7Emzmp0NQX9PZwiY+W
	bi7Tgf1OyY5glvtRLT9cANP15xI1CfMYJMf4wnM1XzpwDKa7UrqyPotiOMBQWyJ2zipxu9zO1wG
	x+T4lfIvLraOktVoHiF/BKt6r7iHqTEcKNujyLErs1hKTO/4SnSUJhVC5+WXDySVKC8EoGH3Tux
	uwWtiwVzbq8UGOPoQtHnUjUr3WwyOpojHknUX41V9QgLZREdL2mW9mzB/QMgedh+IeT9zSZVLN3
	04mbXYHe9N01y+l0Hb4WrwkSHrykC4lOBCjZ5W1eyhn0I2HUPs7MC8DL4Wcl7FOzk=
X-Received: by 2002:a05:600c:1393:b0:489:c57:7836 with SMTP id 5b1f17b1804b1-490428e5b31mr47285995e9.27.1779453268890;
        Fri, 22 May 2026 05:34:28 -0700 (PDT)
Received: from aldo-conte-t14.tailf68ad9.ts.net ([217.61.173.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49042af0ac1sm14760175e9.31.2026.05.22.05.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 05:34:28 -0700 (PDT)
From: Aldo Conte <aldocontelk@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	shuah@kernel.org,
	joshua.crofts1@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v3 7/8] iio: tcs3472: move standalone return to default case
Date: Fri, 22 May 2026 14:34:18 +0200
Message-ID: <20260522123420.45495-8-aldocontelk@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522123420.45495-1-aldocontelk@gmail.com>
References: <20260522123420.45495-1-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the trailing 'return -EINVAL' statements at the end of
tcs3472_read_raw() and tcs3472_write_raw() into explicit default:
cases inside the respective switch statements.

This removes the need for a separate return statement
after the switch.

No functional change.

Suggested-by: Andy Shevchenko <andy@kernel.org>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
---
v3:
- No changes.

 drivers/iio/light/tcs3472.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index f74e6633db45..1f597ca93697 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -166,8 +166,9 @@ static int tcs3472_read_raw(struct iio_dev *indio_dev,
 		*val = 0;
 		*val2 = (256 - data->atime) * 2400;
 		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
 	}
-	return -EINVAL;
 }
 
 static int tcs3472_write_raw(struct iio_dev *indio_dev,
@@ -204,8 +205,9 @@ static int tcs3472_write_raw(struct iio_dev *indio_dev,
 
 		}
 		return -EINVAL;
+	default:
+		return -EINVAL;
 	}
-	return -EINVAL;
 }
 
 /*
-- 
2.54.0

