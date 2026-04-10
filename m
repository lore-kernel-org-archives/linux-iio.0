Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6166129BDAA
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 19:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775849865; cv=none; b=ZCXUt4csdeMQAy1zE6cJFALh6hNrjUlL+jCRLbRQRfGauS5Yg2xYyK4iD+eBbJwtuHWLX1fLy5gP2SL2qfhiRhK78rKEUoCJ9/nQiAcNhqsJbKlhCykGlJK6iYehx/AlOcv67EFxaQf34IX4Goa5j9wibiM2vP5IEXwizNOErCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775849865; c=relaxed/simple;
	bh=u+1vrPfWfzmaWyGb6ZH31nPX7PYtUg9mdWTr4tZRD8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ue40eSC0i5W3z8sEe6pXRcuN06ZTWkNdGkDoEzeRox5JkblWdGy5j72tAq+0kbQ7E4v5XkbjqeZROiBK9bGQjmyBLJIRtfIvlEHKFgXp+Ep+qlF9tARyeOItmWjn0GD/bTMfFbqVDc0xViOEFiXZdVi/bXOidDa2XO8WcGj1in4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyClS5Z0; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyClS5Z0"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43cfde3c3f3so2350069f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 12:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775849863; x=1776454663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R6U/GC1NbMIaWhVGEM7MpaD+iSm/Pta7nRj5dtvFeGk=;
        b=YyClS5Z0LPnkClc1tc8f0ofJrLYk+7P0BYAlbwN+WIrfjow48nBYwBKovY3ohFIT1B
         SCf/kQdyYbbSeHkLE0ZtftgDrFxQ4egP0ccyPVYKWT9eE75dCnt+Mf3/CDMAaZC0KQOM
         w/R6ee1yg1leBxfOFnsvSf62umMdyZCk0DR6f/Y89OMeOkkLXKIXEHl9gH7QtOQvIkMP
         lfKuFggNML5MhF/57MCrJcrcVGp0oG7cwWcW+SvXDr2q166e/6Pa9is3Ad2m4K/iOzcD
         CNHj3y6EZ0qHa3n8meTILwnCovqkuXzEPtoHVt+jjdfr7uJSZebfR2IaCv/3KELldYGC
         X48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775849863; x=1776454663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6U/GC1NbMIaWhVGEM7MpaD+iSm/Pta7nRj5dtvFeGk=;
        b=Vvucj408/UGXS+IH0H4z5xYJf+5UlwRB96RxoDCL51yyQQk7OCxZNc0w444czMAtVW
         uarWci1T1mvKSh4Sz+NuV3l4KC/bMxhIcrnSKbvxRFsrmYbEocLjEQjY/9oKR2VbjkQ9
         a77P/WM9OJqR5gWrrYrAyOuzISV8hSyOxooPpKzbU1OtPQEsUDgNflcOqj2qlfQiHoRF
         qI1L36qJ4slyCJGaR/8aTdykEy03LB+AlESmg0W5Unr4mrCtNOkSjJF0z/q0eQj3MNTP
         Ti2ItQ4vwinFkZ+bqSSwgIfWmsFOd2s5kEFU04WgXYvLO5QaVJ2Ft10ZRTS6XRhaIZcD
         9uYg==
X-Forwarded-Encrypted: i=1; AJvYcCUAD8xCs7uafOy+IpxUn+RT1Im75ZO/T2+7oClv0zBjNY5KXPW/+9qUugkIihp/AwuJMeazVTrS6Ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWIRUw+blJmt0HpBes9nnVTojLAFvhW33/aO21J46Kj62qGeca
	EGcmWOHN7OHhvUQaXIkodfiF4o6hpHYBhvju4TIhVZjVLOfhypBNPeoY
X-Gm-Gg: AeBDietW6cfC1blm+uhTa8IFi1psw3n/GTo/AW065yVlZC7ug/9FNDs1ql9FbzAXd3d
	kMdOQJBqy0e8Hvu2tD2nVq9IHDufNzaV90/3xGh5hiv+THFvIe3kKQQw1SL+nksz527qeGbvMEq
	eFXriCmLFUIHknyqTFqIqpqDE/gkBb6syZIcZZlJkUD0elA2QNVKW8TqD3I1R5yTR/6yMDGpnHV
	iWEUcutuFj9a6iqSXdNDPy8ZWb2PVTqR3G3ZE4O1uGNgbfNChA94FeHrH929JTsPqWt2JEx4Mfb
	XllxiAwHppdisRQOktQNbwg8+oFW0WJTO+raQSzAEZ6RQDVu3cXDPuF16Ozk3Tdl3beZRizRHHV
	bFlhWRhfVM4uFjh3UgcsdUS3n0cmmR8kpkdF1q1lne1pb2nmtGJJwCnJyJMOe/UZJ57e3XpU+EC
	MziKRuJ6AYe7fU7YvEwlo8BbiyKQXZpnZw1mHPlGWsbc/oO8zkxUkkfeljhF0yc/41i2UolPlGR
	ZMposPy9xI/mrGmJV+oCXM=
X-Received: by 2002:a5d:5d02:0:b0:43d:1df7:ed24 with SMTP id ffacd0b85a97d-43d642a64b1mr6593078f8f.21.1775849862359;
        Fri, 10 Apr 2026 12:37:42 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e50044sm9690425f8f.25.2026.04.10.12.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 12:37:41 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH 0/7] iio: dac: Convert several drivers to devm_mutex_init()
Date: Fri, 10 Apr 2026 20:37:30 +0100
Message-ID: <20260410193737.35905-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


This series converts seven iio DAC/ADDAC drivers to use devm_mutex_init()
instead of mutex_init(). These drivers currently call mutex_init() in
probe but have no .remove() callback, so mutex_destroy() is never called
on device unbind.

Same pattern already accepted in iio for other drivers (e.g. ad5446,
ltc2688, ad7124, ad7606, vcnl4000, etc.).

David Carlier (7):
  iio: dac: ad3552r: Use devm_mutex_init()
  iio: dac: ad7303: Use devm_mutex_init()
  iio: dac: ad5758: Use devm_mutex_init()
  iio: dac: ad5755: Use devm_mutex_init()
  iio: dac: ad5686: Use devm_mutex_init()
  iio: dac: ltc2664: Use devm_mutex_init()
  iio: addac: ad74115: Use devm_mutex_init()

 drivers/iio/addac/ad74115.c | 5 ++++-
 drivers/iio/dac/ad3552r.c   | 4 +++-
 drivers/iio/dac/ad5686.c    | 4 +++-
 drivers/iio/dac/ad5755.c    | 5 +++--
 drivers/iio/dac/ad5758.c    | 4 +++-
 drivers/iio/dac/ad7303.c    | 4 +++-
 drivers/iio/dac/ltc2664.c   | 4 +++-
 7 files changed, 22 insertions(+), 8 deletions(-)

-- 
2.53.0

