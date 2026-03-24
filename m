Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1D13D905C
	for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 08:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342084; cv=none; b=fCTeF6KPtzf37m5Kc27Cc0oosBVlTFnQwmm7im+w4dPGGjTsq4V+BjkfER+wvucSELda1ZkKw65ZTTzGbLaCLu+AY5VusdxQpPA/Rs2mm4hqMtZ16U9HVk5OYuqNgvWtgFVFt3D3E1YrxdSiS4BB2VNz8S15bO5in5WOZEOlvIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342084; c=relaxed/simple;
	bh=VDP5t4BDn3RTQYsYXBM61NGLGoZsGItzqihhTlW1ldg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ej6RrsNwThwvjmbqGXQul9zgDaz1d7LkcfXeb3+lJqciyFP/+RArsH45LKuaujmdXkKIlBVTIiZhVUtdYF79z33ex+XdFZiN5sq8vivOBGMovEMobdLWMwV2dZ8RtBRqBMTfjWDK1pbU7huKrdKqkuGrRvJPZYkte75zzGCQHKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sIK46Yz+; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sIK46Yz+"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486fd5360d4so11087665e9.1
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 01:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774342081; x=1774946881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5+yw1a0G+6ay0y10P15I6U/dA0zfGZMo00ZafFMMNF4=;
        b=sIK46Yz+7p2bBaqd4fagPwywAPJZbGizP8yoqzIMPVQBNvlTI6J7bW1ZRa2UljAFji
         zRLhjhq/pXYcvSZxd6yoWJ9120qQBHSObTdiGAL47PF9dCUQqPum/7UfOkeWn86NhWsm
         /40wfgp210RLYx1NeQ7io1JfuZF8SE2QuO+Ob+7Cw85638NxRtPhTZi6Hz3JQiJHOGhX
         q+RXP0cEBQLeklVkehnVt0wix38hP6Bua9h/5ZQXbcfbPUJbOyk/osM/lGKZ1EKkFUNU
         fbhfPTSCndn3yH9DqCnam/DLo65bPk93nIkc/fOqjg01sdSetA/4Ijkd4YBU2AOkGQoU
         RhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774342081; x=1774946881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5+yw1a0G+6ay0y10P15I6U/dA0zfGZMo00ZafFMMNF4=;
        b=dBFYRrGDHGX2Y2yoA2W7KxcN3Akf2aPodcx71+2HEVC/xix4CFUPboFT1ETQILtedA
         wTUJr+gQQEJmiDZh5KSm27b5pRwfXa/B+/cGxLVe1YemK7D2opgVa/poCvOBH6j+7pxR
         dsB+b5KsvQh5Hq4lwY38BARUfjQapJA635rLsV4Owe5iddPTeZkS0Q9d0saLeL0w1/fT
         9iZiduloneZxaY+h416pHGkBTXjFtcN9OdIxMKWGttcCU5MoQcIOgsRQjN1+t4mzp0bq
         UAW15Aeh7jfQbTsLljiTN8TcwhFAdXFF12lC1n/o3JpLIcooupAVr5KsQNQJ35qVRr6X
         TCsA==
X-Forwarded-Encrypted: i=1; AJvYcCWopWqJl/fULUAkpC5MryT2qmsuH2fmY6V2L1lzaKwv9DGqXTxm8L8ertgBm5ZbL64QsObXhlVjKNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCv9c6BNjOHv7d3Tzr/V3G0PMLe/YLFyDgaWR5dQdjn3D+MMiX
	iR2iNn2aUgTaotVHQsnEDkLaxodLmQl6Vn0L856SISTnmx4y/WL976ti+zQLJBhgB4o=
X-Gm-Gg: ATEYQzzHDvwC7Zh4y76avSWJYzf9hPootJa7vtVrWgQXS0+ntqIe64eJyioFiZQLvQb
	EuodwYBgiDHJIBEX5ajSYSBl0bjHSLg8gBQ91i6qKZnob4Ctl+AcnaRPAtMzAR4qB39UDlN5vSP
	9rzQQyUsHtQUm5UHdmmRd1o7w4M+TATCJRzx0S6qO6homUl/5msZQGEjvWC4u1B66D0aRFOzRnP
	7YLHIrypMGSp7KJJHw7XGjwN/SAAyTq/emA4G/evQfFhjZZWxEj8akoVNFjWj4IKrRmtl59yVeK
	mqOMrY1PnUK4LH6DkKq8ZoxQ6rmUFn4NmrTdfkufh8eNZxkAik6Mrs1da5AR+yTp7W5fj9CgVXH
	H/37O6qvdhDhPllT+KBsgleJBwd1yLqMLWOT02Snvn/cRVJ317O2Zf2pcY/7VRJJeJao=
X-Received: by 2002:a05:600c:8b0a:b0:47e:e57d:404 with SMTP id 5b1f17b1804b1-486fee0f917mr214427215e9.16.1774342081149;
        Tue, 24 Mar 2026 01:48:01 -0700 (PDT)
