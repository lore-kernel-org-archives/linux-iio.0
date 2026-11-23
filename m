Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795463389;
	b=zCS7wCnhj+uuW0XA6T3RSUOF/mbxVX+hZx0J2CamVv39TM96eXNcNtZw2TOAVqcQbGvc
	 pilFG8cyhfiwjrWygXG7OiYdG8Yenq7P6Lz7NS6N8nJEEuLGShzT/eBPLnnkTAt3ha1OR
	 7FAOwSvIs2TBGtfz9hjlhxb66hZuAdR3tTW6KqPMQqfK3k8gQQPLTmCB6qYF7RgeO7H/D
	 XpWm5SE0fcbScuomvuF9FIzYfhMqU6+qCf2ytf08G/ZAsnTv/4Ee61xMuLhLZ32nBBep9
	 ZxQUqDFVHMBuUr7jBV2iiypy7ecHDCagIkG0DEBMNiJAxlD90Z5tsPJbVsinSZhG2+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795463389;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RqmWJ7RMrhg2L/ifDvxPzp+3Jv7BCZkcuD44+ncjgs0=;
	b=dXvnSmIV3Vis2HpnS+2fAhrTwJb0HkDwkE15/qByFHq4vBJA4NFWGhGYkE+THnTcYt9k
	 hU2Krw44dLS6OuGhyfz0MA9hsdkBQhb5qoCu4ZK2eCdMEUAgjJa/IsjL852D+OKCA2u6h
	 8YZZmpf4Jp9otUFQctPCy20gYEdS0PxTZJcvmKescIKCnMzDCO7poBiGLR8gHjTETWrhy
	 l4izsf4LHzBfKMwBiIPSyl97SYNU2eJ6tW7dDmApjmJ4arWVSbP417Z6hQghP/aMLBf8A
	 3RufyJvVrClSvHNQbVIqWF5iOzMtxSeXxMmUqulZhs3GErcW/S0tas0f+dkEyDBtZVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=teslabs.com;
	spf=fail smtp.mailfrom=teslabs.com;
	dkim=pass header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Fs748zbE;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F50606A686
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 19:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6F50606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=teslabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=teslabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Fs748zbE
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb6c7b6dbdso34569795e9.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 11:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teslabs-com.20260707.gappssmtp.com; s=20260707; t=1795463387; x=1796068187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RqmWJ7RMrhg2L/ifDvxPzp+3Jv7BCZkcuD44+ncjgs0=;
        b=Fs748zbET1THbOfoMjkEdSA5V7vC/RvF8EUIZhgsRjporPgwNnL/aD1TxSXU1pPmx/
         yH7vZ0bgisW6qAkhp4Qu13rjKYcbVRFLr+YTZJe7PQ1Ly2oJ27XiO0wAhs697KIfsox0
         SQzndo3SGVN4T3/oqz4S67pIusuUMQWtAXUmcZwNA8wI4fSQyI4QRM6OYwEy+zpe7ABp
         ZKhKVT3uWAac6O7dVE3iDndYOfdYO0wkIP0az311xwhokidN19OFvV8uogeiGyJLtqXo
         2CyZlzvxaoBYkmgZZ0Z4Wo5/RGuerL4PFAWpjor38w+zIM1v1wjKx/gJ970AcNHEIvsJ
         h/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795463387; x=1796068187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RqmWJ7RMrhg2L/ifDvxPzp+3Jv7BCZkcuD44+ncjgs0=;
        b=UIiOBk1g2lrz+C+r/RulQVZf0Dl7CoJSg2AkFnmuKT1rMQW68L6hL1PGZCADlNL9j+
         OyRCWwJ6zV11NJn5rlOmUTf6UBKBqqtWpmj/61f80cVx/wgtSFMu8dmdGLRbgAX17lP8
         bJXt3LHm7pIbfLbh/bamZLScxShwRgMUvFN+gZWwDwx8zs+/iTaEzF6GFMnm/fs8jMoi
         AqKExv/9hOlkJzygRDeNU8tHjAHVYNSBCDjyae12xU77xvtditUDx0c0lIcNF2MQ1Qyf
         2aLfc/4lZqPMWe4wZDK3a6kswSeBDM6OpULMfZJDSGtTml+1nK1mMMldz8LafqnithQX
         u3qg==
