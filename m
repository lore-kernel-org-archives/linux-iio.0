Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795748991;
	b=DDTmyAVbn25/XX6Qth7AIXKHh3X6aMBe5gwmaPwyHw8Cd1PPMVG11Giv3sGKLPqQZqQ4
	 RC7xVB0sSbtoP/46Hi0pdzRdxTI/HsuS44ZV1YmC72U3Aa4nXw7DWcg6tWS6cXDLHNc47
	 4trHdmh84R5VsmW1+HXra0Kj0WDsPrtT87DEEcSXKhECOZ8SH5XTl+xWqtS876JtL477T
	 kIqiOScg98HEmwAMtKgQ043DVR+cAmlhIAOiGJnLnddqN+ctwDIsuGHe9VzG3kNzoAMnZ
	 Xowe6iZmsVOjsRWr+YhVzrMjjCI6uEc4oEwNf34l/ddTue2mWB97tXR0e4QNn4wVFAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795748991;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=vGufuwTWq/46jcsCAcE9u6IZvI5rLjH51Ob701dn49c=;
	b=u2oSdadgWa/gEpoO6WEmTVXJbExIC3CqJ/IspuI/R6EiVGd8V28QqRalGJsRSmS2psrC
	 13L+6azt5Xe0PeaHvKGTXO48F9C4wVe3wgPqHhVkQL3QZezv9WDdV4EgnFVY7QvrR5YLe
	 DkIbQqNAU6kLSMorPFgFKuslCQ0MxfCs7cYhET35tCFDG4BhDggGhzpAfQe2UP62WKWOT
	 SkIqRe1eXZ03PSHUoXBJwI95Ymhhqlk0lflTetRnjJ/2ZfVux6Vs0v+5IGeqshKyPOHqh
	 mvJo3V8GU9KL/yQrwFVaRGFht4N+XmM36adTEkcoVuUl9enzH3+TVH8XaPrS4mCD+bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hexin.host;
	spf=pass smtp.mailfrom=hexin.host;
	arc=none smtp.remote-ip=54.204.34.130
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F7B606A32E
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 03:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1F7B606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hexin.host
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexin.host
X-QQ-mid: zesmtpip4t1795748918tcc28d8ca
X-QQ-Originating-IP: wHRPhH5Cv78IADx954vb3fNW7K0ATGmFEMzkF3Q7oE8=
Received: from hx-KLVG-XX ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Nov 2026 11:08:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6242006420529813384
From: He Xin <hexin@hexin.host>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 13/18] iio: accel: mma7455_core: support mount matrix
Date: Fri, 27 Nov 2026 11:08:05 +0800
Message-ID: <6C5039907E7787AE+20261127030810.3150676-14-hexin@hexin.host>
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
X-QQ-XMAILINFO: NoFe3wCY3jEyJKq8ErANha//0lAaRosOs/Cxz6viOSX4dCe66+HUNZ6Q
	fgn9HCJ+dXwXAAE8cz0LS1BWZHGULe6qkdEDyLNkKQ8ZZVW6XK8whkoQTguvjdmI8nauJHS
	NVNLz3zG9ajeueoKDXmM82ERNexI6dALBPZ44zh5xTzVw7g2/gM7osL8hOFgx3XAf+jThB9
	hC2YXgD7CJgI84V0txD/k4MIyBGnmG413lgCkFTxH7qiBVx/uJTairRXwyZo1UmTq69MRV7
	GmC/KCpiFX9NekEILrJpJmYPOtBAvTVvwlM29dT8bnmLNmEJwb+JHblGYHTcoKZM3j1GPnq
	IrGA7JbSkSMGyPWSLsCkihU2zB427wANNv51+9xDmipmmLXrv4/NMCEU7aXZqNoRlNSd0wR
	l9z7i55VAW0iML352nJEaKClW/pIW4bu8WLyELdaChjjpPpSWGkQehz/3hGpYAGR/M1FmQ5
	BixsyN77pFarbGCt1fXfJwXc/Q6dsvtnYDf6O70kSdIJH3wosX+sXZr0GxcOOzKG5MZl/2C
	IkzF9lTmPte34Tz2eoL0PHZbPMViuuSWqrmYbTqXr9DBFyFJPhTSGUz+bbjxjjlJYA7yhrJ
	Ql709ql2iOyBPBFI1iNjFtB6V8+ftFz4XwFjTYtdOuH2IVwBC+1c9YpfMJUxTssRQBSC0Av
	9k+GsAXriLCeQWhZMUdH4i3ihydgKiXTkzeik6H5ltEhNtxhwzeuSKm+SmrXbpEStBmc7oC
	g2jG6Gm0Qv2XJvsWVaUOKKo3pD+glWeD1Rr7ijraKC5P17E6uOH3dXuzjSuSkC0jnv0RWbZ
	SqPPFw9qPFKDGpvjJ4Z1PwOPnJ9OPGog3dc68FTKdYGYmOrscNuD9qdurXmTm4fAh53TGEm
	+eF8Zrarhrg1yKACwQrEObn4/8xdYggh0FSB20QGeJwl4GHCR1mgZB+7poo3alrD0LNYQsn
	gofOThimJBrQUX7kQ6bzBmEbb5tJv81kxt0BdOoKvtSN6N1ZyqnUOiCrslRyCXKETMxitrW
	gOZFhOWfDAQq6UUoCbsmP/ePyWvntKEngmWrgiYRspMMZHEMbp6DsdR/zO25HepYbVXhejf
	D+LMXTM/ak+JhGMR5BJNrw=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

