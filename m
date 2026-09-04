Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DDD4503F1
	for <linux-iio@vger.kernel.org>; Fri,  4 Sep 2026 22:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788559888; cv=none; b=fJWd2QOiak9H7KKH5QQcg6xGhvEIpUrxTFo5x+99VDIvA7kah7gu9Q5ZwchQAIKnaQk8Nc7A5684pYXKhz0/4wjDk6sJIPDcUdAbSiJVl5nGBfYaB8tKp/mnKHGNR/PHXBnY5noees2eBW9mbBFquuPAMJRD24SXogoFNF6oOyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788559888; c=relaxed/simple;
	bh=4mIrQseGaDrWXOkGj+VmtS3xT3kzP+fkmkBCoKYUU7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lH55lYgZH87xE46fywNuM9R7tF879v3Mexkxyar91/ghzVtiGwcYVuBcmD51EDkOugAkcj9YedwFnx0yOvvVPQXubEbzF0CyPGcY0kCb6jQ0xPwX8PnZ3fch8kbOkEeWMsSd6TxbevsJINkHKH0kL/FQ0tr6QhevrcLjSlnmF+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=kEXUa+jN; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="kEXUa+jN"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4ab8cb2a6e4so1240707b6e.0
        for <linux-iio@vger.kernel.org>; Fri, 04 Sep 2026 15:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788559884; x=1789164684; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oxj4NP1Iiq6S7QGXGCteoLSsgcXgpsaLfh9MJtp5gfo=;
        b=kEXUa+jNsszt+1RTNnDYmbNl+SPwL4HoN7QcMbA5GMpIOzgdwvBlEfx48dTSAan0Oj
         xdplGynd4TuoD8huD/vtMH/lxokEX3bnlKJ6AmCZZxCE5cEZa0bQzRTbyqtR0GpssX5q
         hlnr1EX1hEKg21juGenQ+0SwbWn5+4lnem4L7aN8slhMC8QKuHcAo6rGBeGqABJ0KYxM
         Pql7stQG93t8WWseg1otADND+E19hCapBCa81WcwbtW156AR8+oLyM9xza1nGANtXrMj
         yLsmhluTNWCzi1yxomzSpAGKVDo6sy1gDwd1ktO0KqFajRY3BhPksBD17gKIk3nj8Vsa
         EnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788559884; x=1789164684;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oxj4NP1Iiq6S7QGXGCteoLSsgcXgpsaLfh9MJtp5gfo=;
        b=S7HIND3sGqsKSQ3U9J+033JLTPBy2vgHqA7J0ObjdZFOjlgHqYbkIRSZwMhZuaMzq/
         S/iYoutfbm4ChQtk6jvOwUiXIGZfAXXMfS5AAlY93GYWeupg9FR1Vub2ViPMUjWU/30c
         1tvJRzjuiaA5h+BZ5QSzVKyx71Vm6v+BsrLfgI3+aGrrmCOb1XxJLmqub5GPwwc+qXqt
         Dx+HFX5Gagfl6Qt5l73J/jO4wdKcnVJ9M2EQ/pTmQWovXyNXFHDR6X9Rs2ZToWfdZwsh
         psnzaTJHUDA0eP6uVKJkdA+fpf5kgQHVcWtjX769axhMaXeI+Fv8IiRo1wm/8zVBeJ86
         OL2w==
X-Forwarded-Encrypted: i=1; AKwUvBzrIUjPiNdmTx3dZ2Wr+v5UJZp0FFfZ7u2bYxp4Mxjro6cwxzT0MDtJRquHh2egQRAksoQk8q3/e3A=@vger.kernel.org
X-Gm-Message-State: AFuF++nSobwqq9HNzSmkc2Keiq0ftQNjzmldYpsauoe4vrQr6gruW1O5
	9a+k1d70EuV382HLC8ckCUFL1p8mKCdaK7+P4CtKW/6ozSmAbmhp18va6lhsxVJVOfQ=
