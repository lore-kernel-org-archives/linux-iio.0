Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67C9423A6B;
	Mon, 11 May 2026 17:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778519212; cv=none; b=czK87RFOkZlD00RU9PQEZnPdihN68NsekR1W8MHb4BQZPXKoOMNCIPuJu+5ul+zXNqR0tC66BVgL850hhoSX9RzDlo232eG3BNePIVjuhkdNRcuqL7EnmzH13n6tMVUUHNU4vhVB+9wTfZiGqYayowfIBc3CUIx1AollY6t/cE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778519212; c=relaxed/simple;
	bh=UYEAGuxZy8eY0JUQFnsUPZwE8vtdKJ0vXGNculTmbGM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VhOdmazewutGW/KsaB5xhabdvIe+t0fVOP36gTlMKiWfWrfQm6sbntCK0AETH0d84LDsVR0xvdyF9MqrybPtMMRw+v5/+3SbvddZtLVquLHzZ7Zm2ImAfIRdkH7ii0XYdw3A/40FOnl9VGS2qqOdke1UPPFWnTURQ24HHYW7qK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTTKJow/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTTKJow/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6FDC2BCFA;
	Mon, 11 May 2026 17:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778519212;
	bh=UYEAGuxZy8eY0JUQFnsUPZwE8vtdKJ0vXGNculTmbGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fTTKJow/V15CLRqiAA07PoGgBvUvp9dxn23774zoBJ7LPRwK1QdM4no6rm65ghKqI
	 GJtn3L9UhzMnMmcITSfw7Nt1W4jYhy6nGTmeFejyvZ+sVfbdcM4N848Vpkmw4Qreod
	 QXvHeO9l+hKUk6kjp4JR/4zffCqQVrFgjk/1Z2yQvGnd2TvfAwL+7/qq5zbdFdVVPz
	 hK8P6T4N5OXNUab5a4MAyc22iitxC7Ra3/ViMAPrl+y1URkAktBBzDDCvOaYigJdNg
	 3GVV+yCkOrJwpBSVc9UXRFAwNqGEvUcMXymC/gdr9swKJR/0eTNMmkYXiwPNBHK1wq
	 dTraGKPmeS49w==
Date: Mon, 11 May 2026 18:06:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: potentiostat: lmp91000: fix probe order and
 cleanup paths
Message-ID: <20260511180644.3a510387@jic23-huawei>
In-Reply-To: <20260507185424.27327-1-salah.triki@gmail.com>
References: <20260507185424.27327-1-salah.triki@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 May 2026 19:54:24 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> Fix the initialization order in lmp91000_probe() where the immutable
> trigger is set before data->cb_buffer is initialized, which would cause a
> NULL pointer dereference.
> 
> Also, correct the cleanup labels in the error path to properly unregister
> the trigger before performing the triggered buffer cleanup, following the
> standard LIFO (Last-In-First-Out) resource release order.
> 
> Fixes: 67e17300dc1d ("iio: potentiostat: add LMP91000 support")
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
Applied and marked for stable

Thanks,

Jonathan
