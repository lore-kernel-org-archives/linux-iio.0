Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DA7319617;
	Wed,  3 Jun 2026 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780494795; cv=none; b=oFqhcbD2RXDbkxoRQtviBQt0GRGpvN45qeiLHkLTWuOP70NlCT+FBaRn3Z5VQviCHM+/orMFjQKBaQ3hZOZMn6QOvaEGhurHgWNAln9an5akkBKYJEdUarvFbXqS58SeEK0TA2gb2WIiw/qPjP+8ttQN3se5Mm9qaAYbSCrruyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780494795; c=relaxed/simple;
	bh=07p5p1B+du1o3RN2aMHSWOd+HtzxzZJ52VkAEWiwbSI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mlZiipwfwAPCW56G6t23NwJ+hKAUWPd8Bq1VsjHzCSQNvLEnZaB7zQ1ejRJpn6OdPeRD++QNb7Bl5uuRp0zLACRga9E7uvyaE82eGdt3YKIKEd/i9E/DJGBpRXTyUUgc+SuAj377zVYaGA1il2Lde2eJ6tm+3ANMv0CbAtVhZKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LviIDGjO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LviIDGjO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823E21F00893;
	Wed,  3 Jun 2026 13:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780494794;
	bh=rOdrcQ27dklvXBiioyafrsNFrLzBTH5OyF1C8WuyHY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LviIDGjOPOLBCejOCPOFeTLet+D4/359JvVbbxRL+haJGtaT/ltLY6KuZamsyRzqS
	 sQoGQ7m4KeP6Ew2H/L7qgLgTExm6fNT8cdn4anXPTCZF/Aig5d5osRSjt3+Q+F211Q
	 xj3o+iZOR1Uec03m40TglMLXpCEMcBsuVOh1AlmTD39kWxWKxDUyAcsF+3mk7FKtsw
	 5EUc+V0iEDIZjTuYeSdz/NpF/fJOwBZq77IaKYFfFqOs3uO24ko4/M1k0eYQXA+ZDY
	 SzpRaIw4+m41Uusx5kOjSipscstXsI6Kr/A3CVn9MKSV2C1gOnJ6Emg+Zi9yyM1fgZ
	 hAnu0RBXUeVMA==
Date: Wed, 3 Jun 2026 14:53:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: todo: fix typo and refine resource management
 items
Message-ID: <20260603145307.13b7d923@jic23-huawei>
In-Reply-To: <20260601190836.2766703-1-sanjayembedded@gmail.com>
References: <20260601190836.2766703-1-sanjayembedded@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Jun 2026 00:38:36 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Fix a typo in the staging documentation path and adjust formatting of
> existing entries for readability.
> 
> Add TODO items to track conversion of selected drivers to device managed
> resource APIs and evaluate usage of cleanup.h helpers for simplifying
> resource management.
> 
> These updates aim to better reflect ongoing cleanup efforts within the
> IIO subsystem.
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Hmm. Sometimes I regret having this TODO when too many patches are coming in.
I guess it's still a useful document as otherwise we would just get the question
a lot.

> ---
>  drivers/iio/TODO | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/TODO b/drivers/iio/TODO
> index 2ace27d1ac62..17093cc6c61b 100644
> --- a/drivers/iio/TODO
> +++ b/drivers/iio/TODO
> @@ -5,12 +5,16 @@ Documentation
>  tree
>    - Yaml conversions for abandoned drivers
>    - ABI Documentation
> -  - Audit driviers/iio/staging/Documentation
> +  - Audit drivers/staging/iio/Documentation
>  
> -- Converting drivers from device tree centric to more generic
> -property handlers.
> +- Converting drivers from device tree centric to more generic property handlers.
Drop the 'more' 
>  
>  - Refactor old platform_data constructs from drivers and convert it
>  to state struct and using property handlers and readers.
>  
> +- Convert selected IIO drivers to use fully device managed resource APIs.

Mostly I'm fine with this one, but I hope adding it to the todo list doesn't
get lots of new folk taking this on. It is something that requires a non
trivial understanding of the driver in some cases!

> +
> +- Evaluate and adopt cleanup.h helpers (guard, __free) in drivers where
> +  manual resource management is still used.
Can we rephrase,

 - Evaluate and possibly adopt cleanup.h helpers (guard, __free) in drivers
   where manual resource management is still used and there is a significant
   improvement to the code flow and complexity to be had.

> +
>  Mailing list: linux-iio@vger.kernel.org

