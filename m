Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F79378803;
	Mon, 20 Apr 2026 17:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776707329; cv=none; b=R04aFxvVnYkobFeFIvKriqRVnRSS6D742bEA63mFm9an314Pm5EwK766e0UL3R4mnxrubrANZZkokrlQ9jPpIRS7NyZxbQHQTt4DEKmgpEAUtchLZKoe69x8SNIC3qL3ap7TnN/aoQlBbwTT6T4xXRFx3FwW0gKHVBhXO9cyrb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776707329; c=relaxed/simple;
	bh=8dAhoJj+XWifRzYfbUJkR3J4rnTxtjMK2Ayc584/x28=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YKX80rQzs1oKvFFy1p0C1IqdO5BRuFLy3RX1fqVCpFqT/AiN2xiSymOL9vQ6OVDTdongkQ9Kdgmvon+B38z+hr6Bwufn6P6t31foEgyoqdTq1T2G44fXETV4iR+BZhLMptYWMAMzq0TO/epPE+mTwFWprzmkLtuo9rBk7PGDSCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jezvRzLd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jezvRzLd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749DAC19425;
	Mon, 20 Apr 2026 17:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776707328;
	bh=8dAhoJj+XWifRzYfbUJkR3J4rnTxtjMK2Ayc584/x28=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jezvRzLdxtj8jFR5SRtO328o0qBVVNe8PaF4SGmpSCWN9hrLZLGv0TZ6VKSmIhTaG
	 8YwgB7TcWFeuUnWzbXt7qIwU0njQVgmzepyCGmVMusCzPD1Pw+UO2VgdoBqof+KzwV
	 4o/3W7m1BPUx+85rvzcKgbLKMvc7UUCDgyY4nAJb6hlwPu7+Ta2aQQ1FhugAeQiXS4
	 OCN7lIWTuC/74AIe5FoRvfXxSU/r30PC3c5AX2CURLiP2DKlmNeGOXycOHSUqD85Zr
	 XCJ7Hioubb4L4jWrMU1qoB0SYUf8BKzuwB37P0CkkXnSlMyZSds3Cgq0LKMoxtoMS5
	 Syok5KylgyHeg==
Date: Mon, 20 Apr 2026 18:48:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sheng Kun Chang <nothingchang@mirrorstack.ai>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, gregkh@linuxfoundation.org,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 0/3] Move adis16203 inclinometer driver out of staging
Message-ID: <20260420184839.4ab3d9a2@jic23-huawei>
In-Reply-To: <20260401171425.89186-1-nothingchang@mirrorstack.ai>
References: <20260401162458.88110-1-nothingchang@mirrorstack.ai>
	<20260401171425.89186-1-nothingchang@mirrorstack.ai>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  1 Apr 2026 17:14:25 +0000
Sheng Kun Chang <nothingchang@mirrorstack.ai> wrote:

> Hi Jonathan,
> 
> I noticed the existing Fixme comment on the Y-axis channel and
> Gabriel's earlier attempt to fix the single-axis representation
> (v2, April 2025). That patch was not merged.
> 
> Should I address the Fixme as an additional patch in this series
> before the move, or is it fine to fix separately after moving out
> of staging?
> 
> Also, if I should fix it, would it be appropriate to pick up
> Gabriel's patch with credit, or should I write a fresh fix?

If Gabriel's patch does the job pick that up and add your SoB to
indicate you handled the patch. Looking at what I think is latest
version of that I had some feedback.  
https://lore.kernel.org/all/20250421125357.571c429e@jic23-huawei/

If you make substantial changes whilst integrating this feel
free to add a Co-developed-by tag.

Thanks,

Jonathan



> 
> Thanks,
> Sheng Kun

