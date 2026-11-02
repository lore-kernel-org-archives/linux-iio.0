Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793612591;
	b=j1dEboG3027H/7o/GETJxnaXr83HX91TTJ03ZgWYt6v747IMsMZrt05YfznGwyCS5chL
	 dXdavaW1ysBIwgWdgmcKYbS9wFcEV4WoRovv3bM+7wOKIXpo/KXgalfQJno2PcQL69k9w
	 8WxO3MTyF+f+K4FwuK9vkLzDHXzDexEVrSxcpjKyIvxvY8MK+aosP7qdNclB1MxILpKBk
	 iMzuw1VLStYXU6FnmucJ0orJDBdZf/xTmSGGuL6AKDDUWCb5cV/0cGZP4jlGXSo+KCpR3
	 DpQTFaCl4g7CwooDy58KLKGf609IgNP17t2fl+lTKp+lGMXJMdM+CHvo+hjFWaKxjDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793612591;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6B409QdOnvI4K640/GRyjBqzLJCAanW7cL4zy0aAKRk=;
	b=YdLrWKNAoPONR7oEq1VkK1hqssO8czD5/3hflP8HMaoF9P1+3rOOMXoJdt6GUqmSJpEp
	 MjTy6izRFjSJTUa4BDjakR+ck6lbgzoWLG3JHyGq/nQRxUk2ByX56WxbBPWMtvpvKdTun
	 nYy1NRC6ww2uQN4Cd2xVhn5GouGns1yalLL4ZUWKobgJG1w4BXXCGf9qAh64J08yFCzyE
	 6bpTF0kj+R7pPupqf0pOuOwcR8OQK/jvU81ZlMiANIVRSOp6yP+BZzIZ5Kooy1yaqKAgX
	 7hA0gM6I7RFcAzlZryTgOHj7jwyDz1VXSpGYjT2KUggOjXhoMUr72vxYnHxm4qp8ODg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cJMJVYuA;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A936606A329
	for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2026 09:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A936606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cJMJVYuA
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so20843875e9.3
        for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2026 01:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793612589; x=1794217389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6B409QdOnvI4K640/GRyjBqzLJCAanW7cL4zy0aAKRk=;
        b=cJMJVYuAWVoaYwkyiNjlAEONxZr6+M9ML6SRyadMccsHMImZ0MWRheq7Xdn3ZkwFY2
         q8U0K7yGEvv6dqDplu6A877k6T1uSnLg4bmATjrW/rFSU2rMBibYOph6nDiHZmC6BNuE
         DSGuDaJqy9b75U+Jyt+m+KTMX5TKhHzAF2vghZigjc+CeI7aQb1MnE4jIHnf71fHRfZH
         HH63OuS9qRr8APwHgkCJXq9WfcfgAP/MDTKT5yMwIhZMyc0KWHFNd2GCjGKGPXv2isJC
         nAXtMn/1OQMf24+GbSLAM4N/r7yu6O+XLqXt2V6nkxl8OA+WAoIyRJPT9K8+UX+NDGAO
         VILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793612589; x=1794217389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6B409QdOnvI4K640/GRyjBqzLJCAanW7cL4zy0aAKRk=;
        b=Qqp1DmdI9Pnj6wzCxrT1Rwmm4DmaA0Q+HPoDp/P+enydYA1zew0+f/sl//c5wgOYDK
         iUwD2RlFOSymNFhC697IQduS39/D1ccTkLtgqhJwL1vOCY76XBc1bLsEU8mfggRYBRty
         Hy8qg3uZmxD37iSqRWGuWiA1lruWUDolJoA11VNou7CuaNf11NOIZwSnsgH3kK+kKMH4
         fdxQXTAOpmSEHUGNC5MZluViQouGgUM0zaBUdJc1Xrtp6gEq4uZkmTokzeaDmwG7VxXK
         wPT5MMb+QCfwXJ8wu+z+aVMBGMkWDMOzZjFvCiYd69Ve+V2MglgUkWSO5R3LmBaUuHd3
         OdEg==
