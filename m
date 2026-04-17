Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B9C2F12D4
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776445089; cv=none; b=dxnvl4881Xt7pOnTvCrh0Uw0GC8gZ9FdhyZ6zOl3ISj0cjlmeCHwbgXhBqhbqWCUDbNRzbaoixDvKa5U9Wrf9/Z5ieSE6tpEyMdr8ygnP9uWP8VV36UrfszJH3F/vrye81SI5wcUY2hmQ1intG4OdsassEmsHGrXG4mz6Yf+ZeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776445089; c=relaxed/simple;
	bh=gl77M1w7xwsMJgW84cLwI7+KbvG4SV2W2u2xiOShvfk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=prw7Po0WJthRuFPsmG9srRh77tRwiKzJxhKHpdEZNbA0XibS2j2SRr6KQkSwOClJZmITg2JIAobELvBXcEy2a3e5xhifgQT6W8UvJ1TB+HG6hqXUy250qfO4Jjpsaq0T2QHcp2XjOEhVcRqA9j8ow3oQWs51GzFELn7la2R361c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=jqXraQS5; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="jqXraQS5"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56739adfa1aso667895e0c.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 09:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776445085; x=1777049885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=29f8JejsjllPWUoe4ucgc8TPAzPQ99R9tMm99pyfYV4=;
        b=jqXraQS5vVKtKNVSu/vfOWxY9cZxyACta2ZbbG7BJMC+W/299gtzNJs+GRSOFUAB8M
         wtuX9TDN5zZCfHC7OF/IygH2THe/9m/KI0pf5TEbP41EgenE/3fLsRBV0wmGkVA0TnKa
         0JvPmWxDBicjHzqMGfNqn4w8Yy30YQxC7wRUbHnPdkaY5u5AgQBnKZxLb6ns4bNyLjP7
         p7JIKkPmb3weEUYknHl3NWY3AbRVmBdg7LhbbBHeFd4vcX5NAXbeJs9d4rfW9eRvbufn
         WcplobMR8WJEnNFh086I8bLe+V7PXqESFw+AD0bW/SAK98DtNGdNRp6yRHMvz6PZWfg7
         XmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776445085; x=1777049885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29f8JejsjllPWUoe4ucgc8TPAzPQ99R9tMm99pyfYV4=;
        b=sfsuMzEaAuAOssjbXMc3YzQ0ChGenMObwvBqCemvgVptrJRtzxHk2PpnuJ5N4akTex
         JfHttLZEuMj57ZOqabZcleHv03p06ES/nFxzQwcex5LbIGXsnFBG7iAZmY6nq3bwpYOB
         ui9D1mDbf184GgmYikowUxgDt0hpiQ9txckEPkAyRBzCkRVVQaOdeQ/1e//SO1N6ca6N
         SPK6R8MgTcBamIKKiaBOh/7uh/pdPHDXiP2Bwqszrf0f5ZJ3n7PRzBRvcyNjzf7lhrF4
         CBLUHVr82kRF4cWJX/UNKTzur+eDdgdqEAan0+ndlvRpQA+8ehwl96ctU5X2QadrB7dG
         htXQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Qna63qLHNJnbzS/F4q29gZ6VoJ4ZYlvf8ifuq/3vvClkLH3l5n+aAGLFRfn0seouBEnofMUCBRS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgQXC296wl9OLXZVpGjBvEMPBUFhBMAbJN5sSAmzdJg4iC6ltb
	qB0vbNzInVoMJ1GHBknY7s8ce5gpsk9Bl9Z4/6PN+LRQ7pyFj+C3iSg8zF6TGMFXZkU=
X-Gm-Gg: AeBDievbGlix2xu9xsmjvpYP1W7KrF6CBf3EgwZihGSc0GdKNXKQ6m9rRiov/q6paJK
	q4MMQ61gawLOKe4VJlpT4jqZu1kx08nMt5nJOet/+hffi/e9ZLpEKzJcuOZdFY9zsad+rwmGC5R
	ZN3RltFheU8GZ14wpUor+9CQweLyntbEFa9IE6KswdUEn9SnTiEs4r/lv+JccB8BTThDEIKqxYr
	86pcRTfnAtDUggHeiNY53F+kpjh+TRbFXC2z7z/kNefviMJekzg+zEw3MKzzD9tTRM1EiB59Dzn
	88VxJosEgjHL7Z+kMotgzEMceLkPafmgvBP/ORVHndEF1MFMnwp9Tdteh3WKJxPFVLyA6aYM1DY
	yXrp2hdiyCwQrXcd1MaBQ5RL7FjmShjkp/zMX6JMm2TMF+10pKLbxO8gUJuaJ3kfCZxNbjWTK+1
	TtqKZW6lOuxwC/nK95i1LS6053pvCFI9KbJu4LefrbKLrk1z46JiRzkw==
X-Received: by 2002:a05:6123:2e3:b0:56c:fe16:f54b with SMTP id 71dfb90a1353d-56fa59b2e39mr2278029e0c.11.1776445084681;
        Fri, 17 Apr 2026 09:58:04 -0700 (PDT)
Received: from avocado.semfio.usp.br (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa91bf90fsm1195622e0c.1.2026.04.17.09.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 09:58:04 -0700 (PDT)
From: Marcelo Machado Lage <marcelomlage@usp.br>
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	nuno.sa@analog.com
Cc: Marcelo Machado Lage <marcelomlage@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 0/2] iio: adc: mcp3422: apply bit manipulation macros
Date: Fri, 17 Apr 2026 13:57:45 -0300
Message-Id: <20260417165747.507487-1-marcelomlage@usp.br>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set rewrites several open-coded bit manipulation parts of
the MCP3421/2/3/4/5/6/7/8 driver code using bit.h and bitfield.h
macros.

This follows a request by Andy Shevchenko. Thanks, Andy!

Marcelo Machado Lage (2):
  iio: adc: mcp3422: rewrite mask macros using bitfield macros
  iio: adc: mcp3422: write bit operations with bitfield macros

 drivers/iio/adc/mcp3422.c | 60 ++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 35 deletions(-)

-- 
2.34.1

