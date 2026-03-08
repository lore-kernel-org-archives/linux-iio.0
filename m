Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C39C293B75
	for <linux-iio@vger.kernel.org>; Sun,  8 Mar 2026 01:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772934308; cv=none; b=h+hph0flKYDDIN+abOIGbv6XsQmHVDDmVMkDiFCS3yq94gEbDjCM8VlbTK7gihuLlhKf+h5OwWB8DGBEEsdB28Zbz8A32ACTGyA7b5DlgRxVmhGBo2FuvfXeaUB60Xtmbqv1+nkCocnZu+h2WUb1oloNgg3AmWyv9VJaYZH2ljQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772934308; c=relaxed/simple;
	bh=KGGRE2l5CPjgVQf6RrPuOXOkhsx986TzL2/v8BKzEhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YW7aYtXurCBjm+uN95pYfRgG4/8Bqkwd54r0vGTW37XyiQrPZX7pw0JwOyUmkZg2tixRYTE3vFmE5J2XEqxoPMq2sq6eMRvG5/QajXE3c0rn2HtNcNwWOV9z0p/esK2oLvXRNdGPNh2TU/kPZh4zpGiK+JS4GvFNtw5kjJOS7UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=avbRg2Nb; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="avbRg2Nb"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-466f1c3c646so465635b6e.0
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 17:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772934306; x=1773539106; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X+TAeqDEeBH+L0ImN7q+ZuCaBBTUct7hL3W/vdGYMsM=;
        b=avbRg2NbpEQmJDI0V9ij0HawrzKvT4eoiZuKVpFqHUpq+lch2jo+Lr6SPPhHu4v9Jd
         5ktfHxm+ssFg0TTkcshRErbhW3qxF47sIxJsBKhuPpb/sdl4By35pBiUAYdIYXfhkZ5w
         /SHq/VhltBvT9gD/amEl3TPqT8PUms6edQf4Xf5PmOn8drJUA83qP2uvNhac6C9AU8n7
         fpiWlqEnahhtp1hyyR8q8vWfyBR9rhtV5zoytfqffVDNRZtfO0LDfDPV3shzp2bJXmmG
         ERlBS01aZO6udLll3MiKo7Y7wGsiiUVRnI3ybOXD71l77kmVBdGsnWo9+LkWhQaDYxhD
         cdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772934306; x=1773539106;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X+TAeqDEeBH+L0ImN7q+ZuCaBBTUct7hL3W/vdGYMsM=;
        b=FcSljKmUiaMmUicksI+n6mllvDW6GEVeNOOfUSJGImRfe1i+ln+L///EXn/5fa0jdS
         2mpyhqroON9MoEUELzYvQaKQyEcctp5hPWkTxnsVmEnyQvLEwzHS3iTfObqj8naKkCGh
         Fq4Ia7tKsTjgJyro+oQpPKhsxqqIxeBYo7p+VVc0jhSM0XbxXLJo8hocZ/4sR/q7jlMk
         YYBRG0w+NXQ1wqJtDSMjrgLNaVejBLYKHNnZRV1X46y/K+X4O903z1AjpKgRL+CZfxF8
         uiJzLulSTqYLl+aWCsaOkmvbO2y1yrvRnIGWaeUluAlPMpuyEd8xweTMXXFEyWxRYI3v
         AhDw==
X-Forwarded-Encrypted: i=1; AJvYcCX4MMEK82q97G2EK0K4p581rcIfV3FdR3NPCS7zot0TXlkn08XOxqIhkb4dTnG+Pftig+JfgCWTArI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfzAUlo7kiJdBPt7Oy15sS7163cmXZ7J+uiC5raPM9detlLn4Q
	B8ygOnQ3RKZxzssLjUGEuurxxNLlemu2hPyfReXxblPGQnGxBXB9HvOfPksKwOJDX5k=
