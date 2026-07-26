Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D511D37C118;
	Sun, 26 Jul 2026 20:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785097488; cv=none; b=EPtTFMdTVq0aYQ/H6bLbJu48eAHRLpM/SOW9n8EMnQ6uYghZKDp/ZRvBqrqlwickAL+qaQ8zOBfhyNIEACeVT/bIqAknuLieoxWiieZAwWZG8MMoX9tS7d5O/CSb8IONPQ+FfQdPW8VM46UHSd1qs3Iumo1dIgaDJPdWhQmfWkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785097488; c=relaxed/simple;
	bh=tI8SSGUobmZ65r1WAnE1n7mZhJKSa/0JfoIBx3/P2fc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KyDibEQhYWyEszkdT4aF4TdCOInoV4UVPdj2jdBm4JgmNiV1gk5Yq3NC0/aIOfVZ9GlKBIVSTxALufTZSvs0g+Au0Rmg8IJGSI/QYoyJG6FM/y8qfnjSLhmKlNzaTBEGmdTiWiWnLXXvE7kCjgiIqjo7mqmL8pa1+gTHnZ0oLAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gs9y4i6n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gs9y4i6n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7F71F000E9;
	Sun, 26 Jul 2026 20:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785097486;
	bh=OnMqqxswChY/ksukqd9B1K2o5b/IJoLlGSnr98cqu8I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Gs9y4i6nwpyMUYE5qpDTL/IqPSeV0/oQtDP5GfTpW2+a0MW1HYAP43IeLKKfkRW6o
	 mtdqOmLjywBCqcXU0squuHPvP8rbTEvQWu/Bm0mIyVxt09lVu0Gok7fJ4wB6MoMjea
	 HEyo3xcFRQh4e5eXTyiPmNIdyZZqmlTbuGokdaeP401l45dhm/iTyxp3TkjDcFUIDL
	 AregR/zJXS0eRfFdIQjc94zFy5Osootaj/WqsMr5YktJnPi0SQuxzqCBcHB4gkNRWO
	 GSwgLScrgFWt4K4c9uaXA02v2j4pEJEFwNwMDQwUV0Dn5l+EaJby/QLWeUI+TX/CuE
	 HNgugCgDTEcLA==
Date: Sun, 26 Jul 2026 21:24:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Pan Chuang <panchuang@vivo.com>, Puranjay Mohan <puranjay@kernel.org>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Petre Rodan <petre.rodan@subdimension.ro>, Dan Robertson
 <dan@dlrobertson.com>, Matti Vaittinen <mazziesaccount@gmail.com>, Gustavo
 Silva <gustavograzs@gmail.com>, Maxwell Doose <m32285159@gmail.com>, Tomasz
 Duszynski <tduszyns@gmail.com>, Nishant Malpani <nish.malpani25@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, Li peiyu
 <579lpy@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Alex Lanzano
 <lanzano.alex@gmail.com>, Jagath Jog J <jagathjog1996@gmail.com>, Mikael
 Gonella-Bolduc <m.gonella.bolduc@gmail.com>, Subhajit Ghosh
 <subhajit.ghosh@tweaklogic.com>, Mudit Sharma <muditsharma.info@gmail.com>,
 Kevin Tsai <ktsai@capellamicro.com>, Linus Walleij <linusw@kernel.org>,
 Anshul Dalal <anshulusr@gmail.com>, Song Qiang
 <songqiang1304521@gmail.com>, Andreas Klinger <ak@it-klinger.de>, "Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>, Siratul Islam <email@sirat.me>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Bjorn Helgaas
 <bhelgaas@google.com>, Danilo Krummrich <dakr@kernel.org>, Takashi Sakamoto
 <o-takashi@sakamocchi.jp>, Xichao Zhao <zhao.xichao@vivo.com>, Waqar Hameed
 <waqar.hameed@axis.com>, Sakari Ailus <sakari.ailus@linux.intel.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>, Miao Li <limiao@kylinos.cn>,
 Dixit Parmar <dixitparmar19@gmail.com>, Andrew Davis <afd@ti.com>, Kurt
 Borja <kuurtb@gmail.com>, Shrikant Raskar <raskar.shree97@gmail.com>, Chu
 Guangqing <chuguangqing@inspur.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, "Rafael G. Dias"
 <rafael.guimaraes.dias@usp.br>, Svyatoslav Ryhel <clamor95@gmail.com>, Shi
 Hao <i.shihao.999@gmail.com>, Colin Ian King <colin.i.king@gmail.com>,
 Salah Triki <salah.triki@gmail.com>, Yury Norov <ynorov@nvidia.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Yash Suthar
 <yashsuthar983@gmail.com>, Achim Gratz <Achim.Gratz@Stromeko.DE>, Yasin Lee
 <yasin.lee.x@gmail.com>, linux-iio@vger.kernel.org (open list:ADXL355
 THREE-AXIS DIGITAL ACCELEROMETER DRIVER), linux@analog.com (open
 list:ANALOG DEVICES INC IIO DRIVERS), linux-kernel@vger.kernel.org (open
 list)
Subject: Re: [PATCH v2 00/13] iio: Remove redundant error messages on IRQ
 request failure
Message-ID: <20260726212440.6fa412f2@jic23-huawei>
In-Reply-To: <20260726205941.40f6eade@jic23-huawei>
References: <20260724030524.607185-1-panchuang@vivo.com>
	<20260724122701.0000156f@gmail.com>
	<20260726205941.40f6eade@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Jul 2026 20:59:41 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 24 Jul 2026 12:27:01 +0200
> Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> 
> > On Fri, 24 Jul 2026 11:03:35 +0800
> > Pan Chuang <panchuang@vivo.com> wrote:
> >   
> > > Commit 55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()")
> > > added automatic error logging to devm_request_threaded_irq() and
> > > devm_request_any_context_irq() via the new devm_request_result() helper,
> > > which prints device name, IRQ number, handler functions, and error code
> > > on failure.
> > > 
> > > Since devm_request_irq() is a static inline wrapper around
> > > devm_request_threaded_irq(), it also benefits from this
> > > automatic logging.
> > > 
> > > Remove the now-redundant dev_err() and dev_err_probe() calls
> > > in iio drivers that follow these devm_request_*_irq()
> > > functions, as the core now provides more detailed diagnostic
> > > information on failure.
> > > 
> > > v2:
> > > - Rewrap commit description to one line.
> > > - Drop redundant "!= 0" and "< 0" comparisons.
> > >     
> > 
> > Okay, code-wise it's fine, but rewrap your commit messages to 72
> > characters per line.   
> 
> That would involve breaking the commit reference across lines.
> I asked that the author not do that on the previous version because
> it'll make it harder to search for if anyone ever wants to do so.
> 
> Also submitting patches suggests 75 chars. I'm not sure where the 72
> comes from, though it is often quoted and another bit of submitting
> patches does say 70 to 75.
> 

Picked up series with a few tweaks to call out where if (ret < 0)
changes occurred and making sure Andy's RB actually got added.
There was enough changing in here that b4's fuzzy matching missed
sometimes.

Pan, please be careful to pick up given tags on future patch sets.

Thanks,

Jonathan


> 
> 
> > Feel free to apply my tag for the whole series:
> > 
> > Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > 
> > Also, I was scratching my head at how enormous the To: list is, given
> > these changes are only in IIO, but I assume you also added emails of
> > the people who authored the latest changes on a file that get_maintainer
> > outputs - there is no need to do this. Tools like b4 can automatically
> > add (correct) recipients based on get_maintainer.pl
> >   
> 
> 

