Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA4A3382C6
	for <linux-iio@vger.kernel.org>; Thu, 29 Jan 2026 21:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769720688; cv=none; b=Hcszxu4KoDJOXv6qd2NmcWra0FK4+voudSvJXfHpV80nMx2UeR3msdB52adYYxlGCJJmeS+5/f4lq5ghq+k+BTpxk+qHaWfTTF80bmN+rZ2ZeszAVTPYwwV9R6esTigkDi+n2SjmstoOmFMZpeHFMIJojT+l0PcnUedC8FhFHeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769720688; c=relaxed/simple;
	bh=EJ6yFwBp8w94j21FiK2TlrT+q6a+gFLuHoJjNXYB6Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XfJfqWFZ7L5iIf9wz29HXWgCHGuS63yCiaFvNbt4R4o7au0CNFjLfMqtL2/ShAVXA5ZN1U4nviA2/uO0atq4lwo5oeHYVjAWl3TOBrRt5o2PpccyTG50SndSVS+Za2+IthFoadbR1mBG5l0mT/TdNzW3NcY8+REqBO3FaBD4egk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=df7c7Kwp; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="df7c7Kwp"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a07fac8aa1so9800175ad.1
        for <linux-iio@vger.kernel.org>; Thu, 29 Jan 2026 13:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769720687; x=1770325487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cd7mH47laF4ECrvpU1bpkzaBmjECon1i1PruWf77QPo=;
        b=df7c7KwptLdBQUGgQaKMzMB3W8uP7MJTavUVAJpqSf0o+pQq8opea1lK9lCUVB2N7l
         CoDAVWqTJFRIB3IsODGaw8K6IypdVXMcBFv/7tezEyjszOqi17KLWoZ0TmFkGtlXyeup
         DuE4fHa8G2KJFOPU+kZx1xooLn/weH7bTepRE0WJ/gw+AEy4PI3AWDxrvvGe24WM/N+d
         CPt/ZOhnVFUOvqPUQsLq+Bjt3AL/ihmNEavzAJ5UQAhGrpLpdoTgZ3UhURx77pmh0Olw
         IOijkPKxTCkm0B2lXZr6PTFempe7napVQh5T6m0WwUfdWytWHgceMna6+P4YlkbASPtn
         iHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769720687; x=1770325487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cd7mH47laF4ECrvpU1bpkzaBmjECon1i1PruWf77QPo=;
        b=PlLk4SAV+PjG6Z7Jt+6bNHvOoIeItGtK/P9q5pt5ds1RCbHd1d+7MpgxilbnofNMV+
         ct0Ya08H+ZdlPc6S8xatkSFL+YUGeb5MehrzSD5exc7EKu1ZSPGe16zTwP44A9D3rqkh
         VikmVDk2RiBaG9dMeoPNXPXt/dJBgho+7rg7qPVUiwsLQTVjxiKevYja1uRuvridda9B
         8/Cmvk9Lkqt/cVk1kzM3jozZRQo87JBdOA+PMGV/OUj6G9XP4/WE7fHNCeVRfNVOrVMI
         Iroh8rhQffzc0is29B1AoxnXwZjmaDnPexvNN/2vxsW8PWApx24bYsZhHDPbXZ/AssT+
         ZnJw==
X-Forwarded-Encrypted: i=1; AJvYcCWy/lyh5XIsdq8+mJXfG7ik+9hVnT62ZDzOYtmzGiBNEm2UJX8E0WgaG2uskJcoGD2A32Ov94JZp8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHKeqqZgOEeKG9IeIikGRFC7qbznf6M0cZLjqHgoCwncQNSqUh
	oGn3SQiaVKGh4z00jJCdCVDByW4nP3mG9pRt5+i2Bm8dYpUGuUVlVx69
X-Gm-Gg: AZuq6aLdWq22MVbbpRON5PzTZmyv9qIs+yvipTbc2FRuSTTT7Y6mfJxZWpibpRZnNjd
	1mQR5ybYwAaZPyggfFYUDvNvVIAs+VtscoSQSk3VHAgijnEtf9mmE/Qz8zK6b4U/tcw6E9graKA
	GSH6c9c2u7DFUJRpG6+lHnzQvVYYT/LyCgzm05VVxpkk95IbNSma9XT+uK+clgHJmuoTxPYPiVu
	GEsinz4+JjRgq7PAEAPrwgUpkxLUI9iTwRQNqBqI0o1p8flCV/CWu3ciY3XkD6QQMqESiQvOm/t
	D8FUvYKwfeMOnSh75ZOQzqgtQDNwO7aYogqV0oiVnmyiQwOc0J/Q8aqFypvF+MH+g+pyO8hPcOc
	XicsApUyAy5BGPDER9z10LSgmyrnfecVqmAcfTKAYSw2WSCnG7VAQGIfNWG9Knwm4ILbIMO/bqQ
	IJc4Nn5pR8NRiYyacqo0nvK+gwOWVP
X-Received: by 2002:a17:903:3b8f:b0:2a5:8d30:58f7 with SMTP id d9443c01a7336-2a8d7edc348mr5977945ad.17.1769720686867;
        Thu, 29 Jan 2026 13:04:46 -0800 (PST)
Received: from HPVictus15 ([2401:4900:1cb2:d02b:4761:c62a:859e:e20e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b413d16sm59305965ad.25.2026.01.29.13.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 13:04:46 -0800 (PST)
From: SAJJA EASWAR SAI <eshwarsajja20@gmail.com>
To: Subhajit.Ghosh@tweaklogic.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iryuken@duck.com,
	SAJJA EASWAR SAI <eshwarsajja20@gmail.com>
Subject: [PATCH] iio: light: apds9306: remove redundant explicit pointer cast
Date: Fri, 30 Jan 2026 02:34:31 +0530
Message-ID: <20260129210431.654266-1-eshwarsajja20@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

C allows implicit conversion from void * to struct apds9306_data *, so the
explicit cast on 'ptr' is unnecessary. Removing it improves readability.

Signed-off-by: SAJJA EASWAR SAI <eshwarsajja20@gmail.com>
---
 drivers/iio/light/apds9306.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
index 7e68cca0e..5d18eabd9 100644
--- a/drivers/iio/light/apds9306.c
+++ b/drivers/iio/light/apds9306.c
@@ -1176,7 +1176,7 @@ static int apds9306_init_iio_gts(struct apds9306_data *data)
 
 static void apds9306_powerdown(void *ptr)
 {
-	struct apds9306_data *data = (struct apds9306_data *)ptr;
+	struct apds9306_data *data = ptr;
 	struct apds9306_regfields *rf = &data->rf;
 	int ret;
 
-- 
2.52.0

