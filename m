Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61E436A03A;
	Tue,  2 Jun 2026 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780404265; cv=none; b=vEQR8jn6J2aUw0WisPOb3NYY/3VmrMnxkZ2tVKG3ePqxBqubIFOhe468L9UN9IxPa7L4OXc9iAFQsGZPWMZIPYfygeD3igGPIHrn24//Fh8UOUXfCPTTrHlUDMrOyHqbi4L2YthD7+Y+IiiQHHmVw+gWpZvCSIk/3Ao1O2cCOD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780404265; c=relaxed/simple;
	bh=D+cJzdraqlta+Ea8WAVPG2rpnofPJgsTGtGH/ZxAG9U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VR7h+cvOMptvdyINU7coII3I3s9PeVhXJ4XiuR6RPQbYreYFbzCpLv54igOGyjo5eNWz+H7boDmmLIR3h2lH3vu1g54PfUUsFhTDMDxROThf+LyMyOOeISRaJEW9LwOK8ubQa8kjACvosIg5d2X3bcSv8fO/DkQB+adIbybu6mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfVjsNSP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfVjsNSP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DC41F00893;
	Tue,  2 Jun 2026 12:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780404264;
	bh=v+H21jGF5mrKmIGccRMbtsgNGf3kLnQiImQExd2h/nk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AfVjsNSPr5pilHSOA2OHvK/MaTBuWn8MQbFfDMQTH3ereri3zR63iCYReKm9s/yoz
	 sPcKYw9v2zIUsoZqfMzwiLafBBsyqE0e3S8MAnQe9+cuZNPhwcCfZmAS2tHhwYWCrn
	 nJo4cZUhuyCJluJmVxrh11BjjTqBAvlvYORmgygo6vrjPHQWoW8tRGHWwjsUg2o+St
	 nws0JT0+Th4tAr8Ub3+YMeKf350kbzvtTgU7DQ4Vo8q+e6UUcEkbsfsJrgRV+0newo
	 U+ERwjEe/6FSXLUXB1iW0Y0+UNmF1wGISPe2zLgZMWJIL8Pzn8HZfkPsT60kFyiPQD
	 MDJVfU0V1FTog==
Date: Tue, 2 Jun 2026 13:44:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 linux@analog.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad4080: fix AD4880 chip ID
Message-ID: <20260602134417.5fd78512@jic23-huawei>
In-Reply-To: <CALoEA-yz-kJGHXDC=Fwmi1C9P_EpEcimxt=9a94vv6eAHQ-TXg@mail.gmail.com>
References: <20260602084019.2564-1-antoniu.miclaus@analog.com>
	<CALoEA-yz-kJGHXDC=Fwmi1C9P_EpEcimxt=9a94vv6eAHQ-TXg@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jun 2026 11:01:24 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Tue, 2 Jun 2026 at 10:52, Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> >
> > The AD4880 chip ID was incorrectly set to 0x0750. According to the
> > datasheet, the product ID registers read 0x00 (PRODUCT_ID_H) and 0x59
> > (PRODUCT_ID_L), giving a combined chip ID of 0x0059. Fix the value to
> > match the actual hardware.
> >
> > Fixes: 35fc53e802bf ("iio: adc: ad4080: add support for AD4880 dual-channel ADC")
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---  
> 
> Sashiko failed to apply your patch, are you developing against
> an old tree?
Other way around. This is only in the iio tree and sashiko seems to 
use either mainline or next, I haven't figured out which.


> 
> Codewise LGTM.
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 

Applied but I dropped the fixes tag because it causes pain for me to have
references within my tree near merge windows and it will all be in the same
pull request anyway.  Note it had changed because I had to do some surgery
on the tree a few days ago.
