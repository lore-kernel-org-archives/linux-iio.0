Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616E7267714;
	Sat, 21 Mar 2026 19:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774121811; cv=none; b=OtkoHjFNsFed02Yckjg6J2zHorCdsuYJM6HAWS6oyQh6sgh/JkYrAPqqIfZLBw+VvgD1k0IEm4gRNUTbWC10JQJnhoRRlISMqZvRPJsXXdJ642+q+XQptaYqC3uYE4sp7GGrMdMW29uycNNneZkuQ+2VgpkHUa2iLqKIDr6KGq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774121811; c=relaxed/simple;
	bh=9cxwwf8b4P6n6p+x3KT1xRTHC89nFNmJr4wm8qQwDjc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XBGwsd2eVoj9ioPZw9d3zaeTzoMFGHBlt0n0TO24mQY94qqooYRzWBzLPt52k1BmXhicfK0uTxXDhumt0q/OQbi6+6oLejrp0KhovBsGV2xQeVg0LJT0BdvrIpc14t8gcSe4CvCUQ3zGIM/S5J43q9mvycbZ67q9NdaZ1QfDNLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDmNZ/0d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDmNZ/0d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1428EC19421;
	Sat, 21 Mar 2026 19:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774121811;
	bh=9cxwwf8b4P6n6p+x3KT1xRTHC89nFNmJr4wm8qQwDjc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TDmNZ/0d91B8Ih2BCOkZ/0iJYYYnVVg7pJZeIDThvdXBtCc0vVxaawa2N7vdmQ8DL
	 FtkXCikTU+HlvowzptrLtBIR8v4CrzCvIkSJanFzeEjmAr3HU1eVxXhuClmQBhnjgU
	 /O7SEmEp3hb3by4TUk9pvEqLgSQZrwi3DQv74ic1er+iua7Lc/wuRZKs3xfWmN7qN6
	 DbdXrYCCtL6ZwTsVVGvH4RR+tiJc/4b8fbsEJKmbDo/fP9iUS+GWjAjj8xAzxoBKJu
	 XmWFjIFn8FChPjEUdTgHjFNFEdiBT4LNS6uK1Q0WzB49qx+KO1MRwR+enXIaWCI5ju
	 NSkc63nGDS1KA==
Date: Sat, 21 Mar 2026 19:36:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: David Lechner <dlechner@baylibre.com>, Christian Eggers
 <ceggers@arri.de>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: as73211: remove duplicate zero init of
 scan.chan[3]
Message-ID: <20260321193642.70052085@jic23-huawei>
In-Reply-To: <abgLFt_-OehTEWgb@ashevche-desk.local>
References: <20260315-iio-light-ad73211-remove-dup-zero-init-v1-1-4785c876ed92@baylibre.com>
	<abgLFt_-OehTEWgb@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 15:52:22 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, Mar 15, 2026 at 02:21:51PM -0500, David Lechner wrote:
> > Remove setting scan.chan[3] to zero. Since commit 433b99e92294 ("iio:
> > light: as73211: Ensure buffer holes are zeroed"), the entire scan struct
> > is zeroed before being filled with data, so this is redundant.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> ...
> 
> > static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)  
> 
> >  				(char *)&scan.chan[0], 3 * sizeof(scan.chan[0]));  
> 
> Side note: the above looks like a room to improve.
> 

Applied. Indeed that's an ugly line! 

Thanks,

Jonathan
