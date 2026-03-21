Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE432306490;
	Sat, 21 Mar 2026 19:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774120363; cv=none; b=SCm6ZJt7uCyC83Jq6UBI6rXULCj89ihGD3GvS9yLwBYKsAn82vEgq6SePlbQ5HXWiZND1YW9KlIM89qGESQqPDo7D9g1OqkzCfzOZRcxnvTTK2cEfpJ7TsEE0vhn6uMfrpWFneTpBvkS1U0ZXuXJKcgwDmOOYexgldUqyudjDts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774120363; c=relaxed/simple;
	bh=5R6GzzvasyAPjXySpE0CyVu5Esgg2Gvyx71UIygR5V0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uePlz/GkI1zYVl6H9wpRPcKnP59oxPiHsxs7oxFrCeH3kKJ/qrlYha4AOS0FFVdrSHRvqjoN+jwMUd63BPqhXxq6iX8Pny9qkwd9jYjfkOEmW0O6s0XyigMta4Jy6RuLLcgTPEy7pKWud1teH8Cjk+8ksjqkNmAtj2BzHPjaN/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJDNBLmB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJDNBLmB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A679C2BCAF;
	Sat, 21 Mar 2026 19:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774120363;
	bh=5R6GzzvasyAPjXySpE0CyVu5Esgg2Gvyx71UIygR5V0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DJDNBLmBx0qfc4FzaJFifBl2z0h6anv7tyKA4VhjfaZ7GnVTrRIlXDef2YJXgibrX
	 v2i9MwkmerYpKo93R9NUdv7DL50XLtjup5dPwfMpUaUBamIJiU1DvCJZTifu6t5aqd
	 8u98rut4IlPHokeaK0qR6EX/QXR6FcbJryBVI0k9IcYKuneVRyhDjiCKJkKhqJBW05
	 Ycrv5SrJoRCCo5SfRrdREwaNMcZzIR650ipAYncqhdNQg0n06dxrHocm/C11iTf/eE
	 HqBQABVkorjCwuj7IbhLB24VVbqfE6I2AU/nDYNzQGzvzDBTFxK1WF1k2B9EWGYTc2
	 airRIP1D69uxg==
Date: Sat, 21 Mar 2026 19:12:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: andriy.shevchenko@intel.com, andy@kernel.org, dlechner@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 mazziesaccount@gmail.com, nuno.sa@analog.com
Subject: Re: [PATCH v5 02/14] iio: light: fix several incorrect spellings
Message-ID: <20260321191234.5ee92877@jic23-huawei>
In-Reply-To: <20260316090023.14691-3-i.shihao.999@gmail.com>
References: <20260316090023.14691-1-i.shihao.999@gmail.com>
	<20260316090023.14691-3-i.shihao.999@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 14:30:10 +0530
Shi Hao <i.shihao.999@gmail.com> wrote:

> Fix spelling mistakes reported by codespell.
> 
> - sesnor -> sensor
> - substraction -> subtraction
> - simulataneous -> simultaneous
> - proccessed -> processed
> - coefficents -> coefficients
> 
> Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
Applied.

Thanks

Jonathan
