Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1237946C
	for <linux-iio@vger.kernel.org>; Sat, 14 Feb 2026 21:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771102854; cv=none; b=rRuZEODk2WxwsHxhcteBWWH/j24p68zTgsQ/ymXTbVsjzlcfkbZJYOolzaUfpwx0O9nlyFHvfx3mTs97mQI+4QC66QBstgVy3Af6/E+RM/lfOMZUkFTnyRp/Ze3vhLd+KYpe0yRqsBrCx9xhNP56dWSdxX7yuRLujD05Dz8R++Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771102854; c=relaxed/simple;
	bh=u+2d2xYoQpzSjCzCDGd+eN4qGcY38sGOKNLBYRKL+0k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SK8S8xgC4I2sgq0qQP7jgPq4zWAWz5Np66ZQ98pj/jxZgsNHr04DPirj4pvDkMtmiPfhUuFhxML4dL1xn0qxY+ExhHcF/0bHrwedghDQiUpUTrJOFJexQB6oaueG87/0+G9NQb6okZpwbqmMqn4blc/9TZ5CDksAqY6Fy29d8mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RhhSCyse; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RhhSCyse"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d4c1d2123dso1926948a34.2
        for <linux-iio@vger.kernel.org>; Sat, 14 Feb 2026 13:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771102850; x=1771707650; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1AJN2DmyZzxrMDaAeIHz5lzUwylyT2LQfO5U2NARR4A=;
        b=RhhSCysexifnPlVI59KRQm2JKZy+2c1LOFm87hINeuQuKpnhTlqI3w+gOgxAKA6Lw4
         UnWHX2FPuTmQ77BM3M2+1eI96MsSFhTjcUexfCYtQGDs2XjFxqIvk07z8Ne7OIelcyb/
         SNz0+ipEtEw4EZmbvEIK15SIswqosKfeIgmPpHSa/VfdnMsUxRBxSj3eX9+CJ7Jsl6jT
         sQKgc2IGdDUKJi5mVbEYu24EdHnCNF3EDAwiK0q4X7nns4djA5H+ceVq7HMmA7OEmrbR
         J4kqSsnbPNs0NYhchN//f0knQSWpSi6LlT6iC3qaz1WN/ZsgbMxc4m2W3ZdU+WbILWew
         8LKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771102850; x=1771707650;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AJN2DmyZzxrMDaAeIHz5lzUwylyT2LQfO5U2NARR4A=;
        b=PKOnzxGe/jjA/id2255FbZTIbr1eVYjgNH+4m0diz+7gu02QLjZ0RtgTWy+cvED+JU
         3y9QZyDAzHMQvDG5T80DwTiV3sh2WTQRvqef0DbI8vRVjWxOVbJstY/cd8pslPsbGiq/
         NjvyYzACEdmJuoSmcQq9WnatigXpMF0nhMovwO+KiEVFJiSsrfEIcA4013E+7CJ8LENz
         nQ3bpmPW6fpDJ/aRkrdZ20XoS7qX3P/MrjzaojltMEbj6v16uHwnsRBJnioufbXe5JZJ
         Oa8QTx06iIX8N5XxCw5Tx4IIFySMO0TC7tIM2qPqquLFVDroaldN4e1opOPH/tz0E00m
         FUhw==
X-Gm-Message-State: AOJu0Yz7i8/3m2fH7NzA6iIYOayKN3swOYyE6NLWhpg3xlubp+aZ2U2B
	dNymkbPfzFY64rdFW173MMmIaEqbR6/1lIxrQvpb3p1HYZEbr1sIx7Ncv3p/IohOD3iv0QfV3K+
	znu4E
