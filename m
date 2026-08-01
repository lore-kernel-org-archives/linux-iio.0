Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD01523393A
	for <linux-iio@vger.kernel.org>; Sat,  1 Aug 2026 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785575423; cv=none; b=GjEVEk5A4I7vJnH0409O6/lDrcehXL4oJ+eAUaYqX4A7ub0dR5oTyxIncqnk8S4BfAzAKWH5r++ulA3Xl/WNWOF9tw7PlvXi6xWgTBZWXzvWCLkGBtBzroE27yvL/MOFZOEgR1PGBrXT2scFkO/8mbX0ERaGEE5eh7ncpgcuTuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785575423; c=relaxed/simple;
	bh=jXT/RREAI2FfA7u3bpEsKpG3TWqfktCGDx1ce/WgpCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VVdN/J77tJCvO52lo2n8uYEjSDqLITC0TBdijPWC4kT36VarClH2oMnNn5YDhPavJr2XQGaUmkl5+zLrkFNm2w1mcQoaFnZhR9joEsnxE2OKIThKAST19VXnHHbg/TL2XIH1wuY1fKH/BeEjOBek5+JHwCiWQ1rFsM7xe/i2DFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+JAn8Oa; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+JAn8Oa"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e347638adso2230006a91.0
        for <linux-iio@vger.kernel.org>; Sat, 01 Aug 2026 02:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785575421; x=1786180221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bfyzMu9d0j7FgF4V0+W6tNCDJazCXFwoJSVzR2XoTJY=;
        b=i+JAn8OaHdE0mszzrLAUtW0TXEB1qp0UpBqB9aRonc6ZteorwTXhdvZoyu6X8NfW1D
         IvmE5I6L6PXHCcbKs62ihpVbV+9qDV7Vi3325oMdJ99zsSjVToCUrmpBAZ3pYzup+jYD
         O614gxk+IAhtHpgfsO/MgT+8p6oNmE/FLnmmw8abGdPY43APWhPqJkETUQxK+jTZh/RT
         n0FrTe0tht6em+eV46fgoqgvys6GicxoXTcoVAT1CqEekWS1zBvEF3kkSWW6dUkCWtiR
         jA9k32g0JkHy7B4v1URY9OK4IFdcwJVr93HhnXbj9ynUrF6fsiVZ3lst3rxiWy6uy8Ua
         lLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785575421; x=1786180221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bfyzMu9d0j7FgF4V0+W6tNCDJazCXFwoJSVzR2XoTJY=;
        b=mhO0+vCg9iXXkk/YTTIFOvRV8ZRNWCuVajrtvvcRLws8ngXHXOY0mUdPLQYQpwnpab
         oZY7YjthIBssX5RIhOfqhRjaMHdQg8qenRy1y6KTk5dibrOP50ByT/TL8zGMPU4ilrAW
         qUOAmXHGQ1DXLU3b3K2QqwWAIENqKjjAP8n7oxe/CVlf8XzNke4hwJGBHDJZ2ly8YkvY
         rPeCVlXg7UajwtxOjTJQ+iZry3j6lUNnz7jKxhFCt9+TZ4G6s8+xpN1C1a6cJmMmInDv
         MVY+qiFMKJZ2sUHdX1H8Y6+qOoNvaiMqhAi4lwhrB9ZdYwGJ0qayvKzmZP2VTXKfBdAG
         fzsQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr9sOF36+gMeZ66J1NhMGP4jTcu5PP/nYQxEhHgWfYOkFhFkJmmA6Upd07FfwFsIKpsN++XD64/JbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza1ACSA9rrACn/T/ZFsciha+5+IYLiFV9evC1lN9lPe4ZzLSeF
	V/RhVd/6mFZ5XPQjRQI2FmAWsVJkIDY2/OjckArPVAcm7FqjJ/STp9Ky
X-Gm-Gg: AR+sD10C/63x2F2tulsCfL4tk3Ss/lKXzTW4p/g9QT6v3C9NAat8zFEkbgHB7842feu
	fatfN/eTmmGMedmwkS15z+prFd9PI6eah6RWRNUEB1ziSDnw1kklfie/t0H1rLYF/DcyyKW0VhK
	RhfIVfrTjGpQMCsGfchfshMXubuUNAek3LNN/dRJfutnJimZShbQsA4inmmYqSTgZ7TjdO2c+pB
	j/eNEzjo1MiczUEWNpx2YNEElimT+4yrIt7dInZklS963NoG1+YahCEnPIE0PWzXwiWIOYeYOq0
	WSaOjmzkJF0WA5FDa6zKRuvxh9727B8mBokI+uk6RXzK7CJ7RzldH+nnG94ik1WjAv6kSi2dlk3
	EU6608QVFQmws5KrmpyL37LHZBWg0SrMD4nNM7D/ieSCMf9/W9M+IGopJNSbbVjY3tnNMaoQPR0
	5TMIhDLrP6RP9uL95Te5Y6FMmZWCeWKBCgKMdJEBxf842ewzAZq/A9NIZo3w==
X-Received: by 2002:a17:90b:2dca:b0:38e:9045:bac0 with SMTP id 98e67ed59e1d1-38fbc408af7mr2717365a91.5.1785575421063;
        Sat, 01 Aug 2026 02:10:21 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:36ae:7de2:5cca:938])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd9c96asm15432431eec.7.2026.08.01.02.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 02:10:20 -0700 (PDT)
From: mdshahid03@gmail.com
To: Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Joshua Crofts <joshua.crofts@broadcom.com>,
	Broadcom internal kernel list <bcm-kernel-feedback-list@broadcom.com>,
	David Lechner <dlechner@baylibre.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH v4 0/3] iio: adc: bcm_iproc_adc: Simplify probe error handling
Date: Sat,  1 Aug 2026 14:39:50 +0530
Message-ID: <20260801090953.61603-1-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Shahid <mdshahid03@gmail.com>

Hi,

This series simplifies the probe error handling in bcm_iproc_adc.

Changes in v4:
- Move the redundant iproc_adc_enable() error message removal into the
  cleanup patch as suggested by Joshua Crofts.

Mohammad Shahid (3):
  iio: adc: bcm_iproc_adc: Remove redundant probe error messages
  iio: adc: bcm_iproc_adc: Introduce local device pointer
  iio: adc: bcm_iproc_adc: Convert probe error handling to
    dev_err_probe()

 drivers/iio/adc/bcm_iproc_adc.c | 54 +++++++++++++++------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

-- 
2.43.0

