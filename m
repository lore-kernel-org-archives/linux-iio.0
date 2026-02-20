Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642B63314C4;
	Fri, 20 Feb 2026 10:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771583876; cv=none; b=HkRWypb2ThOXuDhGIfarKY87FSw5iqvGYCvLLSftsDdMe7sQoiiNxXnfJSe+NxSCwvY49g3/RS8tppM8efjepei7LWyGID++6U0G4w6F/0eN6ZVCNQk3HHtDV2uJmUXoE353Iqw2KCnjkxcCi94l+/MxcuNX7NjgJR+K6zRykBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771583876; c=relaxed/simple;
	bh=XUzizJeszt9o9lm8mIzInNTxAR55zKLGCV8e73yIPjk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QkUdK0qLaQ0Jk8JD8Q0ZtfcHOfPWd5sOzJGd+255p2hex0ws1Ln7bI6yUOfRcSdVUpIUGh9fzV8BCiWwmrJ6UYC9dSJSFVA2dUVLQc/sqtN0FmN8R46LMwbKppvLo8ButzALq+eqELs1sGsTE/Vs6yFlBUeaBellBBmJTGhZzQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZL9jWzA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZL9jWzA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C20C116C6;
	Fri, 20 Feb 2026 10:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771583876;
	bh=XUzizJeszt9o9lm8mIzInNTxAR55zKLGCV8e73yIPjk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qZL9jWzA+w0/o3nVIqT+OnPK9UNkGnu2TgVWV8jUlzxT4HEKpwuGB41Ao4edG8Ysr
	 Ozvm/Ln2LMJC8RhDRuDwOT0RmqHJkntWedMVSVzuBz7GeB6JuzaqmNJgwl0OYq1+Ct
	 W9xyEtbOrHcM13OhMGiYT9c1lX2ws/LBaG5eZ4WLEK8RsQBot5usG1xKePLqYymUxQ
	 ID9F58Tx/qsQtbW/WHn82YulRWvYPKgJUqHTvNO2Sxb1SmikO7bHWrOh4PVwkvjgcU
	 foEel+jqAF6oojpFv2kDSbEjN2xbMdGQmexAb48DuiN365KwuLAY9eOBRsT/ClDvIl
	 JCCNeA5fr0jYA==
Date: Fri, 20 Feb 2026 10:37:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Neel Bullywon <neelb2403@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/3] iio: magnetometer: bmc150_magn: minor formatting
 cleanup
Message-ID: <20260220103736.70639aa8@jic23-huawei>
In-Reply-To: <aZLWu_7ozsmUZbtg@smile.fi.intel.com>
References: <20260216015454.61836-1-neelb2403@gmail.com>
	<20260216015454.61836-4-neelb2403@gmail.com>
	<aZLWu_7ozsmUZbtg@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Feb 2026 10:35:07 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, Feb 15, 2026 at 08:54:54PM -0500, Neel Bullywon wrote:
> > Improve initializer list style for bmc150_magn_samp_freq_table by
> > moving the opening brace to its own line and using one entry per line
> > with proper indentation and spaces inside braces.
> > 
> > Add spaces inside braces for initializer lists in the preset table
> > for consistency.
> > 
> > Fix indentation of bmc150_magn_scan_masks array. No functional changes.  
> 
> LGTM, FWIW,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

This is also independent of patch 1 so I've picked it up now.

Applied to the testing branch of iio.git

Thanks,

Jonathan
