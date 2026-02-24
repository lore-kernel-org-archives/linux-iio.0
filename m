Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060AC39E193
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 14:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771941847; cv=none; b=Zu8qjsOLsqOVEABREmerHyVt1q57CgJ5uTnWaBPraFFlQ2x8ZGua1zrcYdsXKPmmFe5nzjCDAZQsQBe+Mf3f+pLDjhuEFQOxCVq7Zxw4lVllQXCP/oZUWe+m/10lygilEhixsaTR1ZM3HacK47/KvHR81KJDrTGwech/7mOz4PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771941847; c=relaxed/simple;
	bh=9/7QTpM9w9CetgDRp3W/v439sqmC/gELVsuHbq2pmD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBUAy0tSmKArRhnxrgITIxH3CjpJnn3JOomEvYfiRQJwQlbYGAc8VdQ9i4VHATlHK5c8geZIXq+jU2Rmh6w7wdFdE80BwSMXkqCOaqNrcbSj8hlPwEvpEMbXSaoUbR3zlfl7mw7LlKtJDbiPVBlO8k+vxchdVYyTN2mVvXlk05M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eC81deql; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eC81deql"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48379a42f76so42987305e9.0
        for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 06:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771941844; x=1772546644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbmaZh646ZKImMHo419Q/3GSUkucF5/edL1/4X8vppA=;
        b=eC81deqlDrSuOuJTNTb4+E+xrQRt0V/yN3broUd32Cgm6vKXc/6nPdyn97cmcdVYRR
         2mhNqaoKrOL47Sz0VpERzLG1RxsgZd5LOulGVEM7ZSGjm5oC289VmmRs24V+blE3QNP1
         qToc1IYf8/qZ2CNdb3VxDFOYYahTxTXAQQlZrZy1sfDjg7Fp1aVIuc1l7PDqTR3BcTnY
         a8EcnlOb06hPLBcHnzDCL+uWbGowf2J//IPHq/p5IXHgwUtalUliq24KbgpwJPc6Zfh3
         Y4HC7DhrbrpkqWBI1reJfOUuD5Eso5HHCZn+HncS8TVYL2Z8AIisUojFoGOWm5J1h8hX
         0rcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771941844; x=1772546644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xbmaZh646ZKImMHo419Q/3GSUkucF5/edL1/4X8vppA=;
        b=PJZbhXfct/0uz4Xkvrqjd0OXEQ1LsBBDtJ36VI0SvtRbpSDokPxV6ZcvXL08YnkjFO
         i1Cqs8dFu3P4cCBbdFPAWJnC4+ZiMTXE358plXYqvfdaE0lb/1FulYDrL3B73/28jKI+
         mceAeukspcCnmxkXNVlZU66H99jTLCYgbbL3GGi3wNi7ro4NSfSUDK3uc2kMDk/eXDgZ
         ObcLBsozXtTn95hfs/0N6/x1TbHEJOl0q+ub9RK1CGQyqkppF5p/hrIlOqp3BLBXMdnC
         xKaxtadwsdDLUieVGDgsgX8jC7OgfSkpyuxMGQZQJXcJdN/4WNO2JB+sCuznSxsZXlOM
         ZVxg==
X-Gm-Message-State: AOJu0YxE7kzAf+AItU0NmAvX5k/NiREBqOFIKFn6w4+EvqB+xs8S6RVQ
	Tg3on13wDUFXPYVLTCVYzDpBPftdi/9+IhYoikp8t6x97Y5IYJAc56qAlGRdQ/KP
X-Gm-Gg: AZuq6aJXQExB9kzZedaNdK0WREkukIg/ipOtydruypW22N1y/8QtZGLgpLFE20HuP89
	rVkPvlgHaO/nNseI55wl22K0G8d4QorjnvkF4n/GupbVITMc7Zd53PSb+KsGi2qLNFLsoif46si
	uGcVwIqPb3Ef5vHxaxn8yJ7ScdDEh1O9W+K7/49q2CUCIt56NUdqrUAEB8MYVru2k+pvT4bKZaz
	0DYiQgCakAXB7yZV8v3otZymLe8bOWvCwlU4JaOhY6HXzUT9g6Crw/xzJ+hDQl6w+Z7V/JQJjUm
	8gz0yk2oKIunApdgiWGvpXgho/u2UpHYJwaB0GjHxyDsgPetH3O018rDYyhHW3/+a2115tqrM40
	8IS4Ya3+0B963v0slcY3R1Wb0C+885eL6NwyElL9iT4UJoqKm3v7IpTCaWfMYF2MvVbG+iOSU4h
	7fnFDLiPvbGLx6YvAb65MnwPniQd5Xw8iiKSWEsFgz1ZcsS0jvziJfJABTzEF20VhRja29DAKb
X-Received: by 2002:a05:600c:820e:b0:482:e5d4:b7ca with SMTP id 5b1f17b1804b1-483a95f7d94mr187018185e9.8.1771941843952;
        Tue, 24 Feb 2026 06:04:03 -0800 (PST)
Received: from db07.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7010a0sm1043505e9.5.2026.02.24.06.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 06:04:03 -0800 (PST)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: linux-iio@vger.kernel.org,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees-archive@lists.linuxfoundation.org,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v5 2/5] iio: core: Add IIO_EV_INFO_SCALE to event info
Date: Tue, 24 Feb 2026 14:03:45 +0000
Message-ID: <20260224140351.27288-3-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224140351.27288-1-0rayn.dev@gmail.com>
References: <20260224140351.27288-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement support for IIO_EV_INFO_SCALE in the internal enum
iio_event_info to allow proper ABI compliance.

This allows drivers (like the ADXL345) to expose event scale
attributes using the standard IIO ABI rather than manual
device attributes.

Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 drivers/iio/industrialio-event.c | 1 +
 include/linux/iio/types.h        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index 06295cfc2da8..5096baf233f0 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -256,6 +256,7 @@ static const char * const iio_ev_info_text[] = {
 	[IIO_EV_INFO_TAP2_MIN_DELAY] = "tap2_min_delay",
 	[IIO_EV_INFO_RUNNING_PERIOD] = "runningperiod",
 	[IIO_EV_INFO_RUNNING_COUNT] = "runningcount",
+	[IIO_EV_INFO_SCALE] = "scale",
 };
 
 static enum iio_event_direction iio_ev_attr_dir(struct iio_dev_attr *attr)
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 34eebad12d2c..4e3099defc1d 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -21,6 +21,7 @@ enum iio_event_info {
 	IIO_EV_INFO_TAP2_MIN_DELAY,
 	IIO_EV_INFO_RUNNING_PERIOD,
 	IIO_EV_INFO_RUNNING_COUNT,
+	IIO_EV_INFO_SCALE,
 };
 
 #define IIO_VAL_INT 1
-- 
2.47.3

