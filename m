Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793105412;
	b=fixi7R2pVtl+Bfin4dsc0Fu96wLHd1h8HPawZvKnHBWXiZxEt1b6iPU8468rlKC5Rlys
	 eElqzxHnOVG0cmSyoWVsguIxfsT2cneaB2pGPPlXJvOToKZg8Gl3C06ugrAMcEqC8P4mb
	 Wxk0D6lOrIJjYR7wtZQG5kXv0U9/JzunMcU2oJgukXnohFxbb93XNIT2k06wYD9oM+mgI
	 GgrSitXpU6T/Givfu6fdT4+9XtsMhdj1TGRQ35xXtT0sSy7U+yFN+Gpf551eHBlDacmLB
	 HoYOJnNkXE0nx7WKriPmHfoCzF7YDh6XHtRDlqLR6gG0tuxTfbZgNoM/0A22czOVEUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793105412;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+ZfYLczmvRoSi6CaREX5Mwnwxrh4r7FBoQ6OBNNjGi4=;
	b=PLTbov4DVTF+iko/Fk7PEC5pfYd6UnCQkYh6gBhmWOB9M7avaAZVnfXYTMVXX38/AEsX
	 whWmPo27RyL+QvUB/T/uGyOzzqWEPJZ2ltaUucGUjCWK66xamyGQ82AcOw1jTi6+uKag6
	 4NVgTw4S2i1HvrgBV3btGUd+3VWsTEzs7r5DARJyQPUyUYa+5WF9nnrEHdKzDUeTV3Ol7
	 1pdTc1zm4BZ2nbX6YaW63J71/FEPWanpTmlIJSH7N7BWHIp9tuhz/80kfV1Vp2UTUa6Nh
	 GZ86SXtxq91JO3DU2jZEggx2DLR/mP1VxXOdRy8fjGgPR5ivUlU1oPu4mFGwBvTkCww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="EzESZW/H";
	arc=none smtp.remote-ip=209.85.167.42
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9647060A3808
	for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 12:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9647060A3808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EzESZW/H
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5be42ae8eb1so2720942e87.2
        for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 05:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793105410; x=1793710210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+ZfYLczmvRoSi6CaREX5Mwnwxrh4r7FBoQ6OBNNjGi4=;
        b=EzESZW/H7tOi7GvKKOrMRq6axsqyMq3xScPbGJQxm5ZGKGsHeduTOyDyl4r3phHpuD
         6DkQepdlV5Dr4XL0yivuJYfJSLm4VTu+fuIbIrw9aWrgrSOywUqKeZtlcsC4r+yiAqpg
         HOSQ98PfzDkySybEL05MI3yswMOq0127zLMk+KJY87FefJ4VPs/CSepGX1P18B1uz1v5
         At0gAEGEBj7pbxoLX6hasgbkDtIChAacXgbOfJyR2y2nfLjMqNw/l9dSgFOuXUG9KLkS
         fNAAgoVRWlOuF8kw8lviqRD9bkQ2jIRlfPejz7IcTidhncHCvrU63Oe4SHlNWseWhFy8
         Clww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793105410; x=1793710210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+ZfYLczmvRoSi6CaREX5Mwnwxrh4r7FBoQ6OBNNjGi4=;
        b=MEbSgw4X9CkoEL0SHzsz5y5w4JIQtuJXIW4plmvtR4Idp3i3u97REt11YI5odPimgJ
         79HKOqSXjmy3WpM2yQBZAUfr6Jj0vNTrTVCwXTZpwnhY8DbPtLOEyaJRlE1lGDzyameY
         vDVruC1DtYRR19W81E7XKl9WQUIJt+ASHBigtzwzCoDS0paNIcrpDh5tH5R8OMDwTVIp
         9nWkJbBX8CHjOsDFPN/qiKNqxpeRxW1VBW4coRSYx9jeQjApX3105aLHAf0TE2/h5nxT
         Z+vv4bOnS6cPWNXQF+Kum6TCuILZZvDwq7mYrwdRq3Sq21jST5drHJsxSnYPty4YihPs
         JgWw==
