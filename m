Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D3A244667;
	Sun, 12 Apr 2026 14:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776003900; cv=none; b=TWVL8yHbaOBUK+KwcPuQSYeVAzlYdXbA6jWhuL5XVWxj1wh5AFs6HoNGE9h8aD+QRqvbXZ+adUXopqTd3HMNQvdZIAYtNQne+wpP7Egzb32zbIyjpPsfUfjJcjoK51AWxuJunhphRDP7HnjYI5SYX1OwAHYNOWG/azTBT3qPerE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776003900; c=relaxed/simple;
	bh=Dw5CEzZzXSjmyhaqUf/btE6L3COyj6n3Oqtylwyr+DA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iKxjvGN7UWrP7fCJTvcG4dzGPMmcjg4vFXEVnvVQ685dUwA2TYjpNvHWva77oHZrOx87xdK0VprVIF0zY/CcZAiB421TukrwbPp5Ap42dnW/7y1rn/cODmFPk4KjqmDTsx1jGYQmUDQFrA0vaVeUvPSyGLpe1JDHAiEaIyaoLAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgJL33eE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgJL33eE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E20FC19424;
	Sun, 12 Apr 2026 14:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776003899;
	bh=Dw5CEzZzXSjmyhaqUf/btE6L3COyj6n3Oqtylwyr+DA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HgJL33eEVWvObI5MWOV9Vmn8RePagPXhVx/S686pTJKcLPGPmC1kCj3dUFx5R7Cfx
	 xwPdwxGr8kfDMyASHq2LFQvZUIp5LMTqNZDM3hVLOgbHPCL21sqQsDDD+WIhVc6i6t
	 JtRwKoSU+RtBfaD3jHY5sFz2tTkGr/+7hiFqzwiZ3yqYv5f7wWIyBc6NxbuT/l9jMw
	 SyNKl+qSVikM1l/nSBdjqqzOd0c61HKcK2eJHb9O/5pirRYFcl5GYhf0DHzHx70Su4
	 QGKnmQlZjdlbXMN7fc0zpeSA9jKsEylj/AH3qBH8ojvtnE2q8JZRv9NzkuiJuSY00t
	 i5zqxnoJ85s+g==
Date: Sun, 12 Apr 2026 15:24:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andrea Merello
 <andrea.merello@iit.it>
Subject: Re: [PATCH v3] iio: imu: bno055: add explicit scan buf layout
Message-ID: <20260412152451.5fbf18a7@jic23-huawei>
In-Reply-To: <abgZnpVPfKxDURzv@ashevche-desk.local>
References: <20260314-iio-imu-bno055-repeated-element-v3-1-2baca42290de@baylibre.com>
	<abgZnpVPfKxDURzv@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 16:54:22 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sat, Mar 14, 2026 at 04:38:25PM -0500, David Lechner wrote:
> > Move the scan buf.chans array into a union along with a struct that
> > gives the layout of the buffer with all channels enabled.
> > 
> > Although not technically required in this case, if there had been a
> > different number of items before the quaternion, there could have been
> > a subtle bug with the special alignment needed for the quaternion
> > channel data and the array would have been too small.  
> 
> This looks good to me,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Applied to the testing branch of iio.git.

Also +CC Andrea as original author - not sure if email address still
valid however!
