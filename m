Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E464E353A66
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 16:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786553100; cv=none; b=oEettaanT/JDyngQQ3UfY9ZefQiz6tGZRo+68cLHXaWvBKlAmoEQugINwXUnNwJJ4RwzNuL1T+3X6gXz6G1L5RlSd6mHI1k0D72acUusKWMUuITAilDPNbeR3W/eZTUvGVshtAxzpUkNUyrYldfdSwhnXHSvIW0rHmWRvOg5Xxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786553100; c=relaxed/simple;
	bh=f/UUJEQwVW/zzZmUVc5qiSPTThaU5hzPDPyQD5pCBD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jdFHM7P8I9ej6YKz+yYrlhbThUu0529j6GMMLOzXrxyfMqYfQoFixtxP+LJT8ONbpVpGC0uGBTeMP7Z/XY69iwOrvZZkQkpQHvMIB9s9mROO/K23SZwXhIm+PTxzhjZV0xHBbNItBcwrgWVqNFrmhQMjLtdqWTWup4HilIATbgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RExa3QpF; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RExa3QpF"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9cf07d2df6so791397a12.2
        for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 09:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786553098; x=1787157898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=moa1cK3lyfsCbpEdiaubsjKB+6nL5U25oPdI+VgXliM=;
        b=RExa3QpFqURe3OAhgJ9IoXRvPAXa7kWZhoN0F9yztNCWXJ7aAxp/hzkA2Kvx9m10nU
         tD4+5bDEitfVtR8fp+cODAkabSwUyJSQNFyEzYYmRDqIo3fEpxAGKj+q3vYOSEdw+jFK
         UkYqjxt+IwzUMgW7eKy27xzTtePC27yNIfG7xkKsG9v1+4qckaBjZdXM9ZwqlrxJRlmq
         DQ0Dq9ntz58SaEavfCvZxf10VbNHTIg2ITsodfVu3QpEzi5H9APrTI/myl2+v/Z3OpHo
         ga8lgBCI7f6qrfCJtb3HDzgQHVzWlbIyzKMbQkAZ+QOlwUyNnI/UYxCPNwcg5iPYQKc7
         FFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786553098; x=1787157898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=moa1cK3lyfsCbpEdiaubsjKB+6nL5U25oPdI+VgXliM=;
        b=jcUQxQz3v9hdF0TlHaQnlO32pcUzReRSSsFnTq43fXNuMhym/U/ZBxSqTHE2i89819
         RSvZ8+f/PoiIDG0vgAnkJxdnKrFZzFAvCNYAdtFZgfR9Wzse9zQDUs9fNS3vPfP6sKAV
         PzqpC/kp0hHElrAFcKzUOBN85bt5OklNZvLOytLYmuPKNbnUAwavZG+78BpEovBjylHB
         V5Zw7Ejqj6eHr3tPKF3r0wKbloD0sgrwEOiEjg/4jn9/vJHXgzHtlN8ZguCpi7TthnZ9
         D766emS/JmK1NTiLZSJXUnRgvbo/po82ivoaiQkvh+/3QsJDBW50bfMj6sBVxHN3rOy/
         b4uw==
X-Forwarded-Encrypted: i=1; AHgh+Rr9RREhSKOpfc+C35eBoMv6sZTKWNHHv69ileTcKg7t+DVl14EXKnhWx7jSVV8VsdN8ZE8DLClqOc0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Wa+Z2G/e2OKw48+80rkCy9ueEAybw7ygyejdL8XqJg08NvEx
	x4U9Mv0YJf1YbIX+1oAsmxN4I+vo6XlB+Uzrv1gStabJ0PH1wQ2as34G
X-Gm-Gg: AR+sD11XsW1NNiiM3Q9FLaudo/quDzPJ+0nACkrh1ei+Z07AjMuTEyLr9Ag3WialSyT
	H7ebm9MLnob9X9KHxiMoU6QElBnmcaiDgBWCrJuNuQyKcaJmCXIZf38IxqSqqlKZqrgEAbQ1XSw
	+umnEmr7PkCj5pvCoqRguUpg8QHlL0YReLe2W0X7+G75F7fN3FJ2SoWjT8/dKPVbHJqUf2eZM1c
	WUYCeh3YSQzi58ir5npwnu2dfR3MP9lhVLC7iDUX2o37CszddWMAakgX2VpdsKodOsd6c61hCOH
	vJoL9KUMrkr4H/OvaCF03qRX64nVHN4pICmKYTaJWWZ90AAoeYAYZCATKAald+l/7PCqW7PUkPN
	qMTO0kBMqBF/zVoX7DtWns8K8jAkI+KqXxNIfDJzxv5c7gMjE+dgGFbmFQUpu9amSe3KHfKr43O
	AjQObG/ZZFedWqWOf+9k9kkMj0WPZPJ27f7umPG3slR21GZJnZwedC5kj2Y6BHOt7c4tMFRF+f5
	CozfzyDE2QldhHdOH768IEKKxBtAMlZDSA=
X-Received: by 2002:a05:6a20:748c:b0:3c3:954d:278d with SMTP id adf61e73a8af0-3cc3f5b8607mr6676207637.9.1786553098174;
        Wed, 12 Aug 2026 09:44:58 -0700 (PDT)
Received: from debian.ari ([47.30.26.35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf40f7151sm12462621eec.12.2026.08.12.09.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 09:44:57 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v3 2/8] iio: adc: ti-ads1015: fix PM leak on probe failure
Date: Wed, 12 Aug 2026 22:14:27 +0530
Message-Id: <20260812164433.23011-3-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260812164433.23011-1-architanant5@gmail.com>
References: <20260812164433.23011-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If iio_device_register() fails during probe(), the runtime PM
subsystem is left enabled. This leads to a resource leak upon failure.

Add the missing pm_runtime_disable() and pm_runtime_set_suspended()
calls to the probe() error path to ensure proper cleanup.

Reported-by: Jonathan Cameron <jic23@kernel.org>
Link: https://lore.kernel.org/linux-iio/20260718225515.7e49a458@jic23-huawei/
Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 9cd620b71429..3a14fdab56d8 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -1042,6 +1042,8 @@ static int ads1015_probe(struct i2c_client *client)
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
 		dev_err(&client->dev, "Failed to register IIO device\n");
+		pm_runtime_disable(&client->dev);
+		pm_runtime_set_suspended(&client->dev);
 		return ret;
 	}
 
-- 
2.39.5

