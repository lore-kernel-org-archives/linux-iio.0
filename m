Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793613750;
	b=oygBHB6nVsaEXLqtEjQ0YR4w7mc1dGbxj66YidTf2ntUc9MCCswHP8jwewqm6tVmtqtb
	 +sgTu6nZzJCGo7mpbcCao4fVaKv210+buewrNlmVVd6+YAzCqMgoAAnSCNOs9dgY8PfPG
	 XNFsZ2yTMLXFils2CKaNiDcou4ZKli29qf2BMSIwTX4eGxA+R4XcirjmV/uev2Jv4NgtO
	 VICJhuo08QO8wMHtB2CGULcfvS6J4Bw1uYiKG45GEoMZkvWISCzFz5q9jVYF6y0tv4ar7
	 GSbvjIPbyqj6VhSAv+oYfMDK9/bLmMO+EllbPmEjhs9vAN/ppHrZKKy9ufWqo9Y1xig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613750;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=XzpjiuDg14m5/0rAwtwR3uEc9Ha934pVu4Nw/YOiHAQ=;
	b=5JXu6o7TdeFi/yz4EDTZQ581BBj6rRqFtVwjvzO+2X5pOkrthm51QEF5Jxhzp6QMy4c6
	 bt7aFFN7zyar954KnGnW9r5e+HEA2ARXxh68sWBdd7osb4MdzlpqM+lzF2UVFt6FeiRgp
	 0X+4OP97y3GptrfFN/qaePWLwGGDuvf6d3IzGtqT2WZYeMZ4yZsUzmdQFhgGPZ3UGT1nQ
	 FlA08v09Z4nr3/kKHy19GaWfI7lIoinLj0ta3heipH4O8scnaU50wvwAclqavBpYNv9uc
	 1vKa5nqFXk7Iq62D9eDrgiSFX6PiYNLbuEqp8AFyVLP9xSf0z9ELde7A92pZax8Eo2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OTjL0PkG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6C9606A326;
	Mon,  2 Nov 2026 10:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OTjL0PkG
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793613749;
	b=Sdw3n8cZJlkrzqGPdh6dMB3CD9GNo0GpsZrP3JyZtIurlibo69cIBSXntqTNWTe6kNVp
	 thb5P8bMdO+rt7dif2IAVhUlealtv+FXOns/v0zhl42weCIob4yw87bThAu4jHZVLYNA7
	 cx64dXeHsPgfhz0cjq7okJj+fk8HXdLwW2tGOHIwKnMKSaiBgvewkCq51QdrGl903tjc7
	 vqFxTd62RjuZp7kpg7PkyXGXSLLXTi+iR+bM/UEDsYBXiaHWsRzK7i1F24McXvtGhXQCc
	 zWIkvAvMDkSX3bqXbN8OvtOR8uh4zPvn1YGBAp/17ivI+SGr52UcyaNcOMvVH20ji+A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793613749;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=XzpjiuDg14m5/0rAwtwR3uEc9Ha934pVu4Nw/YOiHAQ=;
	b=IDkuIHi7IvRGnPuP7kqdSidtY304aymblgvlpoY2+azECmXj5MN8PaWJT8Wzx3C7jfek
	 Mr38mHkbkZ6HV/M2fjk8A7tIuLgv8I/3BQLr1UU6vCmy11iIB2nUq6uy5g9J10dGKaw8g
	 emSAfO9J4iFaXHSoiXOwvpB/eM5pABsZ9cSQdtIxWQshh6yY++ftFqk5pKNFux4r4R9Fu
	 w3KAuvX/CfIVoattwJ8tLgdhBWsqT5iKxhMHo6Fq678QGOm0KKMJeywmtkEDfkYyeQ6xm
	 F9B7TqsfZFdw/9MKDrJ/NJ2Lu4JiRMXfo75Yqyp2OGzrWm4qOgmHMqsCaTXyrB1EuJQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 3DE491F00919;
	Mon,  2 Nov 2026 10:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793613749;
	bh=XzpjiuDg14m5/0rAwtwR3uEc9Ha934pVu4Nw/YOiHAQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OTjL0PkG+1OJ9V2ZkWrnG9o1YZAZtk+U9U1I1LfmZNIHxfuq1nGzGGjch7beI9jhM
	 6GttOvG4VxGMldeJqwpBgmLdN5YsrU6vrAHeVK7QesfFMIc+NIO5mmD2tlJykkF3YB
	 VUNn1sBTp+z8RA9RjGhKay/jTiLteO0Czlh0cZ8ZNj50LbiX+gY0h3wlNm5hNrhMEt
	 H+ElJx6fwDazK7WLbbqlxCHGF7TTFtZHXmik/Y3qqe1OOxuVtLIsiIY1pG4Y/nU3H2
	 SgogVlqZokBaeQqMDWQKs0dqltwnneujRivAOh6RoL6ZNGh3O2yfPP5uPhV8y9SxGf
	 62HJG9l9ghOzQ==
Date: Mon, 2 Nov 2026 11:01:58 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] staging: iio: addac: adt7316: clean up header
 inclusions
Message-ID: <20261102110158.0000386b@kernel.org>
In-Reply-To: <20261102094236.57757-1-abdelnasserhussein11@gmail.com>
References: <20261102094236.57757-1-abdelnasserhussein11@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Nov 2026 11:42:34 +0200
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

> This series cleans up header inclusions in adt7316.c by following
> the Include What You Use (IWYU) principle.
> 
> The series is split into two logical steps:
> 1. Sort existing header inclusions alphabetically without modifying the
>    list of included headers. Keep subsystem <linux/iio/*> headers
>    separated and insert a blank line before "adt7316.h".
> 2. Drop proxy header <linux/kernel.h>, explicitly add missing headers
>    (<linux/bits.h>, <linux/err.h>, <linux/errno.h>, <linux/kstrtox.h>,
>    <linux/pm.h>, <linux/string.h>, <linux/types.h>), drop unused headers
>    (<linux/i2c.h>, <linux/list.h>, <linux/rtc.h>, <linux/slab.h>,
>    <linux/workqueue.h>), and maintain alphabetical sorting.
> 
> v3:
>  - Split the series as suggested by Joshua Crofts: patch 1 only sorts
>    the headers, patch 2 replaces kernel.h and adds/drops headers.
>  - Explicitly include <linux/err.h>, <linux/errno.h>, and
>    <linux/types.h> per IWYU following verification of symbols used.
> 
> v2:
>  - Address review feedback from Andy Shevchenko: drop <linux/kernel.h>
>    and include the headers actually used.
>  - Split the original patch into a 2-patch series.
> 
> v1:
>  - Initial submission.
> 
> Abdelnasser Hussein (2):
>   staging: iio: addac: adt7316: sort headers alphabetically
>   staging: iio: addac: adt7316: replace kernel.h with explicit headers
> 
>  drivers/staging/iio/addac/adt7316.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 

Much more readable in this order.

Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts
