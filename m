Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367D33911DF;
	Sat, 22 Aug 2026 22:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787437805; cv=none; b=RRnNNQoD4lAgb1HtmDXeQitGDjzu7/61VH+jSdicOd3YR1AV9c8pKTtfXQxQNeRpiSwz0EJcWbLp47WEcvtdjvh1xU6sbHh0ufxWPHaAuJN7ohk58NbKjWKLb2jWu9Vs8d5ASmY3ByLe+V/CFpQnMGHDY4fQOm4ZAZfTE/M4R5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787437805; c=relaxed/simple;
	bh=zOSyr570s2APd9nvKNoo1QnQABC+UYUcAlmqxUQCh68=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OHDEKnRqs71HjdwtimB7IhOvgLRkkDDdqexzM1aSoL+3N7MGE+3Odukf33SpQW5iAceidfbOVemb7A/DuMMPpZnJtQ4DR9KSGNuYsFo7Tp89+fQZxEkE6iPTUQvqcoF0pW45/v4islNF5nWHFzSl+yqvapVLkldP9l9tmzaUmj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7apuYWm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7apuYWm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7861F000E9;
	Sat, 22 Aug 2026 22:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787437802;
	bh=2uRFXB1UbvhjQI79vfSgPsb2P9PJ0T4iKzW98JSADyI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G7apuYWmmpURUjNRPizl5sTSW6SwSL6uQEZ7TTX4FkNw+2va6ukFyMx2tQ8tUPiEj
	 Vop1gJbcEaMApKiGiO/8NMev+exCd6ILdZ4ZqtVTaYY93lbfbdqmRNaLw+34zYNlWV
	 7uSNwzt2mT9+YEfWCG5VyI4gREpap/9hEErDThVxfK/f/gLQy9NbYnYgMddOVGjxto
	 7szxHfD50Wda5mcXO2Vte2PtEDYTO6rjsa1mwml19lNyHQQQrT0KXgAYhOvs2BB5C4
	 dfNH4dwUnIl2OoSe0KOwZ/+0KtFv9jJGzLkZaEgpYX6iXw8LMUOwg2jkzLk0fZR3pG
	 qklXJ3s3RTvvg==
Date: Sat, 22 Aug 2026 23:29:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add patchwork link to iio entry
Message-ID: <20260822232957.14bb08aa@jic23-huawei>
In-Reply-To: <aoMmbxDElUZ0oj2M@ashevche-desk.local>
References: <20260817113738.1324-1-joshua.crofts1@gmail.com>
	<aoMmbxDElUZ0oj2M@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 18:19:11 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Aug 17, 2026 at 11:37:23AM +0000, Joshua Crofts wrote:
> > The IIO subsystem entry in MAINTAINERS is missing the link to the IIO
> > patchwork system, making its existence lesser known.
> > 
> > Add the missing link.  
> 
> TIL, that we have special entry type in MAINTAINERS for that.
> (TBH, never thought about it)
> 
Likewise!

Applied.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

