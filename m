Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A472EBBA4
	for <linux-iio@vger.kernel.org>; Mon,  9 Mar 2026 10:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773053143; cv=none; b=lYXACAUQOG65JMQDfwt2EP8JR+3hOD4Dcubf3do7/7vadEiFyPTNypU1ZkQL67p+9eCpwiqH5wuw0iImXSX40epWFQCmCdlTEl1cmJ1/jAKokZhzDdasP2VbP2OyZweoE6rYAf6y8HQeVL0obR/O9GL65pNH5dqsmi6RS3Q0OMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773053143; c=relaxed/simple;
	bh=Ez+0uGQ52+IUV8Lt9xv4qouXLy2kKV9GFqAUQ9JNWMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJ5Qu8GM1SVHQ1KXcB5ZpCXPMAFW9nZQSvZ3HHgICamyipCrDJ67vX+IYDrxVYAoYYXp4am3X1P+uDoQ5pgS2Gbl6jdRdBnBBiKPZ5KE1Ok+9loJB8xdbMJCiUsL4kV/3ekOMOAOam3nErsc+BstnxLwpK1EmiU9JCquODMhLTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOjuhCAB; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOjuhCAB"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82989744ee0so3294640b3a.2
        for <linux-iio@vger.kernel.org>; Mon, 09 Mar 2026 03:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773053142; x=1773657942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOeJvDxArRmAukka7WzQkPiarwYqVEMJb3GhbN84k5c=;
        b=EOjuhCABLTueeZmecva7ztyVNmbhaQFmC+s1s0PUoLIE0CcVMaoLDYYhperxKqFYMB
         zCbe66KQPr5CbkJtY3BJdxIzBbSyhn7lGJMoXSdduEVvNYPZ4imUwE7LCv0gaXvntZHx
         EJnrG+Zoz31T85EnhMsPqK38Dou6JZfFPQMV3/7NWWUB//MxBcZ6vgbfA/8QMYyVhI3l
         vHlfSICFDpWe02RFzRVhcaQJ1+PIsPK9etXUQCgZCACUeJ0EdXq6I9QRUffZTOrpXefC
         djQ1EfvPTOd0uUu2NY+HvcL5oqlDFSUqCVZwVSuEJWmogro7/lzbooqK9gdtpKEfLgQ4
         KCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773053142; x=1773657942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HOeJvDxArRmAukka7WzQkPiarwYqVEMJb3GhbN84k5c=;
        b=mZfu1/WZewcvaQJZgzWcK9d0vthcR410nr7FRZfY3xXWW9uwHDrqXssm6d3+ZgrRBA
         mCmLbcWQAuQyswFYeK9Bt0KLXD+yGo9NRFg47g9OdCNjy+9OHQBEgqqG9RjYBKqT1F/i
         8yw3iDv0nQ2kxFpD7oNrDHPT1I7O5JSe76nm8bNuk5EtXyQZjbH5u6QR/uZmzCtvf5Ni
         rWIIGRCiE1tAD+IcOfDYRoOKyrye2EWILAzg9LjTOG314Qoqk+H3p9d3R+VwkhoLaEqR
         2+wTV1RZAWDt/91HTuZaCDlVTIhEcyTpkFNXYv1xLenF9X2nwCJK9i6D4ASBUsyidMK6
         PhyA==
X-Forwarded-Encrypted: i=1; AJvYcCWejEIM+vAQHncNkf07Kyi9XknD90dlKqwQrAVWe+f8ztOQk8WrZ2CK747RRMUyHqg+ZstbOWBBmYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJuOw3v37IzafyXuQ2Vz1zqOAv46Oi21hrj5T1wco5CXFz6tir
	RJn0DbpeOfnllKBWWzF+foTf+LIT1XoWSO1tlQtACjdRcq3ezcnSR7BE
X-Gm-Gg: ATEYQzzdip6vyiqQjIr+pcEQA2WKWSv3ONSLHQLvNjJnP57Kprf+c4MPz4jEQSW2xcX
	6d00go57RM0rs63klOAGjKsGMVSftuHE3JEtfrH2u3UjZHB9nDmXXP1DNC9EHPVPLiXw2O3mFxo
	jHYJuCZM45dEtHCcbbnjvgUy3CNmL7CLqH3heLRHr0FrX6tjKA3XPh07/u15U7KubfDHi29Q2Bz
	SV/hsdU0YQhyDhFO95Dam+Gkgf0A7I1dDATaxFfj8sg+H28c/Y1XvyJv0YLxDFGtb4JPoqcroR9
	o0cNOBBJ5cI0uReft/nkZwdf8wfFPXdukHYPBW06NNZBaJX5rgSlhU2xBBLhsVEcyxLfHbdNOdv
	d7GY8LssBiXRIhYtmIPK2yeuF7+vDgK6EHcTrw+nXJMfatfT4BszoivcIRBLhroRlgek9B5P3ky
	o/zdU97TZsZQ6a+wJJAgOMCfyV
X-Received: by 2002:a05:6a00:2d1e:b0:829:837b:9068 with SMTP id d2e1a72fcca58-829a2e1610cmr8954037b3a.29.1773053141796;
        Mon, 09 Mar 2026 03:45:41 -0700 (PDT)
Received: from fedora ([2401:4900:1f32:2ea1:a1a7:f2aa:545b:3c1e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4657445sm10276143b3a.17.2026.03.09.03.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 03:45:41 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	i.shihao.999@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com,
	nuno.sa@analog.com
Subject: [PATCH v3 1/6] iio: accel: fix typo celcius to Celsius
Date: Mon,  9 Mar 2026 16:15:08 +0530
Message-ID: <20260309104513.40359-2-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309104513.40359-1-i.shihao.999@gmail.com>
References: <20260309104513.40359-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix incorrect spelling in comments
- celcius -> Celsius

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/iio/accel/adis16201.c | 2 +-
 drivers/iio/accel/adis16209.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
index 5127e58eebc7..ba0f97944c6d 100644
--- a/drivers/iio/accel/adis16201.c
+++ b/drivers/iio/accel/adis16201.c
@@ -147,7 +147,7 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
		/*
		 * The raw ADC value is 1278 when the temperature
		 * is 25 degrees and the scale factor per milli
-		 * degree celcius is -470.
+		 * degree Celsius is -470.
		 */
		*val = 25000 / -470 - 1278;
		return IIO_VAL_INT;
diff --git a/drivers/iio/accel/adis16209.c b/drivers/iio/accel/adis16209.c
index 41ffd92f27fd..04e169f221c4 100644
--- a/drivers/iio/accel/adis16209.c
+++ b/drivers/iio/accel/adis16209.c
@@ -186,7 +186,7 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
		/*
		 * The raw ADC value is 0x4FE when the temperature
		 * is 45 degrees and the scale factor per milli
-		 * degree celcius is -470.
+		 * degree Celsius is -470.
		 */
		*val = 25000 / -470 - 0x4FE;
		return IIO_VAL_INT;
--
2.53.0
