Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ECA4CF490;
	Sat, 17 Oct 2026 23:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792278133; cv=none; b=JRb3S7PjHWsIyH8uhXfamp9qYxxj+DoTrDiQudfvs3LKrm/Va7PK/B3024P9UD1eTJOcYlHgn/o5b2k+JdD/ZJPXUp3PjIIXhF7nv2Q0l8X4Hy+a/X9iiWAJe5qzRZpxBReM4xMJwIvlE5KtlZPSwDSEbeiW8yuX0ioIJpm+oxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792278133; c=relaxed/simple;
	bh=EVUKlRpXGCqZ4VWR92lBQvLP96vfZa69eCJA2n/8YPg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZwbFQlPH5kAlH5UFLnbCSdT1XVwZ9xhXIqW+xqtwDp5XuxRZLoRz0/uXs7COfRhT5Pg+OEfE0TiAl1YTeviQA7MsMDQkVFTOe1iLzYSvkCUaddw8rWLQtQVcv/vVpLkiKFlX8SfzQQ3+hAwm2Sz26fLb5SdSyGfIVtJUeUEzrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czJLVQVp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czJLVQVp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33B11F000C4;
	Sat, 17 Oct 2026 23:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792278132;
	bh=FDw5qsSU8x/5QMunwf7IgMPDI/v8VTssP28c0KKSwmM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=czJLVQVpsYXu4fPTZoTle8Y0l8tpcK+XCQTBDfCVNu0+cFVWkloDOqJnA6OLEdxRf
	 r/kqLLiJmJb4HgKiYql7fdcoNVYP18yXxdDUhpssdzkhMarajjO03oRIeHxuFjRBz4
	 CcP43S1CQKxR1L4KylgELL4AnFhsPdTBqYSKfLWLWbjk76JzSFxOXfeRZVwCNNYtyo
	 U1VnbWCO7T1wYiWCitLpp9g/ySWxL7zl0O7jlAzZ+2pN5OPjy85iKG2y0J7tJLP8nx
	 fz+cqbrysEOA5izsdzPFuXdBlMhsymzSe3+6emowuaVl2KZ5NftuqotXlTSwWr/6MV
	 /TLKbEglXh+7w==
Date: Sun, 18 Oct 2026 00:02:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>, Joshua Crofts
 <joshua.crofts1@gmail.com>, Benson Leung <bleung@chromium.org>, Guenter
 Roeck <groeck@chromium.org>, David Lechner <dlechner@baylibre.com>, Nuno Sa
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 chrome-platform@lists.linux.dev, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: common: cros_ec_sensors: use sensor_scale union
 member for CALIBSCALE
Message-ID: <20261018000206.55b279de@jic23-hlaptop>
In-Reply-To: <as6Mr7BSbJeJRlBq@ashevche-desk.local>
References: <20261011045410.356156-1-kapoorarnav43@gmail.com>
	<20261011191641.4e9e2ac4@systembl0wer>
	<20261012211733.575305-1-kapoorarnav43@gmail.com>
	<as6Mr7BSbJeJRlBq@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Oct 2026 22:55:27 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Oct 13, 2026 at 02:47:30AM +0530, Arnav Kapoor wrote:
> > On Sun, 11 Oct 2026 19:16:41 +0200, Joshua Crofts wrote:  
> > > Please add a Fixes tag. Otherwise looks good to me!
> > >
> > > Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>  
> > 
> > Thanks for the review. The mismatch was introduced when CALIBSCALE
> > support was added:
> > 
> > Fixes: ed1f2e85da79 ("iio: cros_ec: Add calibscale for 3d MEMS")
> > 
> > Jonathan, could you pick this up when applying, or would you prefer a v2?  
> 
> No need to resend, `b4` will scan the whole email thread for the tags.
If it could put them in the right order for 'late' fixes tags it would
be perfect (easy fix though so don't resend!)
> 

This driver tends to be well maintained so whilst I'm fine
with the change I'll wait a bit for a tag from one of the maintainers.

Jonathan
