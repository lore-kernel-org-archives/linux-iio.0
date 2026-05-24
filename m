Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6047F3264CA
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 19:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779651009; cv=none; b=g+5iFtmmHBbyutVsedfbglqu4KDIVrqyn5pl8MEnnMtHj7pm+8sWmko3LE3q7YMqaiIrhLM8leSdcerDghB/8v+BTol6wvVxx8YgdFRX93lU26LR3Zl9c76DrW2rbGu8IMSilsNC1PM0JbRvglUoxfztq91UL1Se/zOcEKmpqWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779651009; c=relaxed/simple;
	bh=aQGHbzwD8XvoBZlnyYmSpbPjlEUQmQSq7kMMzigIpcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=laC60/dpD+cqiWDGncQiInyQIaSMHmJzhtPO5UIv0xCOmw+bQy8evJO9UYlRfuHgWPqLdWAzBUnf8gY7S7KLPh9CBxtRPCw1kWtCBuA/N6ctoQ/ADAme2KPKnhpgSvIhBgGXDfe2FwoD/51Y5z84duiBCy1loCqANqFgW5DQ1/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePRiHLE5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePRiHLE5"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2be75f658f3so40598045ad.1
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 12:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779651008; x=1780255808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EfWIGBBAe6WYbf3D5tIwvhwfgl7sXJJFkfUQOgxxis=;
        b=ePRiHLE5liLJUJ4HfIOtbPthg+mqHh8hLOovXpxW3eYfJ4rVRLptKwpby1NQ+KQkV4
         lzQTCZf5fPAAu0frBYEXml36xCdJQCIiv6O3RC+usKVFqXbmeVa6BNjgQbAsIcB7K+J/
         Fc5HdZM/8+JPvypRDo0Usrz9D15Hdh5bwWl0IQLsozQSRI6f2yKDWEHPsOW1bzIEuG4X
         BHG8Q/SHkVnqmu6FRDXt6sTXQosxJUPCCBVqNMPRSXTmtsUMTpbnvqqPkuMwitk+rAi9
         p2LS4QCW+0z5hS4EK9jN4v2mB+IKWHu0IJwXCX7zogxszDj7Knt6mr/BTM6vZdDwYYep
         morg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779651008; x=1780255808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1EfWIGBBAe6WYbf3D5tIwvhwfgl7sXJJFkfUQOgxxis=;
        b=iwXS8aHSIs7NzwnJjgjCp8YOF9fapn9SE3aVd+WOCVVf98kKO/mTxxiY+iFfSQdatN
         f3oNvojI14Poe/hucQvzrcVN7RmBe4qwAWz9JPQGtQIAgOH6jhS5A+zS6IEksFnDqvIW
         J9DtmpgFt/Bjifcq07IuFWRI+3t0olpkx1GQsD1Nsq4cc6g7rrPsLeURHoRNCK7uP2y3
         d4AoP7xtGzif3Mf0eXQFtM8I1vF3MOMZX1aovvPo+27V6pVXD0kOulnI5uzN/+Rwwtyh
         QgQzjHytgzVN+rY8lmGggfW5uFn3umZydl95WyFkpQ/cAkdKrPCqj8cq2sPAL4sX8/G9
         OkVg==
X-Forwarded-Encrypted: i=1; AFNElJ+BuwSjN9o02sDQ0Uud8najFQTg/+zGWy2xtVzPYnEpHo6ImbOqeJ9BUtDum3iMEdDJhYP/5O5ZAo0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp8Si0K07JhpC0VApHVzE+s27372RRJODldv0hSPtBufWRoDSI
	pYf9cURLLXsRMVEOwMYNwUgVsH6rWZD1pzqZ+L0W0SIb2rqtdYSUyTgt
X-Gm-Gg: Acq92OHAqL85a020AU2BjHGEs+quRVIYh6XPNOhz4XGK/pOybhEvfdOxtz5QDXPkfgx
	DIoRhBxKLg0rrLQSsiViiruBO6DxhUkl1Al86CYI9p6tki2LzySxE1hQBEI8LMrub1OG/l220n1
	+dP+Vk8EVnIp5y8HCZn0JwlMQpX+e23znPEt9sLP7BhOEYeIPIVHD8/tZUOyB0rDliSkJFulHDP
	I3LFh5hvyvGzMSYvBFsaUcB8WPxCewpMquCD2Qvc5V29ESc5g/ajoJMOSTVuXEh91r4jsHXvLzi
	ee/RPNC2mzAPHjkWMSM0j4RxoMNdtJ8QzR5VamXeqssgs5+lGUQ0W1DztBD22FAknWl+BwptyLL
	DVlUO83r5FQ4XYKHIiCcSAhKb51qmnaQpT3IzgauhHAhiNdt/eEuq9MGX8ng+y+WD9ztKVkqJ7v
	Ejuf3IJBITscw4kPP1rZ9bWBIcOjcU3uO5gUBp7Qmc//M4n0Hm
X-Received: by 2002:a17:902:e542:b0:2bd:b585:55f5 with SMTP id d9443c01a7336-2beb069c13dmr130607315ad.8.1779651007331;
        Sun, 24 May 2026 12:30:07 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c3168sm72555465ad.58.2026.05.24.12.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:30:06 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	sakari.ailus@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 34/36] iio: position: hid-sensor-custom-intel-hinge: drop hid_sensor_remove_trigger() using devm API
Date: Mon, 25 May 2026 00:59:41 +0530
Message-Id: <20260524192943.1196773-5-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260524192943.1196773-1-sanjayembedded@gmail.com>
References: <20260524192943.1196773-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Use devm_hid_sensor_setup_trigger() to automatically release resource
during fail, unbind or removal of driver using devres framework.

This simplify the setup, remove goto, avoid manual resource cleanup in
teardown path.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/position/hid-sensor-custom-intel-hinge.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
index e616988fe9f4..7844ed12c030 100644
--- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
+++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
@@ -311,8 +311,8 @@ static int hid_hinge_probe(struct platform_device *pdev)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	atomic_set(&st->common_attributes.data_ready, 0);
-	ret = hid_sensor_setup_trigger(indio_dev, indio_dev->name,
-				       &st->common_attributes);
+	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, indio_dev->name,
+					    &st->common_attributes);
 	if (ret < 0) {
 		dev_err(dev, "trigger setup failed\n");
 		return ret;
@@ -324,7 +324,7 @@ static int hid_hinge_probe(struct platform_device *pdev)
 	ret = sensor_hub_register_callback(hsdev, hsdev->usage, &st->callbacks);
 	if (ret < 0) {
 		dev_err(dev, "callback reg failed\n");
-		goto error_remove_trigger;
+		return ret;
 	}
 
 	ret = iio_device_register(indio_dev);
@@ -337,8 +337,6 @@ static int hid_hinge_probe(struct platform_device *pdev)
 
 error_remove_callback:
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
-error_remove_trigger:
-	hid_sensor_remove_trigger(&st->common_attributes);
 	return ret;
 }
 
@@ -347,11 +345,9 @@ static void hid_hinge_remove(struct platform_device *pdev)
 {
 	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct hinge_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
-	hid_sensor_remove_trigger(&st->common_attributes);
 }
 
 static const struct platform_device_id hid_hinge_ids[] = {
-- 
2.34.1

