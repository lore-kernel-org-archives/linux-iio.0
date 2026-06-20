Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D7C2E7162
	for <linux-iio@vger.kernel.org>; Sat, 20 Jun 2026 17:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781977723; cv=none; b=V2TDQsM+u0HpCo2di9XDPTbXTe2c1kyRTnzre+IjjBjGi3wwpL5yzjpl4ebBIvteyxgiU2Me3Zj9MXEs3cBgSqjSvymbpfWPfJYSUT/f7Y70eQzSHaget95A9O1CQVfbNNnmJQXZqC4uIT2PCLaAtOEpVevxjXGX3LFfjkrRPs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781977723; c=relaxed/simple;
	bh=3myZjXhPbGAaY5BWs91sqdsS67HkUbQDCm8ckKnnifc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kB3Qh41Ux1G1YOZo/IkfQTMDU9I8Fm5y4+9eO264rmGGEtp0GHuY9OFEOPTJ9R9k0AaMT4EGFUEH120ZoXmIe9vc0l0JmM6+/fFHitsQz5VfP3INCWUC70nUQenxA8Rp/DUpUyggRIQmzOiwu56VapFNbFKKoWkjtbqK5On0hNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkwRt13i; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkwRt13i"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-37cb36ca63bso1579534a91.0
        for <linux-iio@vger.kernel.org>; Sat, 20 Jun 2026 10:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781977721; x=1782582521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S4Gsa1GZIptWE7b8gOPbJAyJYBZjMmoW/qVhG52EBYg=;
        b=JkwRt13i25m+KA2KGMGMTznpgcZB79jNnHYDvQdpeQqhQJ00sxsxJU4j6TIwuKOxWb
         1I8/50HeZeSv18f23WmM8+h2JqDXNL/ZGfNG8shyZzFHPjrdioz+PjVP3zU1MFO09Z9/
         ceqQUsoQiLnEAOe2/Ocvv+6Pe88guztU3yJYDDR+AlbzYxeFn2cUo8Ot03Emp1OvitQL
         0ONpl0qOITgRsv1ExLcB370trQMREQ/ASQuni3XP8U+6iDzvLcijHYlbWIR3+buSExEa
         LOnSUBP8sDf2LM2EHayzzQO2KzWBzS6O/afYb9VwkfXb2ZG9mxG+nEhmT2scNCvlUKJR
         bN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781977721; x=1782582521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4Gsa1GZIptWE7b8gOPbJAyJYBZjMmoW/qVhG52EBYg=;
        b=aMRrGVxh/oku/JeqB4X1U7WXPY6ovV2CQkRpK5hLgabSha9f5jJnJeBOgzXFjVrueu
         b8a645dwSuv52a9MYOeD4va7qqZf5a66F0J66Applzhiwhl/mquzCny20hkMzrZLbnlf
         PtNlgGMvs89q1yTgBan4dWxGWt+filDuwcdqxT00wNVORWMPQR3FKPn/OVy7GGMQeZ6X
         +vdqWNVvhH1HlN7fxSzgeDCMYYhu56UbP+hoyAvNn0CpsKenRzoyQL6zd9Aa+w8PazL/
         a60BJCKdrTA1BkCVhvth8pSIUpbzsx3Ewds+ydc6PyVK07IKeox62qtXbwPQhniBHFNG
         dAYg==
X-Forwarded-Encrypted: i=1; AHgh+RrdQLXi2cAuO/dCEz3Bb+gTQQ/oj/hvjCkP0rKoCp2ZeZxlh8oTxyig6DWVDMtZkmHNI/V2jTMpfW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzESgUND1JH8l+xOeCZ0YFy0bvJmEEoNnzp7bxPc7EGA5MSIthJ
	Idyxokz+c2lisa5PpL+TzRKpH1OiJbtG8uLpWesnvSnuZ0h27qoUy3MTrxv+qe9Ftgk=
X-Gm-Gg: AfdE7cmDzEUCgmg6vQxv+OUSEeGXN2I69QYIm0+2oXuextW+f0UhGt5bDMJocWs5ibO
	AZAVNzFpN3yCTgkYstUR+WgwO1EtBqlmUlgeddfMje9P/onGpc0y/JLO6aXSuvzNVYDb8ba+WF1
	xGCiQ7GsqVpDJ7uL6eE+Qgq2o7ObU6ETzq1FKEzNkrB1WKiZGBnEt2f3aNVClgLDq6ywDJTeshy
	+4zED54ZLAf1lK3Mdwa44vhl9+dThx+y2gYoLQGj/2O1FbFDzjmKADgvTmlkviDHoHBLlNTl84Y
	IjmmiX85wwUFOpxW9E9B8i5xkrFA3QfftbBGf1vXmNncImrwuAyvnpzk/ma4smK8B/UDmEYttJn
	intaGTwEOpM9BFsT6b13gqgCU5Yujh6FSlx6p0dKwir2dCZQQh1hOiLHPa2go6tlkaraWpk3L1g
	oJmBsr/cLcFgXPi2fgP5FbtpxSd2cQ+xdKGr2YRhM36glsml8pB5doI5RiqlPHjRZLrLti0W6z9
	SSElMha
X-Received: by 2002:a17:90b:5824:b0:369:7421:75cf with SMTP id 98e67ed59e1d1-37d15de5d30mr8168686a91.16.1781977721247;
        Sat, 20 Jun 2026 10:48:41 -0700 (PDT)
Received: from thorfinn ([2401:4900:8836:4853:6bd2:aa0a:1945:47e2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d1536b049sm6344222a91.2.2026.06.20.10.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 10:48:40 -0700 (PDT)
From: Prashant Rahul <prashantrahul23@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Shuah Khan <shuahkhan@gmail.com>,
	Prashant Rahul <prashantrahul23@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Using dev_err_probe as it simplifies error handling and ensures consistent error reporting.
Date: Sat, 20 Jun 2026 23:10:52 +0530
Message-ID: <20260620174708.111470-1-prashantrahul23@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Errors are logged when enabling the regulator or adding the cleanup action
fails, but not when buffer setup fails. This adds that missing log.

changes in v2:
- ti-adc084s021: drop unnecessary braces around single statement if block

v1: https://lore.kernel.org/linux-iio/20260618231543.413771-1-prashantrahul23@gmail.com/

Prashant Rahul (5):
  iio: adc: ti-adc081c: use dev_err_probe for probe time error
  iio: adc: ti-adc084s021: use dev_err_probe for probe time error
  iio: adc: ti-adc108s102: log buffer setup failure in probe
  iio: adc: ti-adc161s626: log buffer setup failure in probe
  iio: adc: ti-adc0832: log buffer setup failure in probe

 drivers/iio/adc/ti-adc081c.c    | 6 ++----
 drivers/iio/adc/ti-adc0832.c    | 2 +-
 drivers/iio/adc/ti-adc084s021.c | 6 ++----
 drivers/iio/adc/ti-adc108s102.c | 2 +-
 drivers/iio/adc/ti-adc161s626.c | 2 +-
 5 files changed, 7 insertions(+), 11 deletions(-)

--
2.54.0
