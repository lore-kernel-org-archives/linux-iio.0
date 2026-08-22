Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577C62F3C07;
	Sat, 22 Aug 2026 01:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787363761; cv=none; b=sDeK3LTiTGWGeX2gRgdklqUZ5GPtY5D/CYEk2T1HmsGDGUmVUy4syHjwSruUvZ9Ksp00ayjQmfifFwZNeC058qqClQXU9XpCAHnMLRiAIDfv3/mhWQPZZgEYwqjEDKPMJyk17eYLyfqvc+71IvmoxZrfvyjAFTA3Jd/Sps056xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787363761; c=relaxed/simple;
	bh=oOHJQ4SzP3X1zRSqo297QGi2WTmJsk/6/U+ht8Y84G4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oE3zOFd6+uOuRO0/7x3M9EJFzz5MiHTT1x1pnDyd4LiUsA3iJM7fziLDbqUadE5VtmiY5KMEOsyFXv9U2fNsFUyN/jppL08oQ1MLFE5GU40WrC6oUmS7SIuBgBmECe1W3U7d5xHBrzWmpG31Wx3tq5w15PyLVlR9quVnB4FAaII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npd2P3QS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npd2P3QS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729501F000E9;
	Sat, 22 Aug 2026 01:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787363759;
	bh=3B2EFBNCnTvdzUPYkq/6Cx4gjX830mklMaEp9EDrc2k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=npd2P3QSQT0F+9/ETkb/dDznx56S+M/D0+3MxobscVzz08K811q3//BZqGNPH8iaS
	 1kJuXqAv5n1RNj7ha/bi9zFbxNO28JzC6FJuSZyI5bDAf+q74EjEwVzgtjr7HaGVY4
	 W4rQVBb//xrikqWDr8Rgqyw9+er7cae3V2V1/67ej7G/LFrrB/1K/W/zFOwH+mBbA0
	 ZVYzGVz4pr08HXPUj/HLB4kCQ/YdXbkF+Z3AN7FNOxOkff1OV+7iqzRd1BSkDVYRPC
	 D2PIRD46Ha9zJcS7tW88VmuURqZgjM2I4cw1JxzAqJCIY1fl1KeQL91P94X2Y7lD6b
	 SAwrEbYOApFaA==
Date: Sat, 22 Aug 2026 02:55:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Adi <adinata.softwareengineer@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, lorenzo@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2 0/5] iio: humidity: hts221: update probe and logging
 implementations
Message-ID: <20260822025557.75714fd1@jic23-huawei>
In-Reply-To: <CABZ6vuAye2aO1BvhXjBAdAJFOmDGkQcXrPN3Bn-VhpEiQGXQog@mail.gmail.com>
References: <20260813153129.12423-1-adinata.softwareengineer@gmail.com>
	<aoK25pW-4Sxr2yh5@ashevche-desk.local>
	<CABZ6vuAye2aO1BvhXjBAdAJFOmDGkQcXrPN3Bn-VhpEiQGXQog@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 22:55:17 +0800
Adi <adinata.softwareengineer@gmail.com> wrote:

> > Looks like you've fixed up the stuff Andy pointed out in v1 and all looked
> > reasonable to me, so applied to the testing branch of iio.git.
> >
> > Note that branch will be rebased on 7.3-rc1 once available and only
> > then pushed out for linux-next to pick up.
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>  
> 
> Thank you for the advice and help.
> 
Added the tag.
Thanks

J
> Regards,
> Adi Nata

