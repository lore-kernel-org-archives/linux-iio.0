Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4F3405C57;
	Sat, 16 May 2026 13:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778936683; cv=none; b=d7g6az2ASgYJg6E0PBUTqhYiPiQl0SJc00zF8P+rNGNwXb/O0624+ERMROHMr3mN1XOB2KIqObBuQmULIYbgUuW9E1EZlIVqESS4Ic1VOSJqSxWJt3bmNINxI30K0jd8Sxj9NrkjGlI4ARgbe91AYFEZ+66TmHt6E3wVBBcH2i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778936683; c=relaxed/simple;
	bh=zqj5Ia6SOv+KlWtDFSjFzlzYnpPVmsw6XpKLBmWboYk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pXG4XzmEszUTnmkTF8hCVCNEHwbCj6cCEK9DQBfsc/NZAcBuLSPPyUQM/E8QwdpoId+rVvxq6/I/JCxInzPh/ye4CJ2EZ9J4qBan80w7DDSRrYpONNIWCg5aVzZNsQ3N4R6aQLw1/9GF1MQkd/buEZ+bqE6Rw6DsV7I9rmE4Ipc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CznIeo+K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CznIeo+K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39CD7C19425;
	Sat, 16 May 2026 13:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778936682;
	bh=zqj5Ia6SOv+KlWtDFSjFzlzYnpPVmsw6XpKLBmWboYk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CznIeo+Kkyxvja/Pq+oofPS83JxtjL1uB1mZYtiUI6UQXC5xFBUXQc3ofN1xOi9Jn
	 IEOacv2k5ly3pbA3JOAsxUV7H/CZe54FWB17iPMKFxQJPz8aobvUGPEFs8Vs33dnzp
	 YoPBELYCoEuGXtJ+AIKhGNiitQOw0YcJ+vZqdlzvGTXc0Tk6qcrNZSeloxBi1giGkk
	 1FSIG7e6ddo9wtI7n8xXcPI4/cdPbUKsP4MkUgD7u99LmCwOu6ElA4S0VNnk16UKFG
	 bJDGu1pNpt6Hxl8sweS5lDuuglIVnqZ9FOS0b2UP0576/2DGrfz5A8gZXJbk3ipoNu
	 YsE0hHHkhFj7w==
Date: Sat, 16 May 2026 14:04:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rishi Gupta
 <gupt21@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] iio: light: veml6030: remove unnecessary read of
 IT index
Message-ID: <20260516140432.15809bea@jic23-huawei>
In-Reply-To: <agTX0jFuTueBU8EZ@ashevche-desk.local>
References: <20260513-veml6031x00-v2-0-4703ca661a1d@gmail.com>
	<20260513-veml6031x00-v2-1-4703ca661a1d@gmail.com>
	<agSt_TGpyujxqrZc@ashevche-desk.local>
	<DIHR7242IVEQ.HZ3NLNX0G9E1@gmail.com>
	<agTX0jFuTueBU8EZ@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 May 2026 22:58:10 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, May 14, 2026 at 07:17:24AM +1300, Javier Carrasco wrote:
> > On Thu May 14, 2026 at 5:59 AM +13, Andy Shevchenko wrote:  
> > > On Wed, May 13, 2026 at 05:49:41PM +1300, Javier Carrasco wrote:  
> > >> This is dead code as the IT index is not used by gts to set the new scale.
> > >> In its current form, the value is read but not used afterward. Remove
> > >> the dead code.  
> > >
> > > Does it have any side-effects on the HW side? Exempli gratia, flushing FIFO,
> > > R1C (read to clear 1) bits?
> > >  
> > >> Fixes: 22eaca4283b2 ("iio: light: veml6030: fix scale to conform to ABI")  
> > >
> > > Not sure it fixes anything. But it might regress, see above why.
> > >
> > > ...
> > >
> > > If no side-effects, the code wise looks good.  
> 
> > This patch does not have side effects on the HW side. Apart from having
> > it tested with real HW, the operation being handled here is setting a
> > new scale, which is stored in a persistent register.  
> 
> It's not only about volatile bits, but good that you able to test on real HW,
> this is much better than just theoretical clean up, thanks for confirming it
> works as expected.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

Applied to the testing branch of iio.git with fixes tag dropped.