X-Forwarded-Encrypted: i=1; AKwUvByQJ8STZ/5cF/DuF+TbHEYw/X/02tueoFbSx3bKjN+AwVM/qFURpQmZRcSYUN9YKb+bChACThs0kgw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIH3CNA/TBi61BfiSY/70d9KVCuFUQJCldJh5JSSuznCRJgv1kO
	j9rvvS2IH+0i1B0+L8eUwdcqbj0lYXBXvxNuv4vD6to06/veGC0zURhN
X-Gm-Gg: AYBFou1luZXEVt9AuYJj3JdaADLfFFCIL/3euDeySicZJkeeszBG2JeUrTXEnjlcLe+
	7n+wcyddCW8/zfC6o+bDuTzXarozGsFI4hnSrF+U3l5SvulAQ5Xoz7OOmMzMTwv9qR1tTQPbgX4
	/UBvRyZesAYmNkMa/nhlaNmoPYIb24UluW3DAVlY1J1YBcvOqFMdscQ/SThUH3aFeN0emnvtZ4k
	xy1f9+aGzsD1W6K7PXkv1e/9/W2ynySUF88eOFa4yayTfW/0++uQb+QfA+2i1EjCIYZRGo9jlbj
	tppdqT/yXhMbJabeJAgN+Kgk0Elf9F1w/N8e1gIwqB8JML59e0uXgptyHNjg0x/P27zX8JSxKLa
	6bXhy7SJPnKNk2OE/N8t3cFn2UNmlmB93YmUBTFm6ihW1cXH9fxqO93LunU5ulSpYOze2Q3heO8
	oAprANK+51e/bxYhNdr325fqEQHQVoMLv1U1dM9z2Urt8SgOzYOHxsCVszOhxTHKHzghQg1r9D9
	6FNdlG20VXYZ0LL3T3mElz2DQSz7to++ChrAYqItJAqChPt+JnNQvNST2wFZdtuMg27tt+hcwLc
	lGLdyo8nSCFdlNqB0U2Zo1ihhP7/Z465UgfExTp3W10wu9RiX8YWKWbo5A8P6mekZw==
X-Received: by 2002:a05:6512:10ca:b0:5bf:c27b:8e52 with SMTP id 2adb3069b0e04-5bfc27b8f26mr1690144e87.65.1793105409656;
        Tue, 27 Oct 2026 05:50:09 -0700 (PDT)
Received: from yantra.. (nekmmqtcmoboczbkdcs-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:55c8:a52b:6ba2:979c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfb7e7cb24sm2052803e87.25.2026.10.27.05.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 05:50:09 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	David Lechner <dlechner@baylibre.com>,
	Guenter Roeck <groeck@chromium.org>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Jinseob Kim <kimjinseob88@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Remi Buisson <remi.buisson@tdk.com>
Cc: chrome-platform@lists.linux.dev,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v4 7/9] iio: light: opt3001: mark the interrupt handler __context_unsafe
Date: Tue, 27 Oct 2026 14:49:52 +0200
Message-ID: <20261027124954.110697-8-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027124954.110697-1-zoone.rupert@gmail.com>
References: <20261027124954.110697-1-zoone.rupert@gmail.com>
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

opt3001_irq() takes opt->lock only when ok_to_ignore_lock is false, and
releases it under the same test. Context analysis does not follow a
lock taken and released on a condition, so mark the handler
__context_unsafe().

Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
Cc: Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>

 drivers/iio/light/opt3001.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index a948353014ac..cfd4a0ba9bd7 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -817,6 +817,7 @@ static int opt3001_configure(struct opt3001 *opt)
 }
 
 static irqreturn_t opt3001_irq(int irq, void *_iio)
+	__context_unsafe(/* lock only taken when !ok_to_ignore_lock */)
 {
 	struct iio_dev *iio = _iio;
 	struct opt3001 *opt = iio_priv(iio);
-- 
2.43.0

