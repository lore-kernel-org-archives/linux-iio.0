Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1463AA1B9
	for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 08:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774513106; cv=none; b=WCqlVMs5ezxYEoRER2RQvb5sDq62qWifM/RZ/SnX2u/Hmp71KFV3HI7XMKlJIo0XS2UM6YxMqr5OqcVQ5WUWeAD/ss0qfmXeZNOnVx2fgY7VE7uFKS2g0b0ZilAdkSUcuYLgNS+fXGfDEFhniWOuXsyLaAvf5GMuXjk2aAozX8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774513106; c=relaxed/simple;
	bh=yqSb+xj+j+Zsm33QL0jScZhrcDvdKz/PHFkslCX+jao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o3GQtFUUiGkZyGsNzQAsIVW9CaFpUAvgwSAOADS6gwcjxrtxkJVZazXJ5nEaV74l3nmo+HVNnlsw650GIaC47KUrD02WUnAFm1vUhUhLaZDzYRTLKCJJ/JGafav0JWfb9hpPWhIhvk8yMirXV1lseYYv2Xyu+ZkbNnuoNPdsdO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsS0iZy8; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsS0iZy8"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c73c990a96dso379518a12.0
        for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 01:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774513105; x=1775117905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WI8mxu0XOiC3NdF7Tl4p8eKdsZm/Gey97Qxo+LUKP1k=;
        b=RsS0iZy8iVY4TbC6XYaDvc6hIvYsZX14r0c3isU1FKcBfFJGLywR1dKcFUBKYvNoB4
         kfHL/5B9CJXL8/5ubepQ5BkbXNp+m+s9GXtf9SnNaGhthqe6rDdRlk10NZ7XS30diXHm
         ydPoA6rO0aYtN10n5rhLwDR7LOC3Ouas3omqqplxp9JC9K2uNfJJs27hUenvvJKiXSyM
         dnddtcMLVF1Nno44Nj+gdnWqFj+6M74YIM7EYHaqHlB1I1Xe5g14RQJOTyOfX7oN5Jkt
         PzC1pa43sxTIztdtd9j4tT+bI2VP2/geCAne2OdzzcWz8B+uRD8C5NJ4krhDr/Nn0VSw
         h8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774513105; x=1775117905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WI8mxu0XOiC3NdF7Tl4p8eKdsZm/Gey97Qxo+LUKP1k=;
        b=Z870nkou0g+47RTYQThUx9nlmVSb1aZwCVsx33a0e5DS+NnYb7ehZgeZHZ4VEdN09Y
         B8FViv5Pj3g146HVa8OofW5XAmuIXKex1WJLtla/DWcAkjeZEXo5Z8gtAuqK2gMGc3MA
         Iu3oERlqeumZ6pa0G9PL5wtb9aOsJ6op4fv05ibfDSfzx0/53ii5Utq3Fma8f0czc65k
         qBRWcFqRN06+9z8b1WPvgC4T4toUCxc87M9J+ofO02qWTwcXc3t02cNSiipc/MUQINhr
         d5+Du8qv0T6ZOHKbiGUzDdYanzEeuD9M7Z+nFDnGc+IkRKUYFAmf+2MuQsukM/7Ta7TF
         6Z6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9dky0sgougTOWZusYa2X/kV+63XOGCaEa3tETdml6g/9VuA8ODetJSe8xsl4VUAesOxf290CM7Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzAEAI5/VGf87hWV8VFMIa/JXOlC2guh7ISUXtSbx2csfbcQzk
	KNkAvNduzXJQZ1N8rXvY6IZjI67fpI2MzxEK+yEJw5Hm7w8OwQ9cKG2g
X-Gm-Gg: ATEYQzyn7qxeqJ/iRcYx+S4uJVWWi8JCRzafkaUG2O+IWVuAT7j/Y+HEB3quwf846m2
	o0WcR0CyFlYwp3ib0ylddJ+D44RIBISFjHPuvf09DzulmdAvQskHV/O0aOIJe/3W0YaXJzGNa90
	s+VIthHUfm7y0rgMD/J0TFCr+u/uhquUD7Gf0J3O8hdpWy25zxTfyFaapOwccnNDyqvjbrBoIng
	msUpEGrHzuB+ve3So8KwwgqYUT8AWNp5bHU8u6TS/rANWQMFTJC7upiXZmR0qsIqZWusjjPdiJM
	TW9FL96U1Bo6A3YvZI3OSTTedEUVmV5We7KJMvq+/Oq5wRgdn70X/xsNmWBkhC5MxzE/Bs9JBC/
	VERltg+kLxnkKVjYkWnVl6kLzJwZilsN9aVbyu08CT4xQisUl3CLgY2G53EXRH0LaAPJYhirRWg
	wELk07wJMfpM7YpRP8nbx1M86Ptw1XrncfaFuDu1ihY5NX1/Fn
X-Received: by 2002:a17:903:1b4f:b0:2ae:ba41:60 with SMTP id d9443c01a7336-2b0b09a7986mr78614015ad.1.1774513104641;
        Thu, 26 Mar 2026 01:18:24 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc87e6cfsm21855535ad.39.2026.03.26.01.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 01:18:24 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: kees@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sanjayembeddedse@gmail.com
Subject: [PATCH v4 1/4] iio: ssp_sensors: cleanup codestyle warning
Date: Thu, 26 Mar 2026 13:48:12 +0530
Message-Id: <20260326081815.925373-2-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326081815.925373-1-sanjayembedded@gmail.com>
References: <20260326081815.925373-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Reported by checkpatch:
FILE: drivers/iio/common/ssp_sensors/ssp_spi.c

WARNING: Prefer __packed over __attribute__((__packed__))
+} __attribute__((__packed__));

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/common/ssp_sensors/ssp_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
index 6c81c0385fb5..8c1e15d61db7 100644
--- a/drivers/iio/common/ssp_sensors/ssp_spi.c
+++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
@@ -29,7 +29,7 @@ struct ssp_msg_header {
 	__le16 length;
 	__le16 options;
 	__le32 data;
-} __attribute__((__packed__));
+} __packed;
 
 struct ssp_msg {
 	u16 length;
-- 
2.34.1

