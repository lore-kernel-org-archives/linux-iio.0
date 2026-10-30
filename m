Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357284;
	b=MzGVvoEuNR1C/uIV8ZZWYoa2txou28BM6DIjsG+0hHiJJYcB1IvnFudp4NQ8Z8V9jM4G
	 vCxtrDb+ardrLvWU0EgLdbJbzfaIAQPs9qCq6XcAPqjfgSzD2DAmN/SOvu0qdt190wW+e
	 hvo0+vZ/HriLLwhYjzLO+7ha61UHCUtD0O8p3kSp+hcE/LcS/b4uYJ3chTEBT2+bJQEMm
	 5693n/Si2IL6255Hfo+E442jZIP5mEbSQ4nHBhfGtPe7RNypQT1qtx3DoPNS/GkbGFXtS
	 G4KdpnIY6oKvNke17wmZg4fbZ1/cv+1BbG9DLB0SFKPOCSVPKqTy2Be85XmdRVYOzuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357284;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=C57ru1ZgQyPfTj2Ltl+MtZ6bKGREeSrdFgZ8/zlIiCA=;
	b=Yq+un/OrofEmCztCy9/ahn0Jq32RM7VlqxCCwjSShVCQBantZ/xmXfbS9bhVb3q33adH
	 UpVD6usJZIqQj9hroTlkXxkoXvp8dNkibApD71DE8o3ZQZhyUlSXDbln8M5KBAZGTFgo4
	 00l8KduwyHbjemoP1JF/hUYsY2tHHxTFqpVyoFjXmQID5HQU0bK6aJSlS+o/Oy6MjaTkC
	 Jk7SRaXE03b334AsZQ7+5Ex1ySgqdKQlzWxH0Ie/ObwAbkvUI1os5POyqDqRVfb63hhLO
	 iMl/4UsB3cKF6LPIEVWkrQzEwwXSc96axAjQ2FUGpX6dTUa2mMfj+//qH0TEMQ92Nuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y+c0kfy6;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BED8606A31D
	for <linux-iio@vger.kernel.org>; Fri, 30 Oct 2026 10:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BED8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y+c0kfy6
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso4666805e9.1
        for <linux-iio@vger.kernel.org>; Fri, 30 Oct 2026 03:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793357282; x=1793962082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C57ru1ZgQyPfTj2Ltl+MtZ6bKGREeSrdFgZ8/zlIiCA=;
        b=y+c0kfy6ChDLjC2R1iiJMnAjUiTid9A+fyPapn4dSVhOrxBpyPmg3QbZSwOHJEAbYN
         Q4HeyWLBCXC0p2ef9JYeIR5WCJ242CAZTHXEApeu5gmEJuqHgm0TtUKkz7iuTki2KO2O
         5pEsL8TdYvMxN3An7qHagEnvL9CvyKmbyTAvb3ZLpDV3wLtRwzNsBpjP6xq+Z7AgqRpX
         JRIJGIVhh7hrJTsJ7Uz01Lg2/RH2L5MGIjXpTckKFdSY/uYvKkyEPSoJksh8cx8V9DyZ
         m9TAdMJ+TaFjKP5kB2PX/HTzNM8J/A3FxZQFFcUzMPykDYK4AGbrCGfM/LEjUke0V1KP
         yx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793357282; x=1793962082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C57ru1ZgQyPfTj2Ltl+MtZ6bKGREeSrdFgZ8/zlIiCA=;
        b=0sJElu47I7UVIRcYC/CbeeW5rhpulCRDrZpvYCfSqBmEypot29JjH8CwVk8owotY9a
         ksudZzduYgL5VuX/Z61xozY0VPnTFvqRggq9CPS+LFHhezR7vPB5jizt8k63GU509TOj
         c2/YbS6Wzf5H1CGTnLyv3hn0r/Nrv2P6tAa2sagR6y0/00TXSlDo5Hw9WMjVXYFU2xmr
         QYmhIzz2w9NYHcQNUZQv7BQO1mbKzsOlmCDdjq02n9jlnpWWL666U1d1qhwEccHnwRjp
         189UHXdQWybJ6yjt3y1sHBzdir8hil1XhltnNt2JyWQv2w77qWKfO7SO6xojc842aey3
         gsOw==
