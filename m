Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FF4230BE9;
	Wed, 23 Sep 2026 02:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790128837; cv=none; b=WI8D1BnCy2GiWhVJEfVhhhCDJmwxx+E3QsBjBQiombwiM+EqxqPlI/mawRXEYTFaUyn2YhUsskNrJx0DPHOeKsixGpm06hUFSTYoZxNCMC+v01UyvV1HaE5r+6TpYO0dKsW5DUvpRduFkOUxwIhYZKMIwZxvN9yhYU4gqSyS6Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790128837; c=relaxed/simple;
	bh=2tgJ20LpL3LkOW3xfe1Zw1ujmjEjo3kBCWCBNU355K0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SNojbTjMEES8AHu+dMZHDuwhsTEK/yK7le5weKHI81oPdblf/3AOFR74EsYLF1lEg8N7nvX8zrgk1GMvBx2gN7L23Q5l+x1XdIdfP2GXqvADhrc/FqzwtBpUYi/AFwB+INLRi4j8vGBAAi0d854NgpL5NgNgK3Ubm3s/wn6FzBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hm86xpSV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hm86xpSV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3771F000FF;
	Wed, 23 Sep 2026 02:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790128835;
	bh=rud8SLnmMoEsyKXoR2FkYRc0jjLKbh0kFcRPEtzLPSY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Hm86xpSVjo9xkuaZtUgoOsKRWOB3CSyPGTVXzicpZEUNfDTM2NpkvDTsDel/0b4Me
	 i51+65Q9y6N/FMP9osOs2R1TihGpOnFG+c4LE470VXnlvYJsIyVbKp4XmyIqogfQtK
	 +d42/L6Mw5Yz4KZEbEynfG1x9Yt244oW7fSvZFwlggljwrxclHhEVPZOsxWtVefpWB
	 BO6Fwe9EzdSDwx9Psx8mUHylUGnBRS0Q/pRtGZu5U+1OjWZhUyITqFWRx2OaZtT+iC
	 i9kj3NoLFQZVOS6y7kAP1F2njd7k6rXmkFQrEwlXhXyAw2glf6ypSk9PWLYh7ytkWo
	 bST9mjLW8gjRw==
Date: Wed, 23 Sep 2026 03:00:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Bill Wendling <morbo@google.com>,
 David Lechner <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>,
 Joel Stanley <joel@jms.id.au>, Justin Stitt <justinstitt@google.com>,
 Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v6 4/6] iio: pressure: dps310: add triggered buffer
 support
Message-ID: <20260923030027.4fb7414e@jic23-hlaptop>
In-Reply-To: <20260918122415.375211-1-zoone.rupert@gmail.com>
References: <20260824201203.396651-1-zoone.rupert@gmail.com>
	<20260824201203.396651-5-zoone.rupert@gmail.com>
	<178813888150.2788519.17461592150162820073.b4-review@b4>
	<20260918122415.375211-1-zoone.rupert@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Sep 2026 15:24:15 +0300
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> On Mon, 31 Aug 2026 02:14:41 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > As this isn't filling in the timestamp, I think you'd be better
> > passing s32 channels[__at_least 2] as that final parameter.  
> 
> There is no __at_least in the tree and nothing in IIO uses [static N], so
> it is a plain s32 channels[2].

At sorry, it is just at_least and there  is always a first user :)


> 
> Rupesh

