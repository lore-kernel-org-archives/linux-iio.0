Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E1C39F19F
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778321457; cv=none; b=X4SaJDbQC+daLKa9BuJ114LzBwz8xyOxjhlEbtzKoZAQz41ycYjAX1O3A/C1ufAqbw6f2+Iucw8kqigP1oo2rbRedi3tAaJ/jPBp43olT7kqIc64HCE0mRNFWWNzZ7/JRXfCsw27bhw7BsbbaXtLKsZRcOPYIkSJ7A2Ginp9LP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778321457; c=relaxed/simple;
	bh=tPWcv1jECZQQd9JlDny4sLxfDxzU2UCtd4V+vUCcfMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pJrMF1dV7Ctt80T4gvyIDqzKIDijQkWq9Imq9ajpadA2bkNOSLPAk1R2VJywISchC6a4VNZYiwp18eEbdFiBraXmlLHA40zm5KPL+qsxC6f21E1dHaHfCAuXupqkeIPzFn5jqMqeAIPj+kcpFHSPvuxMHVaQuEV3R7MqQ8kXB2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8+SXQpx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8+SXQpx"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bab82d75fdso15665505ad.2
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 03:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778321455; x=1778926255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JkFhHabJLImjsw5jAKHOTDz0VLKOY6FhmBrPls4dhd8=;
        b=i8+SXQpx1PKKFWK0+os+QQWDUi3jJ5RYXDE2fYqwC1lEo05WfTF23/yyXn+t/Lv5v3
         IQAa9be8g6velieS5mf/DgjiLo89UvH9AIE00+gQirsz7k8VGmfV8RBNlWRG17IN1EWj
         k8IFvz99LNtT9ZvdSGbk8XwJcs6QYAf5TUIrI+BcWIgfrraMPQmiz3NbNW8jl3HbFcKf
         l8LfvhrlkD8SBCU6h6qMETYI1cnm7MIRGqa2z5On8sy88dv9NW4WSeMLqAZpVFs+f8zo
         wl3+HGXXBjV71xVICP986VyI/7t5ioHJK9bOSfbtJFtH7Aioq+drpvavLvFZ88DF5dAW
         mScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778321455; x=1778926255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JkFhHabJLImjsw5jAKHOTDz0VLKOY6FhmBrPls4dhd8=;
        b=ALh3TPwJTGzMkuckQ/5895OipoX3rpjQavNdXgJtCDbe9EA1vj9xMDeWzvYaEy0ysf
         jEWxxJOjRiFBgXt+vQkCHomKS8VNu+NRxZnw8tbF/S2OMcv8J8PY6q3MrdreXYnMHQ5/
         8BRnc3UIXeUzeLunpaJuyE0RyQdLGkAleAI02XQABW1F144mGJam6/eedMNkvwjkZSgm
         W7tfb2JIVvbH9XVvfn1DFeN3SUIMif8wWlKW5T5t5RLhImJLI+QNtnhyz0v6wkRUB/8c
         AEgNCjDJgt0vs+xjqhTQ5/RHtqgUyTGEyKTmK0xxdh5GKZ2XG9BlmBzrSovD3dbAroEM
         jZPA==
X-Forwarded-Encrypted: i=1; AFNElJ95pfWQVUmuC7WXVgivqCqXBA9KEuvMWE00QO3YRwExe0d28WELjeCduS9xG5J5MSeIf4mHND5PpfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQGMuNyGhaHiRABJlGmTYMH/EoAoMoLse0tA9ni4/wp40br/nn
	XOpAI8vNEiUvvdpB/SLKfquV2F4TyF87YPeL8w5sL2jkISqzIVZydbwi
X-Gm-Gg: Acq92OEI8vhG5K08z5VFfPVo7kmUMlmMtFjRQP+COgMs4zloGrZnMYlVyYYyv7o0WfT
	kFCnxQQMLEcDsuxE94C9ljEr7RkjnRljNBkViRhOLYc3ZuTY2K9Rtla7stqve1HnJW8vfWqAAzA
	LJXFK0mOHkk8lcnjetFe8KfzjR8Xz4p//+OJMNhx/VlKx9tEn5du6kUzRKpknQjlmOt44e2TE5I
	+Whf3XE4ZrFAFxTLwx0KwpGaSRHDsy4Z25ZDNtbCk/VX48Z7NBu9yjSuFqp/4wdtfipNtsEYo2+
	hEsjYDw3cKUDUoQBW9did6k8LlH2mwYVtgbuvhaXn/gHq/WMaOmsUiiTdWCrWQIwoID2q0AYlkB
	PPDagnFqgpJlmiFiv1keCZKF9lnuYcCiX6lnq76hsW0yMTkyj4KTl2tSsRPnYrCarSIhV3rRaMc
	ea6wSRB6Fa0zDA5/xkQJcJqWqvpIeB1e5/3j0nADZSJAjuVWpZ
X-Received: by 2002:a17:903:1ab0:b0:2b2:a267:784a with SMTP id d9443c01a7336-2bc7aa20417mr19618195ad.24.1778321455274;
        Sat, 09 May 2026 03:10:55 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e83084sm47335365ad.61.2026.05.09.03.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 03:10:54 -0700 (PDT)
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
Subject: [PATCH v3 2/9] iio: hid-sensors: cleanup codestyle warning
Date: Sat,  9 May 2026 15:40:33 +0530
Message-Id: <20260509101040.791404-3-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260509101040.791404-1-sanjayembedded@gmail.com>
References: <20260509101040.791404-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Reported by checkpatch:
FILE: drivers/iio/common/hid-sensors/hid-sensor-trigger.c

WARNING: Missing a blank line after declarations

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 28d050b45c74..98fadc61a68a 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -313,7 +313,9 @@ static int __maybe_unused hid_sensor_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct hid_sensor_common *attrb = iio_device_get_drvdata(indio_dev);
+
 	schedule_work(&attrb->work);
+
 	return 0;
 }
 
@@ -321,6 +323,7 @@ static int __maybe_unused hid_sensor_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct hid_sensor_common *attrb = iio_device_get_drvdata(indio_dev);
+
 	return _hid_sensor_power_state(attrb, true);
 }
 
-- 
2.34.1

