Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E082882BE;
	Sat, 16 May 2026 10:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778928326; cv=none; b=VW5eSxDfYyjIbMao0VKUiHI9IiGCwE2EulyyvFrkE/ViKYxl4CzDrEjDamqlWmuKij1KdhVhbJYB10B6yaXUffZz6kefZc2ztiq2t0I4vWfiGAQHDjiecEVseLdH2n2tjvqJNCS6EsYMJxCvx1m3NvZLzsCcvwsJ3KZdjDaeKYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778928326; c=relaxed/simple;
	bh=kFNVfFjqtqI01l7tj4dNGP/g8LTS4h6Kf7NMmv+HM1I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jEQK08dMK/GG5Tj82+ieYGaf8pkKbhmWpDcKnpbYl1JvreycEqxQg9zVfxUfNXbkmUY4zvWu8J3Q4TXXCTJI72yHffknBsF/KozkBb0S2fjEn/LHtlvElJIVrVgL2V7vbybEJnYGdA/lH63uV4BAqipD/uNkN8/rMRWARIXLf4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyXFgB0P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyXFgB0P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271C8C19425;
	Sat, 16 May 2026 10:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778928326;
	bh=kFNVfFjqtqI01l7tj4dNGP/g8LTS4h6Kf7NMmv+HM1I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RyXFgB0PT0ncLVyVxWjhHf9i3mlAqlrT6hEgVdAZmySYm3qbLADGja85vbPvuBJ1w
	 GmnIl1XuM8biXnGUawSpm0E+/tGVH3SnLOS5T8oF/sZxcPq45HbvT38tchzsqMCSzc
	 pcdoHv+iAwgQpIhCyKPJ8bHbbe50IreyRCRYsL2tCYBSTj2guup3QVc/GBg4EzdO4+
	 GTCeHoFNVBTDL93lZ2iInD4wyQyyoXu1Z1Am/eOJHDaO7YdxRnhhJcShkdHi0Dn9Zz
	 /93LdNNfIE+sXUllQpcFDjkEjsNIqj9WK2Gb79d0RwHIslx+dmfzTwNwVWWXcvZ4Mz
	 30SbDcQj9Nm5w==
Date: Sat, 16 May 2026 11:45:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 gregkh@linuxfoundation.org, hcazarim@yahoo.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: bmg160: bail out when bandwidth/filter is
 not in table
Message-ID: <20260516114517.46c9e99b@jic23-huawei>
In-Reply-To: <20260513081251.1781-1-sozdayvek@gmail.com>
References: <20260510023500.61036-1-sozdayvek@gmail.com>
	<20260513081251.1781-1-sozdayvek@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 May 2026 13:12:51 +0500
Stepan Ionichev <sozdayvek@gmail.com> wrote:

> Fixes: 22b46c45fb9b ("iio:gyro:bmg160 Gyro Sensor driver")
> 
> The set_filter() path is reachable from userspace via the
> sysfs in_anglvel_filter_low_pass_3db_frequency interface, so
> userspace can trivially trigger the out-of-bounds read with a
> value that is not in bmg160_samp_freq_table[].filter.

Thanks. Applied with both the fixes tag and that extra bit of analysis
added.  Also marked for stable inclusion.

Jonathan

> 
> Stepan