Received: from localhost ([151.43.230.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48711764509sm35219835e9.13.2026.03.24.01.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 01:48:00 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 5/6] iio: ABI: Add quaternion axis modifier
Date: Tue, 24 Mar 2026 09:47:59 +0100
Message-Id: <20260324084800.654073-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260324084655.653781-1-flavra@baylibre.com>
References: <20260324084655.653781-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3267; i=flavra@baylibre.com; h=from:subject; bh=VDP5t4BDn3RTQYsYXBM61NGLGoZsGItzqihhTlW1ldg=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpwk+/23RdMrDKvc0bNMn04jz/xaWYU+32xhFNB YLa5+a4A7+JAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCacJPvwAKCRDt8TtzzpQ2 X4iBDACgpvWhlNer+JawhsKSoPfJgLM1ZEHsKETRhDXtzr+v/k38Z8QvYY02Wd56juhgwQ//wRb i3sZbavPc3LR935R5DEOjYFyaDNL0gBYDSLb44XnM2EtF3LjGMpCW3AuKssbptnsODE/8rmYT1a GEmvfGqqeF+SAxqJNF/TtQ3udxgBng2Oos83gVvg7Ou5UVGGoTvi2dOYGmA4wDDsIjZf0aWTlFn I2Xv8Ib9C7Dn5sENDfsYz6pIj1IX6Yu5+3S4E+b6mdvSCyd9RUh3Wgn3hhg159rgPO3dtOdxXrN qQg0RWosSMPz5GCfiPg5VSvvoRx888VFXYO0T2P4D+pu/laHotOC3o0iFOFIjgzhD5BA8lqsw1t fnjj9ucL0dDtQjr4cdoXmmcX9eWJgEZygeqYuxpuM0mWjTnEiYBpfbWCHXLNUasZU7iZUew7sSO qFihUOmhtXHb1ruv0xDA/bwM6vmMOhJGKztjvCU7jUBQ6UMT3+Bl//EdDb3JKcoOSy8Uc=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

This modifier applies to the IIO_ROT channel type, and indicates a data
representation that specifies the {x, y, z} components of the normalized
quaternion vector.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
The use of this modifier depends on [1] to get the correct sizing of the
buffer in userspace.

[1]: https://lore.kernel.org/linux-iio/20260307-iio-fix-timestamp-alignment-v2-4-d1d48fbadbbf@baylibre.com/
---
 Documentation/ABI/testing/sysfs-bus-iio | 15 +++++++++++++++
 drivers/iio/industrialio-core.c         |  1 +
 include/uapi/linux/iio/types.h          |  1 +
 tools/iio/iio_event_monitor.c           |  1 +
 4 files changed, 18 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index bd6c3305dd2b..46fef26e5376 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1755,6 +1755,21 @@ Description:
 		measurement from channel Y. Units after application of scale and
 		offset are milliamps.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_rot_quaternionaxis_raw
+KernelVersion:	7.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw value of {x, y, z} components of the quaternion vector. These
+		components represent the axis about which a rotation occurs, and are
+		subject to the following constraints:
+
+		- the quaternion vector is normalized, i.e. w^2 + x^2 + y^2 + z^2 = 1
+		- the rotation angle is within the [-pi, pi] range, i.e. the w
+		  component (which represents the amount of rotation) is non-negative
+
+		These constraints allow the w value to be calculated from the other
+		components: w = sqrt(1 - (x^2 + y^2 + z^2)).
+
 What:		/sys/.../iio:deviceX/in_energy_en
 What:		/sys/.../iio:deviceX/in_distance_en
 What:		/sys/.../iio:deviceX/in_velocity_sqrt(x^2+y^2+z^2)_en
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 22eefd048ba9..bd6f4f9f4533 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -157,6 +157,7 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_ACTIVE] = "active",
 	[IIO_MOD_REACTIVE] = "reactive",
 	[IIO_MOD_APPARENT] = "apparent",
+	[IIO_MOD_QUATERNION_AXIS] = "quaternionaxis",
 };
 
 /* relies on pairs of these shared then separate */
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 6d269b844271..d7c2bb223651 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -113,6 +113,7 @@ enum iio_modifier {
 	IIO_MOD_ACTIVE,
 	IIO_MOD_REACTIVE,
 	IIO_MOD_APPARENT,
+	IIO_MOD_QUATERNION_AXIS,
 };
 
 enum iio_event_type {
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index 03ca33869ce8..df6c43d7738d 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -145,6 +145,7 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_ACTIVE] = "active",
 	[IIO_MOD_REACTIVE] = "reactive",
 	[IIO_MOD_APPARENT] = "apparent",
+	[IIO_MOD_QUATERNION_AXIS] = "quaternionaxis",
 };
 
 static bool event_is_known(struct iio_event_data *event)
-- 
2.39.5

