Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.206.16.166
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795748958;
	b=TU6TOju3TxQu1CPIwCBmHIRIHRK8dtKf/yB3AqMb7JG9XWj0eaIgqyacqKmE0VLXgnxi
	 TPDqtuyHsdTqDjvicF0SG5LijEdAlHgQ+385DDNukZyam5uiqG2yojC8BwcuE3/e7YKRc
	 ZJkc1uE9h61/BfTmIiW1bxH2nHjg9XIOEkMXV4gs6UkwmYSCdgOuai8AFBB69wzkuLY2M
	 mTAqdUR6jep72TQjKOeZcnDAP93FwQE0BzpqYu8m0inBoMuFc+aJ77m9rXx3cm7x3kQj2
	 0Nbm7wTRRgbbOkqtZ4K7zy2neNGMhHtrSyWwZFjgG8e3HXHxNAhWHQ7RHLtVUCq3n8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795748958;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=yang9FDd2QKzvnFaeSDzP8EVQcakOgTxvqErHr760yU=;
	b=5D2bjz/RckICxc55smjLzrfEg5pNDlh8n4rKzazbikC9J7u9/ELxyBVLjFaKR5p8w+26
	 vXuWSt0DB+7zNzNHfWfZ8Up/D/yEP10/lR54L1B4j35VR1BXoKVXmoDo/RqlEuVBX9k+P
	 LjYLw2fZ+2k69I0z/2o767nxtrmFXoetD8k0797mYweaon1slX3NTacfGI2cYwiutlZnK
	 X01p2cG4mDbX4DQEgotdNa6eu4LXZA/O0okJ6T0vXSsiopxAnARaVQrawsTYzbMWycQFC
	 BHpghDALdZ3nNFE1U9CwhrLsAZs52JZOj837SE+U/eEluNYBY9v/LBg4NmE7oW2lN0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hexin.host;
	spf=pass smtp.mailfrom=hexin.host;
	arc=none smtp.remote-ip=54.206.16.166
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6571606A323
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 03:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6571606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hexin.host
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexin.host
X-QQ-mid: zesmtpip4t1795748911tf9beeec0
X-QQ-Originating-IP: OGgt7BYEOgc/04Do+MHR7xcThL0N/iEyn0/GLwFxEu4=
Received: from hx-KLVG-XX ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Nov 2026 11:08:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4401803222957150643
From: He Xin <hexin@hexin.host>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 09/18] iio: accel: da311: support mount matrix
Date: Fri, 27 Nov 2026 11:08:01 +0800
Message-ID: <B8B52AB3DB58F436+20261127030810.3150676-10-hexin@hexin.host>
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
X-QQ-XMAILINFO: MVocNrGTvdgh2zD/I0lKSA3Fr/hn4trINp7uGbZuVZMIhC/Fusm4uG1q
	yAnOdhB81kiW0KqKMZ05DhPD6G9udIpfrhsIRlvxA5QMJd1MtoWOfOUsnb2tmPeIa5iH6AT
	63YqmwaJD1ysQy8xbRPWAbPMRIQaP89j2u2KxLLxu7GCwKugUAQNTOuJoORmvbFxcfOlcV8
	S+7QYZu3YCx0eIl3IvhgWMCeG0lLoDXVFWTdUJFt1uOwrUuftPvOz7JI5GdagyhvcDbfNAn
	aab/+BVWy4Q54pA8MnVPqHDoGzcc8lktU9JTK2iIGGj5GYXy6w+wtsbRQ4Jh9CmrB5aJp3+
	SGGTjK2kFfWR8OHZgnLYjKUC8YH8sYSUL9Mh2Y57b7Zo3HLMn5PHnApRM20nE6xnHQv0ccX
	eHccSMlVKNQvJjMCjUEMoj8RlR0G0OaDk9T6O8bESF/awe+F/15h/Os8X90QBNUgPyaB50A
	sW6mTVK5mVZcBg180bOgKlS3n/JYf2SoB/Lk4N/yy1gBn6OxapsJcxFCdfAk8Gp0jWz0/ky
	nxfXUPfErkrYaK373qjMYFOJbZMlwfLrQoSqFeLIlwcFrdUhOpSHFkbYCuEDH6Ru6g65PKr
	KPpKTTY7kuY+BX8MgD69uO7NjR6HSbDzDNUjj4x6KT5dspJug/gDCFhfCGtq/rWSXWbXDf4
	mXIb7mVFfLZjLnvjJKz75YR2EMrwAxL9QLB4UdaRvqaEP52nXjrTElJKEJXJKSSWCJLmjG1
	3k9G48XG+Te+GaJkuQ1ztDYNXgH0pyFsNLGE5zFnwGfjS/ashnHFAEjZYdNXtUzkcEZZ5Oc
	yHCjcgnkyJYuN5Q2TUp2Wo2/rXHEgPXd3uv+JV7de/jhXECzKvF0h5nxDixAh/INmpswBss
	VoSqaJBifDFNaWjqCXt9omCuQsCwZmdetg6zecRdxjwQXVwZ3+1VCfDPbU6QkKbaH4vPrWt
	dHTGGDVVohIBvlsIhhsmSDpmWy8YxaoLXoKN/xIZmQiostiPy8kzGsmJwIwtv0mIM/RTR3H
	KvPh4RnfN+E42mkzIqxmM5IUMsNiT1BpzZdsm+dt0Z7829LgYNCzNgbRIkx+o=
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
 drivers/iio/accel/da311.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iio/accel/da311.c b/drivers/iio/accel/da311.c
index dcb69c8..35472b2 100644
--- a/drivers/iio/accel/da311.c
+++ b/drivers/iio/accel/da311.c
@@ -77,8 +77,18 @@
 
 static const int da311_nscale = 9580078;
 
+static const struct iio_mount_matrix *
+da311_get_mount_matrix(const struct iio_dev *indio_dev,
+		       const struct iio_chan_spec *chan);
+
+static const struct iio_chan_spec_ext_info da311_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, da311_get_mount_matrix),
+	{ }
+};
+
 #define DA311_CHANNEL(reg, axis) {	\
 	.type = IIO_ACCEL,	\
+	.ext_info = da311_ext_info,\
 	.address = reg,	\
 	.modified = 1,	\
 	.channel2 = IIO_MOD_##axis,	\
@@ -95,8 +105,18 @@ static const struct iio_chan_spec da311_channels[] = {
 
 struct da311_data {
 	struct i2c_client *client;
+	struct iio_mount_matrix orientation;
 };
 
+static const struct iio_mount_matrix *
+da311_get_mount_matrix(const struct iio_dev *indio_dev,
+		       const struct iio_chan_spec *chan)
+{
+	struct da311_data *data = iio_priv(indio_dev);
+
+	return &data->orientation;
+}
+
 static int da311_register_mask_write(struct i2c_client *client, u16 addr,
 				     u8 mask, u8 data)
 {
@@ -232,6 +252,10 @@ static int da311_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
+
+	ret = iio_read_mount_matrix(&client->dev, &data->orientation);
+	if (ret)
+		return ret;
 	data->client = client;
 
 	indio_dev->info = &da311_info;
-- 
2.53.0

