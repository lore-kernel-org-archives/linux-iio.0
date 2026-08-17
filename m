Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996C63DDAFB;
	Fri, 11 Sep 2026 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789153419; cv=none; b=CRRv+HYhHwoSxkI+8bxu2I++zN8La0fbyOH3Nm5QDKgNQrIbNGBwhgfx+Z88VtvRXPM4PMpNTIppMg/AlBK5JnXsjl+MyyLKVPwgI9kFtAg2T9KjL2aDHlndmIVnUnVbKnhdp443iGVe6+4M1TmH8jYjZJRK/uGbmgxCsCqjZBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789153419; c=relaxed/simple;
	bh=6YExB0jyTmBGweY+UKRM07k4sA4dJM2DsBRFReUoZe8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UahQtjJe8BpZxZIOE8za8MqOQAMeqBf4jCvcu4/jd684GqcwcKnD3Gey940XNitYzKAgVJ8u78qUCQQ7X+FrpOKkljbvzqQqdp72f+vIPeTCvxAHdgXjfbTdHYi9KNFdDMVZg+K6q/fnaA3Dx7z46rdfhY3/9mCTEufpl2ZzHKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhiWy4+b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhiWy4+b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BF11F000FF;
	Fri, 11 Sep 2026 19:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789153418;
	bh=F3RjUg6BuSldJfwG8e3mfWUs8y6IOwurHBpLUyrxgfw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HhiWy4+bfojfapuquN5SgTuvPtAOd0+bsMlhAWSvDObNmX9/JU6gZWxxPrcniPW0k
	 OKWlWnGhUj+alukSXvQT8FChRDeYR3T+nASX8GQu8Rq+CL6mo+2j2jms3tTnTuBRS5
	 wkLMDyddEJeHhZziWs52lxpMQZLUG3aom6uAKm+Y/ahdBsZ7gRRmW+Z0/BU1ZDvu7n
	 4W66RnhMkv3gsKlQsJE0+lS/Tn/ehEe+KDbOpuiI1rU7Hkmq1LjvritPA2NVKiyHOv
	 yjuWdBT2GSbEOjblvq00fYyzJP0u3hJj59G/IhkrvugRswt6z2eyomMBXUmMwxJh+I
	 I1vYzws2zrm+w==
Date: Mon, 17 Aug 2026 02:15:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Matti Vaittinen
 <matti.vaittinen@linux.dev>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, Mehdi Djait
 <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>, Topi
 =?UTF-8?B?U29ua2Fqw6Rydmk=?= <sonkajarvi@hotmail.com>
Subject: Re: [PATCH 07/12] iio: pressure: rohm-bm1390: Fix AVE_NUM
 initialization
Message-ID: <20260817021549.29522111@jic23-huawei>
In-Reply-To: <anr0jtvYorFKaEXY@ashevche-desk.local>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
	<7784e12793187a75dc10b0e84471f0cefe4d28b9.1786347811.git.mazziesaccount@gmail.com>
	<anovRGxtsyJZ8cO9@ashevche-desk.local>
	<247b0e35-f49e-4bec-abd4-4a2c3dd49a2d@gmail.com>
	<anr0jtvYorFKaEXY@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 13:08:14 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Aug 11, 2026 at 12:05:47PM +0300, Matti Vaittinen wrote:
> > On 10/08/2026 23:06, Andy Shevchenko wrote:  
> > > On Mon, Aug 10, 2026 at 10:53:07AM +0300, Matti Vaittinen wrote:  
> 
> ...
> 
> > > > Use FIELD_PREP() to shift the intended AVE_NUM value to correct field.  
> > > 
> > > Can it be FIELD_PREP_CONST()?  
> > 
> > Can you please elaborate why it should in this case?  
> 
> I'm not sure why it's not obvious, but the parameters are constants, why would
> we need an additional check or even checks?
> 
Hmm.  I went and had a look as this macro turns up a fair bit.
I'm fairly sure in the case of a pair of compile time constants
FIELD_PREP() both performs additional checks at compile time and
probably collapses to a constant.
The docs for FIELD_PREP_CONST() observe it is for when
you need it to be a constant rather than when it might be
(even if you know it is)

So I think it's not necessarily appropriate here.



