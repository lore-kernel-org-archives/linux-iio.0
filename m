Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C59E2EEE90
	for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 03:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789960514; cv=none; b=Uigrv5wPp4faOmI8fJZ8xyMQ/uK6+tmTjDfoMjixD3znFk+hoYtmSWCPbw1pwb5uX+NU/ZyyVmKC7Wuqx7RaBqpfdhx3/r6+sjEqjFVrrYz7CLrJfArAz6lKw9pUb9fl48U3u3nXUFfjxC9DezRID8SzLg2vlOvvvuqfVRWNhCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789960514; c=relaxed/simple;
	bh=BtZWJ8mxCQuxkS5G0su4SgF0NZHDeIuDRu26YyCVSK8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pp8xkLMKJQASWkHR7FTFEalYXw9EMfcMXWXtHrPo1R3c83zeazEis6MpsbrOjaMPAfkZIrmdw05raCQ0/cVUHR2BB96k+py9dAg+hliudYc2lE6RdD5MNscuBQjI/v9C3vvomdlctj7ZjoqEJfbOhTq+nd1Mv8MzZewKBVjeOX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAxjx2mI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAxjx2mI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7701F000FF;
	Mon, 21 Sep 2026 03:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789960513;
	bh=HXMHuwlUiNYiMhsiipmQWGYFScsDkkwf0mwMXhef15Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CAxjx2mIoRsr9jbPiKUnMqZAoAQ0xJcIWpRUxcpr1pIETnSGmtbZ6CK0W0dK6UTer
	 SmMQ+7pH7xDFZshCa6jdKy3+SsYBOl01MRmPZwHqDqBtiO1T39a4aMPMFyetF9V6Ih
	 4/1v+P/ESHl3ix4LaW7ewcMK3xmLrIvkp6VHf+x7XhILgYoWLMQWMTXaQ91BkAtvP7
	 oXITIFqJkEYFD+6qET0gZEe6MSEUGKODzCtl9bWUJqKs3OFKjDdVC+IJEDr7Wdc7qW
	 X6cdc3Rxvj5FBpa6bTO1QDvy8I1P34EsZs4CgiSk7lrc+djukNfs6TZy4Ho1cK7KxU
	 zm70nGoISybNw==
Date: Mon, 21 Sep 2026 04:15:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>, Wadim Mueller
 <wafgo01@gmail.com>
Cc: "Li Youhong" <dayou5941@163.com>, wafgo01@gmail.com,
 maxwell@maxwelld.cc, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, Li Youhong
 <liyouhong@kylinos.cn>
Subject: Re: [PATCH v2] iio: flow: slf3s: disable regulator if measurement
 restart fails
Message-ID: <20260921041509.5e898d65@jic23-hlaptop>
In-Reply-To: <20260904100054.00004a58@gmail.com>
References: <20260904010902.1481157-1-dayou5941@163.com>
	<20260904100054.00004a58@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Sep 2026 10:00:54 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Fri,  4 Sep 2026 09:09:02 +0800
> "Li Youhong" <dayou5941@163.com> wrote:
> 
> > From: Li Youhong <liyouhong@kylinos.cn>
> > 
> > slf3s_resume() enables the vdd regulator and then starts continuous
> > measurement. If slf3s_start_meas() fails, resume returns an error
> > while leaving the regulator enabled.
> > 
> > After a failed resume the device stays suspended until another resume
> > attempt. That later resume will call regulator_enable() again. Without
> > a matching disable on the failed path, the regulator enable count is
> > skewed and the supply can remain on even after a successful suspend.
> > 
> > Disable vdd when slf3s_start_meas() fails so the enable/disable pairing
> > stays balanced across resume retries.
> > 
> > Fixes: d240b0b8a1ce ("iio: flow: add Sensirion SLF3S liquid flow sensor driver")
> > Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
> > ---  
> 
> LGTM.
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 
I'm not entirely sure where we are on this, but Wadim has
some related patches.  If we can figure out a consensus that
would be good. From tracking point of view I'm marking this one
as changes requested.

Jonathan


