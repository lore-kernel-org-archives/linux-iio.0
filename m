Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.254.200.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706110;
	b=478XLX7y1dcgBS14N7HwmojR2B81oag7ejbshU+V4qSbuW1eDzdfCrMQso5RSbEtZkC0
	 wKar5HccHuV2HR9sOrLOFDRj79NRIMo+Ht0MIfRzHbIoiw/J/u1kF0z7DulkvJfq3oWng
	 9cAXAIQbA6d0duzhQAefKBvqoUlCUZQzViqQW046jXcksqzF0l6NcFQ0iLANo2re+MolO
	 mnTd4/cO+VmbGVux9sY5RRTwXdzH6Y1HeFD1d4PpMC8sQrj0FcBlPUnF+TzI4EbfTYHxN
	 x/ni+659a3BeJgEhiQnCaj/pKZ5wSAtSqMnpFFijB5gcxbgfUIwV84U7AHQ0gdofUDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706110;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-QQ-SENDSIZE:
	 Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=AHUtrGVVVpPripQgHM30mxejG4b6kABVp9lqtckcJZo=;
	b=b2RSNSvk+w1pBcu4VT1ofZES4iESdCvCD6uq50h7FNRwcBPQPIFENaLJYHpvo10a9DdT
	 I1Svxrg0P/lm1agmpj7lxnh1lPNgQmu7oM5zYnptehtVnNYpMKHbqDB512j6RAC4ez1cK
	 7vwbJSdPdq7kvXmyDHGzJrV1y0B2eBecMlZgLA42//4ZgpDJjP6m5fexe5mvBbcYzYsVO
	 Tfmngh2OMsl8wdO+bPD+1MM+2ohYCiB2VRvkabm68KFKQyM/O5rs7lKv1ctBRL2Y+gv11
	 YtOJ9xiAHCeArQu36/fvVOvBwTf9vpjKnL4fv5p2W9xD06TgHPfB4xzKH4UqQDNyhVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smail.nju.edu.cn;
	spf=pass smtp.mailfrom=smail.nju.edu.cn;
	dkim=pass header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=49f1Y1MS;
	arc=none smtp.remote-ip=54.254.200.128
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B2C606EEA9;
	Tue,  3 Nov 2026 11:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67B2C606EEA9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=49f1Y1MS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1793706067;
	bh=AHUtrGVVVpPripQgHM30mxejG4b6kABVp9lqtckcJZo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=49f1Y1MSkXdbFMOnaqN7OaTzdKVCoLYPLgMFW7UuP/HfWDLsZV7blhMizh5yH0m/G
	 t0+6NkzwuK5JDYtp13IWRDqWZ7GDIht1ivxGFhX6hj3lw/9ts+G3o6tMDG4oeg4Mx6
	 kUaSGxOLJAghXo3g+ly9IWPUNMJql5l6HqB17qUI=
X-QQ-mid: zesmtpip2t1793706062td5792a11
X-QQ-Originating-IP: 6OE4mHE8SKQGXjON/lNok7v+0STxNPg+VR8JNlTF80I=
Received: from workstation-Precision-7920-Towe ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Nov 2026 19:41:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5616215956870493913
From: Kang Chen <k.chen@smail.nju.edu.cn>
To: Marius Cristea <marius.cristea@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: pac1934: validate the ACPI channel configuration
Date: Tue,  3 Nov 2026 19:41:00 +0800
Message-Id: <20261103114100.74050-1-k.chen@smail.nju.edu.cn>
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
X-QQ-XMAILINFO: NQR8mRxMnur9YXYoFTeISnJlHBu+IOPI00FyHeaGER4PpHrrqG3Ldqtw
	pm01eSs5KfUjGAAc25rq8t1Z5Z5suKhsTnvPDvkrLrip7TiwJDc2DMz7jUE8vuziBj6/7G/
	KEeILyyb6rMJT/Dd26jA/knZ7aIs+9g5alOrLQVIjzE+TqEY9XCDjCAaKLXVrbfvXjCzqiA
	wnhvkf1Fp93PXHhU5DWHYic4A6DXWuaXVQHCxB0J7TzBWEF7Z/GW5Yvo0eppso76FJNHzQ8
	FkLx7rL+T7GPMHYZudQ/GPH4IF7RBvLLQn1r4CtsWPmJbvz0BKyridxb5IJqe7fMr7WDweV
	Sq7GCR5WIKoBv/MrmVINvX3DIXCfJYiTraFey6MtpZZhgSQzt3Ocx/LrrPraLjOmRnCeiRb
	M8WHfQbsg0L0k/t5Mfn7tpGFsgbnlUCJJj8IBeSS+fA6w5uO9UFnzAoy3wQ9eZ/TFVDgzhB
	bWxw1o/d5mPa5h7q/jlGBpT0c1nuRlSPkkWWWZt9ZeQZ6LdXZc5ldvzxRUo+Txwf56a6x9S
	F5vg50YRWibxs+qtsY/HhtB46lEbF+ocMwte7hhH3raNagMYIYBOi3LxMj1zswKjLVmZ6FU
	LZx4e8VRQ4HZVhxhQzTmsd/24Ve3Vr82E+dngswT4dUEHWCABKVdOZDNMUDSa2F7Ti0lIs6
	EH1Znfaa9PZ0V4PnXa+9SanODBJ5ril9LI/9oTBKtGufq1OzMoqfuPm//Pl5Lj5EmoSPaCf
	YVDoGlEKdrXhapovpc43fELitE32DegTOSQSZ7jSJNGsVZ9ktoqwIhRVzFiWpSMdHcShS/R
	WfI30LfVM+dRHNfr6GT6CLJ10BzKYCCmN8KvUa6jwE0unw/Y1vI5l9j+Z9kS4sT0SDp/9s4
	Ud82dMGukqubwhCkOKtouWBI0oFEERvduV27awrvFWutkX5LtZbuhDYM8qNDcpXULMXUJ6+
	ZkL4/Aaxfr5ietr4tkv7oC06a39Im2cVtWrnZcdmy/vCVRH98ZNYftkO+uDnIqt0/5XNIsr
	k6u+IU378eEsVPA0fKml/c+GZF+jerJX+agpzoVPyuVFut9EdJDh0VSMMFsig=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

