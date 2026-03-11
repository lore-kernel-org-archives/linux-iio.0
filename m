Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B49529E10F;
	Wed, 11 Mar 2026 06:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773211561; cv=none; b=uUc5o07fIJHxUcQZdBaOD+XEhHblurd5Pc/q99Xp4dEeDVDl/gxc/KkSgAcC2lSpi4bE+2PCKInpvx+gzeKEDOKo9t4ou/7sUqroXDQPyT5rHB3X+A7gV8enH2O3oa4MZTiVULHNHubWQSwKzDdxdXqnNdSWz/FSmZLEthpPa+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773211561; c=relaxed/simple;
	bh=4K6v1Z5uqrbPaJefI3o/9xr8KH389GbRCleWha8dTDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKj9m8gifcydeCIvffirywtVj43tLTF5UqsS1e5rjg8WHiaOhkwNG77WlIeUuCyIOBzoBr4/wPC3CpIqVjT8hHZDNjD1XzWFiKq1Zo5YDWNWEefF8tmEY0nkfbyU/Wax7jhclqWa1jGTs6WIh/hUfyY3FnKmuM9o+TxIOAxI7oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gdj3vTzE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gdj3vTzE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6281EC4CEF7;
	Wed, 11 Mar 2026 06:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773211561;
	bh=4K6v1Z5uqrbPaJefI3o/9xr8KH389GbRCleWha8dTDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gdj3vTzEsmEitF8OUwOBC4Z7mgN9nl2qpMZyAq3NGbvGf+E5Fnk63TDBjqtouqXdH
	 KFuNwxv6yz2T8EAIAv9RSlPM6zUKDG4ZO5932ROoDGKLIWT+1mYJbJIvJASRneeB4B
	 T+I35P8C69J22nUri6rrFfXwB1YhPK579ZzNmxDY=
Date: Wed, 11 Mar 2026 07:45:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, m.tretter@pengutronix.de, mchehab@kernel.org,
	p.zabel@pengutronix.de, tiffany.lin@mediatek.com,
	andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	johan@kernel.org, elder@kernel.org, pure.logic@nexus-software.ie,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	kernel@pengutronix.de, kees@kernel.org,
	nabijaczleweli@nabijaczleweli.xyz, marcelo.schmitt1@gmail.com,
	maudspierings@gocontroll.com, hverkuil+cisco@kernel.org,
	ribalda@chromium.org, straube.linux@gmail.com,
	dan.carpenter@linaro.org, lukagejak5@gmail.com,
	ethantidmore06@gmail.com, samasth.norway.ananda@oracle.com,
	karanja99erick@gmail.com, s9430939@naver.com, tglx@kernel.org,
	mingo@kernel.org, sun.jian.kdev@gmail.com, weibu@redadmin.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev, skhan@linuxfoundation.org
Subject: Re: [PATCH 7/7] staging: rtl8723bs: simplify cleanup using __free
Message-ID: <2026031102-decrease-preachy-6096@gregkh>
References: <20260310200513.2162018-1-sanjayembedded@gmail.com>
 <20260310200513.2162018-8-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310200513.2162018-8-sanjayembedded@gmail.com>

On Wed, Mar 11, 2026 at 01:35:13AM +0530, Sanjay Chitroda wrote:
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Replace manual cleanup logic with __free attribute from cleanup.h. This
> removes explicit kfree() calls and simplifies the error handling paths.
> 
> No functional change intended for kmalloc().
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
>  .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 13 ++-----
>  drivers/staging/rtl8723bs/hal/sdio_ops.c      | 37 ++++---------------
>  2 files changed, 11 insertions(+), 39 deletions(-)

As has been stated many times in the past, please do this for new code,
but not for existing code unless you are fixing a bug at the same time,
as the churn is not worth it (especially if you do not have the hardware
to test the changes with.)

thanks,

greg k-h
