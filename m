Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CFD3D9035
	for <linux-iio@vger.kernel.org>; Mon,  2 Mar 2026 13:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772456820; cv=none; b=tjouQpLS7ShnhWSJf0U5Go0X5d1uShIKDABj4rN/fgFueHrgaRvg1Dzr2IcFq/OCc0vmljWQXkgu7ESeEyAYaDNHULAZDwHBjcMaX5J8khK/MlXUkuMCiZw8/VyI330r3ermkxXlzACKFwRpgANrLnKcmyUk4bpKKkIOfcdWtVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772456820; c=relaxed/simple;
	bh=tJOlEx2YSqymMwX2fM5CB5Sh2YTeZS67ymrbPi2BBeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZurZ4de08oZ1BVUOR6hC2PLLMK6TxuMVv8vc1Ic7QDbFavpQtopHlMra6r2cDYS9H8CKla9ZdW/7PF+WrfjUssbh3BWCRoI1dhpH3in+G+eSlQQJ3FmirTmOptpP0OoHBhYq5/wpAPTicBTIpHUS9et83CyfFx9wnRNbptAGc5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4B59C0q; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4B59C0q"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3585ec417f6so2035384a91.1
        for <linux-iio@vger.kernel.org>; Mon, 02 Mar 2026 05:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772456818; x=1773061618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mxbGIf2vs06p+QEYROvnEWXbdM+MByCGD3Xnp5U/wY=;
        b=I4B59C0qALDlyzRayvHMU9UWZdlGbhute9f1lmCPz3A3O+vhpZSN63g3eW2d3Z/cyk
         0hnf8gnYTDZnBMREibP5Pa3oAsFIcP4s05TXgGOqH1xj/MaM5VWBXfSSRn+eriZCPTmw
         dtXobRfomntWmEIsNNvYLTHjEo/AMVU296QKDha2jWKTEStUOeIN3yUw3yg/Z2wRdRHe
         91V/vxdQttZGhpLRxhPX+/+ZdSGb6Skb/l7RCu+irlZIZPryPtfld5CX8M0SYL71L/k9
         yzB8o2Xp8b4i1calSGG6lPhLGPeMLuJaaAaZDUzqEpmFzExQUR8wBavvVSiZXDdDAxf0
         6LZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772456818; x=1773061618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2mxbGIf2vs06p+QEYROvnEWXbdM+MByCGD3Xnp5U/wY=;
        b=Zjn5p0c2jh26CbCBlisWrjVcZCoQWE6IDJutElYor0Pf335pOiYyv05ZOX5kmaL8lg
         l+y+2SLtCWLKXszPqNSwO5OTY/KAy+Ci6xxVJdvNLYHNiYrn9dXItlVo4wWwTNjVGEqm
         GD5rRimTugLIGT/Opo9Bpw0oW+44oQhGuvhYExb3xVEB8EbI9zIZvTPYRuckrrtvxdqy
         B4dt3FzwD7pkwpTD2T1dxflkP64f30CYw4RjHaHI4lkX42oI7C3gb3KL23xTf47piWon
         AHo3yv9wOrUt0QAyOCDP7e5N58VlD2ePD1Jx0CXlAv0ZjhQxT71/vG1N/p4dIyXb5mnY
         0EPA==
X-Forwarded-Encrypted: i=1; AJvYcCWu6s7VJphJppc6Pu3UryQw5FCrha6qOs6L66LPkGC8UiqdMqoADYzMchBdKj079lsql+dy8CxGS9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNpUuFohk2xUfgy5naJBH41I/pTofuxOUCemeBJwvAwqcuKr6V
	Gj6CuaFvhr0TmEaDfFWOMcajsYzhM/e2RaQwPgPovaLsVUmvHx+QmMbb
X-Gm-Gg: ATEYQzxZiOUX+AN96L/4zoVPqA2fKosjUOEY08KIZkkcZq5F1j6RB/BonWOXvn5j4GS
	qGGYC3lWKUwh1jbfWTxCNbLSRBFXXvMtjaYgz2csGfrRJAjTRd+5yaKmyUWXzG4/2CTUozjrtIr
	5PcfdgbV5Jwx+LGjkwrtSm/GjY2lq1lSa6p6qZ0QkeEfCqVqektbEdBrP7G1Clu4DxqxmiarfW6
	aHP/nsF4DDsn1eLAiVnGR8QFZWj6w2PD+817NUc/LHipNUruBEZs0LPYDH+zSR6m/0TbIKt7DsW
	UmCVWrjHaGJuiel4OUsFqjbx/L383eNlNQ+OE6zsxm0Njg0rOpn95yoddkQf0obWaPtIHXb8BD4
	yJfOiMAKDFYpSQYTA29QrCdMNnIsG901e07wiJ1wdgIevz3uXpgpWB1jdlji8TzjpbOx+E4Tn9R
	K48AH0Xf5UtB1tJgwjfNBu/FGOJfEvmo0ZuZhm2QGl1Q==
X-Received: by 2002:a17:90a:e704:b0:359:8df1:8553 with SMTP id 98e67ed59e1d1-3598df1884emr2375476a91.9.1772456818404;
        Mon, 02 Mar 2026 05:06:58 -0800 (PST)
Received: from debian.ari ([152.58.176.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3597b448e38sm7444585a91.5.2026.03.02.05.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 05:06:57 -0800 (PST)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v3 2/4] iio: adc: ad799x: cache regulator voltages during probe
Date: Mon,  2 Mar 2026 18:36:30 +0530
Message-Id: <20260302130632.29144-3-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302130632.29144-1-architanant5@gmail.com>
References: <20260302130632.29144-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reading the regulator voltage via regulator_get_voltage() can be a slow
operation. Since the reference voltages for this ADC are not expected to
change at runtime, it is inefficient to query the regulator API every
time userspace reads the IIO_CHAN_INFO_SCALE attribute.

Cache the VCC and VREF voltages in the state structure during probe().
This improves the performance of ad799x_read_raw() and removes the
dependency on the regulator pointers during fast-path reads.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ad799x.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 7775be874081..35e0589428d0 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -135,6 +135,10 @@ struct ad799x_state {
 	u16				config;
 
 	unsigned int			transfer_size;
+
+	int				vcc_uv;
+	int				vref_uv;
+
 	IIO_DECLARE_DMA_BUFFER_WITH_TS(__be16, rx_buf, AD799X_MAX_CHANNELS);
 };
 
@@ -303,9 +307,9 @@ static int ad799x_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		if (st->vref)
-			ret = regulator_get_voltage(st->vref);
+			ret = st->vref_uv;
 		else
-			ret = regulator_get_voltage(st->reg);
+			ret = st->vcc_uv;
 
 		if (ret < 0)
 			return ret;
@@ -809,6 +813,10 @@ static int ad799x_probe(struct i2c_client *client)
 	ret = regulator_enable(st->reg);
 	if (ret)
 		return ret;
+	ret = regulator_get_voltage(st->reg);
+	if (ret < 0)
+		goto error_disable_reg;
+	st->vcc_uv = ret;
 
 	/* check if an external reference is supplied */
 	if (chip_info->has_vref) {
@@ -827,6 +835,11 @@ static int ad799x_probe(struct i2c_client *client)
 			ret = regulator_enable(st->vref);
 			if (ret)
 				goto error_disable_reg;
+
+			ret = regulator_get_voltage(st->vref);
+			if (ret < 0)
+				goto error_disable_vref;
+			st->vref_uv = ret;
 		}
 	}
 
-- 
2.39.5

