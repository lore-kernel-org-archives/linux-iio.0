Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6BB3B6C09
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 13:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777295940; cv=none; b=MqlPoFuv/OPon25UUcCsixOSnhWLvHhmhoaOa1CDuzTCmEMyFoZ68PMAeRENj7vImNwM/zGfG7v2Sx5L/4T1WItsHXkliCbFT2eblo0oTQo7fQ46iwlBRaNQb4/V+WupKLi2zF41paincpaoV9bwS2yp1C/7DqC5tvYcJuqV7zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777295940; c=relaxed/simple;
	bh=8382jxbz7ogYYCqIEZXiV/bvWVWk+LHqb5S6B2vlJ90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jx6wRSEugQTUPxGIEbGtjmO2PZT3efe7L6vKk+VDZgZr7x29Z1VqTE3qDapAQfNgG5vGVZecjOtxej/maXWEJnOVUdXSvHpzB8RluGBvF4H/UYbX5KN/tc18NaeouKA+xItLCOlMkDqnbVsSaRQzgYPf9UkulGLXHYZURyhKF5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ciziks.com; spf=pass smtp.mailfrom=ciziks.com; dkim=pass (2048-bit key) header.d=ciziks.com header.i=@ciziks.com header.b=4jbjdgm2; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ciziks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciziks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciziks.com header.i=@ciziks.com header.b="4jbjdgm2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ciziks.com;
	s=protonmail; t=1777295934; x=1777555134;
	bh=8382jxbz7ogYYCqIEZXiV/bvWVWk+LHqb5S6B2vlJ90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=4jbjdgm2yFVPXw1noqa6mZabjpa1kohTxfvirbMzLLZfLgxsvT7k4ILY421riAW8B
	 HEUkpnm+RCfdmqrHSy3iAw6WJfzjyAgZXFRexOkxC6bOmd/ZDXJN+XVpWwCZRlk8Ei
	 vnDmb+bUAKJ7JLfE5WTI+B4u3avoNZfydZMx+F5zIfnqh1ehnypWAl7XzzWigOD/gm
	 Dh6Z92VQxoYHaent881X6KgnG47ezKV8nlGAWw4ph4n8Lqy+jxpiQAYsDko3ybgFV0
	 1jwY04JUxkFlLKFnOfHaL4CGZ56Q/+CtbgfNX+6V+MuSgvEUrFOL3LZ6z2SzFJ6wdD
	 QWFR+O1oQwV8A==
X-Pm-Submission-Id: 4g43zt2QZfz1DFFM
From: Lucas Ivars Cadima Ciziks <lucas@ciziks.com>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	nuno.sa@analog.com,
	matheusgiarola@usp.br,
	felipers@usp.br,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: adc: ad7280a: use cleanup helpers guard() and scoped_guard() for mutex locking
Date: Mon, 27 Apr 2026 10:18:44 -0300
Message-ID: <20260427131844.8657-1-lucas@ciziks.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260424175551.071b25ba@jic23-huawei>
References: <20260424175551.071b25ba@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 24 Apr 2026, Jonathan Cameron wrote:
> Series applied to the testing branch of iio.git which I'll rebase
> on rc1 once it is available.

Thank you both for the review and for applying the series, Jonathan and Andy!

Lucas
