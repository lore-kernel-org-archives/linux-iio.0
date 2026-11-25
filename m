Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795595327;
	b=Mv7sR+zgAIUYFnB7ZlhkvqPxAKFReHW+t1tYtjsgxhqzJzGJ/+cfV+t0uaWGLFi41noc
	 f7k0yaVhn4R4h/Aw07fgAC6UOGX0ig6HkH9Me2cA8+m0WoPMf805d2CAJYyRwo2/wK5MQ
	 tmWwb6TcUYY8Q+2hMzbdWD8z5jO0m5S5Sxq+yImmTRSvtJGBA6T8tlCmgboncecO5G0Ky
	 nSFMHtqsgV9fexrlbNpN8ProHBJR+DeUI9Q6JW4zEemBdbKypTePyWSBWLEirXIodLFy1
	 dhiFdaHpeGMG165nqyhZz1PcZaWp6cu0aTOyKeWv3Z1VjwXhtOq7hhmZb6SCuLjErFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795595327;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dttfp/B7lZ7wNOriYIGKd8nyC9bGgBVDFvE22VqbIYk=;
	b=BAdS2ZISEsw3y4BPXsGIVN1pNHpFMIr8obg1F/HcfGiEcb9GJ4AteSm151AkGYgucF92
	 9QpFGXp/ND7MJOHJjcZbfpO06rOSmvZBiI/ZMyyMEEsfgTbzgWjXAJTjXernf0JXE6wjI
	 bihdw3p6/UP4NMDgAlgL57FdjLsswz8lwtZgp/KdU4bWIrYcBtq3A8Hs0bLPjbFeX3hp3
	 ZFRqSJTIn3GyA0SZue4IOI01l9O7kr/5Ud2xOit666bM6v2UZVniNcxsOhuNfwUMZ/24z
	 7HRlvAYbV2EPGYUvjU12z/2/cZQnCNAX69/EPWuieBhk+JhRWRzUqRK8OlT/T1bnOQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P0ThPuBz;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E66606A332
	for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 08:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11E66606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P0ThPuBz
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1b546061d58so12410080c88.1
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 00:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795595326; x=1796200126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dttfp/B7lZ7wNOriYIGKd8nyC9bGgBVDFvE22VqbIYk=;
        b=P0ThPuBzy8A+SceJKFTZCU5j5QqK8FO9NPu7KDw8M2BgUEoLTMxkxOoVJA7f1mJLDi
         ewuPK8y5cEdtO8SsFdncNnjmKeLoBZX/0/GztLuOMUdJb+hQYFYvFMY8ZWJK80Vemw39
         SgqbHIz9i6FcjQy0LpWsF7yd1cin1x+Tn3bMXtW0sikpN1GQNoThGIFR8JFfJ4sNrcJQ
         s1rIS+SRADhlv54ibcUx5Rlv6SjOdhuhn9pK83SzdpliNxv5WX1QiVpdRbP1n5LDJVEK
         p+51LXljwzvjOM610lAv+v33SxKFkAa/GEm83dQkqtQM8uCil98uQvqw/fPfpqAm0D3u
         eB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795595326; x=1796200126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dttfp/B7lZ7wNOriYIGKd8nyC9bGgBVDFvE22VqbIYk=;
        b=vTB4CYV4g/rOkFqOV1qdylhEUcj4fI3O4JkV3QEpD17yywrqqqlQM9LhU2dLRfUmd2
         CDB1r1R091ItcRMNeKc114J+oB34Mm9kwU7EI3NgcezIBJg2WXWB3jBKbVwH6yKr3WIw
         WATS2qPA35aPPqnLmlHkxjiUyOLq0nvL27AssNkEIy5/W1sSdwEfe0Ancv3CyaqScsDN
         Y9lGdU+q/lIVmY4L3n+vkADZrQa0OB3xFTYzjezUl2W30s6ZbgFElRjkaxRy6s7euSpj
         ojUJG07DiFNDzyGWkgrY75bmdS1/kPgQZaEaJqtH5MMl21HErgN04ak/s7wY+avqpAoT
         F0FQ==
