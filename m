Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0441747D95A
	for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 19:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777576013; cv=none; b=c2rDjjYTc9YcQm3M0Y2vAuFNm844RGqLliTOzVaRhmkI2as6HgKUNzqLqi/UJW8l32Wl67jUpGKYJL/3rPhl6aYgZBTjByPJDNHVMP7kZz+YbhGY8yH94q6mSkiIiMNxpeqi8WKbJHyCTZlZaHP/vgFMLcQq/pvxo2zQX3D10KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777576013; c=relaxed/simple;
	bh=fEsnZrRsvrKBNzg7H0bCEZoR5y9jdaPRjz5QDndHJVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VrpYa6tc1k/wU4UAzEV89VoX1X19YUMBErT33AO0XecxjVHsz8l6ml0tNzOMWZPggYf3Ys0818Vgi6W0tHkYCkfaRcnNKiob6uZwpFXThYe/4NCjcmO4D3SO45LgIfdL38RnosDFg8ow88FXu6nj9AXSw+mJV/OwZ/EEheSMWvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bN7HctOr; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bN7HctOr"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so1021597a91.0
        for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 12:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777576011; x=1778180811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzRtJkU00CuLLmFgM3t02EkjasKtqNUWug+c4hQSGm8=;
        b=bN7HctOr7NFwV50L1YTwCozB0Qso7J8LGt1BizGKqfSfUdRSo0SrTDnCfbBe1W0e7e
         BypJS+bTD7ps1Mq8AtVU9mMT+cistwxumpU7cww3CYM4x9ievRCXArQhubiCGudAiRMr
         oSgPGnNrLRN/XbTT2vtMsGVuLURq5Zvx7JPW7ZGzA9we6YO+rA4ky35GLSjDuAeMuUIu
         lqA9Fg+EOx1m/lRxAVJMSg7s8rIsVgvSUUE7TdtiGMrVxcUgMRhGWK/Bd8hXGyzg+Hul
         urkPFoEw1C24CGlMI3WTh+tEEIIj9+AAe7md6eHsdGD3LHCRJAQm0GiaFKuuey2J0pun
         tPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777576011; x=1778180811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HzRtJkU00CuLLmFgM3t02EkjasKtqNUWug+c4hQSGm8=;
        b=hMCDLquo3TxaosNsmSXEXzRpJVbCZWYm/bpWn5640i+KFHvyr9tO2oMpYK5+4q5B08
         sxlqQ5Y6yEyOX55HZN0rg6KQCyxzoyXzE5SLXzexO9gwFqIJgpQCZX4UQizye8mcP3tc
         zS0fU9dielx4OfVDtPFtGOAhRBZIrVwIDKztKcLEi9y+hh079GNC/0A3bprbvbBtWu0f
         W4diZoUa3Rz7gH5l3TMFZHUPDDKfWpvtyasTKkUQMW0uKiHcrD5mUw0D5IMZn9JbjtPe
         ukd2kI9n7fy4vBa7wbrBJXQ3npDlTj5yv8/ZohjChX5Ni41fT4AQAU8WTky3YOMbN5xg
         eOFQ==
X-Forwarded-Encrypted: i=1; AFNElJ+wxINqRkoIDUAutaJNfTbN6eA/sSWF29MLaLLYxR0s8Gep1RlQMCvk+3gB+SM3HciNfZtUb7KVrYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRTxaC5GcWKsahuC2Rw0vX/UdnIDE2XdQGryvbx5HWj0WCwZD+
	qMKWbBD+G2yMYZATIl4M0z910IFbG28vS4pQyng2b2JFQzeV8nNFIIt2
X-Gm-Gg: AeBDiesk2dh+lZeXIWYRmSz9iL8U7WsoSKlYYNU8gkGgDley8vIiQtqv47BUMK5+XkZ
	OzkRZHFa/+6Y97/vY5aB8Sl/iC6jOt2kJlnuQpVGOba/ZOaUqD0qV4DNMp/MLDmk/ZP/AKVXPfy
	qFxGxvwEAf3H1fAXUlTaGRbWFHwjoCn7ODbMAuZwnzJshTu0yPnrMWkfNhzC9jFSr6gDz3cu7aM
	Gvz5TrIlczVt6GVuMP18hVXBwSIgiK/Q//H6B7iNmnHRGGy5INJ2MFbq0p24XMDZQrqFKUOkKL+
	Q+yN4z0JYVTk4WjO/Zb0dNosCVwfC1ND85UQniwjBSvOoc5LnAd6O3GMtx6079E/yxRbrCHTF7J
	gbbnJAPatRkpRjnI71/1a/uGWG+gYZRExRpglc1t9iuQU67guPb7t2YBeic1LBzItcbsO2YJhWQ
	8Vi08x2NFH6pZI0SZL84XbKtuKl7mp22COTlFraSro8AmRmFnUmIwY+D49ljs=
X-Received: by 2002:a17:90b:3d81:b0:35e:577c:c9f with SMTP id 98e67ed59e1d1-364c2f8a3d4mr4494100a91.9.1777576011177;
        Thu, 30 Apr 2026 12:06:51 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae16067sm3332185ad.40.2026.04.30.12.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 12:06:50 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	lars@metafoo.de,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] MAINTAINERS: Update Analog Devices IIO drivers entry
Date: Fri,  1 May 2026 00:36:38 +0530
Message-Id: <20260430190642.3434650-2-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430190642.3434650-1-sanjayembedded@gmail.com>
References: <20260430190642.3434650-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Lars-Peter Clausen is currently busy and is therefore removed from the
ANALOG DEVICES INC IIO DRIVERS entry, with input from Jonathan.

Add Analog Devices mailing list as contact for the ANALOG DEVICES INC
IIO DRIVERS entry for coverage support.

Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Acked-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bc42e1cacd6b..34b67d010e87 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1861,8 +1861,8 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	drivers/dma/dma-axi-dmac.c
 
 ANALOG DEVICES INC IIO DRIVERS
-M:	Lars-Peter Clausen <lars@metafoo.de>
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
+L:	linux@analog.com
 S:	Supported
 W:	http://wiki.analog.com/
 W:	https://ez.analog.com/linux-software-drivers
-- 
2.34.1

