Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B1C4BC001
	for <linux-iio@vger.kernel.org>; Fri,  5 Jun 2026 09:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780650620; cv=none; b=Q7+uyaZcO6hMNkuuGyp3R7KmmDh8vPkVCkVwXl74yaoUmlqv5TJt4ZW0dDFMhBtm/YUm0BculUXsvbzQ670M8q3hgqdUh/pDvUTMy0xXtfqGupVuAIz8o3+vuK3Pu0L/tu/lGhXTdJX4XICFK7zTUeApxDUBWbgkYlhUkhUuLYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780650620; c=relaxed/simple;
	bh=8xSJDpaZmVSWs7VTwG3G2+sj64FSN4lHGATqtc2cRfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rQL2AfU60+48At7rnz5o5kFg9XcU3AhQAcRDndJs1Ir4hfetQR2r0vqEhKLphFx2uAuC/lYIAh8MwafobaOj3vX8N0KZr9buer8aAEr9ybpQdFI0Wyr2iRLGfrE7/QoJqXpk0cF4ZhRDVwlD6Q4xhYuQBOFW/nYdzjAj5ka95gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaqQTwpZ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaqQTwpZ"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aa61e3d3f3so1688929e87.0
        for <linux-iio@vger.kernel.org>; Fri, 05 Jun 2026 02:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780650618; x=1781255418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aWL79kEYyK1+kf+8WUTiGqjmIWfhl+1ma0KEBjpveMg=;
        b=DaqQTwpZc8UofI/Sa0RpuDoJ+9xwNkiN7x9+HXAsp3aUwgOSwM1eRGlja3Z0wlZpjS
         9whFR5AS8mmJexjaVlBpHReDuFNvjq9YJ3MXYldTuw1dj5dBjMY8vh9KiUaQ7Ep4td9M
         wmLATM8PwjIvQVnScBXrWf9e07rxCKOrJaFVkNTya2/Rw5UcM9JdAZUhPghjYuMfooE4
         xzroLV9XfoT90LdE2W3EuhLLpwF626MdAZT1KwsioGgWb4oLsOWupjLL6+eP1ufN5sfG
         +HNshL2jGn5kB7NPoRmV+hmSLk1ICyEXZNVhloR+iEBedIll3r6B1NN70STXPiYOUata
         ByXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780650618; x=1781255418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWL79kEYyK1+kf+8WUTiGqjmIWfhl+1ma0KEBjpveMg=;
        b=rH9jzu1ULXwhBjcNHxja6MzvI+0WQQXjTW1oldYEi+3aQB3FS90OvZDH6JnyrZAFZ6
         1uSMfkNb8u8sXhgUOihBQn+T7LUGzudqUobZOGHe5EeaeVNOEalZc/hSyW2Z3IS/5UUS
         /0KAlyPDva+sYsVT0HQ4jmOnTW2SxzsZQisxCzC/RSamuJZ4urzLF5UBxKxkfiImCNBU
         QnaVYE+kFdzIluAn5hDhW4p9IUPye1km7lC1sFJwLG8064xBEQoYsD+dpjhTrsh1LC0Y
         1hCCQdn7jiX5Rr7IPbpYW3YQ12/xC3wuTTek4eaEZiqXGw53STV5+7HkhWQKv408SUkD
         6AOw==
X-Forwarded-Encrypted: i=1; AFNElJ9gZ0qRGKDtxOJY4tyiZeoiIZ1ZBlozs1Fm6Gj69FoW1+sROhxEZIAZ96ZDKz+AZtxD/RP4Q9oGWd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyuoiRJkUGSfCdkDR4EmOska2SthglSDrAVTtUec88HNCXRjQq
	POmJR/NS9ZhqDRBETUKkF4PjbuS4uSw1RNV0HaMStkMrmvxY5/wst+i8
X-Gm-Gg: Acq92OEsklNiSdPeqPyr7z38mkbvCLJ6XfyMzfI4ITJULZder/Q9zKOgK8gJ9AxnpLx
	VLzOj3vu4nPISy5hA92iI2OxDOyeJeDwVWCSnU2xv3bQ2PAPlzIrwGyVDJfJf5FcrbOV2I1JzOF
	T+dTwbTMDWDNLej/uKLsFMGewfcrdT8oupM/Vxm9xemSZtzl1EAN3hA6f2BVZ/g4gJnwXhqfTXt
	7e6SQ6pEFXQ7bkXzQLKMOJImIWmfCFrUxRtI7eJd0zLkOuQUjdEPmm1/E9qmrL93iKEr1PaHK4N
	Ldy88sXApRKYqyMS56vyodAcXPafRFWyXI98dN8V0TL38Zoxs1MH1kZvottlJZW9bHx3R/EZOo/
	ITHiZJ4KatDAwP2jz1fi91iZlu3PqajFfoez2u7JmUKkm10JmBHGRZ9Ar8liON4p1tEF2oWkPx9
	uobLykFtDu6ItCF+9ShFmdi+xIt37p91bXRaEHo+aryQp6dh/uLHS8lw==
X-Received: by 2002:a05:6512:a93:b0:5aa:7064:e053 with SMTP id 2adb3069b0e04-5aa87bd328dmr833256e87.36.1780650617123;
        Fri, 05 Jun 2026 02:10:17 -0700 (PDT)
Received: from new-nest ([2a05:3580:f312:6c00:1b49:dfce:283c:7307])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b9903e9sm1705914e87.69.2026.06.05.02.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 02:10:16 -0700 (PDT)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Marek <jonathan@marek.ca>,
	Brian Masney <masneyb@onstation.org>,
	Rob Herring <robh@kernel.org>
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH v4 0/3] iio: imu: inv_mpu6050: runtime pm fixes
Date: Fri,  5 Jun 2026 12:09:37 +0300
Message-ID: <20260605090940.1103750-1-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset fixes problem with inv_mpu6050 driver,
when it fails after device is suspended by runtime pm during a probe.
To simplify runtime pm handling in the driver more devm-helpers are used.

Andrey Skvortsov (3):
  iio: imu: inv_mpu6050: fix unbalanced regulator_disable() calls, when
    probe fails
  iio: imu: inv_mpu6050: use devres-enabled version of
    pm_runtime_enable()
  iio: imu: inv_mpu6050: control vdd supply using devm-helpers

 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 49 +++++++---------------
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  1 -
 2 files changed, 15 insertions(+), 35 deletions(-)

Changes in v4:
 - update commit messages to address Andy's comment
   about functions, callbacks and runtime PM names
 - move pm_runtime_set_active just before vddio regulator is enabled
   as it was proposed previously in v2.

Changes in v3:
 - make patch "fix unbalanced regulator_disable calls, when probe fails"
   with Fixes to be the first patch of the patchset for easier backporting
 - don't move pm_runtime_set_active, move devm_add_action_or_reset for
   inv_mpu_core_disable_regulator_action instead
 - update commit message in "fix unbalanced regulator_disable calls,
   when probe fails" to fix Andy's comment
 - remove blank lines in "use devres-enabled version of pm_runtime_enable"
 - no dead code in inv_mpu_core_disable_regulator_action anymore since
   st variable is used to get 'struct device' now

Changes in v2:
 - minimize call trace in commit message
 - use runtime pm framework to track vddio regulator state
 - include specific driver name in patch subject
 - add more patches to use device managed functions

-- 
2.53.0

