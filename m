Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023863932F0;
	Tue,  2 Jun 2026 11:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780400987; cv=none; b=cSwASMRULFWSwUmhMtEI4JkTAysZTeC4kFDnKIkdfP3ElvvFtmdJ0DgUDlnKqQuCx7NewJs/qfnNez29E9axdBu20vW8pXhcORTuld+6PW0zq+B19mQHT36EeY3lUWMOdqoriJBJAv09pgya1a6yceEtHpMVCn9815uwDMRyDgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780400987; c=relaxed/simple;
	bh=evDey7O+95aMZzzj3uOK38V5MR+/RpZxRT6Ri2uFYWw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TFld/swrw20bS+xaOgpaNTzKFtd+ly1xoCcQ4DtUHx3cIYSN+UvUa5jd9n4FXn8QGfrOWd/tWBR3zKSAS4MFq1XCAVS/QFQTsmhSH/VBSFuoQQqoNJYKQY1hqc4NfwSqbZbAwzcCMMgVtFXUoE+uieg0h7EhYNQ0ODAhbSOZ3jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSG5kGyi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSG5kGyi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169B61F00898;
	Tue,  2 Jun 2026 11:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780400985;
	bh=zvk9UcDYxd2RS2Yjad5G26+5hWLU9Km26OekTthy7xM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PSG5kGyiTXaUomqrHtX7LpcGvgHHC+Z6ltgKEKHgqHwG7TucrgBuFYKBf2CGxMuit
	 iPCI+h3DUgMkeF7BDcrnroqSrrxDTrn4KYQLFXWwcjOBb2XMIpv2tS3D5e25Rv4s8Y
	 bF5ZuHehmlZU2rtVy5G/Ycg63/phT9K7AFMYbBANo/CVOcZ/PIcWzfu5ZTt95PbxiF
	 kGrjEFDF0A4t8vdRfwb4735ZH8tRZBzOyRlQ7X5JiOCqcamTD3dUbuv1BdRm53ehrT
	 16UBWpippYFzRw495y9RSmkENBWO1bmzZ84u0ShOazuSbiTbcphAOXMqGhT9hRIv5l
	 EMegM68inJ6Mg==
Date: Tue, 2 Jun 2026 12:49:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Maxwell Doose <m32285159@gmail.com>, Tomasz Duszynski
 <tduszyns@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open
 list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] iio: chemical: sps30: Replace manual locking with
 RAII locking
Message-ID: <20260602124940.6b7b75f4@jic23-huawei>
In-Reply-To: <ah6CfotGBX2VIAvL@ashevche-desk.local>
References: <20260519212602.30541-1-m32285159@gmail.com>
	<ah6CfotGBX2VIAvL@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jun 2026 10:13:02 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, May 19, 2026 at 04:26:02PM -0500, Maxwell Doose wrote:
> > Replace manual mutex_lock() and mutex_unlock() calls with the much newer
> > guard(mutex)() and scoped_guard() macros to enable RAII patterns,
> > modernize the driver, and to increase readability.
> > 
> > Add guard(mutex)() into sps30_do_meas() as every caller locks it's call.  
> 
> ...
> 
> > -	mutex_lock(&state->lock);
> > +	guard(mutex)(&state->lock);
> > +
> >  	ret = state->ops->write_cleaning_period(state, cpu_to_be32(val));
> > -	if (ret) {
> > -		mutex_unlock(&state->lock);
> > +	if (ret)
> >  		return ret;
> > -	}
> >  
> >  	msleep(20);  
> 
> Hmm... msleep() under the mutex?
> 
Device needs to ensure no other access to the hardware whilst a reading
is ongoing.  Mutex being held over that sleep seems appropriate to me
given expectation is that any userspace code that is messing with other
paths that take the lock is shooting itself in the foot and should probably
be doing it's own serialization at a higher level (i.e. not hitting the
sysfs interface from mutliple threads).

Jonathan


