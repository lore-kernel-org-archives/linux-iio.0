Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4208E3191C4
	for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 23:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772149755; cv=none; b=c72fSb3KEry6XBEQKVWWHsZAZZVhty3KbYcAsIkclTu1slnq2qqOzxVrPV9h/YAyzvWYM+FwIfdC+GRhPRZPyvVDX4aZgFsVrA/XUZ4hkrOenKgFhlAOppukQyxaJUgRKsu9xlZ48P+phv0BkBOh2nbxNiFrVEE3WjnjG7RIOJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772149755; c=relaxed/simple;
	bh=/S/uBg4SMtzYtZFDJ9R+FpHnbOgZ9XrrEnW8sR68DVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/qe3WPMCby+q+bIuab4HW7wTCGUF4Pu8CH5ogF80F3osg0bUfmETxu9phfDKFHpwqDTUlzE/hk/PlSFQTdaTZUQiQVQ97EsI67o3RX1PV5rscgtrOEnDRB8Udpl+smeAp4tGYeXU91DfqTNbwwSHOSMeQ4Z07PfB6vFEIvTdf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S70jOrQo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S70jOrQo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C03C116C6;
	Thu, 26 Feb 2026 23:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772149754;
	bh=/S/uBg4SMtzYtZFDJ9R+FpHnbOgZ9XrrEnW8sR68DVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S70jOrQoAfvrb6wOY6JYt0DqeteDVNAkhFTqGMsIhk9x8aM8G3J+6oH76NdvvXtBs
	 tkH6chbKiMoF0+ZeXKcnS883MUsX8ZHsfJ+oXdjRhhy9aRXN3GGp1qy+IwOWn1CQRu
	 L/hilX+popwLvTjBal6tfoCIK0TKkMvmB12DlrQk=
Date: Thu, 26 Feb 2026 15:49:06 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 1st set of fixes for 7.0
Message-ID: <2026022656-handsfree-echo-768f@gregkh>
References: <20260226102709.37fa6f2b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226102709.37fa6f2b@jic23-huawei>

On Thu, Feb 26, 2026 at 10:27:09AM +0000, Jonathan Cameron wrote:
> The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:
> 
>   Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-7.0a

Pulled and pushed out, thanks,

greg k-h
