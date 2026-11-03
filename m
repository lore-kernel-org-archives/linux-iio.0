Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.254.200.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706118;
	b=mcd02qVetx7pSpAMmEVE6f3jxn8/B//ALAEFRfzoP8dCjbDT44cwfJCCL5g1e1w7yyzq
	 lO1dkEWlWN4SND6DR/6Fr/4+MEtfFrouMeNmEozqxlEPt5/7dUtXmanCZDa443bhcgLf7
	 kfdEf47S/zt+4j7NY8P45MtEA942UYqOla0JnuloAZyrUdiXCeCwzOa9C5Ple2thpecRI
	 UPqC3Z3Pid8mbmiBOM0d4lmEisXY6WBawAZl6aE2JyXBZhbecQLa6ioAWlsaMUiRLhRUz
	 h+5utgkR0/WuEpMYTaDxJOAUpvDqc1WMovIl+vyvNqWH2iPT5fdGBiD4Eev1cihX+Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706118;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-QQ-SENDSIZE:
	 Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=Quzn8tDSWOj9Otu16BaBrdI5t0AOEg7iQ6jj1NIMH5s=;
	b=L4Ac786bx2tLaDR+VjnA5QkDVNuN7GYYd7C0+Bom9ek4P6Vt70swM5PlmIcVKfs3PcbQ
	 gVqRZBUrmn9PW1W50HM603XgBnvOtKH4BHgRT6vWMRPGavz2cpnlLgFOnTCtFPYnb2THc
	 kqdD/o+yV1knnVZOl7GehckgFp1wE+k3EBTk+Wr7kd4oCIU3DpNEFTvaAlOqWUtI3hyjz
	 MTtFxxGVsca5nPdDIo8JSnGXSZM2tiPBOVXqzd3GjM7VeDG1JZFd4Gp04QQ14lWsfze+w
	 xY0/SW88cwfV1uLkO/YNcRv46plnvcTL1qtNDjei2STR7QusPjXzhruCVMERWx9EyCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smail.nju.edu.cn;
	spf=pass smtp.mailfrom=smail.nju.edu.cn;
	dkim=pass header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=TZSrww58;
	arc=none smtp.remote-ip=54.254.200.128
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C06F6082BF4;
	Tue,  3 Nov 2026 11:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C06F6082BF4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=TZSrww58
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1793706083;
	bh=Quzn8tDSWOj9Otu16BaBrdI5t0AOEg7iQ6jj1NIMH5s=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=TZSrww58lP1j5o6LpJdN5E32hdgFibIQpneggjSR7qgD14H4tv3Fs1qd1dFpKQYOQ
	 Aler6YFzel6hBmPDgCwigGd84CGESWs1YLQN5Nq3jOD8C9HQotT2Vmq3X63mFvb1Ey
	 9PYJtcsvY9bwqccqUASoK7YFhhZIN8/3l2VXWwR0=
