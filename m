Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87D03C09EA;
	Mon, 31 Aug 2026 05:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788155083; cv=none; b=u8V02ZT492T13NTxFpmeS+TfX1J4SczB53j5+1tFsPqnC54f5Htby3WKwoVnQaBZIlneg0ffTld/YfBZGXQW9EkWazHCDYvM25oPPOwNqevVVJmoQFu8YTleLZMVqpNf530inxq1W5x4qsLQ9HiIhMWtZYyB1s7MS7zWfofn/6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788155083; c=relaxed/simple;
	bh=whhlhW45YrV1ZZ0Lpvp2ksAfeLFYbZeMUfRzQgh8pdo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TODJVI50HYxe77dKesYz+p8SCSf0bIQZpk8rg/OQEw7qtRxFD12T74FR0Kj/xAQhAvGKjcnllQKt3C5WYe1P9NI4w0P18L3UG9AEZHEK6k3cVWsSnpgyEZEdnq7sovq0eJmZk/u2aIuGRaKZiF43CCauXBInVUoVDv2w0yPJaM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=L4heFgj2; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="L4heFgj2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=85
	PVWAYF456dtbQQdKApPzYdVbSLPm9X8lNgK3ZJTI0=; b=L4heFgj2f0zT4HEIR/
	vs8X+DYzL281g7l5wz2E+lv//2J1K+6PYWL/Kmj96UzsjocXYlkBMh/pxyoVp4Jn
	PneSOhipo+BxhrgsIc/tq41Etn7Ub+AqcP0lkukC6/fCwCtth+BovAMJfPDTnL9L
	PSD2Ps4/GulIQMoJP0E8o+P58=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3nxWrFJVqhT4sQA--.61087S2;
	Mon, 31 Aug 2026 13:44:12 +0800 (CST)
From: "Li Youhong" <dayou5941@163.com>
To: biju.das.jz@bp.renesas.com,
	wbg@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Li Youhong <liyouhong@kylinos.cn>
Subject: [PATCH v2 0/3] counter: rz-mtu3-cnt: check clock and runtime PM errors
Date: Mon, 31 Aug 2026 13:44:04 +0800
Message-Id: <20260831054407.1695146-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD3nxWrFJVqhT4sQA--.61087S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr15ury5tw4DtF17Jr48Crg_yoWfKwc_C3
	98Xa43Xr4FgF4kua9rt3W5XrWrKrW8Wry8XayqvryfCr1ayw1DGr4UGr9IvwnrXwn8AF1D
	tw48ZF1fZr1qkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8aNt7UUUUU==
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC3Qww3mqVFKwH4wAA3c

From: Li Youhong <liyouhong@kylinos.cn>

v1 checked only clk_prepare_enable() in probe/resume. Reviewers asked
to also handle pm_runtime_set_active() and all pm_runtime_get_sync()
call sites. Split into three patches, including a follow-up for a
pre-existing runtime PM usage leak on counter init failure.

Changes v1->v2
Link to v1: https://lore.kernel.org/all/20260828071123.179670-1-dayou5941@163.com/
- Also check pm_runtime_set_active() in probe
- Check pm_runtime_get_sync() everywhere
- New patch: put runtime PM ref if counter init fails after get


Li Youhong (3):
  counter: rz-mtu3-cnt: check clk_prepare_enable() and
    pm_runtime_set_active()
  counter: rz-mtu3-cnt: check pm_runtime_get_sync() return values
  counter: rz-mtu3-cnt: put runtime PM ref if counter init fails

 drivers/counter/rz-mtu3-cnt.c | 119 +++++++++++++++++++++++++++-------
 1 file changed, 94 insertions(+), 25 deletions(-)

-- 
2.25.1

