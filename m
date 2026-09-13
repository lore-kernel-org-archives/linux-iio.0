Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC053515F2;
	Sun, 13 Sep 2026 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789330295; cv=none; b=P7/8GZPSnjf4KC9vUHkoDgNM686xBKUb+YOIDAH3CxYRCUjRsXtgls/hblMY5HAemjX9jwbmkbJdDPM0GiJUXFpWkII4H2KO+eno9Jcm0ncgHWVSY5b29FTdPzOqYCzER04YNLAh3U8YFklHKiaQRuLCgDUEuA8p5N5uVctVxWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789330295; c=relaxed/simple;
	bh=bLHIBZ4Anrsy4NBr3TpyisAHLtC3UYo2xSGvZAWpK40=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nhz92vbQzpA3yD9VW0DTzVKwNeUh6UjVTlGYDKMAfyBQBLykysN0qqKqsJmbmDNz1t8AqL9xzKNwlpALBG8ANWrlvRqzq/4HvcFlDIX4XU3CbQWKqxv8VeuuxQ2dKumSSfMf2F7d77UQ1C3d5Ag6959Diso/rDNFNs6apPGxPkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzbKIWnT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzbKIWnT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150351F000FF;
	Sun, 13 Sep 2026 20:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789330293;
	bh=+bfWXLVb1BqU38UVjIC2M30Ibm2m4TPPOeGudbFnPWg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CzbKIWnTbe2HbwUknXVXYm9CkLezLduqiWBbI1uZfp6cE5TkW0TzwmDpWoEm86Ebw
	 QdFKjk6ALJ/RHD33T3GyTn3S2fV8fcR7YSnrl2Sg2aca0diEyxji80aeBGOiZKxpkG
	 gkKWMM50NeGTcAyMxq4cPaXnD/bz8HPAiF1N3BaoQ+Jjmra+Lmt8Gtoe6Mp2wYbvcd
	 dpFacxPbo7p7po6E2P8g8IZCM9Tk0K/lyZIbF4d9vbjwaErefB3/zNqGSs+o+1+WpV
	 d5AUbeeTHvjBMJExfsBq7LSZJpJICsQaEPjHz3SHCvdIqk0/VImvroyzpubeJrwstr
	 BOvvxx00QVCIQ==
Date: Sun, 13 Sep 2026 21:11:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Chris Hall <c-hall@ti.com>, Patrick Edwards
 <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/10] iio: adc: ti-ads112c14: add settlingtime
 attribute
Message-ID: <20260913211128.25734544@jic23-hlaptop>
In-Reply-To: <20260910-iio-adc-ti-ads112c14-filter-support-v3-9-e5a9b27ddb1a@baylibre.com>
References: <20260910-iio-adc-ti-ads112c14-filter-support-v3-0-e5a9b27ddb1a@baylibre.com>
	<20260910-iio-adc-ti-ads112c14-filter-support-v3-9-e5a9b27ddb1a@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 16:13:08 -0500
"David Lechner (TI)" <dlechner@baylibre.com> wrote:

> Add per-channel sysfs attributes for settlingtime and
> settlingtime_available. These allow adjusting the total settling time
> for each channel. The value consists of a fixed t_latency time (based
> on the selected filter_type, oversampling_ratio and sampling_frequency)
> plus a user-configurable t_delay that determines the value to write to
> the DELAY field in the registers.
> 
> The allowable values are non-linear integer multiples, so the step size
> is just the smallest step size. Writing the attribute will match the
> closest matching value for the DELAY field with a time equal to or
> greater than the requested settling time (unless the requested time is
> larger than the maximum allowable settling time).
> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
Hi David,

I flagged a couple more sashiko comments in v2 that are still there.
I was expecting a reply to that v2 thread to reassure that they
weren't relevant.  

Anyhow I'm not going to hold the series up on those (at least to
get it into a branch 0-day will hammer) but please do take a look
and shout if these needs more work.  This is mostly based on you
having updated for one of them which almost certainly means you
looked at the others as well.

Jonathan


