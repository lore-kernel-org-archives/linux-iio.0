Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF1D38E5DE;
	Wed, 29 Apr 2026 06:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777445184; cv=none; b=oAkTxqYLDl6poP5CL4QvuufTnd8LV/K6dY4rPTVjbPMBzTr4c3elxNJb5Atok7pyGoQngQ54D3eVbWU5E6XSMnX8PDX9IL0k6Q4Q522GfyyBOo4nEqXJwsJgPW83Hf6In6m2Ib7BKXUwrfCA2Y8zZHyQ1XAjXUAQF0KCx9iHVAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777445184; c=relaxed/simple;
	bh=0YAVIpMc7jXkWgAa+YCz3kTBrdo6WnWJPf55XJ/xm5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=twcpawGwFpDXRpYfOjO3yHk9RQ7ibLcM4ViXA3lZhAtiXQ4Kwv/goFS+8H3p4ZcHIqr5XmEQtpzXC0TJdv6+/xyC9L1KtLBiescfvXYTAvgXljGST7eJCJ67gCbE+t6XwnQS18UapFaEq7LsPdt1rJf9IBlzm+qgD8yu9nOiLCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IK34oSL6; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IK34oSL6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=F+
	XLX5uoveUAYQYagzvLvm5XTcWWqHen8ASV9IYUOZg=; b=IK34oSL682jTK2Hwsq
	EgAYVtDMokwPwUoXKolJWUi177XpYZLrxbutzZ9YpfODVggGh9eCsDYJP5xJoYec
	ffYK9rkHqBhAP22ngyvH8FLlfXx0hLBgIBL1lDSIqiSJ/O64+s4wlnDFtANQnYPs
	0KoD0uhPPxdoL6pHDnMdq/Mx0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wAny1kPqfFp6KrDCQ--.5462S2;
	Wed, 29 Apr 2026 14:45:37 +0800 (CST)
From: Miao Li <limiao870622@163.com>
To: jic23@kernel.org
Cc: andy@kernel.org,
	dixitparmar19@gmail.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	waqar.hameed@axis.com,
	limiao870622@163.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: light: stk3310: Deal with the ps interrupt issue in PM
Date: Wed, 29 Apr 2026 14:45:35 +0800
Message-Id: <20260429064535.204852-1-limiao870622@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260428192213.7c5c80e5@jic23-huawei>
References: <20260428192213.7c5c80e5@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAny1kPqfFp6KrDCQ--.5462S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr17WF48Kw13Cr43AFyfXrb_yoWxuFb_uF
	yv9FZxGw1F9r9xKF12krsIv34ayayqgFy3J3yDtw4UJasrZrZ8JFW8ur45ZayxWaykKFy5
	CFZFqr1Svr1DWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRN9a9UUUUUU==
X-CM-SenderInfo: 5olpxtbryxiliss6il2tof0z/xtbCzRFFE2nxqREzMgAA3r

> On the Inspur HS326 laptop(which integrated with HiSilicon M900
> processor), if the STK3311-X chip's PS interrupt is configured
> in "Recommended interrupt mode", the interrupt cannot be triggered
> normally after waking from suspend or hibernation.
> 
> In this case, neither disabling and re-enabling the interrupt nor
> resetting the PS threshold register can restore the interrupt to
> normal operation.
> 
> If the interrupt is disabled in suspend() then reset the PS threshold
> register and enable the interrupt in resume(). This resolves the issue.

Hi, Jonathan 
I'm sorry that I forgot to add 'v2' to this patch title,
sending it again with 'v2' added to the subject.
Best regard

