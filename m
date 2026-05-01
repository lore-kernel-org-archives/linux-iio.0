Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7EC42314D
	for <linux-iio@vger.kernel.org>; Fri,  1 May 2026 20:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777666079; cv=none; b=RZX+XWjD71FB1/wJ93mR+/kw9sylrwDBVjFOyBJ0W4dLApljDFQS1RwSHRu13qVt94ICnf6T3YlpW7b2Ye+J0dYrfJTqDosujx9FoG55pEV4q7O2Jlfvb4Ysv8dIimJRwQJvlQrW6sjT5C9CMAeBuTZxi65G6kaJYIXWPzvU3eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777666079; c=relaxed/simple;
	bh=FtD2Z1xu1lLuUsrnPnIxxBPpzBzNkmTiFU81QCJiUQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxvbC6ycWgI2vYexwTEBLEmQGhA6b6q1Zwra1XkIP1Np56yvzfD9M+lf0DatAV1NZlAinrAl4qHZi1ETZpicuqsZlRiw7q+Jpm/kimjdk178FoYtO+f6njxaainD78z39VbFPCroD8t/gD/OMpmhq4Ju6S60NKmXvx0YzogfuHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuVQZ5zo; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuVQZ5zo"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so21301635e9.0
        for <linux-iio@vger.kernel.org>; Fri, 01 May 2026 13:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777666075; x=1778270875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UF/iVRP69aP8wVCrm2EY96bha6HrIsHGDErfR8s64U=;
        b=WuVQZ5zol4gek4M15hnluqs6aFLPlftHDTLgSo1h2YZ8HiefaW14wx3vM2NuUhc5hG
         67ZfXZ9mUKFeMX3q8uTov3gKZXUXEaDlP9PHGVjnV+jPtKYU938NfCn82yDC9eqgvk7A
         /uYmjAINE2wXnw78qWVkQqmJJJZnJqymsKc7e8jjnMe1WG0u4es2VIzQyLSH01koQANc
         6sGh9FNccNVS/uJWyh+4orFhkUp/qPVRw0i8PO0lOndkKu+Lv0E7DivygDh6DmOqxCaA
         x/RjQ997bAdM+VjhATNc3rYV4iXhaWQYt+fU/hTsjgVELVNoJ/wuh+UV6+H9tMccKVtx
         KG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777666075; x=1778270875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6UF/iVRP69aP8wVCrm2EY96bha6HrIsHGDErfR8s64U=;
        b=XjhevX1uPdlFTci6pyiBMW2fsmiFdtVYwHjvE6xsGL6Hpwj9FZ8uG6b+J75BMu/MgH
         nM7Z43SOGsYZ/Wl4AW3x6/BvIQ2aBOnFbLWfWcFoLMthtfWchJ0aX4pcXxvOd57nZFum
         7FJKXfS8byWgUNdHF4u3+Cb4oxSVy46RureYz6B37Us/VMpTP6dedwJSU+mO90m0xMFm
         qdgvdNS7dlYImuKgjBiVg8Gi9tQCQLisTQ1f/8Y9q8fNxF1DK68eTVzy9AHoatxFXLtA
         GmZIiY4u0o6Iw+qO+Nvn0x+/Ff2SXqQJ+fxYAWn7/6Jf2k2MWNfm3BAVgKslCEErkIOE
         fw2Q==
X-Forwarded-Encrypted: i=1; AFNElJ+18c7nyejC9bwEENCgC69xiWQRhsWjQxiXBpwhshr18ML4ZOnNFh0o5EPOZ4/QEXzJ7nF6mD5vmPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgvJ7egMK+7n1iQSKHZsmIw+5cbjjZeihzU1V/xBW4cxyXoH7H
	MBHb9zu96oFKhp4SDbTrcNdBU7cNrfMtQ7e41YCvnEjnEcZ/QnrdZZm0
X-Gm-Gg: AeBDiesGMFSwGlfnqDd2zIkZTakptZ6ZQ+fNwf5l2bk/3kZYHWGWcpkDTacuItpg22v
	9ZLPASGpvNvvtWkqyZsoPL9SZlmt0lx7cGzCWHM7AtSpDNpSelFPoV0b4SvsJfRNiNvEv2AxmqM
	Xa0qo3VmKqzU/+HVPaYN5H8boaeYkzTSXOfbE92ilGBkDtjaBhLYCC2aLy/Ev4ErfTgpJqPx1BG
	vYdTxAB0/RMRCmsxSDzO/DGyiMP3V6BzwXW1Seizc7jtyrXGOUucNuyxDQq5qP5a8AVhy2WUk8u
	NK314gMHTwzIoNiQaCpxUok7hTi1UHAGuaxT8srv2PqH8kBGNQYjcEvJKAD3pRvyPazndBJTdzW
	CDdENcAVkzBmzjnVVOxdKeTuSHnxao+xB/+HNBhJvsuEaUfSL7UwHnYruauOuAc00xpyAkTxy0u
	L7nWvPafKg
X-Received: by 2002:a05:600c:859a:b0:48a:7f90:2231 with SMTP id 5b1f17b1804b1-48a9865f859mr6273835e9.19.1777666075135;
        Fri, 01 May 2026 13:07:55 -0700 (PDT)
Received: from fedora ([2a02:8071:50c5:5c0::3323])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fe953besm26829325e9.2.2026.05.01.13.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 13:07:54 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: wbg@kernel.org
Cc: conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor.dooley@microchip.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] MAINTAINERS: add entry for GPIO quadrature encoder counter driver
Date: Fri,  1 May 2026 22:07:49 +0200
Message-ID: <20260501200749.20029-4-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260501200749.20029-1-wafgo01@gmail.com>
References: <20260501200749.20029-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself as maintainer for the new gpio-quadrature-encoder counter
driver and its devicetree binding.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 06a8c7457..fca62baa7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11018,6 +11018,13 @@ F:	Documentation/dev-tools/gpio-sloppy-logic-analyzer.rst
 F:	drivers/gpio/gpio-sloppy-logic-analyzer.c
 F:	tools/gpio/gpio-sloppy-logic-analyzer.sh
 
+GPIO QUADRATURE ENCODER COUNTER DRIVER
+M:	Wadim Mueller <wafgo01@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/counter/gpio-quadrature-encoder.yaml
+F:	drivers/counter/gpio-quadrature-encoder.c
+
 GPIO SUBSYSTEM
 M:	Linus Walleij <linusw@kernel.org>
 M:	Bartosz Golaszewski <brgl@kernel.org>
-- 
2.52.0

