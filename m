Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3DA1C695;
	Mon, 21 Sep 2026 02:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789958544; cv=none; b=I+LBaGaqsCBGTMvg+d0m1xpbkZZUG6DDiUHF/pqAZdQlQdMjHsjdGWdNhO0oFcaZML04bDT7Ib2XTTbSFzBoRn/NuB4xqbGBBI5J0fRObWNiTI8gIKXZYcq3l2Vjgteu1NUnY66T+4B5Ip8Tb+e5GbSdtfR9ymonhn47dQls5bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789958544; c=relaxed/simple;
	bh=rqUZhq6FGLgK9HJYynd7McvQht7yS1FoXSeDoganFcc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=svY5Fqc0B0cZ6eiDyUpavU20pVMV8Lev0DNExQy1rHieLIj2Vduf9E9H+qbxTE9l0n7CjWoKZweQaHwmpaJP9X61JU62zELZc9URcoAwn4R3/pGvcCZ9eXd9SZqXl86Ogheh/oJiNXa/F60YVjrv6AInCES6zo+rpAhiUsTHtbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBeBt9x7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBeBt9x7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA9F1F000FF;
	Mon, 21 Sep 2026 02:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789958543;
	bh=/bP2P06kLvgPkyhpVNzT6k606fwq12DxgFbkk6tfbMQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PBeBt9x7DdoVQU7tr2KgmMAn1i4H64u2l4SsVrtKW23pblTwsxqfEZSV+ngfiBlj1
	 6NYV/Uh6YOfQasaBnIiI6W/BXBML9VomIOem7W1mGPwk+jl+yM/1XibtXyKCHSTOrk
	 DudkEoFCOt8wTWktSVli8dEkZvpyKLDa47f/YQwLWJZBNrCyyLCjwn5IPKnanKDUTe
	 OQ3kGzcMnOTyydvIiTJ3WiBdZB4vGrwrXmfZy+F0YrEnk8DK+gcyJaJvckgwCf5oqA
	 D4OQxs5IUfhnuFXPC90aAHb3myfVHGcOGO5kf264ZbxIm4+9NR7Y7T+IOlP0a5HKcP
	 46RnLg+knHQTw==
Date: Mon, 21 Sep 2026 03:42:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>, Conor Dooley
 <conor.dooley@microchip.com>, Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v10 00/17] AD9910 Direct Digital Synthesizer
Message-ID: <20260921034218.45c93e1a@jic23-hlaptop>
In-Reply-To: <20260907230505.277f1a6d@jic23-huawei>
References: <20260729-ad9910-iio-driver-v10-0-aa1f6167729e@analog.com>
	<20260802010959.25f9f4df@jic23-huawei>
	<20260802015846.2be354ec@jic23-huawei>
	<q2t53ly3vl73kmu3ehvntnj75pxl2smntctcuxzjuaguihqwju@adzts2ezpg5x>
	<20260907230505.277f1a6d@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Sep 2026 23:05:05 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 4 Aug 2026 11:56:26 +0100
> Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:
> 
> > On 02/08/26 01:58, Jonathan Cameron wrote:  
> > > On Sun, 2 Aug 2026 01:09:59 +0100
> > > Jonathan Cameron <jic23@kernel.org> wrote:
> > >     
> > > > On Wed, 29 Jul 2026 09:25:27 +0100
> > > > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> > > >     
> > > > > This patch series adds support for the Analog Devices AD9910 DDS.
> > > > >       
> > > > Series applied with that small Kconfig help tweak and a bit of fuzz
> > > > around the new channel type due to the flow sensor I merged earlier today.    
> > 
> > Thanks! Let me know if you need a v11, I suppose We are going to wait on the
> > mul_u64_add_u64_div_u64() fix anyways.
> >   
> > > And dropped again :( See patch 11 reply.    
> >   
> 
> Picked up on top of an immutable  branch with the necessary x86
> fixup. ib-iio-x86-asm-fix-7.3
> 
> So this is now on the testing branch of iio.git

And here we go again. Merge rc4 and cherry-picked the patches
on top of that.  Hopefully I didn't mess it up - please
take a look as now pushed out as testing

Thanks

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> 
> 

