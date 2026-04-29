Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB41D30B525;
	Wed, 29 Apr 2026 07:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777449083; cv=none; b=OqgHblqJHZ5vAQpjN6/7MXPfmaITTBSOBP1rcBisJe92CWziGeR9p6ye9p47tcUXSe6hRH/bEmrYjltKrA0pC75cfm/ygqPu8uZEEqMf7UrBWF/kt0+EQ0NAmEiLgmidp/MXnplIVb880Jf5Zmv4FuxZ+9BMulud9DbfB975Das=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777449083; c=relaxed/simple;
	bh=cMm6rnnI9EKlH8qoMa/gHGKRo/lwCw5he4laa5DP1sU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zf6V6mqLFk1e8mDzp+tcEts4/oLzpEOz3h5kFc21f5d+YdftbQ2NqaxmmA/JBwBZRvJtooJ39JDT2YcjKDIywQrILiR38e12v19nP+B75cTVavlPfP04YMy3k/cYeGMY9zd609RhPcovNU+3nyI+71zP0Rj9I2pvTi48qlCps6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gJ9RmuuV; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gJ9RmuuV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ua
	NDXi/yU8TE3Jp7eiuXIdaUX55fk3LUwwuRqcerIE0=; b=gJ9RmuuVk846p5gylI
	QS2mSSg7H2ZCWdxMVdTkGBHWLG8rjqOftu9drWtdtjPCt1ONGxO3BanQ6zA4LJfH
	QDI5qEQTDQByXPvLHMIUjXl2milZYiSiUFFMhyl2PTQK9ekaP6oHxgCHdk0NBOFj
	/MGShb9COc96c6DPRpYJaf5yY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wC3R6lSuPFpTU6XCQ--.62475S2;
	Wed, 29 Apr 2026 15:50:44 +0800 (CST)
From: Miao Li <limiao870622@163.com>
To: jic23@kernel.org,
	andy@kernel.org
Cc: dixitparmar19@gmail.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	waqar.hameed@axis.com,
	limiao870622@163.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v2] iio: light: stk3310: Deal with the ps interrupt issue in PM
Date: Wed, 29 Apr 2026 15:50:42 +0800
Message-Id: <20260429075042.214768-1-limiao870622@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <afGsN5RDDQJZt8ok@ashevche-desk.local>
References: <afGsN5RDDQJZt8ok@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3R6lSuPFpTU6XCQ--.62475S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrWw1fZF4Utr4ruF1fur4kZwb_yoWxXwb_Zw
	10qFZ3W3Z5XF4vga1fWrZFvrWqgrWUJF18Ww48A39avr13Jw1kJa13uF4fA34rGay8J34q
	kF4DCr43WFsayjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUjVT5DUUUUU==
X-CM-SenderInfo: 5olpxtbryxiliss6il2tof0z/xtbCzhQa52nxuFQmXgAA3r

> >  	struct mutex lock;
> >  	bool als_enabled;
> >  	bool ps_enabled;
> > +	bool ps_int_enabled;
> > +	uint32_t ps_thdl;
> > +	uint32_t ps_thdh;
> 
> I still think we shouldn't add more {u}intXX_t into the drivers.
> Just add a patch on top of this to clean up those types to use
> kernel regular ones (uXX/sXX) instead.
> 
> >  	uint32_t ps_near_level;
> >  	u64 timestamp;
> >  	struct regmap *regmap;
> 
> I also haven't seen the response on `pahole` run. Is that tool happy with
> the proposed layout?

Hi, Andy
Patch v3 only fixes a few syntax errors in the function resume()
that were introduced by patch v2,
what you said I will revise at patch v4.
Best Regards.

