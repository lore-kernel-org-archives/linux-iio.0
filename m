Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CA514E2F2;
	Thu, 29 Jan 2026 16:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769703147; cv=none; b=jALM2sTmVnRqA9f0uw947lW3I7TkHNhjbgUY3YN897MMkUEoXQNGbOwl+nHVdnpLRaitLiQTEYlaQAt4W6O3lEqdmXV4lBoi7qXuYGmIXBRs9Z9ulWwtZtqYXzKDVofmOuHiX+uiyVZMK1T8fd9nJHuKEoO34A+GXXdi/xYCNhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769703147; c=relaxed/simple;
	bh=6ETg/2bx8w1l/epP2HPg/n6DzFYAeYAyOcyEgxUHEO0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WER+cWAf4Oi4ashiMogAkBBBunBldLvN6hNKIF/iTOyq/cuBFeIT70br3kT06WD8oo8YTN74tCyvc0qq8U+s2T1gdwpVK6cBNfRck12VKTLV72LJfTkzfrzNIZmCq83SA+2s6oYxPun9RZ6inqiRwqRcXBccJUKp6BnB1773O5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPrCTckN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPrCTckN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E53C4CEF7;
	Thu, 29 Jan 2026 16:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769703146;
	bh=6ETg/2bx8w1l/epP2HPg/n6DzFYAeYAyOcyEgxUHEO0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hPrCTckNvwzGh+xMxhHpTgzn7uXSVnAUsWugHx6qH55r8DpQsH/GHmXTvy69zcMW7
	 4KOQfERWrjXdprDPvph3XXizln2CGxiURpeinMdk2tuAX1tCOh7PEyqX0Rz7kug7+S
	 RBvzIB65Yq+vvBlUWioD7G/E9jumYsn/t+/zVeIF4RwmOpWcZOeKd4zRreWqIWn3OS
	 3g6HQIp8kr8Y0EtYaUo3luOzk7wj/lRunFVmv/Bw3Qi4TifLM4ncTyBv5Yjhmpyv2T
	 QmGGf80fA40w22ZSfIDuCFSZPRPwEpxO86K5oTicbQQt0dqxPl+LUmm/qLyikF29l6
	 r/VbLS0ZxajuQ==
Date: Thu, 29 Jan 2026 16:12:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, "Thomas Gleixner" <tglx@kernel.org>, Andy
 Shevchenko <andriy.shevchenko@intel.com>, Marcus Folkesson
 <marcus.folkesson@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Puranjay Mohan
 <puranjay@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>, Kent Gustavsson
 <kent@minoris.se>, Gustavo Silva <gustavograzs@gmail.com>, Nishant Malpani
 <nish.malpani25@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 17/20] iio: Replace IRQF_ONESHOT with IRQF_NO_THREAD
Message-ID: <20260129161215.03f71a7f@jic23-huawei>
In-Reply-To: <20260128095540.863589-18-bigeasy@linutronix.de>
References: <20260128095540.863589-1-bigeasy@linutronix.de>
	<20260128095540.863589-18-bigeasy@linutronix.de>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Jan 2026 10:55:37 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> Passing IRQF_ONESHOT ensures that the interrupt source is masked until
> the secondary (threaded) handler is done. If only a primary handler is
> used then the flag makes no sense because the interrupt can not fire
> (again) while its handler is running.
> The flag also disallows force-threading of the primary handler and the
> irq-core will warn about this.
> 
> The intention here was probably not allowing forced-threading for
> handlers such as iio_trigger_generic_data_rdy_poll() will intends to
> invoke hard-interrupt handlers.
> 
> Replace IRQF_ONESHOT with IRQF_NO_THREAD.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Applied

Thanks.
