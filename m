Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8B73A9607;
	Thu, 22 Jan 2026 20:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769115476; cv=none; b=lQlVuoIUOjuN/zRDpo94yg1FjMrgh6M9m37QJCSsZUwAKv37HefMzZTm+bHf94ptLvMvzkKZ8wxzFkgtouwfTlMf2nFS3FoTCsjA5sh0XoBvfeHm++R5c0K2AeyU4NZcSy7QFHMOGCFVwHzk+8vN3/O6/Z+w8WF8p4u1Iypsm3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769115476; c=relaxed/simple;
	bh=pTPL7nVsImJWMOB0cVvoWG+SuoHnHciJx0XfwtWIsAk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PJRW8plNkBBCjXLAtUT2f6S5iF6YopFAvMc6mTKMucZkFKhRwvaTdHuLHR5wHSGUDuuhRFV1DsKbZYUDjAswq5m1iiXdrDRX1DlzEvNDYidxD/N5zHzpn2dcO198Ggy6OtVnDei0T5cinVEG3MNbU4eRLf/lGOJbo8iY1PCZz9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acHYxkHz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acHYxkHz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE964C116C6;
	Thu, 22 Jan 2026 20:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769115476;
	bh=pTPL7nVsImJWMOB0cVvoWG+SuoHnHciJx0XfwtWIsAk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=acHYxkHzbBUj38AKPiAWnaH7HnhvvZT3YrmyM/MlISD9im5tjkZJ/0tmvvpMqU4b/
	 z1nmUAaWYd/u+oR7i156uUB1LkYKfZSO/sqBiT4prqhnsmhiflQ0Y6QpK32BcpifPx
	 1xceVPfzO286Dv45qWkdCRcw56jcoNTiiqs9NpTaG4+tYzoS1drJnWB9T5GO26Tuoq
	 eykoR0Wl1spKJJ+UgVm8rNbH6pnOGncVU1y+AUiDWM9R1h16+lQbJcxlIN6K7o5el+
	 5B441qxEWICzXLWd6FN9JLXxO8EeIhu/p4kwEjbYCY/ka1CjOHdmp1rK7QM6jw9Agx
	 ShE7K1IgrKU8g==
Date: Thu, 22 Jan 2026 20:57:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: raskar.shree97@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/5] iio: proximity: rfd77402: Reorder header
 includes
Message-ID: <20260122205749.4f939243@jic23-huawei>
In-Reply-To: <aXCUKMcCyYBf4ZdJ@smile.fi.intel.com>
References: <20260121-b4-rfd77402_v5-v6-0-5b944d0605dd@gmail.com>
	<20260121-b4-rfd77402_v5-v6-1-5b944d0605dd@gmail.com>
	<aXCUKMcCyYBf4ZdJ@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jan 2026 10:54:00 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Jan 21, 2026 at 02:05:41AM +0530, Shrikant Raskar via B4 Relay wrote:
> 
> > Reorder header includes to follow kernel include
> > ordering conventions.  
> 
> FWIW,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

Patches 1 and 2 were already queued up.  I've rebuilt the merge
in my tree to drop patch 2 without breaking the rest of the history.

Shrikant, it is common for maintainer to pick up the early
part of a series whilst later parts still need more work.
If that happens, please rebase on the appropriate tree or
just drop those patches form your series that have already been
applied. Otherwise this mess happens where new review comes
in. Review is always good, but it should be clear if it
is on applied patches or not!

Jonathan
