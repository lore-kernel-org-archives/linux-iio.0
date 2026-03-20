Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E333DF00E
	for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 16:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025153; cv=none; b=Hx5+QSZLz69ReRoHBOPtP8sBGMnAF6U8XPmtEAa02R/AfqmGAL0F/OttgvDl0wQyJq5luGKJs9pKsWhT+bVzwkUdG0Ec8BScduy3uuLUKvGBSiFrhbMi026WVTyfg/MsKVLCvNmoT1VK+67gDdlN3pwr3peaX6QXuYKvntcTMq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025153; c=relaxed/simple;
	bh=F8JhpNRtISwTJCZ0mFH9huui70rVNKoYVUHt0NiS600=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JkhAFKiV4OL8l9FYIU6v0l6wqLITmuNS+t3sTVSMK3jdSJMf3wwSiPRkIqNzwotX94aE373duYuf51GqqtPrpv6SRF5JnmFIS8lTbbxbMk0w45hYlQJheKQgWJ0W5h1oVlK3DqoLXPksr1XtHen1romORDIce95Q9XsKuuy9VjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+nEe1f3; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+nEe1f3"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b97ed4ad579so143650666b.3
        for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 09:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774025150; x=1774629950; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NwqEwLydPXTJh37lAhGuKLAvUQ1T9VTG2r0Fov0v/5k=;
        b=f+nEe1f3ErO1LIWPXRYEoiq23dPDAGj4OPXPaRSy7c38rdcD8XFurp84DcTYUvdloL
         Et0OqPT64yw6/cOsj/sMQPA8Pg6iRH3aq5HY0IKgfq/ej8H/MnO0/tohbPTv0wPB+mN7
         VHqap9T9fg/+M/Ei3HVkQkaazhYjoliXSEZrAbKisba9cCt5C53jmKcYYKKegIEHFzZZ
         lHJVmF9SmUzTLNWNdtrgCN13loIaTPcbi30Kz7kv6a+LE+DmOFaZ+wtTfAN2xC3VB3mW
         c/1O9iKPgeFeGEyZyY9LxLZkKT4Dqiphm5fzGSwIPVkS0LlHkUE3IMmJuTaS0cxFnIqs
         qv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774025150; x=1774629950;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NwqEwLydPXTJh37lAhGuKLAvUQ1T9VTG2r0Fov0v/5k=;
        b=K5X1YeIFVt2QTJbN/2dJ5hnaqD6+BgPtQ+Xd5UCQdpoD9aH8jz5I4RWXUw4FV4q6Xz
         FPOLLzTr3eoojNfgTwnRs23jx4pX+esi+w8z1MqNX3TlgMS7RfmpOeeUDmKynRFYm648
         dQ4wuUKZ/fknbnnebJmg1+0o6fi2DFL+6p8WsujrmMCAlNVO9nFTWKI6oJR2kuRq0L74
         VZlgmZUB+qDdoj7LS6AnZ4ZdeD/EnNjhRTprbE/urmpVL1lSgtThhvXzA5M7OH9ecZpw
         rmW3mBX67A+lCdeHwxSDlpkabCDPAIewcqDc4SYfpXAb35tn1wrDjAmTdXJLAexk/MPq
         qfZA==
X-Gm-Message-State: AOJu0YxS2vNzefStMsfgmvvAfrN2K8QIsyZYs/k/5B2BB8jVEKJn7E0Z
	jkOTSat99JkkRWO727mAyf2r63syoMINXdVScNY1Vq+i9Vm5mLD1PMVv
X-Gm-Gg: ATEYQzxK9D38KGc1kG+pJjCPqRS4aaZu0A79o4mRZJdJWW189JOWqPwsnRlnQhNOpD7
	A2GH9rA1GcvxsfzWgW9OQ2BtatjaXUcvnkeUYKq6d7Dg/+yCHXE+DFErCEsdqyEl60AB/pkauuJ
	9vQlUwzCo/e4ZjpWC88ZgW857sWr6nnUqO4O8+GU2PDRH2wt540RnLoiLBeQvCjsu/ldkU+NoTx
	kg/YETIXEblmy5+JnqAuPX7DUtvI8Rv+VViU/ZDfouGXj0FbqaTAbuBjeUf+/auR3VJ4hyy2CRa
	2yxNI+rLpcfY58HZR+e5/84lDNj6ZtKTYpppT2lLp1PTDhaTngKZljWSBxFB76Nhb6GSskYOCaJ
	nvADk3WaPEK//rNsfh25CVNY752uQpGUdLFZmqN/FkoFxJaCuAPdR6oKzPFUiXD45D6P7IuAkMO
	JSdUxeaXzgcnXil3ZMhQwzzBZV2JbHMSgZ9xa1
X-Received: by 2002:a17:906:4107:b0:b98:baf:638e with SMTP id a640c23a62f3a-b982f220a6emr206784666b.13.1774025149534;
        Fri, 20 Mar 2026 09:45:49 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b98335f1747sm176730466b.33.2026.03.20.09.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 09:45:49 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Fri, 20 Mar 2026 18:45:40 +0200
Subject: [PATCH v6 5/8] iio: light: vcnl4000: remove error messages for
 trigger and irq
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-vcnl4000-regulators-v6-5-0d24d20b1a5b@gmail.com>
References: <20260320-vcnl4000-regulators-v6-0-0d24d20b1a5b@gmail.com>
In-Reply-To: <20260320-vcnl4000-regulators-v6-0-0d24d20b1a5b@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.14.3

The error code is available in the log after return. In our case,
attaching a triggered buffer can only fail if we are out of memory, as
no other buffer is being attached. Remove duplicate error messages to
reduce noise in dmesg.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index cd7e6ee42cc5..76aee16d479b 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -2033,11 +2033,8 @@ static int vcnl4000_probe(struct i2c_client *client)
 						      NULL,
 						      data->chip_spec->trig_buffer_func,
 						      data->chip_spec->buffer_setup_ops);
-		if (ret < 0) {
-			dev_err(&client->dev,
-				"unable to setup iio triggered buffer\n");
+		if (ret < 0)
 			return ret;
-		}
 	}
 
 	if (client->irq && data->chip_spec->irq_thread) {
@@ -2047,10 +2044,8 @@ static int vcnl4000_probe(struct i2c_client *client)
 						IRQF_ONESHOT,
 						"vcnl4000_irq",
 						indio_dev);
-		if (ret < 0) {
-			dev_err(&client->dev, "irq request failed\n");
+		if (ret < 0)
 			return ret;
-		}
 
 		ret = vcnl4010_probe_trigger(indio_dev);
 		if (ret < 0)

-- 
2.53.0

