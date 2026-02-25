Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356E238F93B
	for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 10:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772014693; cv=none; b=m5f6efyWpk2q8VltX1pW5h8q8ngToeF8fBUvGvOH0N45cR3phAeTGiSZAc2z3/ixuSB6nsQaZRlzxg1cs6umdZhg70MpLaeHtX/5baamWgYh4tTzcY67YE0GKCrGTg7gw75ObW+Go5r4bR6cErPmDKp4VsJZR3mOcHqUlo//YbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772014693; c=relaxed/simple;
	bh=/+EtcM4PpShZZS23nog2f3WAGTs3hWTTmC2j8F6kP60=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pRnz0b1wv/78PnZZeHChfXtDJxMQCQYgdgLWZbxSHLTl7lqM+BqkJHl+xlCtEPExJRkO5hVVpQ+zO6KPFSHt5ZgdnJXrmClZhYeDNk6R3s0C3iKrWVNap3B7KfkPzXfI4zYunwmcd+XNyNboxd4roaoCSIfZ9E4T9xrpeA1T5tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mSGSpb4z; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mSGSpb4z"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4836f363d0dso54287495e9.3
        for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 02:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772014687; x=1772619487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQCAfG7KfmZ2nh5OrsOY1rBpRss8IzkmBnmQEIjr/00=;
        b=mSGSpb4zxras9mi+aXVXzb5IWDHE4iGcBr7oVpN4IXy94K7/YvhqSv31cLQazUgIz5
         +79Ml+NLRqmN5CjYl4JGF2MM4Nsw6fLOaAgmGdtYmOtXtIaFC53eup0kjXGi8eOlVtm6
         ybXeDY3e4Z2dBlwo3orIRzm/76R0Fz6t9EM7gADuG9sgtWJDnSQvrb9vki30qwD6MOw5
         fmXxmdOotQVzcoQKovWC01mA5y6u891PilrDT+TlN30TJEQNXu9SUke/DqQYBpM/RaNp
         j1Cp6WJVc53E32O29OZjSwQ7IUdKpczNwZhaMfIU6ZhiS6GPYuqEhKStAzHqHICKArue
         Ltlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772014687; x=1772619487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rQCAfG7KfmZ2nh5OrsOY1rBpRss8IzkmBnmQEIjr/00=;
        b=irdOjybFThu40dV3x0iAJsxT9FCwynyEi96qBOW163S+G8cmHrxdhXn+ASy9tjE5gd
         g1WBKcEs4GmrMEEJWeDZAyaE2Py6W18YGh8SiImuUNBnwMZNttr3v0ITCVnPHbCbKUvy
         StJPsg8gzTZb966gQ1nGabcp28fPmm0aUTQHIbvSR/3wNoOelv0u4Bn+x1GdGyY+tJbO
         h5YBtvK2+kfW5XXo4DKVe9NEPAU6t5IJpqL/TTVY+/50bKf6c6i9u+7TPDTYmIJX/QQy
         Yus2OfgzsIbV/xczH7dpdNgM7vd1epKKy6xaYviMbnq5ESLDd83bZoRBgcSLy0yRQGLw
         bRlg==
X-Forwarded-Encrypted: i=1; AJvYcCV6TfSWU8QDwjaAhmNpvGan7iRqYrjRb//WovZQGqYgTu95h+X7ahmahTl/3COO0ohIO2aNkvYOg8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxSBXGBmLZtHc+2UUnsbUc7+v0b2Lmi3R3NPli6GvsrIy+ef3Q
	dFBPOrnC5w0JwnM93X+v/Ba2bxAd8cU+k6sqkr0AWf5qLUwzQnZqOFM3Tcd+h2PIUqBYCB4jnHw
	6ULBGEKo=
X-Gm-Gg: ATEYQzzczO3apO9GSr9iCfrBHWWwNHJM3VSAeo0Nhjx382rWT9t5jaOgkxAXwaVZ9Jg
	9koXIEwsnEiTt4T7Nc68cCIWfDUL25U5FaUdSNqMsSai+We+hrZtZbg/5jL8eBSj9BddoDnbdwL
	2EofUcb85TAUKykT0n1cv7I6NLAOjhV7zvIr+2pxtvF3L47/Ya8CmYbg6VEBbn5t45ax8Uy22c/
	NI/Vi1z9Y7igZoLLMLMMNKjAKi0Ra94uc3S3bDzx8d9/4JN+YU9ra8taQRHSK1mZp1pe2EeV3Zp
	H2LRIpfHXyvv3w/Vyb3F8hrtexeg55lvYrySbWlsX1sndveOIyU+m8uwsFmhF11Ig3ENrc4MYy3
	IEDqd7fGMjubaVlkJTu5Ibfz694O0nq/onUaTFN0LL6rhICey780IJxmpR7lFUCnewX0jjcKK2b
	UBF7fF
X-Received: by 2002:a05:600c:1c29:b0:477:a978:3a7b with SMTP id 5b1f17b1804b1-483bef49dcemr34559995e9.22.1772014687229;
        Wed, 25 Feb 2026 02:18:07 -0800 (PST)
