Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBC320E702;
	Sat, 21 Mar 2026 13:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774098595; cv=none; b=Xtgb5VrqwOYNaK7557LnPNEf/4enxEuv+QxUNE0Iwkjy7A3uBm7RVXyl2lhWwO+t67wjqFNCsIgXX7dxKgZl13sUxiVjEagpOp2Pwxi7QvmiY2QW8glxoDDeHLbHqOTQqxqrQHLDgkQc7b7reQGHQTtm2ZS7sMGZvF57mGQXtg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774098595; c=relaxed/simple;
	bh=9C0fbFFwhL6ErZxv4M2vm9MsYbFSgyGzOaAeWsE6+kE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c1UDVFGZT1D5g57Tiqs6eOgTU5m5Th3KiFJD9CXNIYqAmsZ75gG+IxdTOoRQo62fuPHDq8HapWmUtAcNjymDpT7XpOCq6+I59+K4R80PBBHnXNjMgRB5KwWWObCp/bjqSxcQ4DgKIRgmMSZWa2/DC7K/E7Pr3ae4LnZytuRTM2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uhkak+/l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uhkak+/l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E993C2BCAF;
	Sat, 21 Mar 2026 13:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774098595;
	bh=9C0fbFFwhL6ErZxv4M2vm9MsYbFSgyGzOaAeWsE6+kE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Uhkak+/lGWG7vL0l9qKhM/S/Ge64IE7+x/Oow9YrmKBWS/P/YGwJIuVKA9zno0tHT
	 3xpCkguUaJiJ/f0wBW9+0F7HEM7LTHr9Eobb0lvrcM2Gf2lZu041FqR91SksPiqYGM
	 lJyF3Nk8Dne97vm8zNb/9PFocBHdGJuyX/7J8i6+79Me77lK3LMwQSjUe7yenPjef5
	 olcWCmqcit7/6Z0bFz05wKE3iUZUe43Ooa3LNSANGMU51vSTZsbQuSZSEEb8GUpIAJ
	 TqcE4lxGXcNF+WFLFT9HIhjFAQh1mbNBxc/kDJNQDdbXai12DntH/FjYBiH7LLoD7C
	 RLM7VPSqOoPKQ==
Date: Sat, 21 Mar 2026 13:09:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Rondon <grondon@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 gregkh@linuxfoundation.org, andriy.shevchenko@intel.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] staging: iio: ad7816: use sysfs_emit() in show
 functions
Message-ID: <20260321130945.18fdd79b@jic23-huawei>
In-Reply-To: <20260320222424.53294-2-grondon@gmail.com>
References: <20260319225719.73587-1-grondon@gmail.com>
	<20260320222424.53294-1-grondon@gmail.com>
	<20260320222424.53294-2-grondon@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Mar 2026 22:24:22 +0000
Gabriel Rondon <grondon@gmail.com> wrote:

> Replace sprintf() with sysfs_emit() in all sysfs attribute show
> functions. sysfs_emit() is the preferred API for sysfs callbacks as
> it is aware of the PAGE_SIZE buffer limit. No functional change.
> 
> Signed-off-by: Gabriel Rondon <grondon@gmail.com>
Always worth a quick check to see if you are overlapping with a series
that might be on the list or already applied.

In this case:
https://lore.kernel.org/all/20260301212819.98597-1-ehanoc@protonmail.com/
