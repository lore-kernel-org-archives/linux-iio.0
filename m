Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336BE3A257C;
	Tue, 21 Apr 2026 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776783275; cv=none; b=FC2mgbPkpXKBXV4JTtHq0DHKgqydhlqx7baOy2seJvk7kHWomL0FvCGJnXAOhFlwKc479+rgFzb11neHlIAIALZePFM/O314JR/DUR98XTqdYrIK0I775EVjfNM6zgGYUW777Uz3clu217zYw711e22hinPA+AiDBuyUotlFaPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776783275; c=relaxed/simple;
	bh=5jKl8uNO/WW+7Qxm+luGw5/n6QGbni4P1DlLF4vEuUI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=azptsdGh5dxvuVjGxeEruS7mKzGTWI7bLm4DFixf0OIrSIIYT1RjU9nVVZcBf7xqkbZG1yVzbmU2RI4HTqEAZH/acmOyez35x9PeSEofzF5cRqIGBxemXpSVVI0lR1xQmhZ1A7M+28zraX2BF9HoL62LdHDN0sqdAbEQM6nH+yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jk72cN3s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jk72cN3s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D13C2BCB0;
	Tue, 21 Apr 2026 14:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776783274;
	bh=5jKl8uNO/WW+7Qxm+luGw5/n6QGbni4P1DlLF4vEuUI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jk72cN3sdkHmry0XxfbE/n3TkIpQeMiL/UXmmOjtbrdABPkqcdz5PLouo0SE0aFx/
	 QFjzN8TLuhUUJJlxHm5gX5FaRG4iqE30QBpU7rxq6dc+c3RAp6dG9jBjJbzo8EZNwd
	 OK38w5mye9shCUJbom6QbCQ4+zD9AWuT2mG9OJK9pwO70Bd9gHXUVFzRCvwC4axCqR
	 NevqKsvhhgSpUST4TikPnJwoM0G/Q6TAFWVLd2Q1CJ5KecxE7jiZucuHVkhKoWE/T5
	 hnZcOyMWp8yl4JKbJHLYeWO5IJZyGIaWNBCTAPPQsP7r80wjgDDszO/vKSs2w6xtJY
	 Wz8o9hwOpmarQ==
Date: Tue, 21 Apr 2026 15:54:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Kevin Tung <kevin.tung.openbmc@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kevin Tung <Kevin.Tung@quantatw.com>
Subject: Re: [PATCH] iio: adc: rtq6056: add i2c_device_id support
Message-ID: <20260421155426.45043750@jic23-huawei>
In-Reply-To: <aeZekWfdcsSkm4SE@ashevche-desk.local>
References: <20260420-rtq6056_support_sysfs_instantiation-v1-1-483ccee27b63@gmail.com>
	<aeZekWfdcsSkm4SE@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Apr 2026 20:12:49 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Apr 20, 2026 at 08:52:52PM +0800, Kevin Tung wrote:
> > Add i2c_device_id table to support legacy I2C instantiation.
> > Update probe to use i2c_get_match_data() so device data can be
> > retrieved consistently for both OF and legacy I2C instantiation.  
> 
> Maybe someone finds this useful...
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Applied.
