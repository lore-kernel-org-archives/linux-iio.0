Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE6F39BA52;
	Thu, 22 Jan 2026 19:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769111671; cv=none; b=du4ht3JOBKtzDlqGW4v1R7VB54aA99NbZ3GG04AHNkNZhngcT8gZ5TorcmM5GdOrA66uGxfGBgaevhnJhAqQZh+MtQ3qlAOay/vBiSEWpBsJ52qldO0byW+X673xwug9ANHzVoJ8RzVhnxtZtxF05KVGWf5BA3zskX/RplOuIZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769111671; c=relaxed/simple;
	bh=hatfovsPRhyp9G47SP3JOu4AZYQGg+kg1WpUDtCT/i4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AckBERq08oZ4b/iJm4Hfv8dFxWz/x/HE/cqPD4tXxjQA/lx2yLoAHxY5oybTAc327VVf24fsk04y+Hl/wfYmqaJfpd7ymFHr3gWlP6jqHBRrdonxkgwkrDf3Bp23SYtLzKmnkCZTvOE0JhU5Nk4mtrg6/8D/xe+It4Bwy0QPjNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPkMYQsP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPkMYQsP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CEAEC116C6;
	Thu, 22 Jan 2026 19:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769111670;
	bh=hatfovsPRhyp9G47SP3JOu4AZYQGg+kg1WpUDtCT/i4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PPkMYQsPOM2ifgJ8m80in6fp2blFd5jZglerRJQ8ajfQmE1eAkE4rEgocQ1mTqZO/
	 o+S4e7nvGH9dYxA9EXy77t3N/h0XTgmfwefv13AVglr9CgFjI92RvWw2F4llmOMm4x
	 7K24wIZyl+kk6oyVFw/ukfAJPnbez2HnFgG/JDjPVXxfeymDcBzx1WH+WjIEb2IpKN
	 TEs8eCgNf3Z8UyV9wvbd3V+voQ/up4wPdNoT/Mq2VL4tMxXf50/AeQpAfMIKiqFTwL
	 yisjppXL9bRrQwc08lpz5cNOpfR8tGznMAO+fBzn4+rOq+stldak+4xMSTzILZPRdZ
	 BOfL0xv7ANkkA==
Date: Thu, 22 Jan 2026 19:54:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] accel: adxl380: Improve data reading from FIFO
Message-ID: <20260122195423.692d90ec@jic23-huawei>
In-Reply-To: <20260119102317.1565417-1-flavra@baylibre.com>
References: <20260119102317.1565417-1-flavra@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Jan 2026 11:23:15 +0100
Francesco Lavra <flavra@baylibre.com> wrote:

> Patch 1 fixes a bug that might cause the adxl380 interrupt handler
> to read from the sensor FIFO more entries than actually present.
> Patch 2 optimizes transfer of FIFO data by minimizing transport protocol
> overhead.
> 
> Changes from v1 [1]:
> - replaced 2 with sizeof(*st->fifo_buf) in adxl380_irq_handler (Jonathan)
> 
> [1] https://lore.kernel.org/linux-iio/20260106193627.3989930-1-flavra@baylibre.com/T/
Series applied.

Given timing I've queued it up on the testing (soon to be togreg) branch of iio.git
but marked the first patch for stable so that it'll get backported after the merge
window.

Thanks,

Jonathan

> 
> Francesco Lavra (2):
>   iio: accel: adxl380: Avoid reading more entries than present in FIFO
>   iio: accel: adxl380: Optimize reading of FIFO entries in interrupt
>     handler
> 
>  drivers/iio/accel/adxl380.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 

