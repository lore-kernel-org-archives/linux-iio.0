Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CA23A0B17;
	Sat,  7 Mar 2026 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772889051; cv=none; b=MNxYV88gQ4TUE8kb2HQW+VFWdh0Qqf7L+eWATQ78YKKGiNw3TtBFhXFCJ6yhXX52j1eEaaRkWKKn+56Ue63YQ+8c5pd4XKKK4kZro2C7837bJnJt7FC4msQ98ZKdZBTbjjZmU+Mc2nsPl8pSIF0p0URDih9SwC11IMxyZEKBjIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772889051; c=relaxed/simple;
	bh=VzQoGzkrar1QwQVd/LVzFEHZNLhvaFuGveEKLnkAim4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BrZS37h28yIe+kW/kaf631KTVp2Twb6pd/uRrNsJh4i5ioKxdmWQZ1w2xZZS+nk+I3LeGx1rqkNGvfcPn6xK6qKTmgE7725aEpZNErLz+pfo7RPYKLHOKu/ftNXH7X/bOtNUVymATRNtbfUkqk3NMST6d93rZFJqy7qf3M6qtMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0mUuUPZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0mUuUPZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B13C19422;
	Sat,  7 Mar 2026 13:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772889050;
	bh=VzQoGzkrar1QwQVd/LVzFEHZNLhvaFuGveEKLnkAim4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y0mUuUPZNs37BP5X4hFUdeaiZTsHC6YKHPpnG7YHJn+TBCeMB4bIy2nx8ltWc8iyI
	 SVnmOvjaoRfrPNEuRzw6YkyFkscj2cVbPMKTSTUIG+QG+07Qu211dy6FsUvvWfkL5H
	 AkFITv7cWDIkDA/KrFAbqSC7IyRZbexwVrkMCFx/pAqMGB56q7otq8GIg5m9dNqQiz
	 dkpIX/nCY2Y2Xt7KCj3SEfAH5ikJdYNbo5c5KkQo0PM+CtVbVtBarTqgiORYA158xq
	 fLYRcoeyWk7RiACApIw2pxR0a5VHTaUzFJg3G6wzSALopPMYltdveSeSjmYEm1sJZV
	 idcj/6cBUI+1w==
Date: Sat, 7 Mar 2026 13:10:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v7 2/6] iio: Replace 'sign' field with union in struct
 iio_scan_type
Message-ID: <20260307131041.5a92d6a0@jic23-huawei>
In-Reply-To: <20260304080640.2844366-1-flavra@baylibre.com>
References: <20260304080519.2844101-1-flavra@baylibre.com>
	<20260304080640.2844366-1-flavra@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Mar 2026 09:06:40 +0100
Francesco Lavra <flavra@baylibre.com> wrote:

> This field is used to differentiate between signed and unsigned integers.
> A following commit will extend its use in order to add support for non-
> integer scan elements; therefore, replace it with a union that contains a
> more generic 'format' field. This union will be dropped when all drivers
> are changed to use the format field.
> 
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> ---
>  Documentation/driver-api/iio/buffers.rst | 4 ++--
>  include/linux/iio/iio.h                  | 7 +++++--
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/driver-api/iio/buffers.rst b/Documentation/driver-api/iio/buffers.rst
> index 63f364e862d1..f36e6d00173f 100644
> --- a/Documentation/driver-api/iio/buffers.rst
> +++ b/Documentation/driver-api/iio/buffers.rst
> @@ -78,7 +78,7 @@ fields in iio_chan_spec definition::
>     /* other members */
>             int scan_index
>             struct {
> -                   char sign;
> +                   char format;
>                     u8 realbits;
>                     u8 storagebits;
>                     u8 shift;
> @@ -98,7 +98,7 @@ following channel definition::
>  		   /* other stuff here */
>  		   .scan_index = 0,
>  		   .scan_type = {
> -		           .sign = 's',
> +		           .format = 's',
This made me wonder if we should use this opportunity to restrict
the flexibility of what can go in .format via some defines?

#define IIO_SCAN_FORMAT_SIGNED_INT 's'
#define IIO_SCAN_FORMAT_UNSIGNED_INT 'u'
#define IIO_SCAN_FORMAT_FLOAT 'f'

or something like that.  Given the aim is to convert all current
instances we can move to the macros as part of switching from
sign to format.


>  			   .realbits = 12,
>  			   .storagebits = 16,
>  			   .shift = 4,
