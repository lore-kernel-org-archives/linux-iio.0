Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778373;
	b=TFbkTIhN46km4gbIja9RcgWP35ktZbcLT96KuhZADNY0OwEPnmlIgBXsYEseB5+Bfq93
	 hKKR+WPtn5c23bSFu5U6kGCgTQa6GzSgEik2lljiS+Pknj28z881gYxih1Os112KdWKeR
	 htLjeFNWp4zINstzJyTPTpHxmgMh/V8xy5hUP4rkobpEjiWdaLxwOiy20ZOIzVzgmhfcm
	 KMAz+KhiytRyeIE9yzSk0Vf6lW9ViycfoFCzkGEuzTOaW0Bh0eY9IXfisijf3IoHCIiD5
	 Gi4H0sl9vTbreYGkdC7c+TR0eiNXisTJ/1MRbpFa2NFsRfXWgKhRrDG6OFsnwShDBXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778373;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3LNah5Hnc+oQiOU9iUKOLyS8ViKTo8ncRQPeNAx1Os4=;
	b=l4MbWrwFrIN2ScglPEdHbXIUokF1yqQw/DNUtwJ2NvOuGOm8o8VL+9ZsU3oUNsXWE2cF
	 gp3+9cl6ML6LV687i3S4MzFRJENMwm58+hoU9J8IOQ/NrMf7pSIlLsS9vLnQbi6p413tJ
	 wJoc5/oKstxY4K3lLTKJFjpQxKY+SOEcI9NjX2OvjO8c8KU5+eB8ZY1F06LblWsadQMy4
	 BI7+4q5SiikYL++myj1iYd5VmD3Wz5lZyiYYzvYGIu3Hv5kLSgf5ZDSBpd9XvgrAOqnX0
	 J3E7cevlksFqH7AwkoLEYBZyqy3hpRap0zmwZhhtbRKnLhYlnoGV/C6N0DVZRLtXYIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OEbZgL1k;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B395060A2627
	for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 17:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B395060A2627
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OEbZgL1k
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48e20edd106so987625f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 10:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792778371; x=1793383171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3LNah5Hnc+oQiOU9iUKOLyS8ViKTo8ncRQPeNAx1Os4=;
        b=OEbZgL1kulvSCIS4M18Jozd+OJn2wgmMdz558trPyD8wLQqmEhq4RCR9o0T1MX89nD
         HMYKXZ5hetATa12c11uKpQGbcYiyf4uupXTyEARTd9JRXS20WpY55CrrHDU+BnDZTPM9
         fGn2jZVVmV8nzcdTby2mitvPxU4QT8Ff5wK581l0nw4EiwrnEmuO766l3cItnCnEjybp
         h6akcUcHoLxgmhx+aWpaj8X36ireJPrN5YS9Eb1DdlrIAEecZMRPiauctTzqnVbTvMXy
         KBk/0sNqn3rJBxGMztCDm/kxKzMJSGinAxjMUAG4S87Dmbbuo6kZhrc/ukc/l6YH9VQF
         mWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792778371; x=1793383171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3LNah5Hnc+oQiOU9iUKOLyS8ViKTo8ncRQPeNAx1Os4=;
        b=rHXl+hnby9DKa2Nndyd1snDgvL+267NlRjdLtOBY/hpF0P9euD8aO+vT3oAMwmbUZS
         tBlhzgTgChnZK8ibswkb3LxAnt1au41XdOKHozzpw96TtUfRIAlc8tt/q08vNE1HibHV
         a5lwIyuncHtIXjcfVbWHwl9mvv6owvWrYlvKNOVlGqhn0NzA50Uo6PLU9jGvehvijllB
         18AfsaxqFAYgDr5jyRucP1GToWaCXpPqn22CiEgOaQnmITUOowTGsgWJSQU5JunOzNDS
         xnoqJ8scsmlhwJYZxyPLN5WF0v0dOVywBMVECLQQIWIjYalxN+DWGv6lgU1aoZbE3kRm
         Y2FQ==
X-Gm-Message-State: AFq9FYKlY0k1MF+IQxiySTxco/q39h4f/ECKLDXRyFtD3xhtiYaqlBbG
	PmoUPtpMTs039j2koQW4LYHscnE19IvhpU+F6MpiLNrcSZAk+jokEkBV
