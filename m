Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D523F2DB7A3;
	Wed, 27 May 2026 06:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779864997; cv=none; b=cU1puQOt7VGNqfFBaehQFxPURtPBfo82TeqtnyF23i3VqxoQCkjjB9uK5aHFqhuKWlXIzz4DlP/5LpNqOPb9vLyKcMEJGa1VccY+ZQoyAVKLzI8BdZ8gh4iOiBDefYFiXF2x+nLRDmv5XVPrnJiPAvo1JGJRKN/HEfagX7VPC3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779864997; c=relaxed/simple;
	bh=me55Rl/ZvHon/Flxl5zIakg9tRYCgnBcoSn8IEuTSkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYJHRx6P+4UyI6dJ7PNA7Xkt+vTPvw18C3EbVP2JVDMzn3CCGHtzu+V6VBeQOfIlGCptOk8wzT2T7fxfSKL1e7JheDTK9nZijo07tzVNCR4F8iCEWsXfCbOsFaVwWCqZ+KpVuxOOUW4aK0d/3l9itODRpV1EeRDyvX+KFX6vvJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ju9nWBj5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ju9nWBj5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF131F000E9;
	Wed, 27 May 2026 06:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779864996;
	bh=YC+uLza7y0Sp6b5nc0/2m0K4Xo/464gvILubFJU6PpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ju9nWBj5M6+itsx5rcIVE1nRHLXH2IKm1Y3tbkbMpbiChSMNCglco4IxdOigzID4R
	 z6rbs+p9sRiFV8CJ+erq/LUqVsn7seCAf97l9EmPoXXz2qbl57FQXPZOHC+mjbPrMm
	 zsdfk+v/p2xQ8wOHG/fnLrY33HiH+IK59ADIPjSrHm7cXQjKoIs9gsHU/uCvd1ueBg
	 ZwVGkUgPUVkh8Cmb01bA2EDjfgGjJ7m+WF7rPBTiTI1FHc5QXORoKb553d9G9KCXKv
	 kplumjQSJHe20RqBqeXcR0RRbcULW21Au9x+kg1dfnTJPOZgvMsgvLsNidZ99qP3Fe
	 ZQjwvRFOMvUiw==
From: William Breathitt Gray <wbg@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	o.rempel@pengutronix.de,
	kernel@pengutronix.de,
	joshua.crofts1@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andy@kernel.org
Subject: Re: [PATCH v2] counter: interrupt-cnt: use devm_mutex_init()
Date: Wed, 27 May 2026 15:56:31 +0900
Message-ID: <20260527065632.502242-1-wbg@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525151152.7238-1-sozdayvek@gmail.com>
References: <20260525151152.7238-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=647; i=wbg@kernel.org; h=from:subject; bh=me55Rl/ZvHon/Flxl5zIakg9tRYCgnBcoSn8IEuTSkU=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFliUwVfq6pofjgXV5LbmbCi7M/Sdu8fWle8/l+4PzFW7 pJz1kn7jlIWBjEuBlkxRZZe87N3H1xS1fjxYv42mDmsTCBDGLg4BWAibywYGdbfd571Obrp8y2T 1z0mr/4W/N2y6OTj7t33fevW+HHN53Rg+MNXNjte4voZqc3cas9umx9rCXh22euB9eanV01tFFq Z+xkA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Mon, May 25, 2026 at 08:11:52PM +0500, Stepan Ionichev wrote:
> interrupt_cnt_probe() calls mutex_init() but neither this driver
> nor the counter core issues a matching mutex_destroy() on unbind,
> which leaks the lock debug state when CONFIG_DEBUG_MUTEXES is
> enabled.
> 
> Switch to devm_mutex_init() so the mutex is torn down in the same
> devm scope it was set up in.
> 
> Fixes: a55ebd47f21f ("counter: add IRQ or GPIO based counter")

The mutex_init() code was added in 7351312632e8 ("counter:
interrupt-cnt: Protect enable/disable OPs with mutex"), so the Fixes tag
should refer to that commit.

William Breathitt Gray
