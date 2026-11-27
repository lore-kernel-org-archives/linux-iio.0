Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.243.244.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795748948;
	b=fr0kyq4YC9HJBoR2y5/HoG7C1Kq54S7PX65+uPhNyobor4OL1RKgBCbjtcIIYfyeazSL
	 JfxKRIZQyRJnVNfPjVds1hTQNdmcBkzNcjUWbLzRu4hRWTcfbKHe94fISfxAqlF27RMTd
	 y5L4aACMm4ZKsjk5Qry+5WpfDnObWV4Vx+LXyszHSBS8+ecAdbYf2MvPaCs6DcngOsu0K
	 ViP2VYqlsJ7YcoMtK0Fj2lvTspobOL/itp2rIJdTnSMjc9VQgtSeWxPTwMLmSIY1PCbSm
	 QbFKqXM0LsUCkwp5anIf3DSpjgZtjpjjcOWYY2Xat/VRPMXa9jrb09Jpkc1fpDcTwAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795748948;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=6DrPhPCOvsyTPkUoQQH4tkZ0+CAjmq09ohxNOfZmRZg=;
	b=yZSEwGkqXEMFVJqW4mGjX/HEzWM0gQpiqCM+RKLNn2v+PlbFzyB233vxdmawWGalLUyh
	 2W2ePjJZRr3SqsWUiuowQzHDuU2+2fvxu+gcRjnNMCKN7v6G/cAWpMDJ3uM8hNIPBghfQ
	 2y2bDdC6ogEKDBQHTy0AuxlJQPHh9fsLWh0sPTvwoyjKzXxxnDKIp29GmBYzh/vdLkYkH
	 2/P35ukbyoalayn1id3TT1TsyFrwPqW56Dr5Gtcx78q0yApPh5emWefG6RMBI8T2VU/Vg
	 DeY43M7arVRs20fELupF/u3v6e454R+dajNhOt/Vb7i0n1pxrWSyMj89eq9Eq9slfpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hexin.host;
	spf=pass smtp.mailfrom=hexin.host;
	arc=none smtp.remote-ip=54.243.244.52
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4C7606A324
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 03:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC4C7606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hexin.host
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexin.host
X-QQ-mid: zesmtpip4t1795748907t977883a4
X-QQ-Originating-IP: YkxTPdo0ZHHOXNVA/NDFmyRxBMR4UR6bK+05Pbt/8Rc=
Received: from hx-KLVG-XX ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Nov 2026 11:08:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1561093114053592961
From: He Xin <hexin@hexin.host>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 07/18] iio: accel: bmi088-accel-core: support mount matrix
Date: Fri, 27 Nov 2026 11:07:59 +0800
Message-ID: <CE97CB3268C27F38+20261127030810.3150676-8-hexin@hexin.host>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127030810.3150676-1-hexin@hexin.host>
References: <20261127030810.3150676-1-hexin@hexin.host>
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
Feedback-ID: zesmtpip:hexin.host:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NhvpCzAv3WKAZEIvGeSnQLz28Cecc9Go1Ps8dMDLeuEQ82IXpVHhd4g1
	GHH1H6FprbV0JKaCnulyiLhUnpBvKVqofiGTSQcdhBs+4wCl1ARZ4egs+WfN4v4l3+WBHco
	FqlB0A6xIB5QB9kuyqQ4n2YD/JPhR+jjEE4qMUjK1tGw5QZklkYAcKIYdvwRzoPftPSLrcW
	vf9EyGwQwt1EfzucBwXrKbtdo6g6IZmSzkwYsZb2bUojLHlqM6pJsQkXbVDIj0rK9l1ZVXy
	V71IzmJAKiEQpNkiOAr1jEWuP/HuFl7cytOMBSNrMuU+JoxPNsaJE7p9nBu4q0XxHvS5my6
	/UmQ2P5zklK495nGEoicKOhaXFqreSANyceBMRxarMSy+FAx+mTC1ordAmKP/Ag0EhRkKlm
	F+Xyn/3S+2MX+zwNOucPadFpfM3bgOD8BsMhwIgNip53OhS+CFUIdnwRtgAKHqaGy8onnMQ
	7gTijsydsS7j336m6bpfyzrDRGFeaqiagpeyCQMTxBwSiAWcgRces5x2WnYssEsnlpI30En
	0qMgsWVeeCN5cgtzTyjuw76YyaKcAmlTPzDV1hicOBku7r2d5UB+MdmZqpRP48vsAuNgG6S
	9ieiU3RG/YSzZJNzzbBmLpJXqfrErVPrUFXgqBjLAEvRjfdjlitQV68Q9nOOd/CWLTYpRdV
	E3UVVsE9RTjAKnfEYP9xJ5pqharV/BqlKim4LHtu5Zmy1PJPkQtqjb9nOwDmB26rrNjNNJ7
	NzWPaYVTnAxm3jWjyACWDrk4EmHPNEpmqKElczTL7orbzQbyt8AnbyE6QaKE54cToInSIf6
	1RzNelGx159BFu1Rd5NOGy7iNSXdZVJWY1utoxGDMD09HN07sqdXMaFV6FRjvSu3OL2PRo9
	wF0JOObYB7pDrvP/BhLEQF2HkkV0B34I9Z8v7/0tA6rMt5qe99DyvifHwqpUvLmxDK09oze
	iE0wquE2KGLYqGPSY+P5zaqfcT/KOkaHRQUaJoVbLqpueJivysPeFz00QamSpt0CMeANSZf
	MTgvk36DjnVAYhnjjTxX14ez6cNY7zAtQpFgNtE+bvW5uYLjrL
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

