Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD9E25B08E;
	Mon, 31 Aug 2026 01:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788141363; cv=none; b=RZEnCEoft9Jw5oPqRxz9+SHWGlUEmGA0PnLyioyeTne4JRJPqctZEJAUU6akpMuysXsWrgDhPWpF39qSo2ue6FarllKgxLkylbLGvnuu9Gjv7DrevodrroEuR24BmO5EtmQGZMpc0f0SrfGVhMJPqtbp8bm7ujM/OMTGGs/eBqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788141363; c=relaxed/simple;
	bh=5oCtvhjiLCDgFPxNRXtmbEObahRGY7imzQ3jP0kf8sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ijtNTKLOGi183NrbmQ/Ewy+eyuK1e80+iNp2Dm20s0vyZ8D+gx8tWJL8FBN404AwLRZNKuqU84hb35XwTWLJbqwWA1Q527bw3nT4eHpc3bEAqYOYbcJjcZyXQBtEkm0N/wdSO34JFgg1UGblyfSVnPLDMdaJ8RK2naJeMpfRK8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdMwuCqq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdMwuCqq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5C81F000E9;
	Mon, 31 Aug 2026 01:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788141361;
	bh=hyqp9QN9fSv18RFAzbc+q3w72fkLkoZKcSxhRSYFTxg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YdMwuCqqwUisYtwUM5fF3XW2e4TtD4hkWV9wmKO11GpaUanKVaGDARcc9K6Ln3whx
	 6Lr82lRmy4nqX+0JYqus0stf91cTOH1r9rDIgL65ns9yRXnTEV8oWJ63w3tjMIAIM8
	 EAPuIUtfVh/RzNaMuCkx9z4EAA51mkG/e+cR0LdnF9e8vei3jR7b3JiOJQO/LkdqJN
	 xmHJVnqHTtFUAHnJNJ8oQiVhV7U76fxRrnTr+olOYw39zbHQ+gehNtK3oBBd12Y13h
	 ervhrfmdfGFogjwSEYNDLS05khQxm8UHWRZ3KYmZslXYlvWbrYzmN+WZ+e1ltJNsE4
	 6rwqezb768v3Q==
Date: Mon, 31 Aug 2026 02:55:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vladislav Leonov <vlad@zlab.su>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Joshua Crofts
 <joshua.crofts1@gmail.com>, Simon Glass <sjg@chromium.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Fix RV1106 SAR-ADC support
Message-ID: <20260831025557.6ee7c42e@jic23-huawei>
In-Reply-To: <20260823122039.20831-1-vlad@zlab.su>
References: <20260823122039.20831-1-vlad@zlab.su>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Aug 2026 15:20:31 +0300
Vladislav Leonov <vlad@zlab.su> wrote:

> This series fixes the support for the RV1106 SAR-ADC in the
> rockchip_saradc driver and its device tree bindings.

I debated how to apply this.  Technically patch 3 is a fix, 2 is an enabler
and 1 is also a fix, but one for something that we just effectively patched
out from running in patch 3.

So in the end I'm thinking take this the slow path for next cycle.  Shout
if anyone thinks this should go in during the -RCs and whether all 3
should do so or just patches 2 and 3 (leaving us without driver support for
now).

Applied to the testing branch of iio.git

Thanks,

Jonathan

> 
> Changes in v2:
> - Combined the driver patch and the dt-binding fix into a series, as
>   requested by Jonathan.
> - Introduced a new patch (2/3) to group single-entries into an enum list,
>   as suggested by Krzysztof.
> - Added missing Suggested-by tag to the patch 3/3
> - rockchip,rv1106-saradc compatible moved from the
>   single-entry to enum list in the patch 3/3
> 
> Vladislav Leonov (3):
>   iio: adc: rockchip_saradc: Add support for RV1106
>   dt-bindings: iio: adc: rockchip-saradc: Group single-entries into an
>     enum list
>   dt-bindings: iio: adc: rockchip-saradc: Fix RV1106 compatible
> 
>  .../bindings/iio/adc/rockchip-saradc.yaml      | 18 +++++++++---------
>  drivers/iio/adc/rockchip_saradc.c              | 16 ++++++++++++++++
>  2 files changed, 25 insertions(+), 9 deletions(-)
> 

