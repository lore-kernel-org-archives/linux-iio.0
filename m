Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB8E372EF9
	for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 17:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774892455; cv=none; b=EGLlBb25s+EtbWTyc9k7Ce2aqQYnjbKE1WfwYTBAQXjnoE8KKu+rQcz7TkSnYGRyPmOYEEhZoW5iE/CmlfGm8Y4dsXLiyR15gjU2BeDiY93eFw6o+EN1Eg/w0OMXWX+gOzI4XDLbcPcLrKdL3gnHbCLuVrV1UUEtWS9yZXNIJUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774892455; c=relaxed/simple;
	bh=NRkfQ5sWlyKZ8jYt0MoyU+A/zQpCzvR61PflWrUi6VI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gHyW/KhEQQdS1TXfW2Bd4wnWCNm2DNXXA8HyZ1NijxS0GIbdJEbcCT2jq/0w5tQsUdQc3YVH6sqyOw09zvPQWP2PZtawxXNP74d+7XHOcQSUQQ4L9yBCCTNDU7kE8Bo23lMuXi/TLlVkB1UGQmaQqkyCy0OqQkxpFPlgP7qyOp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmNvdFKf; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmNvdFKf"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c736261ee8dso1695181a12.1
        for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 10:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774892454; x=1775497254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uXmeoN0zd9waWSuUzT9frQxiUsdJkSomrx79VZXCc6s=;
        b=mmNvdFKf+Okbs6gAQIXXeqkdYnZHFktqK5cdxKQOGtzk2p6PcaoyBtLmXzjuHonVC5
         ZMjC8t0lfZOpaoBaFsH3y1Sex9pdUwt1LV+gCdXkYmxq/tGjwwECQMy4iA+JJ9iT22nf
         l6BXvQDNbW0FqNPpkw7DYdr1FJUJ390xOTyySFttsWaBwdxNB7k5ZH3B7GJYge29vVJS
         F2rXqJX3NXQmufNWsQsjo+IB+bmcBRHjQIo0oaV0RrGze+jky98VHxWNtI0xZJB8wwaM
         9klQJsaZX963wW20PkqktI6URg6j7pyxiCH3kK6um0iDSWQHiLoB4jFZbYPJl9dcM0yJ
         9DtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774892454; x=1775497254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXmeoN0zd9waWSuUzT9frQxiUsdJkSomrx79VZXCc6s=;
        b=k1o/cXIH5vhcFcppcWcytvkyraP7k+P8hG5grzlLavyVTVTvOgDYiHXQwmat2EBN2f
         aEDolysLAcFvNO5UvQNmSmnu6YeF1PzaHFkETxGRqT0uYhl0r9qSZ+zwfzh/GFmvR0uF
         Wf7Ft6/q8xdTaT573tgU7GMY5AyFFCJzfrzoo+thVPnYu6UzpxmhZ5bJE9aKhgOIEejQ
         eQOx4A/i7pkiJcZoi1JZgxFa9d7/z9DyiCTMsZKGTnOMIfnioXv/PC05J+kHjok7IN9+
         km5I5X9sesL0b9evlUz3ZY8IF0YEzYeaw6gmHzFCqkaPl9VDCn6ixHkQgCg3Gw2Z5hmh
         15Gg==
X-Forwarded-Encrypted: i=1; AJvYcCXKqCGlxFUXDcT/XvQpzsVDamBOX1OKMQojW9HqYwvde4DoatK6XbWlaidbHqRc32QuAaDctDduFDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL2nTdp85EkerOZdKihkdRxI99EJ0cSX2qhr7QyWbpKHojQEFe
	TdVB/7Ds0/cQX4lRjSiCNANvNgwXSFksLXDFRDzLV+DPTlx/r1I840/q
X-Gm-Gg: ATEYQzzPmWA78tolPZSf/+jABsAlVZ2MEV3iA3Orj0eM+U9ko+UUmta5yP3mEHagCQ8
	oNDW7v0OXZRcEeO5ff37zTqbu1fAqXLB6MePanlovSFFVYYru1H1wd0R+yyWikqyel4NYfv+hjb
	vkRd8JbfTPvTlBtCRB7PhVVeCJDmaN4NCVwTLmqV5q8mbRh0tamziFHK3XbRCkE9HwfNhmf2hdy
	pCWAuJ25+MevMVPokQHmNfA7tAeyruCkSYFbCGk5AEzuGdwnBKbo3Y1IARLcUtON7pcBNoU6ZQ3
	sTNZQtfSTEpUuUPwy5ajs24a5TQ8doGeETPfgwb9FoPPWrtsvmi9D6YXwBlx1eo2DFGLQqpB35H
	vbMW66DqMunFQj0CyPMhA1LXMKeN3+lFK+pVJ8ZZmgUrhk+uEmwQvNVz5PM+XczjntquNJjudYS
	vc3zBy9h6fDX6TWFBlF4wQEAvgh7lRV9ocIVw2Y0JI
X-Received: by 2002:a05:6a00:2e27:b0:82a:8163:4c00 with SMTP id d2e1a72fcca58-82c95c28026mr12874864b3a.2.1774892453962;
        Mon, 30 Mar 2026 10:40:53 -0700 (PDT)
Received: from Mahmudul.. ([2400:c600:545e:6508:42eb:3d78:89be:591b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca860b125sm7844052b3a.50.2026.03.30.10.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 10:40:53 -0700 (PDT)
From: "Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
Subject: [PATCH v2 0/4] staging: iio: adc: ad7816: code cleanups and modernization
Date: Mon, 30 Mar 2026 23:40:20 +0600
Message-Id: <20260330174024.20712-1-mdmahmudulhasan1511@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses feedback from Andy Shevchenko to modernize and clean
up the ad7816 driver.

Changes in v2:
- Renamed sysfs callback functions (e.g., ad7816_show_mode to mode_show)
  to satisfy the requirements of modern IIO attribute macros and fix
  compilation errors.
- Fixed usage of sysfs_match_string() by removing the unnecessary 
  ARRAY_SIZE parameter.
- Fixed vertical alignment of function parameters to match open parenthesis.
- Replaced sprintf() with sysfs_emit() across all show attributes.

Md. Mahmudul Hasan Mabud (4):
  staging: iio: adc: ad7816: redefine mode constants to start from 0
  staging: iio: adc: ad7816: use sysfs_match_string() for mode selection
  staging: iio: adc: ad7816: replace sprintf() with sysfs_emit()
  staging: iio: adc: ad7816: use modern IIO attribute macros

 drivers/staging/iio/adc/ad7816.c | 111 +++++++++++++++----------------
 1 file changed, 53 insertions(+), 58 deletions(-)

-- 
2.34.1