X-QQ-mid: zesmtpip4t1793706077ta8017ae4
X-QQ-Originating-IP: CgLr/o05gbHd9iLwh6qU6GiZ5/4CMdQLF2HKButkzRk=
Received: from workstation-Precision-7920-Towe ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Nov 2026 19:41:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11776490591211574618
From: Kang Chen <k.chen@smail.nju.edu.cn>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Victor Duicu <victor.duicu@microchip.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: pac1921: validate the ACPI description
Date: Tue,  3 Nov 2026 19:41:15 +0800
Message-Id: <20261103114115.74662-1-k.chen@smail.nju.edu.cn>
X-Mailer: git-send-email 2.34.1
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
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: Mprg6+9faFwuonxFKdHsqYXJyipBWk+Ihch9dk758p6OMsnVcUufQDhv
	FMKSFxrgtMUx4JrkNf/5af8YaFb586aUrTTu1+trSc8lZZ+80o3+NfXZOyRu3Z33WMK13ti
	kRdl4CBi8pGIcXRHSbhrjHMld3XHoRY1DHaKhVsyjv4DvO0VrUStnQ5lkG71a8IeH5qBIgD
	u0tgwLAhu5agB+Pb1HRv/BJz0vHq/BNqYfL7FimUrnSZCQemIs0BOx/g4HI4tRCi3RPxxKz
	xZ0POSQDTh12jo1P1LdvJjDjj0RcFmEE1h+zdjbyKW/c+If9pNmVDTgfXfcwMlEENW26oP0
	h9j6HLbtZP9cFHiiWOSmBWqDzIR7Y11pRtA2cmcQmDS2JH5UK/jQCEM31Y7POp7QfERPeW/
	2MXY3tEJZRskwR+vgmNUZhEgMlKzXe/UbSCc10u04GWtHTfE+yyRVlRLSzftikG3dFsi14y
	bDfTpTh6CErVJca28qAeTWajyUVw+MW6bsxhsf7gpc7Y2E+dKWaLiVn92eamCw9c4QDQ8cB
	VfdMkIUwDW0dAUSqVEhpc96RN/GKXvCGcfC9MnYoEDzg/Hb1fz3Bjk2qC5YBR2JSdmo1At4
	oxQXOOHJecOJCXIxMK0ezrAqb/ZpjsfsxNDgMX/WPr+Th7Xx4PobZPZAJwxxK2ppDUHUa+l
	U4BQZcDc56hnhkk+yeYwO1qTER9+p4J04KqatASf5uKaQShKgYxoH411pFG9NJaL9RR6/nD
	9+C1NO7eAW8wsWGaN4J9i8J5AtN5k23yYX9M8S52+CJDu2XVwMUMfdNQCrkvsW/kUFViMkI
	T9vzyrI0fwGeD3YzA/bQc1GNI5A1qAa0ZaxoSOuV9HxnWU2DE8uQCSsoqnORpeH4XXPrlNC
	4IhBAcQ0jUu7IknnWlGM8xVHD7mZ7qs47N2oEz1ablFbonh2nFJZztVVrx7/Dm28lqgI770
	zE53iO2owilnDysHLvq5SFx9MvIzjTNVk3KiqRLPuynZQgLRL4LsVs4wpvmkpZPueaKs463
	UMXGRE1CKY9SzAl9od4THfeCZVSz1pAAafkOJHMq+R8otL9DYAjZsxBMy+6Oqnf3BLEAACF
	Q==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

pac1921_match_acpi_device() reads elements[0] of both _DSM replies
without checking the top-level object type, the package count, or the
element type.  An empty package makes elements[0] an out-of-bounds
read.  A string reply to the shunt query, or an integer reply to the
label query, makes the driver interpret unrelated union members; for
the label query this can pass a firmware-chosen pointer to
devm_kstrdup().

Require a package with at least one element of the expected type before
reading it.  Also reject a shunt value that does not fit in the int
range checked by the driver before it is truncated to u32.

Fixes: 9fdf1d033316 ("iio: adc: pac1921: Add ACPI support to Microchip pac1921")
Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
---
 drivers/iio/adc/pac1921.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
index f0bab94462f4..3242928d80e4 100644
--- a/drivers/iio/adc/pac1921.c
+++ b/drivers/iio/adc/pac1921.c
@@ -1189,6 +1189,19 @@ static int pac1921_match_acpi_device(struct iio_dev *indio_dev)
 		return dev_err_probe(dev, -EINVAL,
 				     "Could not read shunt from ACPI table\n");
 
+	if (status->type != ACPI_TYPE_PACKAGE || status->package.count < 1 ||
+	    status->package.elements[0].type != ACPI_TYPE_INTEGER) {
+		ACPI_FREE(status);
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid shunt value from ACPI table\n");
+	}
+
+	if (status->package.elements[0].integer.value > INT_MAX) {
+		ACPI_FREE(status);
+		return dev_err_probe(dev, -EINVAL,
+				     "Shunt value out of range from ACPI table\n");
+	}
+
 	priv->rshunt_uohm = status->package.elements[0].integer.value;
 	ACPI_FREE(status);
 
@@ -1198,6 +1211,13 @@ static int pac1921_match_acpi_device(struct iio_dev *indio_dev)
 		return dev_err_probe(dev, -EINVAL,
 				     "Could not read label from ACPI table\n");
 
+	if (status->type != ACPI_TYPE_PACKAGE || status->package.count < 1 ||
+	    status->package.elements[0].type != ACPI_TYPE_STRING) {
+		ACPI_FREE(status);
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid label from ACPI table\n");
+	}
+
 	label = devm_kstrdup(dev, status->package.elements[0].string.pointer,
 			     GFP_KERNEL);
 	ACPI_FREE(status);
-- 
2.34.1

