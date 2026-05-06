Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F562F1FC9;
	Wed,  6 May 2026 17:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778088146; cv=none; b=CMAwS4ZnNOwHLtjowMIbx/+3pk3enGOCjA6EpYM/HvFFOVsyf7fjyCEAdTQl9ulMB6R8JO/VAYKxyt44ESKwZZJrN5Z14kSELw/rrNSZ+rEDCF3JOkG3Qgy8mj6S0ItbtcV0BY0rqnAIjuWdzQ1mzG5vLK9gmUAqk4MyS0f0qaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778088146; c=relaxed/simple;
	bh=xSHJ1q1Cx6lfALXqZAlJmpPFVFlNNbgRPnrDNF1rxRc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FULrP5DeyvnHelIWqPacY1b1u+Ncb4pBUDE7l+QCTyAvdNCvRCo9cG8OIHePo20ZbkQxx7Z04An3NOVkbPpAyxkFuTbUb3kALaH9yI4iHVpvcSgTJElc2rPsQISb7N1C3r6GfXoKDaed1zy5osF8J/F/ziYNOfGx7pee5VIhf+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZ6n1MWY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZ6n1MWY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46DC1C2BCB0;
	Wed,  6 May 2026 17:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778088145;
	bh=xSHJ1q1Cx6lfALXqZAlJmpPFVFlNNbgRPnrDNF1rxRc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VZ6n1MWYk5rlgQ833fmGOHrhCyXhEkJ1BPebBsP2QHBHPwkIx/DgcuSO1qCrlcJqu
	 3mb0a2ujxqmydh8XOk4a82QmE9d+ipG+1nbRBfvNHBtaf6Fjg0Kxax2PepELYRNexp
	 VzgvzlJExqOaSnNdklNOB6kp48MCKxvREGS1N7kTS4B0bY5sjyavxXtY+tp2T1v6Br
	 zaV4OYHinpJ3OgkjxTuu3+N5Kg+yogFa7Ts7wPvd9yBaIYITSqZuLNKoaNRQLFZSbc
	 Bm2w20E/del1vi++0x0Z9zLt7qjON0ySNR87kJJG5AsyfXK9J0dYnY2KAeSYv00Ds+
	 wdC9k00TuoKHg==
Date: Wed, 6 May 2026 18:22:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
 Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>,
 Michael Auchter <michael.auchter@ni.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v6 04/12] iio: dac: ad5686: fix powerdown control on
 dual-channel devices
Message-ID: <20260506182215.5c15288f@jic23-huawei>
In-Reply-To: <20260505-ad5686-fixes-v6-4-c2d5f7be32be@analog.com>
References: <20260505-ad5686-fixes-v6-0-c2d5f7be32be@analog.com>
	<20260505-ad5686-fixes-v6-4-c2d5f7be32be@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 05 May 2026 13:35:05 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Fix powerdown control by using a proper bit shift for the powerdown mask
> values. During initialization, powerdown bits are initialized so that
> unused bits are set to 1 and the correct bit shift is used. Dual-channel
> devices use one-hot encoding in the address and that reflects on the
> position of the powerdown bits, which are not channel-index based
> for that case. Quad-channel devices also use one-hot encoding for the
> channel address but the result of log2(address) coincides with the channel
> index value. Mask as 0x3U is used rather than 0x3, because shift can reach
> value of 30 (last channel of a 16-channel device), which would mess with
> the sign bit. The issue was introduced when first adding support for
> dual-channel devices, which overlooked powerdown control differences.
> 
> Fixes: 7dc8faeab3e3 ("iio: dac: ad5686: add support for AD5338R")
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

The rest of the series will have to wait for these to be upstream.
If I ever catch up with reviews and tests are fine I'll get a pull
request out in next few days for that.

Thanks,

Jonathan