X-Forwarded-Encrypted: i=1; AKwUvBxkq/YYNuRGX4eb2dTda5rUyKfBh6UkfrE6x3D/1i4Cy4+OQK+edZsMzubZodIElqwAOy9kLaHGCFs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZuonQ8GHg5DCb0918jzsbywMId9PDiEKX3fRLVc2QIEi5fqvI
	5gyR2/Bp2+mCfWJ4KBFSraK4aOxwpi+6CaUtXpzOXqYZ645HRBJgJUXU
X-Gm-Gg: AYBFou3sgvudJZ/IgqW8MrnkGFEd7uDCoM4WXQ6h3k4e6u5JIT6yRMWQoK3A4kvblN4
	IuTQ2rMNbEliC3G2+UOlEwmB3G91zZjPHJhFMGRZ4uvmogW65Xunc4dg7uYM6KQ5U4Qq4xwIrZY
	4zrOe3WyCpLvmyYuwov5r0tULgeLPvMMuOe0siIWQl7I2+5iPcgBiiIuxt1XfwDDkuPaj99kBLZ
	CeOKAl7qcZrfvXDkH2W9zcJZ6CnayI9ifIVDyKvr0jyNnPQpS0FDiDVJNAC16JovDUAVbi2PUcV
	gND2W/K+rI3lg5vHWm/rjKQBHfvnwiYRV0pAt/hRI2j57tBsOmxvRblyeJQdnr4gBa5uqQ4QRL5
	go+LaQfRwys66nV3PSd8EbiF/Eyj/YocD7QkJvTYRoqnA9wDSlZFzA1Gu2jSuMb6IzxXNzV6lKN
	zUhFIgeJO8SjVRkQFFctU7Fihe8PFL4CIc5QDZ0EoaL4HzzWxYJo1O+FKPko/bgEKt9lTw+wtWe
	/71dtNq4+s1Y0cqYzR8ghv2LlrDqag5SxJRedPuUduie/sL9YZFtkhJJoj3Cy7XGXsByFVCXgAW
	TV6YpmIEQVUMFRuhktvdspqxEm+X56VP49W/G3A=
X-Received: by 2002:a05:600c:b8a:b0:4ab:c447:49df with SMTP id 5b1f17b1804b1-4ac182dca8emr210351705e9.23.1793612589183;
        Mon, 02 Nov 2026 01:43:09 -0800 (PST)
Received: from fedora ([154.183.179.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa813d295csm332507285e9.7.2026.11.02.01.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 01:43:07 -0800 (PST)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <crofts@kernel.org>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v3 0/2] staging: iio: addac: adt7316: clean up header inclusions
Date: Mon,  2 Nov 2026 11:42:34 +0200
Message-ID: <20261102094236.57757-1-abdelnasserhussein11@gmail.com>
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

This series cleans up header inclusions in adt7316.c by following
the Include What You Use (IWYU) principle.

The series is split into two logical steps:
1. Sort existing header inclusions alphabetically without modifying the
   list of included headers. Keep subsystem <linux/iio/*> headers
   separated and insert a blank line before "adt7316.h".
2. Drop proxy header <linux/kernel.h>, explicitly add missing headers
   (<linux/bits.h>, <linux/err.h>, <linux/errno.h>, <linux/kstrtox.h>,
   <linux/pm.h>, <linux/string.h>, <linux/types.h>), drop unused headers
   (<linux/i2c.h>, <linux/list.h>, <linux/rtc.h>, <linux/slab.h>,
   <linux/workqueue.h>), and maintain alphabetical sorting.

v3:
 - Split the series as suggested by Joshua Crofts: patch 1 only sorts
   the headers, patch 2 replaces kernel.h and adds/drops headers.
 - Explicitly include <linux/err.h>, <linux/errno.h>, and
   <linux/types.h> per IWYU following verification of symbols used.

v2:
 - Address review feedback from Andy Shevchenko: drop <linux/kernel.h>
   and include the headers actually used.
 - Split the original patch into a 2-patch series.

v1:
 - Initial submission.

Abdelnasser Hussein (2):
  staging: iio: addac: adt7316: sort headers alphabetically
  staging: iio: addac: adt7316: replace kernel.h with explicit headers

 drivers/staging/iio/addac/adt7316.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

-- 
2.56.0

