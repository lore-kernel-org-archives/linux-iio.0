Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC3E1DC997;
	Thu, 29 Jan 2026 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769704083; cv=none; b=XVqbRHYnUOd0CXE678euUsu5UfG+8PRKC/WPZOnbsWbU+7CVqxzQq0NyXO/Vkmy4+vybfMp5azsIqAAcoHF3tdRdqN8EeuSMTciRvUrKNfX2IhZAr2nOJ4WKY5mr8O2kQ69K0VEbrg7bLG8HdHnJ5lGz0QJoY3hQRh4joJuttRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769704083; c=relaxed/simple;
	bh=au6rBD3WD7g5u8kFHlS2uHXAl8fgIV9+FiC/rfJ9/4E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MxGBUhYL43S34FRGpVbpbOuLO2myFPfURZEtElfzJe4TuPLeGMRH3iOoayOR7G2r7jOJi3VDMBKg5flVicVKHxxSY1xmrdDxEIMnimqwZyBpJv5lnUrOyFQXn8q4+DaZopusPr0xsdfbP8iJrkZ8oXw0G5ttf3PD46Na1z/1tJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCubv0af; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCubv0af"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33421C116D0;
	Thu, 29 Jan 2026 16:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769704082;
	bh=au6rBD3WD7g5u8kFHlS2uHXAl8fgIV9+FiC/rfJ9/4E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tCubv0afNze1CpMkmRRuChHZsdr3dCn6ApCwAPY/sdA38ch2cHlP/ieHbQyrwBlSQ
	 vtBGF7aKXn9QqifPrG346xjWAyB/4LWIulGTJka28RhtKs02JraRLl2Y2DYQ/D6J6C
	 un5cfU+aYtuv/CvbJYRfJpedXPCCG5qohXiaAMvQw/ibFV0iTlwFj6OFqVFJaS5oe7
	 lysea//JqsmQaGG3bguK3uU071/dTMpHvbbK2XnUElN3tf9ghj7bJsvI7ZuenpTZG5
	 qP2PhQKSAlJ2bKUhh6XfUCaT40YJzTiGSrVXQwPVKXooGyZ1vft5qlX54nm+jJAPbF
	 D3e3R/g6EqT8A==
Date: Thu, 29 Jan 2026 16:27:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: add entry for ADE9000 driver
Message-ID: <20260129162755.76d68a54@jic23-huawei>
In-Reply-To: <20260129144307.118520-1-antoniu.miclaus@analog.com>
References: <20260129144307.118520-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Jan 2026 16:43:07 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add maintainer entry for the ADE9000 polyphase energy metering IC
> driver, including devicetree bindings and driver documentation.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
Applied.

Thanks,

Jonathan
