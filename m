Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794885518;
	b=A8tGvJuEm8He6fN2pDnhy6t+RDsgVynTaOP/UOfSH5AVGGA1xe4iDBBxyW1Xuuf8L7pS
	 6lZv3ltkRbIVCtvtUFfYIXf2BUcbiDCMfbdFHQognd1HorJdmwFiyUre0QaHINiItTfsx
	 FoXvukNKMov69hcO5UKastuMzif2DRri7vyRgoUXAJrnUXfxdFI25+XWruTGyJIZ60JQd
	 +vp4392X3zp6tmNEc8oDZ7B5aDVlvknri/aytJhzt2lErCF0ESAdXbpp0e4qKWn/Ba+JK
	 fTSdsqVtrq5cks6w3wHOa2PCctAg3+3iSgFQsXp7UJeTGmkCWNzS6MKJjOXO9zFVidQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794885518;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=xHXm3AH57pto0E0Q37QvGKX77fTXzoDTB0OzTQzuZlE=;
	b=UBmMXTk2vh2nnFa+SYXlNa85Dg+hg+lwHHbad+iyioPJSTtG4m0eEYdopdUtojlRN+1l
	 Qt9iZkWR2k7ppArRdefAwpHjb4JcGowrO3vMea/hSTjPQzGtLcA+BfNZr3MKSSGGFrM62
	 rSBFUER7YJ5VlLxwwaEx4Vzd9MaLY4YDhIJG1HkDhjyguUOVR55oQOZbc0ZAIOqNlcFrJ
	 ryGNLe8XmSaCLIHp+J/Gxvn1Mk9Pl1w1/ROT5zI2L38leSNZAcvjJdusK11tOQUc4viTA
	 1gOuNPeeNPI+jkP1WXJrJR9DxcvX7lLUouyxW0b1bBMS7rRwLkKXTbwCpKWQ2IJzCLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cX59Ab9r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F84606A31C;
	Tue, 17 Nov 2026 03:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cX59Ab9r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2701F000C5;
	Tue, 17 Nov 2026 03:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794885518;
	bh=xHXm3AH57pto0E0Q37QvGKX77fTXzoDTB0OzTQzuZlE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cX59Ab9rzqgwGwcbLF4QUiRsjurAmILsn5njupNcCivQjmf5pwFWO2q++7TP+jOQd
	 7fpBpOVAw8Zype91fB5tWCxEf2zAutlZN9ORnkEbLZmq7uzTqUAb73jxCkwuEt0siV
	 XXA5Eb96TtuqBLwqkkk505S5LuwHOlAgBTBKKbezTdoac4UtNMxKfvVBopDYRLz74m
	 hjQfhs81KK2DOfjx+WRL8OcHmDG0ZQHX10prUlcfk7QGoAPBLSucXS//yPLM+3RQr8
	 kuBeHM/Z65Vdt92fCq4W+QKAmtbuSnHHHh6X9wTU6nzBetrfKIS9RB15GBiga+mbAI
	 TGrSMVlm2a1Yg==
Date: Tue, 17 Nov 2026 03:18:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Gwendal Grignou <gwendal@chromium.org>,
 Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iio: proximity: sx9310/sx9360: reject
 out-of-range hardware gain values
Message-ID: <20261117031830.69ac22f5@jic23-hlaptop>
In-Reply-To: <avrEmbZJSX5qtGS2@ashevche-desk.local>
References: <20261111164041.341776-1-kapoorarnav43@gmail.com>
	<avXeSbAEGhkMjMJa@ashevche-desk.local>
	<20261115014333.120063-1-kapoorarnav43@gmail.com>
	<avrEmbZJSX5qtGS2@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Nov 2026 10:53:45 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, Nov 15, 2026 at 07:13:32AM +0530, Arnav Kapoor wrote:
> > On Thu, Nov 12, 2026 at 05:42:01PM +0200, Andy Shevchenko wrote:  
> > > Now it looks better.
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>  
> > 
> > Thanks, Andy.  
> 
> You're welcome!
> 
> > Jonathan, a related question while this thread has the right people
> > on it: the Semtech SX9xxx proximity drivers (sx9310, sx9324, sx9360,
> > sx9500 and sx_common) have no MAINTAINERS entry, so get_maintainer.pl
> > only finds the IIO maintainers and reviewers for them.
> > 
> > I've been working through bugs in these drivers for the last few weeks
> > and would like to keep doing that. Would you be OK with a patch that
> > adds a "SEMTECH SX9XXX PROXIMITY SENSOR DRIVERS" entry with me as R:,
> > or M: if you'd prefer the drivers to have a maintainer?
> > Gwendal, as the author of most of this code, you'd be very welcome on
> > the entry too, if you want to be listed.
> > 
> > I don't have the hardware, so anything that needs a real device would
> > still need someone who has one.  
> 
> I believe for an M entry it's kinda implied that you get an HW to play with
> (at least one of the supported sensors by the driver in question).
Agreed that I'd assume that.

R is fine though without hardware.  You are just expressing knowledge
of the driver and a willingness to review changes.

Maintainer can fallback to the catch all.

Jonathan

> 

