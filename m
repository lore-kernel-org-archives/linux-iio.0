Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013832;
	b=laS5gAL8nkO/35lC3NbyJoUzY8oQhln/ftAa+D+myt65dYbuy0CtsKbDTYFElWEpNvqe
	 Jjg5OeYabphSNBIoImWtRjZgakZrLHOIWeyuRY4AaOuSq+hPrfoYKcNGvDWib6IBTmhHi
	 Q8EEVQqhmq3foQ6pJv7z4SrhWPzSnDU/YjjjtH2vSTg2kUf+j04/KQi5jKh6B+mQXQVGF
	 vWXeD3efruG/VKmO+fvRjTbwAtkcHdtkbfvEZTfxxRGSubOmvOnDZ9hzz1PgFQWqulitY
	 GRoJaGwwqzUWyamywSZNLhPLBhX0SxjwYgdQVexs4Puxgu25HtvihRrEml1M9g9hUSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013832;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2QtIsSCf782Lvc7phrGj3N6StJAQ3I3P0y6Y7lrPkzg=;
	b=0tOQsSmShej2mGXZluHZJd1WPyFIKxHIhkNFqcZpqk6Y/yBz02gbx+kiVo8AwSb9/hqw
	 cKez/OI7xct4ExdpSogWrCQohHFAH7B+tiSZOQ6223fh9yPnMTWTLY4i8DaCb7CXd1nn0
	 QtWEFYxa6lZd9jpRC9TD2U6fEIOV3cRnlZKENG7h1XwPyBd/27o2SMK2lBhmHgDVWdWNX
	 7VaiPDb96ycR7hVkqg2t3nXE9JT5UQOTNQxxPrl5kC7tanF/boGREuSRfPJvoKeTPKNg+
	 KK9BHMKjc35XatnZdYFUNXbMT+GMtiQ1dTHxYwi0bMPkva9JzUDnc3zRRxtQtczsi8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EmSNslHs;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8578E606A336
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 11:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8578E606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EmSNslHs
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3535a54bed9so4482856eec.1
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 04:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793013831; x=1793618631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2QtIsSCf782Lvc7phrGj3N6StJAQ3I3P0y6Y7lrPkzg=;
        b=EmSNslHsiF89TKm3ZUimzGbm7e4ZBnJwRCq+2N73iSm40DtyMbjWIrMnLLQdU+Qeg7
         o4sBgsEo2eyozMrsJ9DJHpyzgULXriiGqF940XRqSzWT6VpNkp2dK4oAB2P5uAHMuWeS
         95X5boKn+NbxQ4w3qz3WJW9AD+fBIohChAUi4HLU0enhNNwO9KU9RduZeiC6YQB4bbfB
         nBtKIgqHXs/zKrURyBJsz8m+mfvKWSwxnvtejFpuL2XAOuSzVK20ZE6Zgu5nVk0X8jFi
         0fAcHzjx4Q+U03rkj0UcngJ2bBwacTbCCmGVyZoD78v7tCiSfOY+vKwSsAca6cj6NNlF
         /m8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793013831; x=1793618631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2QtIsSCf782Lvc7phrGj3N6StJAQ3I3P0y6Y7lrPkzg=;
        b=aabY24M1JVHgV5eO5Qol5XQdvUm79yrAyoqtJynsxvtk1uRTAH2kaCgl4zbOtJsgYR
         FB/nnpZ3PQrqSmZ/RMrNDLwV0CbW+dqsE3CpHCiLycl8ymkL1eshpJk4hu2ameU2b8fU
         4qSh5D6w+mFlfqnJrvOVh7G2q5XwKpkoXfrSb2fDshuuNqbeJHSR0vz0JIGP8tuN0B2h
         J0snCUpjRJHv9azvHeZRmDTQuW8OfGapQf0pK0WR+muavF/Jb19pFNzGFug95++Qlg7d
         x209kXYtSZkX/BLolQK3YEbaaimb222kEB4iQF7lLRX5GtOM+1cYjPjVLKkZ8OEBmc9d
         QVGQ==
