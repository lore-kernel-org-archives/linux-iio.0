Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311F8382384
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 16:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776877015; cv=none; b=r9hilEuC/FigKYct78PcEdN3vzHZ89h7ylSdF1/W3W7AO8RjN8UnMv1iQmuVZterioKqjwMypKHQ0W+gBujEwTTi0Vd6HS8/ra3D71jJfIK39ZWSesBWk9r1jPSrZF0+KaUtY9qGB05R3pMNDlrru2A3bhISlOX1sp+pLz4YY4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776877015; c=relaxed/simple;
	bh=2s6lMJnNRX7McdMR9xOP9NNAuG6c7NlV7IsKOLCquf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r/vIzwTxH4WtFW65/eku4zfT8kWt6tMsuOhJcQlmULWRjCKQAX+1Xv2t/eRmhwIAFokg+N1M4/jzUYtWXItHKciKdiabuaMwSLKGGc1yc1sFbXI4K4pkzjFzjJ2o6+5MRjLz3mpqbBpSZiIazaUeugItvoCXNXByqFTPjLzMyeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSIWEHJS; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSIWEHJS"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c736261ee8dso2128430a12.1
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 09:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776877012; x=1777481812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drrRiklWz/CIT2ToxtXvHdj2HR+FSt7bFEX7xEGwwQE=;
        b=fSIWEHJSKv89u+Dq/+OQHbV6GFPHl1R27X5UoH0gxBy/R0PB5BFVgZOWcr9v5GbY4z
         eAzWIAstCjglhpu2raYqewPVmTgIjiKYDCc39HNB2VYiyC9EjlK3pqRqPO1sU4kIAVLx
         zcFNWfHOqNg7DVAmgd/v+NEGNPknqGZfYbJ+9Q0K7+LmEC1f9oJFeoh01+V4EhRgtLA5
         kZsqMbPP1Y5TvM8iVb4hMYTopW/97/bzqII10sb4sRhstSnqC/X1tBe9Q12ylxv+9Twd
         vBR2G/25VeU3FksKhl3/t1SXDFSOc2WC6hjtRZWssMYBsS2N/W/Qa/P4Va8QU03n7uDR
         E3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776877012; x=1777481812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=drrRiklWz/CIT2ToxtXvHdj2HR+FSt7bFEX7xEGwwQE=;
        b=dUnt4CIWPcn6ip+gtujmhFO8z3kyHou9WoXpJMp6vFaRx9jwkJsoc/H0p3sPH/3sVw
         JwL8WDyHk5CIsj+V2K3fpoElQF2yFdlJ5E8J+dYZEX9+vC6/aoH3wmfxltjnir+PMeP7
         fZ8fX70UlEzCHFlAypvECWOp1zFhchArQv5gTEgH8cEF5Hs/Le/YTegSMzPsaXWmmrp9
         UbXK00NUL9p8q+mfWIWeVmv0DzH33j62nKveMca53KScxk5LlMT67KJHPA1aOG6Z6xhU
         NrUxmLRz1/FpcjDe3CiMI6KmLUG8IVapo/rS1mwKqKhb0O9rf9BC3E+XkMZceYh4bkiZ
         8pWQ==
X-Forwarded-Encrypted: i=1; AFNElJ80+nFFddK/Z3NKbHrTY7074bh+1PDIfVJhoLy4V1WkTznZ925Zwz20g4O+UEFe583doIw3MMacOv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUUeZKFn8R1GdmFkPwZwpjxVZxOa6IMAq2+rFK0VTrQ5SZXQHF
	KUhnJ1GnXmcBaM64+IsyHGPG6230H/jzZvPdVjhYXaFM+RrxFhVMM9BR
X-Gm-Gg: AeBDiesjYc43xn7pvwm2qTSmvI/aq70zDi6K0HsHcQJqRLy48QIYBbjihOPda9Btvj9
	/lTDyITTePJ6q1n2X/5C+BRIJBUWaqZbioljLrnW15PJzOw9Tvvzm3+dkZxqLpiid+FWWCrNe75
	9ueU4gobKjayo39yIuNJJMN/9mE938EdbNjqXOmryzD9hsr/6ecIR+zw4xK/nD4pvCrBRYxxiBM
	lz/5T6C6M6IxSlxiWdciMN9EG4JRNHIdy2sWbNyc6Lbi9WWNjef8j9tUeNNyFoCLx42NUeyMNc7
	L9m48auK5xtq8cXr7XLJFu2K49QahwR8tAxh6TbuU2RcRh7LMs2UsclX/l+OdEhm8JrzhOtjaIE
	k/1jmbfMrPhc5ciqzi+9Vz170dkgGcvk43GY7hN3T7S/rLYhU/yA3qOJtnVBcqrRAybr3vZs01N
	a0enfP8Iyew9aaFr1HN31hlYP5ohlj1jAPAC6wLHRFNrCU8FZnZVpNou0ujSg=
