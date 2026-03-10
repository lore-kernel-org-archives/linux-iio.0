Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7231925BC
	for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773139832; cv=none; b=eJZd1FOSZfu8a2qN1Bywbu78X8ozSPfwsuQnZo+b6+4eL7Jy8qiInSG4WVYTuoiBDrRTiKU7zF7exow5TSywF80Xu0CG0OegpNL5gl4W5veoL7+LEwvKoSfcVTfyE43Sz153AW8Q0Ny+/m8otE5rR/54ZoGFl5o0ZVOXxBvJ2pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773139832; c=relaxed/simple;
	bh=0VoBZs7c1VaNHYX4X9G0oFihfaAjTwptBwauSkvbB9s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VJSDkVw0ANsU6P5mNXlNQrgw1rJ30yO/btyafo5JW3XC4gJCeh/fhb0FF0ChDW6Ygs8XlfQJTU1lPdGee8Ihfj6DU/VXxoiquMXkCsd6fnOgeDHmF0X+jCwmqN2KokErUjyWJXwRGbPyvctjgjhdNm9cp3qrQ9NMMGawymscoCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M45i5+BT; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M45i5+BT"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso27302255e9.3
        for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 03:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773139829; x=1773744629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jkdkaOrB5sbIX+V1ogcejtKhZcBX+Pg6pb5seJw+GI=;
        b=M45i5+BTGzrTbsIzvfIaG8lYKev80YBP1s4aqtRU4o941SMmqwNOZIFIGXqi+K3OEu
         Ulgzn2e/sUQbQ6dPGaNd/YWPUnabYg7KuN8dMlXGcJQnyozYC9fZrhMaGSdlJN8/P3/1
         3pmnKG53NJlfeQBUBDh6aEdyUbO9HNJ/S51cUVtQ2Ccu9ttVvHYP+8A+KYfuD+KtAZxh
         gd3Lq8gg3XBh7XM7ownujYy3FSfMGDvm51Xt4No5HVCKtrup+5Rx2/FOIXKCRmdC4Y8u
         tOhsA1xYfhFY/RGICmnRc5RH9bBaYBruknRhd6J7OH+gvFcghex/CiFrU3TMB4v6f1CF
         k2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773139829; x=1773744629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4jkdkaOrB5sbIX+V1ogcejtKhZcBX+Pg6pb5seJw+GI=;
        b=Ndwtue7fQLpPehN9Ub7PFRssYUWsqK3rw5Otm21sBKgbx0RCac31NNhkLvl+/y6RK0
         4MAidYbbHMLWP41axuZSgbZQKmF0CePOeYPsP6F4oUl2x4gMaRDag+aTi8DwzJwGLpWQ
         Fj0m4eH5UJxx4z0lr/21OWP1uNlt04XPkVopudvJM3jXY0Nx99S4em60wF2ihV+TIndZ
         jUhi5ef7DnpZZj2+/9R8ekMkxuODP2m9DJNYheTZj8IHwzuP44MTI9f6IHhVGkl3Rs8d
         vNq1+atBIFPvAc7LS/uMkRYj/gktK5o4uLBAHrk7ilMtVYArO/j3Y6esv4p/mox+MMmC
         ZIPA==
X-Forwarded-Encrypted: i=1; AJvYcCW4sAmnmnYO5fFC0gBuYay1j4h9pDMe5fIK6lmbdclhsv4OUFwV/yhsTbcRezL2eYBHkOdJFOxTmMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfkXb7KdOouOSr6Kmhje6am6rP99cDzcHUHnunTXEO8ipjrs5h
	3edJuGWVFssBz3JQN+q8tOg749AnhxT/WzdU2q7Axfg9050YII/bOglB
