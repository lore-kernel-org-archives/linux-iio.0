Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404A23E6387
	for <linux-iio@vger.kernel.org>; Mon,  8 Jun 2026 19:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780947003; cv=none; b=cXQPHMSl6MxrOVjEreyPKjhY89ZwtDEinrxGZSi3pMkm1z6uhkN03g51gUyGNoU0n3FiIBhla+B1y/D3rAtA+JQOUQpB6WK+hicM/kd4k5YUaNrxLAAoi+VF8yHSGcKKFVYupDOgSFghniZua/XBC/5OpzQF+v9IPUtscqlP3qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780947003; c=relaxed/simple;
	bh=D1z9hHFLCHpdlX8Ku2m/Lv0ieqalyevVUmXzsL4MsHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoB8WoqjmFkguJ31EfqAj8bLpKbVw1i7PdBC38NarEeRX6eqzhlzsUnXvTCvZyBRTdy12go7gV7I+AhMfaULG3BhhhOIrjRI6MoJuziKt6g7pbmOIkbG/JVEMO3a+6/eFF5Kb0roywRNsuit9wwe9uf7onD+stQ4ANu8Ovb7F9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PibVmiI7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PibVmiI7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5F11F00893;
	Mon,  8 Jun 2026 19:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780947002;
	bh=ZeiOaam716Q7zXcfjXGaSnXCkYhIt5cnzzgseZII0BM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PibVmiI7d7TMO2vkWB6MJxTdV9YEkINT28wzwi+Ceea/NjJuhltDK6HY61VBKsE9Z
	 cFqEV43n1PIPb5OGPKxb6qw+oxVP8KwuEI+aljBvFX/55OqMAlI09UJXNsRWSkbR18
	 IzutiyWV+8ZZs+5n3GDNjhHuC9GNX2yQNzhx/M4w=
Date: Mon, 8 Jun 2026 21:29:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: New device support, features and cleanup for 7.2
Message-ID: <2026060856-monoxide-customize-2c0d@gregkh>
References: <20260607182215.3e6e849e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607182215.3e6e849e@jic23-huawei>

On Sun, Jun 07, 2026 at 06:22:15PM +0100, Jonathan Cameron wrote:
> The following changes since commit e43ffb69e0438cddd72aaa30898b4dc446f664f8:
> 
>   Linux 7.1-rc6 (2026-05-31 15:14:24 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-7.2a

Pulled and pushed out, thanks.

greg k-h
