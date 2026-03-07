Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FB42586C2;
	Sat,  7 Mar 2026 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772879201; cv=none; b=t9+NyhTq1kBtsCn7W928Gvs41q94EFD4klmGN13zWAyHpUSGOsv02BSIucyoLAwwip7PktBhif6VDnrHfobdjQwpDPTjOB2+Z95LOXmIQQbkfN/ANgBUgy819BbOR5J4VizaHH9IQ+lMQUI3pF2ZZu7K4Edgg1sK/dkzBkuC+bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772879201; c=relaxed/simple;
	bh=bJZkaIIN5vXMA5ntcFV+OoGcPa4Ag3NRBEq2KoxFaew=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VQX9DlF7gupCKFznzrO3s3XoJyVTdx7C1aJDqVPguJwzWF43AUHOtNbuMT8jhxArIvhvZSEJ4daxMFokJEf4lVoFolmRNzSdurIVa2IHGJwkek4Q6y6tPjSX6ABoqdyXX2IWNa0lV0b6GvVR6LYNIuLOVntYjjbTQ449rHgUBfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VW/7T5Qp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VW/7T5Qp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB859C19422;
	Sat,  7 Mar 2026 10:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772879201;
	bh=bJZkaIIN5vXMA5ntcFV+OoGcPa4Ag3NRBEq2KoxFaew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VW/7T5QpM3M7swlArjxIhZfXu7yUM6Bew/KtwItHZZOhZjQ/v5VWr45Jt2D1KKt5L
	 +Tbl4rPTaxR9QFfeJEcKpvxq+e8IMmHfIdz/LqauO6sxGUR3IIl4TtNBbk8guKzhIJ
	 6n+xZUoS9BpGQaw+tGKrRXVLOcfVjG3G+u2FbPZ7wgelUvRXnR28yTnum3M1sZzN45
	 GiyVfOdDLGatfqv6wgOHPVBL03sJt8C1DcEPU+gDqEvl27GF/bI5s3XKzcMJfc7FIi
	 25mxU5sRpRZJE0Rgdu8cTYBqd9UYKhkDsIsLe1ANH9Cko4MU4ceMovpz5sYQAscO2T
	 EaU5hDfGEVmgg==
Date: Sat, 7 Mar 2026 10:26:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Cc: lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, nuno.sa@analog.com, andy@kernel.org,
 puranjay@kernel.org, dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] iio: accel: convert to guard(mutex)
Message-ID: <20260307102634.6eaafab5@jic23-huawei>
In-Reply-To: <20260307101758.50091-1-rajveer.chaudhari.linux@gmail.com>
References: <20260306211152.65109-1-rajveer.chaudhari.linux@gmail.com>
	<20260307101758.50091-1-rajveer.chaudhari.linux@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  7 Mar 2026 15:47:55 +0530
Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com> wrote:

> This series converts manual mutex_lock/mutex_unlock pairs to
> guard(mutex) in three ADXL accelerometer drivers. Each conversion
> also simplifies error handling by removing goto labels and
> returning directly where possible.
> 
> v3: Remove remaining goto labels completely as requested by David Lechner.
>     Return directly from functions where ret variable is not needed.
> v2: Split into one patch per driver as requested by David Lechner.
>     Ensured each conversion also simplifies code flow.
> 
> Rajveer Chaudhari (3):
>   iio: accel: adxl313: convert to guard(mutex)
>   iio: accel: adxl355: convert to guard(mutex)
>   iio: accel: adxl372: convert to guard(mutex)
> 
>  drivers/iio/accel/adxl313_core.c | 15 ++----
>  drivers/iio/accel/adxl355_core.c | 81 ++++++++++++++------------------
>  drivers/iio/accel/adxl372.c      | 16 +++----
>  3 files changed, 45 insertions(+), 67 deletions(-)
> 

Hi Rajveer,

Small process thing.  Please send each new version as a separate email
thread.  It can get very hard to follow when we end up with deeply
nested threads so most areas of the kernel prefer to just associate
them via name of the thread and possibly a link in the cover letter
to the previous version.

Jonathan
