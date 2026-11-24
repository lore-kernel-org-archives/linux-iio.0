Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795503022;
	b=YpbQ997/vbWj6vcGsxC9DTUwzdA9tIHxJEjpI0EwzEBARjinBylx0LI2odyyygils4F2
	 Nalrqsrofo2pjD01dnsB/tTS8YaSm91UtLrgcDgcZprSyu6+108RUypj/h0fa/sf8oVeH
	 LUc4NZuXlzDuvDBu1cl0sAZJ4UbgsbFlHSxNMFVdNRQ0uev9xY2sjw0u2+LnBrFUjgIwV
	 DwBnp31alrlhN4Bu6bsWqcZUVssdX37A8pKTFEgHVZ3Prr6/UVDOLTMi8bMB9rEud+TNQ
	 AwhnUEZGCLNF3bWpcu0BvpaIt96Y965smGpFx1MUeKZfD9c3eJtkD0UyNoFKb9n6hiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795503022;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HENiTwapNaU7NbNMtbDzb4zDBCZlFqydguAonmAa+ZY=;
	b=aSeq59xz5ekybmEIlBY4R+1iAgRKyrGlW2hv72IwVw2IJpwztwbbKgAnN/UPF+3kZ76y
	 AB6h64XoYBMadHtIaMuC+eMsksathP+fEfOBeMAoJuuvgCLhbAcBu5uvDii4LHGBlQ9PH
	 bH2NVAlaB/5Oq4ohiI2Kl4r0Exl5kG6Kz4F6ks/OCo1Kpyr3pfW+9a0jy+9XqAD9LJeYi
	 jCfbfaJF+3IunqnBTWdJh9Bt62ClDK1AwAYcgklkHTW300K1WEDP27pRo1bDt69vFO/Hi
	 ym7pteIT8PVKUf2bdDxoAg+SNoL0/0ZXFpzO2Ie41I0YQjNcMFYWVUpfDD2Ri9vaK6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mS2nLBcx;
	arc=none smtp.remote-ip=209.85.167.46
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9581606A321
	for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 06:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9581606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mS2nLBcx
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5c26207ee6eso1726786e87.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 22:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795503020; x=1796107820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HENiTwapNaU7NbNMtbDzb4zDBCZlFqydguAonmAa+ZY=;
        b=mS2nLBcx/X6705BUxPUz2G/dvtJ9frwUyGwvOP11xr+LVW4J+T7aWZ1xX+Pfptulcr
         1EKi9h4uWpkmN+uC4v4kb37U2636Ru8/6yWwp2i8XkBdj19eRqnr9LkdTypC44YA/wKl
         z1YNL3NVGanJFWCE+1WrMSgeAG9NDgaUOV47tfB4HmFVXLGr4aaSc7JZ1h9VA7Qd1dyV
         9cQ/KvhUYY2bwjy4YL+qDp+5wXsxbBwtHpEKXoU88/WuV9cV0R742bLnPugIj5NEdyt8
         W3qTLMY8/sGc1Re26/W8oVd7eR6oeYnQ8QbZom9PPaul5zNdlyDzBs9Sd7O+/Yr8axIa
         Oydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795503020; x=1796107820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HENiTwapNaU7NbNMtbDzb4zDBCZlFqydguAonmAa+ZY=;
        b=UQdVzFZJ0Iuzq2PsINl8/svyDeeyh6z/x+Ypxy5d85Y1Ful4GlCDUoss+hFWYmLWwy
         YOe34eDSArVGfo5D/lAY7tkQrKZC+4I8Rc1ErzQNi74bhrx//dInhcDSCfucvPHgKRDJ
         zrPuyN2FgwRZHdTGIPihDYz6BK6xA6cAvBlQ2a66VWSWahxHqo2YxJn98N2n2wCGWnar
         abrL7W3xFDAD7KoRlOpgK01V1eNuLQJgtrXGuu8BEUbOVnThJl5IYNMZ3KGfge3A9tgy
         HLeFNB/ry7crdSf/ODqmpeskryhyeFEXLF6xqgDr59mU5cUS9CUN/STHtHNZraFU390m
         qbMA==
X-Forwarded-Encrypted: i=1; AL+hErEb/RMxxnJ/4k+e3G/uDkkIc4dNWl5e0xHOg+bm8gzBaZS2RLWXMfg9gWmJGvciR+V+88Xdvmu8Pbk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8IbWFrDkr4O8pBLoRzBzSnpz+/WcHnwyY7TTGJFrVbJGXZx2Qh
	J3NH1g2GX9jOfo8qGOPR5q/eBglQcsGRmT2yqvYEjBvTF4R7iTzkW+Gz
