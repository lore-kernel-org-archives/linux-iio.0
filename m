Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE491F8723
	for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 06:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787033848; cv=none; b=RNLR+CnScuJ9vJACtUOtkE2VYyfjMw9SkoGADbP+OgOyt7hFD+5UszhqG2+8qYZX8ACA+VONcMNAZTyeivlJz/3hzHSjQ7Ueyjj5+3JoU0wfa7ouXiNmDnVcyqvRTflyWUy7PDtdxl9rt0N2WFCRmzzv/37pV3FTQ3/VVUx1rmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787033848; c=relaxed/simple;
	bh=6JK/esHqQE3gtsla1o+Tnjw+q+jji5vSZRjT6Lh0Mno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIkHIvU+l4jv4fzlBZHSqbxy8qjA3El9FG7etqpXvalMZD2JvoHGtVkSG1a3rCQBNIcK/LPB0wVLaHhrsQJoqe8ch0aVpTtCXpIY6o2u8ZrTtWSyjSj3RBNOq5A0v85Fw2N6tfIUt8D+hcHBoteGnDbPsa2x059+cfjK2xxG6Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aUHb+6bl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aUHb+6bl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD641F000E9;
	Tue, 18 Aug 2026 06:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787033846;
	bh=W13AT4CDI2b66evAbWx6HXN57BWeIf1P2NvWSxB03+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aUHb+6blGi7wj9COarcydnvtJwjIM/lVhjTcslNTixf1eZreWGDsKhrAlPPq/Fq9N
	 HCaIdEi1jsFQ2W3ZUqj+rQoEHe6vIU/lKhbQWE494QnAM8gQiyzDGz8Fk9UXbDCCMa
	 dN7+SNSyTxpHdbU6CvZu00KVColWRtKyWsxjdXOg=
Date: Tue, 18 Aug 2026 08:15:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: New device support, features and cleanup for the 7.3
 cycle
Message-ID: <2026081827-divinity-glimpse-d08d@gregkh>
References: <20260808001046.3477ca05@jic23-huawei>
 <20260817212425.0a3973a8@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817212425.0a3973a8@jic23-huawei>

On Mon, Aug 17, 2026 at 09:24:25PM +0100, Jonathan Cameron wrote:
> On Sat, 8 Aug 2026 00:10:46 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > The following changes since commit 8cdeaa50eae8dad34885515f62559ee83e7e8dda:
> > 
> >   Linux 7.2-rc2 (2026-07-05 14:44:06 -1000)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-7.3a
> > 
> > for you to fetch changes up to 350d1fb9204b13c5f95e511e98b8bcb47574d425:
> > 
> >   iio: dac: mcp47a1: add support for new device (2026-08-05 01:09:56 +0100)
> >
> 
> Hi Greg,
> 
> Just a quick ping to check this one and the fixes pull request sent a few
> ours earlier haven't fallen through the cracks

It almost did, I will handle these later today, sorry for the delay, was
battling jet-lag...

greg k-h
