Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7A5346A1D
	for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 03:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771818051; cv=none; b=DCXXNzmGIhdCAxaq00K3uQph8rt8Zpfb6mu7cyBAMkaNZUvREweFIrDQQZfASOUKdrErUdYEP7AtYDVWryHgbT0yjFCNtj3CZ2XrvV8EeqivGV+eJBZXalRgwoawF3pll+aQP/cDFw/Fs9/F/G83/F5VcUjdpOlvI+ebtjOXOLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771818051; c=relaxed/simple;
	bh=hhtFSBCaNAA1inHtvsUmd08xIDDQXrIaMtP+/Cvg1B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvHo4joDK/5a1ze7WxqkAOXy5a0Pc+/IEAtWHJrU+CCyvC03PhQvxsU9cXdDTcf6H7bVFnDSQtee+33gBjgb9PALO5rcSn7avn7Xo+IOAVAOfK/rrbCmkrXh+Nk0DxbEYaJVpbIAcFbhhDMqyvXSfg0di9pjzO5GklkSCHMMRIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXyBlUG5; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXyBlUG5"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-797d6f934e2so36599477b3.0
        for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 19:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771818049; x=1772422849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTdCFkQOcqAQyxWkRPn6EMiNCtV+X3PZKtlzItBFjYI=;
        b=OXyBlUG5L2HGWUJaPZ1J+n4RQNURLjJiIQAvfaACJuWi+WhWcVVR8HHzXLMpmH9Lw7
         iDCOPkKZQD/Gky7HCDBodZESJrRWbisvPxP3T9nF4yw0zOBT+do5Dn2opNbIRBPigAbD
         vg7GRIkhq6oH3U4bH6ZKcfYNx8wDyxFsopLszwH2ydYNCT1ECbgsdEWQnM+/lqfUZQaL
         TSGb3uTnu0Vr8JlJwAyfbVcr36NcbgB2nkxQ88INCdH2RPTQlK3KWcWIEEhNt16TU5ui
         Iy7Je7k1eOoMYLh+VyD27sjuHZSpgrnh0gI/UPC4+fz5R8geM+phMfNu3tyKnEkNNaQh
         mo6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771818049; x=1772422849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LTdCFkQOcqAQyxWkRPn6EMiNCtV+X3PZKtlzItBFjYI=;
        b=ZMiL2SMD4IyTjiJ7dstRRIqjnmv/QuJ2T/uxIyOR/3Oik6j4zWgJ9vRzaQfZO3jwW3
         uxfOqB55XyxU1FmAfmWWDXRgN4dl3FPUO3S+6J99PQLj7YWej4enGyzQEzln+fyp9+mR
         FRTHZvBk+qolenLCilrnfcPOZ+z/bcF/SgidCRr6xdMepdB2luHeAqhKZ/q6CCW85q9x
         luPuv2fogF7eJJbqb6dRVVGNHrLjiIAHOWHjUdrLCx8J8OkOCpqgooiOLb/kODIBZXRf
         iobOqFCDMV+8OBq2oD43otwwhS5YTrVMPo/kFUO/12f6MtMkIREaxUL348vqONjqkUVO
         MzEA==
X-Forwarded-Encrypted: i=1; AJvYcCVdgtOEgpbnpgi47urtzgnfLrOBI/qBPtDjdnuaA6ZcHzvpJ4LnylyQ+Lc+jX/xFDBVttmc4n2ZHrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW7jHjIR54lwGDAwkqGp2MeUVO8wZTZ13v8JhFbP7Gblh0mIQ0
	Zyz1LTvLKmO+gOSfn3jgXpdD1LXrVYzUlpG6aDil4nCVwavge3qpqIKG
X-Gm-Gg: ATEYQzw0KAJmkiyxGGplaRaqCsiopYH7MNAkCX/2/QEH2QUuaFZD8/MOfh++oelVyVQ
	3dsr3K/MFF442j/UEPym8ASZV9PGTxSR+fAhXzi+lJFQtlWmhXywDxiKcLbVKqvygALF/Ao0ZHg
	JuIs5xAmPqwSG5KiLKInPfdarQfkWNjyIKT0bKO+cgzRP+UQoGU45XQ6CIQ+4Olkutf66yP2v7t
	Qt6f4oiWfG/vMLdnHsxC1+UnRxqrfN33eM9omz6IGL9Zr9f8Q/Ps6QuI+Pf61RhPiTK64XfoJIG
	leNeY6iRfN7xad3hU70k/f6xjlTXIqKfqUoYdgNNzUt0W767H2o0nQJfQ0CbQxgjuYRRriabcmw
	R/B1uEoJLs+ITkc8swqt54Fztuj18g99ahHUyUipP8YwPFAV+/UvlNAFXRMKqImEk+5jM8p88fB
	XborGH7wmsgA/V1v6wtxs7AMUNedTT4BUiydBRiYrHUOGzrJkUP5Q+Y7jjcs3SKH9hyZOTsi8Xb
	xffFCzW8Rb4dSSrhT7th3Ri
X-Received: by 2002:a05:690c:389:b0:798:3a5:5a76 with SMTP id 00721157ae682-79828f1e46cmr58018697b3.17.1771818048999;
        Sun, 22 Feb 2026 19:40:48 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982dbd5939sm27285237b3.15.2026.02.22.19.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 19:40:48 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v5 09/10] iio: light: gp2ap020a00f: Remove trailing comma in termination entry
Date: Sun, 22 Feb 2026 21:40:19 -0600
Message-ID: <20260223034020.27625-10-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223034020.27625-1-ethantidmore06@gmail.com>
References: <20260223034020.27625-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Termination entry by definition should be the last one, hence remove
stray comma after it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
v5:
- No change.
v4:
- Integrate Andy Shevchenko's cleanups.

 drivers/iio/light/gp2ap020a00f.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 0d7262e1c5c9..0571803155ae 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -195,7 +195,7 @@ enum gp2ap020a00f_opmode {
 	GP2AP020A00F_OPMODE_ALS_AND_PS,
 	GP2AP020A00F_OPMODE_PROX_DETECT,
 	GP2AP020A00F_OPMODE_SHUTDOWN,
-	GP2AP020A00F_NUM_OPMODES,
+	GP2AP020A00F_NUM_OPMODES
 };
 
 enum gp2ap020a00f_cmd {
-- 
2.53.0

