Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8374C043F;
	Wed,  1 Jul 2026 18:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782928816; cv=none; b=adQFUQzunr5XGaFEorGx3GQw0dpWcU4S2k54CzdtpQMiN93mJ20TEouPfzBL/bRxALmklXgHptoCBcJrBV8LGC8VuSUyjSACrWj27/hH+tyGNs7cAqfK9USiKyOBBRU4aLFEqvkDID0I9lzqJXiKyrQ0lmAvdSUcz2BGzGbPPFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782928816; c=relaxed/simple;
	bh=IKVQLAIpJBqpULw36UA4BMH9WLN/5GXEfLx3U//uxu0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nsXPFg0qWEjnR80AwFAAz+KdQesCx5RoaK307pKCNHuCp/a+yHK+byQT9KDGtJr/U1zn6nNlhQW7KTYc+l3xiPg9orhuHa90GnAx7+1DPF2orYuLJMnsb7GXTQ5Mzh59YHo5oZN1DVtK2KCIiPfXmrRWJ7fTVAbF0R0VgdHQyBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPquNYnq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPquNYnq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF52D1F000E9;
	Wed,  1 Jul 2026 18:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782928815;
	bh=IKVQLAIpJBqpULw36UA4BMH9WLN/5GXEfLx3U//uxu0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DPquNYnqFVNYTSn3zrpf/OpIxbIMGloGzttGIlxPtmUty9+qU68cpnMwHuSOtdX5V
	 Lc710+E6btaik5PG3QKbgUrSigED5ZB+SX+3t/YugZikh1chuFY9sviEdveOybqcR5
	 JfZYj+o5CDf66Xr8YI6EswrVAksZN/ul9qukz488X0CTMaSnAQvl7aZvZq9fQQBxKh
	 4VxrPJ/MSaCqS/8PhgIF7et/OfwzwuwzHpgSUisRRK+NR2cRE/63PKZPRk90Wr4d5x
	 ZG9A+QjgW646Ur9Cc2XxGoe8vGGERn/LYzkosD9uGMzSUvJeXYau9QP/ffh79Gl7jl
	 s++P6qsJ2SiJw==
Date: Wed, 1 Jul 2026 19:00:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v7 0/2] add mcf54415 DAC driver
Message-ID: <20260701190009.04cff040@jic23-huawei>
In-Reply-To: <20260701-wip-stmark2-dac-v7-0-ff8fdcc8010a@baylibre.com>
References: <20260701-wip-stmark2-dac-v7-0-ff8fdcc8010a@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 01 Jul 2026 16:17:22 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> This patchset adds a minimalistic DAC driver for the NXP mcf54415/6/7/8
> builtin DACs.
Applied patch 1 to the testing branch of iio.git.

Thanks,

Jonathan
