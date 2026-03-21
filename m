Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54130330301;
	Sat, 21 Mar 2026 19:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774120774; cv=none; b=gy8kwHK6FDQF1fKkLSDIvJ6wKbonlw27VDDLB9ZEHLPW3QqLR30rxrBS7Bxlwvb7TIZfoxf5nLNIzqSIhujshGOXGGLFD0JBNhuAnHWw+7NoOz3u6vOAfwRfHReilWPk63ixCn2mwvwhn5e/vab9BcLd1h1IzNwIM1Z8Y3Dv/1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774120774; c=relaxed/simple;
	bh=NeN8H2yZ7GG8DBH9mh4IjLfCG233breMC2kD2rJcrZM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ub2+4d97P/OTn9c+UDRWWx/k2IQwJEBubPYXGo5cCNp+OUGPGzTRkFcR6lFciyEIElkboTrpncW8C/D/isuRqqnEbgsO8sH4dOqgFQQC2t0MXaNxCvBECitaXQBsLJWiGAED4Kt8DsvmMKfx/E+oIrj+MvBBkXeACupKNztysZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTAnsLj8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTAnsLj8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5127EC19421;
	Sat, 21 Mar 2026 19:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774120773;
	bh=NeN8H2yZ7GG8DBH9mh4IjLfCG233breMC2kD2rJcrZM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TTAnsLj8XLu0Fx3DxoR/T/KTczz50+eeMirkuxPBRn9Xx6p8PObUtT18KiDZFkJ18
	 THgWh9unhwUHFS38TH38aMLkYOxxmMiuaXoqJDpPjO0RRW1lxWSwH/gXMUN7ov2mYd
	 nO0Uxcsx92wnWWrJVcEGauyAo6nrX5hC50Be91K50+IXmaUR1Y0kXFpThX+5L2qsVV
	 u2Nf4WXfbSvrHtummTF0Zf9DDKEZgYyFYfSqhNHfWUnjGKTN5ON14bzGIGqmEgAhlW
	 +hU5QQ0zenrW9Ihdqi5GqGi6150VtO5A0mAN/359X8IuNZ5BtkZqxtIQNqxoSLPe+k
	 Fgqt64CfkuOag==
Date: Sat, 21 Mar 2026 19:19:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: andriy.shevchenko@intel.com, andy@kernel.org, dlechner@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 mazziesaccount@gmail.com, nuno.sa@analog.com
Subject: Re: [PATCH v5 07/14] iio: proximity: fix typo from currenly to
 currently
Message-ID: <20260321191925.2497b781@jic23-huawei>
In-Reply-To: <20260316090023.14691-8-i.shihao.999@gmail.com>
References: <20260316090023.14691-1-i.shihao.999@gmail.com>
	<20260316090023.14691-8-i.shihao.999@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 14:30:15 +0530
Shi Hao <i.shihao.999@gmail.com> wrote:

> Fix incorrect spelling from currenly to currently.
> 
> Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
Applied.

