Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.194.254.142
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795141371;
	b=Uu8V3Rfsc51crDhkC8/iLt5Xjho6uYgAUMo4rgSLnQcOpL1K+E+/g83hAvvLj2LxkFCI
	 UYte/XWrn/9RHuRDUGbyXpJOoIBdGYB28KPOxkVX/OOgUcUpMDRaeJTdRNKxzC3ZC73hl
	 dUjpY6Xwf9b/xi3DrCF8mnMgjxgmE610ziOasOmrV9nMA4NOUjtrHlqS6D5qPAFIxA1Ym
	 U6cDj0cgCBZ3O+s4lOo7zjQGaulEeNHcS8WAIGhVooJKZurJL6RQP/5lE0HSmXOjw4p42
	 F2LrgZn4XV+A4nMo8cksAqoye5azU2WEUf8s1i0bs89jB/8hBYdOuvtMUQqfNNtIRzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795141371;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-QQ-SENDSIZE:
	 Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=P/zNpLrTOtmqClHIZAY0EmFG09sH9ouzQujH5k/amEU=;
	b=SHlwrGM5Ac9Qz+kmehDD4oKC26ZDcmFyHWjpcZYQYEe2luGZkbaaBhXbbxmK/8GEQLK9
	 XFVaNMw9sJUeexdcZKqpHmmdgA5viDa+gcF1k6GREdtyxBiD6VGkb+TVBE/qKTaqGq39p
	 uPTeOAFUHHRoafWDFqZACeT2aKQbrV5GHGxo9yIq7kIQLV8oc946raCLRcW7e1WjFpmiw
	 g6EhkyZbT4EcSwVKquDc+/KbxOWTZ5BjSkCvJAcvGrJHT8Kgt86UL59nZ9G/BRCHRLYRg
	 9k/gIM6HAFhrEdJz9AtXBfAvoJ3W3meD/ytY/E6MAVu7QVE4L2r6TPQiRPxC+a7CzJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=biun9u4T;
	arc=none smtp.remote-ip=18.194.254.142
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC325606A320;
	Fri, 20 Nov 2026 02:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC325606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=biun9u4T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1795141322;
	bh=P/zNpLrTOtmqClHIZAY0EmFG09sH9ouzQujH5k/amEU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=biun9u4TpZBxqQaWDNaRirtsSw7ZCcB+aRJTHblGXgEs9P7furWCzAZXvOgkB7Enc
	 dM0Cx/NVh4pPbZZ3jCXf/VfOLh8kUB38paTxpjWGtZ2neQCoINgRMF39qO+J16LJ56
	 NW1dI00SjDNGNpLvnNFjHJBCfOtPmzbX20aqaIeg=
X-QQ-mid: esmtpgz12t1795141319t66f213b8
X-QQ-Originating-IP: S0xQKMI+sohAVTutLx6QGaJ+/8gwQwIR5AE13eyHWQM=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 20 Nov 2026 10:21:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3208655575677083449
From: Siqi Chen <chensiqi@uniontech.com>
To: jagathjog1996@gmail.com,
	jic23@kernel.org
Cc: crofts@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: imu: bmi323: check i2c_transfer() return value
Date: Fri, 20 Nov 2026 10:21:43 +0800
Message-Id: <20261120022143.4065982-1-chensiqi@uniontech.com>
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
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NLPsVJklzyEpHrDK7k56IKwNuWaN1KtsiMuiEmsFtXpcB74jwc35MtQk
	Svo2a50Td01kFvjPK/QdxSR744bhFnU4cfdC5Lx4d1+2CzuGWDAzAolbbHqXQT56hq75WAW
	224DcKGSxcj6wSpWvoD9jApQOUFi5Ldk9FyjGLaAbTqL3LeG1VJa9s/ZehxaMV7Jr4DcqQN
	EKZ/TChk3T/7X1JlXalbP5ThCsdSZz/mneTvsPqOKps4+MNCFsy4Hob2VMuOXfyLsRaZWbv
	pXiExc/b8jkmZ78rGpsSBZ0BBIAVl+fN+sAcKHeJribUcI6QgRzOlC50dvwLINdt7qS1VKK
	kzP9LfDMM8WJuSOni6rtBCBI9Rrku5IZ7Y+24qH4VgcLX3n/eprUMl2P+7OXmen0Pc+ksgE
	q8Jz+A+loknB70SNij+yDWzSxgA6ifuZF+vIQ6VLpwQG8+6/+VIyrMGTdBaeOtRiLW1oHye
	oeUyvRumRe9MW8vhHY4GxXeJitRMoY9ddm6RNDsXNmm9gUKwqpDhHKhEyfYQv1brCYOWSOM
	wJoe4HMRbovCourIzOAoydyJRYu0T/rxN4lB6OjVdx+H0CTUeoGc9IdsLaTet/uhNZHiEa4
	KD6+Mci/JVaAjhbyRcMjesp/JETU0OvtFvHzzN3YBtH6tyLnMvC8ndQU5MduceX+l8l1m5C
	zHmzfANcqgeW8coeacKnZNR1qBzp2rfIoWrRpdiuw48Ybir2JG4Xi1VtqNwbgOAgY7YtuL7
	rpSg4Nr4TLLSjJxgF6TYd5GRSZ8/1gT9Yv8PS9qTbcNp6yD4O1dEHgQebShJEb8necfUylZ
	dbVf/zimylgWjzsoaL8EPPU4PvMfV3faox3jAsK4lWAcqpSdu6dLQ2ZkKDR0j2ZGd+QOfUm
	IrGopYQ/1WhTmMwXFMk70H7gmBe/0mzRPjG5PSX6ErzPYu4iY47IC6V4T7CBmXClX8HsFff
	ktuf2BLhV9AzZ1b4JTR+gxJ/YjLEjXJCrqXbrUez5tRu9UDV4hJeX2OgQzFqLAjoTGhLcHd
	IvalVmoczAqv4yzYTovJal0B+LZ221/URtQu+jWTAmDU7TuB4OfyHTMvqpgzpbyIcNkVTTq
	A==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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

Fixes: 8a636db3aa57 ("iio: imu: Add driver for BMI323 IMU")
Signed-off-by: Siqi Chen <chensiqi@uniontech.com>
---
Changes in v2:
- Split the transfer error and short-transfer checks for readability.
- Move testing information below the separator.

Compile-tested with CONFIG_BMI323_I2C=m using:

  make O=/tmp/opencode/linux-build-bmi323 W=1 \
       drivers/iio/imu/bmi323/bmi323_i2c.o

No hardware or I2C fault-injection testing was performed.

Link to v1:
https://lore.kernel.org/r/20261119070837.3844364-1-chensiqi@uniontech.com

 drivers/iio/imu/bmi323/bmi323_i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/imu/bmi323/bmi323_i2c.c b/drivers/iio/imu/bmi323/bmi323_i2c.c
index e025c88c30b4..27eddd1346d0 100644
--- a/drivers/iio/imu/bmi323/bmi323_i2c.c
+++ b/drivers/iio/imu/bmi323/bmi323_i2c.c
@@ -41,6 +41,8 @@ static int bmi323_regmap_i2c_read(void *context, const void *reg_buf,
 
 	ret = i2c_transfer(priv->i2c->adapter, msgs, ARRAY_SIZE(msgs));
 	if (ret < 0)
+		return ret;
+	if (ret != ARRAY_SIZE(msgs))
 		return -EIO;
 
 	memcpy(val_buf, priv->i2c_rx_buffer + BMI323_I2C_DUMMY, val_size);

base-commit: c1b99c6982dccade0199879966a2d97f27a0a110
-- 
2.20.1
