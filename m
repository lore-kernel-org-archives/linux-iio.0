Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3231D247291
	for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 05:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781416655; cv=none; b=Prcb30yYBGyseQfQtlptH0QdIxqIBXh+hvDqrBODv0sS1BSMRZs2OzJT/JjZF+ckDZCF2UYfiYkvzkhv4F0qKRNtalKtkLcK1SGOA/B/XhcE7png9gERO+6bFspTxgWyIZQ6wbDFWQv5cla3jph03vH+YHpHyy+IOETVKLoPvEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781416655; c=relaxed/simple;
	bh=pbz6P86RgnamRdlbGB4RjGbZ9JA7M01FmqxRp98j+No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdpfDS9cnbSAoNCbswPc/OlX74vd9vBcbaQR7cUxqFHcOAxyCgeaidkOFfo8NORpBviiUNjPB1XVgBXOP/3eUWpKVdjhidqzvUO+0mm2bFpUcV6gIC6OBvoLUP+T9YOjvyzg0Q91TL3AT+xSUJlR5VsnTsTgXKvt5SMf1dnW0vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O/Cr9Ab+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O/Cr9Ab+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252D81F000E9;
	Sun, 14 Jun 2026 05:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781416653;
	bh=E8oVs44uVI7TLSkF5uHRhT433pHsJNZZ47ey07OMI50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O/Cr9Ab+uqj8vVsk3VzWB5tJWActF4medJm1ngC5b2gn0CjKIbWm0vo8OcMd+O3td
	 e1E+N9CtrZXQddKXDJ7wPT67U7r1I5cHWzJfLmuqM/4Pgxvrcu0wc+dCoS+8kF2GUu
	 YDtVn0Z8ploFe4jMo+XCCcT5yKghitH6kXUlR+Io=
Date: Sun, 14 Jun 2026 07:56:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 2nd set of fixes for the 7.1 cycle
Message-ID: <2026061459-unzip-linguini-6af8@gregkh>
References: <20260602151415.1c17664b@jic23-huawei>
 <20260613151436.4ed833ef@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613151436.4ed833ef@jic23-huawei>

On Sat, Jun 13, 2026 at 03:14:36PM +0100, Jonathan Cameron wrote:
> On Tue, 2 Jun 2026 15:14:15 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > The following changes since commit 329db447f8f02e82ff3acf130c892e1a4063d493:
> > 
> >   Merge tag 'iio-fixes-for-7.1a' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus (2026-05-15 13:45:33 +0200)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-7.1b
> > 
> > for you to fetch changes up to 91bc6767a4f55dc470d8a56b55b9f2ea09094efe:
> > 
> >   iio: adc: ad_sigma_delta: fix clear_pending_event for registerless devices (2026-05-29 09:57:23 +0100)
> > 
> Hi Greg,
> 
> I think this pull request is outstanding.  No problem with queuing it for the merge
> window and if we are too late for that I don't mind if it waits for rc1.

Ugh, gmail considered it spam for some reason, very sorry about that.
I'll just go add it to the pull request for 7.2-rc1.

greg k-h
