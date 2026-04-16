Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A1D3B19D2
	for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2026 20:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776372535; cv=none; b=MdqOmm1nNereb4erPIvDcb+JOnkeTCxATqMuzIycXpg8aDpCg7YGiduqTW+gHD9x5UI4ewqioBCIFAPOIjHboJHkW72xZxJovbG4CMBEHkwGq0GBAHnQGscReQN9k58dO3sAFbFBuoMMdJqYzJhreJ4TkvU+XjQ69WOxayH8CaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776372535; c=relaxed/simple;
	bh=FtD2Z1xu1lLuUsrnPnIxxBPpzBzNkmTiFU81QCJiUQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Phpcfu9WQoCIMSN8xgKXGvW1+Wp7yV+eFX3AhdR5i1mDZk5BoM/CBfV+gy3hVFQY7yv3F75x5Qa3O2C+qAWdEeYhdT6Lb+gdJ+KiBBq339PXm6OVjUrCkDPpa6xZnkyX2KSfWp/WrMig7G+fIdZatuzYmMU5Sj/76l7KKpQ3QTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCe3VUTq; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCe3VUTq"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-672713f953bso2470222a12.2
        for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2026 13:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776372533; x=1776977333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UF/iVRP69aP8wVCrm2EY96bha6HrIsHGDErfR8s64U=;
        b=aCe3VUTqh2Zev397j6VRnBtS4qyp2l9EQ2ccFXgyA0fBQh1QvQ3NFFb/nSxCStuROE
         buZD0D6/FJHtOzzD4Z5rxTYcAwsDCqJEUFAtrsMEc8N4hD0x0kQx/T4QD3qXnW06RXkT
         bg7a391OnTtUQvFn3GGTKqIifAEX5cv1zSE+7OgnhfWM57WZawpLNHNG6/ohL/ZTp4SF
         4In2EHge4w/Cuo3im9eDnHtuU+g9GkDMQFpNZAyJJiBsnewpNpPW1QRtkzs9fXvyMVJS
         I2vjWo0M2HMmGMQo8hXD1vQbUsJ4q2gwDXdazXOjHmnHjbLvhGxcxKf5f3sSO/RJAsv9
         YlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776372533; x=1776977333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6UF/iVRP69aP8wVCrm2EY96bha6HrIsHGDErfR8s64U=;
        b=sh2q3ieg/Q4h0vDD1WTP8Kzjb9YLeJC3cWE/DfFK5tz0erwu6p/ZFI62EJdO/Id2xI
         iYCliUP1JCwrTSI2SlPf/1wRaJDrZGczVPwr1teKMu7QSYAo7HJelX1u6U/anOzBU0HL
         WdrVPqmeoGQMrWq1m2Xi2/C0Rm1r7DYrrusLFMEEmZZO2sVZ6KZVBhX7Clyl/7lwh9sm
         e3qEQ/gYrZb+kCmEpd+qva2i5/LJN8Wu2EL68gkPn3Mz9Tqb8hZ0B2oxHtFW2pQmlolk
         CWmFOGBqMjAQ36na4/fHffGdOJRMZVIXTW5f68OmiF8B7xEpGZ2zApFMS0bEDEyYVkQu
         0RkQ==
X-Forwarded-Encrypted: i=1; AFNElJ+dMtpmc7LnWm4Qb7MwwJRNit9EMNiXzLR4yNxMI0SzA1vvPrWzgqjUKEGYWGFw7W3nciGrTZxdKoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0NhQ9E5Xb8KRKJZRChg8rT2wm+jb0fJMXHOBo8IWTr93GuyIt
	KhZzzsU8fUwjpr+Rq159zy0UKggl5v8N+66GOI9aYgJsWWM/RzG9JOPl
X-Gm-Gg: AeBDiev5N1lHo0IyKpdLwjYtxx5WnUt1sG+errvX9TbgLiXXGVXhF496VXxieGMLSV1
	5n0YMlTeYPLSnqDRsqX7NpVKhIHEp/9urHJ72f11C6Ss5SZpwuqw3NUqBZeqykq+POvbT0wMu0R
	9qj2MEuvTPCdFjCg5VMR+DKjjRGSMfxvX29RkejvZtXU2JA8SUPx76BCl0eEDRXLaSX/pP9+9rZ
	ncKfpN6V9cS+8SUTFqvxltRGG5EcOVPPBGLYXj4TWnwTzSrLpa5Y4zVqifRppX8j21M5jiIrllr
	xyIBsLYXN3Dos2djMVZJyzYyYZwr2jLTwn7C0kY+lNRpO7seaWNGUuoURAgYdkOvBc8wzUF4Lk1
	nP+Wi0fjNQfVLBlGIWovp2BL07qOejAIp02/5OEnJ2VU1TmoQibulwUr9fEm4KMeVhuWJxOUI2G
	M6f2HulIvd
X-Received: by 2002:a17:907:3f8d:b0:b9c:69df:4d9a with SMTP id a640c23a62f3a-ba41e4fd421mr1290966b.37.1776372532434;
        Thu, 16 Apr 2026 13:48:52 -0700 (PDT)
Received: from fedora ([2a02:8071:50c5:5c0::d908])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6723800b6f1sm1437962a12.26.2026.04.16.13.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 13:48:51 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: wbg@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wadim Mueller <wafgo01@gmail.com>
Subject: [PATCH 3/3] MAINTAINERS: add entry for GPIO quadrature encoder counter driver
Date: Thu, 16 Apr 2026 22:48:19 +0200
Message-ID: <a935f0399608773f052051a8792e2e5c77066942.1776372319.git.wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1776372319.git.wafgo01@gmail.com>
References: <cover.1776372319.git.wafgo01@gmail.com>
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

