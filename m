Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE34308F32
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 19:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776628788; cv=none; b=ld61Om5g0fuTEe8OKEOlE+YMqNpX/ifNExUuJ31gNRl3izJfs+s65xYNhHrxIfHhRfMcZulK224B32EwCCp36+4Jw8/gK2Fch6bITtGpPC+ZFBOah8sqXLJB/yVn2Jevj3oomm87p4upZXeuAMjeZUfRR49XMZxJpPDo4JDaG0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776628788; c=relaxed/simple;
	bh=FtD2Z1xu1lLuUsrnPnIxxBPpzBzNkmTiFU81QCJiUQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0U8aXMY8NQCNdL04RER/5igawTz4/ZUTt+5Gjy5HB0LaoolZd4ZA/Rh/X7xqXh4TEyqDCaHZBXhh6HYoJ8xU0079ZFYy+PKiRYB3TEoUy9oMJvQN76VOkwUedq9+I84Obe+H/1El0Mu6oHorluBMY3mEZGbJfapXKg0OD3d3i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHLy62ZZ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHLy62ZZ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso29146395e9.1
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 12:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776628785; x=1777233585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UF/iVRP69aP8wVCrm2EY96bha6HrIsHGDErfR8s64U=;
        b=UHLy62ZZKNv0MjXNxAFa0Ft6T4rc3vnVYhcRCdPvMFlrIwSNIUxvMFZGlVpV/C4DgH
         V5D1CuVU4aDWhXSFR3BVM2PNj+mGWwrMHqhvvlMbIzr6R3hISk7u988APcGXRFiJ7Ryt
         TxKTIXpv6/zM1BcjSeD3InBsDye8RI5Mi7+FiI9mx/sLPjauEXXTPKJfYQfGycecB3OJ
         U0xI8cTmHSZXarWa0NEo12hE0bRmnE4yQqjOsBs8IGyo8cQYUVi84v0TRd+YdB1h7Oul
         zo/fwltiQEG4OABDRDZjwitkrrEiYJQelzYR3RGTy9XjCATcqzOH2usrKoWeiryLZthx
         FGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776628785; x=1777233585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6UF/iVRP69aP8wVCrm2EY96bha6HrIsHGDErfR8s64U=;
        b=faaE7eS3DG8KT2Dp/e5MRA2e0rfJpzMGoBLdR5ZUmEkiLk6hWiZe+UBM3S0yc77zp1
         l4oCPMlhMmoTFyBm19DmbilIAERoxlqwI/kUfWrhf2m5plnYsKoOb9/dwE9qfKuDCYo4
         oGtIrkBk0vFtM2fjzd2rt45PDDH3zJ7QPK/1Hxkk3lbYTTo+kU4PKdiwWxKUnj35Dgby
         p9AE8QfAdqhwszPMIoYVFTZCZU0Y4ik8IghLm4k8qzprVcihBLa0DCeBRsDaUhqp1RdE
         z4HHGw2S7RA23Y2TTAsepIkFUBcK4EFclAkHb+O+4ZGtHdv6wg54Aq8x6TMUomAFByb5
         pb7Q==
X-Gm-Message-State: AOJu0YwQH1ZUEhuCoCbJSfpWG9Hovd9dA339cKm2820tMiOnfiEFsEgO
	t27wDnuZeFIoGtA9kUe07QdMvZIX+J8bHEQTYVnAVLHMKFe8d9d2K3IoFMKIx3Lj+qg=
X-Gm-Gg: AeBDiesjHxjVzEbw+3/dToMhHDKFBapFknhl6iiDs3Dr05SXfHLo0INg3tCTXAo3mAx
	oHhOfQzfDZdKMDWwQAzor4+kaH6D5IjGjkjpOI3Otl9PHFKn58Z0IXXmeU6CwD94GLd3I7STD4K
	yGWD3sMPXKS2y/fwC8wAUyyC/z7mjBsC1W11IJc/jemRXmTh0ORv5jN7N/3vTL6N0Tnz/o7VZ6C
	/RlbZNR5GJoBK6WW5a/8cxadBxC2hAHgZmSj+NobKHTOwCoLjKR3sFThyqRnNY0wz+tQ7duvaGh
	m+tNOA12xNPmoV59hZ10FcTMemw9GqAuC6Fjt5y5hIqo8CjtXHjyKo0K76Z9aR66b56RBSlILoE
	bU9QbS29kJdkde8jDVQ4FyagNPW3juoZ3Ob+iqS3wwmJA5ukf03rozKfVZmoL/m8aSpYfqG8Yta
	pyhuw/O0Wb
X-Received: by 2002:a05:600d:106:b0:488:a2a1:62cb with SMTP id 5b1f17b1804b1-488fb8b5753mr98476615e9.13.1776628785173;
        Sun, 19 Apr 2026 12:59:45 -0700 (PDT)
Received: from fedora ([2a02:8071:50c5:5c0::d908])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e46471sm22482179f8f.28.2026.04.19.12.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 12:59:44 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: wbg@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	linux-kernel@vger.kernel.org,
	Wadim Mueller <wafgo01@gmail.com>
Subject: [PATCH v2 3/3] MAINTAINERS: add entry for GPIO quadrature encoder counter driver
Date: Sun, 19 Apr 2026 21:59:08 +0200
Message-ID: <20260419195908.12202-4-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260419195908.12202-1-wafgo01@gmail.com>
References: <20260419195908.12202-1-wafgo01@gmail.com>
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

