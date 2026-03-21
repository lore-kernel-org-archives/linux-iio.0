Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A95261586;
	Sat, 21 Mar 2026 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774108297; cv=none; b=s1g+fmXAPZuAyC1uAFWxfQrrNmYODIfahwVuwpXEPzdypore4dYViboDOifAW9rEOc7rJwIbYCLMWzC0hSY0QrRcPobiXNDypt6fSc8DcdcRxKwcSQJwyPxX6FIZuxG8lXemDl3suJIGUYR0V5Q7QjYlWpWEptgps4a7r2kOH9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774108297; c=relaxed/simple;
	bh=iJK6gXRLy8snWp9xWdLSHDh/M81apV4w9OBDnP6so3c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mApl8A8jFFhWSlwYiR2DcF5TandqHW4BzlIVThUK81Ut9D0AZH/7yxJtk/HFVDTF/xRz6NEvVQuHKlb9GvdE7nffkUVJ6vgmFcfCxRkq2l2ND/BGjGEMaieXDQzCvO6moFBPnTsWnsu6lwsy3/nleEzI+jIzYz/2ZpHuV6DsjG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S615ZWhJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S615ZWhJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C045C19421;
	Sat, 21 Mar 2026 15:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774108297;
	bh=iJK6gXRLy8snWp9xWdLSHDh/M81apV4w9OBDnP6so3c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S615ZWhJmxbdpU+bgacRtU8dgRb16UnPmsyiRB3L6XZW+D+RcW/f/dzvmE92oVsXX
	 do7A2ayfRyx3Gx2wPKf31th8IWvMlFRWxVAhgzm8t2cYvWYEg1Pe5kQZVY3Sfd4Iuq
	 9fwlxfE9ycpiUsNH2c4xej/TemgNxyF+fctZdo35/e8YaGAbKOCobDHUymeNrfykPc
	 SJ5ZD23GsrUVCNhXe7K1tVkg7HrXSmETfmXQWi1eTU/ZLBxoSLPYxPjQH5iAZjT/JC
	 mAHEQOoLvWi07QJYHamGlARrG2vRz6P0MP6FVjMLXL68o8a+fiJGHB3t7n5nChdg4o
	 6RHej1iQmb4dg==
Date: Sat, 21 Mar 2026 15:51:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Billy Tsai <billy_tsai@aspeedtech.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, morris_mao@aspeedtech.com
Subject: Re: [PATCH v3 4/4] iio: adc: aspeed: Reserve battery sensing
 channel for on-demand use
Message-ID: <20260321155127.3e63fa47@jic23-huawei>
In-Reply-To: <ab0ifBMNuY4BwqA5@ashevche-desk.local>
References: <20260320-adc-v3-0-bc0eac04ef7c@aspeedtech.com>
	<20260320-adc-v3-4-bc0eac04ef7c@aspeedtech.com>
	<ab0ifBMNuY4BwqA5@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Mar 2026 12:33:32 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Mar 20, 2026 at 01:46:38PM +0800, Billy Tsai wrote:
> > For controllers with battery sensing capability (AST2600/AST2700), the
> > last channel uses a different circuit design optimized for battery
> > voltage measurement. This channel should not be enabled by default
> > along with other channels to avoid potential interference and power
> > efficiency issues.
> > This ensures optimal power efficiency for normal ADC operations while
> > maintaining full functionality when battery sensing is needed.  
> 
> 
> ...
> 
> > +			/*
> > +			 * After enable a new channel need to wait some time for ADC stable  
> 
> Missed period at the end. And you probably wanted to say
> "...for ADC to stabilize."
Tweaked and tidied up line wrap.

Series applied to the togreg branch of iio.git.

thanks,

Jonathan

> 
> > +			 * Experiment result is 1ms.
> > +			 */
> > +			fsleep(1000);
> > +		}  
> 

