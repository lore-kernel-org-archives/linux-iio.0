Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255481D6DB5;
	Thu, 23 Apr 2026 18:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776969150; cv=none; b=L8W091SRjNQ8ItZ2uzkzy5E8kZawdjSVj/dEZV1nZpHJY1fIjVBHpCb0orsx4oA/OcvXGD7TJnRj8WjBAXNC4TWgwp32A+9FWIX8rVtNOFvn7s7aOuosfEVDi0Z7mu7ZE5FQN6dkKaMzK0W+6f8opo2qTMjJF6RoMwpU+pCS3jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776969150; c=relaxed/simple;
	bh=xMNR1EVp8DA1JogMAcW0BPEsa6ZlIaF6HQ5ThjDNrbM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VdbjBtKG6TYvlpOSQ+b+1MpquYFdVUHED6CliRYlGrLNkGGBmLTWGhu2A34WOrubQO7wPAEno4KL6tb3OEuMv90npwOzQW4stWVBtR8+F3N+e/sZKuGvsXKwx7SOZlYrSGRHXY3qn/e7bKX3Sg/EdxEmvfu7LePgPPql1YXDL7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDQT9NyP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDQT9NyP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86447C2BCAF;
	Thu, 23 Apr 2026 18:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776969149;
	bh=xMNR1EVp8DA1JogMAcW0BPEsa6ZlIaF6HQ5ThjDNrbM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EDQT9NyP42/jKkD3DgsPZckASVOaGRuWvmHUwEd8zD21avaleSollnFkWn4CwuXk+
	 AB8nC98rG6jk96WHsSLpiEE/Z3kd6mE/VQOYlEa/EKdgtuJKwbQ3G6UaiRUBjfnJLL
	 FCt744ufiy8fNlHCXcSTnn5B6mDjQah7GA10jg2Gwd5M9eMvJrBloP2BNevcV1cJa+
	 X2wLGIyoku9I4+s7lnOT6yh0WwZhBEb3iB5xSU9dBT0hqrJ5k8SqxJnHMGIjTRqKmO
	 qbmCNuRtIDXr5IYlrQhk8yITExD4+fK0hGiuQ5YBuQ0Gt1b/PEMVLRCadUtsuim9zH
	 3gLIywxHXY/lw==
Date: Thu, 23 Apr 2026 19:32:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Auchter
 <michael.auchter@ni.com>, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees
 Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 00/22] Extend device support for AD5686 driver
Message-ID: <20260423193219.5a4c6e26@jic23-huawei>
In-Reply-To: <aekvUKh2SoAaLKW6@ashevche-desk.local>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
	<aekvUKh2SoAaLKW6@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Apr 2026 23:28:00 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Apr 22, 2026 at 03:45:34PM +0100, Rodrigo Alencar via B4 Relay wrote:
> > This series adds support for multiple nanoDAC parts, adding triggered
> > buffer and gain control support to the ad5686 DAC driver family, along
> > with a number of driver cleanups and fixes.
> > 
> > Initial patches update the device-tree bindings:
> > - Add compatible entries for missing and new parts;
> > - Add GPIO properties for RESET, GAIN and LDAC pins;
> > - Add missing power supplies properties.  
> 
> > Driver cleanups and fixes:
> > - Refactor include headers (IWYU);
> > - Switch to device managed mutex initialization;
> > - Drop enum chip id in favor of per-device chip_info structs;
> > - Fix voltage reference control on single-channel devices;
> > - Fix powerdown control on dual-channel devices;
> > - Introduce bus ops struct with a sync() operation for batching
> >   bus transfers.
> > 
> > New functionality:
> > - Device support for: AD5316R, AD5675, AD5697R, AD5313R, AD5317R,
> >   AD5674, AD5679, AD5687, AD5687R, AD5689 and AD5689R;
> > - Consume optional reset and new power supplies;
> > - LDAC GPIO handling (active-low, held low when unused);
> > - SPI bus sync() implementation for batching multiple transfers;
> > - Triggered buffer support, leveraging LDAC and sync() to flush
> >   all channel writes atomically;
> > - Gain control support through the scale property.  
> 
> This is rather long series. Please, start from the fixes series first that is
> independent on the features.
> 
> I see here ~3 sequential series. Can we rather do them this way?
> 
> Personally I stopped reviewing on patch 12 (without even opening DT stuff)
> because it's exhaustive. Documentation usually suggests the series to be
> limited by ~15 patches IIRC.
> 
On plus side this one was easier to review than the RFC that Rodrigo
has outstanding so I reviewed this one instead :)

Better split up though as Andy suggests. I'm less bothered than some
about merge window timing, but a set that does 3 different types of
things is never a good thing even if they are all on one driver.

Thanks,

Jonathan


