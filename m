Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795072262;
	b=rhpuNo195BkWrrCDtMM5QAaJW2/AJsNSFr+lTzWDi0Vgy4HiqP0++T/YkKOch11fQ8Cq
	 QWatdhh58O11xX4auZRV7vlQ7kFWMxAjrzL5lxfMGetQHkTwjZcfFxcX55HEpGxM1omx1
	 Leyx2gpgsEOkymIBbBsBNPq3F/yoO9MX7ecU78Iubm/zrefEkeMliQr+RWeZIJPQz2bAi
	 6FaYc2kIVcv0TRne2gx1WJfj8E3WVart4dILfeYsVk39O7B8baikA+xSVHzmC0mxPkO+A
	 olyCCpaCKsN3tg8qXghI8SppA8n9q+4Pf70E8XWqK4npxHsy0EIGqwyvG7H9GGiosKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072262;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-QQ-SENDSIZE:
	 Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=qNAyhmbrA2C/mQtXbsAKKNgCM08AC8iWT1pCBSPmwfE=;
	b=dpXK29IABIhKq7ttNJZJM5U2GnU/QI79FbgJjeKxnDwPKnbSpFoasKVNK/Y1dq+W8k4M
	 b5B+7htA3ehTwbcfa9QUl1htFk62ZpnIZXsL88731kl/uhX38Ddx1b/pxURlySYddSM49
	 ds08ktHinNmJW6iuWxmQCblZSXvqDRr063pE3CTZwY0If+g/mpqgvGX/GeEkjIciG5GOc
	 Eb7mzGhL9+1CU0oXkR/RRfOOmLAYceNhLKvUPiePSGdWfRdAfR+wF0wHOkv+5lICfVfP4
	 XXr0lM/iUhXerJmSBMe3knKN6NxVayzXwn+FFmL2+YBO4iQ1yRpZ+rmxvvwzVPzjrvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b="fEEFrJU/";
	arc=none smtp.remote-ip=54.204.34.130
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A329F60A2625;
	Thu, 19 Nov 2026 07:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A329F60A2625
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=fEEFrJU/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1795072218;
	bh=qNAyhmbrA2C/mQtXbsAKKNgCM08AC8iWT1pCBSPmwfE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=fEEFrJU/l/pcMH8a5f1MnspVdrEl6Z8HlWOROwDIIaZVSzDo/PHYSjQad/J2+XtYr
	 qWRN2UIaSrZgENC767P4AYBf+4+41NICe5QVTmfPswbzuU3k7Yvp7rSwiAC3zKXaRU
	 1IDROMw37LPQp765mECiw893iodkbTTDzqA4pZPo=
