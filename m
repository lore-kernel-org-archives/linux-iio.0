Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E9A3590A9;
	Mon, 29 Jun 2026 23:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782774980; cv=none; b=VhdSncYCzzEIMHIUazDcwMRIJZBMG9AU0c3XN1I/D2l0C0Awik+wfkWmrNay6xOZdcRr8zr6V2IiL3OW0kDcFotJeqIm5Civ4Mg4o23EMTxefimVtNyqsLxq0EtNTMPsZpUTs/easmr0FeFuDQUHKVBHZWCKxbMHjTcX6XTlI+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782774980; c=relaxed/simple;
	bh=dEIWrsthZfZnNsPgPP66KxlxsV1d/VyZZ5OBUtcCPY4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=awEZtg9HqXNE0y7BEJDDewuX1P/oSx98Ojgs1SF2wLpaLeyVblWXNzr2UPFuBinzzXtkMs9+HLb4oZqHFGXdzQkMqTjuGpmKYzWflBOPaJ+BzGEyBlvcX7dcEjg+GccGYi/a7w1dorUfxOlrm6lFQejcLzQ8Y3duC67ZpGyQ0JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lN7Su+LK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lN7Su+LK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56781F000E9;
	Mon, 29 Jun 2026 23:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782774978;
	bh=PhPgvVGb9kDFBki+zrqy6z3Ddadn7ijrcnOJFx5NwWQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lN7Su+LKZOpW5RJfrMR561D9OtESgqjIejp23z3Pg0q6H3Z4QLMBI9NMbT9VyFjlK
	 N8naL3kNn0XwEKJ2157re69t0dlw5gjIflJ7aW9vZnJ1YVOKEtBwL4VUHPfO3aW9nS
	 lSMsPcKSZisiqzYZg6A2WQn/PtWlzmq+VlcjKtbbvXCRU145sTeEl6NqrKp1MPp8Rv
	 ex8mxrL0Pcg8HFjSbKfq+mVERtXc7dDGDuVsxUY+dpPcWIfK/PQh62+bKljFuHsGIc
	 D3q8QCfXIOHgiwpG41OhmxqKsM5N71bzuiFniJPybRbnEzw3oaKgVeHPzWoavkS2ER
	 Ya9GbG489/eSw==
Date: Tue, 30 Jun 2026 00:16:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, kernel test
 robot <lkp@intel.com>
Subject: Re: [PATCH] lib: kstrtox: missing parameter description doc fixup
Message-ID: <20260630001614.42ed1d81@jic23-huawei>
In-Reply-To: <20260626-b4-parse-integer-doc-fixup-v1-1-25cc495af36f@analog.com>
References: <20260626-b4-parse-integer-doc-fixup-v1-1-25cc495af36f@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jun 2026 10:34:51 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add description string for 'init' parameter.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202606250230.etPGuolf-lkp@intel.com/
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
> Recent change causing a build warning. This is to be a fixup
> patch amended to:
> 
Thanks!  Applied as a fixup.

Jonathan

> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=521b4ae3b5a47cf4ef5826016eecde08e8740bef
> ---
>  lib/kstrtox.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/kstrtox.c b/lib/kstrtox.c
> index 17357c4ae52c..bac1c057e1b0 100644
> --- a/lib/kstrtox.c
> +++ b/lib/kstrtox.c
> @@ -46,6 +46,7 @@ const char *_parse_integer_fixup_radix(const char *s, unsigned int *base)
>   * @base: Radix
>   * @p: Where to store result
>   * @max_chars: Maximum amount of characters to convert
> + * @init: Initial value of the multiply-accumulate result
>   *
>   * Convert non-negative integer string representation in explicitly given
>   * radix to an integer. If overflow occurs, value at @p is set to ULLONG_MAX.
> 
> ---
> base-commit: 7667a80340e99fd45357d0c90ae05813b01bbfef
> change-id: 20260626-b4-parse-integer-doc-fixup-6b2a5cd77a1b
> 
> Best regards,

