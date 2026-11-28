Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795866722;
	b=C6GbNXC2fid2mb3auZHTN1ZUw8S79WjPN5GHhSu3Fr3yrnoz+UfYd4I2nqAY8NXbkJ3p
	 scAo3D8Qama2P0DuqVhmYYm/77I5wGUAf68zS+hJcmTAui+oyLnjDNqQaquNVuM7ww+iV
	 uvi3aKta5GNofV3h9cn4rpWRX9o49pjvCY16UmeEhdsag84asAF2oMv3VYv1KFW9ulwj6
	 5j+AmXzdZSXwzmLoGb/AcYhEC/sV2BEy4NyPgn7dLdpOyOfOTjLjzdypnp8GB9b2CKitT
	 GZSh3LDtJg8GykPR7u0jWjETjEQ3/kDTtNptaEL6EtuMkMRGBT6FjdsYFr3mkwKglaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795866722;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wQAIunjbZ5VEO8eGZeZfnFQxqO5F52y9Of/nUTYaqm8=;
	b=R9OipnzEQ5OFE0YI9Vk8qKVMHRfCqJYsYffuXFe4f5NHwSy+b3hH0jdOluRL63ecwT6Q
	 Vwjpx36BkpSh1l0cS68zUMtZmvCAok2ZQ5k8lEyMGSzyzgdXf4O7LzLtpUBynpGf0ZNOX
	 BUic5ab/Hx96iCAf/B4wJL1sJGfjNBq5r/MQkb8tyrn4wxuzKUxsQUUFPDWlt5NELr+2b
	 BJ3c39MZgCHEDF+w19qZYKzelzTKy0N+rn8VvjdA16jI30AZHonUlFfZBR9cuNOQALspM
	 8NcM6XbGx+GpoHxKQjErlEN9q9ZOGrXZh/4AcyMRMsDXEOZVS9wvy7R6IFR8rq6Yx2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ap6jOXkm;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9F8606A31F
	for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2026 11:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F9F8606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ap6jOXkm
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-386cf1041cdso6619334eec.0
        for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2026 03:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795866721; x=1796471521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wQAIunjbZ5VEO8eGZeZfnFQxqO5F52y9Of/nUTYaqm8=;
        b=ap6jOXkmKMicDfUfxgcnRnW18agrg9BaJqYYH+bjyGcleTXPC7xrANAF6BPmZjCM8p
         xgt56SIWv4rXCC3XwcJJFChJ7qluep/p7ccNdsQhpzy5AXMlCwZvm8pf7ge9n64OyGc2
         Ki6pD/KaqcyqYY6isA1KeiOavhZZIBUQdsNBO63HWpDezIihlhk5IJI9jR+EiBQvHqLA
         07r622D8xZVtUpt4sHvwQI0eq4w3fDgDFWKc4LAzQk8sw9kFmpluL7WWffcSg/fLWZqy
         b/wJmKbrRALh69MgPiTeC+a3+I6kOj5VMU6S1pfCgMS1NOerL4ExJLq8wXSVA01EXl4P
         HIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795866721; x=1796471521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wQAIunjbZ5VEO8eGZeZfnFQxqO5F52y9Of/nUTYaqm8=;
        b=2wBlFySsTm++TtOtrfS56zsKOuIwsY7G2fQmZxjrH4ZsleQHfTyCF36vHdRumyx3Ui
         RHvJTj3gqQjrmL+DmsuGlRw5iMabi3R2SHDpHiqnquewCAcvYgpJ+gEN07U7VkzoEDme
         ZgrnCq1pcrFDPqyjkw4kLqmGg+5omS7ybCw7fb4NjqqF47gnN776UKPC89tcXtgb05HQ
         ZtTNn8QumsFuLK0Gqw7o0gmzNpT5PBzdeoNLJ6xPYe5LE81dAmV0FzEq9UY15P4pR1bg
         pJlCqP9TW0OJe7z1nzSW09MJ0KKzekHlJZCKMr+TTXiFIbWZ6OPKVEmo8YTZUaVoDF7D
         uouQ==
X-Forwarded-Encrypted: i=1; AL+hErFTYcglmaddUudbcdepcVFmhI06zz4OfnGF014ZDO6d9+N333L2tmOldrBb01ULHxAU3z+zkr4AEbE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/JgYtty/FVspHtaqdX/vzUIUBQ4LzQMttD/ir4mv+bk3eYJPpy
	Zc7JVtFLnWSfEUB8Ty5Ib3mptpOA3aVP+OGrmEbz0IjA2Bbd5FhMH8gb
