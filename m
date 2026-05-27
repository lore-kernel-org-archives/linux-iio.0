Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9994143D4E8
	for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 16:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779900245; cv=none; b=jDRz+MyCEAupFFev3hlMjRseuzBAxo+kadZkwbOeHcjf/V3PNj2ui7i/CT3/hlW/PmiqSOLxtDeJYH28ljoXQ4+p1fvYSefR4QB8YVYrc3FTsm+g9SgSUKUh+ekyGmVAznXvLUH/IpwnfeWH9zyIv/OUK7JJPaKnY2Zwi8UDxA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779900245; c=relaxed/simple;
	bh=gnOeq6nevR00p4BRCG+3LdG76HL3esTC8/ZlNWWwurg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjpB5hvkAKPe0raqxVF6W44f0zM9+MFw53vChKSQCAEoyOj0ntVhszZgVWLq6AGJ9qD0ABdO4yfT2pvj+LfmClduUS0SxxWVKFQtBfQ5rmdXHIwRHtRLQ965O1D6kdk8G0+k9wDxZ2SMEPI4+5E61sy8qHY1YM+7l/LUYGC1VGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ch5TprY3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ch5TprY3"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49039a8851fso63939905e9.2
        for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 09:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779900242; x=1780505042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSZav8ICoF+jXsdpo13Wmcy7+dFcmblDEv6LvCijgmw=;
        b=Ch5TprY3dv1g61FmU8jFkeOGrZB2lcjcxE8zrZdO1epYMjHKwPKgsT+kv6kYYJYAQu
         n0gbIR7YfsU0XUYma2A8j1SMqqLjYJKAsSBp8t07IiTvSrvsKoAbOTrwMHXjxy2/bUFE
         PF5SKphM58U504j6nOH9NalvYMCNOGV1vOCi4kEIUOzCGj2Kor5QpARFp33m6W3R5KUz
         4Ohtmd0X332Cd5yi0zcYmM4GpnBKhUVaycp8dQ0uSrqxCdplvCUjmcpKCd1QSmEBaztp
         COTN+0hI47tI277RFyrzB6GzL+a3DMWPaFvrEmGpPE/L4en+TpqzkJ5Fl9ugR5loYyWl
         zSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779900242; x=1780505042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XSZav8ICoF+jXsdpo13Wmcy7+dFcmblDEv6LvCijgmw=;
        b=iATCs/vqqCDFU+LGYfpiha8REQhZqTW5OlAuXpKdLGW3By3FLuGAdPYHzbtu4nMwC3
         Mb8ivM/Xw/4sSKoUJhSnq9fuV3zl2sUvT6LGb6MDFEol1v04Wd/9u3FMv4bGZ8w7Z8fA
         2x5q3fND1Vx1LL9j7HBHen8AvPrg2JFIRps65ETYuJEitgV2iycijfuUMzyP50NdevKL
         fFzAb3mRLmpQ98IGV5DkAJFYQbQtDVj8JFYRU126/ER+mlCiZYtjRxfHwut7vfkiMPqP
         tXdZDnbwdMFnjc/OLAdPsMiSocoSomTcRFcjEXnyfHkzAFsnicR1O9QoosF1LJ0vD+ny
         DLiA==
X-Gm-Message-State: AOJu0Yx1U/Dn2ogzS1QXCPA/ITFMZ0mxonpICXiYLe/8P/d2KbzrGDWE
	27yH+KuW+zzZb4EFONLnuGy20CcK7GDMuxqn3HNYhEKY9i1vssTaFpiw81JahnsF
X-Gm-Gg: Acq92OEgKXNctBVYEHrKhekCyd/n1ijkpst4catGEJpqV+Ype3AxhaK6uEQj/rRpaoW
	s2hO7pBbg05WHn54j4TT7saIjXoz5mgV7XcC6xeDUXgaVYszETj8gtN+WJPg8OdNWGMKUn8m4fr
	zh1EgMuxc0HX3hhd43mHK/IZr3XkwCd7WrllGSrsOUtCZj8rfmvOL5rA1qD7WWhdJ+BahCer6pM
	v5lQ4kOdHcXiJwfF518MEohgaRpv8DUPEwpd4q3/xBlvLTfRQJcJWO+pUied0aypnbQIb9PdOMx
	ZEz3MRyYID9auJATe+Hel2jbu3eLIupMtj5pO9pCI1DtBpekitVstToUF7BYdSRmYVEH2ptHfzX
	A41jS2Tl2Q7AEeUy1azKT5no3fnIGWWyCvG0gavcg+5RVibSq+bVKWJKxTfKSJsSefpP+aHQbNL
	KQsDtlo5OJPexIgauteZVKplyXqI7F+/SFDbpSt+C+dkFjRUGfJJfakgnM
X-Received: by 2002:a05:600c:604:b0:489:e696:8362 with SMTP id 5b1f17b1804b1-490426b2902mr269501235e9.13.1779900241784;
        Wed, 27 May 2026 09:44:01 -0700 (PDT)
Received: from MSI-LINUX.kielce.vectranet.pl ([2a02:2a40:27ec:2900:f829:aa3:9ba8:c8c3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454c5eb0sm436435435e9.2.2026.05.27.09.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 09:44:01 -0700 (PDT)
From: Jakub Szczudlo <jakubszczudlo40@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	Jakub Szczudlo <jakubszczudlo40@gmail.com>
Subject: [PATCH 3/4] update adc Kconfig with ads1110
Date: Wed, 27 May 2026 18:43:11 +0200
Message-ID: <20260527164312.355729-3-jakubszczudlo40@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260527164312.355729-1-jakubszczudlo40@gmail.com>
References: <20260527164312.355729-1-jakubszczudlo40@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jakub Szczudlo <jakubszczudlo40@gmail.com>
---
 drivers/iio/adc/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a9dedbb8eb46..3f2bbfb24daf 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1756,6 +1756,16 @@ config TI_ADS1100
 	  This driver can also be built as a module. If so, the module will be
 	  called ti-ads1100.
 
+config TI_ADS1110
+	tristate "Texas Instruments ADS1110"
+	depends on I2C
+	help
+	  If you say yes here you get support for Texas Instruments ADS1110
+	  ADC chip.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called ti-ads1110.
+
 config TI_ADS1119
        tristate "Texas Instruments ADS1119 ADC"
        depends on I2C
-- 
2.47.3

