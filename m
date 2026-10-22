Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792695443;
	b=0Vlt9QM3Y9I1RGDgY3onlnQBMMfho4jq32HyABWEbvXiSYX9L2NYa23IpNDqhF6b6F8H
	 48pYEuFxVoH4b5Z2xAkgWekelyv8lU71DJsK402V69ac6Z0u3wBbDWXZVJSjd4kfFpUF/
	 FnT/4D1VCPVorrnt+YdcRB1zJKeHKq+AAs1tpOj+wtMiHz/QAvqDm2TLxNKCwDl77MBgI
	 Np9q2PoXWt0sBar5oxEDWaaOuUVij0ryP1zdTbY47kM8JPdzFEoMO+h9LfaE/3hNWRKi7
	 9aaE9JnDxE1ya6yUaIK4bnZGOadAjS8i2ROpSU8AJJHJ1CnYEwNXdJzFmE3IJzbggbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792695443;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=rEz2DJU5xtg+qo92FpdybUYGy6jNujiV1g+Xw84W7WQ=;
	b=NdTUKp1VyktpNjLcYyI+eCUR+Bf6zExHEplotTOVue2nyitF6sbt+WYNMi07oa6SeuqE
	 U/LqyhSXIP9gwQ/FXeNincsKYJdhlcRt2kNcvId+mQ8sbwL0Gc2TtovzBx9Fcmtxcca0J
	 82iHDe+7ugvoT31hyZ8tXonoFMUOwMj4tGTdBJ7H9pWo3wy9oiDSJwygyb6Vz65/bhlly
	 9CyXAOE3Hbqi2Z3ot4xMXJ24w5W+StKKkJRgEpsdaWRnqB79giFZlsxVtCJUxU3s2HZOJ
	 F34arHTAipAseFPJ7QxNuMgNMRhy649IzEkHFYm1d2J3NveHkY3D/88YJFA4VlL6fjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AVpASINv;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AEE606A32E
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 18:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7AEE606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AVpASINv
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48c4d870d54so76574f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 11:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792695441; x=1793300241; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rEz2DJU5xtg+qo92FpdybUYGy6jNujiV1g+Xw84W7WQ=;
        b=AVpASINv3/+gIk07o3cZ4mqOKifekdjWq63VFK+94SiZrLUp21Qg4skNwLfIxkCldS
         +t7KV9LnqYlD3Ea4PZe326XriH7qkvIc2h5YkoLixpo/jBmWCb7ALDCmc5/oT/SEcq5U
         QTCnvFoueYXinrrjjE8okFCIBSsGoF4W0E/UMKTgfaSkLv3mDNXQ411sUzUL+56C6De7
         CLv9EVxSMne8fCDmqVmd8EfXEjO/AsNIMoc23oKUBZxxpkKk6KMClwnVj43zEVTOz3x6
         eHVYz6mfuo4k4u6C4HMJABXfL7cNmTDlbPjfBoLTAn83tQFJGvv46cIavJDJpx4viy3Q
         1Yjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792695441; x=1793300241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rEz2DJU5xtg+qo92FpdybUYGy6jNujiV1g+Xw84W7WQ=;
        b=RUO41Qldz0ObfTYLOklG1SXQkBDXoKFvaOVKPH+Z2fQ84QuCdLehXTd+KNFEadxIrS
         AHW3lrIm7InmT4lw2krtt+4A06H9dWOrfv8KMbU2epsIkc/pfZwWobK84+xmJHi8/o8c
         hXxsFiSrL7EYTMYI+uvBW3GG98dSr1gN6/qzTH6rGWH9jc7Rj0CAy/SrMgXpRInoqDF3
         qwsEscmh8MM01oDZk0TbolHSNY0D5ZfLGTcbKyz4MxnWk8AYgGfysNGlOYMM00CGHYUo
         D+gILiC/Uu+1hXYzP0nIEnXQYVNipK+tKqpor+HZQLyIhXd0wcI22/+ZZEFRQW2qmFwM
         qP7w==
X-Gm-Message-State: AFq9FYJYc/f85twF2/4IBD2fMQi4oZWVyaaIuYzZ8yZ3/Gqt2keXMHSe
	rp58OcCm63bcyzDiRh7eSzE5a5smCQpyxBSZV+zTjhU6dSfnnEKHfHru
X-Gm-Gg: AYBFou32zp9ZOhshakkPP5jEsjfBqOsKqOmaadczFtRQIl3OMY01QymrTtD166+cVaN
	ugJ3dGD2FkRD0XOn/0UtMVdu0rCtOm0JYIdwWcwmQSA44ruqeP1B2W5TPpeXv7PA7dGccwxkUg9
	JmioaCBOG5/cdPtSh4Ge74qwYJ17J9YA9CxHCpkJQel51gfJJzttk2GabgGdkRHMy2Pj8PP5DhQ
	yApq6FVsNVRGBXdbQPQjon5sfbGx5wEgWh7WoyhwlqrovAqGujxCYK1Z5hh2mNqt9m9UV0nrkej
	ZzQA8hajnKYFra+WvbG3jjzAFUN4X/0cQoDRhQcde9Zqw3UZx45O7xirrdmKL8vv9AHFvpI3amY
	i3k4rUkksn8txzQOyjfRvtA4WwvE/4VBG3AEcEPEf6ChtjDSu29ItTapOyfe0+nBwci7mS5A8Mu
	elEBINUeiqCZ/jtaD7a33xMFhZTUzrlb1dfDYssPZwtatFokTTtAxuohYA0g+gggt0+HADX3PUL
	/GaPZfAmpKt9sxgwDUmK7vpm7kl527McFlXHV1JQIJUst1cCbk03Q==
X-Received: by 2002:a05:6000:136a:b0:48d:fd5b:504d with SMTP id ffacd0b85a97d-48e264b1ff5mr8730839f8f.31.1792695440986;
        Thu, 22 Oct 2026 11:57:20 -0700 (PDT)
Received: from localhost ([2a02:8308:b092:fd00:d900:ff27:14a1:f032])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e379e6daasm144016f8f.30.2026.10.22.11.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:57:20 -0700 (PDT)
From: Jan Remes <ciakval@gmail.com>
Date: Thu, 22 Oct 2026 20:56:41 +0200
Subject: [PATCH v4 2/4] iio: light: tsl2591: add I2C device ID table
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-first-patch-v4-2-90b2fc6e8e28@mycroftmind.com>
References: <20261022-first-patch-v4-0-90b2fc6e8e28@mycroftmind.com>
In-Reply-To: <20261022-first-patch-v4-0-90b2fc6e8e28@mycroftmind.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Joe Sandom <joe.g.sandom@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jan Remes <jan.remes@mycroftmind.com>, Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.16.0

From: Jan Remes <jan.remes@mycroftmind.com>

Add an I2C ID table so that driver can match devices assigned via sysfs
or through board info.

Signed-off-by: Jan Remes <jan.remes@mycroftmind.com>
---
 drivers/iio/light/tsl2591.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
index f56d31404c25..8cfce720efb9 100644
--- a/drivers/iio/light/tsl2591.c
+++ b/drivers/iio/light/tsl2591.c
@@ -1149,7 +1149,14 @@ static const struct of_device_id tsl2591_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, tsl2591_of_match);
 
+static const struct i2c_device_id tsl2591_id[] = {
+	{ .name = "tsl2591" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tsl2591_id);
+
 static struct i2c_driver tsl2591_driver = {
+	.id_table = tsl2591_id,
 	.driver = {
 		.name = "tsl2591",
 		.pm = pm_ptr(&tsl2591_pm_ops),

-- 
2.53.0

