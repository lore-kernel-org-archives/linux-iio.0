Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792951407;
	b=xiD3lQciU8zYHv7Tuqf9MdKe5ytZxA9TBq6msoyZH13ku/LZ/sDLg3gG8+kHT7Zfiovs
	 IYe3K1iWwhPNcakkKlZ6g4IVfd2y5wgU89078QDYDdSvpK0Clyo+urOHbfJicPJiTnHbm
	 rTjyASCrjf1UXxAqf9ajAjSQ7tEZPvBwNW1YEjhSeiushakNO00hhvk9RdGShbbfLDsJ3
	 r5M77CfX0Z/4V7po+Xf264BRVr83/Yb7JjA+b8HwiKaixaUmy6HyjsrTA9XEf5zKC50DS
	 ZFGWwZeBdnqVwLbWGlXlNDfB4N9ozQGQygyN6PuebMRam5sxYBSoXNs2qyKVuN1HTeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792951407;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oGMF4Q3FKs8fn3YAByKtysFrkHDHvnUFQNs10reubHI=;
	b=D1Wjl3M2M44FP/jlj7jnhkaSWOnK7DAMkLKi1FpxumSekPSys6uwhlBOrGUGYqBfSI9N
	 rrKNXeXI4nDuAucpcKsrAu3urftlap9437wBZuAyjN6T8kivt/alCUTv+tqOTSCqYM3L2
	 WIBqZ0jyYbO6B8Y4phT6ccuIRy+0wue8O9TqnxamgGHlYPXPR/2uA8OsXuGiT7ea6+iHX
	 3g89YFNnMqA7v+1RH0AhCCpCoKCxAbIeirxsKbiCTqz39ZV66NXiXLopiuJ5LsxOXz9Gm
	 u/3Af5jdkWRuuAEyyxHaIsMxc6eP7jM1Eelb4LlaPDrOGX0uxQWbcJh8wdiHVKuHJ3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Yz3DAhZa;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE56606A329
	for <linux-iio@vger.kernel.org>; Sun, 25 Oct 2026 18:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CE56606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Yz3DAhZa
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so4176135e9.0
        for <linux-iio@vger.kernel.org>; Sun, 25 Oct 2026 11:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792951405; x=1793556205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oGMF4Q3FKs8fn3YAByKtysFrkHDHvnUFQNs10reubHI=;
        b=Yz3DAhZa1ioTItGzQDNf9M0ywPd9fITkrY8kdwClnU8r3li7j2PGsQtcTAdpnVaryL
         JTXKcNOhDKV6qK6UtvgsAdfGmK3ArnEEIGTwIOMm93uMNRYkg/wOq7mTvKNL335m1q/5
         f5Dl2tmVpHj7+Ncg9u/G8lpmFoJYzq3eryI+8FsxdPWV35FhFHF2SaChRXw+0J8JD6vh
         UV2glsk3BhDvC3m7CditfmOSViBdHU+TzKxjopFtOdFFI/Jt+biqXWoAkYrKrfvdA25a
         TDc8E3gWN0Q1JDTwNoTBDlePhzi5wBXQ211kIUW7isjHO1zEcoxTXnBnj514ON2iESpw
         RXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792951405; x=1793556205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oGMF4Q3FKs8fn3YAByKtysFrkHDHvnUFQNs10reubHI=;
        b=zxbv8wgqundQxIJcpJG+yR4Hb9nIhs3/QXvViyfDQ5BfI+CzX7GndjCkMRMyzhLUDp
         uz6whk1RSDaBODwT0RK+k5bjvuUbBwZMN27vp72hLmw/P+2n0KTCHTkpPvvXkLm64mVT
         1Q7xaCFwV0WebJrScvcjz4r05+PD+8L9FUPafIg6dJlpWchxmC23DtGrGpGPVapkYYSE
         BYXvlKqdjNm4Db5Ya9fCWSSjOLPHxsT3iDSFgN3U6ZtrWD/NMb3nqvLgWU/vkMeqSJtr
         mJa4j/RpkRxQvfs2kKIpZ0gxclUv5PLtYQHj17yKU5hAZKBNOHWGvsHXs70RQZYTEXm/
         d3tQ==
