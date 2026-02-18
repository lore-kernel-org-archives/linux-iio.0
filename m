Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112992FB09A
	for <linux-iio@vger.kernel.org>; Wed, 18 Feb 2026 04:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771389476; cv=none; b=VXLGkKRsfmPMq2dUOHo4xl0GziS7/7S2sM/7nz5cxcePII0lSmdpyV46EWdI0rxM4woUMqxph9YQrgtfIxUwq7q1rRvmE/qpl8WMdiJL2swDBNsB2azBurp2xE8Ok0N1xKLb7SPA485jrYIB1ZuXVu6iYJDK2pFQMdhAJbbQPBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771389476; c=relaxed/simple;
	bh=M6P2fOwaPfajnVICfkp43PSCExBZfZImFLdu1/EjtpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jz14vUWPzyAoRij9hAlhTK8tPnm6hjpxp61XvbLxx/+NM54lyUwkbwEvre/oIBmfwYxI6n5YpnG4kFd2UI1HKVzRFHk43Mur6yfLscoZLWPjsmwNtzZId3oYWjq/WiTANGRNQEcHxyBv/Iy462dYJuFd3+v4ZSzoTAPZWNrZXVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlpVnxXB; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlpVnxXB"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-794fe16d032so40776427b3.3
        for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 20:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771389474; x=1771994274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzV4CSCJUqEmyPqip690W5uop12UNLhf6APilRzECSQ=;
        b=KlpVnxXB7NVpsnsWvuVLih5jtr4ix9tMjDzlVs+WmKyxeV7L1Yn2t0StGftD/miZZE
         J0wXrgrmLy7jLJHYlv/9rv1NSl/JrzWI2LLhII+KphcVhFYil3m/PkFrEwpskY4ebw03
         bQnnx8kBBo460T9I6et78n/Hgn1+Uq55JdQY46rv8lHWAZLFwaVatY8dBBtZGPTPfG+q
         BdRmZozRcLj57e1Rru2utrNS/xPG3fUsWPtMwR3xVULSyUlHYUNwaIWjXCR8h7G0zUjQ
         BafDjs0Syu31IDtWk7bl05vmIYj2UTijBY9WBLhagsYiAu2DQhBPgr7mkkPRtXpjEj5v
         UJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771389474; x=1771994274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bzV4CSCJUqEmyPqip690W5uop12UNLhf6APilRzECSQ=;
        b=cAipxfSCQQnBavuKS93Jw0e0Qjv8o2RMg24Ajq4h4FWjiBDwk3TWcDFWUvhb40x1Bf
         prfsyUnJYTujtHg851S52GnwZc/mlviF8i4R2xcWAdsDnD4bQVUhJW7e0UciZFkljy7M
         A9HFzifMP641ru9BmUin7ardOdeBlnATKQeubKRGUAZ8o17H/R9eBkgYF8uD23cfzVK6
         CYgoJES0RpFtprUUl3ITtpkMaAwMkWRDjuStpd5onL9M7Jx23ZaYUTGLXJT1wuxWx0ys
         ruhe2oTmXImrbUEmoqGe8mTFHjqhaGWmikiY4P3k8U+Sf2qRJYcknLGve9iOmJoRl7Oh
         8IYw==
X-Forwarded-Encrypted: i=1; AJvYcCXWjHsYtIGOSJd9UVncfzsUw08K8PNL+SccE4PMGV+wWMLYNTcfIfJFZRymIhar49JP+dG5W7bEDlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDUzPQ3D5aWc+JZimcvenAN2yrlqptNtQh/fNy9J5RLhg2beHG
	OLKJUDDzmpW0gJ6is+EaVW3hO+XtZBOu0g0Q04tFhySby1y5XHyyFJFg
X-Gm-Gg: AZuq6aINEiLPbCMv7RKZk+e08HajhYI2VvszVK0MsYWQuoXJSMeThoBYNMJJqGk2V5f
	nUbkxVmHGwQ0dcvKljfndGRIH3wbmTP+QE/NLYgUvz2dlkiD+pG/52dpLX3D8zTyrzTrEUrfYjy
	HCvchQ/8Gi/lvHG8TgHRpzpRZ5m5IAfZu5vMPgM0VdCZXrO+m4xUmxjRJI4mT+1q6RCbeTd5Fr4
	bDlCvD9nUFH6U7YmbcfRvgNeZNiZV6qZD/kua+hImjB7M15iQOe0/helAdok7zwfvEWOVHMnhSJ
	IEbhIyLfbtXO93QSksiBwvfJvYCY1WOAH44w1WQf8sDIQC5NWW5UUck4RG8qOjWnF0RhoAZnd8H
	wfUZW2Y4zev7XZE47DB1lkftiIbdn03PEfF6XK4jrc/Hb7TDPtpBZttoqMizktgWB466K6OmOD2
	aT8tMtgG0yhqOk5GFu2r92nbO/FsxCH1VcijMF6+fn9wOv5hgg1lcACpYuDs5k3x22qfWGFw6XM
	fpLK/CnoscpPky0HL5y3XuQuOBMeueU7IZIG5p3r+M=
X-Received: by 2002:a05:690c:6e82:b0:794:ff27:df2c with SMTP id 00721157ae682-797f73b6411mr5118057b3.55.1771389474032;
        Tue, 17 Feb 2026 20:37:54 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c23e4bdsm119850617b3.32.2026.02.17.20.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 20:37:53 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: jic23@kernel.org,
	andy@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v4 8/9] iio: light: gp2ap020a00f: Remove trailing comma in termination entry
Date: Tue, 17 Feb 2026 22:37:27 -0600
Message-ID: <20260218043728.609659-9-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218043728.609659-1-ethantidmore06@gmail.com>
References: <20260218043728.609659-1-ethantidmore06@gmail.com>
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
v4:
- Integrate Andy Shevchenko's cleanups.

 drivers/iio/light/gp2ap020a00f.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index d922cd4987ab..1867dacc0af6 100644
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