X-Gm-Gg: AZuq6aKC+V2ENASPME3C1XdYSLqyWCd6CD0loOKIS3KlYbAfJZ2I8IcA03Cv1fnjRti
	iANCK9bt64wiD9ANgOJ82qwCiZEuxJhsyLXqwY/kVH6pfluLnlomVkMP62qJnxgHQCT90cAYA/S
	PHIJ13qn9+13bf/oRMxHnZS90iXUo7Us2O4Oq+Y3OAibANwZoRC20QXXraYrdaVQbpybm0LUOgA
	AoKFAm961BvbugaV5PChoZFu97gDq7zwOqCMir3ZqOM7y2Fe4aegTvJu/vjaLfFOmYvxFB5nG85
	zQyGnlpKP2qTmIjiZZa9Nwi9wLVdEXd7RquZPKlesm2dkF5vhWU2EcVuaakBKzSABSKtFZx0Wuk
	5Ni7tehSoIvU+WIkoXCl87T9hkO4vtAWH+MPlPh231Qe/DZcDxZCwgzeju+/97Tu7+yLcvFsYhV
	sLck/tm7tmKjg3vrnzSIWB8WGaJw==
X-Received: by 2002:a05:6830:648a:b0:7d1:9832:4796 with SMTP id 46e09a7af769-7d4c4a785d9mr3643804a34.16.1771102849891;
        Sat, 14 Feb 2026 13:00:49 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:109:393c:254e:962e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4da074c15sm1181680a34.15.2026.02.14.13.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 13:00:49 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] iio: orientation: hid-sensor-rotation: fix quaternion
 alignment
Date: Sat, 14 Feb 2026 15:00:19 -0600
Message-Id: <20260214-iio-fix-repeat-alignment-v1-0-47f01288c803@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqEMBAEvyJzdiAOG0W/Ih6i2+qARkmCCOLfN
 +yxoKoeigiKSF3xUMClUQ+foSoLmlbnF7B+M5MYqY1UH1Y9eNabA064xG7Txe/wiW1jR5mMaSG
 Wcn4GZO+/7of3/QHQ6CXXagAAAA==
X-Change-ID: 20260214-iio-fix-repeat-alignment-575b2c009e25
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-input@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, Lixu Zhang <lixu.zhang@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1233; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=u+2d2xYoQpzSjCzCDGd+eN4qGcY38sGOKNLBYRKL+0k=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpkOJrV6kHmSUUdM8ecaLTEyrn2jpyKfO4+Agy6
 wD5YxkOm9SJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaZDiawAKCRDCzCAB/wGP
 wA3JB/0S8uXpjOHSBnUB2ezOVtqy46chqbQ4icjSU5nekObaWVgJ+ja8klq9UzsQt8iWY9Pd3y4
 u/J7qwABJnGOiA7T5tL1U2Tb+M7iok6PAUXK8BX/75TSNgOy06/NEsUPehRWeHYOdGyrSJKOXsP
 wg5We8G4gsEGFal1zFG6jjoxFjTOlQZY5ZB69/wv0fOXEGYa5B6gFYovlhaXI5qmiPFlqHPOc3x
 GpPpiqxqGKnbxj/XixWnEgN+v/nG7XCbcC4MPDjvoAXezL1IT3hZUYErBNOyZOt94Twzl+3hAkw
 doHh0gKCqMY/PIbZQsPl3KdevUU5e3Ph0LKLz77F5+o8VuZJ
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

The main point of this series is to fix a regression reported in
hid-sensor-rotation where the alignment of the quaternion field in the
data was inadvertently changed from 16 bytes to 8 bytes. This is an
unusually case (one of only 2 in the kernel) where the .repeat field of
struct iio_scan_type is used and we have such a requirement. (The other
case uses u16 instead of u32, so it wasn't affected.)

To make the reason for the alignment more explicit to future readers,
we introduce a new macro, IIO_DECLARE_REPEATED_ELEMENT, to declare the
array with proper allignment. This is meant to follow the pattern of
the similar IIO_DECLARE_BUFFER_WITH_TS() macro.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (2):
      iio: add IIO_DECLARE_REPEATED_ELEMENT() macro
      iio: orientation: hid-sensor-rotation: fix quaternion alignment

 drivers/iio/orientation/hid-sensor-rotation.c |  2 +-
 include/linux/iio/iio.h                       | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)
---
base-commit: 0f11bb7985ceef2aeeb5c45c3c7bfff3f5a16e03
change-id: 20260214-iio-fix-repeat-alignment-575b2c009e25

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

