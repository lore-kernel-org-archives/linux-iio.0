Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A0737AA88;
	Thu, 22 Jan 2026 19:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769110452; cv=none; b=PS+JWbx77Mf0ZUukR+ETptGARz93oND2NjAPijj5NYC/oKKJYlatajUZ9dp8HzEm+GKGm8XGySlBmDTtzZvH0OYK3YCZeNftRO2m9JyAVAwNjXN0duKfcoLwIxKkYP8vi1XFUnzMIbLVdpU5xwNmo08lUUVChqwR8wpM8ZzI3eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769110452; c=relaxed/simple;
	bh=+64Zu3U/M+Jq4FDpAcyTJrOKnY3xTdHmADMOAeIJR4c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HWrwkX3aa7XNOqSGm9qZPxmLAenbRvT69VpRo8hnp7ozerjZ7KninTsj0en6V4TXbXfdfMolXbAsP4cWmNoW4aePEJDkTtAc5Zq0CahzSNVoGESXWDZWqcAaie7Y3lzdwvQqO3o2HA+/mFyxrebiIyOGQsR5C4I/qNjiyLUMDwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzBb6GJf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzBb6GJf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3A2C116C6;
	Thu, 22 Jan 2026 19:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769110451;
	bh=+64Zu3U/M+Jq4FDpAcyTJrOKnY3xTdHmADMOAeIJR4c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YzBb6GJf5mgOwnqUF+fqVL1cAwDmY3HC/Wj0hYMNSDQc6zUIfYOFR6AMEwpR09pWC
	 Ju/iyOtSsr4qcgl38vuVsmzmCz1wnp/x3jFVf0Ho+/kUUZYFdlFvUXxzxH+SJpziUM
	 xaKvIH1uycbdgArGXJxFUnR+0YcdzcNOwXKcTf3n1UPKTYS3a6Dba8XGdnCI6cs4Wk
	 3NA+rDaD7ThIhK3gkp9HAxd8YyR0ko4iYbDD+tqi2xoomNc2LXkm93tPrhgoCZjlxH
	 3sUXjbsgas+N9N18ZZWM18nR1rAg4tNsI6BGGVuLbEureWC97In6aMrKBIKCw5EHXr
	 m/C3iSyqTkV8Q==
Date: Thu, 22 Jan 2026 19:34:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Petre Rodan <petre.rodan@subdimension.ro>, Andreas Klinger
 <ak@it-klinger.de>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: mprls0025pa: remove error message
Message-ID: <20260122193404.5939d179@jic23-huawei>
In-Reply-To: <aW3nBgx_325IhDEi@smile.fi.intel.com>
References: <20260118-mprl_driver_followup-v1-1-5d5d6b03350b@subdimension.ro>
	<aW3nBgx_325IhDEi@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Jan 2026 10:10:46 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, Jan 18, 2026 at 01:19:39PM +0200, Petre Rodan wrote:
> > Do not print a duplicate error message if devm_request_irq() fails.  
> 
> > Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> > ---
> > A tiny followup to the mprls driver cleanup, as requested by Andy [1]  
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

Applied.

Thanks!

J
