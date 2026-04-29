Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D010C3BE621;
	Wed, 29 Apr 2026 09:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454548; cv=none; b=hvSWFFYn2NmPBBmJdTKwj9URnST9m+ZKcHo/F7TW0s643zKyzyELMKXe22Ldx9iAEKpzijJmvgog5FbBcu2T5lZTSyTWOL/UWHxjPuyjHQH5FQ7UnoLoo7vZzllmgB2sS5tf2UB3sD0mId0XG1sSFlx8RaLfSCXtHXnI9GF5JPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454548; c=relaxed/simple;
	bh=dCzNgsKOJBfw/h4e7MqkL6Hp01k50ArFr9gmVclJFh8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZASLuMcoKOGcyNfU6cXX6GEpVl5LhiNmuLNxyKzhXDdbIdWV42oI2qTWzxJVIgRn3D9n3LZe9NdT9xtX0PIz+Na0XY/0kMQJxWGkdDkvhG3e/vstMHjsHfvjePO7U7IGeWUKuWtJ9TvijKF9UoX6yZL4oDFSQmAvyj6/EjPsmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYMnUpBt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYMnUpBt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A008C19425;
	Wed, 29 Apr 2026 09:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777454548;
	bh=dCzNgsKOJBfw/h4e7MqkL6Hp01k50ArFr9gmVclJFh8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aYMnUpBtX1CpZ+RIrnaysLIRSf+Gd8CmU5SXJ1YtOJPCdKV1DV1K4ogTbwAlzblvv
	 y6FJJnb5TXIKWqf+I68aifjpexsFNTBjMmsciFlk6BtDFuK6O13DKQCI6pFp0F9wFl
	 ZqBRwBLY6VhL1kp58NT6llB3UxnDa7V9dlj0xXFxgYv2zsyEGhb8WZC6EG76v1l1+d
	 5jyreriulgO3syBgb4gukGBQD22D3QRLO38pmE442kBDarvu/1Oofh7CusqEXwmEcg
	 eKqqE0paqDnvH/97Q4n2jo+yhWOrQ07D+WfN0iMheaeTXT/l2ch/nFU9Yc21cP49uM
	 jRa1UtDDd/4XQ==
Date: Wed, 29 Apr 2026 10:22:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Felix Gu <ustc.gu@gmail.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: buffer: hw-consumer: free scan_mask on buffer
 release
Message-ID: <20260429102220.03b73286@jic23-huawei>
In-Reply-To: <afGtkEBzGzpqB8cc@ashevche-desk.local>
References: <20260427-iio_buf-v1-1-2bbdac844647@gmail.com>
	<20260428182858.7d7e1034@jic23-huawei>
	<afGtkEBzGzpqB8cc@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Apr 2026 10:04:48 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Apr 28, 2026 at 06:28:58PM +0100, Jonathan Cameron wrote:
> > On Mon, 27 Apr 2026 19:11:39 +0800
> > Felix Gu <ustc.gu@gmail.com> wrote:
> >   
> > > The scan_mask lifetime changed in commit 9a2e1233d38c ("iio: buffer:
> > > hw-consumer: remove redundant scan_mask flexible array").
> > > 
> > > Before that change, the scan mask storage was embedded in struct
> > > hw_consumer_buffer, so iio_hw_buf_release() could free the whole
> > > allocation with a single kfree(hw_buf).  
> >   
> > > That commit moved the scan mask to a separate bitmap_zalloc() allocation  
> >   
> > > stored in buffer.scan_mask, but left iio_hw_buf_release() unchanged.  
> > 
> > Hmm. This reuse of a pointer that is otherwise set via very different
> > paths sent me down a wild goose chase.
> > 
> > Patch seems fine, but I'd like Nuno to take a quick look before I pick it up.  
> 
> Yeah, more eyeballs is better here. I spent like an hour to understand
> mysterious ways of scan_mask in IIO (we have a few of them and we have a few
> objects based on struct iio_buffer), and we have constructors/destructors for
> those objects which of that is responsible to handle scan_mask as appropriate.

Likewise on time to understand this and I wrote some of them :(

> 
> May be all of this is documented somewhere?.. Dunno.

Have a guess :(  Nope.  This one is downright odd and only really exists
to leverage some helper functions.   With hindsight I think maybe we'd
be better of separating it out so it doesn't use the same structure.

But for now we need a fix.


> 
> > > Free the scan mask in iio_hw_buf_release() before freeing the buffer
> > > wrapper.  
> 