X-Received: by 2002:a05:6a20:7285:b0:39f:27ab:2454 with SMTP id adf61e73a8af0-3a08d90d557mr26185501637.49.1776877012485;
        Wed, 22 Apr 2026 09:56:52 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976fa3604sm11908675a12.14.2026.04.22.09.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:56:52 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	sakari.ailus@linux.intel.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] iio: accel: mma8452: cleanup codestyle warning
Date: Wed, 22 Apr 2026 22:26:38 +0530
Message-Id: <20260422165643.2148195-2-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260422165643.2148195-1-sanjayembedded@gmail.com>
References: <20260422165643.2148195-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Reported by checkpatch:
FILE: drivers/iio/accel/mma8452.c

CHECK: Alignment should match open parenthesis

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/accel/mma8452.c | 47 +++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 15172ba2972c..6d9091f696cf 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -704,8 +704,8 @@ static int mma8452_set_hp_filter_frequency(struct mma8452_data *data,
 }
 
 static int __mma8452_write_raw(struct iio_dev *indio_dev,
-			     struct iio_chan_spec const *chan,
-			     int val, int val2, long mask)
+			       struct iio_chan_spec const *chan,
+			       int val, int val2, long mask)
 {
 	struct mma8452_data *data = iio_priv(indio_dev);
 	int i, j, ret;
@@ -786,8 +786,9 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
 }
 
 static int mma8452_get_event_regs(struct mma8452_data *data,
-		const struct iio_chan_spec *chan, enum iio_event_direction dir,
-		const struct mma8452_event_regs **ev_reg)
+				  const struct iio_chan_spec *chan,
+				  enum iio_event_direction dir,
+				  const struct mma8452_event_regs **ev_reg)
 {
 	if (!chan)
 		return -EINVAL;
@@ -816,11 +817,11 @@ static int mma8452_get_event_regs(struct mma8452_data *data,
 }
 
 static int mma8452_read_event_value(struct iio_dev *indio_dev,
-			       const struct iio_chan_spec *chan,
-			       enum iio_event_type type,
-			       enum iio_event_direction dir,
-			       enum iio_event_info info,
-			       int *val, int *val2)
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info,
+				    int *val, int *val2)
 {
 	struct mma8452_data *data = iio_priv(indio_dev);
 	int ret, us, power_mode;
@@ -879,11 +880,11 @@ static int mma8452_read_event_value(struct iio_dev *indio_dev,
 }
 
 static int mma8452_write_event_value(struct iio_dev *indio_dev,
-				const struct iio_chan_spec *chan,
-				enum iio_event_type type,
-				enum iio_event_direction dir,
-				enum iio_event_info info,
-				int val, int val2)
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     enum iio_event_info info,
+				     int val, int val2)
 {
 	struct mma8452_data *data = iio_priv(indio_dev);
 	int ret, reg, steps;
@@ -953,8 +954,7 @@ static int mma8452_read_event_config(struct iio_dev *indio_dev,
 	case IIO_EV_DIR_FALLING:
 		return mma8452_freefall_mode_enabled(data);
 	case IIO_EV_DIR_RISING:
-		ret = i2c_smbus_read_byte_data(data->client,
-				ev_regs->ev_cfg);
+		ret = i2c_smbus_read_byte_data(data->client, ev_regs->ev_cfg);
 		if (ret < 0)
 			return ret;
 
@@ -1191,7 +1191,7 @@ static const struct attribute_group mma8452_event_attribute_group = {
 
 static const struct iio_mount_matrix *
 mma8452_get_mount_matrix(const struct iio_dev *indio_dev,
-			   const struct iio_chan_spec *chan)
+			 const struct iio_chan_spec *chan)
 {
 	struct mma8452_data *data = iio_priv(indio_dev);
 
@@ -1514,8 +1514,9 @@ static int mma8452_reset(struct i2c_client *client)
 	 * The following code will read the reset register, and check whether
 	 * this reset works.
 	 */
-	i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG2,
-					MMA8452_CTRL_REG2_RST);
+	i2c_smbus_write_byte_data(client,
+				  MMA8452_CTRL_REG2,
+				  MMA8452_CTRL_REG2_RST);
 
 	for (i = 0; i < 10; i++) {
 		usleep_range(100, 200);
@@ -1645,8 +1646,8 @@ static int mma8452_probe(struct i2c_client *client)
 			dev_dbg(&client->dev, "using interrupt line INT2\n");
 		} else {
 			ret = i2c_smbus_write_byte_data(client,
-						MMA8452_CTRL_REG5,
-						data->chip_info->all_events);
+							MMA8452_CTRL_REG5,
+							data->chip_info->all_events);
 			if (ret < 0)
 				goto disable_regulators;
 
@@ -1654,8 +1655,8 @@ static int mma8452_probe(struct i2c_client *client)
 		}
 
 		ret = i2c_smbus_write_byte_data(client,
-					MMA8452_CTRL_REG4,
-					data->chip_info->enabled_events);
+						MMA8452_CTRL_REG4,
+						data->chip_info->enabled_events);
 		if (ret < 0)
 			goto disable_regulators;
 
-- 
2.34.1

