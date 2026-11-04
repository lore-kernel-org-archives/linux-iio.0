Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793764817;
	b=BhyhEGwKCqYpQ/TMmLjprapWzEvOB2NQ3dWIUsrbzNOy/AwT8KZEAk+56Pu6aYCDVaJv
	 GIyGqKFpRipbsZaV0O/FXdQqJk9tmMQfxKZHsGM49a+D/BFPUisc3LP2UX8K4kAFAiLVF
	 kRvvcib/wM1gN4eH7ua06xh3rH4wghbhxcIBa0yl8GhvNHngAHPmT/IK4DbxkfVAzMMYf
	 voIdHeQnUlqpdkWycUgCCeW3+QhgV6usAJuJP6k72OAltgo98wIbeIr+lplZLxZiVvAtk
	 ieIoyzRoMSLrnVak/yvyg2M5NPtEAJPScC6MxZWdvbfdE6+UHsAutIM6GC3lqbP/kew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793764817;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SWMYtumevZJRR1DeWp1IIIUFZTPm9g0gCqSnFRuUnqQ=;
	b=oB9Cei84Wru4egMkOeVmjupeJg3KnoOM2QecbRg4ljetE3vAxPiXAbwQ+jOs5/dDc2f+
	 /R+eeismezZ+3bu87rL2fcHckQqL3IGEVyW3KHoI3Z4K5f86rCwysAj4R9ChFZhbbhaST
	 bD1shza+z8rjX4uWhiO4D2nt79R6YVp7yuPHL9wCcJgENroglNT+MlhmzsdUsQam3OqRc
	 lh2oaxtiWLbHrXdKFTYLZLWwSCnOF5w2lHljHdXhh8HjwhUpzYJRLnlbZQ0pJSB8OzUVd
	 ofHG0rMrKcmIah9mh4vxr7KamKsFb8tonpST/aKu/ZU90AVEvwfbPQEeaUWT0dV87IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=PCVgH7DE;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D87606A32C;
	Wed,  4 Nov 2026 04:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18D87606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=PCVgH7DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=PCVgH7DEkR+fNFTE6h7f2IdjtXrque8J4K18zkYkDYYV7OmKw9Xf9Fjotiu3Y4rOVg2Fm4HmMi+NL
	 KE2nG8DtJ+vZu3+kNpU5nM79YKmd0frQTHNjTBj8yDQCD0FpnlIyBtksazz2YrRgBE0mUTXrjW3vbb
	 NRRgWkBlGEBqI9Aw=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76aeaadcb1e1-9a667;
	Wed, 04 Nov 2026 12:00:11 +0800 (CST)
X-RM-TRANSID:2ee76aeaadcb1e1-9a667
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from DESKTOP-3K8GUTQ (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66aeaadc9e9f-120b8;
	Wed, 04 Nov 2026 12:00:11 +0800 (CST)
X-RM-TRANSID:2ee66aeaadc9e9f-120b8
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	andy@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
Subject: [PATCH v4 0/2] iio: gyro: mpu3050: Fix runtime PM refcount leak in trigger enable path
Date: Wed,  4 Nov 2026 12:00:05 +0800
Message-ID: <20261104040008.1458-1-laixiangwu@cmss.chinamobile.com>
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

Hi Jonathan,

Thanks for the review! This version addresses both comments on the
trigger helpers: the dispatcher now uses an else, and the error
return for the IRQ status read in the enable path is propagated.
The disable path is left as is, as you concluded it was not worth
the effort to fix.

Patch 1 splits the enable and disable paths out of
mpu3050_drdy_trigger_set_state() into separate helpers. It is a pure
code move with no functional change. Patch 2 applies the runtime PM
refcount fix on top, using pm_runtime_resume_and_get() instead of
pm_runtime_get_sync(), which also keeps the usage counter balanced
when the resume fails.

Changes in v4:
- use an else for the either/or dispatch in
  mpu3050_drdy_trigger_set_state(), as suggested by the reviewer.
- propagate the error from the IRQ status read in the enable path
  instead of only printing it, as suggested by the reviewer.

Changes in v3:
- no code changes, the series was reposted as a new top-level thread.

Changes in v2:
- split the enable and disable paths out of
  mpu3050_drdy_trigger_set_state() into a precursor patch and use
  pm_runtime_resume_and_get() instead of pm_runtime_get_sync(), as
  suggested by the reviewer.

v3: https://lore.kernel.org/r/20261103092002.1332-1-laixiangwu@cmss.chinamobile.com/
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



