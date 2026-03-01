Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007103382C3
	for <linux-iio@vger.kernel.org>; Sun,  1 Mar 2026 20:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772396734; cv=none; b=j89VubqdEsd7or24OYjKF2hHh4c6Nnq0p6fL5RHeEOrf+8esH034OexmjEjBUt0txyxYHL2N9Lu3DFNLQn1hQUD6HnrR9axtfnrPx0NhvvoXG6y8LJ02j/4Y8VI5TltVk/snHn6J0cu4mg6cSdKFcq8gQkH2KwPj+q8bFgOSkEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772396734; c=relaxed/simple;
	bh=Df01JxrgdJ/czk7PscfActXgUF6VwomhAfkjAESPLys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=htEdBmb66AIPjDr8ooD1TVjIDChCvPJf5O+cEGw5UqbwPHLED8BDQhUQ5we87biRnLQ/E1FZO5oJ0IfcMxuomliFJ5/fpChO5fLEkwPIHUUtdyud+bFUHLoOsq6nBG8HggbbRQoYDAhz7RKvJ+JrXZpV+5uwKiCKrci2HLhsnVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uhhhyiv1; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uhhhyiv1"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d4c68f0e47so2464409a34.1
        for <linux-iio@vger.kernel.org>; Sun, 01 Mar 2026 12:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772396732; x=1773001532; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bxzCN3wwvXWsW/jY59gqah99qTBhWFcny/0HrO0Lk6Q=;
        b=uhhhyiv1zR3AvFJL1XvTr3bCwy/VsKGzh7j9quJjgoaQmGIG+KDVOX1Rk9wYF7cZN6
         hRdZPQZ986HLp1HZL7G4Q9hC4ukR+gQpryZcZ0ZxVsx0r97coFpKGZNXvJzBa+qd71UQ
         HmVq5DPTysFWOpRmkxa0AZy9N4yMuIb7gu3ueeeI5CpFBTrj5KBg1DdWkEHYCfvrSPsR
         S/0fF0rbXS8/qknDuC2o7OFY1Hklm74o65hpblLh2T5yvbzEM118TJqYT3QSd52TjDpa
         I1+h2anl+OShLyc+X0DDWJQFvGJrATGUqP04rza0APy4gQ26jq0dMsxtyGXpxqPl5iHk
         JmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772396732; x=1773001532;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bxzCN3wwvXWsW/jY59gqah99qTBhWFcny/0HrO0Lk6Q=;
        b=slU4IxUGoRLyoXP3fPPZL1jVZlTkeDD+dBzwVYyWRHvtsOo211red562LpIrAoaod1
         4zEuhxc9PITSafCqndmFSTykugo5elaAdCamBhx01hEHjvcno0k0rxebuE/BtX2ey1R4
         SOOZsMA4ykyf4bNtxYP2pjabHP8CIw7ieyF5QZ9qSmj4dXy2slUG0svOQG5vsl4P3o9m
         CAoyJURHHXgvlWzYnQHhy7pImIPhILgAAUX7/MzLaWtSmjkd1390L+Vw+JcNhJcH9lXs
         B4dzQE9m+my8qeKvAWO0gsyj25SVeeVdyBL4ARfJaZFQelq3PsohC1d7/Sdsa7jyFk1T
         pT6g==
X-Forwarded-Encrypted: i=1; AJvYcCX36YeAft5wG2AAO7sJ2YseIjYiZmBBlOqNwI8+cr09BEtzfVqWiLOx8XwvY8bqfq8gTgSrgYhFojk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Tr7LEetZrH9UdpK/47wvof8nJEYAugn2x3789dB0ahC5SQGh
	4WrOdfeze0WORUFBDfx37yyINsCK9FANrQjt/7DQu38siFcRNZd4AzgtyYTFgOeTzMCtiMvO543
	L8GZD
X-Gm-Gg: ATEYQzykxMu1X5N52GnLEs7+Lp9MDAqav5Xji+ZcbF0m1+XgZGixnKWAMaT9BUguLTG
	fLTRU0ew/EmN9TkM+fST1xvFOz60K+JdMdeMHyuCYhKGyaI6ZQtLyOTgUXcQvI/27MxhTBF6hsr
	hTTCsn46mnbcwzCZfvLtZQf6Xt4nJDIA/8fNCqr8tcGG0kD2A+JbQKcxh3oq1u7uPu7kiRAMBig
	vUqRVwA7iQ3oo8lkyXi+GSmk4qMMGnyuq9d/VA5y3rIh+gmwLG2CbJrYhxEjBp/ymWSMzSg2Ihp
	V2WGr7hLCCCL1DcEHJ18jk7qAq5uK0mco4QY6QfqGINOgSSzflXesCPvM+x8eGxmt0ZGFyxiKUR
	4JoOC9uGTXwnVOHQ+4DZYnfVN2tUWwFze2oeznMl/IP8meYGW+JnTLqXAKSw7Tx22jGulDJsUpj
	nVL5gNvmlCu5G/5Jx+kMVhxd7g/CmM
X-Received: by 2002:a05:6820:1885:b0:663:40d:48a3 with SMTP id 006d021491bc7-679fadb6ec3mr5760441eaf.8.1772396731996;
        Sun, 01 Mar 2026 12:25:31 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:8b9c:d657:204d:5a5f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160d277316sm10063025fac.17.2026.03.01.12.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 12:25:31 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 01 Mar 2026 14:24:51 -0600
