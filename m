Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E63432AABC;
	Tue, 28 Apr 2026 17:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777398857; cv=none; b=KmV86S7qzHN6RceD7C6gm/7SuBJJJ0zqgDwjsmtvsMdkHVrVyxqYO/cDY2Wgzfk+N9B3KbHHvYV9ti20zwMtGDm+NP32DesQC+NrDcQ/4ITMnS68efiYWg8psk2Hln3TnQ/dEHURX2P0pksqQfbvMBpnOyckRUpXpkOqChEJflA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777398857; c=relaxed/simple;
	bh=dVIXiIwoCKW0sJZFtHXL6Jc4YP+robNzYsnUBNL8Sww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jzszPvAKnb+OoiQHqD4o7mEZI8BoKr7gg4IMYfhBFIzMPE15IB6z7yVG5Wy5r4Mgn2aZn4X9lBtjPLyLhiiTLJHVwYlqm2PRiHdZPAQe33+zS0/gpoDAGVTGXpcNkZIhhyv5Ug3BL5EXHEwXeHx2VZn+nW/jhhH2Y5VnyPpGQsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Csmj/EkV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Csmj/EkV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A15C2BCB7;
	Tue, 28 Apr 2026 17:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777398856;
	bh=dVIXiIwoCKW0sJZFtHXL6Jc4YP+robNzYsnUBNL8Sww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Csmj/EkVmwaMf55FqHyurSc+P385tG0HDerYCG5WBJZEF2FOYJCptT+gr7+3WAThR
	 cYPshAW4v2wNqc8uDQEDAKPV1RX4CQQEDkgI2UzXM3fgRXIr9KBA1F8l20YXcS3mxU
	 ePp4O9YLAC2cmb6lImAUyqgQ3uXiFu4PmSvJriJWRe9/kXgX3tqwKIhbrgLL+Z+Zfr
	 IzHCSscI7NueYtGz3b7v/W6k0ShLCJXfcBhaiyBgE1sokaXlBcj1g3F+BELtgUT7SJ
	 DEP80AZNYIPnZqdthxXtgYwsPUkUlkMJ4fDEwyeap4SpD7XU+Xk/0xZn49qCumPmWs
	 wN9/q/k3zPfMw==
Date: Tue, 28 Apr 2026 18:54:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Piyush Patle
 <piyushpatle228@gmail.com>, ak@it-klinger.de, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/7] iio: adc: hx711: update Kconfig, module
 description and file header
Message-ID: <20260428185404.26f3da04@jic23-huawei>
In-Reply-To: <CALoEA-w=giUoevbAh+i66ATKfXCr9WUE0R6G6DOMq2xE8cibEA@mail.gmail.com>
References: <20260427100950.33936-1-piyushpatle228@gmail.com>
	<20260427100950.33936-4-piyushpatle228@gmail.com>
	<CALoEA-wAUpZ7_2_3kB33mNB_Y_DAc_p7QwPR9a5pxL1iET_cdw@mail.gmail.com>
	<ae9otn7HuPKVtzsk@ashevche-desk.local>
	<CALoEA-w=giUoevbAh+i66ATKfXCr9WUE0R6G6DOMq2xE8cibEA@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 15:49:06 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Mon, 27 Apr 2026 at 15:46, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > On Mon, Apr 27, 2026 at 12:26:53PM +0200, Joshua Crofts wrote:  
> > > On Mon, 27 Apr 2026 at 12:23, Piyush Patle <piyushpatle228@gmail.com> wrote:  
> >
> > ...
> >  
> > > > +         which are used for bridge sensors such as weigh cells.  
> > >
> > > Typo here.  
> >
> > It's better if you point exactly what the typo is.
> > I think you meant "weigh" that should be "weight"?  
> 
> Yep, that's it, my mistake.

Nope. They are called weigh cells not weight cells.



> 

