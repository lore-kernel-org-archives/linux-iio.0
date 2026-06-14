Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E057730568A;
	Sun, 14 Jun 2026 18:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781460843; cv=none; b=qzLXYEBgdypZdJiJncwk3n5a88SjyHAWR7ZVl7GKrazRXrXmNHOEp5LQF9LiUnC0vV6mgx/ctM78hfj6D9RWvPbV6nIWdN9hqwUEsPn6PbST+HizT5W6nckb8FtWzcTV3HK1e3baSTtLB8r+ASFjdUaOvmlHazf5WqJk8RiHWQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781460843; c=relaxed/simple;
	bh=wnjy6sSx5WRjgkFQIjRAmlZ2KSHqKBC6VOTGUauQ0fM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CUfizUwOnVgNOOs0rEj5JOB90LJncdwAgBJgnTWGQuLKVgMDizGGn8Tmye/RYFk4MoRhQi0FIN3OEx204oubnU7I/bD6Jsfx3P6Na7IJvCbOtvSAtVEE5Lw4mc29k/lCtXrA3nfG9w1/47D+/Ojtg/bHIDjbOKDDkUAzh7j7tkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKI2yeo2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKI2yeo2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5A11F000E9;
	Sun, 14 Jun 2026 18:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781460842;
	bh=TR29DfCSsXXWKRqJA2eGb577bERsx9EnCGJYqF4/YLA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gKI2yeo2rvisA6I3E6cmdxaaOJrirvFKHIbcM+r6Nssb64UTztaUIOnnimAz5Opfw
	 kgq77+NaMxOZii4FPoXKORj9bmnHGnQxhMvGTZjOKhVND7V3sEm1++cp7H46zGbayl
	 CXiz3Y/ZvN/QKP4sKV2gKUMjPO3bPJdlo/K5CqT0BhiMqkWk29CvlT4SRMUAzwXTks
	 PtoJsj5ycNcKFFcw2Zjzri+y148/h485Lu25YGj72G6VgMaBifOLPq8IQ5CC06Z6ys
	 lk5dF3UHjS7jN30tAGASkbkVoLwaf07iaz31Aw7TvXXLXcs+v8eoO6epf3uWwx/rts
	 K6Z7PbR/epZtg==
Date: Sun, 14 Jun 2026 19:13:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: david.laight.linux@gmail.com
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, Arnd
 Bergmann <arnd@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] drivers/iio/test: Use strscpy() to copy the test
 description
Message-ID: <20260614191355.04ca0a34@jic23-huawei>
In-Reply-To: <20260606202633.5018-37-david.laight.linux@gmail.com>
References: <20260606202633.5018-37-david.laight.linux@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  6 Jun 2026 21:26:31 +0100
david.laight.linux@gmail.com wrote:

> From: David Laight <david.laight.linux@gmail.com>
> 
> The buffer length is known to be KUNIT_PARAM_DESC_SIZE
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
Hi David,

Given all the names are set in this file, I'm taking this as a hardening
patch against future problems.

Applied to the testing branch of iio.git which will be rebased on rc1
once available.

thanks,

Jonathan

> ---
> This is one of a group of patches that remove potentially unbounded
> strcpy() calls.
> 
> They are mostly replaced by strscpy() or, when strlen() has just been
> called, with memcpy() (usually including the '\0').
> 
> Calls with copy string literals into arrays are left unchanged.
> They are safe and easily detected as such.
> 
> The changes were made by getting the compiler to detect the calls and
> then fixing the code by hand.
> 
> Note that all the changes are only compile tested.
> 
> Some Makefiles were changed to allow files to contain strcpy().
> As well as 'difficult to fix' files, this included 'show' functions
> as they really need to use sysfs_emit() or seq_printf().
> 
> All the patches are being sent individually to avoid very long cc lists.
> Apologies for the terse commit messages and likely unexpected tags.
> (There are about 100 patches in total.)
> 
>  drivers/iio/test/iio-test-rescale.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/test/iio-test-rescale.c b/drivers/iio/test/iio-test-rescale.c
> index ac6942cf1e44..bcd4a607be19 100644
> --- a/drivers/iio/test/iio-test-rescale.c
> +++ b/drivers/iio/test/iio-test-rescale.c
> @@ -575,7 +575,7 @@ static const struct rescale_tc_data offset_cases[] = {
>  
>  static void case_to_desc(const struct rescale_tc_data *t, char *desc)
>  {
> -	strcpy(desc, t->name);
> +	strscpy(desc, t->name, KUNIT_PARAM_DESC_SIZE);
>  }
>  
>  KUNIT_ARRAY_PARAM(iio_rescale_scale, scale_cases, case_to_desc);

