Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977F82FB0A3
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 12:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776601071; cv=none; b=my/qnkRoh3+t3f7YnVipcmeHqoPuXJ0zS5mI8XpGdcOcBuezXxNHDtrMnhxxYVC+Pe4QW8/M6buL9UIK6X6HV1km8ola2HxLyOY/faat50/xYubjA58KhAX5bUk0a0woHsr3DKzb+RXuu1dVPLaq1GYCY+o5ocEJks0itbtkCDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776601071; c=relaxed/simple;
	bh=CwSbuAqg3f4FANc2ar7Fzc9yk4tpd2+6swMs4fpt+Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XqGMNBg3qjj4KQIG/lXzayUCHEHqMijeyveTpum9Fz1Cw0ALDb5AwZqRy+SZEoPRQxCjVXJhLIZY7GMQQcOVO/pLjMQyVjrdb8DRsFOcWr1KBWqj0z+ajnIm4wMrSS1Px5ExfzATrRfRjDNpI34X5dYzjYnWn97LGpvLeEyKMlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+xmXtc5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+xmXtc5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797E9C2BCAF;
	Sun, 19 Apr 2026 12:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776601071;
	bh=CwSbuAqg3f4FANc2ar7Fzc9yk4tpd2+6swMs4fpt+Aw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s+xmXtc5r0pBvSo47EbRZosCVAriEieLTHj6L1DDhQELjkm5IchNXkwNZciDKQIoa
	 H3nqdRUjUU7/zGYQAzdvc7C4fR5x8DzryoMZ8cLLp6knEv7psakbvczpfZ7Qg4DXCs
	 Dq9hQYxMPIjEJ8nokzHh6BKEyGDTCvPDsAiIaIH1R9q1Vn/5Y+vVuOprWe8+uDsAIs
	 hMKCIRevgqEu+FJ1oDChGcqyLMvUBckS5cHYPAFmLSXjVd593jfQz7gIfj5mtWC1sD
	 Iv5sNiEWlo3TApzDv61f1gZMbsLdyLfoSZ+FDH4u1sSiQ5QzlM64ig5x8oyq5XIJ0N
	 wWpQ2ETKZyhAA==
Date: Sun, 19 Apr 2026 13:17:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Erick Henrique <erick.henrique.rodrigues@usp.br>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 andriy.shevchenko@intel.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: dac: m62332: Use guard(mutex) for locking
Message-ID: <20260419131743.4c4e24e9@jic23-huawei>
In-Reply-To: <20260418130322.106769-3-erick.henrique.rodrigues@usp.br>
References: <20260414233912.662606-1-erick.henrique.rodrigues@usp.br>
	<20260418130322.106769-1-erick.henrique.rodrigues@usp.br>
	<20260418130322.106769-3-erick.henrique.rodrigues@usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Apr 2026 10:03:22 -0300
Erick Henrique <erick.henrique.rodrigues@usp.br> wrote:

> Replace mutex_lock()/mutex_unlock() calls with guard(mutex)() to
> simplify locking and make cleanup automatic when the lock goes out
> of scope. Also simplify the i2c_master_send() error handling by
> using sequential early returns instead of a combined condition.
> 
> Signed-off-by: Erick Henrique <erick.henrique.rodrigues@usp.br>
Looks good to me.

thanks,

Jonathan
