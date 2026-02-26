Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A820187FE4
	for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 23:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772147485; cv=none; b=qpIqo0lPKtW5Hg9WP7zwVy6/qeTL8CVLxzXouqE8jNFgkpw0hGrsCdwx8hf+VepQx9H6X7S/mxDFA1t8PvOOslOGZlZuErtlhX0xvEM3VP2PtGhLxipBvFslaKSkHP7JcuAk9EQ8xDdxes22wxA9/SOd6s9oK3OieuSlGjDXKtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772147485; c=relaxed/simple;
	bh=pgDjF+SFynRqwPcTuhu9A71XQCFv4iZQSdb1IQofHC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLUhMLPTE+I15G9O4ns9Amf2JdawqSsfV0ibEZhHEfhfi136ang8yem5LbCQDHBhvrA1bGxEuh9iH1iLLDG4Ii9lSWgMMiy9Chalu/uI/alwJy6ME17AyPx6Cw18IykhipNfPGVhONH6n4roLfITFnex39GdyMkY0JuD4MEEE7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlAJ/c5m; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlAJ/c5m"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8272c559597so1476720b3a.1
        for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 15:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772147484; x=1772752284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vO2yIyX5QV033H/kp7ME/ccMu7iMw0aAmads5tUNKKw=;
        b=TlAJ/c5mc/2AoysCI7WWJTyk08yCU+JJZbW8QJd5l9KdXSBOMMK6c2tec+mbr07tFX
         Ph1vILT1NewYbpdbvg2hjavg6aZOdUPH5Bwazu02ouW6v3wP/tyYOa3FD0ZY8tKe52eE
         +cIbeK0aG2r/4AS59cts71N5S6Jf5XG4raP5PWJcosE3K2FnA4sdeqpKvhcXS3azGwRf
         bGZjJ7rhbHf+XtjMxIKCmLy5+EDynHddHEayIvC1u6tdBawF/nLhqEM67oqm1IHvIUpS
         jdYGNMAI1rZXZBfDhtd9seQgMTxn/pKpyQ3W5WjGLQw0fFU1595iXflr1jICTx+bI4Po
         YbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772147484; x=1772752284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vO2yIyX5QV033H/kp7ME/ccMu7iMw0aAmads5tUNKKw=;
        b=X5eSAwzi86G3eQNMyGtEdxhRoJm4tGyvnSVEtdmXdV9R+ZfJcVOs7IFdgb35TomG/g
         2ckn7mkziOVNNj1QHKhS8w1uDjGpJmmj4y5bMQEQa92SyaqRlwPRc/JjP2iGayjBfpha
         xPuyP+PWhXBgQMKjUuo8+4jAGtHGtwkY6f0rGuKIE0/k5bbj2nT3Vtgv+5n/UUanByqm
         laA1WfT1HtDnIMWwx5jQwzaIa86rLdt5MZ5P6kCz6RUaQNrKDl02RPJv3FtTcTTldFws
         NSBKNWRSem1X0aufeB69P3P+UV3zz2umMgpmcqME7gazJQRfx2hSlgb5bCkuthqZ5yqB
         DBjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtCHAAf5nkG6vsIXlE140BawnxEY8lm4Y/gorar11KItyJzz+HvQYZhIb0LIrHYHJA/z//48JnIDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5bNnKC3E11OMIFk3vUoFev/OG5qcI+pyJhU65KuWNWQcXj7to
	/nqE2cRVoNYn2vgCMxptmEgLD72pdhnZJmnaY+FJpl3mFhxTCe/1lK68
X-Gm-Gg: ATEYQzznW1I/zKSxOxNC0QeaBTB5VczMTKzngazE1pcCTNiM3Kg4RjKawGKR0yZRUi/
	kKnsukawctQsCT0qwk744Z0ULX+kritDWV+tOraU23fPja1UBW/4qRj/U39NAYfwdgfwVnwFgbf
	IVCoD2ICSYU6eQOWX/j8Pji9D8vTxwLGykzDKcHWoAWSHVg06k1I/oO3/WdZ5ICDRWOi1yFvXTO
	yr3HZSuiNVi74t9oPMYyAW9q2ZmWlERYX3j0puWeYMmBiRFZ1zGfkjZsx2+1Z6+WQsVar6dSNX6
	pVMUx+h1YZ4qgF8jVqRexA5Y0mDUYPuarH7GdAjolrxD1VkTA6k8UhZ73fM0yKZbj/DsGr7En7t
	cUI0DvSruky7oGqg+7NsJnC19BOqrkSo9J/x4DTEdH8FICIjWnSJPj4mFNMLRPBjCMssCiVxOJF
	dShqgB43eUwECJM84w5LTr6Okk
X-Received: by 2002:a05:6a00:1888:b0:823:9c6:1985 with SMTP id d2e1a72fcca58-8274d972c30mr600523b3a.16.1772147484051;
        Thu, 26 Feb 2026 15:11:24 -0800 (PST)
Received: from arch ([2409:40c2:5006:5b06:f9ff:5cdf:1c23:a906])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a01054dsm4238752b3a.43.2026.02.26.15.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 15:11:23 -0800 (PST)
From: Bhargav Joshi <rougueprince47@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rougueprince47@gmail.com,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v6 2/3] iio: frequency: ad9523: fix multi-line dereferences
Date: Fri, 27 Feb 2026 04:40:56 +0530
Message-ID: <20260226231057.20669-3-rougueprince47@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260226231057.20669-1-rougueprince47@gmail.com>
References: <20260226231057.20669-1-rougueprince47@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Platform data pointer dereferences for pll1_charge_pump_current_nA and
pll2_charge_pump_current_nA were split across multiple lines. Bring the
dereference chains onto a single line.

This resolves the following checkpatch.pl warnings:
WARNING: Avoid multiple line dereference - prefer 'pdata->pll1_charge_pump_current_nA'
WARNING: Avoid multiple line dereference - prefer 'pdata->pll2_charge_pump_current_nA'

Signed-off-by: Bhargav Joshi <rougueprince47@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
Changes in v6:
- No changes.

Changes in v5:
- Reflowed all commit messages to properly wrap near 72 characters as
  requested except for warning messages.

Changes in v4:
- Used full name for SoB.

Changes in v3:
- Collected reviewed-by (no code changes).

 drivers/iio/frequency/ad9523.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index 5725ab62e0fd..6daa2ea354a8 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -797,8 +797,7 @@ static int ad9523_setup(struct iio_dev *indio_dev)
 		return ret;
 
 	ret = ad9523_write(indio_dev, AD9523_PLL1_CHARGE_PUMP_CTRL,
-		AD9523_PLL1_CHARGE_PUMP_CURRENT_nA(pdata->
-			pll1_charge_pump_current_nA) |
+		AD9523_PLL1_CHARGE_PUMP_CURRENT_nA(pdata->pll1_charge_pump_current_nA) |
 		AD9523_PLL1_CHARGE_PUMP_MODE_NORMAL |
 		AD9523_PLL1_BACKLASH_PW_MIN);
 	if (ret < 0)
@@ -842,8 +841,7 @@ static int ad9523_setup(struct iio_dev *indio_dev)
 	 */
 
 	ret = ad9523_write(indio_dev, AD9523_PLL2_CHARGE_PUMP,
-		AD9523_PLL2_CHARGE_PUMP_CURRENT_nA(pdata->
-			pll2_charge_pump_current_nA));
+		AD9523_PLL2_CHARGE_PUMP_CURRENT_nA(pdata->pll2_charge_pump_current_nA));
 	if (ret < 0)
 		return ret;
 
-- 
2.53.0