The driver ignores the mount matrix described by the firmware (ACPI
_DSD "mount-matrix" or the devicetree property), so the orientation
reported to userspace is wrong whenever the sensor is not mounted
axis-aligned with the display.

Read the mount matrix at probe time and expose it through
IIO_MOUNT_MATRIX(), as several other accelerometer drivers already do.

Signed-off-by: He Xin <hexin@hexin.host>
---
 drivers/iio/accel/mma7455_core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iio/accel/mma7455_core.c b/drivers/iio/accel/mma7455_core.c
index a2b5bdf..bd4e07b 100644
--- a/drivers/iio/accel/mma7455_core.c
+++ b/drivers/iio/accel/mma7455_core.c
@@ -61,6 +61,7 @@ struct mma7455_data {
 		__le16 channels[3];
 		aligned_s64 ts;
 	} scan;
+	struct iio_mount_matrix orientation;
 };
 
 static int mma7455_drdy(struct mma7455_data *mma7455)
@@ -209,8 +210,23 @@ static const struct iio_info mma7455_info = {
 	.write_raw = mma7455_write_raw,
 };
 
+static const struct iio_mount_matrix *
+mma7455_core_get_mount_matrix(const struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan)
+{
+	struct mma7455_data *mma7455 = iio_priv(indio_dev);
+
+	return &mma7455->orientation;
+}
+
+static const struct iio_chan_spec_ext_info mma7455_core_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, mma7455_core_get_mount_matrix),
+	{ }
+};
+
 #define MMA7455_CHANNEL(axis, idx) { \
 	.type = IIO_ACCEL, \
+	.ext_info = mma7455_core_ext_info,\
 	.modified = 1, \
 	.address = MMA7455_REG_##axis##OUTL,\
 	.channel2 = IIO_MOD_##axis, \
@@ -267,6 +283,10 @@ int mma7455_core_probe(struct device *dev, struct regmap *regmap,
 
 	dev_set_drvdata(dev, indio_dev);
 	mma7455 = iio_priv(indio_dev);
+
+	ret = iio_read_mount_matrix(dev, &mma7455->orientation);
+	if (ret)
+		return ret;
 	mma7455->regmap = regmap;
 
 	indio_dev->info = &mma7455_info;
-- 
2.53.0

