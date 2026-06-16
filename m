Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1066C428852
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605598; cv=none; b=eTcb04HQI+ixmbAekINfIP2PlhCB7hx0o+qFvqQQRmE3K1208EUSqZr+MjeRuTgEy+loRaV32tlNnGZ7fJv1BXe0f+EIJHIG2kKTDNhg6Cq3CP1zQ4aOSJejeb2eKkcBMwbj3APTOztYZkUDAa/oVn8bLPTTc5bpKZ7PJzt9FxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605598; c=relaxed/simple;
	bh=YatbobhKKz4ZXJqLFkZi6B5c6FYlSQIo4E6cJZYKIBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nh9lBeI9DaVQgxfrZjCmzEPpQn+9DJcErfNXlhj/exw6AhK7ZQJR/RxEy90WlqEjzKnLHdsIx8FEHRUuA0TXKpyru/TGQCoEEEw1ay/z3B5Ex7O9FaMBu//Yf/aDVo+rq1pnUgpC8aiwwMFlers6AZYtVzKdeQsSRY+A6xrhvls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b60qy7oB; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b60qy7oB"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36ba706ab46so2784162a91.1
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 03:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781605596; x=1782210396; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=563kewyp78EbqXlKbSAb9Qtc/HGBLkQqxRNmW+0iFYY=;
        b=b60qy7oBt0fqNFTRdu3cMWqfrqgpkvc6hQip2zMfbFgqElbwAgfF/LzQgjrrmyWsOk
         sowKrDiCteTMLS73BIxkJM59EqYEl9tvWRcf/G/NrtyKRs4SnSRdG8WBg8GRigimGoka
         azA2eYXzvzWkiUERhkOzZeSUMWiCMiFwWuAeZO1bVNxZ8abF7kkxgCnWYNyxu2TnmRu6
         qxh8NOdGi0ceXELEjlg7aTA1JyBA+r8PdcysE570Lvj0qQjLG68gKlU3IzvJ5g5ztpqA
         cZjk+Aq06MYtxg0/QFD8dsNMGnDpduAWJo4cijfMtjolENautgbLwO1YujSS9a57DGH6
         amoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781605596; x=1782210396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=563kewyp78EbqXlKbSAb9Qtc/HGBLkQqxRNmW+0iFYY=;
        b=oAfjty2RTa1OhUZU+WFXnBtkZsHFyMLXeen+ehvgGIiKQZTHaFicCKr+edCyCEnd6j
         UnVXSnb7NvMSe8FzBnQ/27E0ZqzunYMULYlISCoQ3WcF3zQvIE5ogiNYalCJGrS6LJFK
         vibDgQiDzk3yrFnU8Vg6ebCgZ862ewO2wRphGsiwU+aJR7tWGkug8BLIBhlJQxULJXnM
         qqR0wVSaqUn4JkwAhhTF1PG6gVZnTJzqIghYY+FGyh8zsNHn2GBwwQzie64GpUju1zGd
         u4KzfnV0660+0aee1ur5gfvJ2wIriCsa6KLwkyvfNJ7MRfTbUK1mfHf11Y7MylPakRf+
         +Yfg==
X-Gm-Message-State: AOJu0YxVezHBfw8qWBNK3viw9Oq4GjqV7UOttzP27DRxbs32xACXjQsX
	dby24hd9Nj7xrrRqLvOXwXPAuro1X+AokA2nfCSJrN2FIXzfqzjM4iAS6A8e6w==
X-Gm-Gg: Acq92OFPr8S1MaNB967t3VdygGwMKZ7J0A0nS3nnsyd3wH2wnsxzOFYYFi81biqhM8E
	dhqQO2PXhyL8UcUq8MjY2+8Su53iQscZh1BHcb1pTbI92hYx2OR31Fnt4jB8GFFIGqEwk1YjoVI
	SDJ90z6uLKD8VFFLD83ijUhXJTT20ceLfq5eBSMgmmKOVa4XxVG9bB1Xy+oC8ThS6Q+VWZHt5yj
	C1ovzCgABiNYagxqjMjwRt2Cbsi8n9mmynhG9Pv5A0WgH2N6rR2hJORPInK5COAxvFyuLc2Cn19
	m8xOUHWd1A/98HwzyXtT+sQL8fFWs6MGCIeYJ8bmq4f/0mks/euJWsfSoJtOPKCfY5xUcn0Zshl
	sIym0gCCzK1dsRMcdOq25QsMsE+vV9nsU2klhvZcrCIoowDEJnQBoMZa7XGdUiabi1vrisqR3wW
	uYOioh6f8F/MVKCW2IhLrNdcJHjQRxkKNWsx+AOyBN2f7jGjeY
X-Received: by 2002:a17:90b:258d:b0:369:7421:b36f with SMTP id 98e67ed59e1d1-37c52916561mr2911272a91.21.1781605596401;
        Tue, 16 Jun 2026 03:26:36 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e88d546dsm8079269a91.2.2026.06.16.03.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:26:36 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Tue, 16 Jun 2026 15:56:06 +0530
Subject: [PATCH 01/11] iio: hid-sensors: add missing blank line after
 declarations
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-15-jun-hid-iio-alignment-v1-1-0cd544286575@gmail.com>
References: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
In-Reply-To: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Add a blank line after variable declarations to improve
readability and align with kernel coding style.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
changes in v4:
- Rectify commit message with input from David
---
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 417c4ab8c1b2..c8ccf96f3d03 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -314,7 +314,9 @@ static int __maybe_unused hid_sensor_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct hid_sensor_common *attrb = iio_device_get_drvdata(indio_dev);
+
 	schedule_work(&attrb->work);
+
 	return 0;
 }
 
@@ -322,6 +324,7 @@ static int __maybe_unused hid_sensor_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct hid_sensor_common *attrb = iio_device_get_drvdata(indio_dev);
+
 	return _hid_sensor_power_state(attrb, true);
 }
 

-- 
2.34.1

