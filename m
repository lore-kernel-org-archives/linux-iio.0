Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A3B340260;
	Fri, 23 Jan 2026 09:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769162192; cv=none; b=TQE2rXAON7b5HgvV/myc5WnrwhrMTyBjiTVWnnediLBksEKm5extu4q+g+wTQ4i2TQVV4YFsokhi1HxpnG40vQYTz9gbtRvvMl9NXpqoG26Th6FCcjjCf7wfTUWiBdpTSwXkWhTwWgPwYbtfLc/9u4//Yn9t4bwU2vt7UMDpWQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769162192; c=relaxed/simple;
	bh=yekfAuEBrPfUmKH2UK5QGV+4CEYhc2dtx4EbQRdMNDs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W2V0tbVY+ndtF/UTnhxHQOf86qCz0XDIKUP2Sm7FeTaPL0MUoDCktd7tuBDyWMi73Dnc2k2DMh0fOafpn6vXCkzqtNz2air7zCm+QO4G+MZ1GGJiQoJHc1bG0x7wYgSevaJlPsxZ/yrNI6CbmE9BLuuU1n2lhKQU6xqMqfGUnr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uuQC80Zm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uuQC80Zm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146DBC116D0;
	Fri, 23 Jan 2026 09:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769162191;
	bh=yekfAuEBrPfUmKH2UK5QGV+4CEYhc2dtx4EbQRdMNDs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uuQC80ZmzFDjeIY2H6mboWVcf6HkhAjUS8bBTzG0NR18XP/PBnwbluOWftHj1S3OV
	 rLGTj9YDtT4Kcn0Q4iUZeMrXkP/YdZOcq5heRB3fI/bfPlHFBNt5lux8uJhAjBVP0u
	 ijaFFgSzEQR3/echWSU6rZUtCctMGMUv1banw8D6EOJweGv7yK/NgbkhUQKGvch3QY
	 0N+aYpN2cI5ZNk2bwGm9JJf36LHHRH9eVE/O+YM87EYNaFn8hSsuhzMwSus1a1mPyv
	 kez5D8Kwp7WmjLRmcmIYwz602Jkd1cRFpr+2QekTk84K/uJ5HX09gG2dK7gTLvlJqU
	 1uxAe0NaDibIA==
Date: Fri, 23 Jan 2026 09:56:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Kurt Borja <kuurtb@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Benson Leung
 <bleung@chromium.org>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Gwendal Grignou <gwendal@chromium.org>, Shrikant Raskar
 <raskar.shree97@gmail.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Guenter Roeck
 <groeck@chromium.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 chrome-platform@lists.linux.dev
Subject: Re: [PATCH v5 2/7] iio: core: Refactor iio_device_claim_direct()
 implementation
Message-ID: <20260123095621.4b3276ef@jic23-huawei>
In-Reply-To: <aXMq5bBkj8It6f5z@smile.fi.intel.com>
References: <20260120-lock-impr-v5-0-d4d22347041f@gmail.com>
	<20260120-lock-impr-v5-2-d4d22347041f@gmail.com>
	<20260122190401.510234c4@jic23-huawei>
	<aXMq5bBkj8It6f5z@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Jan 2026 10:01:41 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Jan 22, 2026 at 07:04:01PM +0000, Jonathan Cameron wrote:
> > On Tue, 20 Jan 2026 01:20:42 -0500
> > Kurt Borja <kuurtb@gmail.com> wrote:  
> 
> ...
> 
> > So sparse does change what it moans about with this one in precisely one instance
> > There are 9 false positives with Al Viro's updated sparse - I haven't checked the
> > original one recently.  
> 
> FWIW, I also switched to use Al's branch of sparse and recommended LKP to use
> that as well.
> 
Agreed, that will help with most of the false positives but not all :(
