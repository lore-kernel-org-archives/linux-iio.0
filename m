Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB05F3168EE
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 09:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776157996; cv=none; b=SXrYfJcmDX6q/TsXEJFpMPx8a9598OwFOPRAq/EXreTCOqp/A+k08HsaR4zMpIvTT7edYfPC36s5rXJBDWj+XcKXxVKaQXwqJKsu27RpA7c2Jes0vP8VzZL5xlNLt/Df+KCQM6SRq6pUUs0kyl8Qi7dbEvJPzfCgi95o5Ux48D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776157996; c=relaxed/simple;
	bh=eP4D4GNwsawcxEXw684svxH/w2GIYqCO5lilHeOr4zg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S9U5SsuMjhfNPTSSBENjwD2b3Solzb6jQ3KVDtD1d+e7Xjh2npY2wPFzTsGr/2nIsai5HttwzMD1TD280T0/zhkJQHKemlQvB7jRPl1OpMnaXlL3hzbc4/zufpLxpllwfSZiGn/aK7nnHQeeEF6rkTD8hYg3wVPYyJaedAYT+/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+MSMuGu; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+MSMuGu"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6712eb9139bso4151316a12.3
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 02:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776157992; x=1776762792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cALGFqNRXLm6IfVizKgr8efbiRqkV2I059rgEgWBcao=;
        b=g+MSMuGunDCRZE64uQ62GIGDAb5mM6Z2ds60+ZBVaXgCQvf0NDReGmsN+6YOz1E3Cx
         kN9oR3w5V3gqsmitcc2n28ZRdx4Doe6ibCC2jpSW6WuJAzBvEWQ2zGvsFvfFeFfI5HgX
         oeMOm1ZXIjosSTwEnsqIG3Odrl2H09BOjAgaSkCWL1OYUac552Xh4r5797bYZXU1UfsX
         vIxDjoCqxVdj1UyYDaewgrgH7u/APxHe9pjKk1vdd+DEdJh4fnsLfoitP+t9p6ticjgj
         gp9jmIq+VkJbcCI9KDPo1yPPkCgJlhLZYABjNghivoANtLxkwZBoMe0BbQaToaFzlAoN
         ZugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776157992; x=1776762792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cALGFqNRXLm6IfVizKgr8efbiRqkV2I059rgEgWBcao=;
        b=HPJ4y3iemQ2ii58885LtSuT7Q4GQla5Y8bIIYZIVIIgup4pMEqf7WL9Agj7P4yLKIt
         Bo3YGZWcJAxh1jV1Mv2mAkH686/oOwbURU+F58kgi8tN+e/D5HHhO+349B4EWcRBRIiY
         //9Vxqdc+wTe4YVT9bnFFrZmtcm73GZYmqPehTXHaG9/Ae7Bu5u3M78oYmeD6I5mK2gO
         dFdxRWDfQH4bO7t+2FgAfX/jaQBNm9Dic6qECoy4vRjFgd7uS/uNOlQc4WAFH9QFBo69
         vqQBYJ2dQZlVk2ztaw7qxUyD2yxGT51UFf60UzXumaXdCbEALu4GPbl6FssGro7Kva8q
         +BnQ==
X-Forwarded-Encrypted: i=1; AFNElJ/gCx5xyj20bwVlb2yBkP9GemLYsOMUGzB7gakxlNfKp6W8UAdk/TCA7Hscs4Yoq11BqLCkCXjhg6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl+GTVQVpmUZgo/DBWEb6d+1F/wRLe5zMSy93VJAzpcAxzoMC7
	qnGlN6eE0qLxGiKwMNJV4dgkmJGB8nAB0DswhSbAswowmFPAdQm+JAcb
X-Gm-Gg: AeBDieu8y8uFIKIRGYb3OBtQBB5jVltUBeiJLq0XqoJwF5wu3Gv+qmYgt0CRn6eQTT7
	WvawffmGvTNDCO6E7AipxyJUNAoERBrPQe65ZGsvg1SOEb6w8xRSJRiG0mdUVBOq1sR2VMFjoFa
	L/9s++dYZ7iavDq9ZYF6kb0cQ8NSH7qhMJKzYXHuqHCYgVdCWiEPfp92yBvG92SWWw4EDhfcMYS
	/LkQsKveddFfmqqczKWoOhOo4t3pft1kNGl4JWYQq712/EQn40wuv+Aj2++R3Dr1k4FbXPmXcLR
	19FruoKtDo1i3HFHgWCzaXuPNvEUPi9ejfIY7NBLAtPTrdI4qv0T+XUZFdB8prigW7JyUOXOMZT
	mjHdUAc80dRqA12/fHpIez/RypAaBBC3eDiL9viYl5iadwUepjXBlCwmcH6herQ0Iso3LOwhGeD
	et78W1WeenxSh57LS+LtplUQ/JBYJmo7lNMV18028XTiWPsRvx7k2NMykCSkiJqAlHQwWh0fLBM
	gqlLeJiCtCHlvaoB5H+PHr41o1weRe+ahEr+h8HqMtfimUG/gPoTYJN37E7AGeZwQP3EXB54ESy
	xy2RfeaSa1CGH865REZM2+M7h/xr9pRR98KVhv5hnpEUn1wgbidQAwXHUNt9OpbcqPaRYy7ExtA
	ilot6uENO2k75kydyB4pDFXIWIzw1ENmL2687m4wXt0I31TkO6eDG2hZLlKBDz73IbwkfWSo87+
	JsOca/v6M=
X-Received: by 2002:a17:906:518a:10b0:b9c:7c84:c443 with SMTP id a640c23a62f3a-b9d72793370mr711253166b.17.1776157991936;
        Tue, 14 Apr 2026 02:13:11 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-b.c.od237066db22328bb-tp.internal (63.152.141.34.bc.googleusercontent.com. [34.141.152.63])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e7c8a44sm384466866b.52.2026.04.14.02.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 02:13:11 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH 0/3] iio: frequency: ad9834: driver cleanup
Date: Tue, 14 Apr 2026 09:12:47 +0000
Message-ID: <20260414091250.1295-1-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series deals with cleaning up includes, changing sprintf()
to sysfs_emit() for better writing to userspace and adding mutexes
when reading st->control to prevent data races.

Joshua Crofts (3):
  iio: frequency: ad9834: clean up includes
  iio: frequency: ad9834: change sprintf() to sysfs_emit()
  iio: frequency: ad9834: add mutex_lock() when reading st->control

 drivers/staging/iio/frequency/ad9834.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

-- 
2.47.3

