Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793024445;
	b=HJ1VHc49kXkOQj8lQMJD6t2cgGQUMlnEhk4761h9oR3yDMVuWj0dJrOeGnF44uqipvqo
	 IVj/H49Wj5Q/gbYoFzqjF9PX9EkUcS6wxs71Ha5/iE9YYnyEEZi06ITSFPeoaQl9wH5IQ
	 35lcCJcADjGpQyc7dAqMNWJ3LyAVaRouI48TjmO3zPob9mikDCJupolwLdqZpzwZvLFOt
	 tfXpdn9ZI9TS5k+OraswguQwioTNJiCjrda8JOt7z+/y12xLl3ZI5k298Wqe4pbEla9/Y
	 /bGbXdJQChspxMQh2O1t7Q6sm6kxYOBbolF95xo8ZqSaKeqQwDfD5OsBRxC7WTF1+zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793024445;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gZsq+xXtHizaLpzo1tER32r/t6mRAs6VUf47ZcMCllc=;
	b=ZHqc60WfRKi4yNG0v89v4WXR4GrdpDWO9M0hXyJYB5WjPRbZCDAcHGwDhJ1kjceWKiW/
	 MSwO89l9nGloTpoHGb0uoB7MSeG4uk6eT9SsGw5AIYshX4wsw9AXEDJsyE3cq/D8ewcdh
	 lkzdtvhWSLXzcTXC23uPCp/U9wkjyHacN0fQ+yEdHEGnQJAUdZ/p/4GPAFma4trnJ/oVd
	 spgq0aulWmY9B1fDaPGMTBmJtOEGGqIJAc0wmXku5vFklAv4KnpPsq+xWS06xD7WYAcv0
	 xfCgb6L3RzYv9HAZ6mv2gR8KA2I3ZfGNjbKZos0qxdJHflX2gshkBZBdOSmZhGjeZcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PiF1ICPh;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9977606A31B
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 14:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9977606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PiF1ICPh
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48e0d1da913so2460753f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 07:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793024443; x=1793629243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gZsq+xXtHizaLpzo1tER32r/t6mRAs6VUf47ZcMCllc=;
        b=PiF1ICPhsZXEQPej5refTiirqNLb6J2mK+PQpmijJDAQZIHVYPOgPgdiMURTByH7ET
         UBkXeOTqyfsvCJLtcrfBSA6rP9+aNOb0g240XThoIqfIJiiaop7HmgnaypCcuWf1s4p2
         ytFIjBB0+KKOuEFkH3avHr4KEUN2uajL0N6Z6jIP81H6TuImv3TO6aK2QNR7vOIWp5BJ
         aBd20eMJyrW5n6WWmWVwLYHdhj1eoq8KizhzKESpCDQxIfPoqJzFjqcomM+uMMMKPgms
         yRTZdmZNEUfzyrBNHKBR1AfCCpvDbO9xOA015wRMWC1U7kjfDDjpHVEjoiN7cOPujFxT
         Ko3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793024443; x=1793629243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gZsq+xXtHizaLpzo1tER32r/t6mRAs6VUf47ZcMCllc=;
        b=KgjmI8oqWgqWsCy/s3B199ilw1DQ29tQZqlXaPe3iBAH+ZICPo3icClMr0C8JSQSzV
         IPV5Q+x/IqVJZVcTlbA0Y6CkCIAT2Znfh8AClhABx2FSUpj+J42764N4HwtVIK1BP2Ct
         qc6LHtIOK3QWNTz/hb6scn+dMsQmscghy9kETWHUz3dOxlklrAw24NN2OUg/aDgxp8GU
         ZLn65hn6Fe+10pxsdca4Svk6yoRxs7219624nQaaaApiGc/mESx8ZrRzuQnGMQA49r3r
         xtoUMkzw34bUmSNZelXdMQXOHZdmjWY91R8SR0GecOCBMC+qVzH81IARJ5oFx5cFAHDR
         iM2Q==
X-Forwarded-Encrypted: i=1; AKwUvBws7QTBEEvU11Ds6EDZSu721LJ8w/rTFL/0+6+E28uPOXbrI4cOYC8ONjRyHi9lV5m+smd0p6pi0jo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQNeZzVV2i20VLZypXHVRMLvJJJRmZMXjlKcoKIYKhtXELXwFk
	DnjClGeW8C2jl83JRuSvOitJn+rCCc5vpNRvc/pSz+hvTBnm18/KVTo=
X-Gm-Gg: AYBFou2XiKR1iF/t+LTr6ReYrf9wmOYzh9DFAVHI+vE2NJu3Oru1AMSflbltvSLPAch
	o5JCVQ0zU2+pitX7U+Ll7NyrWqAtKFlv50SD5wMQC8kBnQDP3VYULf+2pj1nGkYFcsYZbopHMLM
	T0TISzZ9uYDdlvSORyakkZET6VZ4WaNPwwXV2NRpx/d3Mz7H8zC5LCEIMQnWPasxmR98ZXsG6Yb
	CGef+v0+mxMZ1+3pkefdRzfWEshxif7Xjiajdv+xUqefGUHKAYNRo/qEC7xNvB8GrQlHqgJGVSh
	naqrHA/sXrQ/nf4FTyJhzxxhAW30JlaR4T8nMtRYpLcH/vv4Pu8Un+7bE/rc98hXMFkGHIO3UVs
	LwLftIL2RLt8EozS+Jhyq0caWwGgm03O0JVSNYJfd/xS9cTmWlj+iUYjQJGPJIHUV2QA1nv6Swk
	NRsULLkc2bfXb4vIwcgQOO6rRDx/3BijSr43owMdKHTVvfGe07LlWH+9iSgYioFIwQrRhu8B/vw
	hdt5StZWa3LOcKKRfdcHg7E
X-Received: by 2002:a05:6000:2881:b0:48d:f1ab:faf9 with SMTP id ffacd0b85a97d-48e3ed2c7a8mr13855318f8f.16.1793024442950;
        Mon, 26 Oct 2026 07:20:42 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb8d5sm17484186f8f.28.2026.10.26.07.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 07:20:41 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Kevin Tsai <ktsai@capellamicro.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2 0/2] iio: validate ACPI object types before package access
Date: Mon, 26 Oct 2026 14:20:37 +0000
Message-ID: <20261026142040.62383-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

Two IIO drivers access ACPI package members without validating the
returned object type.  Use acpi_evaluate_object_typed() to request
ACPI_TYPE_PACKAGE at evaluation time, and replace kfree() with
ACPI_FREE() for ACPI-allocated buffers.

Changes in v2:
- Use acpi_evaluate_object_typed() instead of manual post-eval type
  check, as suggested by Jonathan Cameron
- Replace kfree() with ACPI_FREE() for ACPI-allocated buffers

Tristan Madani (2):
  iio: light: cm32181: validate ACPI object type in
    cm32181_acpi_get_cpm()
  iio: imu: inv_mpu6050: validate ACPI object types in
    asus_acpi_get_sensor_info()

 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 7 +++++--
 drivers/iio/light/cm32181.c                | 5 +++--
 2 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.47.3

