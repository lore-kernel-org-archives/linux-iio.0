Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A830389119
	for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 07:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773300458; cv=none; b=joFeRtMsn7ifPn0Z/mb9sBElWtwWUjAnkX4D64nutXzebrCmw7Rm0L3uI8ATVQQghsm4KwIplqYdWMDo32NBhWW4lmr0yMnNIb/Q31Qo1WVF67oeDYabxNg4JEFycukwcZ4a9XYtCZZOQlfc8YKmOwmpMvTlGKmGYcGNvBvmXqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773300458; c=relaxed/simple;
	bh=j7n+jTRsgur+aqLMBnVbTk7FX3PKXhTxx8CVcD0FAUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=idZbOYc0gKJqQLeSpH2BfJor4Eppmfw8BkiSlcq1DQF2At+ixekxN8k3EoDP3wop9t5BV2Vu2v9v8wMVRY+bk+9bCCdnvOxrMFqz6uI8e5N6zl73VxIVroTqMG4QDCob2PaX3J7N1UVr92n0RLf8QrP6Xi3hyUWjF08wo82upgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5Bx5JWk; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5Bx5JWk"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439acc60f9dso92068f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 00:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773300453; x=1773905253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pYAdKLTdz353LmLCDsPjRxQCXN2D9mbnuWbC6g0T4Zc=;
        b=f5Bx5JWkJpKyChkM+Un3PYSjAZf3b8Wadll0o2fFdY1VQTuipAhT7sFL4msDQnm0wT
         mACMoXti3EN3EUd0WinKg9x6GljOzL9NkYJxpPwFDmePLF9xBmmgUuAlLeBPxqRQyI/G
         n+u+NtXzVc7sVFB4McaNyen+ty4t38Uiw24asmx1Uw4s+NUOSn9Vxuclw7LftrhR8hUW
         +7xywmJ99gXmXspHQWapLt6e3WJ353n7cwFqS3VWTeHdMOll1CwmswCZxDCcaBtRrcFu
         0mIecwnjfRSvIuPV1Hdky+GCnIWc0RQvfsdaqpZTJssRGb0VIKYKlfhwW9tkDBIDIDZt
         Wk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773300453; x=1773905253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYAdKLTdz353LmLCDsPjRxQCXN2D9mbnuWbC6g0T4Zc=;
        b=OziBJURgoMjx0oIrwFk/Ll33texhK3WAkr9Lgitf0EgfNqf8fYEXsDQyMJuJfnAtL+
         kMFaHEGPJ/WgepXTs3aBEpZBz8DV8b29dKIn1VlFowN18stiUurYVTXDwBXlNw2q/w8C
         56WtCqwTwDarWH8RJ2k6jMYYdXPhbPkN5DZcv98FNqtN2gugTtvMju/zetCWLRBsflfl
         0DWZGVOeh4Cd9soyz8dxbhkjM2ZQVNvktxsP/L5nVmu4of6oJDfvJEhVgfeQBPJsFix+
         mU/vuamr+8ncViUSa4MafaRRU9Dpk5iwadp6RhGNYMuseXyG/6WgSbp7A0hPkhQXD0iF
         UCpA==
X-Forwarded-Encrypted: i=1; AJvYcCXDHufeSQAy4nejrQePMUWJfbbnqGvZ8z6oa+k0Y2SeDH0I2LL8nGafnZFJNKXQeJcTXqpk5rQv8ZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNh3umWGybaLIhLWHURSz409p8F/tvtp1w7Kt9h6XpkicbEHnG
	VeZfZCir7B1uRTdJaXIzUiYgot7WazjYlyv9GkcLJqzQM96PG6UnFCjczzCZlHFW
X-Gm-Gg: ATEYQzyLCR0sS+kfluCblWv28uwrXNay7irHi+U5al9uVN0oYUoyRsKQdx/FA/XERa9
	Ux7kRPzH6jk4fAjGFg4RCm4e/RGc82UIRGhTKNVp/oljxqMQlJ4aYDA0v8cttEqjwGOmLHzLlIu
	q47MySDTxS0zsRbpRaSN8P401OOS/pGMhl5nW8QMECrei9QPiP76uNY8o0t/U7LOyhws+kKEEt8
	zhWIYE/koNnMilQBuMBizgy6Knz7AiCsWF6A7xLfjnkpiPPYV+53NPfPtUMVG7CoQAD0P8mCUlO
	cF6Ij3TJTvNZSGxxJsgec9u6UTuH0W9OPm1OOr0Lno8TtKWMLjZfQHHzDywENkFOX/T34m6Yiq3
	3GnyQPRtqMG/s9+LbdpQnCq//pAxbnjlbhpre/4ZHcJmlpbSmgbh5TQkK8R8bJiTKePAQqO4S4m
	+23rcOV8IiJqSC/ZVUlIoki63U3nh/ATPf7r3aATI1cH+ZuxCOIwodKL6x+/+qDw7XfLYHivXIr
	NutRsVlz8IuZdWznSF5XfSN2ZerO1QcMdG4zXLiJrNLX2/+1n0U
