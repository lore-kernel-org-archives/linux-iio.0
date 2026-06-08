Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8BB36EAB1;
	Mon,  8 Jun 2026 17:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780941194; cv=none; b=XNoQGzkidc0TAnOaUUjEFL5ZAFaJrgjoO0ja4L5QBtkIeGFQSPeA0Zlog6rSfWWqtD95uOhw4RNNHCrlgZQ0NMrXmJIF+hGyghmXFw8ncv2G74y0PYA0gw938EXxudF2Zs8GxXXv0+QuG3hbdiXY+WHXhnjTunD2dXti2mN0OVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780941194; c=relaxed/simple;
	bh=qkwwkcO6D+ZFuK9gkY8KxQNvnZm7YrKg9Wu3aVMHRXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XOlku07AD1X/PIT7Sh++fb/JSLrO0HzzUmVquV/tvcywPeZluyyWr3WhK0gTZsGGyM8kSdUivTW3xAQ4/hH1gWd5/IMVxdkuNU6/swEf2LZ6GN6wFv1+GKGSmL6C6f3QkZ1cC5GZexsVpUuMcbIkc+3Am8IjhI4Yj/GwKCrpLW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PO8++ZJT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PO8++ZJT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094481F00893;
	Mon,  8 Jun 2026 17:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780941193;
	bh=+oJtzYYP2pKAJ5zPI+wu/YkSrwtr6IMIgnwI/sMsH9g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PO8++ZJTfTB5Xb0SGjeZkXVgdt/SPWDsRqHIy6grm4tEzG4c/k2zJOLjiPTRvsvWn
	 b8+LMn5gZTWl8iY9wz2jbyNSn4aqTIKFx8u9cwjfNRx8I906Gj+Zc8V44+SyuJq8YN
	 mB8zoBJAgaN+9WEi17PTqX0vUgbb5f/3eS0n3ffYRkAd/a9F6CchEq1ji03mUowf2J
	 m4o8LnPPVhtTYpsJNxMVBt+dOMjLfdCgmPLpj7lDClEmAce5FvJu5u1g4AnN3oMFxI
	 cbGDM4QIHyyV6NZJLnXnDRWrxFvjEJmnNg+fiOPl5S8KU9+80AWAbbXSJO+XbSVBZ6
	 iSYImJMc+k4zQ==
Date: Mon, 8 Jun 2026 18:53:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, Jakub Szczudlo
 <jakubszczudlo40@gmail.com>, linux-iio@vger.kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 marcelo.schmitt@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mike.looijmans@topic.nl, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, jorge.marques@analog.com,
 antoniu.miclaus@analog.com, mazziesaccount@gmail.com,
 jishnu.prakash@oss.qualcomm.com, duje@dujemihanovic.xyz, wens@kernel.org,
 sakari.ailus@linux.intel.com, linusw@kernel.org
Subject: Re: [PATCH 2/3] iio: adc: Update Kconfig description for TI_ADS1100
Message-ID: <20260608185301.320f147d@jic23-huawei>
In-Reply-To: <aiaq1EdzvyrlYn82@ashevche-desk.local>
References: <20260607183542.368184-1-jakubszczudlo40@gmail.com>
	<20260607183542.368184-3-jakubszczudlo40@gmail.com>
	<CALoEA-yj3hMKRa-3OpKtHKswRjddkARSBs9AnfiLNOtPiygPyw@mail.gmail.com>
	<aiaq1EdzvyrlYn82@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jun 2026 14:43:16 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Jun 08, 2026 at 08:45:46AM +0200, Joshua Crofts wrote:
> > On Sun, 7 Jun 2026 at 20:38, Jakub Szczudlo <jakubszczudlo40@gmail.com> wrote:  
> > >
> > > Add mention of ads1110 in Kconfig for TI_ADS1100
> > >
> > > Signed-off-by: jszczudlo <jakubszczudlo40@gmail.com>  
> > 
> > Better to fold this change into the patch that adds the actual driver code,
> > otherwise this is unnecessary churn.  
> 
> It's fine to do it separately, but after the code update. The combined version
> will work for me as well.
> 

FWIW I'd prefer it combined with the next patch.
I'm not keen on separate updates on build files in general as they
are easier to review in context. 
