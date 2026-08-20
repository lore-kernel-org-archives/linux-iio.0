Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42310222580;
	Thu, 20 Aug 2026 00:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787187478; cv=none; b=boezAXzy0MveS0yqKpT2KWOIpNjwxoHzT5lysVt5d5T7wP8V6uftQH8pSomsdMRnjL8ZbWw/hg9OwBEBHUghlm4qEzkiveEwAS5HUhDC+emn77/OdOhWR4UpWPQlF6ABYeNP3dLbj8naWr2stGnZCKQD1XS2BQQcAFE1ysoi/2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787187478; c=relaxed/simple;
	bh=iTsBM+zhifhEVy/t0k8fQnDrJ8UkQPci75ZvDiDEHog=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQwOpwMP+K8RNXqP3eK9GHNPHQXN5hn5WYFpJl5/QNyxIPjccsHjLNnGehkUgmj4rlXLkvWyD59ttXIwn/X/8MtbVhdUYWbyjhLiyWR60atiBr/2Q+Uwt4fJJzc/k2E3EVoaaod3PkhM7ld0NZZa3NH0NTiWEro3Mp94BM/PyMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofqoOZxY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofqoOZxY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B5F1F000E9;
	Thu, 20 Aug 2026 00:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787187476;
	bh=kM+T5YFvyzkuB+A5pR6vF4uBLMNV4q+o0hL9s8uGv3Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ofqoOZxYl/yJsfKnHokgkeX/MUBBZ9ajy+sguL3jaYm57T/dsYfO/jueRn7X/FOq5
	 SrIkwOe41UVGfOptOdPxC/IQXsW0WoCNzRYD7FC+W7jj0hpUmFcNZkYeflEzoLGc8M
	 pVzSG5U7CedgtouGuc2Hfhnm5Bm5ds3wJ3IpMJk7UpbVLf9jtfLl4UEwP0qwe4KZqB
	 Q71ZsOSpyhcGtML7e9GnCubdoPNIdJmL/bblzeLRaL5CuQIX78x/Zb6MGtUbMxGOUZ
	 YLREmwHcQrkSnERdUHld+n2XFK4xv4Xw81u31BpfaKB6N4XFOepfHWZ9+WNNjoklMv
	 ckdSrAt1d2LFA==
Date: Thu, 20 Aug 2026 01:57:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <jananisunil.dev@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Janani Sunil
 <janani.sunil@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>, Linus
 Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: iio: adc: Add AD7768
Message-ID: <20260820015753.4faee677@jic23-huawei>
In-Reply-To: <9dd16bb5-7a30-4024-88a7-4a4bf47c35e8@gmail.com>
References: <20260709-ad7768-driver-v1-0-44e1194fd96a@analog.com>
	<20260709-ad7768-driver-v1-1-44e1194fd96a@analog.com>
	<36df7c4f-82ea-4ed5-a4f9-3a29c75dc99a@baylibre.com>
	<9dd16bb5-7a30-4024-88a7-4a4bf47c35e8@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jul 2026 16:00:26 +0200
Janani Sunil <jananisunil.dev@gmail.com> wrote:

> On 7/9/26 17:43, David Lechner wrote:
> > On 7/9/26 3:50 AM, Janani Sunil wrote:  
> >> Devicetree Bindings for AD7768-4 (4 channel) and AD7768 (8 channel)
> >> simultaneous sampling ADC
> >>
> >> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> >> ---
> >>   
> >>
> >> +
> >> +  adi,power-mode:
> >> +    $ref: /schemas/types.yaml#/definitions/string
> >> +    enum:
> >> +      - low
> >> +      - median
> >> +      - fast
> >> +    description:
> >> +      Power mode selection.  
> > Unless there are pins that control this, it seems like it should be
> > left up to the driver to decide how to set this.
> >
> > In this case, it looks like the power mode also influences sample rate
> > which is normally something controlled at runtime.  
> 
> Hi David,
> 
> The reason we'd like to retain power mode control is that certain ODRs 
> are supported across all three power modes (low/median/fast), and the 
> RMS noise and power consumption differ significantly between them at the 
> same ODR.
> 
> The higher the power mode, the better the noise performance, but power 
> consumption nearly doubles for every ~3 dB improvement in dynamic range. 
> Silently selecting one power mode in the driver would remove a 
> meaningful hardware tradeoff from the user.
> 
> We'd like to propose the following instead:
> - Remove adi,power-mode from the DT as suggested.
> - Expose power mode as a per-device sysfs attribute.
> - in_voltage<N>_sampling_frequency_available dynamically reflects only 
> the ODRs valid for the currently selected power mode.
> 
> This keeps the DT clean while still giving the user explicit control 
> over the noise versus power trade off. Would this approach be acceptable?
> 

The challenge here is simple: How does userspace know what a power mode
means?  Everyone wants low power and low noise and the trade of between
the two tends to be invisible.  If we add a control it also becomes
hard to do a best effort - give them something sensible - control based
on what they want. Users understand the ability to sample at different max
frequencies for example. There are ways to do this like always requiring
'auto' as an option for a power control but they are also rather nasty.

Whilst I see that it is reasonably complex to move from 'low / medium / high'
we need to try really hard to map that to something numeric and well defined.
I think it came up earlier in the discussion - there is a clearly stated
set of recommendations for a  mapping from fmod to power mode. I lost
track of whether we had reasons to not try and build an interface
around that.  Even though modulator frequency is a little obscure, if it
is consistently defined across manufacturers and parts and the trade offs
around how it is chosen are well understood that might be something that
would make a better ABI?

Jonathan




> Thanks,
> Jan
> 
> 
> 

