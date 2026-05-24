Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5AB336EF8
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 20:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779655882; cv=none; b=qUi0w89iAzU1iun2kc1j2+Ko5rxHDIDJZpqpi7FOX4/qFJCaLhNl//uloLt2Cs+0OUnMqY+5SLxVpo3EfikfCZ1KMepYyIO9vwyvHIHVEVnWAZX955kSPrSBALiBeAwcH9xyA0ot5AAgwg+7ICAPpARv8XKEbt5/6AEHYz2/3uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779655882; c=relaxed/simple;
	bh=/E6noZEAxsmqEWcfMOy++WDBnV+JRuYmIOlWaCLHqFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2S/mDPCiUzA9ffpFZsmS+BKhzEWFxMGBrwKsOCbZ7PRmoEd4jzdcQEWNUxjVFKC6hDrpD3MqYQW31ZugPp7S3AlySBm+jinzpeJOX5uv+w9DoLGQVaw2FjNaA+E+CC2eOkGsldd/FW0B0fRWZR3oWw8hLyGWQ5mUD1cvLpgfTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oTqru2vc; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTqru2vc"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48d146705b4so95070475e9.3
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 13:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779655879; x=1780260679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFd4yJ/TC4wEbZC59wd9fQSCOjR2w318PilPDVoxbPw=;
        b=oTqru2vcdTnZiWMZkpNMv9u7o2L0pLHcfkA7TkK9woFGYlYbPozZtQqICzS27/ybPQ
         nV/KWK/0vLAl0EshAzJL451DxkaIRToVSt1sROHanFWDS5KihzClqoK1VkZmCh342cIe
         +U8xMkoVVBWw7unuREfntsXHbt6nSV3q6PK8frZ7kG9CCC9L3EaVeU9YM6RV0S7wDbIu
         NE0UnO4LHuUJe21vbXexD/7db2l2cK5DRqvCAp4+PJVrwnutv3AQCHCfEZCYiVzL3qXV
         0NnlLhU5Ix7kwfWdh6t1rDy06yVIgRA6JCdJyCJnscSNt8wR0PoAc0SmSEoaj0R6P745
         Wapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779655879; x=1780260679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iFd4yJ/TC4wEbZC59wd9fQSCOjR2w318PilPDVoxbPw=;
        b=q2P0rzF0iseH4JmAW/svgOe+Fduq+FLnpCSK5/2Nu5k9jT/0w6K01FXrifmfblfHfg
         Ajn48tYgVdTOfFmh6Tv8qYA2rlMs8w1+xJm9ehkvpOWltgXUEB5A7A/W6l4/L8OA+grG
         v1u91XC/N2lgY3KBFPo8xzG5S/gkpsgczas3fQFzWAd+Nx8Y6fY0SH5i4maJu/up32Rx
         75A9Myv4US5xWhqD1ggR/ntc8O8tIHNA/QMFwyBBo9d5Udpk7E3/6tGiedRDJMk5KyRN
         IuVN+3fSwviYB+RhZPm2uuZZrDpioSwTKxyZa64q4v78ywwcCcnoL3T/UKDSDtJgTQFS
         a+ZQ==
X-Forwarded-Encrypted: i=1; AFNElJ9n/oytcJPg3gPC2cM5LFOO02AMrbKsSsQFtLIdl0MsTVYyH/ueyFILWUkHci5JrKJi2xkAB3uS2SE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2t/ZHarSNYOqtEHmy03ZgGEn+L78JliI4R/JhVl8g5NU+95cJ
	tlXxLZ+o6xvszN9hCsX7W7KAzvXcmu46kPwQW4BPQ150bejLi5NOjUwn
X-Gm-Gg: Acq92OE4lkaQ3xlMOMz3TUVgL5G0vOQmZNt6EnfpacNkLcXN2q11I5tf4M0K2n75u6G
	01gu8mbToDKKE+IkS4y8Dbz5rWiZL5r72KPMr0zlGLPTRm6y93JYUmPBuzlIo/g4qfxcIFTWZ7z
	+iTJtU8jDp7+ZtP+B7z6iT9Ixw8Js/mW3E5OnFyPGxoWIA6GVn9U47SIj8GIDtEvjtuQw4JvyQP
	1YivnLkDx4hGWpNSvTsJzqDNF2hp1CCP39pPxDi2iqRrdrVxiy4wWYD4ATp1fVY8KFfK/4aet9/
	dkUKgCk3agJLLcM7Xp/gkQWnVpj5QUEbhHnx+gV0WHiiwOv5noaqtVtMtvSGGbT08kGXBr+TYtZ
	iet3XuRkVVT3ZFjw2oz366LcLe9LHSoSwBgvLo21jNfzKUknJMXin6OSmQGHdevqRNAwF5jI8HJ
	KcsNMn
X-Received: by 2002:a05:600c:818e:b0:490:58f4:ba23 with SMTP id 5b1f17b1804b1-4905c60ef29mr62901095e9.30.1779655878894;
        Sun, 24 May 2026 13:51:18 -0700 (PDT)
Received: from sefo-laptop ([2a02:8071:50c5:5c0::361b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d6ebf0sm22738588f8f.34.2026.05.24.13.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 13:51:18 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux@roeck-us.net,
	jdelvare@suse.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 4/4] MAINTAINERS: add entry for Sensirion SLF3x flow sensor driver
Date: Sun, 24 May 2026 22:49:39 +0200
Message-ID: <20260524205112.26638-5-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260524205112.26638-1-wafgo01@gmail.com>
References: <20260524205112.26638-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wadim Mueller <wadim.mueller@cmblu.de>

Signed-off-by: Wadim Mueller <wadim.mueller@cmblu.de>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 06a8c7457..5cafa8c8f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24187,6 +24187,13 @@ S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-iio-chemical-sgp40
 F:	drivers/iio/chemical/sgp40.c
 
+SENSIRION SLF3X LIQUID FLOW SENSOR DRIVER
+M:	Wadim Mueller <wadim.mueller@cmblu.de>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
+F:	drivers/iio/flow/slf3x.c
+
 SENSIRION SPS30 AIR POLLUTION SENSOR DRIVER
 M:	Tomasz Duszynski <tduszyns@gmail.com>
 S:	Maintained
-- 
2.52.0

