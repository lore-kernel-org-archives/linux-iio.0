Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF7C3F23B3;
	Wed,  6 May 2026 16:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778086590; cv=none; b=tN/phQZ0IJXFXQfWhnGlot66k1elKeVwlRzdNyu06xC3HQs8h+gnrV50oYa1lkVWiuLhNKvCVHEtute3A7HMQCgDzenOcXlfGde7TFW6aNx3MWJM1iJqtwKbz+rB2/JrQzJ1VdMmE0P4nVK7U/xMJIBao9U6b+5tSi+TGgamQtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778086590; c=relaxed/simple;
	bh=Y+XpoQHqihd6JMWDGuxd+3C+6fmg1AXku9NlwXDLyDU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bt84sjXaI1Odgh8jVAwOYvIv8eZl2gDiUZOaV80fjVaKHVfukumpsf2zfGQ+TNSv4mqxadlnqEB5GpButSGQD9CreR7KctrV4DWF4tKYsVkRkaT29ig5lZKl/YWusMDlyr9/LfzsjsgbFDwwE1dhz5CUbDjBhVZi1RyAC1farCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTGjLTAX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTGjLTAX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0EEC2BCB0;
	Wed,  6 May 2026 16:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778086590;
	bh=Y+XpoQHqihd6JMWDGuxd+3C+6fmg1AXku9NlwXDLyDU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KTGjLTAXYL+0NSG3TgTsKgKqRo1RdLktqxo4XlCvWrd4VhMb0B7VGR1+kLDX2N6P/
	 w6InjHux1wyCdGCES0vo4LJvMGOwHyzrYbL4BLHMaFjD/P2Fw80n8H7bnt5pACXAk9
	 YLAN3avE6WlQZwlV4j5vctJuKzw5mq5LcfYYdERj4brlcIuDPcJm/ovCEe46GTXJ4v
	 CZc634UzF6Ji1Oni2h3lzgRiGEOg4iScbVr37IoWldAWtogNtUELShwrQKByCPLMbL
	 Tq08NSm+iqaduBI2EFNr6egvKu/i935QznPxXBUxeyCQZ1MVW3DFd0GJmh/vTUgphJ
	 MbKuAQVkqyrrw==
Date: Wed, 6 May 2026 17:56:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 11/18] iio: magnetometer: ak8975: remove duplicate
 error message
Message-ID: <20260506175623.2750767e@jic23-huawei>
In-Reply-To: <20260505-magnetometer-fixes-v5-11-831b9b5550fc@gmail.com>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
	<20260505-magnetometer-fixes-v5-11-831b9b5550fc@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 05 May 2026 13:46:07 +0200
Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> The devm_request_irq() already prints an error message.
> Remove the duplicate.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Applied.
