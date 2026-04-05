Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F358F30F532
	for <linux-iio@vger.kernel.org>; Sun,  5 Apr 2026 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775405344; cv=none; b=po+A0o2t2MGokRyFenC9/B6HZUyjIRBtkguXZwSBNXtbwZ+bu0/843MboZ28Qsl5THwsSf+jEMdlSEyzVAH1wDxi1QOLrrnX/OGAhE+VTrJcHDWRs6copMTiL/yQCJREHMu9J94kspaQxRqvmPRmrKXoCzP4ExC3VGO05ru8j58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775405344; c=relaxed/simple;
	bh=N/WGkqOTtr1/EsB9ncOc03NX0oaLTzpDZdk6nWr+iVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FEIxrWtBmMIFHIxSN4L08/D8PjqNINoThI8dNmZkDHorcFWrXnjhU6vK8zpD/1b0qDaEtKlCtwIiGWhyvMEtGlmgxYst5o/L0Vpszofi7SazUc7upo2G42A32zg/ioiiaJ3I+NuNiGpDXECvwrdknlKlS+3EaHBw5WHensDcdWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUXFNIvU; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUXFNIvU"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-66e8cf72a93so1258083a12.0
        for <linux-iio@vger.kernel.org>; Sun, 05 Apr 2026 09:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775405340; x=1776010140; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6vrsOzQeG5kSW32wCOP8z9WhfnNMQJXqkN1XExXaUJw=;
        b=NUXFNIvUB7OFvl11jc5l4/3yT0HlV8F0PsuJ43tLTwuCHmJ8hRHnFyPsZdU7kBWikp
         0AlABE/ebY47bPrHbenej47YlIQFIISTpoiZ30nhDcc6MTdZBJT9GBDyrquoRCZkhoH8
         RT18mrisXWNaniJ//O3lNHqVm/qdTB8OErgLd14KOlQD+p4drp3nQIDI5+/+HAwpkgT/
         oaYdp74bZsTtzvHhKnRdDVHN2Hw6D8TqihbEPCsbGqLuyuJMaUrXrFqgYyTyCVbte2h3
         ia22o7CnN/DMpf5yfwFxqkHtPhG4VipwQReW1M9UrEHnPoelwPyymjna6ei3WovbFP4T
         EV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775405340; x=1776010140;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6vrsOzQeG5kSW32wCOP8z9WhfnNMQJXqkN1XExXaUJw=;
        b=JcQ3Dfa27dKirQWMkf8vrI3pqSjicJw/bvWP1+6z2o6hhOwQQfJIlOptVp8f9qwHcn
         o3VOH+ONRsNWqSTlJQPk2361bQRfTEGZF1p1cUNcxnA1jY2kI3zBIuWlnAE/fo8sKNEj
         3oDahAuLAtTlOzwWMbkX/8YLgzrTm9nqS6MN3ORtBhKlyMsn8SNp3Fw7/RIMry7McMIU
         leM1ucNIQt+jbTtJEVFkY6/Ku0gusrBlPIwPEz2m8plAUaAlrLwIAKrkTqqgZ56T3ysn
         jnBgwdybspCMLf+CUPXWIgvPvHxXTdelaOAwe8gszXl+/7s8rowxEFah0hF4ZNGIbuoG
         auMg==
X-Gm-Message-State: AOJu0Ywxi4pBbqLHoN9uVJ+Nex+i+IsLSs6VXRCO3KDa/pUiC7kWsJr6
	C2SRMTrAXTQJu/l18p5k0wOfQMSSmTgddErWNuEDX4o4Yl29d2qLrilbLyVyn2tg
X-Gm-Gg: AeBDieu8WKEvMGDD8HKsLVCjqq2tD/NUEVKKUaSJd/hq0s54OeW5BN+5krOcc7vX7FW
	InyIQOXU+ugDp/CXdmTqENDckZjWWx8APYrRSh20uOvAa1r6I8o1CIFXFqUVHZRY9/9jVaAe0Rw
	zUHbldzZ7gNU9elST1VSCSIVd0K7g+00Cwb4XKnGtxKNu+Dk1qMzy5jL9DK2yMEO0dBjeWyM3YW
	/OE7OS9URRY/ZJiQFb+9TFWV6lO2QdhlF/4IP9hCMYM7EGrNAvY47HcfGIky7K7lYsORDdxVN8c
	xjsntbhvZL+DkAqi/K/azzhoWXsltYKzh4woTH3zVtK3PcpDgJ+cnwLPFWEZWkSe2Lbohj6cvtM
	F83rc2q1DzcLfB+w3/bG3QKKWlARHa4xImWuyRnf13Vci7yAT26saMDhSLAJYejrsNJVRNo0rdq
	QotMRaUaHWL1ke4YUq0upYKiRIiw==
X-Received: by 2002:a05:6402:434a:b0:66e:809f:39e1 with SMTP id 4fb4d7f45d1cf-66e809f3a61mr2627757a12.4.1775405339692;
        Sun, 05 Apr 2026 09:08:59 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66e02f389absm3195890a12.13.2026.04.05.09.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 09:08:58 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Sun, 05 Apr 2026 19:08:42 +0300
Subject: [PATCH v2 5/6] iio: light: vcnl4000: make pm_runtime_enable()
 device-managed
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260405-vcnl4000-drop-enum-v2-5-7c8dc98c3974@gmail.com>
References: <20260405-vcnl4000-drop-enum-v2-0-7c8dc98c3974@gmail.com>
In-Reply-To: <20260405-vcnl4000-drop-enum-v2-0-7c8dc98c3974@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.15.1

Replace pm_runtime_set_active() and pm_runtime_enable() with their
device-managed counterpart to remove them from vcnl4000_remove().

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index d28c7abe7642..556dc9afa82c 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -2055,18 +2055,17 @@ static int vcnl4000_probe(struct i2c_client *client)
 			return ret;
 	}
 
-	ret = pm_runtime_set_active(dev);
+	ret = devm_pm_runtime_set_active_enabled(dev);
 	if (ret < 0)
 		return ret;
 
+	pm_runtime_set_autosuspend_delay(dev, VCNL4000_SLEEP_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
 		return ret;
 
-	pm_runtime_enable(dev);
-	pm_runtime_set_autosuspend_delay(dev, VCNL4000_SLEEP_DELAY_MS);
-	pm_runtime_use_autosuspend(dev);
-
 	return 0;
 }
 
@@ -2087,10 +2086,7 @@ static void vcnl4000_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
-	pm_runtime_dont_use_autosuspend(&client->dev);
-	pm_runtime_disable(&client->dev);
 	iio_device_unregister(indio_dev);
-	pm_runtime_set_suspended(&client->dev);
 }
 
 static int vcnl4000_runtime_suspend(struct device *dev)

-- 
2.53.0

