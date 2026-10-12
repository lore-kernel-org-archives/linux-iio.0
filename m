Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E5E446C18
	for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 07:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791790980; cv=none; b=ugDFHki+NhbVUslQfbExREFaOwS8InfYF2qr0jvpZgFa9Eb1opwOawV5+MOVccluCRwrkcAaly0Dal5kjvPX1aMbuhi0wXLGxPe+TRWUXZBpESyTe5d9lEx5/HjjNuqEGA5nJf864nwfFCnLM9tnhxgJjQX5uLOYZWp9oYo831I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791790980; c=relaxed/simple;
	bh=5US6qHRDMsC7+3n4j55+vD2ffevfbGh9rWJssZb03RI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=omJHQ5ujRNACRKue01j86/8hBkIaztjAf7mGNNwvLkgK8R2kjE9WMKXnFzkH5iIIMqZUjM5WKJVnA8qOBODOw0cpKIXbSNBDZHKNxzlpMH3tRVWev9RAbuAZYrbp/3NChtxI9Jap9wCSZubkXeNfNdjhMIJTlhf2/pw/wsWSbno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=db+sDMKX; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="db+sDMKX"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so588449a91.2
        for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 00:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791790975; x=1792395775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kcb5d4WbMF0RGuZ6n9zwqpNvEO0t828hCiSHNJS62Zk=;
        b=db+sDMKXrXA5XmXgVN7YtlDXgq3epPo3+YfSrzqNCfGQfVxt2WKmN2I4ZTHq/4ONmZ
         HzPdttzy9lu43H6Ab9+09lJhYVyEJmF5d/hIgfsYkblP/F6u9ZCKgOc7AM5lFmtfjuzs
         h3J+zHBAEeTKnmuA+y06aHI8URtzJH0/SxemsRLbIQAOJMlljb5Po539pQsrCpS9oHS9
         pGrgVlizlLM26HjZXZv7ojHVqsAffAPjKwzPwQWzMV6NO1+rHwp3pFtF7Qoh46W2JrIq
         dvRFLIAQjtxgyw45uEoag5Nyamv202QD690J4SkoYWDS5oBru3F5CY4y9q+Yr1UNsGwR
         FVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791790975; x=1792395775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kcb5d4WbMF0RGuZ6n9zwqpNvEO0t828hCiSHNJS62Zk=;
        b=VaSI+YB+8IUKrcOyOmcBGB8EXtsCprqzVmcxVcE8+q7x9aNpg1RWF0XNubGT2hXMT7
         tqPJgTsln0dn8Fid8nKG1zR0eBo3JoU1rEySNWHCw0ojI3RjztCTndz9V1Mdttpbi4G8
         ypzw1jJCtf/NLUX5eB3H0YgLd1H3NXuozRiH2v6yVtnhNxeBuqWcoQahOE3W1MmAVgPU
         +Y9YeUddtfYOyxtumbY9bOeBaiALPwGwrl7/qcR3bK81qqomlPf3iLyDfs1z+Xq9iFr8
         IQzI7tXvDDQTPwxP+CmucVqR90i/a6GzeGfSAahlmeVYOLe6LhqD2o4qy8abzgt5dqFc
         AmrQ==
X-Forwarded-Encrypted: i=1; AKwUvBzeMa1F6c84CNJe9fxlnjleiEMkjn54mrhxWYNqtxeHFfdCLTUazPc7nBt/XByG+cLbYS/BFMdE3OI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLTVyo3ivwu1i8XM6dnrnkThGFcbMVih1CsO9AfTunrU3W/29lV
	AloLLN5ktchZg/ojgGX+aXwT2cx+V5fYjmufuQ1tkVuK06dJNEByXizb
X-Gm-Gg: AYBFou026256T7Z3YKY9REB3juzrG3M2md58M6vTPUpPVVN8xBcZzkPWX4DJUAxzWcm
	eMRuFO+Sf5fs/ZmTvcFAfztOBdAtcYl+yLi8umIyV9EpTTC4KoG0BmvwmpXMJIjzgPaLcD5Ae4l
	Dqup4HnN1ow4MTm64L3/SdxamSbU47IiTQz3WgRBSpv3Qv5rfyU1iAFh4HxJRLmGb3muBDhFP33
	kDOEWWHAasFTpzIw4kdkhUv/Fwa67YZy8LQifyfHfIQDjmHges6v0+e0OxZ1v8/FBxUhm2z6vTb
	IkxLYEuuIDtlQCoyKZHSWUKR7s2YP9JsxnaFf3/0EiH9Xgzi+ssnqY3EqQGXykc0eoajoX1ExM6
	20IbXqWvM4Qh1kNIybCLVZDrc2jJbGZFEU/pFPXb3hTGUUVHuiJIlgx3mS0aEIZ1nO53FuTbtrV
	lvY6J/L4YcLFuLYRfVjEcnZsE2a4uiWCoGTrU/J6ucCrnHWVk+tcE5BvR8DQYVW86By1KCuXj7G
	RrYKTGLQUrOPLbz8sMq3O+sXuzjRio6ANmDn2TQ0A==
