Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A101638655C
	for <linux-iio@vger.kernel.org>; Mon,  8 Jun 2026 19:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780946857; cv=none; b=D6LjAP8CzfoMN1JD+mhg0SgoTIgPTpf5vJrQgR+VwJqOClYiYpAfVBICvBOYySYpse85Q/tl63j3+Y3aEtr1KtuSTXH7URPVta4ntnqeYU8MnTJd6M9JGsaFqrTt4IeyyGON7Iu8Jp1YIzm8YjnMV7u3Spp8oKau84/RjVKEy9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780946857; c=relaxed/simple;
	bh=DwrvekuNY8nAfQc4TOo5cES999fr7QobcwMexb4J9Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FythvuOM5fI44Adni6jROuvDjSesqzCf9FJpg01FId9bJXsXfNOY4qqAFSHKDpU1LGSslgWfCNSxH+I6IE+nwToY1l/30UnnxKgzPsKjgIM1awQUo9sXmoxbV86gJEf+5ZkDuGHuZN6NjOgaFAd52fTi7+vvNCl/T1Hll4KP4rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2Nqpx1gR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2Nqpx1gR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4AB1F00893;
	Mon,  8 Jun 2026 19:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780946856;
	bh=x5Gw3d8WZCwXg/xFRbZBoMdKF23B0DoG9P5A8wv4jvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=2Nqpx1gRPLwxH5GB3vAFH9rP5D2EPIrXi3Jo2krBXX/HZp9fGwqw6vAi5CKoW965u
	 sJPXXnzyBz+vBy+EDenfGiQnzlveAtdsyCacU/qPcxjLcyPoiHe8fFIs0u0UQQcS9H
	 kbwinU9a/uklJ/92CBf/8PngKAByzr/esHK6NNts=
Date: Mon, 8 Jun 2026 21:26:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [GIT PULL] Counter updates for 7.2
Message-ID: <2026060830-oxidize-alive-b048@gregkh>
References: <20260602024614.853294-1-wbg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602024614.853294-1-wbg@kernel.org>

On Tue, Jun 02, 2026 at 11:46:02AM +0900, William Breathitt Gray wrote:
> The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:
> 
>   Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-updates-for-7.2

Pulled and pushed out, thanks.

greg k-h
