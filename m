Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839A62BD58A;
	Wed, 13 May 2026 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680393; cv=none; b=qlazr5GV9WpIEi2Ojbz2DGcAV+m+QKP9xGETNJhNFCkaeaaBcJge1gPjlI28EAWvK73BMjJoYV0n3ynJDc4btYvx7a/DuwMaxi6UfbGD7+yVeJ9TynUDt6HXupVSZg81Qs2epItkkwTRnDm3uLvfSz1ejKCemqFM3TK3YTE7wio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680393; c=relaxed/simple;
	bh=vboSbNrhRoqpwhCEDdVvoJxSw2POTG5BmRbeyr6o4VY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IbTOOOl9QiKuKQbskR6NB/ItWzA9fsCKkFU2ObyR0V5FJVu614pvXv5M1YDDjk4h1jbKzYBHgtTeeg0Zb53zJ9gYbG/j6CUyu2T7oqhOvwgmhv9RPBrl1FrqEBIjXZTcJdfD632BhEGJtZ2xoTS9aOJYJqYaVZZvV/7L7LlDfa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTNKAIBk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTNKAIBk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30095C2BCB7;
	Wed, 13 May 2026 13:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778680393;
	bh=vboSbNrhRoqpwhCEDdVvoJxSw2POTG5BmRbeyr6o4VY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GTNKAIBkIXuP1UZacQ3v4jPyQXH2SdW/3YmEtUUU6GFKwEzHnJdSFeXI1PhulfTK9
	 ov7ztaqGpNo9EldG4Nl+Kzsl6GNzsoB3b/EdxxQZtMaPDBXWEtUDg1E4Bfd+jpH3Iy
	 F08WTE6Sop4lRBVC1YWBs4PPuX1u+MRSBR1nkOsl9A9TjclBBKgvZR3DG2HMzLDUKB
	 0KcfEWZkEaFfHl05tcnkWJPcIFyOpadHMiBQlX9dvZtcQmy27OcG6FIRz50kgaUTfn
	 9SPXpYHiS6/IQlQJqCHvaOYFZdVjmNVpTX1OaCIUmBsaC4f7ZGp5y/hLUHIemFzIfP
	 tVnmoTc3wrZyw==
Date: Wed, 13 May 2026 14:53:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Greg Ungerer <gerg@linux-m68k.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Steven King <sfking@fdwdc.com>, Arnd Bergmann
 <arnd@arndb.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Greg Ungerer <gerg@uclinux.org>,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 08/11] m68k: stmark2: add mcf5441x DAC platform
 devices
Message-ID: <20260513145300.11b4fdd6@jic23-huawei>
In-Reply-To: <20260513-wip-stmark2-dac-v2-8-fcdae50cf51a@baylibre.com>
References: <20260513-wip-stmark2-dac-v2-0-fcdae50cf51a@baylibre.com>
	<20260513-wip-stmark2-dac-v2-8-fcdae50cf51a@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 May 2026 11:14:32 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add mcf5441x DAC platform devices.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Looks good now.
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
