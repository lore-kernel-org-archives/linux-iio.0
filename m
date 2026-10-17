Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B483768EA;
	Sat, 17 Oct 2026 20:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792268330; cv=none; b=hhfYy7od2fCo8U4KA7GlkwbyKXRWjmq/x/FD6f+NTjq03/QkH4mMQI4OvMMsi7pPxu0UnKORoZIxOIiIl7RnWPuWIkTW1I9fMERgXSxbs01463p+Z3N8Nh2W3P4t3Yv7H7CaOnhed6rJlhsYyL8/ASF57yDTQcnb5irkB6MFiUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792268330; c=relaxed/simple;
	bh=J4of0SVXjpfiFbNWy1jqatlgewJSzeYdwghUfogZjTM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F7fD+P6cgwrjMDicfP31rYTQ9n7M0wN3oVmnPDPbEnSbilfcGvHJAeux0LLyfdjaB4Hh7mNa1ii7yGvLjHkGfyd6tRez/+/2SFuT/TLjgbmNDGMf+ue0vhwfRZHqf+Dp+fEiRX9ax3mUddivtXOvdFED7MXamsuLAxs3m7vweaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4vEkw00; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4vEkw00"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A281F000C4;
	Sat, 17 Oct 2026 20:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792268328;
	bh=sbe4+v17yEd5O0OdsAgh6j+PtDWNPdo2E7EGP1qGmCo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=i4vEkw00EsfD6O2O5v98/bv9yBSLylq8wvu2ghGG+ubPyWauQFdbDZCEjKb9A9PpL
	 DLdmQzgeYrbyDS692885puYdlcxXfFHv7+oInkBo1hKpYhyKpP1X1Sps/UgHpQhqVS
	 mIuMxkjsU5REoiuTi3KUxrL/9Vf/TjSqMnyxgGG/XCo5FIdSn216//aGpYZy5ayeWV
	 Ex0nkZ02rxLlotsj5lBS9xDT2buXRtff8RvSf22ApclgIAqBDBaKKabGctPwIA8Hj/
	 gbE2p2IF6OqqkHD0YNBgwYgnCj1CQ0hqZNM1f+mEIqb0xCjZ98BRK1Dwhk9AMYj4Ty
	 BZ1pYhUF76j3A==
Date: Sat, 17 Oct 2026 21:18:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Liu Yufei <lyf98405@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: proximity: Add Vishay VCNL36829
Message-ID: <20261017211843.18bd5d87@jic23-hlaptop>
In-Reply-To: <20261017210502.129d1709@jic23-hlaptop>
References: <20261003050453.413700-1-lyf98405@gmail.com>
	<20261003050453.413700-2-lyf98405@gmail.com>
	<20261017210502.129d1709@jic23-hlaptop>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Oct 2026 21:05:02 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat,  3 Oct 2026 13:04:52 +0800
> Liu Yufei <lyf98405@gmail.com> wrote:
> 
> > From: Liu Yufei <lyf98405@gmail.com>
> > 
> > Add devicetree binding for the Vishay VCNL36829 proximity sensor.
> > 
> > The VCNL36829 is a proximity sensor with an integrated VCSEL emitter
> > in a small package. It is controlled over I2C and has an interrupt
> > output. It is powered by two supplies, vdd and vddio.  
> 
> I wondered if we should just combine this with the vcml3020 binding
> which is fairly similar but with the integrated vcsel rather than
> an led, it would get just complicated enough that I guess for two such
> short bindings keeping them separate is easier.
> > 
> > Signed-off-by: Liu Yufei <lyf98405@gmail.com>  
> 
> What changed enough to justify not picking up Krzysztof's tag?
> https://lore.kernel.org/all/20261004-outgoing-outrageous-fulmar-2ba7f4@quoll/
> Looks like nothing.  Please be careful around that in future.  If everything
> else is fine I might just assume it is fine to put that tag back

Oops. Illustrates my point about confused threads nicely :(
I thought I was replying to v3!  Ignore this gibberish.

J
> 
> Thanks,
> 
> Jonathan
> 
> 
> 

