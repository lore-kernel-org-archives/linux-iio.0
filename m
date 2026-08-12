Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB5917C203;
	Wed, 12 Aug 2026 03:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786505966; cv=none; b=j+2KWtUOdLiP5WF5HqJzdl+zza+qb32/LCUaMPkjBxw6iBxnNRxhhHYea+3YGVv1LxB5umt2xL7zW54TM41sPPDWZ+9rxW8H3anOlaagAXMRtRRzRwKkn3q6YBzMTIOdjKsW/Y+eprtS4CNjVQaBOa3B3GHitkri8Moa4p2xkFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786505966; c=relaxed/simple;
	bh=4poK1r333hhp/ay8xbGh87Zr6AgRnka+0rnMMYhYsxY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JMqNQg1p4d1Pao4EC3zovNnF7r0Qwo5V23REjVVNLBjY48PeyKEPy1iV4Ur934KxTUBNbWDtqH1q2g1qkmny6vknqj3ct58ELca8XHs12lmrHlz3k/reYWd54YQLRzmIfhFck9g+og8jqJea8yTYy9+WyE5pi970QS7LgYFOWZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5VV+2CS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5VV+2CS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0213F1F000E9;
	Wed, 12 Aug 2026 03:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786505965;
	bh=LBOLoXUQjO04xGCabVrwxiLL6iVPjLVxn+FdeG6GYzY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=P5VV+2CSj4aYjzRj0ApcP57hnS19AaIb2ICtTRP7yspGv3Mqe1p09ROpuqr/S6AiE
	 AfVGFTzFaI4eKgl0cV8DrITT1sooH2j6ORriiIbANMUD5vw99JK7c4ygNBmSR9DQpA
	 6Mqf2vGAMiQnnZRYVn9GTTcRfxRn3zVEPSpfAsR/YoFO8eSz+XSc3lZ/NpwkNjBCIV
	 tkXAHaz6YGbVALZI0ymAd2FRJ02nxmCca/rBTGV4LHJ/SrweXHbW5gCtuyJaP0fXoY
	 iR0KmvxH1wRhLwDdzBIFPnCQKXiACq3Fapff+K5wp9sSwmPzrqtn3NDYlQiJB//E41
	 Fg0gigh6t/1NQ==
Date: Wed, 12 Aug 2026 04:39:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Tsz Shan Chan <tsz.chan.dev@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tsz Shan Chan <tchan@jacques.com.au>
Subject: Re: [PATCH 1/2] iio: light: vcnl4000: use correct channel array
 size
Message-ID: <20260812043914.4181b413@jic23-huawei>
In-Reply-To: <anrxEpjjlPVOnR2F@ashevche-desk.local>
References: <20260811-vcnl4000-v1-0-50e7fb657692@jacques.com.au>
	<20260811-vcnl4000-v1-1-50e7fb657692@jacques.com.au>
	<anrxEpjjlPVOnR2F@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 12:53:22 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Aug 11, 2026 at 05:07:24PM +1000, Tsz Shan Chan wrote:
> > Use ARRAY_SIZE(vcnl4040_channels) for num_channels to match .channels.  
> 
> I was under impression that I have seen this patch a few months ago.
> In any case sounds like a fix and hence needs a Fixes tag.
> 
They are both the same size == 2 I think.

So whilst nice to fix this I don't see it as needing a fixes tag
as such.  It would be helpful if the patch description called
out that the ARRAY_SIZE() of the wrong array happens to match the
one it should be.

Jonathan


