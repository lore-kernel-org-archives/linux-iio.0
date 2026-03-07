Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EF71F9F7A
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 07:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772867816; cv=none; b=gFnvSQybpJHRfuPduCJ5C+H7opzy2bItwCieRN+lSsU2IadAKLSq9BnO5lWutLdYjmbWKZQ9mdgOngYIcjzaqlj/Ler7sbqbzvuxErujnr2AQBaJp2PwKhdtdm5XA8GCXuratO0i1X7QlhP4atu1o4a7ikGwvazXMRms4wBCjic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772867816; c=relaxed/simple;
	bh=UgtuvNuuCpf3OMp6KXUhZ4/C6amh9pWSM9108LhmcQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KV9rL78S6/CoYje1+Qr/LmWHfakfk8foTZ0Sig0orZoX2c8H3pnDNt/9j4zf9kj2/k1rmPlXBYxQ+4MjV8kPzZJEe1LfS7oYCoF/iWttRBKGLAkFwmCvPfqVaUfdm7MpYdhGE4DI08mKLmjS0cg6XG0jMrh9FTrvqNF47zUURGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Po3Yy/gd; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Po3Yy/gd"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439be84dd8cso720666f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 06 Mar 2026 23:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772867812; x=1773472612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MqMPHxhvDaU8Gqkt8uyyZpAER2QYZh9+IUNdHsWoCb0=;
        b=Po3Yy/gdop3ym342lTuO63v1YDiEIiU+d3QSTiE5mjxzVhBN5QDjKkWbivgXPfDKPA
         bnv+QHkBEDoe0/jDD4eRDe634/B35zbUbxXaUPkHzZfi6I/tZnfaGmf5wBmMOZwvhuQ9
         5HB+yXjfXCKDkdGs5vosiVfK39ZMFBCi5yMnKHI8gmDwP7X8QbIJnNH3uNlY+yyb/qT/
         aF8VbH2Fpy/SI2Ld6ThhT6IaEjRVyVfztyrE+FmW8xn4cHvbeey0Gw5AQMFKd/Ogj/rr
         kSUamxO538++woviOcMOR1cpKdXiJj1oQJwMb7abVU3IcaCD09CSiu4l4ip80oDMowlf
         1+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772867812; x=1773472612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqMPHxhvDaU8Gqkt8uyyZpAER2QYZh9+IUNdHsWoCb0=;
        b=TRAbU5iXc79wSvQAdv9TX3yVEUBXHSLNXGzzmwrTPOwcjFVXNr24Dwe7dV2WQcRBFJ
         IsRHJZ8KLBpOHDCoiL6Nu2vA0ogwxTkiT86X2c8pUkThP1iCMlZ/q0ee76LpVuvIcg7X
         9poi+ChLam18GZ8eLd9W3+lcCi+Hd2hBsvZbBQl9t/Dtatn9GN0g4KXCI8+6N1KQiqAD
         m30uEZJoHari8xme0yIM0AAIhCBUjzLIC6JNlierTK0TNAnkUoTx7rlSmmjmKMy8jMlA
         4rsVIHZpbolBaSWAoY1cW3IzVqnZ/mVJrnuJ2+uHIlT3xcVk18SO5/AvBQgEfEJ4suNj
         ezzA==
X-Forwarded-Encrypted: i=1; AJvYcCUhWdHURysQ7t3jn5R9UaKzAUpyk8TtMNHxbBChiuQDQZT04BFochwp+Fe6Mg0SzGVKn7ONjx0tY1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpzw7WGYjx2DVS9t9JCQ6nt5pl1KORrM5rmDQ7VSvjh/ALBPEf
	NHBhCNDt+uVhVZzd6Qj87Sp5b5W61GU707pOAZf9HbgEfBdTCd/eLpQj