X-Received: by 2002:adf:f785:0:b0:439:fbf7:dc7 with SMTP id ffacd0b85a97d-439fbf70e13mr3118362f8f.5.1773300452977;
        Thu, 12 Mar 2026 00:27:32 -0700 (PDT)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe2187aasm5295049f8f.30.2026.03.12.00.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 00:27:32 -0700 (PDT)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: antoniu.miclaus@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Subject: [PATCH] iio: adc: ad7793: Format block comments
Date: Thu, 12 Mar 2026 11:26:04 +0400
Message-ID: <20260312072603.38478-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the trailing "*/" of multi-line block comments to a separate
line to comply with the kernel comment style.

This fixes checkpatch warnings:

"WARNING: Block comments use a trailing */ on a separate line"

No functional change.

Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
---
 drivers/iio/adc/ad7793.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index 8ff7b70d6632..c56c43468db6 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -35,9 +35,11 @@
 #define AD7793_REG_ID		4 /* ID Register	     (RO, 8-bit) */
 #define AD7793_REG_IO		5 /* IO Register	     (RO, 8-bit) */
 #define AD7793_REG_OFFSET	6 /* Offset Register	     (RW, 16-bit
-				   * (AD7792)/24-bit (AD7793)) */
+				   * (AD7792)/24-bit (AD7793))
+				   */
 #define AD7793_REG_FULLSALE	7 /* Full-Scale Register
-				   * (RW, 16-bit (AD7792)/24-bit (AD7793)) */
+				   * (RW, 16-bit (AD7792)/24-bit (AD7793))
+				   */
 
 /* Communications Register Bit Designations (AD7793_REG_COMM) */
 #define AD7793_COMM_WEN		(1 << 7) /* Write Enable */
@@ -69,15 +71,18 @@
 #define AD7793_MODE_CAL_SYS_FULL	7 /* System Full-Scale Calibration */
 
 #define AD7793_CLK_INT		0 /* Internal 64 kHz Clock not
-				   * available at the CLK pin */
+				   * available at the CLK pin
+				   */
 #define AD7793_CLK_INT_CO	1 /* Internal 64 kHz Clock available
-				   * at the CLK pin */
+				   * at the CLK pin
+				   */
 #define AD7793_CLK_EXT		2 /* External 64 kHz Clock */
 #define AD7793_CLK_EXT_DIV2	3 /* External Clock divided by 2 */
 
 /* Configuration Register Bit Designations (AD7793_REG_CONF) */
 #define AD7793_CONF_VBIAS(x)	(((x) & 0x3) << 14) /* Bias Voltage
-						     * Generator Enable */
+						     * Generator Enable
+						     */
 #define AD7793_CONF_BO_EN	(1 << 13) /* Burnout Current Enable */
 #define AD7793_CONF_UNIPOLAR	(1 << 12) /* Unipolar/Bipolar Enable */
 #define AD7793_CONF_BOOST	(1 << 11) /* Boost Enable */
@@ -113,13 +118,17 @@
 
 /* IO (Excitation Current Sources) Register Bit Designations (AD7793_REG_IO) */
 #define AD7793_IO_IEXC1_IOUT1_IEXC2_IOUT2	0 /* IEXC1 connect to IOUT1,
-						   * IEXC2 connect to IOUT2 */
+						   * IEXC2 connect to IOUT2
+						   */
 #define AD7793_IO_IEXC1_IOUT2_IEXC2_IOUT1	1 /* IEXC1 connect to IOUT2,
-						   * IEXC2 connect to IOUT1 */
+						   * IEXC2 connect to IOUT1
+						   */
 #define AD7793_IO_IEXC1_IEXC2_IOUT1		2 /* Both current sources
-						   * IEXC1,2 connect to IOUT1 */
+						   * IEXC1,2 connect to IOUT1
+						   */
 #define AD7793_IO_IEXC1_IEXC2_IOUT2		3 /* Both current sources
-						   * IEXC1,2 connect to IOUT2 */
+						   * IEXC1,2 connect to IOUT2
+						   */
 
 #define AD7793_IO_IXCEN_10uA	(1 << 0) /* Excitation Current 10uA */
 #define AD7793_IO_IXCEN_210uA	(2 << 0) /* Excitation Current 210uA */
-- 
2.52.0

