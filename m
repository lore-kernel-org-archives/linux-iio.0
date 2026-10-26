Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013849;
	b=jRLEYD+M2o2c7Vfw/i8JumJ6xXEM2GoBeC4qYq3DE8an4sJpwe49Jde6b/mzms5I9mEP
	 k9IChLaKTCUgF+XOZA/JlyGNaxQU6k80peCrQ9mcdmKqoQJ3It9F07nHQiUwyi76VCgVA
	 4tuxvnru8W5yc+iP5/f6BvXP3MJBEHMlT6FbvKwRu2rY1Q655nvAgXU0RVbhqsA3QAYp/
	 XPU/Dd2MfNO/oBowWdEt96CXTaWFwt6a7JmIFvGafxmRTSzqgmG2OKHaG3usTVRICocXk
	 B8YoLz9X4xXcMlnQXPz3NCKLT5HSrslJh69ylylBsTDr7+qXqrhjjJOoUK9pYRWviWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3ZCcLPkE02vSHMXBIPmyiMf940q2ub6k3rkDQkOeqZ8=;
	b=CpK2z2HSmCJjrfmBQTaOtRxMgLiFpXEK6ifPwD1/5PlCng4AVAzAAH2QZOxkFQMoXb2Z
	 sc+Igc/9p4vQdTzFbKqCl69jIi1MTvDtv3oB6d984WKyMdzpPGYbBOKK3BPwY1hwqup7d
	 Fd0HA8Vk0QeIia2yIv82FKTXqm7X5/SnGPml1y6ZzqtA/GsYwVHevTzROterpRWYdZ0Bf
	 RHdY1gRpC8BW0ACw9tN39VbLn9XVYg+zBNyJ8tDz3sNUcZUgR2Uyn7+1P5piYhqBs5y8T
	 mMI9+HDgDqzq1q/I9Pg0P/rY5xCGN+n2BB7Dwo0v7lDX5rucsNVbUmPP5iafeEJliPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F72iXN0y;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F99606A32E
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 11:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60F99606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F72iXN0y
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso5438793eec.0
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 04:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793013848; x=1793618648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3ZCcLPkE02vSHMXBIPmyiMf940q2ub6k3rkDQkOeqZ8=;
        b=F72iXN0yFRLfPRlWjDxgJAnIr+m4n4vU9Ami7ER6qVccNBMPnt0tI1KoumsYSUNtFz
         UVnSiZSpDeHiQVyIftRIcnmHvseXQp4b+Tal5CGYSdte/q6zA6HU0r7P1h4C6LJ5D4Je
         lOYuUW+9bukg9iiZSdo0jmUgsuV0cRgVTvdG/pE19g7ayogYl6/BD9n8+4NJFbh3rl5C
         /aApeAWwu6s7I0hQhu/gtXLKyx/Jk9rySop6l2LubCNK/Ma5AQxuxymS1FRYj12HU6w7
         DN91M52Rg4CekbYmz0VoHzOF6g7+8k6guGZ3ySKB+K60c0NRfjcznFjrCLW4zO0YuAaH
         hTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793013848; x=1793618648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3ZCcLPkE02vSHMXBIPmyiMf940q2ub6k3rkDQkOeqZ8=;
        b=SWV6J/OwCd6e3BKTXc3OJqgK5VXaJNocbmWtx1EfjEwPJmnlS2DP1c1TrLjH+VyFs4
         UpGU3gMLUmg1nDV822bRUWvsCeFkWs8zlCAl2oj2yHcio3aZ17yx3gCFDVIiK9IrmsDw
         7opiuctckjf1zbJmCY0d4Oyau6baGP+2SL/yu5HWXpzbWVyCweMvq+o/BNqdjj/HoCtE
         gk4cJTkbaByITz+Sym3XDvF1CYkewn+canE0Bq7QbImLgaW5ZSeLSPVnrREX+yl1N/xO
         iTOFiq2egxxjHxIsIATJh5nm8w0SmShMo+XNzuvdMwWvI3I/6SxgEtRZEAcOTTBhaxl1
         CXdw==
X-Forwarded-Encrypted: i=1; AKwUvBzMV7VTAgQ2okU3BXstEe8Lwntrss2dXd0dhi1u2GGEaxSMDMFxRLwt07cgXi/n6yCXbMfWCXlg2QA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIFDqE6cAf9kZtnrgq/APbr9/ZCuf+ihMfoNJg4X1odJrscZWJo
	0gu+001MWxs8dF7W5mvzo8XzkQsb7uhx2AZhUW7hz4meZHO4k+dUhC3f