X-Forwarded-Encrypted: i=1; AKwUvByXZ95SR4hOMZ3YUGil23l9gNUMbT1Q7Gv+Gb8Mawz1I6WvNQKdvdDi2sh15GtEBjnX27NvYOoyS+s=@vger.kernel.org
X-Gm-Message-State: AFq9FYLcAai5hbqOa1yAB6lwBJlX/EHdfjo7ngPychICAWm8Sw1iinMz
	5lhZJ+XetcW5rgXNicrt0P6DXj84VSHgr1cpp/U4Zo6dS1YbU8B9/vo=
X-Gm-Gg: AYBFou1xL3My5a8ujPwcLvJo3FEypZDRzw0+/d6k5/NKXSRDn+IA9svDE+qWRP9EtKc
	zIz1M6VyPX2dOTNVtpyyGZbrd/92JspEH2iw5dcpMQYSEU2zlRjN4nfI31cFhj7i+plIfRqU42n
	/hQrbjsTv8+5daV1VbosmV/tpRlKijaH/U6lN3JzjNcyDVniXhIGBpOG0ZJXTagiP0wEcOcUhRp
	XNjbjNzDPIKIJU8G5ESJtbUd833AO9oXeAe8+TCBxPuw/PzztMkuW2SwkH4bQ1UjQsHluobaRKO
	8QR6JbOtlt+fVS/b29DTugc6EcC/KtDauE7IRDWcoy92QKLZmqcFWX7rakS2jZht6+vu/qiljA2
	OZIMIL3XE+e7f6q3MGC9K++jyjljdInOeXhJfr+grzRMCe0MEmbTfN9HkSIu2d4gXdCT769KYxK
	SKv/e7M027GKHhc9YUnr3fijFiBQZBSQKrdpuYAwzBmk4MnrcNvAdgkgDdMjWyfzL2Iam3adpxn
	xVyvroO6L9GHlI7c+qE+GuMqXjd0b80a10rZg==
X-Received: by 2002:a05:600c:630f:b0:4a1:efbe:529c with SMTP id 5b1f17b1804b1-4a35ae9e071mr92039425e9.12.1792951405253;
        Sun, 25 Oct 2026 11:03:25 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a4cb7bece3sm82641055e9.10.2026.10.25.11.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 11:03:24 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] iio: light: cm32181: validate ACPI object type in cm32181_acpi_get_cpm()
Date: Sun, 25 Oct 2026 18:03:22 +0000
Message-ID: <20261025180323.3641477-1-tristan@talencesecurity.com>
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

cm32181_acpi_get_cpm() accesses cpm->package.count and
cpm->package.elements without checking that the returned ACPI object
is of type ACPI_TYPE_PACKAGE.  If firmware returns a different type,
the package union members alias onto unrelated data.

Add the missing type check after the ACPI evaluation and before
accessing the package contents.

Fixes: d34ca613b939 ("iio: light: cm32181: Add support for parsing CPM0 and CPM1 ACPI tables")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/iio/light/cm32181.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index b32a94028f091..1528465be6adb 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -121,6 +121,11 @@ static int cm32181_acpi_get_cpm(struct device *dev, char *obj_name,
 	}
 
 	cpm = buffer.pointer;
+	if (cpm->type != ACPI_TYPE_PACKAGE) {
+		dev_err(dev, "object %s is not a package\n", obj_name);
+		kfree(buffer.pointer);
+		return -EINVAL;
+	}
 	if (cpm->package.count > count)
 		dev_warn(dev, "%s table contains %u values, only using first %d values\n",
 			 obj_name, cpm->package.count, count);
-- 
2.47.3

