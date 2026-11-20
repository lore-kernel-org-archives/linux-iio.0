Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795158712;
	b=w5R9x5F9tCarlFgHZjMGfnkoDOyKa6Ov2KkMPPzQEq4A+V9RwJ5EXydJ20vU+bLjJSKi
	 aqnRIl+J4G5XhHCOdRpCQ9DZHJIVLybYJCY3RbUecJVZ3FXHHsaI35AUfrflkMrG6gB6D
	 47y1SGM9IppQtButiq0OJsgoKJ4k+Ys4CmCzyLz5u2Luta/U3wkf18pVSX3ggDu2ugYi1
	 U1nRDCZEJvZS7+WzGVxwRpaWYWpNslQShGHfavio7AD5yeogeRNkoUuwHI2vpKtJowG+t
	 KyXQ3forc2NTqLyqPvGkWmKj8pN0kFKsEUFCkBNhMKCkv5D+s2/vdiffLHVjeFpSnwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795158712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=JJGQ4D2eo3fFSEzpn5XnRuAQyOqk1PzNC7ilU8TUars=;
	b=O20M3elCCBZ8bdWE4Z1aozfmCH+QP1ia4cRia8vP26JzvJe/z/VWt7sRcql1yNWaqmSY
	 DxvJ2IL9F+ZESbDn/lNDPih6MQZdEZXNnKlYoAhd6HhJd4Flk2lPNYErCnVANRiadU65A
	 xIY9wkVEXkvJs58iJhbwU1qjF8DR6RLgLWP9QqWCQXS+QzmMkr6z5DidAF/i/jve7vofX
	 We1M8AWXBijFcljgnIT8qg1WF51E2LWUVPG5VHC0E83xq095Mxt5PDkSacuk4ZzFCtqq0
	 SJiJRpM1cQhCqFaRxu8oMhfmqiVs4LDzrUbTVMlvvwnswdwcmeT77ojE2NGXqoI0X1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CRD5U3PH;
	arc=none smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B483606A334
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 07:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B483606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CRD5U3PH
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5ee3e658c72so317896e0c.1
        for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 23:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795158710; x=1795763510; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JJGQ4D2eo3fFSEzpn5XnRuAQyOqk1PzNC7ilU8TUars=;
        b=CRD5U3PH8L/ASkXv99LVbNcIFeonjJBb/SFpnCHws3oK7k3aKAV9mj+aXgN1k+1Qpx
         dCV6PwdCrjpN5x9inn4/vWradJYQw86tmQWvEbSY6ceptZZMuUbLHq7jiy0951MLXfHx
         8FsfRnQzbDzWcDWuowy4y52VOrQXuD1VYx6j9HLAbzOX6uoF1ZzBpi2xJZ7x3wkbuGKA
         p4edVbAATnYdPaevTZRFekchz0yxfCPRzcxVA96oKgvJHddOmB7z0kktovCCdLArKoPS
         46KGsqH5oASRGFDnt064hpcFUarcGl3YnlmbxGMUKvcpQPP48xm1xhEdmFgLVW7GaIUt
         TnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795158710; x=1795763510;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JJGQ4D2eo3fFSEzpn5XnRuAQyOqk1PzNC7ilU8TUars=;
        b=VZSg47nmxLhmRpKKpGvr/uOgdaVeWL8qaFmXtqbn56JRILhbIhYMDrD1ByhYSeTQ5+
         /TmBCv2uMNKP2lH1GLOs7urJ5jPaL9ckTEht4kZI5Pc0hBAkNVvmxU4cd9JRTRNmMcDB
         +/I4BCnfuaR40v2vjHi2QfYjgWAv5ESBrtElz4MYuwT8iJl4kgl937ds2KfCruh2IXGe
         NdKeZv3j7EqWVd+lx4wPn6dAqm2WAZnAxIRS2LCaDNOQQi0HTedAXTwrJKr40fzpeDAl
         xCe2JM4Wt9PbzuOrB1syNhNMOKmFlkmqvIuKaWJX6aODgNLbU5RKNM/523dsHKN/Ub8d
         7hNw==
X-Gm-Message-State: APuU4Z8SthppAi6Pfs+0m+ZDfQ4MyG/lPOoWY1M1U3SSxPkA+0Kb9Lak
	fWcyPxkqN7pKSsTUVkH/XQwKSjVIs/BnvZEdKg/t8s5dgxPd9AUNX2rx
