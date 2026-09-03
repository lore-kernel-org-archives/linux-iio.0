Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD2F349CE8;
	Thu,  3 Sep 2026 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788426463; cv=none; b=NNIzw30XrKTuQu/+e3qBG1+aqohfDQ4ZgIWKavG+YgFx0V5Ks9I2ZBXLertkBxCMAeAJVuhKxTdUCm2zzM5uEJNisV5B/sHtCfYE885xBEkQjBDzbFyMVpL/gbp6XdefxWSB9nVm57K6+K+KvXSc+3jGsRrkauItasQLCS6dANI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788426463; c=relaxed/simple;
	bh=p0Tjx2+U5h/rf6okYtbIzXjBfD1XPS0qzV8r2aFB4Do=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bzJ4LaLKrzl3iWvXocbrQ86KoH19rJKdoI3GtAD8A5pyIY5eyWKB0oRVhsUWVk9fi+EfLqijQmOMhXMyginSX2GwRDY8YgX7aOsl2InhB2iTS+eMd/+HNLngHgkTRdcmOZbQiMQ8NFH38d46QkjaR05qt4GPFzFkpChXkznf/2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=l/c4kLJk; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="l/c4kLJk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=LS
	IxZtrynnxZjfo/nDvCprwcB99w6SITCLPtGGzA9x8=; b=l/c4kLJklv4V4HOfNS
	TocHnlPlbCdVUpoMOOiR1Z3itAwNk1jVe2/IKlxvyCmK9VxIoixffNhwR2YypoCD
	jaFitpV3Pd6K7u1UmxlvAwQr/dcUhxnIZDSj7FwtiP+VxBD67HSNsMPb5eZjFekg
	Z0PN84P1ub67rIL5XDsBIm8og=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCH097JOJlqWQVtAQ--.56878S2;
	Thu, 03 Sep 2026 17:07:21 +0800 (CST)
From: "Li Youhong" <dayou5941@163.com>
To: biju.das.jz@bp.renesas.com,
	wbg@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Li Youhong <liyouhong@kylinos.cn>
Subject: [PATCH v3 0/3] counter: rz-mtu3-cnt: check clock and runtime PM errors
Date: Thu,  3 Sep 2026 17:07:16 +0800
Message-Id: <20260903090719.3498955-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCH097JOJlqWQVtAQ--.56878S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr18GF48Kr1DuF4xXr1UJrb_yoWktFX_Cr
	Z8WFy3Xr4FgF4kCa9rta15XrWFgrW8WryrXayqvrWfCr1Syr1qkr47GF9FywnrXws8AF1D
	tw40qF1fZr1qkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8IzuJUUUUU==
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC+QpB72qZOMoHkwAA3I

From: Li Youhong <liyouhong@kylinos.cn>

v1 checked only clk_prepare_enable() in probe/resume. Reviewers asked
to also handle pm_runtime_set_active() and all runtime PM get call
sites. Split into three patches, including a follow-up for a
pre-existing runtime PM usage leak on counter init failure.

Changes v2->v3:
Link to v2: https://lore.kernel.org/all/20260831054407.1695146-1-dayou5941@163.com/
- Use pm_runtime_resume_and_get() instead of pm_runtime_get_sync()
  plus pm_runtime_put_noidle() on failure

Changes v1->v2
Link to v1: https://lore.kernel.org/all/20260828071123.179670-1-dayou5941@163.com/
- Also check pm_runtime_set_active() in probe
- Check pm_runtime_get_sync() everywhere
- New patch: put runtime PM ref if counter init fails after get

Li Youhong (3):
  counter: rz-mtu3-cnt: check clk_prepare_enable() and
    pm_runtime_set_active()
  counter: rz-mtu3-cnt: check pm_runtime_resume_and_get() return
    values
  counter: rz-mtu3-cnt: put runtime PM ref if counter init fails

 drivers/counter/rz-mtu3-cnt.c | 112 +++++++++++++++++++++++++++-------
 1 file changed, 83 insertions(+), 29 deletions(-)

-- 
2.25.1

