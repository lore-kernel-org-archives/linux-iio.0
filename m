Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81471406276;
	Tue, 28 Apr 2026 18:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777400806; cv=none; b=ce/0R3hcHpvfRyTpD5HOsKrLUy3YHsH+tmsj+wshqwG/6JYtCA6NdPttojLrk8GkEFx2IdF/qoDKKZWPwgU06OQwGO+VjR4bcskL43M9KtnbulXabktOtsqKlqZZOyfcC8N9ivH2vNDyH1zXhn0DYynGH7LHkY8M8zmHplyhSeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777400806; c=relaxed/simple;
	bh=Ja9LxXT4w36gaxdKavCQ8JNjUMNTrtfcd8kywyETbT8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KjjAMb7+9k3mFIgAB6Mx95So5B79ORoUs0tuuyYvk7H+me9QgobU/dKmbE5qV/vQuf67F+36i0Q28TvDmJrHKzVrtT6q8Lp/zsR/MQ3/bDOK/N0c6MrlVQ8aZZELsoGBOPYz866iU8aY27XfUG/Hqds3aHC/zG9LMQvXhJrV5t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CM0QIPdq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CM0QIPdq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E275C2BCAF;
	Tue, 28 Apr 2026 18:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777400806;
	bh=Ja9LxXT4w36gaxdKavCQ8JNjUMNTrtfcd8kywyETbT8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CM0QIPdqGXecOtiMZaT+tv6lBjAmFWSmU/ucd2FpYKBa3vt3B2jA+AVVi5oWh4U8X
	 gHB9j3PlAyFaFq2/Zcd0mf0AIzRk4CjFCYjRSgI4JkxiclHnaFmlHzscr+yVdq3AhJ
	 fUelN+mVjuFOu+V3tnAy1Lg1oMxiHIT/Y3TNu3dKeDXxWf00OaMPEDTXL2vEJ6wCmt
	 isRZZm8v3DTMrRlosLMKZounWUf/RygslBmHQsgDRIc/KwEKrLu7/r25QPPiPQ3GwX
	 Ha8De6WMF/ISQS+IkJs/MVbVWmPvLnMtVeo3BpViyJ9lQbw5TTletDs2Lfi0ZjDW0N
	 /qu5wJdRSLXnQ==
Date: Tue, 28 Apr 2026 19:26:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Felix Gu <ustc.gu@gmail.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Arnaud Pouliquen
 <arnaud.pouliquen@st.com>, Mark Brown <broonie@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Roman Gushchin
 <roman.gushchin@linux.dev>
Subject: Re: [PATCH] iio: buffer: hw-consumer: fix use-after-free in error
 path
Message-ID: <20260428192636.58e4fc8b@jic23-huawei>
In-Reply-To: <afDZYNprYaQzcfpf@ashevche-desk.local>
References: <20260428-iio-buf-v1-1-dcc63ff7b800@gmail.com>
	<afDZYNprYaQzcfpf@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Apr 2026 18:59:28 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Apr 28, 2026 at 10:53:25PM +0800, Felix Gu wrote:
> > In the err_put_buffers cleanup path of iio_hw_consumer_alloc(), the code
> > was using list_for_each_entry() to iterate through buffers while calling
> > iio_buffer_put() which can free the current buffer if refcount drops to 0.
> > The list_for_each_entry() loop macro then evaluates buf->head.next to
> > continue iteration, accessing the freed buffer.
> > 
> > Fix this by using list_for_each_entry_safe().
> > 
> > Closes:https://sashiko.dev/#/patchset/20260427-iio_buf-v1-1-2bbdac844647%40gmail.com  
> 
> Format is wrong, missing space.
> 
> >   
> 
> Tag block should have no blank lines.
> 
> > Fixes: 48b66f8f936f ("iio: Add hardware consumer buffer support")
> > Signed-off-by: Felix Gu <ustc.gu@gmail.com>  
> 
> I am also wondering should we put Reported-by with the reference to AI somehow?
> Jonathan, others, what are your opinions?

Would be nice to do so for these - things noticed whilst reviewing a patch
type reports.

Roman (+CC), any suggestions on how to do this?


> 
> ...
> 
> > -	struct hw_consumer_buffer *buf;
> > +	struct hw_consumer_buffer *buf, *n;  
> 
> Please, name it rather *tmp.
> 
> >  {  
> 

