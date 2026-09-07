Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D8C35C693;
	Mon,  7 Sep 2026 22:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788818713; cv=none; b=DOZRJa6K0FZ4qxaFhCR5JO9J/alzJnv2PcvhJdcjAjkcCb8C9hLmYGQEyzWd6V02kameigeo3U5g50CbB0S1/Lnkx/DE16RXsqLO6o376wwAuwqueve3iYW1J0aprAXWryaVjOZiPQcHqM7kOS+l9FTXJ+edZWwGiwH9+2O3aq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788818713; c=relaxed/simple;
	bh=HSVHMNiebtUlr8duaQtZJpGHybr8L3ocRdK/2rQaS0M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mY5/8pELp0XHkERfzi8DD4I+B6QdECaugCsk/F9LZgxOt5odV8s9Gyoag0gfyuQwaC3s34Zbq3INTjn0N2LeZBB9IKgIgIXS9Q3x4lPsuCXAR9XsQXdUrNn6JRLdqz17xjqOAErqtLtdF3oGrgKxV5gsi1decDwVpgZ7tVOg2Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CF5D9on2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CF5D9on2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180561F00A3A;
	Mon,  7 Sep 2026 22:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788818712;
	bh=NbEiT9jkipQvcDxldyYNY6XH49wcDR72T8buIXfrPpU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CF5D9on2JSVwP4TgeCAzZW971EBA2/YsYl6Uxt18yZ3WxW6nUF9zc9Qs98zDmb107
	 Gn2rba7r5uwDxILkDqVDFsC2RYO1XTgNPGy7WlZdWj7YwTDsScdkbVgAIVQYB3pajm
	 NkJrZZrpvSwQfrwS/wRrAokn282sROBWyKJu+iI5iVICFLYEZrdJcPnQWnqID1ks63
	 EAKUvN/8bvmj8gAB9RyAXsIXIXpGjJaznCj1FWXsucqvUKBfencTnFtKgosyd3r7p5
	 auF6DtxZ0iXgyzr2y2KWs74XQlQb3u6oCiglvR1Al9cXYvYFwr4Jk0RgPMmY8Zzh7x
	 YWzT1K4HU/I9w==
Date: Mon, 7 Sep 2026 23:05:05 +0100
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
Message-ID: <20260907230505.277f1a6d@jic23-huawei>
In-Reply-To: <q2t53ly3vl73kmu3ehvntnj75pxl2smntctcuxzjuaguihqwju@adzts2ezpg5x>
References: <20260729-ad9910-iio-driver-v10-0-aa1f6167729e@analog.com>
	<20260802010959.25f9f4df@jic23-huawei>
	<20260802015846.2be354ec@jic23-huawei>
	<q2t53ly3vl73kmu3ehvntnj75pxl2smntctcuxzjuaguihqwju@adzts2ezpg5x>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Aug 2026 11:56:26 +0100
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 02/08/26 01:58, Jonathan Cameron wrote:
> > On Sun, 2 Aug 2026 01:09:59 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >   
> > > On Wed, 29 Jul 2026 09:25:27 +0100
> > > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> > >   
> > > > This patch series adds support for the Analog Devices AD9910 DDS.
> > > >     
> > > Series applied with that small Kconfig help tweak and a bit of fuzz
> > > around the new channel type due to the flow sensor I merged earlier today.  
> 
> Thanks! Let me know if you need a v11, I suppose We are going to wait on the
> mul_u64_add_u64_div_u64() fix anyways.
> 
> > And dropped again :( See patch 11 reply.  
> 

Picked up on top of an immutable  branch with the necessary x86
fixup. ib-iio-x86-asm-fix-7.3

So this is now on the testing branch of iio.git

Thanks,

Jonathan


