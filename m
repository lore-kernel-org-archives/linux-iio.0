Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B4E1E7C23;
	Sat, 22 Aug 2026 01:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787361587; cv=none; b=sq4LCwXmIiUq4uaiKeZyMgU9De6EMtAQA4kDotj9dgIBKuiqdXYPuuZKhrNC1JxWSgdB+sRqkdz1nsQ2lq93JnsVXiNrsWbjp4NFcXfjSNcviQteCIvv9tLcjN0L9XrAZDhO/p3Rs8THMlk/vicQnVEDa7tq+HlM3Artb0moCvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787361587; c=relaxed/simple;
	bh=kNGTwCDoEYfbS5x8nhA6b7y8gP7wJUKvZHFnGDMdwDs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IUSRu3xQjKHAVAK6UyVfIYC/GSJhgr07bFenOScnWqf0ZPacB7Fdy2U1ANOl1SMinzDd1KEwJ4FBprWT/g8MOrIhPtbk6WUh6o5uVIPVxtUrxbcWNeMvSQPDVjPkHXIWtu9Mve81QcpSCrmYkFBCslPZ7SjRVTmQ2v565gX2zhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLseH5Bs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLseH5Bs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA87E1F000E9;
	Sat, 22 Aug 2026 01:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787361586;
	bh=iHX7SookFBfHAbNUDHG8EUDTcnaqTZJ1GrthQjL1l6M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KLseH5BsoFo+WQ0l6KSHtjE/xiPjP02VPhFOaiy8avpqoW1ptQt9bUCUz04PI2ieH
	 1qVUPA94UXoT4rKxqbT6C6T0Ik+lw/xWdqC6GZKEpc1HlA8zW9TiocZKIzv8rqmn2t
	 NBYtKTVnNqQtY/2z0uSaYg9s/CSu6RRPjTp3WkEzRs2waEZe1dhK/rLSiQtCbO0U0d
	 maLcbyze/h6Ez3x5efpuZiz4my4u86ibK41IPcHQEVqZXsWBaH9/GiXNjrIvbdKHSF
	 /ZFasxAw2xR8HXqzY0S5oQ5snf6FDE3DmWQC02Lmp9qxVqH7g7gKJeZq5g92apD5XE
	 Cct3o4+ISpU/A==
Date: Sat, 22 Aug 2026 02:19:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Maxwell Doose <maxwell@maxwelld.cc>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Marius Cristea
 <marius.cristea@microchip.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Tomasz Duszynski <tduszyns@gmail.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH v1 0/4] iio: Unshadow error codes in ->store()
Message-ID: <20260822021941.3f5a6806@jic23-huawei>
In-Reply-To: <20260813071912.2465208-1-andriy.shevchenko@linux.intel.com>
References: <20260813071912.2465208-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 09:16:49 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> kstrtox() may return different error codes. Allow them to be returned.
> This mini-series makes all IIO drivers to follow the same pattern when
> using kstrtox() APIs. Patches can be individually applied, the series
> is just a union by the subject, no code dependencies are there.
> 
> Andy Shevchenko (4):
>   iio: light: Unshadow error codes in ->store()
>   iio: imu: inv_mpu6050: Unshadow error codes in ->store()
>   iio: chemical: sps30: Unshadow error codes in ->store()
>   iio: adc: pac1934: Unshadow error codes in ->store()
Applied.  thanks

Jonathan

> 
>  drivers/iio/adc/pac1934.c                  |  9 ++++++---
>  drivers/iio/chemical/sps30.c               | 11 ++++++++---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |  6 ++++--
>  drivers/iio/light/isl29018.c               |  7 +++++--
>  drivers/iio/light/lm3533-als.c             | 11 +++++++----
>  drivers/iio/light/tsl2583.c                | 15 +++++++++++----
>  drivers/iio/light/tsl2772.c                | 16 ++++++++++++----
>  7 files changed, 53 insertions(+), 22 deletions(-)
> 


