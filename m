Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385E13988E3
	for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787128033; cv=none; b=bXgv1Pot5f0OTKus5ScW0mTTyAa8J8yXEaHfYI+upoqVN5tGwAICHuIJnEM0GqrqZIF4xzbAxsjpVPBW5GZUW8uhETmREWTWzLKSEcIxD/KFNwSei6XBdyXShQZoevCsP5LYkfnmwp2kzpuuqB9beWA/4HeAt+I0FLm5aqCRCX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787128033; c=relaxed/simple;
	bh=5GexjHSKPN3CTMHHA9Eq41kh7m4OiivvxIMcSvWNxq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpCdPvR8wi8pVZNy6JZa9X32kFWH39y/FRdCHkjBiz1cPUhyB8vsdhMLIPjUYBe9ZmKR3Cy19k3UX6h17KZEFDVcvykJP6oxPNgcgTIXyAjTRv+UF6kqg62356+oOYjvLipGcjM0xBErAxO11rT4gHcg9Y+vdsncru8hfMzrTNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mhPcyJAI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mhPcyJAI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0CF1F000E9;
	Wed, 19 Aug 2026 08:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787128031;
	bh=muzlKMJ8mqRECQKgYKQg8Cqh9haXK6LndKjQ7q6d2H8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mhPcyJAIhlEnA9JldA4Oxh0yb9/XsgVJ90sZxC8z3xbJ9RA6hfO7OOE8WmPJOV5J1
	 87iE8zvT7ih0uiyNH97MHBELsdOC354IezorazQRaE5+pOdnEc6+lO1xQmxzgRFQs4
	 w1TXePmXV4YhzyCwDAXoW9W64TG7ppW5fwAebKBg=
Date: Wed, 19 Aug 2026 09:54:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: New device support, features and cleanup for the 7.3
 cycle
Message-ID: <2026081923-eating-karate-dac6@gregkh>
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

Now pulled and pushed out, sorry for the delay.

greg k-h