X-Forwarded-Encrypted: i=1; AL+hErGxMOw0neGR/mAy6U6wp+yxX3kr3XCHrsNSEorkiAUBrLoF9oauWbpJHz4KxWpof0B0rlk4Dv4/gLM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9uNYjXxl48Ng2hdRw8Q8K8MigOnhVh+OWCG5DtoQEyaCzWRTXI
	DdT1EvpSWhCDB3QeKUt9pxAuRKJe8hjMign0ZRojfWEyyTOxy4eBRmumbPjIdkifIZU=
X-Gm-Gg: AZFdTZdxEBclpKkFFwT/gUx8Wk5S967pVYkIsQI5vtiKaS6R1VmN8SxBEedgat90J8H
	yV1zrjuyQl3hORBKcBf4CwTWiQdzdN5O6/rGoiLPfI79orl14k3UA3ocWrW3tHw9PpJXBEXdBq2
	he20PsJLrEBDIwvUSYhvUyOuVG8BZPVnEmzN2y/utMT3vN+eu5QYMEYt1KHe7yS74Thu8JWXkuO
	0Mvh4ykd9qUelriNEwRU4WIXDGbsEXlYyKrSV/d+UAzC8DbvRbiMYuKatOps0OUd8C7fb0JEL4D
	wRQSjkTO71VmWfjvtk0x1uGa9J1xrKckdeyuot72VVMykT/QE2JPe9aXfXatxZxbWnsQyhjZCaE
	lCKTaT3gni9DQ3MfG58ejgM0mOz6KuXKJ4jZEa2b9ExtPDY1I2pnwSGxwruncXyjJSnEqplUBTE
	PYBl0gRb5LSv1bvBsu4GuaN0ZfSR8JxkrF/nIvBxUMEgsxuR9qHDiVtpsDo0x3OXbvy8noUFYB1
	coSsOM1XVgXY+DnmO6ic4RJ3rFMQmtfJFzWUp64YB0N+K1tJwulVW1pG0rM9ZCfi1gcOnHLmjOb
	tV5NPID/yc0K4Tyhw/Z98jJAUuHo2bf/aNMdu7a0O7zpk4mZWMWZ/DoWFeqF5G7uZKv5Cy+EE4b
	89NugjvdRAMo=
X-Received: by 2002:a05:600c:8210:b0:4bb:6a2d:b438 with SMTP id 5b1f17b1804b1-4bb88786c81mr256282695e9.0.1795463387295;
        Mon, 23 Nov 2026 11:49:47 -0800 (PST)
Received: from localhost.localdomain ([139.47.121.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm300924125e9.2.2026.11.23.11.49.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 11:49:47 -0800 (PST)
From: Gerard Marull-Paretas <gerard@teslabs.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Frank Li <Frank.li@nxp.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] iio: magnetometer: mmc5633: Reference the datasheet for the SET/RESET wait
Date: Mon, 23 Nov 2026 20:49:41 +0100
Message-ID: <20261123194943.57601-3-gerard@teslabs.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261123194943.57601-1-gerard@teslabs.com>
References: <20261123194943.57601-1-gerard@teslabs.com>
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

Name the datasheet parameter the 1 ms wait after a SET or RESET comes
from, tSR in the Operating Timing Diagram table.

Signed-off-by: Gerard Marull-Paretas <gerard@teslabs.com>
---
 drivers/iio/magnetometer/mmc5633.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/magnetometer/mmc5633.c b/drivers/iio/magnetometer/mmc5633.c
index b651f01e1b5d..5871007eeba6 100644
--- a/drivers/iio/magnetometer/mmc5633.c
+++ b/drivers/iio/magnetometer/mmc5633.c
@@ -63,6 +63,7 @@
 
 #define MMC5633_CTRL1_BW_MASK		GENMASK(1, 0)
 
+/* tSR: minimum time between SET or RESET and other operations */
 #define MMC5633_WAIT_SET_RESET_US	(1 * USEC_PER_MSEC)
 
 #define MMC5633_HDR_CTRL0_MEAS_M	0x01
-- 
2.45.2

