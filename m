Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C961647DD72;
	Wed,  6 May 2026 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778085634; cv=none; b=AjSXXQjqk7EP7VJUMhbibLszPI0scqv90Av8H/FybaGt/iBM55pmswmrulizYHz8ezlSiv2Ij9as/smFzAZ7Mcxd/cjOnJThpmALn1a2Ap2jXJu7JocR+QaZKsFoJ7bTayCpIpE2XfxlWp0YB+Ci/jqAQ76iW3WigHyH7b+HaaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778085634; c=relaxed/simple;
	bh=kuTlo/sqlL3+ArcBsIOU1q77znpZbKHKmV2IWwpMQIM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=redNvLnQEliUNhLfe8I1iKM2IgnJeVpaIW+6q1AB2qimzB1O+dI2b97z+QSODwCl6x/IqxbqO8iTJov8qXmzUHyClBlwVEbIP/DHsAN5EnqXwfA47GR8etDUrB1GkH/TuPYeEeOYhUMKN/TzVEiKLEGR6Br7mQ64FISEhDFzcRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsGZvXz7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsGZvXz7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1BDC2BCB0;
	Wed,  6 May 2026 16:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778085634;
	bh=kuTlo/sqlL3+ArcBsIOU1q77znpZbKHKmV2IWwpMQIM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UsGZvXz7bYVKVz3ZfZedewt7KP7ObDGUJOqq5pPazLA1SkSPQK1FsEFKK5a+mvjE1
	 3OlH0zoui8EvhwJl25g5Dbu4emBm68N5b0WPv2ynaGcAqIaPFJq3ZpXiLMWfDf7Lf6
	 IgvEWeXhp+0yy5kbsq+614kAog1Xwa0L8xm3lWc5gSreezC9ABo9I07miSiz/plXYE
	 1LTJmXddUtjXgfEfARjQb4aDph3OwIqyyidAFawuRl+pFXNMPvvmBuRNXk12RKbQ4C
	 7lMsr4sR6xsXKKqYkEaZkHg3BV6EueqWBeraG9KNbYhVlgK7Sx1MkS3N1s9TgPh+3F
	 LQL+HtTq2qgJw==
Date: Wed, 6 May 2026 17:40:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 04/18] iio: magnetometer: ak8975: change 'u8*' to 'u8
 *' in cast
Message-ID: <20260506174027.493f451d@jic23-huawei>
In-Reply-To: <afrgHtgLZMEDT1j1@ashevche-desk.local>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
	<20260505-magnetometer-fixes-v5-4-831b9b5550fc@gmail.com>
	<afrgHtgLZMEDT1j1@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 May 2026 09:30:54 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, May 05, 2026 at 01:46:00PM +0200, Joshua Crofts via B4 Relay wrote:
> 
> > Change 'u8*' cast to 'u8 *' as the former triggers a checkpatch error.
> > Also fix the indentation of parameters in
> > i2c_smbus_read_i2c_block_data_or_emulated() function.
> > 
> > No functional change.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Applied.