X-Gm-Gg: ATEYQzwpVuQzQepEdjjJ0ysDw9KPWHfXdz+XJF+rp5EcMLckiB8B5xAC11eamoqlhFB
	f6mRSoTj4zXKC26v9222qhCiAi8Sx/x+S2vIDHKgFqrvSrqmHRIFuzMZ2HbFehXjla8nqzl5lu8
	HuzlSh96m92zzCuX4hcf3G3nr3RF6YiBGntCErrCwGKQVg9gly1K9p+wT7nqvVI0fmUbJSAR5Q1
	Hc5Pc+GqVlJ4teds8KNxCPsWijsu6pa1bwa628vx4F+ByY2Cudl5P/7zGKaeIX/HvF7Iy8+YsKB
	1wZxzE1/WmviXdyNq7rwmCOf0jTqNwCwpOe4BuAe0uMVs2YPwwfYfA6PMt1XQ6C789J75YFltCB
	QRSiSc+LNiwFvZ4X5nx8RTMoXPmNiOe1JCEUDXw34cwbzoc7HFF5beWBtwijzSbJzbVwSqHzI4H
	prcQLt3bcBAEgUJSZZLi3jBU0p12nI
X-Received: by 2002:a05:6808:3a0f:b0:463:ae2a:ebec with SMTP id 5614622812f47-466dca4883emr4113475b6e.22.1772934306280;
        Sat, 07 Mar 2026 17:45:06 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a7b4:e550:6d81:e067])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-466dfa96903sm3244357b6e.13.2026.03.07.17.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 17:45:04 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 07 Mar 2026 19:44:12 -0600
Subject: [PATCH v2 4/5] iio: buffer: ensure repeat alignment is a power of
 two
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260307-iio-fix-timestamp-alignment-v2-4-d1d48fbadbbf@baylibre.com>
References: <20260307-iio-fix-timestamp-alignment-v2-0-d1d48fbadbbf@baylibre.com>
In-Reply-To: <20260307-iio-fix-timestamp-alignment-v2-0-d1d48fbadbbf@baylibre.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 =?utf-8?q?Lars_M=C3=B6llendorf?= <lars.moellendorf@plating.de>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Lixu Zhang <lixu.zhang@intel.com>, Francesco Lavra <flavra@baylibre.com>, 
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1535; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=KGGRE2l5CPjgVQf6RrPuOXOkhsx986TzL2/v8BKzEhs=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBprNSI+w5dXqe1KCxUBkRwVln7cnSQ30EL5CJJI
 YxY1TzRbAGJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaazUiAAKCRDCzCAB/wGP
 wH4hB/90QpXGpaE2wP8nKyQz/wOwnUDGw6z5fgcxEBtazFY2zIWfUwisWjYYQyu35pJtx7Bw898
 MUdE8yz3wQ77dhAL2cy36rCPInbcWktvIe4w94jnvzzBFvT5FeCOpNFvS3GJQpS6HY6qDb7iCbN
 wmjgCQnTJAUE8qtrYaevWBFMMiolx6JbQjwrj41/iORpBDwUB7Yp+Lju9zdTDbawi/auffhnbTE
 DmMScQWs9neU662/sMmXpqtR+mP/+KgiYW3BErGnzZnS4K40utpHfLTAnCTC1B5FMsK4E8oL0ij
 WzlyxVFeZoTLI3RgRk7Jeq1SKRruGvY/HGwqysIJQTUtq+uI
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use roundup_pow_of_two() in the calculation of iio_storage_bytes_for_si()
when scan_type->repeat > 1 to ensure that the size is a power of two.
storagebits is always going to be a power of two bytes, so we only need
to apply this to the repeat factor. The storage size is also used for
alignment, and we want to ensure that all alignments are a power of two.

The only repeat in use in the kernel currently is for quaternions, which
have a repeat of 4, so this does not change the result for existing
users.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes: new patch

In v1, Nuno made the point that if the size isn't a power of two, then
the alignment won't be a power of two either. And this could cause
unexpected problems regarding alignment in general.

This will affect the work Francesco is doing with IIO_MOD_QUATERNION_AXIS
which will have a repeat of 3, so this is a good time to think about this.
---
 drivers/iio/industrialio-buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index ecfe0c9740e2..c38da24561c0 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -748,7 +748,7 @@ static int iio_storage_bytes_for_si(struct iio_dev *indio_dev,
 	bytes = scan_type->storagebits / 8;
 
 	if (scan_type->repeat > 1)
-		bytes *= scan_type->repeat;
+		bytes *= roundup_pow_of_two(scan_type->repeat);
 
 	return bytes;
 }

-- 
2.43.0

