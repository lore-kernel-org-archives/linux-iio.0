Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7233E024B
	for <linux-iio@vger.kernel.org>; Sat, 10 Oct 2026 06:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791615239; cv=none; b=EnjWowgzO74zhjhMRlXdxPrEd1XP+yE3+NfHxP8uTmRb3Lvvq7KYS+zRcoseSEKxEI+hGEToYFQrUwWVedtOS3o1m7hRgQt+d9C8AvSdb1jmHPqJ5gF+ktm+C6os+DtAnFFlhQqhqXc+JK+VyEEf5KdamlVGFxCfrFhz2up61t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791615239; c=relaxed/simple;
	bh=KCiU9H7oAsfJb+wOCJGHY+ftuBOqit3svB97TjTz8Ps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bh8fopsVxU1O0J5JiVm4sNjZKUX2+zfIsT2UrFcRRXG3vcGm6hMmqxfbd3fKJbnfRM8uOBuAFurNrvycmZlzIVffXmMvz3KpjYJEtZUdng1wpDo7S94DnSHas6he9QYpmsB8kDBY1El437nilOJZggi/+S+QVsoMPj2FTLH7gUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjYTGa9a; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjYTGa9a"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-14394530ec6so344599c88.1
        for <linux-iio@vger.kernel.org>; Fri, 09 Oct 2026 23:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791615237; x=1792220037; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JbdiTE9cW05Ir8fGL9rCBVCwwyaDuqPvBVhKoWrKJGI=;
        b=cjYTGa9ae2WwjSfLPM3nmEiW8Okrdn2JhaFUWC3E8pr0WU+tSQAV/wJOFQdve0S68W
         Dbz7g7S0LH5INJxbrNsp33XSFkfO06LaaMQcvuCHFSn1Xld12eR/btSQHtOjVVVMAj7s
         A9kZ1pUcdjqmk/PfGGnQV3p524U2sWA97CYvN4Lvh85YNLhKaUBF2vlxXAnhvuSKY0xy
         UPqWE5z/Ml0wjdL1KyuodYKDuaG/PhMVmmbnO821/xtA3kjBt83xvNkvNer437bLOEvr
         oFMmgaEOHFkYgNTx4y/FOubxyy3KyTvL7Hf2pZotjwn5HwJMiefysPj6pC5iPFb/WaCG
         +DyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791615237; x=1792220037;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JbdiTE9cW05Ir8fGL9rCBVCwwyaDuqPvBVhKoWrKJGI=;
        b=biK7b9Uwn00BIbnXsjflmA05Lxrt6jEG0hbpkXO/IgLNf1laQLmrmtaxgPtbRQ72TU
         +anmeKWF+Wk+SptSMQ0OyUWp3Idk6h1zQqPJRwXraomyiAVWko0JayagRGFBDK64KrS2
         K3gBzCusZFlYPA0NvuzaK7xO7F3VSpQUxEVp8V3+MGbW9TxRZU+1fhFAXH9LJCe6GPa5
         bHhaW7hlqkM2LDqJ0R7oAwP2z7qT0UcON9WD2dkbmNfwSmmY/6CVx9leqIUj+BRbFi7T
         D2+t0XoLvRg9X1kEABKZr0hUIboB9Jf/Z6F4yS8G1H4laLGZXdV/F+a9X/jajP1DG0lL
         SKNA==
X-Forwarded-Encrypted: i=1; AKwUvBx/k+f2Jca2zq13c9gxBG77XefeSSVE3kOba79+bc64paWnaRRcPigIcFcLS2goN+T3uOysdcPvDa8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLuKQHIj+CCp7PDG2wJ/S/rEpCSqU0HJQrM6fstsPt0YpHpuY3P
	/lEkhwiYuEl2aBKQKGL8mfLHmBKqfoJJHa508VzACIuzqsCX6sC8asrh
X-Gm-Gg: AYBFou021/a414XNASznhpaEwoIy8D/XGBJmxt1h00N94b/jluAjerBdQi4Zv40G4n1
	apeE2IBkZUi+b7Y1JsYK/j55bxfFbYo92wQcSoYhM01YKTuL6pNNy3QHe7p/kHGJ2+z1b9ezYQ2
	qcliva3aV5BaOFZqtg1fSSqLMPYdGHMF0kysX74yXnlMXJftMfts8vBvDQUaS4tNJrcwD+detVc
	JaU9Jod6Uz/CsHL3TgErg9cpyj5PR3kLGNtn8YZ57lBX1uENuu38gNi32sFFz/5eL2ylr/dB9vj
	2OcsJm+d1yWSl2JTVnC9Wr4ykdy3sQ3pmXTLx8BK+LpH7GQ2SqT9+VTotc4TfW2J9p9dBcvgmcF
	l8aK78UqqqEX9csIZ9DbHLK5u5TUuK8ncP1Em3e17dZ4QrQufkgeR03TUBzcXhGUetav+wtbgIf
	HO6CkfDf/230Czu73VeZaxmtzSI+Q0Bf7NfYkS8JzMh1c2Oln6+iiNPmFAJ4fgrU5UrKMo0ALn6
	X5CvtCb7Xq4MY5SmfdZQpl9HQoWMALT59lFIRk=
