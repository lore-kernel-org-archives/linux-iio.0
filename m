Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64CF3AF660
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 14:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778855061; cv=none; b=lN4rh0+KhMaOfo6SjDVhAg8dVxVecKpJhqe5MP12lNAVeRoGcFutpgEloWbwSw7/3UsYwORXVHIUaVFzCHkD4kJxmK1z3fEZ2TS5yum/2A1u/rm1wXS8X5AMW1hu23+t5C40pDGQMPtyQgvwhpBygrDqxAZCn0RghkfetjGwcHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778855061; c=relaxed/simple;
	bh=YN70OJCo6M6JQ2rfVVZV+KksqDxFo5TpXQ4uylIJQMY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CrcjmJsKBWh5C0dP6A0cAOiHLY3ni7YiKb4r7Izo0gKgrobdwqo9uw9+jAsh+K5Vh4cAX/xXcCVAgaxAc0L9GcDbopJkZ/tGxC284zIbdSgFw0AfIqDqa/OgpQ5SeNjb7gw14sZ1FZrZF15Y9B5tLWF0z69zSxOIBBwDF/121Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9DEUSNc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9DEUSNc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BF5C2BCB7;
	Fri, 15 May 2026 14:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778855061;
	bh=YN70OJCo6M6JQ2rfVVZV+KksqDxFo5TpXQ4uylIJQMY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T9DEUSNcxsQW+OppHxKIIWtK/3nnoXa1fmeiHprP4aC2rIYeO/7nzCiPa56K64D2i
	 /KnAStQdWbnyolp0IFC7FMcOqMjh5I1dQPf4tllPKWDIZECPflJmC7hDcO8lHQoEEw
	 wYg/T9q4aGtJ7UXRcKsKE1kG5XUSUzFcbq0wKESz0bcm4HZ99NZUcNLj3Vp1+18Mf2
	 t7Bb3U+G4MLqCXHGu73Sj6DwC0uW0jeB8nbE/02klIaQN5j6o+G/JgggZHs1SI48E/
	 A/1ItJS6vQEkuhdo0WJv93VWmnkeQeK4JWadbBpz13D7qxt7Nd0qLvHrR3StD60KpM
	 00zKgQKV5Wr9w==
Date: Fri, 15 May 2026 15:24:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Raffael Raiel Trindade <raffaelraiel@usp.br>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, Kim Carvalho
 <kim.ca@usp.br>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v6] iio: light: vcnl4000: use lock guard()
Message-ID: <20260515152414.5c8dfebb@jic23-huawei>
In-Reply-To: <20260514201312.678131-1-raffaelraiel@usp.br>
References: <20260514201312.678131-1-raffaelraiel@usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 May 2026 17:11:49 -0300
Raffael Raiel Trindade <raffaelraiel@usp.br> wrote:

> From: Raffael Raiel Trindade <raffaelraiel@usp.br>
> 
> Use guard() and scoped_guard() for handling mutex lock instead of manually
> locking and unlocking. Remove gotos in error handling logic. This prevents
> forgotten locks on early exits.
> 
> Signed-off-by: Raffael Raiel Trindade <raffaelraiel@usp.br>
> Co-developed-by: Kim Carvalho <kim.ca@usp.br>
> Signed-off-by: Kim Carvalho <kim.ca@usp.br>
Applied to the testing branch of iio.git.

Thanks

Jonathan
