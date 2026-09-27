Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C0B3B9950;
	Sun, 27 Sep 2026 19:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790535932; cv=none; b=b8JHOowJPQ9VRnM+HUSQspcrEeJvqZi6a2bs+u/bbqEqTbjDGZmGZzQK2Pl7e7NDWERzqVz9qfA8kob6tfSpoc2/lm6VfCXcVWshsk2QTbqmuOdoIFJlOzsTrsaWPGeaCVq39xk19SikKIPC8cPZmxIx0OHkuNA5LS7esHUJgYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790535932; c=relaxed/simple;
	bh=6CAMfyRZCm6lDCb6W+DVkEqZxWjajEugma5smoXX0ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EnHx9MCp5TlERNf6PzZMVEbivsX9LReDwBfY4mva/mYaM2xLiMf+GcSPbKUja8yXg/MF5pCrC+LCIIbikQwQ7UkD70GC9yTQ7WcI/Oi//ch1JnRpkPg2Alphbku/9oJmfOIVrO+3lXU3NKZaoJmAG1qPoTgAvUkJxhMSKEwC+8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEBoP15M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEBoP15M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3881F000FF;
	Sun, 27 Sep 2026 19:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790535930;
	bh=TZKrMRTUsVfAT6yY8QlJPs2wT7+7wG4NWDcxvmTQn18=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MEBoP15Mgp67vKjrqpI2TQc3ZmlYbA6fjiPKPck9+/TTT2lcf6ePXhEFkBxZKoiPg
	 tHCxkFPzt1RW6v7TcjCO2OzoT47mMCQJUqymQh4kbvVRXcKB2OzGlQ20CRdcNTMvU0
	 khIZetHkZ0BhwsTzlspe7FTHlUFqJBO+e7SBDg5rsbLvOTAMha5OPuUhnQ1YKkPLHi
	 YPqYmUjMHO3qTb6F1A1hWC7Ujk9BULdltAfsczV6lJPAJFcZMIKyWnIxAprT8ygNoB
	 6gt/bh2nmH/aDIjAHTEvxMZtlCcFNOfFhRJVRIOe2iLt7ZmaJkXE1WIK42h5EZC5pl
	 YvAQKs9C9mnqQ==
Date: Sun, 27 Sep 2026 20:05:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: gregkh@linuxfoundation.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
 linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, joshua.crofts1@gmail.com, error27@gmail.com
Subject: Re: [PATCH v3] staging: iio: adc: ad7816: Protect sysfs attributes
 with mutex
Message-ID: <20260927200525.4b31c449@jic23-hlaptop>
In-Reply-To: <20260923110745.3836-1-abdelnasserhussein11@gmail.com>
References: <20260923110745.3836-1-abdelnasserhussein11@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Sep 2026 14:07:45 +0300
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

> The sysfs store functions modify driver state that is critical during
> SPI transactions. ad7816_store_mode toggles hardware GPIO pins, while
> ad7816_store_channel updates the internal software state
> (chip->channel_id).
> 
> If these are modified concurrently by userspace while an SPI transfer
> is in progress, it could corrupt the hardware transaction or cause the
> driver to communicate with the wrong channel.
> 
> Add the existing chip->lock guard to these functions to serialize
> access and prevent these race conditions.
> 
> Fixes: 7924425db04a ("staging: iio: adc: new driver for AD7816 devices")
> Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Applied to the testing branch of iio.git.

Thanks,

Jonathan