X-Gm-Gg: ATEYQzyQUqzPPsPt2j/+JXL5etOWymdVWeSb/Ei6/rDIsk1D870Ipm9ZSNrGmONefFU
	KZkALfpwtXx4t7oJzk47nJYlcfWPYToSdCEWF7+CMBRN8hnRHkxYhDs+yo/JgpIHreU2enB/Apy
	goCxoHghuoNkdRkvm6KUmmXgdUQB7BkFS9V5rsSQ9UcAJzHXTO9ojGSBnX37V17P/F1d2gFK7MA
	5CgrOOoFjUZCXn9uuatZVGQYy6bHEviUY/mYbgNO9PcEBgE95PJZcllExym7PgN/+Cp2kjwseNc
	qf/og+yuISF8vEZ8yVNVkCzXIHx9zKBc56EYObtT9tx4BIMGiKSLz3ILLlmI1r1qBNJeOw+NBBu
	cXQ8H3JQclCuNuMcCm1upojzQGjXhoT6/QxN7Qa0p9SUNAz4XU7jX7/sBx/CX5Nx60R/O+GHJN0
	oYZ85Mdhn0U94ClxWcUNkGa3jf7o7lxWLifncAD+wNCpn2onb6l78S9YkFr/6mcQcsNYEUip7u/
	QXCZ5A06BNjG/n3JyL/iJCpry2REMLBKlpvXD7ZjFDD8OCqQV42
X-Received: by 2002:a05:6000:1785:b0:439:b59e:5e5e with SMTP id ffacd0b85a97d-439da0f8df2mr4133878f8f.0.1772867812113;
        Fri, 06 Mar 2026 23:16:52 -0800 (PST)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d840sm10630812f8f.8.2026.03.06.23.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 23:16:51 -0800 (PST)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: antoniu.miclaus@analog.com
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Subject: [PATCH v2] iio: adc: max1363: Reformat enum and array initializers
Date: Sat,  7 Mar 2026 11:15:56 +0400
Message-ID: <20260307071555.14683-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reformat the device enum so each entry is on its own line and add a
trailing comma to the final enumerator. Also reformat the nearby monitor
speeds array for consistency.

No functional change.

Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
---
v2:
 - Address review comments from Andy Shevchenko and David Lechner
 - Move all enum entries to separate lines
 - Add trailing comma to final enum entry
 - Reformat max1363_monitor_speeds[] initializer
 
drivers/iio/adc/max1363.c | 83 ++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index d35f4487b2f9..207d1e960e21 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -637,48 +637,51 @@ static const enum max1363_modes max11644_mode_list[] = {
 static const struct iio_chan_spec max11646_channels[] = MAX1363_2X_CHANS(10);
 static const struct iio_chan_spec max11644_channels[] = MAX1363_2X_CHANS(12);
 
-enum { max1361,
-       max1362,
-       max1363,
-       max1364,
-       max1036,
-       max1037,
-       max1038,
-       max1039,
-       max1136,
-       max1137,
-       max1138,
-       max1139,
-       max1236,
-       max1237,
-       max1238,
-       max1239,
-       max11600,
-       max11601,
-       max11602,
-       max11603,
-       max11604,
-       max11605,
-       max11606,
-       max11607,
-       max11608,
-       max11609,
-       max11610,
-       max11611,
-       max11612,
-       max11613,
-       max11614,
-       max11615,
-       max11616,
-       max11617,
-       max11644,
-       max11645,
-       max11646,
-       max11647
+enum {
+	max1361,
+	max1362,
+	max1363,
+	max1364,
+	max1036,
+	max1037,
+	max1038,
+	max1039,
+	max1136,
+	max1137,
+	max1138,
+	max1139,
+	max1236,
+	max1237,
+	max1238,
+	max1239,
+	max11600,
+	max11601,
+	max11602,
+	max11603,
+	max11604,
+	max11605,
+	max11606,
+	max11607,
+	max11608,
+	max11609,
+	max11610,
+	max11611,
+	max11612,
+	max11613,
+	max11614,
+	max11615,
+	max11616,
+	max11617,
+	max11644,
+	max11645,
+	max11646,
+	max11647,
 };
 
-static const int max1363_monitor_speeds[] = { 133000, 665000, 33300, 16600,
-					      8300, 4200, 2000, 1000 };
+static const int max1363_monitor_speeds[] = {
+	133000, 665000, 33300, 16600,
+	8300, 4200, 2000, 1000,
+};
 
 static ssize_t max1363_monitor_show_freq(struct device *dev,
 					struct device_attribute *attr,
-- 
2.52.0

