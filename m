Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794995801;
	b=vHKk1qZMTQn5cAdLZtgYdrIKULYtGguAywniV2ZZlgF7R7ieNLyWHtrUFJ0CBsLRVDP4
	 SO9+OZcAEOx0i360oqBkebHDf/CEVmM7lNOepWXmg7sRydY4c7aLWsRIvugH2I1LlkI3S
	 1SBFyQ4Z4MLiOAiM3bsp6JC6za/ECuc7FulrwlG6CLPn09iVDwLncT8/FzGBpXkgIYbuz
	 b3Pt51FlduVsHvkaLcKiojZ+azPR5vtJoPmWqja0BZ2a5aJK58aLBSUklDSDeHv5bQgHh
	 bGajwbDH3JAbj+t7Y+pOiuYobA4YKlvqxAyvkmp/gQRcK7ACtQtiCAwr1S1f995VJCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794995801;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rEM78S/8/8XKwgKKOokwwTk8Yg7/gNMRUZ72Gt6ak98=;
	b=T7STpnKVTZ+ekuIg4fFPDf+ok17Ttl3WXWqmwNY2J9Unzi52jL84b61Ab1FxeC/VFCDQ
	 0eNfQGRWxu3fvYgz3wFx3beJHu7OYFSvwEQ11n/R3ytxbjJ1oxOrMnfFcjRWPGftk8xvw
	 SvnEwegzckTZipx3WyWoNriwuQVuIEpdompWVgf0AVD2/lt0GrBsXdb0wgsci/JnKSN0Q
	 EjKdbn2dTTtCXFTRgAAU94mhuifcbHaH2K7zeMiqAAqVTccsrURoYDjcOGeCq88U/YE4D
	 tC+/JfCkunbtqPgvP72BRxxkLI7+nETpuOSI42RWvF2pXdgdTmgccDYqdVVdVdBFhMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BwAjaLHu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7215B606A31C;
	Wed, 18 Nov 2026 09:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BwAjaLHu
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794995801;
	b=BAVwnEbKpT7FJ35TOGoHAaL5QueumzdvJDjigWtSQfmR8yUzpLVHU/tw1cy+HiG/rnT9
	 jsy0hIowE6gIZdbN4Afn1V+TPl4oGdcFDo+DCyDcDhFqB5CJO5ZiPuqFb8BDBvxUIqcXb
	 jEQIOsvyfnmKwaXTrNnXsUx6yPnG6HJic7+a4NQT+MCUIl/6pfXPB2vk32NXuR3W4jAiH
	 1km+OWZAon/QPgvhn6J28xDmFYjw6JxJ2bnXl9JQNAj5sSq2fTR1nhbsfS6racaaa7J7E
	 LDtwFMIuJOIXEGWJKeIVODHk0v0yuTNQvbV06kglsM1uYH97N3bEvghB2KjsYbafHDQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794995801;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rEM78S/8/8XKwgKKOokwwTk8Yg7/gNMRUZ72Gt6ak98=;
	b=1hLsBQzKiwEo87/4rlSVLk5I0P4gBRblbMS92mquRWGXgVRfD7XYDV4/PS74WAZzPWaQ
	 O95JsFoHa0vkyJJJAKEW8gcGtpbizhO7bronMlyCB8+3jZzKL8bSIwJu6tfhXwxed7Ptd
	 1n5AFVV9HdQgdZvBlJTxx+4PL5JDYWp/HbOrQaDY7tQmyFiH/+PRDH0CZ07lzn7QeUQ7n
	 k8FHZPHP7eBZPx0gV1bkAaqJVZQwZi1xHPJNiokG/9zPYJ7Dit7Mdupfo+Ji3kL4ExUvP
	 wMHFbqX+O7Djv6YWi7bJWCOHlofjuXL5kOcIYAHnj/Rl4r4bOAzjbgBJIcSF2W/MnzA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 11CDE1F000C4;
	Wed, 18 Nov 2026 09:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794995801;
	bh=rEM78S/8/8XKwgKKOokwwTk8Yg7/gNMRUZ72Gt6ak98=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BwAjaLHuz8xDeeiOT1gnBpLKKE1iamwQPW5WLrnhOUGPGmMQFp/6mMkbmMNyBf2rB
	 dcw2SeCaXbUqCUmnT75/WkEFT0iuss9Jyx7radlcPkIttGdqoXUdkGsqQS9v5r4AGV
	 4KC/Q9ztEsSUXZNLpIPTI1oOP9NJ3tSs0ZPL52YH/vVVRhE80cau5NFD3yGAsbMqYL
	 Z0JtyUqvFk9BPv3426wkU/fGirSeZ0BrFAthpzhpeYoIcBDPQJwv7hwJ21D5UMTjyb
	 yE3EPiG5DvVwaH9yTwaYieNwNTLrtpgnUmoTFgXsbzQbGOBoj1Hpx6inxrdizvem8E
	 63xD53kb8j7Yw==
Date: Wed, 18 Nov 2026 10:56:26 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Cristian Ciocaltea
 <cristian.ciocaltea@collabora.com>, linux@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Esteban Blanc <eblanc@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Andy Shevchenko
 <andy@kernel.org>
Subject: Re: [PATCH v1 1/3] math.h: Add mult_fract() that takes struct
 __Txx_fract as argument
Message-ID: <20261118105626.000074e8@kernel.org>
In-Reply-To: <av1zrjobIT3KRfiP@ashevche-desk.local>
References: <20261117091638.1463621-1-andriy.shevchenko@linux.intel.com>
	<20261117091638.1463621-2-andriy.shevchenko@linux.intel.com>
	<20261118092229.000025fb@kernel.org>
	<av1zrjobIT3KRfiP@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
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

On Wed, 18 Nov 2026 11:45:18 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Nov 18, 2026 at 09:22:29AM +0100, Joshua Crofts wrote:
> > On Tue, 17 Nov 2026 10:14:40 +0100
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >   
> > > Add mult_fract() that takes struct __Txx_fract as argument and
> > > calls do_div() instead of plain divisions.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >  include/linux/math.h | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/include/linux/math.h b/include/linux/math.h
> > > index 1e8fb3efbc8c..ded258df50df 100644
> > > --- a/include/linux/math.h
> > > +++ b/include/linux/math.h
> > > @@ -128,6 +128,10 @@ __STRUCT_FRACT(u32)
> > >  	q * n_ + r * n_ / d_;	\
> > >  })
> > >  
> > > +/* Same as above but for a struct __Txx_fract fraction */
> > > +#define mult_fract(x, f) 				\
> > > +	mult_frac(x, (f)->numerator, (f)->denominator)
> > > +
> > >  #define sector_div(a, b) do_div(a, b)  
> > 
> > Sashiko has some remarks.  
> 
> Strange that I have got no email on that...

Yeah, for IIO Sashiko doesn't send emails, only if a patch series touches
any dt-bindings stuff (new drivers etc.).

-- 
Kind regards,
Joshua Crofts