X-Gm-Gg: AZFdTZdXTRiqTX5h7JDSsCVlBMFU5lH22tx2U1y8qberyidm+EFRkkqnwTXj72Dttmv
	fle9xzR9/ejNbVqaK5IfRurKmz47mx+pRApSkHXQvO94mHTeDtKYtXh+CkuAHbIA7K/xgaXD95L
	BUbuMX0n/oxUK2WEKciQsJAeb6+Q9i2Y5izLCoVlcKwu1SdAwgvFYK4mR4VBDmgotWyVwgSqUV6
	2h7b00x1drvsXV7X/6o1HswXXwJRmnhKFCZa8bo6QFHcyzYUSWS2YSegBC/xeAmpiyNF45yQ7SQ
	43YChUT/njUMm8QbImoYXFFvD4izbjMH7wMIjmDZ1jB5mxnCYJ7CDrGfUH3VAo6kzbwyy8AGffK
	N5ENV/VBvElhV/JzAbcVWWZ7W7zfE7kmQ4JJF99UQyqZi4C3KchkED9HPBZMohayN7PS9RosFRc
	9CK5I7e2dEq85slVPcbUOTcKGwanWBmCJPV9ZLEobpa7LvUwwQXNj12lxiGVG8quyGToarxjF/z
	a1/02Y3+ulwRTN/IqMTZHjq4sjX1MZG/a7HNsNvp0pYCVdBRjTDXtuBx3I6qXP3oLUf7WPEP7Hl
	LwZ7SfBH6nFGwSyV3964NpAPZYX/JVC48I+gOUn5rySRg3cqjJfISlSfwS5sdMPVpEE56dykw1p
	q9TdMlOwfx2ygTORDmOvjzFifFLyjqgXQvH+I8w==
X-Received: by 2002:a05:6512:3e1a:b0:5bf:ae0d:5c8e with SMTP id 2adb3069b0e04-5c1bc89ae6emr4162899e87.57.1795503019603;
        Mon, 23 Nov 2026 22:50:19 -0800 (PST)
Received: from yantra.. (nekmmqsyyquzw1lm5eb-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:3cd2:d52a:a1ef:5dd3])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bd018b45sm3538556e87.41.2026.11.23.22.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 22:50:19 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lucas Stankus <lucas.p.stankus@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH 0/6] iio: debugfs register access through regmap in the core
Date: Tue, 24 Nov 2026 08:50:10 +0200
Message-ID: <20261124065016.185124-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
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

More than 25 IIO drivers have a debugfs_reg_access callback that is
only a regmap_read() or regmap_write() on the regmap of the parent
device. Patch 1 adds a core helper for that, patches 2 to 5 use it in
four drivers and patch 6 adds register access to dps310 with it. The
other drivers can follow in batches if the helper is wanted.

The helper finds the regmap with dev_get_regmap() on the parent, so it
only fits drivers with one regmap there. Existing callbacks that take a
lock or claim direct mode around the access are left alone.

Patch 6 is tested on a DPS310 on a BeagleBone Black. I don't have the
other parts. For those, adxl313, adxl372, bma220 and ina226 (ina219
uses the same callback) were instantiated on i2c-stub under QEMU:
reads, writes and refused registers through direct_reg_access give the
same results before and after.

Based on iio testing.

Rupesh Majhi (6):
  iio: core: add iio_debugfs_reg_access_regmap()
  iio: accel: adxl313: use iio_debugfs_reg_access_regmap()
  iio: accel: adxl372: use iio_debugfs_reg_access_regmap()
  iio: accel: bma220: use iio_debugfs_reg_access_regmap()
  iio: adc: ina2xx-adc: use iio_debugfs_reg_access_regmap()
  iio: pressure: dps310: add debugfs register access

 drivers/iio/accel/adxl313_core.c | 12 +-----------
 drivers/iio/accel/adxl372.c      | 15 +--------------
 drivers/iio/accel/bma220_core.c  | 12 +-----------
 drivers/iio/adc/ina2xx-adc.c     | 15 ++-------------
 drivers/iio/industrialio-core.c  | 28 ++++++++++++++++++++++++++++
 drivers/iio/pressure/dps310.c    |  1 +
 include/linux/iio/iio.h          |  2 ++
 7 files changed, 36 insertions(+), 49 deletions(-)


base-commit: f2cbef9101b9fc979a324bb1242b8b802a2484b6
-- 
2.43.0