X-Gm-Gg: AYBFou3npOUWYvVAOI45EDVLMqUAAGD5lcYlKtS4cHvY93MC4GeDACw0S1SZelNgdL+
	EyF/AGMETCyPeYOTt+6k0TaUNBr/dx94x9BzexDGyGp7s9nmOcdqyw1wsm0rFfaCuM+6vSHmdJN
	O6YqPX0M5TX+BiC92GmcMkY2QyQxHmxUlgSRXrmxjZIO1wyUoaFUfgJ7HChS9p1IpodLW7rkl+6
	G7bOdAIw5HoUyLiXvrqC319w9APltCSchjsu4jijVfsybtFKYGzy4gYf3dMVQdrN0TxBh9exZKQ
	xjX6hx2NZ3j/pdal4Tu/WK9r2S8yTfZe9pet1sbNjFhIjYQV38p2pEEb1qg73kMGPzGO88xj/Zt
	p9ZCM2eyMaV6/mEctnt1+vmQu4ZRvyxNRqw3jY8Z14baPJvJmvVf17fM/Puqisza0xCQhRVFdja
	YxS5Rw+PcD7JhoXOMB3QGTAsH+k1dOChH7enDG5v28CtoI5SJEjKnL1eXykKf2hIpthA==
X-Received: by 2002:a05:6808:1406:b0:4b5:a7a3:25ee with SMTP id 5614622812f47-4b96252944fmr6559379b6e.20.1788559884399;
        Fri, 04 Sep 2026 15:11:24 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4324:3ccf:e2bf:d545])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b970d1ff95sm3187113b6e.6.2026.09.04.15.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 15:11:23 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Fri, 04 Sep 2026 17:09:53 -0500
Subject: [PATCH v2 08/10] iio: ABI: add sinc4+sinc1+pf1 filter_type
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-iio-adc-ti-ads112c14-filter-support-v2-8-f86592360658@baylibre.com>
References: <20260904-iio-adc-ti-ads112c14-filter-support-v2-0-f86592360658@baylibre.com>
In-Reply-To: <20260904-iio-adc-ti-ads112c14-filter-support-v2-0-f86592360658@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=859; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=4mIrQseGaDrWXOkGj+VmtS3xT3kzP+fkmkBCoKYUU7I=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqm0HlQXdNNIv6P1pCGYX3k0ytCkSsrBvRFD/gx
 8Xp0vh7buCJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaptB5QAKCRDCzCAB/wGP
 wOjrB/wP+pIBS0ZXanR7Fag75lIXHQ8UPkpwn3bDpjabLNeuTguY43lX/pl3e5xPSXNgq2n8JmD
 7IM5RXzKz/vQupNeKlsz+iAbseCmomlK4hVfkMzus/pUb+wpWpOTAlTQN5v0z//RJmG8ocka2bZ
 kQjgPg4pKRmrQzpyFYyD1ss42q7k+JKcJTY9bukatphXZKGU7g/pIpPpBkIjPllx9ZZN8MHAP6I
 H2YevGAlw6t4zFIyP/MOZ6kr5Vy0xtsQJnEoVYbxlyLUYh54wrfCcVf6V7ZFVBws0edtP3zTrcm
 trxOOshaBjbYzagMhFWzAn8/db8LvuCDK+SGkiVeS1SXnq+b
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Document "sinc4+sinc1+pf1" as a valid value for the filter_type
attributes (used by the ti-ads112c14 driver).

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index a4f5595722ad..a8e1cb8e7490 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2380,6 +2380,7 @@ Description:
 		* "sinc4+lp" - Sinc4 + Low Pass Filter.
 		* "sinc4+sinc1" - Sinc4 + averaging by 8. Low 1st conversion
 		  time.
+		* "sinc4+sinc1+pf1" - Sinc4 + Sinc1 + device specific Post Filter 1.
 		* "sinc4+rej60" - Sinc4 + 60Hz rejection.
 		* "sinc5" - The digital sinc5 filter. Excellent noise
 		  performance

-- 
2.43.0

