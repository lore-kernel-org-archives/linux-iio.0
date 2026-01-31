Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F672472A5
	for <linux-iio@vger.kernel.org>; Sat, 31 Jan 2026 18:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769882862; cv=none; b=f+Pcp2URszrTxAhbGzamTgY/At+GVhAORmqGtW4Phy/kSThJwr1CLt4cLx/XrBc8FUpZNBqYQu/bYWT/bQkf/jpYwxNQ0f9FH068c3+u0Cq/WIqjFYd5m6zTiKKqqbeCZWo9S1/ZepUkGrILEEGTr47VrNtnNh3oNb8BPcKsngo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769882862; c=relaxed/simple;
	bh=YCCpD0QHjOKimy7w+T9Zn9FY4hzBeDKWEFv8yf62MeE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DbggPmszS1lUDlUjnkY/00uw1QIVFmZmSwK0raWH8IL7ljZDPW5Od/K71FB64AvscmJtFohrP3Tabe8kWFpB8ySEzrL+U4GY16K25CbxEciK4GgMoPgbo165iN900GlC446XkFf6XcMrUlV+xydQZX6+qSS4ZGYOBfKU8l/kcJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVda+sg8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVda+sg8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1346C4CEF1;
	Sat, 31 Jan 2026 18:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769882861;
	bh=YCCpD0QHjOKimy7w+T9Zn9FY4hzBeDKWEFv8yf62MeE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rVda+sg8LOGff/Pt46lqBiDCK1IzW5MZ1ciT05EThmiQhq5dr2Kk3yd195hO6p0t8
	 +tpAf/426RjORXiqYuCIBlE6YxENzWne5Iq1l/+Uf0fCX1v3fM+5bXcdX3P8M5mquf
	 KRKeGaoUHI/oqHZKcVeHujqnTGf2K5f8+Mw3imQZljhaAyMrbN4OrK6y4+XpjAfw6r
	 DZVMDQ0DFVnb5X5S/5GuKoqbEqHzRA+Fvd07GILjCXNUhQCMgGOygcLKEP8ODa1wVT
	 m0ekdux09UZO+8Dada3LCAAnQpRD+sTPIZWsL6V9JRKNO3SrvpqfQ1wtMeSjwqXNt6
	 HLBu2wCljyf/w==
Date: Sat, 31 Jan 2026 18:07:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Menderes Sabaz <sabazmenderes@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com,
 andy.shevchenko@gmail.com
Subject: Re: [PATCH v4] iio: dac: ad5360: converting to guard(mutex)
Message-ID: <20260131180734.7fa27509@jic23-huawei>
In-Reply-To: <20260129164610.81917-1-sabazmenderes@gmail.com>
References: <20260129164610.81917-1-sabazmenderes@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Jan 2026 19:46:10 +0300
Menderes Sabaz <sabazmenderes@gmail.com> wrote:

> Converting mutex_lock and mutex_unlock to guard(mutex)
> 
> Signed-off-by: Menderes Sabaz <sabazmenderes@gmail.com>
> Reviewed-by: David Lechner <dlechner@baylibre.com>
Applied to the testing branch of iio.git which will be rebased once
6.20-rc1 or 7.0-rc1 comes out depending on what mood Linus is in for
naming ;)
