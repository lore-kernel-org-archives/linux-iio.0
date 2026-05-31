Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E4632E75A;
	Sun, 31 May 2026 22:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780266906; cv=none; b=jDItt7uvMbEKd3NrN+492NkUOGB0l1xk1QfCRewyGM1DWxXQCGjzOMRHO56N0/8z9R/e3bI9SvhYhLqlu3EUy2UOMMvtBVGVfuOfvWJbCJ2qBRQa7H6VBeUsMp2vQOVX+3XLumrxhG5N/Zi4rIm8cv0rCne8ndoBpyXtHY7BsnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780266906; c=relaxed/simple;
	bh=INkaQNhEiRxfgxkskNC6/SDidGvqNcMeg3vZoPDirlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DpgJKKuai2GN1RJNYpd1QIG6mROa2c95znhxBHLXFsnROeC/5HjL/irn0rOMy8xf8D1gym4WcWjHryncwGQEiHtMSb3Q71qiHm9y2dSGHF6SjP6DPzz/lLQHOvQX0PhsWhR6aN0FfG+cU0RF42+EUltITdi7qxiWXxTclabiud4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCZwyUiC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCZwyUiC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15FCA1F00893;
	Sun, 31 May 2026 22:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780266905;
	bh=+hhlO4dK69ZjGMBysUyuxmv1LF+cggM8XspEFirAbHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oCZwyUiCdxajMqmxN74uaQYa0cO9vQBdjRlEvNqw3CUNUP/jCnScxqu/TqyoKFdZe
	 PnR7zaoMFoBjW2A/eju5D4CVu/SIPlZ6SQEPuwgrYRZAIhu17x+65xGf/9KwJTqZUK
	 TvpZEiYGjRMWWRLYbCn6Ha2P4s7ElVxaRMQRrkvbf1we/SKhRQk1draD8s2ait9Fcv
	 iBdmZ9qLV9/ElggbupGSLcWa6C8k2nDR7wwtRD9s+iFesQB8/t3eq7IBAkoqCawePZ
	 LnyFyG4XlU/BNX5CpxbTigEbYagWYCAev+whhpmv5UplszvN5tgvueLbQarPUy9EG+
	 VM9binWnpGYwA==
From: William Breathitt Gray <wbg@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	o.rempel@pengutronix.de,
	kernel@pengutronix.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andy@kernel.org
Subject: Re: [PATCH] counter: interrupt-cnt: use devm_mutex_init()
Date: Mon,  1 Jun 2026 07:34:58 +0900
Message-ID: <178026663949.725822.13459734900740084238.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260523184418.7586-1-sozdayvek@gmail.com>
References: <20260523184418.7586-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=547; i=wbg@kernel.org; h=from:subject:message-id; bh=wMnKUIAViGYYDm+AGpSE0QUrBCqLODhKturDiOzE1R4=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFky23bNDFVZ//bHKxvBxcULPpw+N7Ez6i73w6eW+kskJ 86b+viEQUcpC4MYF4OsmCJLr/nZuw8uqWr8eDF/G8wcViaQIQxcnAIwEZYqRobDKkf32B+x3bxB 5EKUQvvj2+nzHM7yrmLd+GbjonQ/g1nVjAyXWvI7NnW+NM+ZcspxdgnnhE3XZmafucsfbOKbVLv +RiEnAA==
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Sat, 23 May 2026 23:44:18 +0500, Stepan Ionichev wrote:
> interrupt_cnt_probe() calls mutex_init() but neither this driver
> nor the counter core issues a matching mutex_destroy() on unbind,
> so the lock debug state is leaked.
> 
> Switch to devm_mutex_init() so the mutex is torn down in the same
> devm scope it was set up in.
> 
> [...]

Applied, thanks!

[1/1] counter: interrupt-cnt: use devm_mutex_init()
      commit: 4d9a902be374aea023f2193f729c26612e56b542

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>
