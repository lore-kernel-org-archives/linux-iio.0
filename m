Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CB240DFCE;
	Mon,  4 May 2026 03:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777863908; cv=none; b=YiUyDomPS739EH122KHuqbkY3MJ7x1Ibe9iIQu9RUg4oySOy/DxFXgkmBLItNFXs+u9lIX4CvsaRjAx2JjKQn8qowHOy7SOBwgRzmuMS7kZukyHp/dVeUhPZW4l8Pizn2eMwRYskC/bSeqWAad01zaB/rbGRyPBUlV8+5noN0+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777863908; c=relaxed/simple;
	bh=ltqr528/RonuJ/3VAw5LEjN9zDGFttDbqxGWXz4l8RM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AGUFpXmrIpRU6EUYpb/2pGQ5WkPZ0m7dFy9uJlNEY9dA+poWT8DTzwDrkLL+Kr6vsjEh39g89eFsh9w8TKth2ijn2ldJ8RlPcVuxa6uJA+PvtmLsP6wj3PsPQU/SEj8Q9NDcQEkQuvWwrhoACbt0nO+2sLwoaMSEyVDOGXqhcXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RPq+p6vs; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RPq+p6vs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=mh
	DzqckWgefPXDklEfoMqic4XOMmyZNYcyhl0bgDWbg=; b=RPq+p6vsSQ6ZVkhoAn
	uUdOTDSW9uTIZSnIRybQC0bHBXog9w9gJiRah5Is6/ZtfhlRIDPJt58dLikECm5i
	IyUIucsNZN9Meej5cBND9y6M9pPdo8BmlAquZvD6QblSCUUBl/xBBvM/P3Ed5Ybp
	MMm/dfvZ3U6miolnDof+O+wLo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wBntLOwDPhpacQZDQ--.45044S2;
	Mon, 04 May 2026 11:04:17 +0800 (CST)
From: Miao Li <limiao870622@163.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	waqar.hameed@axis.com,
	dixitparmar19@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	limiao870622@163.com,
	Miao Li <limiao@kylinos.cn>
Subject: [PATCH v4 0/3] iio: light: stk3310: Fix PS interrupt after suspend and clean up code style
Date: Mon,  4 May 2026 11:04:05 +0800
Message-Id: <20260504030408.105762-1-limiao870622@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBntLOwDPhpacQZDQ--.45044S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFWrGF4DAF18Cw47WFWrGrg_yoWDCFb_ur
	y0k347Wr4UCFs3KFyxAr4aq39IgFWjkFyIgF15KFWfXa4DGr13Xrs8XFWxZ3yrGFZayrn8
	Ja1ftr1Iyw1akjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRM189JUUUUU==
X-CM-SenderInfo: 5olpxtbryxiliss6il2tof0z/xtbC7xHHlWn4DLEhmAAA35

From: Miao Li <limiao@kylinos.cn>

This patch series addresses an interrupt issue and does two code cleanups
for the stk3310 driver.

Patch 1 fixes a PS interrupt issue where the interrupt cannot be triggered
normally after waking from suspend/hibernation, discovered on the Inspur
HS326 laptop with HiSilicon M900 processor.

Patch 2 replaces uint32_t with u32 and reorders members of struct
stk3310_data to eliminate memory padding holes, improving code
consistency and efficiency.

Patch 3 replaces hardcoded count parameters with sizeof(buf) in
regmap_bulk_read/write calls to improve code maintainability.

Miao Li (3):
  iio: light: stk3310: Deal with the ps interrupt issue in PM
  iio: light: stk3310: Replace uint32_t with u32 and reorder members to
    eliminate padding
  iio: light: stk3310: Use sizeof() for regmap_bulk_read/write count
    parameter

 drivers/iio/light/stk3310.c | 84 ++++++++++++++++++++++++++++++++-----
 1 file changed, 73 insertions(+), 11 deletions(-)

Best regards.
-- 
2.25.1

