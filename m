Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111563DAAB4;
	Tue,  4 Aug 2026 23:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785885953; cv=none; b=o6dzX1Cq3yszKTBetj1trViSpIoeyjzV8I/VubS2WfBqvwQzQuTcYqfKBRzPjHnbw3iQGJiHs3PBvB5OzwsbIE/qapxrFtcfvDr8OBAj1a7nWpBG7Fi8ggoQI8MHvyUMPkxmG1eMGrMiAi1sg4w8s2RIQOzfgKaBDwdV4k/5ijo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785885953; c=relaxed/simple;
	bh=N+mIEMu6JBxRJzJCdEqmCj7qqXRc8g74EQ7haF39uqk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CYybKtua/tQxUPORm9rcaYhkQxynmibMWaFUdtLlN5gYOKx6tuRwXpuMg52ijYIVUf1UGpBQxPrC4/lf/UpbbGbEPocVbkYyPucJGQrw+IeDgggzQEH22DiDwezxf/TZsg8woCKHweYuQFYMZ4bgmoBTotGA8xZNfWmwpvXuLGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxw2aZQW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxw2aZQW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97161F000E9;
	Tue,  4 Aug 2026 23:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785885951;
	bh=T1kGO2uPv0CMMTMFg2kGHsJvcFPkb2s8A9cWD/GS+us=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hxw2aZQWTYHSQv0gIlmnFT593Drgei6XEV6pZP+LqlFJaXMif4LC+NG62Cy4zSF0F
	 BlSwpDk6mmSQw2/HB8WeHOJbVOYFYtkF8HgnoNIEOp9B13q3/XNCgWgH+m0NmcaGZm
	 m0JmeViWIoITHkCeEUhGhffPavrvZWg1AZTN1CmhZ+qEhFuFRwM53O/n9OlRJ+Y+BD
	 IqbAeMGU/8rxB0EsLrseBJo00Xdli4T4C8VE0KIToDJ+bBu5ec4dA4yvHMniZ3I47g
	 KzgEFsTjU6MYCvoU/3iFPxSdUm0K+DrVSL2ZXjIk4EMbCtBRsBPb8K3QLp3aMExxR5
	 mKXQugieRPt4Q==
Date: Wed, 5 Aug 2026 00:25:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marco Chen <marcochen.dev@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 pmeerw@pmeerw.net, matt@ranostay.sg, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v1] iio: health: max30102: fix NULL dereference in
 interrupt handler
Message-ID: <20260805002548.01ff7177@jic23-huawei>
In-Reply-To: <anADiCtmoVbT0o2F@xiaolong>
References: <20260731184124.112124-1-marcochen.dev@gmail.com>
	<20260802032609.27900bb9@jic23-huawei>
	<anADiCtmoVbT0o2F@xiaolong>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Aug 2026 00:13:33 -0400
Marco Chen <marcochen.dev@gmail.com> wrote:

> On Sun, Aug 02, 2026 at 03:26:09AM +0100, Jonathan Cameron wrote:
> > > +	if (!indio_dev->active_scan_mask) {  
> > 
> > That is racy as this could be going on in parallel with the buffer being disabled
> > so we check here but it's gone before it is accessed.  
> 
> I understand what you mean. I will remove this active_scan_mask check.
> 
> > Which leads me to suggest alternative fix - check INT_STATUS and if nothing
> > set it isn't our interrupt.  That doesn't get into the potential buffer
> > enabled / disabled races but should close your condition I think
> > - looks like it is read in the fifo part below. You may need to refactor a
> > little to not read it twice.  
> 
> This makes a lot of sense. For the v2 patch, I will plan to read
> INT_STATUS once at the top of the handler and pass that value into
> max30102_fifo_count() so it is not read twice. Consequently I will
> remove the INT_STATUS read from max30102_fifo_count(), too.
> 
> For checking INT_STATUS to see if it isn't our interrupt, instead of
> checking if nothing is set, I was thinking to check the
> MAX30102_REG_INT_STATUS_FIFO_RDY bit specifically because that is the 
> only interrupt enabled in max30102_chip_init().

Agreed. That is a better solution than mine :)

> 
> This will close the reproducer I was hitting earlier as you said. Since
> we only ever reach bitmap_weight() when FIFO_RDY is set, the NULL dereference
> is avoided. I think there is a theoretical window if the buffer is disabled
> between the FIFO_RDY check and bitmap_weight() call, but as you said,
> closing this would need the buffered mode claim. I plan to leave that
> out of this fix.

