Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F1A175A8D;
	Sun, 27 Sep 2026 17:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790529638; cv=none; b=Ko6Nv1Swm2OAhz0i44yngSBPWmGto/S0bGjRAv2hRChR/o+TUFbIpvfjSZ70wjclQ95twRGy7Bg6eNdYmo7zSEswDaUM7ak4T47eeDtmBn6X1ACygs6YgcTI/0/BNEAJ6y3wjvmh4EDDsGFnNYMEmojbE+oOA7l1s6NL6aY2ofg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790529638; c=relaxed/simple;
	bh=u5/wDkmjLQblmCApcNDp5j71D8QW3Rp1zyX8ySE2wk8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d9O8cUBKh+fCWiL8owEDvZSjrEuePNnbzyUoGD+x5DhflamDhKdqJBhXkZdZ6LSnw9QOTLAkQhb/GAbBbjkrrK2o5qsZWhLXxxiyonykIWw0ggxmCblehcFXjsFS8/6gFt9qXGYUYjdel3/CVDLc4UdzdX7whZ2V5Y7MCFORN/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H35YaXF0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H35YaXF0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3701F000FF;
	Sun, 27 Sep 2026 17:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790529637;
	bh=uqM2/RhHyVMNSnI3o/wEgW+aZX/6c3k3HHCtJRj7/PU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=H35YaXF0NJ6e31pYQMK9Z0MB81nez7defH9Y7Ukyr9hB/ACjbsDYBZ3iNxoionO5l
	 8rGLQPpahjXtJ24IA+m9K1tbjLXF0tL0FFnJnjynUrfS6+QlCaZmEozfb7FL4u4Yfu
	 8AIi6k2JZ0vixKzeuE+090pDV0K7uVG9Bu+aAttxPwLUkMzE5S1rDhuXqXO7w3/X/7
	 h+L7kTO54onK93BlihgaAjXEmVWugtacJY5Ts2VLSCzpDTreJrKONpooADMJKTFC+o
	 XeuVbega939AQek+QR5qBhm7cMjwhJlLlIOvgaHS7WbOyqu52EV3sXmPXaxELAXKdB
	 Hq6RWNZgd1D5Q==
Date: Sun, 27 Sep 2026 18:20:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jiale Yao <yaojiale02@163.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
 Siratul Islam <email@sirat.me>, Maxwell Doose <maxwell@maxwelld.cc>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: kmx61: reject duplicate event disable
Message-ID: <20260927182031.6d490331@jic23-hlaptop>
In-Reply-To: <araCxIGnZK0zuUSS@ashevche-desk.local>
References: <20260925141006.2255067-1-yaojiale02@163.com>
	<araCxIGnZK0zuUSS@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Sep 2026 17:18:44 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Sep 25, 2026 at 10:10:05PM +0800, Jiale Yao wrote:
> > The IIO core does not filter duplicate writes to the event enable
> > attribute. kmx61_write_event_config() already ignores repeated enable
> > requests, but a repeated disable request still calls
> > kmx61_set_power_state(data, false, KMX61_ACC), dropping a runtime PM
> > reference that was not acquired for this request. This can underflow the
> > runtime PM usage count and trigger a "Runtime PM usage count underflow"
> > warning.
> > 
> > Return early when the requested state already matches ev_enable_state.  
> 
> Same comments as per previous patches of the same topic.
> 
Fixes tag needed.

