Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12791DE3B5;
	Sat,  7 Feb 2026 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770483759; cv=none; b=GzJUyRWgYSn7vGlWZ3GhgfPid6YzF5KqzKbIG8Ifm/DzJpXo6QL8mkx4/ak93ve2094qECDja5Otp94ChnC8sdCUws4uWfv+/ThjrfPLIP7653Fg6Cs5Vvbi47Rs6+QEjMTxCCFO9Tmm9NAxWUeSsSts6EDcHeRj7zMxMbIgMao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770483759; c=relaxed/simple;
	bh=s40Hrrm4dNIEKwWoQ4agNmRWxze8FatK53eM+4F3lVo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dh09OiSOdEqSFreisSMSbiRfuoQHKYoQ11rhwRzzM3AHeM1FssVUhNTbeEWZHQcMmm+sBEcPLPxC9LYoOskwWJN4Yf2XJtauwQX2VeQzxu6r0L7BavLjEhM7CftbSuQ746cEPKsBH26D1+BDMAH03rf2XWOI/krPSk1Bg7MskG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxjUxY5c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxjUxY5c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A28CC116D0;
	Sat,  7 Feb 2026 17:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770483758;
	bh=s40Hrrm4dNIEKwWoQ4agNmRWxze8FatK53eM+4F3lVo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nxjUxY5c9A25VX63WElHWm3+MW2nfwy/qUm9YXGHDYbfWd+RovP1PoJuMpvCooGDj
	 m8QmgdyBTk+Q9xjNJUhrf4IppV7FShHIVt0Agf/Hq3hetatKoUPdLhOYRod0sfy7+8
	 UAq9ooUkmguvL7Ttzi07OwlJpP21KNBFFDqADljj/6S2JXpbuwcqKnK4TNaDdRICHI
	 pCxr4F1SWrzz/g8EjQbFHYSUkD/zjrUS9Y10Lj+4KriUSpnf+A7VoJpofL6tKrwima
	 EJ39TJfInyk6yn2hSIwqHAbYOjL0BjmMoVcAaWrMI5qvkuL8tjKnlJKy5XROtOs3xx
	 VTOcD6kVw7Kcw==
Date: Sat, 7 Feb 2026 17:02:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
 rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v6 2/8] iio: core: add fixed point parsing with 64-bit
 parts
Message-ID: <20260207170228.2f2bfb35@jic23-huawei>
In-Reply-To: <aYMgzMVcv_QALJtF@smile.fi.intel.com>
References: <20260130-adf41513-iio-driver-v6-0-cf46239026bc@analog.com>
	<20260130-adf41513-iio-driver-v6-2-cf46239026bc@analog.com>
	<aYKkv3dq9Vkm3s_3@smile.fi.intel.com>
	<7tiv33i65unu5ypk7puj3buzybykyhv2qbwp54bhcem5t4rawq@dpfedqmmxbhx>
	<aYMYJppigidPeLH4@smile.fi.intel.com>
	<hrhgmum6zdww7etc6ztchivfqecaaqeeul2bbagzyongkxpaeh@q7x4popwel6d>
	<aYMgzMVcv_QALJtF@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Feb 2026 12:34:52 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Feb 04, 2026 at 10:28:05AM +0000, Rodrigo Alencar wrote:
> > On 26/02/04 11:57AM, Andy Shevchenko wrote:  
> > > On Wed, Feb 04, 2026 at 09:42:55AM +0000, Rodrigo Alencar wrote:  
> > > > On 26/02/04 03:45AM, Andy Shevchenko wrote:  
> > > > > On Fri, Jan 30, 2026 at 10:06:43AM +0000, Rodrigo Alencar via B4 Relay wrote:  
> 
> ...
> 
> > > > > There is a development in the parse_integer in the lib/. I reviewed that series
> > > > > and hopefully it will go in. With that done, we better reuse the lib/ function.
> > > > > 
> > > > > https://lore.kernel.org/linux-hardening/20260202115451.290173-1-dmantipov@yandex.ru/  
> > > > 
> > > > In this patch, I see that it updates the overflow check, but I am not
> > > > seeing that function being exposed to other kernel modules.  
> > > 
> > > Can the IIO be compiled as a module? If so, then we would need to export that
> > > function. (Note, we may export only for the exact module(s) in question, so
> > > nobody else will be able to use it. See EXPORT_SYMBOL_FOR_MODULES() macro.)  
> > 
> > Yes, one can have an industrialio.ko.
> > Then, would it be fine to use:
> > 
> > EXPORT_SYMBOL_FOR_MODULES(_parse_integer_limit, "industrialio");
> > 
> > in lib/kstrtox.c; and:
> > 
> > #include "../../lib/kstrtox.h"
> > 
> > in drivers/iio/industrialio-core.c
> > 
> > that does not look pretty.  
> 
> Yeah, but I think it's fine as long as we have an associated FIXME.
> In any case Jonathan is the one who makes a decision here.

You've lost me. Why do we need to restrict this function to use
by specific modules?  We normally only bother with that dance when
there is a big footgun or something deep in core kernel code where
we want to be very careful who uses it.

To me it doesn't seem appropriate here.

Jonathan



> 

