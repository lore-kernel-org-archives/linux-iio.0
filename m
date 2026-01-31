Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1084430AACA
	for <linux-iio@vger.kernel.org>; Sat, 31 Jan 2026 07:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769845129; cv=none; b=SLl6CA+LEl/Evpj2Ld4rBVhs6yUDre1JY2M6iX19J5jqx4cZmHB/aQUkFG94UEUBneTUpATvasqBBHhh42O9VC4iStCItvrAdmOO0fLflpsIp4Yds9jg6Pb5wmLFpGzukKaEUDLzuioLUe84KhgpldL4NTbIdMmu4xNovpDCPi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769845129; c=relaxed/simple;
	bh=7aqbCCJ3cNIjap2RyyMRc23UzcYoh2GgCZUUzwZRJe0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QNCYjNXdDsHvC+/ZIfCpRor+tVRTHGwYd7Q+zu7KISB4pAlNeZprhBznxN7se6H6eYEVMSnzdCTbZt61Hgb9iCJ8Ua/AfT4bs8+Gp9kEnh3gOHTtSTF1wXlb2Il4SfFRIz1etWETgLLyHnpU5mznW1o/cta2vKsFXSqxieVDKMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgCLcgt1; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgCLcgt1"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b704f08e73so1600523eec.1
        for <linux-iio@vger.kernel.org>; Fri, 30 Jan 2026 23:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769845127; x=1770449927; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QOS1jVACnptxdFytd8AcMZXdBxmvVr3DfIRt4sfvRMc=;
        b=VgCLcgt1bcvqsYdbetS5RnIinB8ZlWoM2iGC9TNV7FOFqOWpCGHZE0SpvXG3V5c0eH
         bkF6RzzBYu+F5AEsKaBtba6yoC7RBa/m1aQkr6x4nNfQmAgmDX47Wv7ZcMcEZfVy+k+V
         wVwg1wjvPkHa0Tj8jgVDlLmlRZkoWk5hG+pxmLmRK0awtXH0mL1tLNCEHXvAffzeP19b
         +HBWUXvzoXIpWAiQmJzY3nfi3HsQSJbl77noWSwrrEllEpf1R5NIg3Vx0pAYY88I3s2j
         Udf5t+QM20Jqw3j+yUSnpvZQDWmS5Ey4mqdIlL2gLII/zZf5ic4pco54Zu99EW2qOR18
         CuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769845127; x=1770449927;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QOS1jVACnptxdFytd8AcMZXdBxmvVr3DfIRt4sfvRMc=;
        b=C0d7DeBeLqcMhf0b6t3kaQRAi09f0pda6JMtot9dcZFF3QdXzMv2l7W8eRIUQP8BOm
         WsQfG83Qt8LTVvNOlY5shswoZYKoLIM2ZPOc/OtcLa9veXcgUhyXSvIdajDTwYhWkMVX
         c0XeyBuzTssmW6HaqMRB4Gfn45ou4AEjst8vHKjO1jOhc0ta4GuD3GeTA/Iz5QQyWoWw
         JcdJSQQqn78llND8JjNuXX5cynbIOljhpkaPw+cRPSuHsNu30bYNgg/whtnHJwiGPoH6
         FQUs56j4qyFJG4aYDlwSvBUq4IvGXyBZ+G3ol+4SmAAwagzq02gjAz10I4oSQZhH0/QV
         yUPw==
X-Forwarded-Encrypted: i=1; AJvYcCXqWIXsUdub8LFzbzeK1Drklq6X45AyIbHgrjykY4BaGeNSdJosNaioAYTCn/QPMQNQOrnJyi9+Jqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ExsCTLw9+n6gA+/aKBNLkV3FMhK4Xn84Y3ZvpWgtOXd70YLF
	dXYY848Jjjhah8n3GJQ5omIjOceYXI7BiTR2+6LL53Zh4ay1HIA3nNZ3
