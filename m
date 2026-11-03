Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793697610;
	b=yV5SOAA+MdVuyCHO/tF8vrdJ5xrv/JoSuNHNQyFgSokzZDj+mJF3Q0Im8bkqh+Dhmp/W
	 pm4N0P57R3+FYVthg1G5/qw3Wvsns3GS/GAxilexWFH7gEfRT2eNOoMcBVBqUW0EunWo7
	 tcim5ptNcPjXSBvgZIqU7CcOJ0tr60Kk2qtQjOqMzCqA2jGcXcEB9pSbhk7u8/ryqnPKl
	 mBpRXnpznweVBpyFDRoiJ5d957kXTbczxBbvUPVinSvPasnJMjI/s6lvvEUKNOfwIRHlF
	 Rg/7obw3R12C0okpfpUPEH534t/1XDoyN7Imhpoq0RvGx3oyVWwTuESqLm/Jd4kwJbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697610;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qQUBwg7EWEuP3G99Ct4pTXSXiISjMvbZEC/5oHQfxf8=;
	b=XNxHcGn6hD/zs5qGgn0mDT5i618Q7UmQ0FxEuSHwGDsUGEC6x2WdafTBF950hxK3NX0u
	 2SVgx2t6K482QDQ2V3JSpKfyFUTWrxjUxbmt+xX3xqgY0hat8c4d1O0bewVPjButmHRtY
	 BaZvtAV/1yf1+BEC45nlkcj100jrcKRryOTW+8ObYro+JeGXZMKo6b30U1pYyjXOdAyE2
	 8ynbn5vnyFSzt0GshqHBOl961hCB4pdZ8+DN8REE3vcCEMDeaaUkP52jFnnueLX4WrzIF
	 tnWa0y3Bqsm3Q/zsBWscsU2jPnPvO0X4usKubhzeT+YLn6d9eN8NZiE4ZcZ2b8Tj68g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=OQGcGSi2;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CECD606A324;
	Tue,  3 Nov 2026 09:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CECD606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=OQGcGSi2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=OQGcGSi2VP/ucliWfa2nm+eZ2jzFxRvzwnx79oycPDS+G+qjQFf5I0qO1PTtxxmGmoH8M2IyWGgv8
	 WFdLqi/Ee/37oMkqIInyUnRlNI7X+YhWVEUpZmYuT09C5m5Dwa2ZjKqUJd5VFhXYklYUmMhPTbcXxg
	 k3PxeR8BO4AfR2+k=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66ae9a74554a-5fcc9;
	Tue, 03 Nov 2026 17:20:06 +0800 (CST)
X-RM-TRANSID:2ee66ae9a74554a-5fcc9
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from DESKTOP-3K8GUTQ (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66ae9a744004-f3e30;
	Tue, 03 Nov 2026 17:20:05 +0800 (CST)
X-RM-TRANSID:2ee66ae9a744004-f3e30
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	andy@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	laixiangwu <laixiangwu@cmss.chinamobile.com>
Subject: [PATCH v3 0/2] iio: gyro: mpu3050: Fix runtime PM refcount leak in trigger enable path
Date: Tue,  3 Nov 2026 17:20:00 +0800
Message-ID: <20261103092002.1332-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: laixiangwu <laixiangwu@cmss.chinamobile.com>

Hi Jonathan,

This is a repost of the v2 series as a new top-level thread, as
requested. There are no code changes since v2.

For context, this series fixes a runtime PM refcount leak in the
mpu3050 data ready trigger enable path: patch 1 splits the enable
and disable paths out of mpu3050_drdy_trigger_set_state() into
separate helpers, and patch 2 applies the fix on top, using
pm_runtime_resume_and_get() instead of pm_runtime_get_sync(), which
also keeps the usage counter balanced when the resume fails.

Changes in v3:
- no code changes, the series is reposted as a new top-level thread
  (v2 was mistakenly sent as a reply to the review comments).

Changes in v2:
- split the enable and disable paths out of
  mpu3050_drdy_trigger_set_state() into a precursor patch, as
  suggested by the reviewer.
- use pm_runtime_resume_and_get() instead of pm_runtime_get_sync(),
  as suggested by the reviewer.

v2: https://lore.kernel.org/r/20261101092327.197-1-laixiangwu@cmss.chinamobile.com/
v1: https://lore.kernel.org/r/20261030084305.1660-1-laixiangwu@cmss.chinamobile.com/

laixiangwu (2):
  iio: gyro: mpu3050: Split data ready trigger enable/disable into
    helpers
  iio: gyro: mpu3050: Fix runtime PM refcount leak in trigger enable
    path

 drivers/iio/gyro/mpu3050-core.c | 182 +++++++++++++++++++-------------
 1 file changed, 108 insertions(+), 74 deletions(-)

-- 
2.50.1.windows.1