X-Forwarded-Encrypted: i=1; AKwUvBwRRTjMY84gA1uIiCcZJcXD8Yh3CWhSToxtWqFGuDTAUQrPFmFI+Xm065QiQBvHrzso9Xw/fLGz+zk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLIFJKYWaTfQYdZ1R+6mwuHbbkFBwdVdG098LHwE1eWhCYW7euR
	pR6SHOSsVc+9ICjqqiEx6VrT4vASsQIBLpBr0WVJNxkUQs1adZA6mFIL
X-Gm-Gg: AYBFou38qH4jmLLmIkiooNeCHHF8lIT3xMGoj7WcRywfcheapZ3mAnrcjZSVG7oQr0C
	a2oT1fPU/eNn3qCx2d2x7ExgV6H2qOZ1YbEyWZJWaMvO82kx1whbNGxEK2/XiHw8m9QtnKxOJGY
	WEn5ElsAX/xRPr0tuLb83kNeTtc/ZnlBfoPThLvwETgroGeiIFlo4rZJDMuSe0tFV3m9S6mNHLO
	RCyxsgY5YkEZtfQEyosvPUZte35mWfCZkzIq/fuMN962Iqwh+yaTn5Ko2W8yqXXnXPlRa0+uTGs
	x2pkxwlB8miGk2u9LKmjAswNeQERt9sJXi3gvlC8IuzE48sRGzrDKSubzjg79bPJ90kmJVWos80
	/rV550s9XgCjGdvtc5cYlBmg1/OIpblQZ2KAPuu3RHSiv7yshPdymEsqQqqrg3BCfuveMONSivY
	lclvDKNvXnDj4ov1U3AONqZ6VUbEQRsNcqNCmI3xffwqnXYlPV34fq5wb3s7ElKwIABg9p3eNLe
	LudeYog2dW3Neux0KflFpHxuCUoFcTlh0yLK5SZEoD4y1Egyn/gKZovXmyXKDA6uVVUtXxoK75a
	y/byCsrLVCC6wSOBdlIvbyIORC3tu7LtSsDSvYiSOoll9L5UZpunZ6l2jMgUDAr/ciarV6SIR75
	7MaYS+CcAW5Q=
X-Received: by 2002:a05:7301:1623:b0:369:efcf:262c with SMTP id 5a478bee46e88-369efcf2ab1mr7178727eec.32.1793013831112;
        Mon, 26 Oct 2026 04:23:51 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a064510b0sm6599989eec.2.2026.10.26.04.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:23:50 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v2 0/3] iio: proximity: sx93xx: keep the IRQ balanced across suspend and resume
Date: Mon, 26 Oct 2026 16:53:03 +0530
Message-ID: <20261026112342.65917-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
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

sx9310, sx9324 and sx9360 disable the interrupt in suspend before
anything that can fail, and don't enable it again when suspend or resume
fails. Without an interrupt line they also act on IRQ 0. One patch per
driver, as the Fixes tags differ.

Changes in v2:
- Send as a series with a cover letter (Joshua)
- sx9310: move the wake-up register writes into a helper that uses
  guard(), so resume can use the usual early returns (Andy)
- sx9324, sx9360: no changes

v1:
https://lore.kernel.org/all/20261026100322.16720-1-kapoorarnav43@gmail.com/
https://lore.kernel.org/all/20261026100408.16874-1-kapoorarnav43@gmail.com/
https://lore.kernel.org/all/20261026100450.17023-1-kapoorarnav43@gmail.com/

Compile-tested only (W=1); I don't have the hardware and haven't
reproduced a failing suspend.

Arnav Kapoor (3):
  iio: proximity: sx9310: keep the IRQ balanced across suspend and
    resume
  iio: proximity: sx9324: keep the IRQ balanced across suspend and
    resume
  iio: proximity: sx9360: keep the IRQ balanced across suspend and
    resume

 drivers/iio/proximity/sx9310.c | 41 ++++++++++++++++++++++------------
 drivers/iio/proximity/sx9324.c | 31 +++++++++++++++----------
 drivers/iio/proximity/sx9360.c | 33 ++++++++++++++++-----------
 3 files changed, 66 insertions(+), 39 deletions(-)


base-commit: 2ef6f5c4ee56e90c237c5f7687f09e635f7d30a9
-- 
2.53.0

