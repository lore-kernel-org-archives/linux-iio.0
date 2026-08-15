Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76BE42900D
	for <linux-iio@vger.kernel.org>; Sat, 15 Aug 2026 18:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786818499; cv=none; b=W5ptdcAmunngcEtwnEFsl1+1j2LpckvW/pgjNykquaYKY6FdyxdXhVnKljR4p6nIw72XZFwcR4aMXcvvBYrvGbdtq5GQg8M+QgUzXga+HiDHPlHYt+POS9+yieBpTTEZCnvL58wqVtsQtfa2+ZyJKi6z/ezNfEqCxcfyDCvBhCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786818499; c=relaxed/simple;
	bh=gEw34VENern9leYlo6WUQSo7332q+Lp9FfLfUyozZz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cG3yXCJGHLj0oFJ38jWXqZItqw/NrkPBChptpZH7aYdNW43DrbW6NeWUxJyrWexdprs6WaNucFvPOB6HXy+sPeQq12q0w8tlnJXPzNxZe/vTDt+5y/3enNje2JwEiUspgxM5jNNCu01jnJEaWgtyrpUQiPt9LnCr8UsH62yWcM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYjHSaDh; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYjHSaDh"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66c93dc3f68so654334d50.1
        for <linux-iio@vger.kernel.org>; Sat, 15 Aug 2026 11:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786818496; x=1787423296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LDaZRH1XbTfk3hXUc+K+eSj2XbWKoDFGNk633rhoJVM=;
        b=jYjHSaDhtaNBYOB1gxcDHUcRmFtsDTIXUdlify75n6SNYiPfiUOsPA2bf62+1UNoAJ
         kQps3hziQkj3e9ElefO7Ow9+Bw31lpV+2j544BGfTkhm7oXTFmrsKvxX/Py/qqcVFhLu
         EWljHuShuhE9laBXx8PcyiIM/B03D+j7W5rNlgr+jXLaRYh6vecLqv8XyQAEih4bCAeS
         UX+klaF9ICY9g2gJ72OHOPMzDUIbvmnw7AwImwDWN31wLtVeli1kv0i5Nll1vfvQEiui
         LFcRzECU0wUBo+DyTZN62PFPBRxZ0Iid1kqOFCHCc0qOqtj7e+kGHSpB2aksyKt0wX19
         kAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786818496; x=1787423296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LDaZRH1XbTfk3hXUc+K+eSj2XbWKoDFGNk633rhoJVM=;
        b=nscuiDuqqgvKJNDE3NPFW/bv3kjCU99IPk3rNn+2zjo5c8UW05ZGht8Vr148LuYm8V
         UYRoean5oJKCybGXImNLwyjYbq16Uf6v5twjOcWohETC9TgSea35MaMBOJE4vipNAwlg
         teYU3/Rc84g2JddiIRClDOdnngJzeOQuSHWc8xF9M7MXHkpb4DSnV5chHKWAGT2o6FpV
         AsLq1Xv1IxBIwx9ERO2JGdVEqGVL5ME+Z1Z1I/F/InkSsikbp+n1lIRjdXi1Jo6v7yfS
         JlWuAPf1UsIS2TY0d2nhp7p8YaNU0ffOHppDJ12lVRUfeEzWNkvWp+ZpBGAGKB3jwv+x
         aLfA==
X-Forwarded-Encrypted: i=1; AHgh+Rpt4noOJRSW/veoSLRPyc5XDSI/0bP2N7mDX+S2uBFJLadB1Yr5flbgowMMW3hZb2ffyCBA4SPgDGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvIz9lMyq8nGw+L2qZlNWYy+RI/lG0RZqNA+kGqe6ntQkaw1wU
	MoIcR5WsgHoqg5XRyX3Ljsp98m2MXabRCqeSo940x1Ai1Z38fLK2cso=
