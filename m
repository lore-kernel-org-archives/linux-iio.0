Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F32036EAB9;
	Mon, 18 May 2026 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779119096; cv=none; b=Ez0vPYqOTUx0Au2JCd97BCdqHvJR1jTMLsCnJupwrNecmlnDKECGq9sOqZHhY4QAP8eIPmaO0Lv6cqRpXfACwcfujbRgR1HLnn7tgtsln5jiRX938F/oAubfxBhtN9mtYQyDFvMu59l4J6PKGcv3P54Cr7C3+8k5RdN6BnPKiRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779119096; c=relaxed/simple;
	bh=gTu+hAwJZKRLTtD+A+avEeHzQqC6EwtEYG0HiI1fp9A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mf0j7s2IXN6tE80hsO3ytb/JulPTC917+c6sPIx/WEgIbktFDWAVfmljZMxLN8KeTOgkO3CZByXWjcwlo38ubsgqhduIJ0Din4t5pjZ3zP+7wfKjWYPjdN3ZGlC/IcaqgWg8h72qjWCBgqNqRlJ6NRSGY3moIO+/81o3qadBCAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1gim1We; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1gim1We"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE63C2BCB7;
	Mon, 18 May 2026 15:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779119096;
	bh=gTu+hAwJZKRLTtD+A+avEeHzQqC6EwtEYG0HiI1fp9A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X1gim1Wewd9sNHDtgFPPToYX5SKVHGz0nzoOWrfIGr6ZyMJ10PN2Egti7EXrVR8Wa
	 mId0oBVge4I3rGeM8hXIMJQwNXziR9yKy77esHXNPB1HDc6PMFrk0dmWipBmSgSNZ1
	 apMywtgeKXmL1+utaE7kCj3kj61ONlYEJug5ylrTPQhp/NWNJVuWfRrKBX+LAI51B1
	 f6n6mBxlo7Z8oZC/sVsX/1oI0iUfiOrsmzniMDPQUfjWBJuMEoao+ZtqquSXLBF/oW
	 C7CN9pWLhdBNESKp7w/AjQ5KT576gFS/Jzhzn/f6wn6gjr1s7yoHPOU3gU8baW2CSo
	 zK+IUq9VT36nQ==
Date: Mon, 18 May 2026 16:44:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Jyoti Bhayana
 <jbhayana@google.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Benson Leung
 <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, chrome-platform@lists.linux.dev
Subject: Re: [PATCH 0/8] iio: timestamp declaration cleanup
Message-ID: <20260518164444.7fb5f616@jic23-huawei>
In-Reply-To: <41c0317d-2ce8-412c-818a-4a84201fce29@baylibre.com>
References: <20260517-iio-timestamp-cleanup-v1-0-61fb908c11c7@baylibre.com>
	<agq7PPw0qupI_8Dh@ashevche-desk.local>
	<agq8Q1wpzIw4XhNQ@ashevche-desk.local>
	<41c0317d-2ce8-412c-818a-4a84201fce29@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 09:34:48 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 5/18/26 2:14 AM, Andy Shevchenko wrote:
> > On Mon, May 18, 2026 at 10:09:48AM +0300, Andy Shevchenko wrote:  
> >> On Sun, May 17, 2026 at 01:17:17PM -0500, David Lechner wrote:  
> >>> While looking around the code, I noticed that there are a lot of places
> >>> were we are manually filling all of the fields of an IIO timestamp.
> >>>
> >>> This is error-prone (as seen in the first patch) and more verbose than
> >>> it needs to be.
> >>>
> >>> I went with the approach of using the existing IIO_CHAN_SOFT_TIMESTAMP()
> >>> macro for doing a struct assignment. This does require a cast, which  
> >>
> >> No, it's *not* a cast. It's a compound literal. And instead of doing this in
> >> every driver, add it to the macro (in a separate patch). Oh, let me just cook
> >> it for you (I added that to several cases in the past).  
> > 
> > 20260518071349.469748-1-andriy.shevchenko@linux.intel.com  
> 
> Nice, thanks. I agree this will be the cleanest solution.
With that the series looks good to me.

J
> 
> >   
> >>> makes it a bit more verbose, but we were already doing that in to
> >>> drivers, so I went with it anyway.  
> >>  
> >>> If we want to consider alternatives, we could make a iio helper function
> >>> or macro like the first and second patches did.  
> >   
> 

