Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F320366DA5;
	Sat,  5 Sep 2026 13:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788615582; cv=none; b=JyOOjQubE9MekjwdOugiWKGGonpL/lYmwkBRo3yS7hN/cnf7QZGnpyHIk9ohfr6zeX9iVDUiT4M0KdyzwDqby6EyiSecMutTPw4ss7h9XgRa6nU1wS3eGsuWvZPr/x2qDhdlKn8QxffZVyHkJfK5OaT8t765DNI49T0v8oGhhpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788615582; c=relaxed/simple;
	bh=pwg0rFj1xajU/wfE4B21u+MpCzYljV9MT5k0j3nVbi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fr/a7Xd18tKA2buNmNJI6bCME66XtFiF2JqWSI834SBgc3UPEljVhmEWH0N5OXFjcmXQYR811B/ClGyRIDFIBCvk2G2UwGVA99f/A3PUzF1nzG0JWsYmSHJAEgJ1E5NFn2DhRc5fmKl/CnfzcoewDfrIzaeWmUd3W0qfzD+LSFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cQzLLR60; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cQzLLR60"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=mz
	Nr6siC7QEasvtfMaja0FZLlh2IVC7SAC3/hCNCs2U=; b=cQzLLR60TfVhfRBWc+
	flaUyr4fQWv0OYLxe1VDaONwH6Se9dKJucDhAolKgXxaJ7l7s7RJjq55AeajVRKG
	B2nP4wLjQQtUO8RGRjPs6QKjzXMS/Qw2a8J9LiTdhI8JO813598PYbl6YMdy8kjY
	r305peKCCz8Ak3V5SCV5DyNuQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3v9t3G5xqyL+NAw--.19694S2;
	Sat, 05 Sep 2026 21:39:04 +0800 (CST)
From: "hpp.iscas" <hppiscas@163.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: "hpp.iscas" <hppiscas@163.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?q?S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tiberiu Breana <tiberiu.a.breana@intel.com>
Subject: [PATCH] iio: accel: bma220: Publish the SPI driver's ACPI alias
Date: Sat,  5 Sep 2026 21:39:01 +0800
Message-ID: <20260905133901.66016-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:_____wD3v9t3G5xqyL+NAw--.19694S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF1ktrWktr1DGFW7urW5trb_yoWfuFbEkF
	1rZrs7WFWrCr1DCrn8tr1fZrykC34jqF1fGF1SvFn3K3y7WryrZF97Zw4xXa4kWF17C3Zr
	Xa4fXa4fCr4agjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRPl1tUUUUU==
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbCxRimb2qcG3gvswAA3d

The BMA220 SPI driver registers an ACPI match table containing BMA0220,=0D
but exports only its SPI and OF tables. SPI devices with an ACPI=0D
companion emit an ACPI modalias, which neither existing table covers.=0D
=0D
Publish the ACPI table without changing either of the other matches.=0D
=0D
Fixes: bf2a5600a3eb ("iio: accel: Add support for Bosch BMA220")=0D
Signed-off-by: hpp.iscas <hppiscas@163.com>=0D
---=0D
 drivers/iio/accel/bma220_spi.c | 1 +=0D
 1 file changed, 1 insertion(+)=0D
=0D
diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.=
c=0D
index d6c1087..13b156b 100644=0D
--- a/drivers/iio/accel/bma220_spi.c=0D
+++ b/drivers/iio/accel/bma220_spi.c=0D
@@ -33,6 +33,7 @@ static const struct acpi_device_id bma220_acpi_id[] =3D {=
=0D
 	{ "BMA0220", 0 },=0D
 	{ }=0D
 };=0D
+MODULE_DEVICE_TABLE(acpi, bma220_acpi_id);=0D
 MODULE_DEVICE_TABLE(spi, bma220_spi_id);=0D
 =0D
 static const struct of_device_id bma220_of_spi_match[] =3D {=0D