X-Gm-Gg: AZuq6aIiAhHysAkRKQUizABVthDtRfJveNpeNZ593vVCv/KIYHx/9tZNYlGZdY9eQnh
	RcsqEVLhx16AnD/72SV9NzIyHtqcbw8gZZbc9Pv0ExBY0FjeY7HqX0KdXVKoQAGSkYn/Gr20GOB
	NcGzXfMZEMdJSxDUj9fb6nmKYkQHdxz3p0qN5OX5J4jcA/Xt1DTI9T5NE4UATj8QAEXeUNfGXrR
	ukLLC4OoiCGiIzj5HszxCzpvzWpARVBdU2JZvye39jufg1n0DqzOVu33SeG6HsyI2hAhxF7A5lh
	RuUiAc3shTyGgrTV9u7B4ae2Y0IC1ymyO1pCnV+QEIT2sWhU1ZTKBhJunOZhCwyIyZldWCgNACw
	J2hoVi8VFW5Y4RXeMSHif2ZvTpukksGavQxIyb1fNerkc0MmWDbDXW0G+DUUt0ud04fbEqljbFP
	ZmIY/A18a05g8dmwCaaCG4BgV6cw==
X-Received: by 2002:a05:7301:678d:b0:2ae:5022:fe7c with SMTP id 5a478bee46e88-2b7b178aae9mr4054074eec.1.1769845127208;
        Fri, 30 Jan 2026 23:38:47 -0800 (PST)
Received: from [192.168.0.61] ([76.174.137.141])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16cf8d6sm14337027eec.3.2026.01.30.23.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 23:38:45 -0800 (PST)
From: Michael Harris <michaelharriscode@gmail.com>
Date: Fri, 30 Jan 2026 23:38:27 -0800
Subject: [PATCH 1/2] staging: iio: adt7316: remove unused macros
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-adt7316-correct-macros-v1-1-8a71df1e42f1@gmail.com>
References: <20260130-adt7316-correct-macros-v1-0-8a71df1e42f1@gmail.com>
In-Reply-To: <20260130-adt7316-correct-macros-v1-0-8a71df1e42f1@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Michael Harris <michaelharriscode@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769845124; l=1508;
 i=michaelharriscode@gmail.com; s=20260130; h=from:subject:message-id;
 bh=7aqbCCJ3cNIjap2RyyMRc23UzcYoh2GgCZUUzwZRJe0=;
 b=NGX7ge1pSXDuDL0B4/Jm5ajydDs0Q2K9iAfzSKgpTrREdkmczKC3zeyQxSkYevJqKa8MfDL55
 lvNtPIf++KpAYSoFmvZaOybeuggM4CDNtpkiAra1LiP4zqVw1Up/gym
X-Developer-Key: i=michaelharriscode@gmail.com; a=ed25519;
 pk=td/zQD3XANAhdG3Kf3mSetXiynk1Ql0eM4s0+eks5DU=

Delete macros that aren't in use

Signed-off-by: Michael Harris <michaelharriscode@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 8a9a8262c2bec34f3c3e79d8174f492b9a23fb70..4173c8822fff495e8c69d9cf6c11be9e9227a8c1 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -111,7 +111,6 @@
 #define ADT7316_AD_SINGLE_CH_MODE	0x10
 #define ADT7316_DISABLE_AVERAGING	0x20
 #define ADT7316_EN_SMBUS_TIMEOUT	0x40
-#define ADT7316_RESET			0x80
 
 /*
  * ADT7316 config3
@@ -154,7 +153,6 @@
 /*
  * ADT7316 value masks
  */
-#define ADT7316_VALUE_MASK		0xfff
 #define ADT7316_T_VALUE_SIGN		0x400
 #define ADT7316_T_VALUE_FLOAT_OFFSET	2
 #define ADT7316_T_VALUE_FLOAT_MASK	0x2
@@ -194,15 +192,6 @@ struct adt7316_chip_info {
  * Logic interrupt mask for user application to enable
  * interrupts.
  */
-#define ADT7316_IN_TEMP_HIGH_INT_MASK	0x1
-#define ADT7316_IN_TEMP_LOW_INT_MASK	0x2
-#define ADT7316_EX_TEMP_HIGH_INT_MASK	0x4
-#define ADT7316_EX_TEMP_LOW_INT_MASK	0x8
-#define ADT7316_EX_TEMP_FAULT_INT_MASK	0x10
-#define ADT7516_AIN1_INT_MASK		0x4
-#define ADT7516_AIN2_INT_MASK		0x20
-#define ADT7516_AIN3_INT_MASK		0x40
-#define ADT7516_AIN4_INT_MASK		0x80
 #define ADT7316_VDD_INT_MASK		0x100
 #define ADT7316_TEMP_INT_MASK		0x1F
 #define ADT7516_AIN_INT_MASK		0xE0

-- 
2.52.0