X-Forwarded-Encrypted: i=1; AL+hErHuOy5SK5U5ZKGtmMddd9L2p64F7Mthd3sUZmk0gPt0d7dOhPep1WQvSwGoYyOdL8gSfaoCPEFdWvg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9EF0yZ3VbKvHZnASVU2Am6L0W3OqenrPGh8SSQrYv4AWs3ZUyn
	OcMZpT+AzvaBxiBCs1RrkWeOJll7ZA8bC9tlnx2ZWzP+YuQHKPDUTbgNOR2B1g==
X-Gm-Gg: AZFdTZeOr9jY7rj/vLnAFmWmzRs/m8C2G1F9+DvU9524Evge68XMNcWiWYJYy1P54XC
	teipV63S1cMLI3OmFBPyL1jv4cp75TT6rj9QDVBztupBFzJThKePIoQivvLcEIUyzqow5ifksu4
	H+lSUgEqemG/KyUuBHGGAL7Xq0z7vMeGmAE14jpH9a6Nup5YXHfSiZyFcX0HgwEEM2EmY3krVyF
	XZwkqip0u1z0qkhUfdxlgDdw//IlAhTAPknm5aC5jOnRuOAmEoyqtDGkYnb07QLsbT9eVE4rSbA
	Tmxuu7LAJZmBslZ92FOdK/ZgbnXdDZXoqGJw0p0z8YZEsJEBZozqBJ27R8vy72hFlynaxMwL7BW
	L3CtaWLnm5dImzmPmkM7BKnyC6O3bE5jmyQ+WX82qxaHXxvGS31YElbvuHYPbH0LxNkMLyYCdKc
	Tt3Bk6C+Gj8LdXh7IihukqDSov86pFHf9dmwWNAfBnJkYOc2hyJpWJkPYjRYW/TPhTKSJgtV10m
	UTsZazmPA19/N+BdfR8XmqOQQBBEU9zMG5VOrnASOviaXLcVkqJV9WiMInxQjERyWm3vTyiENxc
	yeLVGr28inM7rO8c6GcUpc9KzLQgQnpd19DEeKouweK9sUnrSL9xtQ==
X-Received: by 2002:a05:701b:2704:b0:1b5:4f6d:8277 with SMTP id a92af1059eb24-1b5568e78b1mr16606421c88.26.1795595326056;
        Wed, 25 Nov 2026 00:28:46 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55681301asm40511409c88.8.2026.11.25.00.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 00:28:45 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	Andrea Merello <andrea.merello@iit.it>,
	stable@vger.kernel.org
Subject: [PATCH] iio: imu: bno055: restore the order of the gyroscope range codes
Date: Wed, 25 Nov 2026 16:28:40 +0800
Message-Id: <20261125082840.1340359-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Commit 399b883ec828 ("iio: imu: bno055: fix OOB access of hw_xlate
array") also reversed the hw_xlate table of the gyroscope scale.
bno055_gyr_scale_vals[] runs from 125 to 2000 dps, which the chip
encodes as 4 to 0 (datasheet, Table 3-9 "Gyroscope configurations").

With fusion off, in_anglvel_scale now reports and selects the ranges in
reverse order. Restore the order.

Fixes: 399b883ec828 ("iio: imu: bno055: fix OOB access of hw_xlate array")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
Noticed during an LLM-assisted review of the hw_xlate lookup check [1].
Reproduced in a userspace harness. Not tested on hardware.

I used an LLM to help write the harness and this patch.

[1] https://lore.kernel.org/linux-iio/20261123135554.2983499-3-maoyixie.tju@gmail.com/

 drivers/iio/imu/bno055/bno055.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/bno055/bno055.c b/drivers/iio/imu/bno055/bno055.c
index b1c7b4f88bf10e7e0477a1d424bbb4815f59c6a9..50543ac35f044c18b6734224dba94286e6292c76 100644
--- a/drivers/iio/imu/bno055/bno055.c
+++ b/drivers/iio/imu/bno055/bno055.c
@@ -171,7 +171,7 @@ static const int bno055_gyr_scale_vals[] = {
 	1000, 1877467, 2000, 1877467,
 };
 
-static const int bno055_gyr_scale_hw_xlate[] = {0, 1, 2, 3, 4};
+static const int bno055_gyr_scale_hw_xlate[] = {4, 3, 2, 1, 0};
 static const struct bno055_sysfs_attr bno055_gyr_scale = {
 	.vals = bno055_gyr_scale_vals,
 	.len = ARRAY_SIZE(bno055_gyr_scale_vals),
-- 
2.34.1