The driver ignores the mount matrix described by the firmware (ACPI
_DSD "mount-matrix" or the devicetree property), so the orientation
reported to userspace is wrong whenever the sensor is not mounted
axis-aligned with the display.

Read the mount matrix at probe time and expose it through
IIO_MOUNT_MATRIX(), as several other accelerometer drivers already do.

Signed-off-by: He Xin <hexin@hexin.host>
---
 drivers/iio/accel/bmi088-accel-core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
index c7da90a..45241a2 100644
--- a/drivers/iio/accel/bmi088-accel-core.c
+++ b/drivers/iio/accel/bmi088-accel-core.c
@@ -126,6 +126,7 @@ struct bmi088_accel_data {
 	struct regmap *regmap;
 	const struct bmi088_accel_chip_info *chip_info;
 	u8 buffer[2] __aligned(IIO_DMA_MINALIGN); /* shared DMA safe buffer */
+	struct iio_mount_matrix orientation;
 };
 
 static const struct regmap_range bmi088_volatile_ranges[] = {
@@ -433,8 +434,23 @@ static int bmi088_accel_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static const struct iio_mount_matrix *
+bmi088_accel_core_get_mount_matrix(const struct iio_dev *indio_dev,
+				   const struct iio_chan_spec *chan)
+{
+	struct bmi088_accel_data *data = iio_priv(indio_dev);
+
+	return &data->orientation;
+}
+
+static const struct iio_chan_spec_ext_info bmi088_accel_core_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, bmi088_accel_core_get_mount_matrix),
+	{ }
+};
+
 #define BMI088_ACCEL_CHANNEL(_axis) { \
 	.type = IIO_ACCEL, \
+	.ext_info = bmi088_accel_core_ext_info,\
 	.modified = 1, \
 	.channel2 = IIO_MOD_##_axis, \
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
@@ -555,6 +571,10 @@ int bmi088_accel_core_probe(struct device *dev, struct regmap *regmap,
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
+
+	ret = iio_read_mount_matrix(dev, &data->orientation);
+	if (ret)
+		return ret;
 	dev_set_drvdata(dev, indio_dev);
 
 	data->regmap = regmap;
-- 
2.53.0

