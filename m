Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74633BC69C
	for <linux-iio@vger.kernel.org>; Thu,  6 Aug 2026 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007071; cv=none; b=gtqWJ5BZfmnwGg05fXZmgbqtpIzYgZnjrrDac9XdlSSI752munXNEIBCMG1Qfjp+Py5PnTYC326A5UyGRds6s9ZA/UwrPaV7xU3AY32O09DtHua25YHrLPZmJTsMk6wQyx/rfafavSHE1hgLJ7FkwITLPZh0nEGJfLdWUJtXUlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007071; c=relaxed/simple;
	bh=LhscW7nbL2LM8MhGr9J8piebkrqpq+90KoU0DXYnBIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkwnZXwzdt6XDaxrRhws3v794EQ9uvN08lw0boEjAjYfrabHpvnzPYCMF993ln7mvv01tffAcgkBr6CeDpc61vBau2FJunuFPkr2Ws+pAkthinaWxJkfLLlg+ts2QDLoqKloXIgeBD29YGggJ4heR0YSHmKcItVGc0SqtTApUqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CMW0pxns; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CMW0pxns"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A941F000E9;
	Thu,  6 Aug 2026 09:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786007070;
	bh=Qckj+D514TCosDmfZCc19/weQLlPid3n+L3vAfPg82U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CMW0pxnsjdUjbsEBfJxB+43m3VxCnBRHeFA0TzJrkU97EsBenUozX5Emu9wibPnuB
	 JobMbmesA6kf1Gb7w++Odoy/VM4ITHl1S3Ij/39VNtzUtSOakktGReQ5HPXLEBAwL2
	 7J0jGiJuMDLeFFC8jzzwhFUIKx4m/RjAQQpeQW50=
Date: Thu, 6 Aug 2026 11:04:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [GIT PULL] Counter fixes for 7.2
Message-ID: <2026080602-wrench-prancing-548f@gregkh>
References: <20260805030250.1502786-1-wbg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805030250.1502786-1-wbg@kernel.org>

On Wed, Aug 05, 2026 at 12:02:49PM +0900, William Breathitt Gray wrote:
> The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:
> 
>   Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-7.2

Pulled and pushed out,t hanks.

greg k-h
