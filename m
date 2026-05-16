Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACBD3D8113;
	Sat, 16 May 2026 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778932746; cv=none; b=uVCIpvtxbS/kAOn2HmbqmiBy7j0/h7onw6cc9lyFAQgloLm44Yhptr5sl2T7s24J9J+n89Bk4JdBz6hOSjkEBgIaZKWOYCwEFaTRWWFC7gKi11vedHejv9+zsBHGz/7iYdW7sGycdaX/JDCjjbBkhz7kKLw0WM17lLlFWDGCHJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778932746; c=relaxed/simple;
	bh=pF2D7Cj1OpuEQdj3BGO0cUO9Tu/EDmTMM/V2m/5t+So=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CNOcdnUqNLwkuG985mO50OH2if3ec5B60zL/qEIfjooieC95q4sk1HEl6YFZdqqxbLzRKScSqKVHHFlUSUirzVEe9Ndft9tIf4X6msPitiMDcRvSO12ERYTKYBW9tWh+gW+Z2CqyvxC/h7MmGU+WzqSl3XXVl0jc1RXr+OhowDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQJo1Hgh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQJo1Hgh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9149EC19425;
	Sat, 16 May 2026 11:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778932745;
	bh=pF2D7Cj1OpuEQdj3BGO0cUO9Tu/EDmTMM/V2m/5t+So=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uQJo1HghWrSjQPrWAW97/lgiIicUrMO5TvPiHlofhRw+ISeSQM+3D6eY8CjYr56BZ
	 xUKOLGk0dCikC3W/ZqsVlReXKi8XAsKlOGg2SqgHGblg1mJFCwAPZD/G5A9dz9D1TJ
	 YepxoMUjIqWgexlWxaNiuVSsurztsPZrbkeLvhocbBGN4KASj64uQ8ItwcABDwt/kU
	 wH1JZbKLjOcFSUMaMUiAEZjl1Stdeq+W0Xj73QqV/NFAZoJE0Sx7I+hVA0/9/3H7He
	 SzAk6i3eqzlpu82o49RB0kgBFAMc0akEBFLTmOytobMSTqS0tx3oUrQ9TlQWfcbVOr
	 o/Y2bXauL4dJA==
Date: Sat, 16 May 2026 12:58:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Alexander Koch <mail@alexanderkoch.net>, Michael Hornung
 <mhornung.linux@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/10] iio: light: opt3001: make headers conform to
 iwyu
Message-ID: <20260516125856.4a3a323a@jic23-huawei>
In-Reply-To: <20260512-opt3001-cleanup-v2-2-8018cf3a8a0a@gmail.com>
References: <20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com>
	<20260512-opt3001-cleanup-v2-2-8018cf3a8a0a@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 May 2026 12:57:22 +0200
Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:

> From: Joshua Crofts <joshua.crofts1@gmail.com>
> 
> Remove kernel.h proxy header, device.h, irq.h, slab.h as they are
> unnecessary and add missing headers (array_size.h, dev_printk.h,
> errno.h, jiffies.h, wait.h) to enforce IWYU principle and reduce
> transitive dependencies. Also, replace bitops.h with bits.h as only
> the BIT() macro is used.
> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Sashiko had fun with unrelated review, but this patch itself is fine.
In the interests of reducing what is in flight (and because I'll take
the 'fix' in the previous via the slow path anyway) 
Applied this one to the testing branch of iio.git.

Thanks,

Jonathan
