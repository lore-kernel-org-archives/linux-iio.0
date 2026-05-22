Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3A6407CDE;
	Fri, 22 May 2026 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459190; cv=none; b=Igku7eXrmOZvZbcgYwxG1noFvbfTLjauiDXgCNh472+VtMvjJ0jkh7GWxQD8C6UCNBvqWxw4q10ff1GActICUsv2jVFBd1Rf3grDftqlGYaTk1DUqZzY6xuOPSWIALdsOIZBQhYFw9MqdWmexKniNjGxeQJEcPAn5XDmGgXlHuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459190; c=relaxed/simple;
	bh=ehOjXhOdSJtJ8L7VW9pLW1mjBVNcO4Ijci2JLoO/H9s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gvytz9xBJuqsh9XSpOaC5ebYjyyNywo80iXM49Fwi0qkadr8Kp8phzQ3oA4E/DJDmMbD98gOAukuaqLhNDGk5BmoA+K25MQjc5V6L6SA6ly0Kuj7ARiH6YJ7bjPHdqAeAGluJDt09FZsbQcQosYAdVo/4eno6te2LpWlD9Dq+do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNbSOz0V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNbSOz0V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC5C1F000E9;
	Fri, 22 May 2026 14:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779459181;
	bh=p2r/uvzRc066dcnGdaiZpLskxwY5TZ8WCjPjC5XyTfk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WNbSOz0Vi3SFiYjtkckGNdbLDhOHeZHEAqVkHviC23pJSNNTcYlTqxEVeoBGytZQj
	 cuNUERGaN2M3JIUSuQ1kW6nFp9jjKZvgtGDX6I4NSBueUGdLd8jToEDY0GWNQ9Z09N
	 P8ayrKVbVBBgC8N2Slu/dw9yRerLXUT+wqV5lozTVRYQTSP2qsgu0KejBj5RSD9Y/+
	 fubl6dWj9n2CVRYqAJ7JuMSZwH4piJLYqKqmFGpyvdEh3mJfKGmQoZSA8MegvjOsHO
	 M6mdm42mIvelgQCTkP22aJ1rCsEb+Y1GMJuSCSosgtUUwB2NRGOT7GDe7V7ZKESMTr
	 aVyyzq7sk+Vcg==
Date: Fri, 22 May 2026 15:12:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Alexander Koch <mail@alexanderkoch.net>, Michael Hornung
 <mhornung.linux@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Maxwell Doose <m32285159@gmail.com>
Subject: Re: [PATCH v3 7/7] iio: light: opt3001: add comment to mutex
Message-ID: <20260522151252.4a8ac373@jic23-huawei>
In-Reply-To: <20260521-opt3001-cleanup-v3-7-820169dec8c3@gmail.com>
References: <20260521-opt3001-cleanup-v3-0-820169dec8c3@gmail.com>
	<20260521-opt3001-cleanup-v3-7-820169dec8c3@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 11:55:44 +0200
Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:

> From: Joshua Crofts <joshua.crofts1@gmail.com>
> 
> Add comment to mutex per checkpatch.pl report.
> 
> No functional change.
> 
> Reviewed-by: Maxwell Doose <m32285159@gmail.com>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  drivers/iio/light/opt3001.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> index ac1c7ba5679867f6b814894680e317615f2e373b..9d24d7a23ef00d160fdae737b6ea1943576a3fcf 100644
> --- a/drivers/iio/light/opt3001.c
> +++ b/drivers/iio/light/opt3001.c
> @@ -103,6 +103,7 @@ struct opt3001_chip_info {
>  struct opt3001 {
>  	struct i2c_client	*client;
>  
> +	/* Mutex for ensuring one executed command at a time */

The device uses a 'register' type control scheme rather than
command based. So I'm not sure what intended meaning of this is.
I'd say something like

	/*
	 * Ensure data capture sequences and read-modify-write
	 * sequences are not interrupted.
	 */

At least from glancing at the driver I think that's why it's there.

>  	struct mutex		lock;
>  	bool			ok_to_ignore_lock;
This one is odd enough and coupled with the lock. Either comment on both of them
to say how they interact or add two comments.

>  	bool			result_ready;
> 