X-Gm-Gg: AZFdTZfIG6OTK1QhbS6+8V9pdJaLWkGkhl0Y9/P6FGSEoIdE3iqP1WyfTLaRxZeqhJH
	v1eexz3ApPtkLaap2fvRZCBNFzB6EssJykYuwd4tzXPEp/hbWgxGsQ/bL7kIUIAj3mil9WvtJ9p
	HWRjn56U7sbtVBK3gUV23HYMzcFdJ/lt7jKZ9WohER1vmVBYOyaKvCOMsy6/j+8Esy5Ssd2LXQP
	XqtjywPd+45ClJ/amFP4Tqkoil/1cXsQIL8q5LHnBbqLUZ0KfPei3Ljx0u+hroTfQ6gswbqWUTQ
	VUGnE2vPXQ+uF8W63XanUIVI/TeiJkWCFpzGZtP3il0X6pOug8Eks2iZlhppstWqm8b9vXwAOTy
	smLfMbHjq//WlX9xw32HOaIQH7zsWAdtEUOT7ConvUKUXc/VIIeF9rOZHIj/piJeKtTEvG71JmF
	8gI1SdRtVMpN20IkDGWwkyGb/qYNT+/bHJ/gMmq4YrxGnFnBs9fCYHtrpAB9TGVMrJeFpjrY7iJ
	74d/xRsDBkv5Sqj0LptqCZK0PPi51SioOimzbVfsORg9tkdMggMqylom9CjJiQyCJlEBQNYU3Gx
	THnMNsD8Lnsds0ctGI9tPK30j7dmVeY3doDjnGM=
X-Received: by 2002:a05:6122:1823:b0:5ec:3e18:a8fa with SMTP id 71dfb90a1353d-5ee8af737e8mr1223751e0c.20.1795158710550;
        Thu, 19 Nov 2026 23:11:50 -0800 (PST)
Received: from [192.168.0.9] ([2a09:bac5:565c:aa::11:204])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b653081sm1773611e0c.16.2026.11.19.23.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:11:49 -0800 (PST)
From: =?utf-8?q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>
Date: Fri, 20 Nov 2026 01:11:39 -0600
Subject: [PATCH 3/3] iio: pressure: abp060mg: Use msleep() instead of
 msleep_interruptible()
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261120-b4-abp060mg-fixes-v1-3-2baf026cde47@gmail.com>
References: <20261120-b4-abp060mg-fixes-v1-0-2baf026cde47@gmail.com>
In-Reply-To: <20261120-b4-abp060mg-fixes-v1-0-2baf026cde47@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Marcin Malagowski <mrc@bourne.st>
Cc: linux-iio@vger.kernel.org, 
 =?utf-8?q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795158700; l=1082;
 i=aleszlucero@gmail.com; s=20261104; h=from:subject:message-id;
 bh=yde38aPvChaSDKVX8eNqBzVIbo3uuJJnZnhNFZP+CU4=;
 b=HeXe3JdvEeZZ3MHxzPNt90GwvsT/8qMXOVhWZXHtL4ll4TzPielwPBKZdEZhRVCnqBXO83O14
 w/WbPK6iIUkDzE4itk+BGbkNcSj4MPQ0kR1WhV5fNwgB4HU98uDqJXW
X-Developer-Key: i=aleszlucero@gmail.com; a=ed25519;
 pk=zRzEBMID7l1FXqr2CjfnlIn++3m3N05FuNYb5zPA3cw=

The return value of msleep_interruptible() is ignored. If a signal
arrives while waiting for the sensor conversion, the thread wakes up
early and reads the sensor before the 40 ms response time has elapsed,
resulting in stale data or an -EIO error.

Use msleep() to ensure the full conversion delay is respected.

Fixes: 9ecca12edde4 ("iio: pressure: Add driver for Honeywell ABP family")
Signed-off-by: Oscar Alejandro Sánchez Lucero <aleszlucero@gmail.com>
---
 drivers/iio/pressure/abp060mg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/abp060mg.c b/drivers/iio/pressure/abp060mg.c
index 895deaf24427..a525dd21986b 100644
--- a/drivers/iio/pressure/abp060mg.c
+++ b/drivers/iio/pressure/abp060mg.c
@@ -111,7 +111,7 @@ static int abp060mg_get_measurement(struct abp_state *state, int *val)
 	if (ret != state->mreq_len)
 		return -EIO;
 
-	msleep_interruptible(ABP060MG_RESP_TIME_MS);
+	msleep(ABP060MG_RESP_TIME_MS);
 
 	ret = i2c_master_recv(client, (u8 *)&buf, sizeof(buf));
 	if (ret < 0)

-- 
2.56.1

