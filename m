Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794083488;
	b=RDUE86+S5IhgA9iFW+X/qjO84fFQshVhUPR1QexMZjm7ToWPEKdArfnuIIkOH6m0FVFg
	 lgG4GOI4HgC+9ihTQvhY0zdAJPk5GPHTAa2mRai79UesVBTATu8yBE/26hO8Nwy3tJbFc
	 QwbDqeTePnICPl+/VmcsoLSNz734XZKj0ODLftTDgsV2CFhAXWnj3lz8UElaLF04Ltlzr
	 WBahS03VIU6CZhIWxheK49izIdygFE1f4/72WJHipytYQcFBFfrkumPcaHEAD38vrZu44
	 ubi8bkBEc3hntju08GrkqyLkLHAvqErxG48NBBl8S5EROL7QqgP0FS0DDYIsINd8NiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794083488;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=6R7bD2lGbyz5elKAgspeW/S1EvIUDAsU8iwuty7BhyI=;
	b=G4wtYIDdhxu7Z1L6uL56r6XjK+qBobA3FpgzrYcbJgL2HEDNbAPEKzVG6k5ngrJJe9+2
	 /5TJBUJibOuKWrsoJrkjOrNeoU0dXy/ztcENcXnVjalpPrY7Nto6ElTPUxKrp3NAfyv8G
	 Pvd5yo1r/WFXhcHxmzvrxpuUuUHQlFGd75NWwB6e/rn2JySQNkbLt8qxaa7GpTPQiFg2X
	 QLXF0y9ZiDhV19Us92GYoFi72cxWMgUUmOpynfrCAwcLdkqa76FRXrM/FGSeUnqeXzhWj
	 yD4riXgwKbvpFEYnUNEhl5CbuM2kosWII8zpfyADYIcEF+umaWdM3txnVZuPdudHdPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G1cVQTNl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66780606A326;
	Sat,  7 Nov 2026 20:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G1cVQTNl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E591F0089F;
	Sat,  7 Nov 2026 20:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794083488;
	bh=6R7bD2lGbyz5elKAgspeW/S1EvIUDAsU8iwuty7BhyI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G1cVQTNldgtph5Vl7FzQw6lgD987FMmUKcceFYmLXkcpHm/CymQloz/mqjqimF5kt
	 /lb7DSrusTCKhmCMDI2ijXbpg41v8udtocU4o1bKt/qWtPVa2FWSyGAL8Z95yX//bZ
	 Fm+Md35LnwH5XdSW6thEWIleORqaz4GLb53DU75LsmzEtCkuoypOeVF99StMNdB5jG
	 J+SaFrwpygUe1uRS+LxKSPLXiDTfh4usayIqpHAYTZxjEW2D4gcWyFS787DKMG27WH
	 zKDNvrkzaPWoeVdkAgo0np9eP0pcBtsJH0o1nghx+VwfWVE5d93HvWBNfN+qR+Aosf
	 Ri1fDB40peycQ==
Date: Sat, 7 Nov 2026 20:31:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Joshua Crofts <crofts@kernel.org>, linux@analog.com,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] staging: iio: addac: adt7316: clean up header
 inclusions
Message-ID: <20261107203121.4cc15592@jic23-hlaptop>
In-Reply-To: <20261104183429.20125-1-abdelnasserhussein11@gmail.com>
References: <20261104183429.20125-1-abdelnasserhussein11@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
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

On Wed,  4 Nov 2026 20:34:27 +0200
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

> This series cleans up header inclusions in adt7316.c. Patch 1 sorts
> the includes alphabetically. Patch 2 drops <linux/kernel.h> and
> includes the headers the driver actually uses (IWYU), removing the
> unused ones.
Applied.
> 
> Changes in v4:
>  - Moved the list of added/dropped headers out of the patch 2 commit
>    message, as requested by Andy Shevchenko.
>  - Added Reviewed-by from Joshua Crofts.
> 
> Changes in v3:
>  - Split the series as suggested by Joshua Crofts: patch 1 only sorts
>    the headers, patch 2 replaces kernel.h and adds/drops headers.
> 
> Changes in v2:
>  - Split the original patch into a 2-patch series.
> 
> Abdelnasser Hussein (2):
>   staging: iio: addac: adt7316: sort headers alphabetically
>   staging: iio: addac: adt7316: replace kernel.h with explicit headers
> 
>  drivers/staging/iio/addac/adt7316.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 