X-Gm-Gg: AR+sD11qtdGoLc9FPrQWwuBiruLBdyDKBnxDP8WlavNygAth7PCqtEWPQcE7BkpM9p+
	KAAZVwng5XzCA1sRMe72YLCzhwi4qeHiBiDn+brM/FHRdYQWp6laOd8Moisi5af0QlPmBm8kW2D
	FIJCQRQR+42Pk4Zhrx7i0B3tNnII4CxWdkn8bUxJ8x7xom+uOTvuvwiSYDKEeQ+EfbFR31WFGU2
	Y+7SAaQTNB8ChXtDo6ZV4IsEJYSwvMVdg2t1HwQO2JvMAQppEDzDCPsaso30EPdDJbP5Bf28MiW
	xBz6WzrpwwPjQAaS3GVimZNIQSCcCzxagzf8aKVtfs1C0PpophMFXr2EmCX/716UR5Bysaols9z
	KNDgBZ9F/1jdW5TK9PrCHixGclXNc1sY7lOXirBrGXsvqqQMI3LzR+//Xsu4OzkOXA63pbVMJJb
	nIFsoHuxbXGye9Tihgvp6DlCcYV9ssITPRuHFiAMDGUzo2AdHtt7hhhEVopDzL03gdYLZU+O9Tm
	8/X9Us5wo+eUUPEG9LX
X-Received: by 2002:a05:690e:4195:b0:66b:d2b5:2db5 with SMTP id 956f58d0204a3-66c72b30aacmr4411880d50.9.1786818496549;
        Sat, 15 Aug 2026 11:28:16 -0700 (PDT)
Received: from daffodil.tailc06997.ts.net ([163.152.162.75])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66c75c5dd24sm2598154d50.6.2026.08.15.11.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 11:28:15 -0700 (PDT)
From: Arka Mondal <arkamondalofficial@gmail.com>
To: jic23@kernel.org,
	Michael.Hennerich@analog.com,
	nuno.sa@analog.com
Cc: andy@kernel.org,
	andriy.shevchenko@intel.com,
	dlechner@baylibre.com,
	rohitsarkar5398@gmail.com,
	venkat.prashanth2498@gmail.com,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arka Mondal <arkamondalofficial@gmail.com>
Subject: [PATCH v2 2/3] iio: imu: adis16400: fix unprotected debugfs reads
Date: Sun, 16 Aug 2026 03:27:25 +0900
Message-ID: <20260815182726.11796-3-arkamondalofficial@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260815182726.11796-1-arkamondalofficial@gmail.com>
References: <20260815182726.11796-1-arkamondalofficial@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

adis16400_serial_number_fops is open coded and never calls
debugfs_file_get(), so debugfs_remove_recursive() does not wait for a
read in progress and unbind frees the iio_dev underneath it.

Commit ae1d37a9bb4b ("iio: imu: adis16400: use DEFINE_DEBUGFS_ATTRIBUTE
instead of DEFINE_SIMPLE_ATTRIBUTE") converted product_id and
flash_count to DEFINE_DEBUGFS_ATTRIBUTE, which protects itself, but
moved all three files to debugfs_create_file_unsafe().

serial_number prints three registers as "%.4x-%.4x-%.4x" and
DEFINE_DEBUGFS_ATTRIBUTE() formats a single u64, so it cannot be
converted without changing what the file returns. adis16475 and
adis16550 already use debugfs_create_file() for their open coded
files. Use it here too.

Fixes: ae1d37a9bb4b ("iio: imu: adis16400: use DEFINE_DEBUGFS_ATTRIBUTE instead of DEFINE_SIMPLE_ATTRIBUTE")
Signed-off-by: Arka Mondal <arkamondalofficial@gmail.com>
---

Notes:
    Compile tested only; no relevant hardware available.

 drivers/iio/imu/adis16400.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
index 36323ad149e0..7e85c1b8dc16 100644
--- a/drivers/iio/imu/adis16400.c
+++ b/drivers/iio/imu/adis16400.c
@@ -280,7 +280,7 @@ static void adis16400_debugfs_init(struct iio_dev *indio_dev)
 		return;
 
 	if (st->variant->flags & ADIS16400_HAS_SERIAL_NUMBER)
-		debugfs_create_file_unsafe("serial_number", 0400,
+		debugfs_create_file("serial_number", 0400,
 				d, st, &adis16400_serial_number_fops);
 	if (st->variant->flags & ADIS16400_HAS_PROD_ID)
 		debugfs_create_file_unsafe("product_id", 0400,
-- 
2.55.0

