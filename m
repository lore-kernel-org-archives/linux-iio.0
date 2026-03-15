Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BECB222582;
	Sun, 15 Mar 2026 19:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773601519; cv=none; b=KNRqFTO/C7ZOAOL8hyAI9g1Bzhbf3ezFeiLy+m7rnRk6GSxBHbPbtMPMlqfBsW1JcwnM2Of7u7NbCI3cGVjY07KoRm2CGA9oDZ7fjL7UzlnkMk3xK3mIPVYYhJMuYWX6mhYPhNA++0p2vEwwDnJayxHgIK5bk++j6/8E2btJzFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773601519; c=relaxed/simple;
	bh=wIX01ZsxIj1f/txxtUXIE4/W11vgVRJFigVYMa4kwkA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IkTXWvf+ppItZnHrDRU7wcWapHTE0uuNsX4fL0FwknqG0o3I03AuNgkMXzsdQ3GUY0UUi4DY1owvuJXiJQ2ywbKhEZq2n3qmzpdAAT/3dRtP2f4R8jlHTcN6Mw8peKG2YZfN+tXpnx0fTwcnJ4o7xrbzX2rorOt4dEKyuvFWWwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GObdD3u3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GObdD3u3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D93C4CEF7;
	Sun, 15 Mar 2026 19:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773601519;
	bh=wIX01ZsxIj1f/txxtUXIE4/W11vgVRJFigVYMa4kwkA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GObdD3u3uKUIgT6qWof3+6bLkb8b9klc+gVWTcfvsjxHPyOaoxPySVA7Rq611GIQc
	 F6PRqHr04Us2zTLHUubTkpIyM1I39PhWq4DXn0y+1vcbthP7ga5S8quua/cdosGWVF
	 RjPx55oUnDgowcURV3xHFSMuU8rHXm+u15Hye7WVpaiaynoSX78UKOILEeEFyf5+g5
	 GuOUtAJJDbYbVXXdzzFdMz07JLu/KlE+zRVIC8gjizTWiOoUh4EyyhTCrzSPbGTJZ3
	 Rc7FvTX7+yABqOSNa6rh+dOnZLbgTqBX/OtJq89p9vy/evwL8fIgYd+yoUs/BM6rqJ
	 rI/smu24F3ySg==
Date: Sun, 15 Mar 2026 19:05:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 waqar.hameed@axis.com, linusw@kernel.org, sakari.ailus@linux.intel.com,
 harshit.m.mogalapalli@oracle.com, antoniu.miclaus@analog.com,
 andrew.ijano@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/8] iio: accel: convert to guard(mutex)
Message-ID: <20260315190509.4ce69a70@jic23-huawei>
In-Reply-To: <20260314170609.26827-1-rajveer.chaudhari.linux@gmail.com>
References: <20260314170609.26827-1-rajveer.chaudhari.linux@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Mar 2026 22:36:01 +0530
Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com> wrote:

> This series converts manual mutex_lock/mutex_unlock pairs to
> guard(mutex) in two ADXL accelerometer drivers. Each conversion

No it doesn't...

> also simplifies error handling by removing goto labels and
> returning directly on error paths.
> 
> v4 : Sort Headers alphabetically
> 
> Link to v3: https://lore.kernel.org/all/20260312081942.23858-1-
> rajveer.chaudhari.linux@gmail.com/

As per the thread on doing this stuff as a GSOC project, 
please don't do too many of these.  I don't mind people doing
one or two as a 'getting started' project but they do take non
trivial review and don't necessarily give sufficient benefit.

So on that note, maybe move on to other topics after this set!
I am in favour of these as part of more significant driver
improvement series though!

> 
> Rajveer Chaudhari (8):
>   iio: accel: bmc150: sort headers alphabetically
>   iio: accel: bmc150: convert to guard(mutex)
>   iio: accel: mma8452: sort headers alphabetically
>   iio: accel: mma8452: convert to guard(mutex)
>   iio: accel: mma9551: sort headers alphabetically
>   iio: accel: mma9551: convert to guard(mutex)
>   iio: accel: sca3000: sort headers alphabetically
>   iio: accel: sca3000: convert to guard(mutex)
> 
>  drivers/iio/accel/bmc150-accel-core.c |  38 +++----
>  drivers/iio/accel/mma8452.c           |  38 +++----
>  drivers/iio/accel/mma9551.c           |  19 ++--
>  drivers/iio/accel/sca3000.c           | 157 ++++++++++++--------------
>  4 files changed, 115 insertions(+), 137 deletions(-)
> 

