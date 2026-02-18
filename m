Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4A6346FDA;
	Wed, 18 Feb 2026 19:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771443591; cv=none; b=HZP5Bl55AQ6GqtBzbX6mzTBHbbfWZ5RZOF5LRkOsy5UCxx1l/1zmRQGFBIG4+WDed37VgnHKew8VYNPgSHJUuYtPDQZkXGeYev+YHJZ2zpyt6SsHoZ453wJXGGacaJIRLKbM3Y9DT0q0usePVxb80G/HQ34LAfc2GgIE3+6ZQpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771443591; c=relaxed/simple;
	bh=D+sEqreT8KH5MvuumZ7pq26QX38YMqgmFXHC5MpUHIU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OVUYC9PGjNuL2+Ku8LF4ZkXxadlc5wT0IGWUrPKSJgVYJcHfvgypKr0J4QzE/Kpf10df9yNojIy5Vua5p6f53eSL85XcnGcRPMWahHMt471SOot1+LhkHXs5bq6/oDr75QWFHCNclSgjKvXQRX61gjQJ2GbyEY9wvI4/jdaNIyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RI+hyUgq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RI+hyUgq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B24AC116D0;
	Wed, 18 Feb 2026 19:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771443591;
	bh=D+sEqreT8KH5MvuumZ7pq26QX38YMqgmFXHC5MpUHIU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RI+hyUgqI5cailj1bpFIIXs3zptVPHPX93Xkr5Re4wSoXIbRLMHjD1aXMwKbjKs+B
	 mTiCFNEElZy8jB3/lGLMeqqbGycz97SV30exS2xB0bRGwJdsvVz8QpEs0tUS7HadqQ
	 6XV8TTrPIoa8ALF3yZ3RQ22OYVirOye9ACou8eRzXmz82R2plyhgC4qKdBBaDB1+f4
	 C3Di2Z9/fv8xVrwfBt0LMQZ3G/HMSIMSgvnN2/KQXZ1Z/7c6FlOmu3o23atMYzQzH3
	 CpwM//95xUMlqGIuiE18JZ2zmfEtgkEP6UFCB+zob/w9FnW+qxKY+0ShKMUSBVCLhP
	 X/xBG9aWgtpbQ==
Date: Wed, 18 Feb 2026 19:39:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v5 0/2] iio: light: Add support for Capella cm36686 and
 cm36672p sensors
Message-ID: <20260218193942.192faeef@jic23-huawei>
In-Reply-To: <20260217-cm36686-v5-0-63c2de9709d8@gmail.com>
References: <20260217-cm36686-v5-0-63c2de9709d8@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Feb 2026 14:13:14 +0200
Erikas Bitovtas <xerikasxx@gmail.com> wrote:

> This patch series adds support for Capella cm36686 and cm36672p ambient
> light and proximity sensors.
> 
Series applied to the testing branch of iio.git.

I'll be rebasing on rc1 after the weekend and then pushing out as togreg for
linux-next to pick up.

Thanks,

Jonathan
