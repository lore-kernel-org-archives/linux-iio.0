Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4824F2580CF;
	Sat, 16 May 2026 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778933425; cv=none; b=XKaKq5OleNEGGSp32S/DZNxiX5zHMpaipuEuIraT08sIzUcan3OjrEolxnvoqBb3BnFPXglAgB0tws0bfSqU2nlBIGwK9yd+w3pYKVgZ89OSNBrqcyNRbzCZLVPCX0F3Fb7fIFBEOe6Huqj4vmYldJNJ8ONgKYEJCv6MDNjwsp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778933425; c=relaxed/simple;
	bh=Y4qnwMbeKZRjTVx0CxmZ9xmjEegISLUEnKnsvwK8gjk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lwJXLtjt/0egdTOjxZasryQirzXieo8TVND7nkuEnwdbOlOZUuJOE7V+ixuJPLX84AUmx5EJvj6uLh1pqDY3qFDAE+BYvZQPAIyaJwfCCkxj1ANtCXwW/L9Vutylk4GqGf3/zOoIV8S48gmXkDxMlKGjvIxClLag0YHobUHzTvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbiDy3uF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbiDy3uF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3896C19425;
	Sat, 16 May 2026 12:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778933425;
	bh=Y4qnwMbeKZRjTVx0CxmZ9xmjEegISLUEnKnsvwK8gjk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bbiDy3uF23dEt5TDGE8A9YT+rF5FvET6iRVnxltCpSUriRBh+CPZwMOyEkEm87K0h
	 IEviLnDeM5M9OjEBguckqmW7rS5s8W7D3njy82hi91/N2RftUegSSXH09oMR8OZ0Ht
	 rU2VPKVtb7NrO3jWOZH4BM/HwnDi0yboP/JaZxAGBGOdzXCGntkkrOBiK4a8gt0h1n
	 GNs6wy/TybJlVlJPuyNQMTRY4jZnvk5AjxvVn6GLjnO716c4nkhMAdI7Q1c+8fmvf8
	 vFH7gJUZHSoVSzaXUy2XOFoGraWHA1EMJR6lLY/jJ/MLxFJPO4sl8YBMzCsJZYCtwT
	 6Ans/Wcb8XBxA==
Date: Sat, 16 May 2026 13:10:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Alexander Koch <mail@alexanderkoch.net>, Michael Hornung
 <mhornung.linux@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/10] iio: light: opt3001: switch driver to managed
 resources
Message-ID: <20260516131017.3de30733@jic23-huawei>
In-Reply-To: <20260512152600.764ff7c7@jic23-huawei>
References: <20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com>
	<20260512-opt3001-cleanup-v2-9-8018cf3a8a0a@gmail.com>
	<20260512152600.764ff7c7@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 May 2026 15:26:00 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 12 May 2026 12:57:29 +0200
> Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
> 
> > From: Joshua Crofts <joshua.crofts1@gmail.com>
> > 
> > Move the driver to use devm_* functions to automate resource
> > management and simplify error handling. This also allows removal
> > of the opt3001_remove() function.
> > 
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>  
> Some trivial stuff inline.  I'll probably wait for sashiko to catch up with
> it's backlog and get to this one.  If nothing comes up there or in other reviews
> I'm fine tweaking the stuff below whilst applying the series.
> 
Sashiko did come back with a lifetime issue.

I think it's a false positive as there aren't any workqueues or similar
that might still be active. IRQs will long have been cleaned up before
the mutex_destroy() occurs.

Anyhow, do take a look 
https://sashiko.dev/#/patchset/20260512-opt3001-cleanup-v2-0-8018cf3a8a0a%40gmail.com
and make sure I'm not missing anything!

Jonathan
