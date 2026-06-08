Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FD834B682
	for <linux-iio@vger.kernel.org>; Mon,  8 Jun 2026 03:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780889669; cv=none; b=VWmk5K2/xGCb77W0RG2kHUjVM2QUE7j88+mJu2bY+On0G7hd6mZjfiyG12+flyGnsi0wHEeQw5lsqE5uTptJP8CDU3bcljWVpX5uxxuZ8tC6NPqlJC+mvTYhCvNJ6NbcGhEfYqiMbIsBWYVac5H7z6xB65AEhjAkqp36V9zrSwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780889669; c=relaxed/simple;
	bh=sHHbD0ONEEaCeotDdkn9pje+CVbEmNbV5DHwllWZyZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=In18YUMG0GPB6H6niMF7vXusb4ppaZICqx315lsA8/CoEz4DOhuJolhbelT4l0sUw5Qjq+ReD4uqEC016ebbV8wZZ/G+q+c56kY7RDBAgt4coMyLhG6+BK66C8nQfU/USVrRpLIxK+YoVUH85cSd7C0lCrzwoIIcAH0FVwZMUKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36da8439078so3365306a91.2
        for <linux-iio@vger.kernel.org>; Sun, 07 Jun 2026 20:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780889668; x=1781494468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Ho76qDRnjibYO7dJmtXa8Sqgx9fQ9gkuBJQgz/YzZQ=;
        b=bixf+Y6sziRhGbxD/xUv4h7+rnuoAkIikg9CFpKBzE7UdIMox+JhQU84d2uVqpo6n2
         e1jAudaRILe/9dd7cf0Lv4bCVDWdoEVw3MIDs1gu8SWAFAHxAUx/QTanRZzpY3VvgvNL
         kJqLMpsLL+TBVxoFILq11eVTXy9pfnOuopCKkpXmginao4yBhojocxEkS20AFRXOy2tW
         Yq1RVv6DK3A5t5bWzA6m02vLEa6eWoQC+kLUiOfzfHWrbOi6tqYwU8AouANrOpEYDFQu
         Ji+KB9ySZpHGbNgymzxETgtHVja1QMW981e75SHoR3ujlPR1X/aLCe6YltBw0VIcCsk4
         6Hig==
X-Forwarded-Encrypted: i=1; AFNElJ8DGe6etxfCiOpr9tyrWl+2BMacjWALx+dDye4A+16m8ez6mYmCS5ASd6kSTP4O1vUAriehpIFix78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0nq3SX7WUoYwwWSS5wmeU0KlVib3ayQ/bDxA/Do2Aqb14Iz9p
	DCtE7csnlPmH3ojq/QrNrnkDXUrq+xzqjFbiZ+lHztnBe0U4dfEasIO2
X-Gm-Gg: Acq92OFstqAPCf6SZt6t1gCY6oyqc9/5w2BFbWVlc9k6BQHKE0G8jzzH1FANJ+ULmEQ
	K/3XJeevt6uie/Di90Z1SR4t5A9Tw16R8l1TeMjMrx7DtQIn7SLdLtRs7w5eOg2KswvtcFSDM1z
	2OADd08NoiKf31EUGYItjzF8nqzHIWzooHMx7zIUfd0VKna7KsDIOrUFDBQPuOFgUgmJNOZ9l1i
	UC8WLBJI8VhvooO4ZGFLCU7+1VYSDLVmF7ocNN053bTRQsol0zJDprR++c8MBSkm2rjUoOPhKEv
	JtN5rAWYXIe87/4qAZmb0eYNoHgpdm7LxiZsydp06spcjtYr8+Xxz0SsnvoHMR9clJyh/fvCblt
	ktE5cPG5S8K8evoxHtzREJ4HKx/2Z64NS2AVnnWI8XMy7CxdMvZ65REJ5ilRZ8pNMfrMeqXzlIV
	ApDhHnd8UzF04sZ45CWQ6SPROzxnA/OReWjR9RZV4QkIjUebAK+Uwdyd6UgSIsDxi4xyd4YRr6E
	HKUKhHr29Z5S+Wt6DU9eMvKN4+jtAz7Jh6GW/17
X-Received: by 2002:a17:90b:394e:b0:36a:aeaf:ab2a with SMTP id 98e67ed59e1d1-370f0d4c33emr16802169a91.19.1780889668050;
        Sun, 07 Jun 2026 20:34:28 -0700 (PDT)
Received: from fedora ([59.152.111.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6c76f55asm14102286a91.7.2026.06.07.20.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 20:34:27 -0700 (PDT)
From: Siratul Islam <email@sirat.me>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Siratul Islam <email@sirat.me>
Subject: [PATCH 0/1] iio: proximity: cleanup fixes for vl53l1x-i2c
Date: Mon,  8 Jun 2026 09:32:05 +0600
Message-ID: <20260608033218.26514-1-email@sirat.me>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch addresses the style changes suggested by Andy on the
initial patch series introducing this driver. The changes include:

- Sort register defines list
- Extract vl53l1x_wait_data_ready() polling logic
- Logically split regmap_read_poll_timeout()

No functional changes.

Link: https://lore.kernel.org/linux-iio/acUHDGUqg4RdI7fW@ashevche-desk.local/#t

Siratul Islam (1):
  iio: proximity: cleanup fixes for vl53l1x-i2c

 drivers/iio/proximity/vl53l1x-i2c.c | 36 ++++++++++++++---------------
 1 file changed, 17 insertions(+), 19 deletions(-)

--
2.54.0

