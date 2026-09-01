Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91DB3246E8;
	Tue,  1 Sep 2026 01:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225269; cv=none; b=MlloYTz3d2nrSgUOLQiG8cia8P9sBmOipxina1wiMKhvPzkzBoHNOB/lonyVrW3/RSxbhzZ7OFIHGcE2Z0wgbJrTQjg6KYFZQTpAWPRoBzIM4k3ftQWUco0VRT6PBAGsqjbs9PlgJj9X+XG1kAiGFzoSVDABeztuL/IR3aZE1ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225269; c=relaxed/simple;
	bh=/4ZrUkLqJAvESICKjzIdoCM6XgatbEzSBP25ZzLHJTE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hqeu4q50WbMDO/lbCPG5CD5j12E/9lHRLak+Xp9e5FoOwpIPy7AzWUi6xgzu+kgrPPqCJWQfYQDQ7kUyCgQlHWqJzBN8D+j2C1Z+h0WBUC5MkyT4K1gigX87SFyAuCElIqZt9mjh1txYEXEozVjQU15oxZ3a0956P1GyDUsqZJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkgZ4AZR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkgZ4AZR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB7C1F000E9;
	Tue,  1 Sep 2026 01:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788225266;
	bh=zotEN213Rc8xR+NuDKzpDkGMQKwazNvNPLziMG6ggbo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hkgZ4AZRBqBlv63hN21mgfLdqvV+3wLTA13XRbKGJQskycp7yQC+GhdXe7NNTX1Nv
	 1sfJGhxI+g5/ocMLPewgvEOzUrajd2YHRqJKnqZhcqY9RGekHGIefCjDCijwkDTVAp
	 U46RhUo5uNIdGDcDrONeIt5XFIFHst3a4olNUnvj2YQ378xw7XwhsI5BqrQ8bJbG2f
	 VNiMcchnD3hsrHAJo0ODR5/bQ6qeQh5UxAvlglXm7asNYta/lCzDfHIzTUUyqfqiZO
	 ChaT7OOVUrZHmE6D+WgHSTfzPPbLvia2pDXcodwm/TTUkyZ035v/BWOmmNFVMMbh7j
	 TEQFvKZFBz3Vw==
Date: Tue, 1 Sep 2026 02:14:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andi.shyti@kernel.org,
 wsa+renesas@sang-engineering.com, ojeda@kernel.org, dakr@kernel.org,
 igor.korotin@linux.dev, branstj@gmail.com, brucer42@gmail.com
Subject: Re: [RFC PATCH v5 2/3] rust: add minimal IIO subsystem abstractions
Message-ID: <20260901021420.144a64d3@jic23-huawei>
In-Reply-To: <CAO26r3RLnX4HXrKDF6akmG722Q2CvDU-uJ40Yfuu_wwJdGgA9g@mail.gmail.com>
References: <20260822062725.60519-1-muchamadcoirulanwar@gmail.com>
	<20260822062725.60519-3-muchamadcoirulanwar@gmail.com>
	<20260824010726.2849f3d8@jic23-huawei>
	<CAO26r3RLnX4HXrKDF6akmG722Q2CvDU-uJ40Yfuu_wwJdGgA9g@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Aug 2026 13:53:11 +0700
Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com> wrote:

> Hi Jonathan,
> 
> On Mon, 24 Aug 2026 at 07:07, Jonathan Cameron <jic23@kernel.org> wrote:
> > This looks fine to me subject to a few little things - see inline.
> >
> > However I didn't take the time to decode every line of rust today so there were bits
> > I simply didn't understand yet.  So for this to be able to move forward I'm going
> > to need reviews from rust experts!  
> 
> Thanks for the review. I'll add an explicit review request to Danilo
> and Igor in the v6 cover
> letter.
> 
> Brandon Saint-John has been CC'd since v2 and reviewed the series at
> v3. If he has time to look at it again, a Reviewed-by from him on the
> Rust abstractions would be welcome.

Sounds good.

> > > +
> > > +/// C-compatible trampoline for the `iio_info.read_raw` callback.
> > > +///
> > > +/// # Safety
> > > +///
> > > +/// This function is only called by the IIO core via the `read_raw` function
> > > +/// pointer in `iio_info`. The IIO core guarantees:
> > > +/// - `indio_dev` is a valid `iio_dev` allocated by `iio_device_alloc`.
> > > +/// - `chan` points to a valid channel spec from the device's channel array.
> > > +/// - `val` is a valid non-null pointer to a writable `int`.
> > > +/// - `val2` is a valid non-null pointer to a writable `int`. The IIO core
> > > +///   always passes stack-allocated storage for both, regardless of whether
> > > +///   the driver uses `val2` (e.g. `IIO_VAL_INT` only writes `val`; `val2`  
> >
> > That val2 is always a valid pointer smells a bit like the c interface leaking
> > into the rust.  I'm not necessarily against that being a constraint we take
> > on but I'm not sure how we document that. Probably add something to the C docs.
> > Any C driver relying on this today is probably buggy for other reasons.  
> 
> As you suggested, I'll add a note to the C-side iio_info.read_raw
> documentation in include/linux/iio/iio.h. The IIO core always passes
> stack-allocated storage for both val and val2 regardless of which
> IIO_VAL_* type the driver returns, so the assumption holds, it just
> isn't written down anywhere. I'll also note it in the SAFETY block of
> read_raw_callback.

Perfect. Thanks.  There are a lot of little things like this that we
don't document well on the C side of things.  Big advantage of your
work is it'll help us clean some of that up.

> 
> 
> > > +        Ok(IioVal::Fractional(v, v2)) => {
> > > +            // SAFETY: both `val` and `val2` are valid per the Safety contract.
> > > +            unsafe {
> > > +                *val = v;
> > > +                *val2 = v2.get();  
> >
> > Why get in some places and not others?  May well be a gap in my really limited
> > rust knowledge.  
> 
> This came up in v3 and I answered it then but forgot to add the comment
> as I said I would. IioVal::Fractional holds a NonZeroI32 denominator to
> prevent division-by-zero in iio_format_value(). NonZeroI32 is a newtype
> wrapper over i32, so .get() is needed to extract the inner i32. The
> other variants hold plain i32 and don't need it. I'll add an inline
> comment in v6.

Ah.  This is my lack of rust knowledge (and forgetfulness).  I'd avoid
putting too many comments in for the benefit of folk like me who are
still failing to find the time to learn rust :(  

Jonathan
