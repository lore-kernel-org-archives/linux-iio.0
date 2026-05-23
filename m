Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B1650276;
	Sat, 23 May 2026 22:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779576704; cv=none; b=pJWQMRlEB6vrK6So9ketSPuUDUyuXxM3VX/S7TqMR8/vXX5V2Cn5eTeHHOSdtSjRR+Zp/R03cufREWNybqlcYBEwdpRvEY4iYrYD96dWb+3DgbpkUdJ295IT46BhoHuQusvo5P2Er3LbCk3AeTcVa8FsJ6fT8trTSsM5QLmTDfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779576704; c=relaxed/simple;
	bh=Ztlyvv4wmJ8crarO6mgSm0SbdXJWU+vSp0bN6hYlngU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+QCM1OpMOxPsU9+6BUN7+kRxM2cjFljfw8rILlmSJ1juqtnpJbztv4YXad0rf1XF+vbfJasoKguNEZ8nIbKy33YnvIJsGu7MJQLY/q9FB5bCAYBMNLaa+1Sc2PUcUOySIgKJaVACnXGPQ4wG+wBLvbLQMXnvhS7cb+d3tbpzPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNm0F8bj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNm0F8bj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7051F000E9;
	Sat, 23 May 2026 22:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779576702;
	bh=DhDG/u7BkQjVzXr24V+62v2K1r4C4AbtRNKbpRPCizI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FNm0F8bjjRweN+1xfkzWfkqOqHfk6GT/XP7YbC/7y3CdnFsrPsI90l63L2tmkcvyQ
	 WUz/hTfjxMDX2XO6lQelBE7rfX/aMk7ggek+BdcM9DldKwWYIMMLe4Qs0oVJ3DeAUM
	 ZoArAoNvz3Ae+I43TBD0o+uJ945/H0FBYW8cPANGlUCd3572mO0+ooPQ1ZIBOiJM4v
	 Xtc8VpBz5WW4/BXAlyoOi7KZroTfRkEc6lQeDlMRimK+vkeyex2Bke3WyQ4vw5dSR5
	 CNx63dm2fn8aXcJAjEa9ZZkE25fhjl18MgPnEVub9rDuJIotiyvDVsmrc5UaBg5Bxr
	 CiiFjcRh/ROcg==
From: William Breathitt Gray <wbg@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	o.rempel@pengutronix.de,
	kernel@pengutronix.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andy@kernel.org,
	joshua.crofts1@gmail.com
Subject: Re: [PATCH] counter: interrupt-cnt: use devm_mutex_init()
Date: Sun, 24 May 2026 07:51:35 +0900
Message-ID: <20260523225136.377780-1-wbg@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260523184418.7586-1-sozdayvek@gmail.com>
References: <20260523184418.7586-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=665; i=wbg@kernel.org; h=from:subject; bh=Ztlyvv4wmJ8crarO6mgSm0SbdXJWU+vSp0bN6hYlngU=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFlC+j5blK8lv1y7PemEoMu+/9sUj10X28GobGW+/Wks4 +oL2yeVdpSyMIhxMciKKbL0mp+9++CSqsaPF/O3wcxhZQIZwsDFKQATmTGFkWGXu9WSkJAqVtFX Gyfr/E+3yWdqMrh2WUZZpXD5rr3yL7MZGbb3TU79t+9w/6SeT+EHbdtb5IJ//520vjfGI41v84z Kg5wA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Sat, May 23, 2026 at 11:44:18PM +0500, Stepan Ionichev wrote:
> interrupt_cnt_probe() calls mutex_init() but neither this driver
> nor the counter core issues a matching mutex_destroy() on unbind,
> so the lock debug state is leaked.
> 
> Switch to devm_mutex_init() so the mutex is torn down in the same
> devm scope it was set up in.
> 
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>

This sounds like a bug fix (albeit applicable only under
CONFIG_DEBUG_MUTEXES) so we should have a Fixes tag here, correct?

If this issue applies to counter-core and counter-chrdev, would you
submit patches for them as well?

William Breathitt Gray
