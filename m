Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB2B242D65;
	Thu,  2 Jul 2026 20:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783023336; cv=none; b=nRj3TwxsKHKZDl1ovHS8l7e6OEDK+2wu/NXKncxVYpJl+e5DE560qtEj79QIjHsHVKeLlqZFWO/RunTo5mnsJ89xgxkCyXCsK/73Detb/ptQkCi8bducuHal3BmHKwlDQ95IFk/DMdy+htkD3msoyatlWDJaxmDZmjwtJ8xBPMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783023336; c=relaxed/simple;
	bh=+rk5AypRIrYkXJboLriL8DfQpGlmDTgunbf6eVj1rpw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L//PtC6btHX+mIQ9ikNKl4r3u2hWx1phZPCinUG5SMfbT+FVuEW4R9uzZxrLOtCZciQw0MUpMdb2oRf+KaaIEg+Dp1E/6Sj3OgafNCuziKIbvFt7ZWhmAzcauD7IByH/pISj2m4QJNE8VRQAcqX8JGVtUSBEnROvJuSDC1G9LbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVEoXwrY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVEoXwrY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD78B1F000E9;
	Thu,  2 Jul 2026 20:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783023334;
	bh=J3N++1DrkqZG7W8piNvlwRdK1s8AEcTVHMt/m15GKHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jVEoXwrYJB0PSGXSNhNtEPoTxnHMejfphLioh/xwu7av4OCMMuEKq5+n2+yqTnG9W
	 3RLBYOdjvNd+Wm8ScwC9P8JGw5O2mRxGMQsHwwEd0qOZcSZ/KAekR/oeBVH+OtUY1l
	 EqZDCxRMl3h348MwHLlFfTLsv4DNk3VWbGCtIOLuvf0fzTTfdPLM0xarG+w9ztaMXc
	 9swxSzI0aKiBssOGV/y5iP7+ZFiBm/pe3LjrsdvzcD57k+6rIErk5FIz92M9N0Jcdn
	 kg0L5WXaHab/l6shChxPDWENSlbI8xmPwVam9Dj8C0HBhAyC9l9w3PoG9I4gKywb2W
	 +m6E8MUIp0pTQ==
Date: Thu, 2 Jul 2026 21:15:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM
 AND DRIVERS), devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND
 FLATTENED DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: Re: [RFC PATCH 0/3] Add Sensirion STS30 temperature sensor driver
Message-ID: <20260702211528.13fbb841@jic23-huawei>
In-Reply-To: <20260620044010.1082621-1-m32285159@gmail.com>
References: <20260620044010.1082621-1-m32285159@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jun 2026 23:40:04 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> Hi all,
> 
> This patch adds support for the Sensirion STS30 family of temperature
> sensor drivers. It currently supports single-shot non-clock stretched
> readings as well as the entirety of the STS30 family.
> 
> I'm sending this as an RFC patch as I unfortunately do not have the
> hardware right now. I have compile-tested it successfully and have done
> a tad bit of testing on QEMU, with it properly registering with no
> errors reported in dmesg. Unfortunately due to the way I had compiled
> the kernel used to test the driver it did not expose the I2C bus to
> userspace properly and I was not able to retrieve values from the
> driver, but I can continue more testing over the next few days and am
> happy to answer any questions anyone may have. Additionally, regarding
> dmesg logs, I neglected to save them while in my testing, but as stated
> previously, I can continue more testing over the next couple of days.


Hi Maxwell,

If sending a driver out prior to getting access to hardware (nothing wrong
with doing that to get early feebdack!) Then mark it RFC and state
at top of cover letter it's because it is untested on real hardware.

Note there are exceptions to this where we will merge kernel code against
emulation but that is normally about large cross industry standards or similar
not small drivers like this one.

Thanks,

Jonathan

> 
> Maxwell Doose (3):
>   dt-bindings: iio: temperature: Add STS30 devicetree bindings
>   iio: temperature: Add STS30 temperature sensor driver
>   MAINTAINERS: Add entry for Sensirion STS30 driver
> 
>  .../iio/temperature/sensirion,sts30.yaml      |  49 +++
>  MAINTAINERS                                   |   6 +
>  drivers/iio/temperature/Kconfig               |  11 +
>  drivers/iio/temperature/Makefile              |   1 +
>  drivers/iio/temperature/sts30.c               | 321 ++++++++++++++++++
>  5 files changed, 388 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/sensirion,sts30.yaml
>  create mode 100644 drivers/iio/temperature/sts30.c
> 

