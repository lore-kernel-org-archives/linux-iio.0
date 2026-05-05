Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18817339863;
	Tue,  5 May 2026 12:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984767; cv=none; b=IG3kn6WGftoU2oyo55Om/GKixJSIREGm7Q9Hfgzi8lmH8qXRwsbXwPdcQbccQ8ZI/nL1ikZIgCwyUDGVaCwNkanzOwZJH7G4uZBnbcoJjdF6i/oZ6vXR/2+5npVubul6UvkT6lFoiChaLPJFCJJr+9w73AR4S5zvoHfMoKiLwb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984767; c=relaxed/simple;
	bh=+Zsz0dFBU266SJ4Zp4XhgBL/ynv/fDn/9u9HJhGm7lA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pp528C1wDnVvmHugZY6lukSV+fewmdLfkMOMn89YISmlxTb0BPrZaeKVylcYgqsqrdi45BYSHSizau/1Gao7e97FM0kkGbfkZbCPIfdu+gmIdVusTVF5GW/TUA/E98qM17U8VlqvYW2NFemSRn0TShIr7ikmk/tZO5YG9gTQocU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJf9FdWT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJf9FdWT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE88DC2BCB9;
	Tue,  5 May 2026 12:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777984766;
	bh=+Zsz0dFBU266SJ4Zp4XhgBL/ynv/fDn/9u9HJhGm7lA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rJf9FdWTimy82KJY+Sxprs4Ta97S7139TSvqZneh8uvWkb2Rg4l7FBOXErNTEWh+o
	 /U2ScB/gneBN+MdVvnJK9FKP3hcVqR49IR76D4HnYimZwVK8CFh8TxQw+Vy4wW0GM7
	 oNOSBrn1ctPvhuYtNJBZpJlhymFtG0vXU+IgB0/krjAvkiWQrCGaDwOLQtsJFHAjuQ
	 njX47DYAb/M0cbmONMOtLzRLcw7bSpT0bztQeYWFBGExmzKFhDpwOxnpyl/VuMeFg5
	 cyJ3IKbaIb228hPiGF1PaLEUb/zchaWWwGLEHnh83udkK8XDV/vQFlqrZnwt1mSSKB
	 +9bWbLe9s2zjQ==
Date: Tue, 5 May 2026 13:39:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Maxwell Doose" <m32285159@gmail.com>
Cc: "Felix Gu" <ustc.gu@gmail.com>, "David Lechner" <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Lars-Peter Clausen" <lars@metafoo.de>, "Arnaud
 Pouliquen" <arnaud.pouliquen@st.com>, "Mark Brown" <broonie@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "sashiko"
 <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2] iio: buffer: hw-consumer: fix use-after-free in
 error path
Message-ID: <20260505133917.78e01a54@jic23-huawei>
In-Reply-To: <DI6Y78RY6DRL.HBDGRFK0BCFO@gmail.com>
References: <20260430-iio-buf-v2-1-84c2231dea5e@gmail.com>
	<DI6Y78RY6DRL.HBDGRFK0BCFO@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Apr 2026 20:27:27 -0500
"Maxwell Doose" <m32285159@gmail.com> wrote:

> On Thu Apr 30, 2026 at 8:29 AM CDT, Felix Gu wrote:
> > In the err_put_buffers cleanup path of iio_hw_consumer_alloc(), the code
> > was using list_for_each_entry() to iterate through buffers while calling
> > iio_buffer_put() which can free the current buffer if refcount drops to 0=  
> .
> > The list_for_each_entry() loop macro then evaluates buf->head.next to
> > continue iteration, accessing the freed buffer.
> >
> > Fix this by using list_for_each_entry_safe().
> >
> > Fixes: 48b66f8f936f ("iio: Add hardware consumer buffer support")
> > Reported-by: sashiko <sashiko-bot@kernel.org>
> > Closes: https://sashiko.dev/#/patchset/20260427-iio_buf-v1-1-2bbdac844647@gmail.com
> > Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> > ---
> > Changes in v2:
> > - Fix Andy's comment.
> > - Add Reported-by tag.
> > - Link to v1: https://lore.kernel.org/r/20260428-iio-buf-v1-1-dcc63ff7b80@gmail.com
> > ---
> >  drivers/iio/buffer/industrialio-hw-consumer.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >  
> 
> Looks fine to me.
> 
> Reviewed-by: Maxwell Doose <m32285159@gmail.com>
> 
> best regards,
> maxwell
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks

J
> 
> 
> 
> > Best regards,
> > --=
> > Felix Gu <ustc.gu@gmail.com>  
> 