X-Gm-Gg: AZFdTZfK0bQdWB9FGYWLW0AjHZa2GKhOm+WbUNz5t5SGM22QUD/5BJEosR+jVpkgL7J
	y5qC9hoefpBBB+GG86TKRUvg7BiqFhtz+h7Lz1vkZGG2X5QlbXesDyOuLeo+jbGSTUzIK/aeLAu
	K9AWV1MJRFQJZpZjgg0718Rai3bFWMLdyCbe8Zpg/UCE7K2HQ0gl/nS/1QjlIJkwYBgEpM4iSUq
	Xaiw//9dQWzpiL5V+uHayQgY2DFxDK06DRRzg7CV9vPF1n2C8/bNlMMzZ9RE9bQfYrLWnQ+Zsjq
	01bR7U+FPzva490w89XnLvXhhnQPVps+zv06LbQqkFxFEmt/yOOEtFPXqu7LDX+qjbKvjQljosL
	uAY8vuR+BPT2mtmDwoATcDG/o2VoLh4Aale+UxCFkotE3wSjF4FZOyuvt1eaoYZNqvoDbSfVJf7
	Jxkl9v+6Oc8spo6jLhfmQ6KmD8pAvNxa2ypTtMiOWR8IU/yL4R25pXde7mcAHTywVJ8DszpewYc
	JW44vO2TlNVXrw1uT1VuZQHA6dnA1hr3EGDoCu5ol1PecxaYn1LQSWEhPC8a8inQV7jK1sRKLQZ
	7ACnuz1Yo/EIi47oBy9RpqLVHuKBwTk3WLXY1X6NPHasa+Xmr1NJES1i/h9NLwFKKRNwYdX4TTE
	0I3EP0cfJGVAbyku3n7xzddJKXgE/k8Kaufks/drWOwOEedkijQ7S/Z3sgjqrQeXc7Y3TeSlxP+
	WGIb+dCvNpar3AGhapxKUyeBosjX8xBEDddlHyJZjeDQ==
X-Received: by 2002:a05:7300:e9d9:10b0:386:ce20:31c6 with SMTP id 5a478bee46e88-386ce20334emr13305569eec.29.1795866721134;
        Sat, 28 Nov 2026 03:52:01 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385c6830815sm74256544eec.20.2026.11.28.03.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 03:52:00 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v2 1/4] iio: proximity: aw96103: report negative proximity diff values
Date: Sat, 28 Nov 2026 17:21:38 +0530
Message-ID: <20261128115144.557411-2-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261128115144.557411-1-kapoorarnav43@gmail.com>
References: <20261128115144.557411-1-kapoorarnav43@gmail.com>
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

The DIFF registers hold a signed S21.10 fixed-point value (Awinic's own
aw_sar driver documents the diff data format as S21.10), which goes
negative when the measured capacitance drops below the baseline.
aw96103_get_diff_raw() divides it as a u32, so a diff of -1 (0xfffffc00)
is reported as 4194303 instead of -1.

Convert the value to int before the division instead of after it, and
declare it as unsigned int, the type regmap_read() takes.

Fixes: 07b241262dca ("iio: proximity: aw96103: Add support for aw96103/aw96105 proximity sensor")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/aw96103.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/aw96103.c b/drivers/iio/proximity/aw96103.c
index e3ab55170b6c..483b3bf18d19 100644
--- a/drivers/iio/proximity/aw96103.c
+++ b/drivers/iio/proximity/aw96103.c
@@ -261,14 +261,14 @@ static const struct regmap_config aw96103_regmap_confg = {
 static int aw96103_get_diff_raw(struct aw96103 *aw96103, unsigned int chan,
 				int *buf)
 {
-	u32 data;
+	unsigned int data;
 	int ret;
 
 	ret = regmap_read(aw96103->regmap,
 			  AW96103_REG_DIFF_CH0 + chan * 4, &data);
 	if (ret)
 		return ret;
-	*buf = (int)(data / AW_DATA_PROCESS_FACTOR);
+	*buf = (int)data / AW_DATA_PROCESS_FACTOR;
 
 	return 0;
 }
-- 
2.53.0

