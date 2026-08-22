Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EF02EEE65;
	Sat, 22 Aug 2026 22:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787436859; cv=none; b=YEK/YUl3iVtTUN34OTC5kYI0+Q/y9YaWymlcctgnnOIC4TDomss24zFubdJeQarwLc6LaJcxPjl/rCwpZSaJhh27Pyo+i5eN+OWHqtnPeY3VHwylr5+nXbxAnZpQEsBMfMHSyD408Z85lMORojmrC3zLvtv5yZZOPeQXX3kIjcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787436859; c=relaxed/simple;
	bh=DREBep/hE3rOBeFy0DIXlbZgKXk0OFYf6eXCrpJXa2M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ESRs4Cleq4+qUrN42kK5df4LxRicQHBZueiNEgofTeY5008ZLIOoQ1NuXcWPMHFCCAwM1O7+Dlqjo/hlR5aIoDYdQpaiJjzD8o79KpYi3xWlBNjrvvXkb/A6A3439d+N63b0SocJPlW/BihKDzClJ3DYjzKY0CvjxTa/xjgAq7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxUgT6rP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxUgT6rP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBF61F000E9;
	Sat, 22 Aug 2026 22:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787436857;
	bh=nZHq+MLsjuQEEdw7GVVHv+dEFrQTQrY6Vsu8OiJHI9k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TxUgT6rPqeeofFi2y8OmjjzoHOhNPMMcXwIW1CR8cO7YHk/BAYRqYISrQamHyB93m
	 srM37V4l5wNtj7tXjP5S6JR9jRZNK7GDhw6mXgPoXd2+g5U08bG5iD1m51jslfBK4c
	 2/wPUhF9YFXu/jJWLpYQbmalwiDuYxsqwYDj7ABOaKlKvwawVKoLN3QQlNLmMuiqMn
	 AQznqB1NLgo4vsE4pTWlMohWBH1HOk37QWNisnPbwP2eavb+8XgXekojk/xCwFaMeE
	 /LwabSWxph+kwzTf0+kNghPAyPKzgffGdsQGIZonA/o+s3cWbEZibD1U5lW6LnMDDy
	 TYMVUkRmUgLKw==
Date: Sat, 22 Aug 2026 23:14:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Rondon <grondon@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Stepan
 Ionichev <sozdayvek@gmail.com>, Maxwell Doose <m32285159@gmail.com>, Yash
 Suthar <yashsuthar983@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] iio: accel: bmc150: fix event-enable race, then
 use guard(mutex)
Message-ID: <20260822231413.6f09cc09@jic23-huawei>
In-Reply-To: <20260816234231.14168-1-grondon@gmail.com>
References: <20260816234231.14168-1-grondon@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 00:42:28 +0100
Gabriel Rondon <grondon@gmail.com> wrote:

> This series addresses what came out of the v3 review of the
> guard(mutex) conversion [1]: the pre-existing bugs had to be fixed
> before the conversion could go in.
> 
> The unaligned-timestamp / DMA-safety problem in the trigger path is
> no longer part of this series: it is fixed by Yash Suthar's
> "iio: accel: bmc150: DMA-safe buffers and use
> iio_push_to_buffers_with_ts()" v2 series [2], which this series is
> rebased on top of.
> 
> Patch 1 sorts the header inclusions (suggested by Andy in the v3
> thread) so the cleanup.h include added later lands in order. Patch 2
> fixes the event-enable race in write_event_config(), where
> ev_enable_state was checked outside the lock. Patch 3 is the
> guard(mutex)/scoped_guard() conversion itself, now applying on top of
> the fixes.
> 
> [1] https://lore.kernel.org/linux-iio/20260525110130.61284-1-grondon@gmail.com/
> [2] https://lore.kernel.org/linux-iio/20260815175728.99541-1-yashsuthar983@gmail.com/
> 
Given I've asked for some changes to Yash's series, this will need
a rebase. So I've marked it as changes requested in patchwork.

Jonathan

> Changes in v4:
> - Turned into a series: prep and fix first, conversion last
>   (Jonathan, v3 review)
> - Sorted header inclusions (Andy)
> - Fixed the ev_enable_state race under the lock, with Fixes: tag and
>   Cc: stable
> - The unaligned-timestamp problem raised in the v3 review is fixed by
>   [2] rather than by a patch here; the series is rebased on top of [2]
> 
> Gabriel Rondon (3):
>   iio: accel: bmc150: sort header inclusions alphabetically
>   iio: accel: bmc150: take the lock before checking ev_enable_state
>   iio: accel: bmc150: use guard(mutex) for mutex handling
> 
>  drivers/iio/accel/bmc150-accel-core.c | 92 ++++++++++-----------------
>  1 file changed, 33 insertions(+), 59 deletions(-)
> 

