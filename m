Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588073009F6;
	Sat, 21 Mar 2026 19:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774121126; cv=none; b=JR9EZQCBcnB9+OD9vkwKsnjZJ2VuD1rayl8nDZSrosyH4beHRLvkObI9swFxZuMyhogYAZL1iHRE9KI8Z4/RfNUv3vB0/Xe0HDBqiTRShRqa8WVSxlwfHGPR9L8K6hIpqwsfiEw5aUFSUIk3rSBi8oLbn8A6t4rpXudJSnooO7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774121126; c=relaxed/simple;
	bh=6Jypcff0L35q/QGIUfdHsdEUqxIj9HVtIHob21svGzs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DjXfBlSk8RqToksDfFoFrb1Pda0kNT0eSGqE2FTbSW3LP56FykBysDXoL99JTOMXHcyeVIVkQbcgfgF6OHGCSpU58ICW/T3kuzr4jOBO3n3pmn+NkqAmTQwhjKFw2rK4KORnaatstU+tRkbwgEdKp3bDx+1qw5/csZI0+Yxn4YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/07dMvU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/07dMvU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460CEC19421;
	Sat, 21 Mar 2026 19:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774121125;
	bh=6Jypcff0L35q/QGIUfdHsdEUqxIj9HVtIHob21svGzs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H/07dMvUkIcPt+WfWVdz+IklQayZKTy0Vzbz8sORg0zXtzjAItPWTe7CweTKz5j8e
	 IKjrp2cEg3QAZGvqeXWPL6x8xW1F4LgelPo1ghfIUqpkP96ur1YDUa+fJjK2sNTwAV
	 zKIhBm0rcwlishtsaGU2G5k/xpDihlOYgFred++oZw39leAgfv73w5s9MeBeqhDC3K
	 RBS+b9rfKK3bbws/vtS9N7HPtq5Te51y8aLPwKGOpr5zrUufZlID64S1ifTWYh7g+K
	 nuGIemAchLnnoXIXYUYhZqaNffhHyMmrEDoWl2f0ykBq6845vMbJO+o8S28t5IgGUk
	 dpUZDH36MSXLg==
Date: Sat, 21 Mar 2026 19:25:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: andriy.shevchenko@intel.com, andy@kernel.org, dlechner@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 mazziesaccount@gmail.com, nuno.sa@analog.com
Subject: Re: [PATCH v5 11/14] iio: common: fix spelling mistakes in comments
Message-ID: <20260321192517.048e1fb4@jic23-huawei>
In-Reply-To: <20260316090023.14691-12-i.shihao.999@gmail.com>
References: <20260316090023.14691-1-i.shihao.999@gmail.com>
	<20260316090023.14691-12-i.shihao.999@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 14:30:19 +0530
Shi Hao <i.shihao.999@gmail.com> wrote:

> Fix spelling mistakes in comments.
> 
> - exepects -> expects
> - fuction -> function
> - theoritical -> theoretical
> - appopriate -> appropriate
> - iio -> IIO
> 
> Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
Applied.

Thanks,

Jonathan
