Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2FD3E172E;
	Thu, 25 Jun 2026 12:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782391891; cv=none; b=VyWKjUCklqO4gYhwhntGRqqZ8mSmrk8AXh8qSzGRQ8Il/YrbqaSIwVjPxc2rksaG1eaOZvJWB8igTJWUY+s/UvoXU94lAa6le5h9LsVVWjCYI1Y40eoAUoK0oR+9bA8g3qUFmLX02qqPzMQGIL/tNeTpRJ85MZ5EnjZ4tvmY16Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782391891; c=relaxed/simple;
	bh=0KY5pisGVRhnEuhpCJQP4FVCFO4yUslg/w9UkTeY5jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5HmC40crqSGNfR3PdvYSHHhDUgoK9jw58wwdgLUTVu58zlnKcDqwlTnc7R1EYhIFANxBNbBGULM12GI+esiM+CkdUDJwFE97ju/BHqX0VQtHzpgfxhFKB/qcV27TE7UCDhcdTeCAy1+iw/HSliv+NniObXle+El/9aG3MR/qX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GcWUAuYI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GcWUAuYI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1741F000E9;
	Thu, 25 Jun 2026 12:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782391890;
	bh=0KY5pisGVRhnEuhpCJQP4FVCFO4yUslg/w9UkTeY5jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GcWUAuYI8hZWuP+UEaG6pK0vUopuq9u0DUU5Te1SdOg5KbvIibBkq2D302L1jTRyp
	 QJrbje3pQpWUV39nBaJeou5/xhmllZrMHsQqFz5TryXazxKmn302Eq7ICTViKxEvLB
	 OEXyFHi1gl6D31E8i1hFipmZZYFeE6DPb1rxTR1M=
Date: Thu, 25 Jun 2026 13:40:18 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Batu Ada Tutkun <batuadatutkun@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: frequency: ad9834: use guard() for mutex
 locking
Message-ID: <2026062558-ambiance-recipient-707f@gregkh>
References: <20260625120456.1267-1-batuadatutkun@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625120456.1267-1-batuadatutkun@gmail.com>

On Thu, Jun 25, 2026 at 03:04:55PM +0300, Batu Ada Tutkun wrote:
> Replace manual mutex_lock()/mutex_unlock() pairs with guard(mutex) in
> ad9834_write() and ad9834_store_wavetype(). The mutex is now released
> automatically when each function returns, removing the need for
> explicit unlock calls.

You only need to do this for new code, no need to change existing code
unless you are fixing a bug by using guard().

thanks,

greg k-h
