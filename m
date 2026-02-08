Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C72F35DCE0
	for <linux-iio@vger.kernel.org>; Sun,  8 Feb 2026 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770563134; cv=none; b=Eg+cIupij9uRmgBtw0KZbgnLAMY6WNQzlldmvS8BIerYqmwrXpeNwq84IxJpcwb0kQSnh4NimeWaXqMtCLiYIslrkk97DWNYHeu21CMbk6joDNCSUjWEkHyueMGF50EZsF1H9H9i1O+jDKeANw5aWBDraMwKTtAFJlaa/Kxv6ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770563134; c=relaxed/simple;
	bh=9/7QTpM9w9CetgDRp3W/v439sqmC/gELVsuHbq2pmD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZyE/holckd+nnVIrlCCXODz4AcTBZ7G2yKXPocz6ung5tzGpN/FvMN5d4oXt9eVLWXZhxGhik4VaDU364ccXPyJn5SPa1amOQRKJdpRPuV7slXNjdXbxFiN7oXvk40044IsCxq0enbwCD7COmDraEHy+uIhOpgodhvzGrrgaN0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ch0kBBNH; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ch0kBBNH"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-480706554beso23923125e9.1
        for <linux-iio@vger.kernel.org>; Sun, 08 Feb 2026 07:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770563133; x=1771167933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbmaZh646ZKImMHo419Q/3GSUkucF5/edL1/4X8vppA=;
        b=Ch0kBBNH62QY6YYQ+nxagFaqOws5iBgV8VtSs7Yinh6wqmZPlGR/eZ5hTCGfhj8TWb
         K3VFuFKnMPs5vvKEkY3wvyavbJKR449xduffrSInJsPYdFqAXTynWY90yeofNDE7ELfc
         FGz6mCrfjf+GFSbLlgd/uoDPxEHvR/TnonqptpQDQKaoWBL4RC2dk7jbRNSNa8wjD5Hg
         HrMLNgcKnzXEHGyFbmvGuIAjGu7fPtJ/DKg2JuPb2cXpsTKUxLc7FiwE6MdMmA32AIyb
         e8Cby9oI2r8Mx+K2iD8AJuPoWmEaJ4ltpT48IBER5im/4R5HmMlxwfIyhADYtL4RW0eu
         IMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770563133; x=1771167933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xbmaZh646ZKImMHo419Q/3GSUkucF5/edL1/4X8vppA=;
        b=p5Fyvp2rtZWL49TbjPgDMVF0Cq8gaC6vz5xcN1JmDOy3Rtxo48qACSZeAh4EnTYk4D
         zCbUcU411D3cSw5JuIz8yWMXGoKUmm7Ky0JAN7ZawIbDd7pJZJGAXwyJStWv7hDGhkYX
         E2XR38h41CLCFHg8bSzquAx9scQeZ7d71h7VEZAJgwAreh2eBi03HvSHlbrljnv4bcVA
         /rtmb1b9+2G1el53+4OmVEmKhosfadBqUMzq74+Ms/4GF97QrK+V2R63gf+T2akQvfjz
         LewgxSWr0BvBxkIxT80xNL/KytW4NkBZh+EIhjUjBE01UMQqClzD96cxlwp019E0mmHi
         dp1g==
X-Forwarded-Encrypted: i=1; AJvYcCW6vRBGKDuNljy89QbLKDYChkri6GuqP8qZGMaepKOe7hXWT9W7EuSyRGkGzvfqnsCijZ59mTHbVpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuIZcqs69wi2HTDXlnXNwqSuFCYL9H/OS92cXwZMmuuY6khJMs
	9AGgLqDCb7dwnIymkMA+W8gACxpVSJmUJ0YwNRzwt3/6k11PgxZ9qtYT
X-Gm-Gg: AZuq6aI5IVrn+TDqI9CDl20vpe105Rzqwwex5eglYNlxLYfLoGFDaRByVAwgJI1eKOZ
	hBDo3YhhGSGwdVCUSDexe5K/ZNb9CXIhWSs0VejcYRKG2TsvS6pV7msAmvSEU2Asg/paWgLlv3j
	psa9JP/uVcATrIurXDU6n+GofwqEv8vSZJ7pq646ZUwBHgSTAoLiweEvhxchNnOleHkXhghrUq2
	VHSzh5HNHjOh+ctSP9URa8qoGtsy/sf8EBfen2vaNkWaZEaWa7O8czXJghxFgpvfGheJ6so2cV0
	61lWmZk84EPPNtK0WJ0490kk3lMLALmjkX3CMxzzVjOcyuW38vVJZoUWNDjk0RHj0jXarkprCNo
	KW5mICo8KbrkLlJZkf9ilJcZZaAXnxlrm7+WS166wbHbRYuF2FP230GI7yeiHFUvOj0PBIRZwX0
	dfcdeuMhdefFz0iAdRBCRT1gCr58HLs1hMxwXIIoSsLLrhFK+r9g==
X-Received: by 2002:a05:600c:3553:b0:477:9976:9e1a with SMTP id 5b1f17b1804b1-483201dc5bamr123026275e9.6.1770563132478;
        Sun, 08 Feb 2026 07:05:32 -0800 (PST)
Received: from DB-VM.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483206cc7d3sm179326255e9.5.2026.02.08.07.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 07:05:32 -0800 (PST)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees-archive@lists.linuxfoundation.org,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v3 2/4] iio: core: Add IIO_EV_INFO_SCALE to event info
Date: Sun,  8 Feb 2026 10:05:03 -0500
Message-ID: <20260208150515.14798-3-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260208150515.14798-1-0rayn.dev@gmail.com>
References: <20260208150515.14798-1-0rayn.dev@gmail.com>
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