Subject: [PATCH 2/4] iio: buffer: check return value of
 iio_compute_scan_bytes()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260301-iio-fix-timestamp-alignment-v1-2-1a54980bfb90@baylibre.com>
References: <20260301-iio-fix-timestamp-alignment-v1-0-1a54980bfb90@baylibre.com>
In-Reply-To: <20260301-iio-fix-timestamp-alignment-v1-0-1a54980bfb90@baylibre.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 =?utf-8?q?Lars_M=C3=B6llendorf?= <lars.moellendorf@plating.de>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Lixu Zhang <lixu.zhang@intel.com>, linux-input@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3313; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=Df01JxrgdJ/czk7PscfActXgUF6VwomhAfkjAESPLys=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBppKCjOvjbpvzjZFuFI5GjHBqD/VSIz93rBBcy2
 iiKSDNP+wOJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaaSgowAKCRDCzCAB/wGP
 wJzVB/9NIIyQ7h1f9VkV7fjfHarpvVFFmMWtxU9CFevKWQR+gsbpXMCIWBIXW759ATP3yNS5p0M
 DWBav1gBpOgLTQhgUHhe3pRI4KTtr+e2akshFuQOUpxTB06IbY44JHzpDhiZkonZY8ZCJaa6CQQ
 YjEJga0dm+RcE8Qkxz2OBRva0T0B5ou24/eM9Q9BFGhECaaQYPkWHrAtb/JNrlzG9P1rFXWGs5x
 K8xwszcZyn1s3cdDOgY33Wm6CowSsBQy1oznbuWmCmMvtTUpHTsvCOpJFHmgNx5zk5MV1tmXDrB
 9J6EjkagKZooY2N5HRBUMNlDJZPE194tajiCUOi8EiPLFHTE
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Check return value of iio_compute_scan_bytes() as it can return an
error.

The result is moved to an output parameter while we are touching this
as we will need to add a second output parameter in a later change.

The return type of iio_buffer_update_bytes_per_datum() also had to be
changed to propagate the error.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/industrialio-buffer.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 46f36a6ed271..71dfc81cb9e5 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -764,7 +764,8 @@ static int iio_storage_bytes_for_timestamp(struct iio_dev *indio_dev)
 }
 
 static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
-				  const unsigned long *mask, bool timestamp)
+				  const unsigned long *mask, bool timestamp,
+				  unsigned int *scan_bytes)
 {
 	unsigned int bytes = 0;
 	int length, i, largest = 0;
@@ -790,8 +791,9 @@ static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
 		largest = max(largest, length);
 	}
 
-	bytes = ALIGN(bytes, largest);
-	return bytes;
+	*scan_bytes = ALIGN(bytes, largest);
+
+	return 0;
 }
 
 static void iio_buffer_activate(struct iio_dev *indio_dev,
@@ -836,18 +838,23 @@ static int iio_buffer_disable(struct iio_buffer *buffer,
 	return buffer->access->disable(buffer, indio_dev);
 }
 
-static void iio_buffer_update_bytes_per_datum(struct iio_dev *indio_dev,
-					      struct iio_buffer *buffer)
+static int iio_buffer_update_bytes_per_datum(struct iio_dev *indio_dev,
+					     struct iio_buffer *buffer)
 {
 	unsigned int bytes;
+	int ret;
 
 	if (!buffer->access->set_bytes_per_datum)
-		return;
+		return 0;
 
-	bytes = iio_compute_scan_bytes(indio_dev, buffer->scan_mask,
-				       buffer->scan_timestamp);
+	ret = iio_compute_scan_bytes(indio_dev, buffer->scan_mask,
+				     buffer->scan_timestamp, &bytes);
+	if (ret)
+		return ret;
 
 	buffer->access->set_bytes_per_datum(buffer, bytes);
+
+	return 0;
 }
 
 static int iio_buffer_request_update(struct iio_dev *indio_dev,
@@ -855,7 +862,10 @@ static int iio_buffer_request_update(struct iio_dev *indio_dev,
 {
 	int ret;
 
-	iio_buffer_update_bytes_per_datum(indio_dev, buffer);
+	ret = iio_buffer_update_bytes_per_datum(indio_dev, buffer);
+	if (ret)
+		return ret;
+
 	if (buffer->access->request_update) {
 		ret = buffer->access->request_update(buffer);
 		if (ret) {
@@ -898,6 +908,7 @@ static int iio_verify_update(struct iio_dev *indio_dev,
 	struct iio_buffer *buffer;
 	bool scan_timestamp;
 	unsigned int modes;
+	int ret;
 
 	if (insert_buffer &&
 	    bitmap_empty(insert_buffer->scan_mask, masklength)) {
@@ -985,8 +996,11 @@ static int iio_verify_update(struct iio_dev *indio_dev,
 		scan_mask = compound_mask;
 	}
 
-	config->scan_bytes = iio_compute_scan_bytes(indio_dev,
-						    scan_mask, scan_timestamp);
+	ret = iio_compute_scan_bytes(indio_dev, scan_mask, scan_timestamp,
+				     &config->scan_bytes);
+	if (ret)
+		return ret;
+
 	config->scan_mask = scan_mask;
 	config->scan_timestamp = scan_timestamp;
 

-- 
2.43.0

