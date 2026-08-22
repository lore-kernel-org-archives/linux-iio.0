Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37973AC0EF
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 08:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787385829; cv=none; b=Z3p3dcM+olwuJdbhuXPDm1p630tGl+89l/Lmgf+89GW7k1HrDxiBTAxHI5AqRfY3A5/3ZnZgtxJEcVRTufYvukM2J/8U2AFZR94TSfdUQfuCvyaSpOwRlkYZRJ7C3zK2MWNrV2bwD+3XE/yUIjFizkr8Gp/FI9pUv2ZkEdRi7VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787385829; c=relaxed/simple;
	bh=dvAjdnNJVQJ62vNaNg2Z4X9kxYArIDzkbZ+sRlbauJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=owY0V8KIbnJuofI9dbtS9A9m+ZtnGTnb0HDPj1O1bG/CErE/zYWKVTqtcwEYA8PG91NfLHGzHMkvh8T3EG94lzrgDVRoSiF636r69iB/KD52HzqUPjpmC9qG1RLJVFx05M4dA8AJKInn8Hb4LUZD8CRIWFDkz1L9PrLo6TYVKXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdeX3Gfx; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdeX3Gfx"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c1c52d920b8so255664766b.2
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 01:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787385826; x=1787990626; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0lLTkI1x6cKq77M9uvYfmFj3xaZvqplfwC0PepDvB0U=;
        b=EdeX3GfxOKIx57w3e6p38+Qx6SzjgGOEYBLAsVINEUXHDzT1EN5O/lBeqhTxAyK6Ho
         AjleZezzV59cnH9dGVLml8NHOOcqFi2+7MrW/duCc3p/L8/9vWF8I05lCEU0aJJcrZvh
         mSR0TeKNBwVlSMVvFDkC0fDranDQ9ozqbl4lPWtu57pychujlm2ebfHrwNf6ghU+MQUv
         bnyC5gjRjsxCeI/IeTwCl69V4JbwPv/PHcfqIPlcJHyniI8yteraVXsSXMB7s1lCw4NR
         /G/DCO/N2bEHtpp7aKg41FTC70bwdkG6D8kbcEITLvuxivT7sHuIzLULBbJriZc24zBQ
         EsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787385826; x=1787990626;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0lLTkI1x6cKq77M9uvYfmFj3xaZvqplfwC0PepDvB0U=;
        b=FZjw2vYDlb0XVWlRZBky6EcZlmDjeTb/UNmwW3weES7ar0IO53V91uRBjR+fHGAbiD
         52/M+f+PMrc3Lg9hAlfD8nJPpfEBe0I3i5vpJivFBDIh6mib3+HHH6kuxcdtQlsiHHoW
         RPcjLLqPrYTAIPB0EWWqHT9TB5hJLLzqMWZHjndaAME9vtqm+lnzoBIGg1iApMh1gO5K
         zmygbg3MsAFXzbJI2s0wZVYn6ttp9qjQYjwvj+ThSsBU5+PUnQUjeHJvGxWR+KKFOqNJ
         sZzqzmulS8m4ZNrvWG+BCpPFLzpHSdaYeDkkNyzjwmiPEOR9M/X74c2Wx2VXqciLrPLA
         rplQ==
X-Gm-Message-State: AFuF++ldVedYtGOeLlLTUNU0Dqe1kvhX94tbUgW4dgEqcqfMAlBSkUQ7
	TuL5jCfFayIjnp+o+R++dzp48+LAF9c1uT6RGZ2bKkuSdZQAqKUHZEYj
X-Gm-Gg: AR+sD138+Pq83jnl1T8IZcxEBMRahwSgC7Uxypi78bsGvv+7ahk+iqvBjg81D0tpbjc
	t9IDFbNxp6QClEBU+7R4wrQulQzZ9DrzGfBQY4o1IpNqEDJP0bwkQuZuTlrbeiLBuhqZfCJwRUo
	qPyrk0bYONSHgSEQJpXXGE/Q9zhg8TljA5yRHKrmNI/3LswSG+HeYWBCK4Qd2fXspn3kttmfh5t
	EUmDuiweepf+2lzsZTrCJgA8vF7cyUk/1Q1C50F5ypaVtg898iHZrLYCy4blbJWSlzCTJGNioAc
	x96a5P8b992SHjITCA95uxhw5kALCblq9LtTc4ClhcKxWzKFsDicdmd8jcuFPDr0aKacfGxSl7B
	cp+P3RSxdy6TNjWedt1JpeVxUs4VsoigiWHVUWmrFlAYK+smmrbiCV8Cs4xKaYlprjoCDVRr/+N
	PWH5kzU9oKonL3wQnS0BAFzSBz3dWpBKQk6hnw8Fq1qQgqQbz+DSiIlZtt2mvvdbUrqA9O9gxAU
	3j3cIhuPWAgp8Yd0DULw/i/1M1kAIscC7wOorZ44ayQ1qgy0G3VVAGeoLYW2mnk521estVCnHx3
	4hpQ2Tlwkt/+b1DozrP1LYlt4KQ8i8Lt8dyrygIyCIXKVJgrl6jj0x9SjNhYCogEJ4GWvFCo+oB
	rj/XAJvAE+uq5505UHaeelNqp
X-Received: by 2002:a17:907:1b09:b0:c24:670b:7750 with SMTP id a640c23a62f3a-c246a60ca8cmr1164928166b.14.1787385825800;
        Sat, 22 Aug 2026 01:03:45 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feeca188sm11114235a12.6.2026.08.22.01.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 01:03:45 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 22 Aug 2026 10:02:28 +0200
Subject: [PATCH 01/14] iio: temperature: iqs620at-temp: separate IIO header
 from others
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-kernel-header-removal-v1-1-ee31b124be11@gmail.com>
References: <20260822-kernel-header-removal-v1-0-ee31b124be11@gmail.com>
In-Reply-To: <20260822-kernel-header-removal-v1-0-ee31b124be11@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Crt Mori <cmo@melexis.com>, 
 Puranjay Mohan <puranjay@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787385823; l=894;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=dvAjdnNJVQJ62vNaNg2Z4X9kxYArIDzkbZ+sRlbauJo=;
 b=UI5tmbH0Dk8iI5rXgLTmAdXpNXXcvtkNDro/38j5I5WgEib9EJBGYTTDZRhNr6TyQ1delA8f4
 MTmr2oCzus+A625wPxFMCwklgO9I21QLZ62x+bDAEf0WU6NdU/6IKdd
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Separate the <linux/iio/iio.h> header from the other generic
<linux/*> headers to comply with the IIO style.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/temperature/iqs620at-temp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/iqs620at-temp.c b/drivers/iio/temperature/iqs620at-temp.c
index e2f878d57af7..24b4d50740f3 100644
--- a/drivers/iio/temperature/iqs620at-temp.c
+++ b/drivers/iio/temperature/iqs620at-temp.c
@@ -6,13 +6,14 @@
  */
 
 #include <linux/device.h>
-#include <linux/iio/iio.h>
 #include <linux/kernel.h>
 #include <linux/mfd/iqs62x.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
+#include <linux/iio/iio.h>
+
 #define IQS620_TEMP_UI_OUT			0x1A
 
 #define IQS620_TEMP_SCALE			1000

-- 
2.55.0

