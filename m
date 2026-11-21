Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795305552;
	b=04Gx4jxUZc9Qflut33YEvKFELB1QrJ6iG5Y3i1Yu+QYc9eJDYNXIvEZU1ltBIk6obFCd
	 nD3I2YWpNivWmLqUe2ywo7lKYQO8DkLJJF1M1Nnfgi+3OPJb4L18pUoWdiRfXEhAtSbqd
	 f8X8kI3cLUkEBFT2fRV/tpK64kswXOsKLYiSw+yeo+pIAZiywf4xsP0fdIzaTcCY6xU3e
	 Li2Zc0CE88HRLubDlL4d256nEoBXctF1vyXQxfX4Q9kO+JITEuTRP9RqlsIWtX2QrtFV9
	 jL9z6Q/7m/usSUg7qEXPJIHZXO30qN/K9ch+f3m4Wv3NO9IFleO1skcPchl/Mg3PbWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795305552;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=GawK7uEp6ynP+1OXc7D7hnhH1v2mtIVCn3SoaQI56xY=;
	b=NnBrIc+2UkOPod0vvq2+skxeO+44xwLORM45MqrVuHMgBawiFNvwGPucmr8WaS3JWHgw
	 2Qvb1a6svm9RE7qr0zWA6fhK4PlgMIsK8NdDVbadljHl6lXBy+6bO8I+eU0eNRTn5HDe4
	 Cf+hI9MMN2oSqktXEPSuRshsK7adqYQsZYlub8xDs7DQJVWCKjgIqNBhQ5Ew6uWh8S773
	 3HdhrDPjQ7bbD8emyap1eeREybNDYG36ix0C0k6WlVgwl2OzeyW/j5YiKKRw9sEQ2SR4q
	 d7eNlNxT08WNhPnQtdY7BJLCn8FEeJBJO/cyWk9Z7iQYqP1feWREfxqqsyN1ngxc+oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QEf3Wbg1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A72606A320;
	Sat, 21 Nov 2026 23:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QEf3Wbg1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFA81F000C0;
	Sat, 21 Nov 2026 23:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795305552;
	bh=GawK7uEp6ynP+1OXc7D7hnhH1v2mtIVCn3SoaQI56xY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QEf3Wbg1J/IPtqQb9GkmAIOA9TUQzDHhKV1oLBYQGAOnqUkyLKiYJ746o2t+yWt0k
	 QZn5p+kINkL4PA06JPBT5dB1UvOpJ5L41DPyZHxuWjV8/mX3Rx03JkluvM8pAGzOT9
	 +wEY9FEJfltTxHAUmiT5R76+vqZpYjpXBZERAU+o4hsHIgmh9WGhSD89o+WBZ/GNff
	 uslrpHEv6ffxkilMBJKFXb0VDIsANSzoBxWCAzO2xILQbk/Yd0uYZ8ZvDPN5XdeKbs
	 mSpIAt+2Pg4unerETaUqvIXaFlAKNUsA3zNebLbMLLkLPnbRu3YaZLAjSJhvv+BfJU
	 iHP2VvXjaYJ1g==
Date: Sat, 21 Nov 2026 23:59:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>, Gwendal Grignou
 <gwendal@chromium.org>, Daniel Campello <campello@chromium.org>, Andy
 Shevchenko <andriy.shevchenko@intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: proximity: semtech: add myself
 as maintainer
Message-ID: <20261121235904.612f61e6@jic23-hlaptop>
In-Reply-To: <f3d38cc6-112a-4d48-b0e6-f26d7819aa1b@kernel.org>
References: <20261117172612.25535-1-kapoorarnav43@gmail.com>
	<20261117172612.25535-2-kapoorarnav43@gmail.com>
	<f3d38cc6-112a-4d48-b0e6-f26d7819aa1b@kernel.org>
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

On Wed, 18 Nov 2026 13:37:40 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 17/11/2026 18:26, Arnav Kapoor wrote:
> > I'm adding a reviewer entry for the Semtech SX9xxx proximity drivers to
> > MAINTAINERS. Add myself to the maintainers of their bindings as well,
> > so changes to them reach me.
> >   
> 
> Why? Same comments as for cover letter. Looks premature, you were just a
> few months ago sending multiple same patches, clearly not even checking
> what you are about to send:
> 
> https://lore.kernel.org/all/20260624044610.69708-1-kapoorarnav43@gmail.com/
> 
> https://lore.kernel.org/all/20260624042543.38925-1-kapoorarnav43@gmail.com/
> 
> Your patches were never even built by you:
> 
> https://lore.kernel.org/all/20260621045340.65872-1-kapoorarnav43@gmail.com/
> 
> Building code is... well, we do not have to even discuss that. You were
> simply sending LLM slop.
> 
> LLM slop senders are not maintainers. It's doing everything opposite to
> maintainers.
> 
> Best regards,
> Krzysztof
Hi Arnav,

I tend to be on the relaxed side for people offering to look after individual
drivers, but given Krzysztof's feedback let us hold off for now.

Give it some time and continue your active work reviewing code and we
can revisit!  Don't let this put you off. Your recent contributions have
been most welcome.

Thanks,

Jonathan


