Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7024C3ACF1E;
	Fri, 29 May 2026 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780045428; cv=none; b=XBs7fwkEtOT6/M/lpskVpQ2hHS4zDOQfoEMIQz2TpqKYMu4OGV6wuT7uuvspQhj5wVDJFrOJrFN57ZAHCC5vpGhF0YFUaY7Tgtc9kHEfI0M4QfM1d58FKihCQvlw7/108iyNt9T1EB1LmuDavf/bYjJ3Fk6+byd8c7ObgkgmsPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780045428; c=relaxed/simple;
	bh=dfvd3+GTrarMPPUGrgttsrrfFPcOJYJ/c/UNZFYWs5M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UHF+71sBY+mChcyUXBDRWJMG8JDbqXYp50bo07g1cRGfZfEebMIKZBi7sFEzTfFHkwsYYfGPCkuOwq4ITjZ1FbxR0smGArqu6QniO79vTG/exA6mlS3cR3Ajc182c3hpJrBTaeeMpCTGoWGlg8EmawpeD9BYf9kyrnjnAU49I9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+9pPHJr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+9pPHJr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF7F1F00899;
	Fri, 29 May 2026 09:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780045427;
	bh=XqUguunJRpbZ9x2gW/CJnKhlSiBuX+wd5rq8fxPIDHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=M+9pPHJrMLZ35VYpdWvp/z6eDizpMqwUhkBZxGZ0RFXS+MXbygzmRHirEeHLgTAAm
	 zmy5mUU7+gx83Nm6QhyZNwmVlSawyCi8UucTT9rNJ8JiEoaHwGwZT0uJ2bTkP92GpO
	 of+zdVXgSwJFI/cEXhcwCxNuhxmlAktIdSz334KKj7Zzl2Ej+mtY811+BgOsYlm6TG
	 sA8GFRNMuTpMbZ9tpp5NGlc0jsiE6SI9d97C2O2xkhzNRzpVpG9HppPrg0KG3ahhnC
	 8wlVceE9nUCGOl3vqzxOEvG7bFeZJs5cu3jMBWUgrO9tDx2su5akKtE76uZxoW/XUr
	 f/qpI1w7R0AeQ==
Date: Fri, 29 May 2026 10:03:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Erim, Salih" <salih.erim@amd.com>
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Conall O'Griofa <conall.ogriofa@amd.com>,
 Michal Simek <michal.simek@amd.com>, Guenter Roeck <linux@roeck-us.net>,
 Salih Erim <erimsalih@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] iio: adc: add AMD/Xilinx Versal SysMon driver
Message-ID: <20260529100336.3f18d93c@jic23-huawei>
In-Reply-To: <d579623e-b799-4caa-aeec-7d070a972aae@amd.com>
References: <20260527114211.174288-1-salih.erim@amd.com>
	<20260528130600.25e401a7@jic23-huawei>
	<d579623e-b799-4caa-aeec-7d070a972aae@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 May 2026 22:46:58 +0100
"Erim, Salih" <salih.erim@amd.com> wrote:

> Hi Jonathan,
> 
> On 28/05/2026 13:06, Jonathan Cameron wrote:
> > 
> > 
> > On Wed, 27 May 2026 12:42:06 +0100
> > Salih Erim <salih.erim@amd.com> wrote:
> >   
> >> This series adds a new IIO driver for the AMD/Xilinx Versal System
> >> Monitor (SysMon), providing on-chip voltage and temperature monitoring.
> >>
> >> The Versal SysMon measures up to 160 supply voltages and reads up to
> >> 64 temperature satellites distributed across the SoC. The hardware
> >> also provides aggregated device temperature registers: the current
> >> max and min across all active satellites, and peak/trough values
> >> recorded since last hardware reset. The device can be accessed via
> >> memory-mapped I/O or via an I2C interface.
> >>
> >> The driver is split into a bus-agnostic core module using the regmap
> >> API, an MMIO platform driver, and an I2C driver. This allows the
> >> same IIO logic to be shared across different bus transports.
> >>
> >> Previous submissions:
> >>    v2: https://lore.kernel.org/all/cover.1746182670.git.salih.erim@amd.com/
> >>    v1: https://lore.kernel.org/all/cover.1757061697.git.michal.simek@amd.com/
> >>  
> > https://sashiko.dev/#/patchset/20260527114211.174288-1-salih.erim%40amd.com
> > Quite a bit of feedback.  Some of which is clearly garbage, like the
> > ARCH_VERSAL suggestion, but take a close look as it does tend to pick up on
> > stuff that humans miss.  
> 
> Thanks Jonathan. I've gone through all the Sashiko findings.
Thanks,
> 
> Reviewed but keeping as-is:
> - Left-shift of negative in millicelsius_to_q8p7: GCC defines
>    this behavior and it's consistent with the read direction
>    (right-shift); Andy asked for this symmetry in v2
> - Oversampling read without mutex: reading a single int is
>    atomic on arm64; adding contention for no practical benefit

This is potentially a bit messier if the compiler gets creative
(see Will Deacon's various talks on this for instance).  Still
we neglect this for most IIO drivers today.  One day maybe we'll
fix all that up - lots of careful READ_ONCE()/WRITE_ONCE() markings.



