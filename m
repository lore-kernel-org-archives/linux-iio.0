Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795299799;
	b=gmBAKG0iAf4e6upXj33LObAgIhDe73xDqQo2btzWBJD0FYdV0L57QATMM9u2jg9lc7Mr
	 s3iasszhPbeiJQYry1Ls7JjZCZQaWfy0D1z53SdBpmTX4cp6bEvqHAQxWyw7XiX8aBcPv
	 bkCmh3KprkSOrRkkGQaRwPEC6GhCjKJcXHCmPuA8Dh37frg3ZTr5whjDVQdZvbqDxNOHM
	 oHsx1eOoJbu5IGeb32EQIr56VnxLdr99lCuwk1TTDf7SmSgnt8Wt1SuFmGA30e/wgLbrY
	 hTeoiD2g8KLcZ1wUCy+9Mk74fM0Sh0b0Tr9e8nTeUUTWMoTUt7c1yhH1O74SqeSHCmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795299799;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=69N/ochuiuw46uiyi/7z1V5zkgQx2u6He/iAWbfxXeg=;
	b=bRjZgwCXmJk91XYKLy9bxDqiJtBnEN8lVmtQzRztkjcAF1HoRk5qK0UBwR7+C6munWgz
	 nqk5KqKQNm7w7nqiVvpxrYD2EMuR/7BhQnDUBPr5LggRvRzVw5zS697twa6XhS10CJP6P
	 szDMgI3mrL8ZUhll4uU8Woq0fsI+fXNJZpOv4lYrc4aKOobLov8KvFdbJdk4MVSi/xmDL
	 o3az9yJIe0lpzC3IdJBiJYBlIYO+hlvOPOhO7+jwZAZ2VcJWbdQIE46ODQ5oNb18YODjd
	 r8VHk2tMLcqJJ+tyb7mxA5psOnDrC8h//MZwt4SRJK8ADTH+jqomNacK+bR7sv+091A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KLXeY4UM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE43606A320;
	Sat, 21 Nov 2026 22:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KLXeY4UM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36C51F000CA;
	Sat, 21 Nov 2026 22:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795299798;
	bh=69N/ochuiuw46uiyi/7z1V5zkgQx2u6He/iAWbfxXeg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KLXeY4UMc5Bgz+0NwsamP3si7OHrpzWPdzJ4bQ/TE3AeXNenLy4K/XqvQy3var/CS
	 nTJSp1Bb2TnNHoTtnijx1niLei2I1WiWYSbrk5ye1ReojYdCYvVyxsRYdmeo3jtZGc
	 8ZWPQiRizCJ0KmIiSgk6koJbmsvk1qlMaVijBMy+Wsjs988aQe1d3/p6S/B6UJ7Rvr
	 ch/3gU8NYCzvQvaFFTIZLvT5zaHjpiw0jwlS2VW24kj+KPL/CwdcKW/xcu822ILCyB
	 /1+fE6xFqrd7uL6p6m1JF5f18k9ro/XLXJHUCZwskztYOYoOMeg3QRaXYCrunUyO/K
	 CE6RrMvsfjyjg==
Date: Sat, 21 Nov 2026 22:23:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <crofts@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Cristian Ciocaltea
 <cristian.ciocaltea@collabora.com>, linux@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Esteban Blanc <eblanc@baylibre.com>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 0/3] iio: adc: Provide mult_fract() and make use of
 it
Message-ID: <20261121222313.6352e414@jic23-hlaptop>
In-Reply-To: <7d50b14d-2df8-4616-ac66-d6dbb1d24061@kernel.org>
References: <20261119192408.1724611-1-andriy.shevchenko@linux.intel.com>
	<7d50b14d-2df8-4616-ac66-d6dbb1d24061@kernel.org>
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

On Fri, 20 Nov 2026 11:28:35 +0100
Joshua Crofts <crofts@kernel.org> wrote:

> On 19/11/2026 20:19, Andy Shevchenko wrote:
> > In a couple of IIO ADC driver the suggested new helper mult_fract()
> > may be used. So, provide it and update the straightforward users.
> > 
> > The helper has potential treewide, hence it's provided directly in math.h.
> > 
> > In v2:
> > - updated commit message in patch 1 (Sashiko, c/o Joshua)
> > - used local variable to avoid double evaluation (Sashiko, c/o Joshua)
> > - collected tags (Marcelo)
> > 
> > v1: <20261117091638.1463621-1-andriy.shevchenko@linux.intel.com>
> > 
> > Andy Shevchenko (3):
> >   math.h: Add mult_fract() that takes struct __Txx_fract as argument
> >   iio: adc: ad4030: Switch to use mult_fract() helper
> >   iio: adc: ltc2378: Switch to use mult_fract() helper
> > 
> >  drivers/iio/adc/ad4030.c  | 13 ++++++-------
> >  drivers/iio/adc/ltc2378.c |  4 +++-
> >  include/linux/math.h      |  7 +++++++
> >  3 files changed, 16 insertions(+), 8 deletions(-)
> >   
> 
> Fine now.
> 
> Reviewed-by: Joshua Crofts <crofts@kernel.org>
> 
I briefly wondered if we should wait for some tags related to math.h
but then I couldn't figure out who would be paying attention to that other
than Andy.  So I guess we are fine without. 

Applied to the testing branch of iio.git.

Thanks,

Jonathan


