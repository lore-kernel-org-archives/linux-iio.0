Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.254.200.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706149;
	b=VCCVXw5TCRTOS6vAvkzDDjGkkhZkMhe5yU7qCcXdr9NpJ3GR7xCdKhSUi3VL1X97xvpG
	 3Vaelo/y/3I4s+6W2S8ffv6I7gGfBthDDSF2KV0I3zQXlEzUTrlX7CFfbazqU+5pkha0f
	 IfsHJxaRQDtsXdOA/OuiFgZKopbvTiV1oM9KRmjeojJVpi1KbsnxifV4us4u99UI+uZUU
	 y+SaUTQkeNKlDrVpH3DbBR3JZqPQQN/ipDI+Jm1ccISplE3bngkKGEuaICO6M8bJItZwx
	 YfaecdtEoJ1vPgsp0vb1yi7J3XXQ2tNgoBroyUd0O9yxyVUl/MG3vwNSd3vlShWVgXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706149;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-QQ-SENDSIZE:
	 Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=WDO2rQ1PLfvnShnPFy2s3fQQzkyxV6hKUvybO5qEacA=;
	b=Tw1Wdz7Gxit9hIUQqBFlpJee7IWmVB6Rg1bV3txQFSgJdGbTQYxGOnah/m0w26wsR8/p
	 i6rHr5o8LoEocK6iZdjIHW/VEF3DsuNGrziiIg/3q4yQrdn/+23RQ65r0iUsace6sdOjz
	 cZw6/lnnGtOeKA2aCksheuC7F/p8gXNQ92x/G2UeGxNY66lCkwcWl6zYZCw27Vgso3Ucg
	 QTDvRcSm5aVlC9QfC3WdCmkxO3uBOMOokYG3YgMY5PufYvaXwXAtDAmpRoO6eWCI7nkcX
	 8+4MM0qumZjfbL+zsT1s9nTUyAMDEg/hLRt3khe2evZKPsV/+pTEzOfi1EJ+w+YLjqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smail.nju.edu.cn;
	spf=pass smtp.mailfrom=smail.nju.edu.cn;
	dkim=pass header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=zybtg9R7;
	arc=none smtp.remote-ip=54.254.200.128
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A90B606D81B;
	Tue,  3 Nov 2026 11:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A90B606D81B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=zybtg9R7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1793706113;
	bh=WDO2rQ1PLfvnShnPFy2s3fQQzkyxV6hKUvybO5qEacA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=zybtg9R7F37oDE+StyXV9iZHoTSPGWgTG+E8nYoOguTMrueB/gNj7YW29aTKg7Mgp
	 WZa6IunLjJLIC/pOxx0i35C1z8dJlICykiwKygcb9IRxplXewAmiVk0tW39JHLBcwo
	 M0vT6sNNEvFj5W9PIKTz9Cj9o31eNH8410n6NfoY=
X-QQ-mid: zesmtpip4t1793706108t90f548c1
X-QQ-Originating-IP: gCjtDIGJZ/yFvX1GpugMOJalIHVOkdIo/HzkbdcGPao=
Received: from workstation-Precision-7920-Towe ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Nov 2026 19:41:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18235537241290329803
From: Kang Chen <k.chen@smail.nju.edu.cn>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: imu: inv_mpu6050: validate the CNF0 package
Date: Tue,  3 Nov 2026 19:41:46 +0800
Message-Id: <20261103114146.75881-1-k.chen@smail.nju.edu.cn>
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
X-QQ-XMAILINFO: MSstRF5C1p/jnprOKqA0zHwChnvNCcAgP9oiCO/OTJCDgC9NJQfJ/Ub8
	DdMiL4egYue0T1zsLvHu3QVn94xy44movVyR0WEk5jVmX0a8u7bhjKg5mPH0Bwx3o1ht6sT
	zyZPU36BCniRsqltkUDHAQMgcLT1bSouCyVFuz6JU5I3fkUWVoOCCClOAtBYo+XO9aoBZAO
	mYM7ATgpMSGBZ23sPVQ/amb3Xs5cxagJ3buOZ5o/UjC6c4o9g55+IXQzgUJdW7kbdUPJuXA
	rdc5KxN+dZW+nF2rG3E+lMWzr1fmCdSrDhbnhcZ3sowSYqM7tNPTMh518u4ERk9QyydkM/Y
	gSwYW2kbLfP8qTkikUpCQ3M9rMFhS0upf3ro89ihe1NXqUGhjg5UUyGiW5908JMj50SgHSY
	iT74B+Ehof6XCy5nXen3JN0M1Jf5AIAqgJQjB81viRXLf5JwkHEP16dxvjvn5jHj3OMxzIV
	nYD5xof3xWD4On8fBXEwVJP5XcAhMzO/Y5IkBRMiDxdxiNdGfTb39K1AuemRr9XEL2AY6a2
	54K5DSOGHwYCocqBjj9stfFGgZA8avmKig3xWqwUXcYj2J1bUKfl5Ts5pLMbL+UgAUpvAVi
	4KcdRJZK+6OE17NJITiRRMQp9/mfoEcbej/pcx5ZpANlSKjxf+9j20I/XciSrkogZ1whwN6
	I9gAuNPco8VeTPESwLQpXr8pzgjagAoCkSG5H9R0/M78YdzhlYKGnNMSHiDFwLr7QjP9Qx8
	xCNO9Ukcu7c9kclBnAxkmHUs6Wrz5jUKCrYJ6fPpyhktxOF0NGTZM35LLLzPmhmnzb9jECL
	Iuxa+oCKMsuTfXByLTZ4FgQn+1Rw5C077eaV793kFacHBBGCJmNwnHQXF+VJCV+C5OS8P/C
	wbCk3qooLuBfOol8oX7xoF+BPXpgrerY9XfPjlHn5uMM55ZK7MRei+pL+yLBj/EhpO1cdev
	0QENpibC4fYC0DOCQdJtqSzmz3ExQrbfyTlibgY4ZEVH1/v7VvQl8lXTBsu4j2yR7tMjYam
	SrEnsfZS27zi2g5RPgNGYja4CP9Pv0nO1QNvoFu5RBJVCx0YV3
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

asus_acpi_get_sensor_info() walks the package returned by CNF0 and uses
each element as a package without checking the object type or the
element type.  A top-level string or buffer makes package.count alias
its length and package.elements alias its data pointer.  For a
non-package element, the inner count and elements pointer are taken
from unrelated union members, so the driver can walk a firmware-chosen
pointer and pass it to strscpy().

Require a top-level package and skip elements that are not packages.

Fixes: a35c5d1aa96a ("iio: imu: inv_mpu6050: Create mux clients for ACPI")
Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
index 460792ed27e0..0dc6c042043e 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
@@ -57,11 +57,19 @@ static int asus_acpi_get_sensor_info(struct acpi_device *adev,
 		return -ENODEV;
 
 	cpm = buffer.pointer;
+	if (!cpm || cpm->type != ACPI_TYPE_PACKAGE) {
+		kfree(buffer.pointer);
+		return -ENODEV;
+	}
+
 	for (i = 0; i < cpm->package.count; ++i) {
 		union acpi_object *elem;
 		int j;
 
 		elem = &cpm->package.elements[i];
+		if (elem->type != ACPI_TYPE_PACKAGE)
+			continue;
+
 		for (j = 0; j < elem->package.count; ++j) {
 			union acpi_object *sub_elem;
 
-- 
2.34.1