X-Gm-Gg: ATEYQzzSQSuBMV7xZw/5o31dzL3QGkN6S48WTvG6TRkWJA6H6Xm5Kuj9mVz4V80R68t
	c0S/HXiU+m8GgNjJaIEw6+r+e1eTZCjc0km0fTTU5XJyU6VFYZWFXI50J2lgEVfNmOadEnsP5AO
	0XiRODAfZpyuKB8EF+glhbHil2oCB69zfEYuqnY56vBtp6ib+rUywKZL2NVjkskfosxwGXTeWAs
	D22mMpPvDOrmWPX/gbKGR7wBMhLA/SFRm6oABzO8paOAFuTpHq9N+zfzoQFBl3+DesFIPjOvETG
	wYkfaBGsVYjKRndAAIjQxdyoaC0CPAYLhQCve1849bZLa9j6CZ6yMhvRBysp20v52t2meDq1qqx
	OqD9lxdCdjfq5J8vaJh5YPdnzVdy5mfhA1Q0Nlt65QJSLkzIbZPjYgFPSLFQ3q1BVdLusAmq+kJ
	+dN3hwqL/fdl6EOswsqI/cBWJ5hxwO/J5VBMY6uwCHlHsmPLtrnRG/2l9P5VgwFHSm
X-Received: by 2002:a05:600c:a00c:b0:485:3983:aba2 with SMTP id 5b1f17b1804b1-4853983ac6dmr130510055e9.23.1773139829169;
        Tue, 10 Mar 2026 03:50:29 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541acea11sm71843325e9.7.2026.03.10.03.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 03:50:28 -0700 (PDT)
Date: Tue, 10 Mar 2026 10:50:27 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>,
 rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v8 02/10] lib: kstrtox: add kstrntoull() helper
Message-ID: <20260310105027.08b93187@pumpkin>
In-Reply-To: <zhjkurpwbuvirh3k4a4c3lfeu5semu4rjszvej4hnx7scjyk2q@v4r7oqexwsjl>
References: <20260303-adf41513-iio-driver-v8-0-8dd2417cc465@analog.com>
	<20260303-adf41513-iio-driver-v8-2-8dd2417cc465@analog.com>
	<20260304101655.620df7ee@pumpkin>
	<6et7t3o6fjiinpkvpsmoxjhp6edn23dgclbulaxg5paccdotgp@amtf33da5dhf>
	<zhjkurpwbuvirh3k4a4c3lfeu5semu4rjszvej4hnx7scjyk2q@v4r7oqexwsjl>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Mar 2026 09:26:11 +0000
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 26/03/04 11:41AM, Rodrigo Alencar wrote:
> > On 26/03/04 10:16AM, David Laight wrote:  
> > > On Tue, 03 Mar 2026 13:27:07 +0000
> > > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> > >   
> > > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > > 
> > > > Add kstrntoull() function, which converts a string to an ULL with a max
> > > > character limit. The function is an alternative integer parsing function
> > > > that does not require a null-terminated string. It becomes a better option
> > > > over simple_strtoull() or kstrtoull() when parsing integers from a buffer
> > > > with custom delimiters without having to create temporary copies.
> > > > The function is consumed inside the implementation _kstrtoull(),
> > > > promoting reuse.  
> > > 
> > > If you've got custom delimiters use a function that returns a pointer
> > > to the character that terminated the conversion.
> > > They save you having to find the delimiter as well as taking a copy.  
> > 
> > understood, how about this prototype then:
> > 
> > const char __must_check *kstrntoull(const char *s, unsigned int base,
> > 				    unsigned long long *res, size_t max_chars); 
> > 
> > to be used like:
> > 
> > 	end = kstrntoull(s, base, &res, INT_MAX);
> > 	if (IS_ERR(end)) {
> > 		/* return or handle error */
> > 		return PTR_ERR(end);
> > 	}  
> 
> Hi David,
> 
> Do you have any other feedback? the function prototype can also be changed as
> follows:
> 
> int __must_check *kstrntoull(const char *s, const char **endp, unsigned int base,
> 			     unsigned long long *res, size_t max_chars);
> 
> so that a pointer to the terminated character is passes as a parameter.
> which one would be the preference?
> 

I really don't see why you need to add 'yet another' function for parsing
integers.
Having to pre-scan the string for a separator seems just wrong.
The userspace strtoul() family do everything quite nicely apart from
overflow/limit checking.
There are a few options for overflow:
- Ignore it, this used to be what posix/sus allowed for command lines.
- Saturate.
- Return a pointer to the digit that makes the value too big as the
  termination character - since the code will typically expect one
  of ",.:-" this will be a syntax error.

It might be worth adding a parameter for the maximum value.
Then you only need one real function for 32bit and 64bit values.
But you also really want the use the function return value for the
converted number (for all sorts of reasons).

	David