X-Gm-Gg: AYBFou3VpQc4yQIpkp2LCF5jvnWXBlXy6kJzkoUHnpTogaSb5WEQwEG5WkHMJ+4ZL6k
	M3z1cb2VYdzYDxvJlA3aPc8kNtclZZ9kLnOx7Go3Z8UQ7Lr1mDa5Uc3v245qs/l5I7giE0PpWDL
	H7fr6yyR9fkm0at1Fhh132IuuVHbN8Ko3kJxLVDnUq4dHRu4k+ECvaHcFYAPxjRP5xBKSG7k0aA
	YdUukuS5CTKymrmOIvYmTQekvKZ0h/ETbUKNPzbOFFDrG5rtMuRQw0AQhgMLgKAe4POntwvb7T/
	Dns5Q/pcVU4bwe7vqGOTllt/Rn7vg/bkrkJxgK+7EHpVrmZmNNDbkYR/QPXOS2IpVpHRuAs1jS/
	HKdeYOg8sEFyW0kUs+yoMZqGRHBIqjxxk3eEwbbILuUTrTHMFtl2jwUJlnCPO/Ga8QBJISVN+R2
	U1G5ZGcZ6LPXh9RHFwhXtgx1iYpd3M/xmjSUI0L+fiHG6UZ3Sd9T1DsaN4jSQWnbUQyyNbrcacr
	jI4aLwr70lgYHIIRlY0PS+d1pCLtRy7h4f1yDvaABVpgKWFI+TFqy382BRcAoWEdoPtkt7l0kbI
	5AJVYBHVHSDZEpY+tu3SRhVdKYkTOk55Lj55+ZVl9d3YY6AkG4QBhvMlGKcxCnotzAt+1+PnqJc
	9NVA/VrxATgLHK7lcoUSG6p6LHdXHCj7wNqNtHPF4AbjPMw==
X-Received: by 2002:a05:6000:41c8:b0:48d:ff71:dd9d with SMTP id ffacd0b85a97d-48e3859451amr5267524f8f.23.1792778370853;
        Fri, 23 Oct 2026 10:59:30 -0700 (PDT)
Received: from iku.example.org (host86-133-9-17.range86-133.btcentralplus.com. [86.133.9.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d37ca2asm1342800f8f.8.2026.10.23.10.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 10:59:30 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 6/8] iio: adc: rzt2h: Prepare for SoCs with different ADC info
Date: Fri, 23 Oct 2026 18:59:17 +0100
Message-ID: <20261023175919.160103-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023175919.160103-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261023175919.160103-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Prepare the driver for RZ/V2H(P) support, where the ADC supports 8-bit and
12-bit conversion modes with channel configurations that differ from
RZ/T2H.

Allow each SoC to provide its own IIO info structure and use the
chip-specific configuration when registering the IIO device.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2->v3:
- No change

v1->v2:
- No change
---
 drivers/iio/adc/rzt2h_adc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
index 94dad479abff..dbe82939acc2 100644
--- a/drivers/iio/adc/rzt2h_adc.c
+++ b/drivers/iio/adc/rzt2h_adc.c
@@ -68,6 +68,7 @@ struct rzt2h_adc;
 struct rzt2h_adc_chip_info {
 	const struct iio_chan_spec *chan_template;
 	int (*sst_to_freq)(struct rzt2h_adc *adc, u8 sst);
+	const struct iio_info *info;
 	unsigned int num_channels;
 	u8 features;
 };
@@ -763,7 +764,7 @@ static int rzt2h_adc_probe(struct platform_device *pdev)
 		return ret;
 
 	indio_dev->name = "rzt2h-adc";
-	indio_dev->info = &rzt2h_adc_iio_info;
+	indio_dev->info = chip_info->info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = adc->channels;
 	indio_dev->num_channels = adc->num_channels;
@@ -778,6 +779,7 @@ static int rzt2h_adc_probe(struct platform_device *pdev)
 static const struct rzt2h_adc_chip_info rzt2h_adc_info = {
 	.chan_template = &rzt2h_adc_chan_template,
 	.sst_to_freq = rzt2h_adc_sst_to_freq,
+	.info = &rzt2h_adc_iio_info,
 	.num_channels = 16,
 	.features = RZT2H_ADC_FEATURE_CALIBRATION | RZT2H_ADC_FEATURE_SAMPLE_STATE,
 };
-- 
2.55.0