X-QQ-mid: esmtpsz17t1795072215t886513f6
X-QQ-Originating-IP: J+FGUIIPG/VTXSsHRx4PYxKGgL+tOtLP6CcVvMSSs20=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 19 Nov 2026 15:10:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9374642726524579920
From: Siqi Chen <chensiqi@uniontech.com>
To: jagathjog1996@gmail.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: imu: bmi323: check i2c_transfer() return value
Date: Thu, 19 Nov 2026 15:08:37 +0800
Message-Id: <20261119070837.3844364-1-chensiqi@uniontech.com>
X-Mailer: git-send-email 2.20.1
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
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MwP/zDbFYto1pl2k0PiUKTY1pjoFKgznlTde4I9wrN021i+nMesrgtlk
	IYv2WrKXxRMlBwnUMvfPGAzfVOeQ9yKTvSwaYnKsLDDtvshZ7Szq65MbAhGJHv7+KXIp8BQ
	HoPqaBYAWP1cCsxCIps9YreISaiDtnY5sunoG1dNMIkKBng4VG+FEVhZkhs/lhziOrqwBgx
	vbG4WGDQxOdn1h/grInJMJIWDiwD7yJutgniobIjXnZIYx4AipSp0nWwthhXmqMHsMp5UiF
	r5oady6wI/FcHfl1voAAlIobyXRpqsAG5egf5ui5bG4ZDoOYDOlc2ooHFwYCw3+FfscbRY/
	wq0xdTaJNHrh/kI9jBWMqimXDqGP3TReuZjZKZEW7U5MhhLPI8GxHNWBk3+PvIpLaKUETSw
	PIkFOhFsTxGlbeJbrVumq/M6MD38rmoGerZcUCe8W2EGo6lCRK4xQo4+Z12NUPQAzoWx5aa
	Tvk8oYzIDFNxXT4RgKYJ2fKJ58Cdj5EkOKrgdjF65qcN6pGdPSHLVQt6+udAgn0G9yPpSSP
	SsWEM1Z4939oM9i2/jxf2VeGaqHIqDCoH+DG1mG3BR3CYac8nglSnqDf0/w3LAh0fmDFpmI
	S842zLBDG7mdYJHuK5XAYD3qFYRp+jqO15qhtwm22kA47tr0u5mtctFdcDJ4iOSxIE8Rye5
	Qlh0wBg/Ewf7v2exV/k6c3aquf0qw1hHbWlSgApGnzheXS41Z/1U8yVquOUHoUtpDxRkDYz
	Fm5hmgiYP+rcxoNZfPiY1byocnfe5vXz2lUu80zk7JuZTU/2PAcSx3K9x3aB5X0n4I84ihg
	CmPxmnGndqXDAWKP9dSEhG9CELZTQGQsSIHtghRWPRgUMnbt+K/SstkF28h41BnxH0s5xoE
	HzYu9XfCxHF7lkwnTC++tfpSbxBur4X/rROkQr5RvS84UvxhnhcdaMDkJOiuMYbIDG2u0U+
	zi/RxInktE39+raYOuTSNq0gqx7LIria9QFwmB2PQ5UfP5pztrhyJ+WgzHZP/bGc9dEn8A2
	OMYOb3VtNY1d3D+32aR3dadGpoGF2NgbdN/1Z5KvjEMHkhGoNPNj2etmoDAeDAyqjaJiGFj
	g==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

i2c_transfer() returns the number of messages transferred or a negative
error code. The BMI323 I2C read path only checks for negative values and
maps all errors to -EIO.

If only the register-address message is transferred, the function copies
data from the receive buffer and reports success even though the read
message was not completed.

Require both messages to be transferred, preserve negative error codes,
and return -EIO for a short transfer.

OpenCode was used to identify the issue and draft the code and changelog.

Compile-tested with CONFIG_BMI323_I2C=m using:

  make O=/tmp/opencode/linux-build-bmi323 W=1 \
       drivers/iio/imu/bmi323/bmi323_i2c.o

No hardware or I2C fault-injection testing was performed.

Fixes: 8a636db3aa57 ("iio: imu: Add driver for BMI323 IMU")
Signed-off-by: Siqi Chen <chensiqi@uniontech.com>
---
 drivers/iio/imu/bmi323/bmi323_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/bmi323/bmi323_i2c.c b/drivers/iio/imu/bmi323/bmi323_i2c.c
index e025c88c30b4..18f05f119961 100644
--- a/drivers/iio/imu/bmi323/bmi323_i2c.c
+++ b/drivers/iio/imu/bmi323/bmi323_i2c.c
@@ -40,8 +40,8 @@ static int bmi323_regmap_i2c_read(void *context, const void *reg_buf,
 	msgs[1].flags = priv->i2c->flags | I2C_M_RD;
 
 	ret = i2c_transfer(priv->i2c->adapter, msgs, ARRAY_SIZE(msgs));
-	if (ret < 0)
-		return -EIO;
+	if (ret != ARRAY_SIZE(msgs))
+		return ret < 0 ? ret : -EIO;
 
 	memcpy(val_buf, priv->i2c_rx_buffer + BMI323_I2C_DUMMY, val_size);
 

base-commit: c1b99c6982dccade0199879966a2d97f27a0a110
-- 
2.20.1