The four _DSM calls that describe the channel configuration trust the
returned package.  The first one is walked in pairs and its count is
used to index the four-element labels[], shunts[] and
active_channels[] arrays; a longer package writes past them, and an odd
count reads elements[i + 1] past the end.  Non-string or non-integer
elements make the driver use union members that hold unrelated data,
including a firmware-chosen pointer for devm_kmemdup().

Validate the object type, the package count, and the type of every
element before using it.  Allocate the labels with devm_kzalloc() and
reject an impossible allocation length, so the terminating NUL cannot
be written out of bounds on 32-bit systems.  Reject milliohm values
that would overflow the u32 micro-ohm fields, and micro-ohm values that
do not fit in u32.  Also validate the single-element bipolar and
sample-rate packages before reading them.

Fixes: 0fb528c8255b ("iio: adc: adding support for PAC193x")
Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
---
 drivers/iio/adc/pac1934.c | 72 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 63 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
index 5e901ab25c8e..b0447fc813fc 100644
--- a/drivers/iio/adc/pac1934.c
+++ b/drivers/iio/adc/pac1934.c
@@ -1094,7 +1094,7 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 	union acpi_object *rez;
 	struct device *dev = &client->dev;
 	unsigned short bi_dir_mask;
-	int idx, i;
+	int idx, i, ret = 0;
 	guid_t guid;
 
 	handle = ACPI_HANDLE(dev);
@@ -1105,18 +1105,44 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 	if (!rez)
 		return -EINVAL;
 
+	if (rez->type != ACPI_TYPE_PACKAGE ||
+	    rez->package.count % 2 ||
+	    rez->package.count > 2 * info->phys_channels) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
 	for (i = 0; i < rez->package.count; i += 2) {
+		size_t len;
+		u64 mohm;
+
+		if (rez->package.elements[i].type != ACPI_TYPE_STRING ||
+		    rez->package.elements[i + 1].type != ACPI_TYPE_INTEGER) {
+			ret = -EINVAL;
+			goto out_free;
+		}
+
+		mohm = rez->package.elements[i + 1].integer.value;
+		if (mohm > U32_MAX / 1000) {
+			ret = -EINVAL;
+			goto out_free;
+		}
+
+		len = rez->package.elements[i].string.length;
+		if (len == U32_MAX) {
+			ret = -EINVAL;
+			goto out_free;
+		}
+
 		idx = i / 2;
-		info->labels[idx] =
-			devm_kmemdup(dev, rez->package.elements[i].string.pointer,
-				     (size_t)rez->package.elements[i].string.length + 1,
-				     GFP_KERNEL);
+		info->labels[idx] = devm_kzalloc(dev, len + 1, GFP_KERNEL);
 		if (!info->labels[idx]) {
-			ACPI_FREE(rez);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto out_free;
 		}
-		info->labels[idx][rez->package.elements[i].string.length] = '\0';
-		info->shunts[idx] = rez->package.elements[i + 1].integer.value * 1000;
+		memcpy(info->labels[idx],
+		       rez->package.elements[i].string.pointer, len);
+		info->shunts[idx] = mohm * 1000;
 		info->active_channels[idx] = (info->shunts[idx] != 0);
 	}
 
@@ -1133,7 +1159,19 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 		return 0;
 	}
 
+	if (rez->type != ACPI_TYPE_PACKAGE ||
+	    rez->package.count > info->phys_channels) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
 	for (i = 0; i < rez->package.count; i++) {
+		if (rez->package.elements[i].type != ACPI_TYPE_INTEGER ||
+		    rez->package.elements[i].integer.value > U32_MAX) {
+			ret = -EINVAL;
+			goto out_free;
+		}
+
 		idx = i;
 		info->shunts[idx] = rez->package.elements[i].integer.value;
 		info->active_channels[idx] = (info->shunts[idx] != 0);
@@ -1145,6 +1183,12 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 	if (!rez)
 		return -EINVAL;
 
+	if (rez->type != ACPI_TYPE_PACKAGE || rez->package.count < 1 ||
+	    rez->package.elements[0].type != ACPI_TYPE_INTEGER) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
 	bi_dir_mask = rez->package.elements[0].integer.value;
 	info->bi_dir[0] = ((bi_dir_mask & (1 << 3)) | (bi_dir_mask & (1 << 7))) != 0;
 	info->bi_dir[1] = ((bi_dir_mask & (1 << 2)) | (bi_dir_mask & (1 << 6))) != 0;
@@ -1157,11 +1201,21 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 	if (!rez)
 		return -EINVAL;
 
+	if (rez->type != ACPI_TYPE_PACKAGE || rez->package.count < 1 ||
+	    rez->package.elements[0].type != ACPI_TYPE_INTEGER) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
 	info->sample_rate_value = rez->package.elements[0].integer.value;
 
 	ACPI_FREE(rez);
 
 	return 0;
+
+out_free:
+	ACPI_FREE(rez);
+	return ret;
 }
 
 static int pac1934_fw_parse_channel_config(struct i2c_client *client,
-- 
2.34.1

