Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0443A9632
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 19:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776712527; cv=none; b=ZZkxJ3pRF+1zVf71/y42rwWQmRoim9bQw6Nxbg2WuV0eN6o8yeuBUWkIMS7BqCYW2qOUk2Jy5B54zKObTuwcZT9SOg7r573sUreqcoJyJbuhodVSR63CbAd5UNf7hs6BOrq6EAOtCAssQnnMRorNrtpI9CJm0YyODwqn/xSSeA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776712527; c=relaxed/simple;
	bh=ZSubsmiMuRkCE7ooxCVlbL3d0pAXvXX4NmZgCqVftv0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZS95n1qpIgsDOyhIE4TfISFWKVp0IJ+TiqucCbo77WsVWgeUtQkfGqKda0XrwS9QVziHHExlybynQ9sYqkylz1Rf8jhY6dd+/vNhv5tdSCC0JYB5WW+yWfhaxriUEjdL3ABJAQZgm3Qo7Rpiz3igTF1UvN3Xu8Ke5vONkIaLUH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=Qg4j13xY; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="Qg4j13xY"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12c726c30efso2987072c88.1
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 12:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776712524; x=1777317324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LgDGh8Ddwl85zVpNGmg/48pkhDNXoAEqQElPkvjtK1k=;
        b=Qg4j13xYozIgWsF7Qg00OLz+wvwUpgxZjcrFGHrnEvkM8s1URV3QnOlp/4hGdghVEb
         4xJjup8Ke1xRCHU7z4ZwtNOU6YlYmrTwbf9P2OB4YixVKSsJ18bgP3ZrrhpI3ahb/+qX
         Jjo6sO6a8BeBeU8lZklsvyF6OjmAivhsECEXwrICagA1SEVc/9rKuK/Ia7T6azau5HqV
         8rlEWld30Xgoyg4ZydWiDSPkWt5Y8Io2HTC2+XrnFX4lDC24s2/LVegLbNu2SrN45pAK
         IwvgBtdGelC0GCKOdbcx4sCLk6BicpbFBlE7eHlo5YajSEzKUJywIGE/6DKD9kdz739f
         YlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776712524; x=1777317324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LgDGh8Ddwl85zVpNGmg/48pkhDNXoAEqQElPkvjtK1k=;
        b=h/VpSqJyysdGaWYbYMYfeP8a+Sys+/F3PTB7sUBSp3QdHk9k8K3S6bfyuJhviaw+x4
         KdwR/yJVXKFQQEfe2QALuQL17iCqnKdyEtSXxPFCSoZXfJGpL0c6X93zJ8bZuAobcvk9
         /6+woArGbliZsTzaoCQg/kUGYqHROd5Xd/1KTMp761KoSN6I+nWbQDrwCqpihhWI1mNO
         +PfPYI5rVvw6Nbr0fWNxcFKmV3NIvZ2XoVE3FFTgr+1Y9QDHr8JCNOimbe8UkuRrMX+9
         DUea+/5BC4gtxmMfZnhXWzbIkqy5Yi1ZBO7Dra6td3iBEu5wJCAzLbTxpQ3Y9gDFpfVO
         MX7A==
X-Forwarded-Encrypted: i=1; AFNElJ9c1wMeMbKkJLAM3xYOUld1jsNCYSBirBCkA6D2u55rQtBCmDUT/6j9H/05Wpgx6Aw07NCeTUm+xwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdj3/mX/D1psoWLtUTlPyOc+kzMQDbIZejDgCmcbws6Z78Q6q9
	L3xWHI+DkR3J1miuRxbNcLKIxUjnfj/4CCAAqQHSClPsVTiFxYuoXxyijfdg3NsYwuV2DQFeOd6
	VgnhrnI5j8Q==
X-Gm-Gg: AeBDieuaBl59/qRyiFmJy2CkBCLB9RQ7MZh1Pt7kDK4mzCCKAYKFYQXGiKRYjm81AeX
	9CgyLqZOfhvoW6EpRJ7m+WLgYqxTduz/WhwWD7zpt5XkwWskGYP/7OjkXTtILhm8jwqcaUqg7J0
	U4PDakpC9PVCaGccs3qes11NrcKpHVLp35oOgks6517PZioYHTvI5AVowvDuX1tWpo/O3XLqyTl
	iF5j0Ax+hJEAGO2CzRskAT/X/EbTwo7pgJCOI7+e9dt3jGfrJcpikMNkfmPUerRXG0rTEDKvmm9
	USVQtgIp8vc/h7pKr7EId55HDn92bDcWy1TNHJRVw/bKrrpLf7hVs0/o+ThRXx4DvKdAjFZ4tvR
	jdEj3k2RR8ClBuN5kGELzEfa+hgAGg9K9U0IBxx0OnXePZMTwq6wLWhpEKGSiOL6MNRk8FET/p0
	dqavZPPSvY4pjPQQSvBYcXu1nUr938+z6hcFkteGYxnk3dRKm/JEwc7SXnL518
X-Received: by 2002:a05:7022:ec13:b0:12c:6e85:505c with SMTP id a92af1059eb24-12c73f6444amr7013499c88.4.1776712523591;
        Mon, 20 Apr 2026 12:15:23 -0700 (PDT)
Received: from avocado.. (mvx-177-92-77-170.mundivox.com. [177.92.77.170])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a2ac32sm16106846c88.15.2026.04.20.12.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 12:15:22 -0700 (PDT)
From: Marcelo Machado Lage <marcelomlage@usp.br>
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	nuno.sa@analog.com
Cc: Marcelo Machado Lage <marcelomlage@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 0/2] iio: adc: mcp3422: apply bit manipulation macros
Date: Mon, 20 Apr 2026 16:14:53 -0300
Message-Id: <20260420191455.529923-1-marcelomlage@usp.br>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set rewrites several open-coded bit manipulation parts of
the MCP3421/2/3/4/5/6/7/8 driver code using bits.h and bitfield.h
macros.

Marcelo Machado Lage (2):
  iio: adc: mcp3422: rewrite mask macros using bits.h macros
  iio: adc: mcp3422: write bit operations with bitfield.h macros

 drivers/iio/adc/mcp3422.c | 63 ++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 37 deletions(-)

-- 
2.34.1

