Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA083D1CC0;
	Tue, 26 May 2026 16:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813818; cv=none; b=JzCnliWh0G8+ZMT+1etGEu51Lv5s8GqAgmohGr93LGtUb3ogTqvsdD3lTO6IUU7eHxDNO20MYVlRLShyfu1Nc+nHtqQkCFYDY2RxsQ5wELMvL64+AqDmtsGYaMBDHGc+GwmZivTfORQVmvU3MZgSddXla/LeW5P4lPTZ9VYiRew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813818; c=relaxed/simple;
	bh=MjLHloKJCxD+hGr33Dww2AZhfZ3uiSEFA70yynJqiCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PWiBtF1eEyFQGAHiewHkoCQjH7/mDYCq07NPLPYefEPFJb/vGTcolZ29m3tRkEsnAyP2U7Y3iEye51JJPmrDbiXo1mTLSfROPCw5a+ukTY096o6yXW9hUHqHpopBDh1mDEZ9mOU4t7RIyNgT5HRhwRw1a0BbgkDIyMowdgwJBEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mcumi2w1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mcumi2w1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B70A1F000E9;
	Tue, 26 May 2026 16:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779813815;
	bh=Wt7b2w/nP6GXZrMW8V04fvvP+WuxlrCyAZTLdwHm9Mc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Mcumi2w1s+QkLY2IqtaI33Osg/Zn2jADRpCokTSxuIfJdYbLxzI91DeBHiokFLxxP
	 pipd8ifZqFMw2biwzS1sjhKNoHtCXmgmDs9VA5BtrXUrAA+w/b/fveXJ6xIqtdTshF
	 oDkbm4P27HoBOfwQrxIhVb9mRzLWsiVs4ynaGtU5U9cvDpY2S19UnPdz9jEa+/DV6C
	 5iGrVE09rDUwZZddRd8TIwKRWIWg55pX6qkzTDTWnQRhK3Q5tPni491QMVrxY2Zbfo
	 Zl/wP2qd1d4/3DjLez9zrimhbGzkpz3cQFDSmIYLHvjO4/qyaehQ0GW8GGMk86zXHX
	 PSFZ4olEnqGew==
Date: Tue, 26 May 2026 17:43:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: lars@metafoo.de, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux@roeck-us.net, jdelvare@suse.com, ak@it-klinger.de,
 linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 3/4] iio: flow: add Sensirion SLF3x liquid flow
 sensor driver
Message-ID: <20260526174229.7c7414ae@jic23-huawei>
In-Reply-To: <20260524205112.26638-4-wafgo01@gmail.com>
References: <20260524205112.26638-1-wafgo01@gmail.com>
	<20260524205112.26638-4-wafgo01@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 May 2026 22:49:38 +0200
Wadim Mueller <wafgo01@gmail.com> wrote:

> From: Wadim Mueller <wadim.mueller@cmblu.de>
> 
> Add an IIO driver for the Sensirion SLF3S family of digital
> liquid-flow sensors.  The supported sub-types (SLF3S-0600F,
> SLF3S-4000B) share the same register map and command set and are
> distinguished only by the flow scale; the variant is detected at
> probe time from the product-information register.
> 
> The driver exposes two IIO channels:
>   - in_volumeflow_raw / in_volumeflow_scale (litres per second)
>   - in_temp_raw       / in_temp_scale       (milli-degC)
> 
> Continuous measurement mode is started in probe and stopped via
> devm-action; read_raw() fetches the most recent sample on demand.
> 
> Signed-off-by: Wadim Mueller <wadim.mueller@cmblu.de>
Also see:
https://sashiko.dev/#/patchset/20260524205112.26638-1-wafgo01%40gmail.com
It may well not be correct in all cases, but it often is!

The value of _scale seems like a plausible issue to me.
We have discussed expanding the range further than 9 decimal places
in the past. Seems like this might be the time we need to do it.
There is some work under review at the moment to allow more complex
fixed point handling but not sure it applies usefully here.

I also missed the crc table is global. Easy solution is take a copy.

Suspend / resume one is a value add for the future.

Jonathan
