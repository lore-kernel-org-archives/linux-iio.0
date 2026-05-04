Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5782BFC7B;
	Mon,  4 May 2026 15:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777907758; cv=none; b=rVcttl+DlYTi4GAFCOPXNbhBhwk1Q9ZECnPTBIbfqtubiu7X3CL6NIZ0ugw2Zf5m6xxExdvdN6WIAtIWXe9aqxbyLYRwj5TLZIIHhvpvYWv+DQ0aZn51V5ojLl7fpNJOnJF7dMs7tQ8fVgR1lMndn9gFHQEs1/Q5x3AjS7uLUDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777907758; c=relaxed/simple;
	bh=sNstatoGoswv58G0fADnyn/clwRDCMQeyNB7Vea1Fi8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sfZlWbbfnygvHVjpYJNS3fv3ntDb5uyCsdkWYOMXuwWITAM0N8LfxKR6758B9ErhoDEJ/DxbzNaqE3rV9/aX8H7/TkrNvnlH1P6CZkASo1+WUe8Gf7pWYTxga3ipGuT9VZFUC9sV6fqkmg5Z8Yv/e4Z8Bz1X5B3+k1egCPEueok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6yElNLq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6yElNLq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE305C2BCB8;
	Mon,  4 May 2026 15:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777907757;
	bh=sNstatoGoswv58G0fADnyn/clwRDCMQeyNB7Vea1Fi8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J6yElNLqOWAsnZQuFS/qr8/vye7B8tDQN/gOsT9XEtpES1mbJwnwYb4lCXYq2JX04
	 +rsXj6OuWFynluNOd5h5RTjrNKeXWX45/UC3XIOeJgdMDTkNLG/bef7oT0lQdiJmyQ
	 amZvcxG3ZGaA5dPYUpbSA+YqYUysYyahIs/bBuCtWJB9p6mTqM6cKosokyLJanNJ2w
	 MIpYeil8jnF/+mNWMkCi1HhiUU4MU6V4ZLQhbw+ZovbCaVHLa/Uqf29AQhcL84S/in
	 CILyPwQ39RX09WbZiCjMIVqivNxpTLYJk4TfFen/TVPFBcxyv19C1+c34NJkUQAgaE
	 WkOUHX/i/f3hg==
Date: Mon, 4 May 2026 16:15:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/17] iio: magnetometer: ak8975: modernize and
 cleanup driver
Message-ID: <20260504161549.40ed10de@jic23-huawei>
In-Reply-To: <CALoEA-y4SeS8xtauxOc_w4epJ1JrNnO8KKfxBhdXMAtxQ+6onQ@mail.gmail.com>
References: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
	<afh8nZ8fsyeXYbtz@ashevche-desk.local>
	<CALoEA-y4SeS8xtauxOc_w4epJ1JrNnO8KKfxBhdXMAtxQ+6onQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 May 2026 13:13:17 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Mon, 4 May 2026 at 13:01, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > Co-developed for those is too strong. Just use your SoB only.
> > You may use my Reviewed-by though.
> >
> > Taking this into account, you can wait a day and send a new version with that
> > and --base fixed. Also it gives me and others a chance to briefly look into
> > the contents and see if everything looks okay.  
> 
> Sounds good, the devm_* migration patch should be looked over especially,
> since I have made some additional changes.
> 

I looked through them and only that one question on the read_poll stuff
and whether we should check for errors from the function being checked
on each poll

J
