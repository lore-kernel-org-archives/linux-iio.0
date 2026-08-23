Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EBD1A275;
	Sun, 23 Aug 2026 00:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787445757; cv=none; b=IT96i+wi/tUE1gtF2Ll3q5kElTYGuv/ugK5I3iAmbwnL+GkAD1XuknsOqfB+vyEFvy10H28OBXCRlfsjrfHrAgS+/sZVZ27Y5TeZMw/S9tbuLiIDRLvi5VpoCoO/h3oNbc/QtrMb4PAgqI4ndrWA1OKAj08xzGTiMlStK6KwWsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787445757; c=relaxed/simple;
	bh=+gFF3jfwHwTgz+qf4ZPxzkj127YUBDTVRUXI6COK5Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LI+NZd4+IBorp0mGU1giw9QGq4ePT+LmuRyU8TkYbvrnaLGyRsniuGcMe5hMcSp3LvVDlkofySIFaNAJNqKtVpyVnHUiIWiWc/dZMizBC2Wf+17AhJnI6rFmHIYS6NXR48+llPOz+QtOMJZ30w0zY0Ygc5k4nGN9uhvT+ogtNLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxOzp3AK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxOzp3AK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068CF1F000E9;
	Sun, 23 Aug 2026 00:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787445755;
	bh=ChjigdwQq0EiLZN1u1T2R0xZCvD+v4uvyeiQeRS982A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IxOzp3AKmCg2aSDoqmJaU+D9i5VYE5XFrccLfHamqF3VX67esbmsyPlIMSknajPLV
	 hsNrZBbehKKh5xyEJy3///tbvnhIQsvFmOE9ZcqwtVVsJRXhZLOIoeU5e4dcaMtAPr
	 bvq1ZcMS+X3RDrCN2OmWyxPLn/m0/hQFehxmFXIrr+AhddN8iSXVT8gFI8UrAysGot
	 //n4txT30UKQHDK+lr/3rYUVpywdngOjGUjZcXdPhIKhjTNgkzgYv7tKomuqHDBnHe
	 9tkbJRrQ0fD+cV9tSLojr1TzI6RQQPufGySAjTgvbNhaSuTadzttYPGwI5dqgGGwzJ
	 Mc+7hd7GBa+NQ==
Date: Sun, 23 Aug 2026 01:42:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Gabriel Rondon <grondon@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nishant Malpani <nish.malpani25@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] iio: gyro: convert to iio_push_to_buffers_with_ts()
Message-ID: <20260823014232.5d7d88fb@jic23-huawei>
In-Reply-To: <886f7b8a-ccd5-4a71-b5f0-3d3453dffefe@baylibre.com>
References: <20260821140553.80246-1-grondon@gmail.com>
	<886f7b8a-ccd5-4a71-b5f0-3d3453dffefe@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Aug 2026 18:25:57 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 8/21/26 9:05 AM, Gabriel Rondon wrote:
> > Convert the gyro drivers that still use the deprecated
> > iio_push_to_buffers_with_timestamp() to iio_push_to_buffers_with_ts(),
> > which takes and checks the destination buffer size.
> > 
> > Each pushes a struct with an aligned_s64 timestamp, so the change is
> > passing sizeof() of that buffer at the push site. No functional change.
> > 
> > Gabriel Rondon (3):
> >   iio: gyro: adxrs290: use iio_push_to_buffers_with_ts()
> >   iio: gyro: bmg160: use iio_push_to_buffers_with_ts()
> >   iio: gyro: itg3200: use iio_push_to_buffers_with_ts()
> > 
> >  drivers/iio/gyro/adxrs290.c       | 4 ++--
> >  drivers/iio/gyro/bmg160_core.c    | 4 ++--
> >  drivers/iio/gyro/itg3200_buffer.c | 3 ++-
> >  3 files changed, 6 insertions(+), 5 deletions(-)
> >   
> 
> These check out. I also looked for alignment/DMA issues.
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 

Applied to the testing branch of iio.git. I'll rebase that on
rc1 when that is available and then it will go out as togreg
for linux-next to pick up.

Nice little series.

Thanks,

Jonathan

> 