X-Forwarded-Encrypted: i=1; AKwUvBxXFSqWFbCW8sjT08fDks+8VAvLnMWOAHh4K+ZbN85RFFclX6C/feljiuC+NIlfvXt1NaS1x7N5CN4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJcVWHnjTStC1GUVb9uW5xgtSnRkKyUcAkEVc5WZL5p0vVzIvJ+
	NNyd+p3oAPMvaZb3/PBSgObqHTd3l743rFM1sq6uMCU2XiM7BMw//vxg
X-Gm-Gg: AYBFou0vhwpH7FXdZKpzX08UlpqISW3eMofXgQw3GWWpUrjE+6gey4vjQS2CJDQvA88
	wuQfk+C2rMUD5UvZQSgM7rBK67s9eNWmWNEc3vJZLF290/plIMiiPqwXoDxQjhdyoizz30qvQQ5
	ikTbdfP/6iUlqSJaDhjsGJo0kgNpmpG4j60WOw3SytC5weHuqVD8mx1fA4mBb6kt4PVGsirFDco
	d1wwXZaekBqs4vLdnsjBFAz2z+3Ukms7esThC1L4XX6ia+H/c8scIjcoqcwzyabolgoT9OLziaz
	IVBxJaNDY4kP2RfrHjHrNcfjLrdis6xlH+Grow+xVc9PGqbduaisS15Mkydhe926jkqLh6prO/x
	FljbWb3DNvUS9yV4nbzNJDdt6KlSx+qG3IpNVafy5tSoSBdvNcs3C2zoMucFp8IwA9i01qjCWKe
	CzdC/aImy8566PanbtPMdUr1vene51BE3JXjMDdP/uEEiDiPAOWAJ+fdPoF2xB/rd5G35kzfRgh
	kz7UZ9I6r+qj1VJbydh6OjXKz//fLQkjR9ZInTbsl68g8IO99I8gSJf2QFIunxTr/c7IrXRk3DH
	XqYFwSMNoM+1jf99FtkRwszssHckK+qNIPMAuagypWNVnZhu5H7qEZYud2fh
X-Received: by 2002:a05:600d:a:b0:4ac:aae6:6401 with SMTP id 5b1f17b1804b1-4acaae665d8mr12093245e9.12.1793357282256;
        Fri, 30 Oct 2026 03:48:02 -0700 (PDT)
Received: from fedora ([154.183.179.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71bae25dsm2240473f8f.59.2026.10.30.03.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:48:01 -0700 (PDT)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nuno Sa <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux@analog.com,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v2 0/2] staging: iio: addac: adt7316: clean up header inclusions
Date: Fri, 30 Oct 2026 12:47:43 +0200
Message-ID: <20261030104745.16693-1-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series cleans up header inclusions in adt7316.c

The changes are split into two logical patches:
1. Drop proxy header <linux/kernel.h> and explicitly include
   <linux/bits.h> and <linux/kstrtox.h> per IWYU.
2. Explicitly include missing headers (<linux/err.h>, <linux/errno.h>,
   <linux/pm.h>, <linux/string.h>, and <linux/types.h>), drop unused
   headers, and sort the remaining headers alphabetically.

Note: <linux/device.h> is retained because the driver explicitly calls
dev_get_drvdata() and dev_set_drvdata().

v2:
 - Split the original patch into a 2-patch series.
 - Dropped proxy header <linux/kernel.h> and included <linux/bits.h>
   and <linux/kstrtox.h>.
 - Explicitly included missing headers for types, errors, and PM ops.
 - Retained <linux/device.h> for device drvdata functions.

Abdelnasser Hussein (2):
  staging: iio: addac: adt7316: replace kernel.h with bits.h and
    kstrtox.h
  staging: iio: addac: adt7316: explicitly include missing headers and
    sort

 drivers/staging/iio/addac/adt7316.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

-- 
2.56.0

