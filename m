Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADDA385525;
	Mon, 20 Apr 2026 12:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776687004; cv=none; b=lLeCRzQkGBn3Hyw2TYEl3PrVfxT05MRmK+V+mfK5Xo9CkmZo8j62rh5gCakFhfCmpdWSiV2vsFObuiQZIfKthraWaX7OncMJff5+YgO7Sdk79AJ1VNzqauMmzl050M2VVIY9R7CBOqY5FdgbKo9CkC+0F5fzbKfbiW2XnsW5mCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776687004; c=relaxed/simple;
	bh=9PSiOjy2HqcK8tJ9oRArf+tqRTaBQBQt+JoJ0C/5bT0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ajoyUgeXMFPhq6T72ai/kQQQZewd9jbM4ScxuRKadLzjZ6g2VHAchEcSPr1ttbmmkyh9c5/pe71DWLSgRRy+u/5WJIHeLbsiQWwWBvVr1ERIVN2/mlttRgcSBi/2YmuLJcTBzxDve6wwNGRBaO3cE+iy9vG1y6hBU3lzu/UZgZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPN1GWtO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPN1GWtO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4B1C19425;
	Mon, 20 Apr 2026 12:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776687003;
	bh=9PSiOjy2HqcK8tJ9oRArf+tqRTaBQBQt+JoJ0C/5bT0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EPN1GWtON4AfPkPPmp+iTdQlhEJ9Rc/9Dac/ljbnB4szKv70CO3OyWHz5ahJKcd4J
	 WUzmiTT0lUZ/PRByNgCUmUWkNAtrMaTdSeJI4y0LuYMq9p+hTqlqbLxN8c+M2B66Ce
	 CUfVsE8SRK8BwNkR7+7j+paH/e0BCD6dg5e9/Q85cH5X+jq02cAIUduMB2dAsQsRS0
	 VOPTPiMv2MaaDAqfMlepgrivpTU6kyKb6pWlYV3p6cn1E3pir6X0AUJyKkV6yIjzoK
	 xveRrm+elHeNFUMmVzRzHFLuo7GYQ4DlQngiXJgJxyeG0MyL1wtIhi7Ip5v/uxJBIt
	 EyGyPFqRqGx8Q==
Date: Mon, 20 Apr 2026 13:09:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4 0/6] iio: light: vcnl4000: drop enum ID table and use
 device-managed register
Message-ID: <20260420130955.628babaa@jic23-huawei>
In-Reply-To: <20260414-vcnl4000-drop-enum-v4-0-59fde2932a0f@gmail.com>
References: <20260414-vcnl4000-drop-enum-v4-0-59fde2932a0f@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Apr 2026 15:37:16 +0300
Erikas Bitovtas <xerikasxx@gmail.com> wrote:

> This patch series drops the enum ID table for device enumeration and
> instead adds pointers to chip ID structs directly. Necessary
> information about the device is then taken from i2c_get_match_data()
> call. This removes the association between enum ID table and struct
> table and allows for easier addition and removal of new devices.
> 
> Along with that, an iio_device_register() call is replaced with its
> device-managed counterpart, to ensure that device is unregistered
> automatically.
> 
> No functional changes are intended.
> 
> Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
Applied to the testing branch of iio.git which I'll rebase on rc1 once
available and then push out for linux-next to pick up.

Thanks,

Jonathan
