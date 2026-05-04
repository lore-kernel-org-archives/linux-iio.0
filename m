Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D120123182D;
	Mon,  4 May 2026 17:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777916258; cv=none; b=H0S+HDOpjkwrhDm9PS4VbACNyVmAW6GpRqx1jGgSgp82EQ24HuJH9818y0wXhTlygYdpcvMHOxwv3f3hna02v/tTF1XCqtGt/LU89j03Xns6WOG3vp4GlNPHYudChpWQ8h6IBQDJ0l97U7a2Poa39OdfhrH/EeH66606vUV+l84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777916258; c=relaxed/simple;
	bh=7qBPJ3imFR2D1N8JXzsRvpkRhiquaOC3EZNB1Nwjxr4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Mp3kY1H8IbGfzEYivkjq4gZlAiv3NdJpcxiYpUDMUM+G3A7amnc7WoE5xgIK8P4ghD9R5fWNYEalbu7AUUaNlECJhF5n6aYocN9L4l+2s5atwdqNISxrZ57540yucQKC7uBVyudkWWgPGlaz1rUwrsyIrxM9T6Tsvr/2FuXYu4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 9BD8215D7F;
	Mon,  4 May 2026 19:29:21 +0200 (CEST)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
	id 8E65215DC7; Mon,  4 May 2026 19:29:21 +0200 (CEST)
X-Spam-Level: *
X-Spam-Score: 1.3
Received: from mail.lysator.liu.se (imap.lysator.liu.se [IPv6:2001:6b0:17:f0a0::3])
	by mail.lysator.liu.se (Postfix) with ESMTP id 2377915EB8;
	Mon,  4 May 2026 19:29:17 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 04 May 2026 19:29:17 +0200
From: Peter Rosin <peda@lysator.liu.se>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Peter Rosin <peda@axentia.se>, Linus Torvalds
 <torvalds@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Wolfram
 Sang <wsa@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Linux I2C
 <linux-i2c@vger.kernel.org>, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update mail for Peter Rosin
In-Reply-To: <afhUW7anAEURM0Gz@ninjato>
References: <7ddc5b09-b6c9-99f9-d951-6b3ef96f8c1f@axentia.se>
 <afhUW7anAEURM0Gz@ninjato>
Message-ID: <e8f64a4f745ebfac9395906f19d1b586@lysator.liu.se>
X-Sender: peda@lysator.liu.se
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP

2026-05-04 10:10 skrev Wolfram Sang:
> On Thu, Apr 30, 2026 at 06:09:58AM +0200, Peter Rosin wrote:
>> I'm resigning from my position at Axentia.
> 
> All the best for your future path and thank you for all the work so 
> far!

Thanks! If anything, I should have more time to spend on the kernel 
going
forward. However, right now it feels like everything is in a state of
flux...

>> Signed-off-by: Peter Rosin <peda@axentia.se>
> 
> Do you take this via the mux tree or shall I pick it via I2C?

It would be convenient for me if you could take it, thanks!

Cheers,
Peter