X-Received: by 2002:a05:701b:2906:b0:168:6ad8:e89e with SMTP id a92af1059eb24-16a63d21e08mr4178604c88.45.1791615236985;
        Fri, 09 Oct 2026 23:53:56 -0700 (PDT)
Received: from [192.168.100.70] (host-200-61-172-117.iplanisp.com.ar. [200.61.172.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cacb5e9sm13009650eec.20.2026.10.09.23.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 23:53:56 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sat, 10 Oct 2026 03:52:49 -0300
Subject: [PATCH v5 10/10] iio: adc: ti-ads1262: support common mode
 supplies
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-ads126x-v5-10-49e331cb2fed@gmail.com>
References: <20261010-ads126x-v5-0-49e331cb2fed@gmail.com>
In-Reply-To: <20261010-ads126x-v5-0-49e331cb2fed@gmail.com>
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2778; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=KCiU9H7oAsfJb+wOCJGHY+ftuBOqit3svB97TjTz8Ps=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDFknHzz77dK1n8X0pfahdSv6X2ZNUDC6qdJmevSzkITFY
 ueT6qprO0pZGMS4GGTFFFnaExZ9exSV99bvQOh9mDmsTCBDGLg4BWAiR0MYGVp+bharN+WTX/4s
 ojv93Ikti4vNp65V7q5kXlO4bavwg52MDL/yas4FZNqtWfwz4gu/jaHVATvLto7X04+62vjoHKl
 7zQoA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Enable common mode regulators. The usual configuration is to have our
own 'vbias' regulator connected internally as common mode voltage on the
AINCOM pin.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/adc/ti-ads1262.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c
index 5bb41b70353f..66a7fedfefde 100644
--- a/drivers/iio/adc/ti-ads1262.c
+++ b/drivers/iio/adc/ti-ads1262.c
@@ -241,6 +241,7 @@ struct ads1262 {
 	u32 rref_ohms[ADS1262_EXT_REF_COUNT][ADS1262_EXT_REF_COUNT];
 	int refp_uV[ADS1262_EXT_REF_COUNT];
 	int refn_uV[ADS1262_EXT_REF_COUNT];
+	int common_mode_uV[ADS1262_INPMUX_AINCOM + 1];
 	IIO_DECLARE_BUFFER_WITH_TS(__be32, scan_buffer,
 				   ADS1262_FW_CHANNEL_COUNT +
 				   ADS1262_MON_CHANNEL_COUNT);
@@ -690,6 +691,13 @@ static int ads1262_read_raw(struct iio_dev *indio_dev,
 						      scale * ADS1262_TEMP_SLOPE_uV_C);
 			iio_val_s64_decompose(offset, val, val2);
 
+			return IIO_VAL_INT_64;
+
+		case IIO_VOLTAGE:
+			offset = mul_u64_u64_div_u64(st->common_mode_uV[chan->channel2],
+						     NANO, scale);
+			iio_val_s64_decompose(offset, val, val2);
+
 			return IIO_VAL_INT_64;
 		default:
 			return -EOPNOTSUPP;
@@ -1123,6 +1131,28 @@ static irqreturn_t ads1262_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int ads1262_parse_common_mode_supplies(struct ads1262 *st)
+{
+	struct device *dev = &st->spi->dev;
+	char name[sizeof("aincom")];
+	int ret;
+
+	for (unsigned int i = 0; i <= ADS1262_INPMUX_AINCOM; i++) {
+		if (i < ADS1262_INPMUX_AINCOM)
+			scnprintf(name, sizeof(name), "ain%u", i);
+		else
+			scnprintf(name, sizeof(name), "aincom");
+
+		ret = devm_regulator_get_enable_read_voltage(dev, name);
+		if (ret < 0 && ret != -ENODEV)
+			return dev_err_probe(dev, ret,
+					     "failed to get common mode supply: %s\n", name);
+		st->common_mode_uV[i] = ret != -ENODEV ? ret : 0;
+	}
+
+	return 0;
+}
+
 static int ads1262_vbias_enable(struct regulator_dev *rdev)
 {
 	struct ads1262 *st = rdev_get_drvdata(rdev);
@@ -1876,6 +1906,9 @@ static int ads1262_parse_channels(struct iio_dev *indio_dev)
 		spec->info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 						     BIT(IIO_CHAN_INFO_SCALE);
 
+		if (!chan->is_resistance && !spec->differential)
+			spec->info_mask_separate |= BIT(IIO_CHAN_INFO_OFFSET);
+
 		i++;
 	}
 
@@ -2027,6 +2060,10 @@ static int ads1262_spi_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	ret = ads1262_parse_common_mode_supplies(st);
+	if (ret)
+		return ret;
+
 	ret = ads1262_populate_tables(indio_dev);
 	if (ret)
 		return ret;

-- 
2.55.0

