Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A34F42188D;
	Tue,  5 May 2026 12:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777982987; cv=none; b=pkd6mRfm5fIhPyJ7OxRZnPbCCj87CGg9oDDc0c9MuPL4Im18vHcWXJdfIW8j0ehxPLxp9R8RqCpk5cv1UXj+HFOOe1rEievtR5/QVfEbsZgfeE6Ek7vVkMcvQYraERSAXF9+X1pxuQZFuhLZQxtsLHxwt0d1vd4CUUzhi/SjUzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777982987; c=relaxed/simple;
	bh=ICVN5ga59PeeFDjeBMuG5pg4GosJyFHV0RUJjQGp7Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ru+JpsvIA61Sj5zF/Z0N5TWh0agF51KRzbg8e2TUXXJM659fBw7lgTmUrzSYI8qpzSnOmeKH/uzSC8LW88bL5Do6cYXKR/MHMbL033PuaheyNdXcrxvO4n0wh12sVAekQVRDCk+yZ8ab+uimxreHR9I3m/63CnM8avOFJkjbN2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nx5Sk9tS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nx5Sk9tS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679BCC2BCB4;
	Tue,  5 May 2026 12:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777982987;
	bh=ICVN5ga59PeeFDjeBMuG5pg4GosJyFHV0RUJjQGp7Lc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nx5Sk9tSW66FewfsHRU/z6xMUbWAaIHvUDG1L5Wi3FqabKtgfzW6ukNtsvPiYn/1w
	 Jc3TUhqtQVG6ZHUntyeqrDpRmq6a2OEV12fsLcRUf+KLxW6W9OPxcGNsI4kxR0EjmY
	 0a72xy+6nvBmhnIl5mcN8KmX+CfAM1uyZSZsdU7X4Ld92X/Qm6VtHCrJIMh63nUVeh
	 jMNb0zF/pBP5IfYyAffFM69CdHRRV7iUVIMbXZJRlHuU5+q8NX/2ytkl/GjP9H+KLR
	 jardPihSOqoGNHGWTrrBrD9q9YLINU+aBtw6a8zccgNIBWsrAh32XQ9FR4Yx9Y3sg+
	 0lSZrkiJm5Dog==
Date: Tue, 5 May 2026 13:09:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>,
 rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
 Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>,
 Michael Auchter <michael.auchter@ni.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Andy
 Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v5 03/12] iio: dac: ad5686: acquire lock when doing
 powerdown control
Message-ID: <20260505130937.31ce7156@jic23-huawei>
In-Reply-To: <iu6ybzwcpkforriv5fgtryzekfldddxnx5cnzpdmzdz2xll3fh@5ymrecfbtmn7>
References: <20260501-ad5686-fixes-v5-0-0b2f45488418@analog.com>
	<20260501-ad5686-fixes-v5-3-0b2f45488418@analog.com>
	<20260505120544.693cadf4@jic23-huawei>
	<iu6ybzwcpkforriv5fgtryzekfldddxnx5cnzpdmzdz2xll3fh@5ymrecfbtmn7>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 May 2026 12:16:09 +0100
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 26/05/05 12:05PM, Jonathan Cameron wrote:
> > On Fri, 01 May 2026 10:14:56 +0100
> > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> >   
> > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > 
> > > Protect write access of pwr_down_mode and pwr_down_mask fields with
> > > existing mutex lock. Each channel exposes their own attributes for
> > > controlling powerdown modes and powerdown state. This fixes potential
> > > race conditions as those functions perform non-atomic read-modify-write
> > > operations to those pwr_down_* fields. This issue exists since the
> > > ad5686 driver was first introduced.
> > > 
> > > Fixes: c2f37c8dcadc ("iio: dac: New driver for AD5686R, AD5685R, AD5684R Digital to analog converters")
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>  
> > https://sashiko.dev/#/patchset/20260501-ad5686-fixes-v5-0-0b2f45488418%40analog.com
> > 
> > Reasonable concern about possible races in the read path leading to
> > -EPERM rather than simply the wrong value.
> > 
> > The other bit about not updating hardware is true but I think it's fine not to change
> > what powerdown mode we are in whilst powered down.  
> 
> True! I've seen sashiko review for this, I have a v6 ready with its feeback.
> Just waiting for some more reviews (like yours). I might be sending to many new versions
> for this one in a short amount of time!
> 
Cool. In cases like this it is useful to reply with a 'review' of your own
patch.  Saves other reviewers from commenting on things you've already dealt
with.

Anyhow, good to hear you already have it in hand

Thanks,

Jonathan
