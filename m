Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3C3253B73;
	Thu,  5 Feb 2026 20:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770324343; cv=none; b=kh7pV2tHaOBRAnKmo3MEim04sR6fDqYO9cSmQ7AOAmSMFAgUFt51y2bBX6yEg7GEeKiZ7HGR/YPX0pe0eswpTfAaxoOELH4eiMQOXINTV0SobRWf2j0X6uOfF0hJJwfuQPKFrwvCi57eEKVTlgVXIw2SI2Qi+sPPpKn8Snle7z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770324343; c=relaxed/simple;
	bh=8Vm1xVBeTFjcsJ8EoEubFpgSCSUOAqPXdGRc5NYntMg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U9u+IUcApOVoEt3/QrqPr0WkWI0xaOvk2TK5uCjyuEdEMJfNcgVfb1QcM/LLmwpYzOKkjr1Rfz4DBHSnrT6RihsmT2/InJF5vzaM1ue3UzCMN+eSDO33kUPuM3oTMrPXzPhIErZeNTCtb4GVaaDEG0OPZIIIhK+VCEzrPXDHWmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHcnCad0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHcnCad0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BB6C4CEF7;
	Thu,  5 Feb 2026 20:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770324342;
	bh=8Vm1xVBeTFjcsJ8EoEubFpgSCSUOAqPXdGRc5NYntMg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NHcnCad0vImSl9MYmPlVMuEftOmKcqvsybbbYOZkY9Qs1DfCDxIKOpfpfl+zkBcbk
	 Q1TTFsNrYiH/3nRrALo6aykVjI6mtvcSCftua1Y7o1jydSmrfqcFGnpnmtN7xWS3r5
	 NS833bvwLPloWtmXJVHeVrZVt8Fb0c5phPtDMmn4hjXFdrDlmCdlI2XEilcAdwiDRJ
	 qqvr5NAP0RsUxwC/tO7jPi5DnM0Q6EfyCr1KeYCnSreAAT/UjZ3OrFabwiYsGUWJPN
	 MIYOf4Mi1IKVuvVLiy5X29penYkvNI1+rEBBVoawW5cnU62AR7sSpMqSXvephAqoAp
	 eb1XjGyiBnu/A==
Date: Thu, 5 Feb 2026 20:45:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Jagath Jog J
 <jagathjog1996@gmail.com>, Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>, Fabio Estevam
 <festevam@denx.de>, Linus Walleij <linus.walleij@linaro.org>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Marcelo Schmitt
 <marcelo.schmitt1@gmail.com>, Eugene Zaikonnikov <ez@norphonic.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/13] iio: remove unused struct fields across
 drivers
Message-ID: <20260205204532.1a49cb73@jic23-huawei>
In-Reply-To: <aYHDjUVQTSa4Oyrl@smile.fi.intel.com>
References: <cover.1770030812.git.antoniu.miclaus@analog.com>
	<aYHDjUVQTSa4Oyrl@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Feb 2026 11:44:45 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Feb 02, 2026 at 01:25:50PM +0200, Antoniu Miclaus wrote:
> > This series removes unused struct fields found across various IIO
> > drivers. These fields were either left over from previous refactoring,
> > or were added during development but never actually used.
> > 
> > Removing them reduces memory footprint slightly and improves code
> > clarity by eliminating dead struct members that could confuse future
> > readers.
> > 
> > Each patch is independent and can be merged separately as they touch
> > different drivers with no dependencies between them.  
> 
> Assuming it applies cleanly and compiles,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> and I see in some cases it gains space.
> 

Applied.  Thanks!

J
