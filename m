Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795656270;
	b=JDSylfPfzPLOw4Yia9hZQrsYBST5qXIYNg4x7mJGa97I9PoYPg7c+5AiMSCTXDmr1/Kr
	 G7Xlvve9DVftlbIsq91cwQ5zoIeukXN+bklLMfnDkWBJzesnuuc9hpBWNC1SXeZWsuaEb
	 uBfKQN6vuLIJmlHmD0ZG4ipCZJCT9D3Pw8DrLvlbT8E07Mvqv4A5Z7NtAz1ZetYJv9Yu3
	 pFwK8Fc5/3OiFNHNblaXo36BdyaxoRgMOiAwUmWbIfdUtox6drrW9nliACCG40Ty6uT7j
	 IkWU/XGHoOavzELnOl4uloEg2cKNU9Vx9fggRDAcI61+Hco0gnVjBsYI+E3J2uwTVnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795656270;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=oUw4CIipF92U6Bf0z/Muwun4pHzjQbWp6wVyUB4u0UM=;
	b=uJJl3WrGdYHhcrjZzyJpMavivVPFMx3PqlcA/5Nbk9pyLBLF4RDtTeU6LqbCGvwO4+jY
	 UQcetWYurZguRAGRCcWsj8ah9heJGKP9Lu/I2/nuypQG+pOifAw6IFIGWTewEp3mG+Twt
	 iYKziWtgFy2juxstmeG/6uBUz3bWnrZeFoOtRyQ6dNg6+BSH4M/yYSGXJGIuO6HdecCSD
	 FZBnEKQiJJ+Ka6CxbzGllazREvnrn2J8fFbMRCLVG7cICUBBB2yAUUUnlIOPJdUcBGSML
	 SjCIHpvPEm1sDru87gd2ALt44+58tWoASnXm4v03L1sXZTpz7KJep7THd+M9pf11BJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LlgwLdnC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58DC606A31E;
	Thu, 26 Nov 2026 01:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LlgwLdnC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2C31F000C6;
	Thu, 26 Nov 2026 01:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795656270;
	bh=oUw4CIipF92U6Bf0z/Muwun4pHzjQbWp6wVyUB4u0UM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LlgwLdnCUWkpKGQQt407+kD4EJ07JJ1B+BIxuABrDsmb8pHDJx/gqSBQSkwBLp3WA
	 z6q/P+HcaS/9l995D+Zq6RWBwVaPFnB63jyhBsEQARQ+BO1RVS22zOIARYhQWEKK4W
	 azBFJtBdOFw+lzISFwWzyjWcYhbfoOISveDZcHi1W7CY7AghguAAUJ4U+G248UdvmH
	 T04euMFfa3Cr1/c3iootJzPmADLFGQD7WLox8Nv2gU8imJw57bwCId5Y6gdeQtoxfn
	 +gk0EbdHmHh0+3sz0xyW5AgMho89IoaOpJxGZJ7UVSKvXuQ5rDBRh6vlgYOgIJzFG0
	 ZIZIo5YLmGKRw==
Date: Thu, 26 Nov 2026 01:24:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: joshua.crofts1@gmail.com, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, David Lechner <dlechner@baylibre.com>,
 Nuno Sa <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_mpu6050: use named initializers for temp
 in hw_info[]
Message-ID: <20261126012423.2e5754be@jic23-hlaptop>
In-Reply-To: <20261024030205.1ed973b1@jic23-hlaptop>
References: <20261018000924.758186-1-kapoorarnav43@gmail.com>
	<20261020095936.00002ff3@gmail.com>
	<20261021183823.169199-1-kapoorarnav43@gmail.com>
	<20261024030205.1ed973b1@jic23-hlaptop>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Oct 2026 03:02:05 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 22 Oct 2026 00:08:00 +0530
> Arnav Kapoor <kapoorarnav43@gmail.com> wrote:
> 
> > On Tue, 20 Oct 2026 09:59:36 +0200, Joshua Crofts wrote:  
> > > Your patch fails to apply, please check it out.    
> > 
> > Thanks for trying it. The patch is based on iio.git fixes-togreg, on
> > top of commit 2b8d4cd20ac8 ("iio: imu: inv_mpu6050: fix swapped accel
> > and gyro startup times"), which changes the neighbouring .startup_time
> > lines in every hw_info[] entry. It applies cleanly there, but not on
> > togreg or testing, which don't have that fix yet. I should have said so
> > below the ---, sorry.
> > 
> > Jonathan, I can resend once that fix has reached togreg, or rebase it
> > however you prefer.  
> 
> I'll hold it in patchwork so you shouldn't need to resend.
> I tend to do a sanity check on state of patches ever few weeks that
> picks up things like this.
> 
> But feel free to poke me if I seem to have lost it.
Applied to the testing branch of iio.git.

I just merged in rc4 and got the fixes.

Thanks,

Jonathan

> 
> Jonathan
> 
> > 
> > Thanks,
> > Arnav  
> 
> 