X-Received: by 2002:a17:90a:c88b:b0:3a4:8c41:fab6 with SMTP id 98e67ed59e1d1-3ab3ab32a3amr6713683a91.46.1791790974980;
        Mon, 12 Oct 2026 00:42:54 -0700 (PDT)
Received: from lenovo.localdomain (211-23-53-87.hinet-ip.hinet.net. [211.23.53.87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab37139b59sm15470556a91.13.2026.10.12.00.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 00:42:54 -0700 (PDT)
From: Yu-Hsiang Tseng <asas1asas200@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] iio: acpi: Accept comma separated values in ROTM strings
Date: Mon, 12 Oct 2026 15:41:44 +0800
Message-ID: <20261012074144.1060625-1-asas1asas200@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ROTM method of the MXC6655 accelerometer on the Higole F9B, an
Alder Lake-N handheld (AMI BIOS F9D_16G_P800217, DMI strings are all
"Default string"), separates the values with a comma and a space:

	Method (ROTM, 0, NotSerialized)
	{
	    Name (SBUF, Package (0x03)
	    {
	        "-1, 0, 0",
	        "0, 1, 0",
	        "0, 0, 1"
	    })
	    Return (SBUF)
	}

iio_read_acpi_mount_matrix() only accepts the space separated form used
in Microsoft's example ("0 1 0"). It rejects this matrix and mxc4005
falls back to the identity matrix:

	mxc4005 i2c-MXC6655:00: Incorrect ACPI mount matrix string format
	mxc4005 i2c-MXC6655:00: mounting matrix not found: using identity...

With the X axis not inverted, iio-sensor-proxy reports left-up when the
device is held right-up and vice versa, so the desktop turns the
picture upside down whenever the handheld is held in landscape.

It is not the only BIOS written this way. The BOSC0200 on the AYANEO
Air Plus uses commas in its ROMS method as well, with a space before
one of them, and its ROMK method has "1, 0,0":

	Method (ROMS, 0, NotSerialized)
	{
	    Name (SBUF, Package (0x03)
	    {
	        "-1, 0, 0",
	        "0, -1 , 0",
	        "0, 0, -1"
	    })
	    Return (SBUF)
	}

The kernel's sscanf() does not support '%*[', so there is no clean way
to take both separators in a single format string. That leaves either
a second sscanf() call with a comma format, or normalizing the
separator first. Do the latter: turn the commas into spaces before
parsing, so the existing "%d %d %d" format, which already takes any
amount of white space around the values, keeps working unchanged. The
strings live in the buffer acpi_evaluate_object() allocated for us, so
they can be modified in place.

With this change in_accel_mount_matrix on the Higole F9B reads
"-1, 0, 0; 0, 1, 0; 0, 0, 1" and, with no udev hwdb override, the
desktop rotates correctly in all four orientations. The AYANEO Air
Plus was not tested; systemd's hwdb has an entry for it, which
iio-sensor-proxy prefers over the kernel's matrix.

Link: https://github.com/hhd-dev/hwinfo/blob/d9508123bee46ae3a59dc24826030ef51ea95058/devices/ayaneo_airplus/acpi/decoded/dsdt.dsl
Cc: stable@vger.kernel.org # 6.10.x
Assisted-by: LLM
Signed-off-by: Yu-Hsiang Tseng <asas1asas200@gmail.com>
---
 drivers/iio/industrialio-acpi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/industrialio-acpi.c b/drivers/iio/industrialio-acpi.c
index d67a43843..c77926f6d 100644
--- a/drivers/iio/industrialio-acpi.c
+++ b/drivers/iio/industrialio-acpi.c
@@ -6,6 +6,7 @@
 #include <linux/export.h>
 #include <linux/iio/iio.h>
 #include <linux/sprintf.h>
+#include <linux/string.h>
 
 /**
  * iio_read_acpi_mount_matrix() - Read accelerometer mount matrix info from ACPI
@@ -63,6 +64,14 @@ bool iio_read_acpi_mount_matrix(struct device *dev,
 		}
 
 		str = elements[i].string.pointer;
+		/*
+		 * Microsoft's example separates the values with spaces, "0 1 0".
+		 * Some BIOSes use commas instead, with or without spaces around
+		 * them: "0, 1, 0", "0, -1 , 0", "1, 0,0". The string lives in
+		 * the buffer allocated for us above, so turn the commas into
+		 * spaces in place before parsing.
+		 */
+		strreplace(str, ',', ' ');
 		if (sscanf(str, "%d %d %d", &val[0], &val[1], &val[2]) != 3) {
 			dev_err(dev, "Incorrect ACPI mount matrix string format\n");
 			goto out_free_buffer;

base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
-- 
2.55.0

