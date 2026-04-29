Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B83C10F2
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 01:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777426675; cv=none; b=G2e7l5km2nB3mJnJx8tcLgI4L0LiXWM+CzALTgtHKN+eyBIgu9dlegYEOChei+FXSrAbn0X8/5jnBgUmJoFYy26FBZCmSihRzeTwJk4r5UQ1SioonDcgQBQQY+3/cD1KW1HrlWo2ri9TlTYY+s7E8xGtmrwunQtfQJSJPl7WHjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777426675; c=relaxed/simple;
	bh=cyPiDJjoKP7MVrCsdguzwkmZ1AXGToSRzYUEJQ89j0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t3h1MaVltOHJG1sL6GR4fTOTLCDCUJFT6rn2tDtClqoRVU7CXiMRT6CCWF69aAEIrr7fywYM7NzRRAmBXqXnJ2cXgWVYPDzl3XCt/EQlRkOWvwr1zjzySn7qrs+bbAhHlmHNxM+kDRpRkvJ+kWJdO0GIj5qpZ3voRBvB0O/cAxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=fnwOKF5M; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="fnwOKF5M"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7947cf097c1so114258237b3.2
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 18:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1777426671; x=1778031471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xYvcj3PZ0VKhlN+5p8f4HoZeNyLA48Vi/zoIdpEXU38=;
        b=fnwOKF5MjyZ4ORYHTFYpuvjFuww+jFVKiTXYRZUgVL1b6BLu15FiPgOrYrFIGQN0pU
         EZlFPUgP2m5IWHIqeEyuqsqoRjBdbFcECx8hBJjE22L08cJ987Uenbs5EdvAjF0TJ2s8
         iTs6CNRh5/HkNvjDVJN7z8G5Z5tD3IR/xnM9MCsDSCPkeIn5Uu/wis582U3Zb3frGMCj
         1EM9wqLMVvVodjaFaTeo2SlRjMGTns5jkfBWfZvX5PtLK003/JslluZTJJLXn11igFcG
         5WrCfQPDmBE9tM7x/2A5dgdMSsI9j1QhDFjP/mhqDTkWE3MU9Yb6a3rQHivbyLQRyWz6
         UeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777426671; x=1778031471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYvcj3PZ0VKhlN+5p8f4HoZeNyLA48Vi/zoIdpEXU38=;
        b=aQC8DFSpScxYOmJ9QpHwgIpMiTjlyEnvaLBvIW8CszPczg0MA2Bohsf8CI6ivFb4/+
         ox2lb7NCUHdNA0jfMyyuwdJ9S7/WRUO4wBDDEX+dawe6rNRrGu0eTw7+vNjkp1AppSGD
         dKPE5Gic+a87iCW3NnsQ3S+CorX6GHGh8jDmqDasZFXIolLwegdgDXdm8+jIaKNU8UvI
         KrlTnNzxbjDfA+Wy8eOhzyUXBvNJScFUFiyp/93w2yuVUEix7WU+eZ83w7nYGkqkfJtQ
         UmvcoNNJpxSWCr4GVtdvnWFdc+Kpp67Ari2isCOs3qo4HxG4CaE0ccs1a0+1L7SCAlJ5
         Uzgw==
X-Forwarded-Encrypted: i=1; AFNElJ8s5v2GRoSw4DaPWL0Mb2UH5aw9coiWTeNw8alen6ELOZ9kzWIpkCT6rPfeOBbGfcpRbvwuiIiqxCw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1aSTuYNJtZrLVZokMUjlox3v/Gsu1alqM0B3TNb/BsZpshLW9
	FEA/7Zg3bOlUXY7mPvYi+svg/HSInaG+NcoCm/9rD1UvBBasYtq68POSdAaysv2rlj0=
X-Gm-Gg: AeBDietjI2tTDRn7jsYPL4kGP96PgWIHwAJGZ+Itq/TfCP9AHukRcR0jj8ZRuq/MxL5
	4MXRKBBq1Zoct6RKOeEqJ0/8TzgWChj2TK7klAJNkSmg5k/11WxLEGNPT0bzzbUxZdEQH6mEB08
	tXgWeXJ/xKEh+zfaPn4PWPAJZtVcYS/IE89FevsLHXBKy4B2sf2nCJtP65BeYCSdfts8gWvbikl
	Q06qhJcM1qv8cTqRH0U3nuMuvjb/7QYMmV8VcxddSEVQxR8t76cX2HBOhSb9qeSmaaVpeDSbaaG
	MIVblYQBf2E5cdpZq621zSHHqlIBA20WANFBvpvVlLet5UiHUa972xnxY7vgDNLkkib3xCWGTIG
	eDRCEHKAmE0hDxeXUmvajdBPvBKCRG8xtjJ5OGCKyBJviA7GmVQSJDKtblV/iV0NY2tuiTMtWbr
	MnZMm2S6pY09/j5TTUlIu2pa6DJUvTmfTuQPVNk3YULfxgIiXtVJoqbQ==
X-Received: by 2002:a05:690c:111:b0:7b3:852d:eed8 with SMTP id 00721157ae682-7bcf520251amr59331717b3.20.1777426671354;
        Tue, 28 Apr 2026 18:37:51 -0700 (PDT)
Received: from pedrobgennari-Aspire-A514-53G ([191.19.131.187])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd259dc229sm7182457b3.39.2026.04.28.18.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 18:37:50 -0700 (PDT)
From: Pedro Barletta Gennari <pedro.pbg@usp.br>
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	nuno.sa@analog.com
Cc: pedro.pbg@usp.br,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 0/2] iio: light: iqs621-als: use lock guards and prefer early error handling
Date: Tue, 28 Apr 2026 22:29:53 -0300
Message-ID: <20260429013640.26870-1-pedro.pbg@usp.br>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use guard(mutex)() for handling mutex lock instead of manually
locking and unlocking the mutex and flip 'if (!ret)' to 'if (ret)'
to handle errors early in drivers/iio/light/iqs621-als.c

Patch 2 depends on patch 1

Signed-off-by: Pedro Barletta Gennari <pedro.pbg@usp.br>
---
v3:
  - Remove unnecessary { }
  - Remove unnecessary ret initialization
  - Flip 'if (!ret)' to 'if (ret)'
v2:
  - Keep include list ordered
  - Remove redundant 'else'
  - Remove unnecessary variable 'ret'
---

Pedro Barletta Gennari (2):
  iio: light: iqs621-als: use lock guards
  iio: light: iqs621-als: prefer early error handling over if (!ret)

 drivers/iio/light/iqs621-als.c | 111 +++++++++++++--------------------
 1 file changed, 43 insertions(+), 68 deletions(-)

-- 
2.51.0