X-Gm-Gg: AYBFou2Lc6gOcq4uBZ/RpXPnDJXUq2x4dWp2XnY+DDT94G8p6vjW5+Sj+m3GcXS7bnF
	AEPeANIWbGOyuzHOAGpIqX9s8LxrDS1DW3JtdmjIyxoxz3x4BtzrfHR8ydyHZ2xCiq3/OysZRqS
	bnqm/9N7KXTiJrNz3NOZm3Dm1JakG69ESXptYFoijse8XkLLfrElDnUzEJY2r12DCOH/OW6ZJKE
	fGVHvstTyjJT2B6oBvMV6kuuRFGcrfERkDkVjmVErVHujrq9Ly/fGZshYFAdLpyLWeOvlQ7/VAo
	rNIYgbJQ8oFz/mBmVhxvN8wkyevF2MQK7ru2plbDhyQMKc55SQNhSYtiIwmzi7UvI+ETEeG4r14
	2gd2uLwx7YOTfwDpzRxgmEL9agMm/vwjDZzBSZ5k42nZj+FtHreHrU5hZ1G/Lxo44l5AtaXwPIh
	yjALLqKbUZgxyCvyf2Fl1+mhgdY08TqxlF0MeBEyINMypHFxqFCI2nxHiXukmZODW8Zk38rs5Ol
	xLLFVSem97stMzWleTQcDzHowRZEVBKbv7U/U1w9ho44pJLpsIirWf7is6bOPUMhx9jQlV7S88K
	s+t37BeXwuTg6JjrqXh4KtLJtnn1JUxwCjvKx9U2cqwoswI8L/TWa/MFN1XRp78Mdk0CzqyC5EQ
	uNOqILVOhxzQ=
X-Received: by 2002:a05:693c:6016:b0:369:f5f6:36a7 with SMTP id 5a478bee46e88-369f5f63c1emr5941419eec.16.1793013847987;
        Mon, 26 Oct 2026 04:24:07 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a064510b0sm6599989eec.2.2026.10.26.04.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:24:07 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v2 2/3] iio: proximity: sx9324: keep the IRQ balanced across suspend and resume
Date: Mon, 26 Oct 2026 16:53:05 +0530
Message-ID: <20261026112342.65917-3-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026112342.65917-1-kapoorarnav43@gmail.com>
References: <20261026112342.65917-1-kapoorarnav43@gmail.com>
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

sx9324_suspend() disables the interrupt first and returns with it still
disabled if a register access fails. Resume isn't called after a failed
suspend, so the interrupt is never enabled again. sx9324_resume() also
returns without enabling it on error. Without an interrupt line,
client->irq is 0 and both callbacks act on IRQ 0, which the driver
doesn't own.

Disable the interrupt only once the device is asleep, always enable it
in resume, and skip both when there is no interrupt.

Fixes: 4c18a890dff8 ("iio:proximity:sx9324: Add SX9324 support")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx9324.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 255a36976ac4..ced415747a98 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -1088,8 +1088,6 @@ static int sx9324_suspend(struct device *dev)
 	unsigned int regval;
 	int ret;
 
-	disable_irq_nosync(data->client->irq);
-
 	guard(mutex)(&data->mutex);
 	ret = regmap_read(data->regmap, SX9324_REG_GNRL_CTRL1, &regval);
 	if (ret < 0)
@@ -1100,23 +1098,32 @@ static int sx9324_suspend(struct device *dev)
 
 
 	/* Disable all phases, send the device to sleep. */
-	return regmap_write(data->regmap, SX9324_REG_GNRL_CTRL1, 0);
+	ret = regmap_write(data->regmap, SX9324_REG_GNRL_CTRL1, 0);
+	if (ret)
+		return ret;
+
+	/* Only once nothing can fail, as resume isn't called on failure. */
+	if (data->client->irq)
+		disable_irq_nosync(data->client->irq);
+
+	return 0;
 }
 
 static int sx9324_resume(struct device *dev)
 {
 	struct sx_common_data *data = iio_priv(dev_get_drvdata(dev));
+	int ret;
 
-	scoped_guard(mutex, &data->mutex) {
-		int ret = regmap_write(data->regmap, SX9324_REG_GNRL_CTRL1,
-				       data->suspend_ctrl |
-				       SX9324_REG_GNRL_CTRL1_PAUSECTRL);
-		if (ret)
-			return ret;
-	}
+	scoped_guard(mutex, &data->mutex)
+		ret = regmap_write(data->regmap, SX9324_REG_GNRL_CTRL1,
+				   data->suspend_ctrl |
+				   SX9324_REG_GNRL_CTRL1_PAUSECTRL);
 
-	enable_irq(data->client->irq);
-	return 0;
+	/* Balance the suspend even if the device couldn't be woken up. */
+	if (data->client->irq)
+		enable_irq(data->client->irq);
+
+	return ret;
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(sx9324_pm_ops, sx9324_suspend, sx9324_resume);
-- 
2.53.0

