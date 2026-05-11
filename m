Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A27377EA2;
	Mon, 11 May 2026 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778519655; cv=none; b=UoDclH4rFe3jF3MrocA5x3M5+DA6wvOMueKV5aVFFZ5m8x4CjmqqJChNxbAhSGE92wcK3hLLCwr1WHsqkbEZ7Ny6pp8s2thlMbmwAA7ZKHxWxqVbtdwX98kHqT59ErU72N5WmAPep6HrKO2kYq6GKA2SlwNpSy43QhFxWx7y7v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778519655; c=relaxed/simple;
	bh=jOsztDmQOSbCEmI6TigqK5R6hP0bebCyoSBEABSEkFE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tLWCV5jCAYinpWP7YrPDN9R9Q57OUZcAHFnOJwSjGFPNH+6e/U2k+9M6S3MD1Vyav9wvJ6WykbWlG2aeibc866LVMgr9Oz2QJdDYrWTjF7Baz9f8WHCi5uqT3794G4ThIhCeJa40IBno40skjXSOzOpu4M1HLdFQ5ra/jV00D9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixXk9hCD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixXk9hCD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40955C2BCB0;
	Mon, 11 May 2026 17:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778519655;
	bh=jOsztDmQOSbCEmI6TigqK5R6hP0bebCyoSBEABSEkFE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ixXk9hCDXMRhMrpASfcpMZ47Lmh3YsB1ybxqF6HQZ8rh+z69mcNnAE3VBlJ6AkACE
	 B/wj7clEkd+91+AoiAJEJPs82YwvCwTw7lOdzjqte/7yUkalDDwBVepecBteZqtubu
	 HRTf2/T+Li4z1Yfwi2aZts9cviCKCn1Q2e1B1kXzC60T8nRLsY7k/1LQb9gdybmJFu
	 j07b36at60JUzSrVKmphxdB9r5CiKzZNdKJG9CAichUFmAzbrJ6H4GUdTCv6CBZDfn
	 CrMUqRPWBs1aexOY/oNlDtALG4X5rphwX9GOVJs7VGPRpMrU7WQJCK9FlQPMtEZB10
	 786hS0EQvErBw==
Date: Mon, 11 May 2026 18:14:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vladislav Kulikov <vlad.kulikov.c@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: magnetometer: add driver for MEMSIC
 MMC5983MA
Message-ID: <20260511181405.32cb7c55@jic23-huawei>
In-Reply-To: <20260507205033.951990-3-vlad.kulikov.c@gmail.com>
References: <20260507205033.951990-1-vlad.kulikov.c@gmail.com>
	<20260507205033.951990-3-vlad.kulikov.c@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 May 2026 20:50:32 +0000
Vladislav Kulikov <vlad.kulikov.c@gmail.com> wrote:

> Add support for the MEMSIC MMC5983MA 3-axis magnetometer. The driver
> provides raw magnetic field readings via IIO sysfs with SET/RESET
> offset cancellation for each measurement.
> 
> Signed-off-by: Vladislav Kulikov <vlad.kulikov.c@gmail.com>
Looks good to me.  So lets have a v3 with that explanation in the
cover letter for why a new driver and the minor tweaks David suggested.

Nice work

Jonathan