Received: from localhost ([151.35.220.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7010a0sm49867195e9.5.2026.02.25.02.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 02:18:07 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 6/7] iio: ABI: Add custom data type
Date: Wed, 25 Feb 2026 11:18:06 +0100
Message-Id: <20260225101806.2368391-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260225100421.2366864-1-flavra@baylibre.com>
References: <20260225100421.2366864-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4581; i=flavra@baylibre.com; h=from:subject; bh=/+EtcM4PpShZZS23nog2f3WAGTs3hWTTmC2j8F6kP60=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpnsxdWrELV6QZHRH1//cLHvGcAS3iRA4IUjLuG OdEJqYDaOaJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaZ7MXQAKCRDt8TtzzpQ2 X3oaDACbVyOKxnql1ABdOV9cFY4thzVqCrlCe+XuB9ecQ0c0GdaSRoFfYGwIXJVdIqC55wrI2aw vXLHDmKsEix2JJvnu4ssmqu9Lq23xgJTryFhCShN0gMpScRWlc0MMcwchV90mX46Yn7pWMGO3/Y tJlLbuV16T/VIyyPCfuGdpfwTT6Yp5t3uze6vXC3CDj+HOxhfIqXiMRX/dyByZszPU0TqBFhBZ5 qLlqoCi/9VNhtia6AvMkEOc6eOMTWDTyvPgRApkIAQU+skanOjPgv7cmEkTOePPEsLRgiHByI8r 6B/eVzReG7R4jBScUW1D1TVBvUs2v8FjLYretnHssjx5hDZZvcjd/Z6x2NhBkDS1t9ExKtIplqb 2c2N1ImTdR19DdbMuP9qMZIdQpBoC/Sm9x9VpOlQM8jYNZc5TZdgcCBzNbHbcyGKy7WwiERdpyn cKb5vFwd4LGDT8+ETUWNzhfqkp/mnfThNI1Yny0rY3fezshsm6fVNGAK90JAuuN4CNPVI=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

This type is used when the data received from or sent to a device cannot be
identified with a standard type and must be processed by custom userspace.
Any driver using the custom type must provide a driver-specific document
that explains what the data represents and how it is to be interpreted by
userspace.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 19 +++++++++++++++++++
 drivers/iio/industrialio-core.c         |  1 +
 include/uapi/linux/iio/types.h          |  1 +
 3 files changed, 21 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 61961bca4dce..2e45e54f54eb 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -450,6 +450,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_magn_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_rot_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_angl_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceY_offset
+What:		/sys/bus/iio/devices/iio:deviceX/in_custom_offset
+What:		/sys/bus/iio/devices/iio:deviceX/in_customY_offset
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -507,6 +509,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_red_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_green_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_blue_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_co2_scale
+What:		/sys/bus/iio/devices/iio:deviceX/in_custom_scale
+What:		/sys/bus/iio/devices/iio:deviceX/in_customY_scale
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -1486,6 +1490,8 @@ What:		/sys/.../iio:deviceX/bufferY/in_pressureY_en
 What:		/sys/.../iio:deviceX/bufferY/in_pressure_en
 What:		/sys/.../iio:deviceX/bufferY/in_rot_quaternion_en
 What:		/sys/.../iio:deviceX/bufferY/in_proximity_en
+What:		/sys/.../iio:deviceX/bufferY/in_custom_en
+What:		/sys/.../iio:deviceX/bufferY/in_customZ_en
 KernelVersion:	5.11
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -1505,6 +1511,8 @@ What:		/sys/.../iio:deviceX/bufferY/in_pressureY_type
 What:		/sys/.../iio:deviceX/bufferY/in_pressure_type
 What:		/sys/.../iio:deviceX/bufferY/in_rot_quaternion_type
 What:		/sys/.../iio:deviceX/bufferY/in_proximity_type
+What:		/sys/.../iio:deviceX/bufferY/in_custom_type
+What:		/sys/.../iio:deviceX/bufferY/in_customZ_type
 KernelVersion:	5.11
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -1566,6 +1574,8 @@ What:		/sys/.../iio:deviceX/bufferY/in_pressureY_index
 What:		/sys/.../iio:deviceX/bufferY/in_pressure_index
 What:		/sys/.../iio:deviceX/bufferY/in_rot_quaternion_index
 What:		/sys/.../iio:deviceX/bufferY/in_proximity_index
+What:		/sys/.../iio:deviceX/bufferY/in_custom_index
+What:		/sys/.../iio:deviceX/bufferY/in_customZ_index
 KernelVersion:	5.11
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -2393,6 +2403,15 @@ Description:
 		The x and y light color coordinate on the CIE 1931 chromaticity
 		diagram.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_custom_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_customY_raw
+KernelVersion:	7.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Custom input value, whose type is driver-specific and is described
+		in a separate document. It can have a modifier Y, in which case it
+		is a measuremement from channel Y.
+
 What:		/sys/bus/iio/devices/iio:deviceX/events/in_altvoltageY_mag_either_label
 What:		/sys/bus/iio/devices/iio:deviceX/events/in_altvoltageY_mag_rising_label
 What:		/sys/bus/iio/devices/iio:deviceX/events/in_altvoltageY_thresh_falling_label
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 22eefd048ba9..dd179e3b0fb7 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -98,6 +98,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_CHROMATICITY] = "chromaticity",
 	[IIO_ATTENTION] = "attention",
 	[IIO_ALTCURRENT] = "altcurrent",
+	[IIO_CUSTOM] = "custom"
 };
 
 static const char * const iio_modifier_names[] = {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 6d269b844271..47fefcdd693c 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -53,6 +53,7 @@ enum iio_chan_type {
 	IIO_CHROMATICITY,
 	IIO_ATTENTION,
 	IIO_ALTCURRENT,
+	IIO_CUSTOM
 };
 
 enum iio_modifier {
-- 
2.39.5

