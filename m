Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65D2358387;
	Sun, 26 Apr 2026 13:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777210711; cv=none; b=piDrrjubSqtF68VpiqN6xWHzhZj/iFo3X4nCJS41JPHc0RyQKp8cgeIJToQbIVwWj8LXrQ9dQJ66CCNizrfYlVMciEhz7/Lxe4ilsZvZ8nxk/1MwzFfdEwhThkS9ROY6QuDdg4CptUCD2bigh2yFTJwLYJBzwrBn7Zcz8RHE7q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777210711; c=relaxed/simple;
	bh=wrtw7TzaX+nY0x+xKJ1l/g3tjY+hL6iAYtCT23/bm1c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dK6Lf3OpN83YK8tc79ugZ4Lb0d8i1a6m+x/p2l/r2KpCpGyxzaNZ2m65KCAkMvZi0t04jqKgmEBzgubxEP3oPd1t4tOTHpX72stDMQdoVt12eR52I8RRUgt+qWJJ6g/YWEIDdmgWcH4hg+RIeVx54f7tE2audleSaEnWX/LaCwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmF8UPyb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmF8UPyb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75AF5C2BCAF;
	Sun, 26 Apr 2026 13:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777210711;
	bh=wrtw7TzaX+nY0x+xKJ1l/g3tjY+hL6iAYtCT23/bm1c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kmF8UPybabx4Y1A0N8yu5/RaKIZHVyQLsPZOz/WdFa1u1k6nJshGkn8+cvBDa/yd1
	 nOCytAhzwYJAuP9Y+z1AWIXiG79GlK3l0A+H/sCoVu+hZHIBGH/IFGD7DaHJfzVtjv
	 MyctAFbrrSjXVyR6jBdjnG7QKNHeuqJskvG2YdOQVe8f5oAxp00eoXQRQxhj9N5fxO
	 2f+xR1k+PYFq8KHKD342spkh3XpEhansF+55gYI0gDGZw70wo2WxXMf/59QgOlG/kM
	 D0oOUL3NO1AVbAdzduN96p/AWptmp8uaVmq6Q9BTJgYptXyTrnXtenlkprvoviWQKx
	 v+T/DvZ8S9EBQ==
Date: Sun, 26 Apr 2026 14:38:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
 Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>,
 Michael Auchter <michael.auchter@ni.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Andy
 Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH 02/10] iio: dac: ad5686: remove redundant register
 definition
Message-ID: <20260426143824.463af045@jic23-huawei>
In-Reply-To: <20260426143211.1d0bc12e@jic23-huawei>
References: <20260426-ad5686-fixes-v1-0-7c946a77794e@analog.com>
	<20260426-ad5686-fixes-v1-2-7c946a77794e@analog.com>
	<20260426143211.1d0bc12e@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Apr 2026 14:32:11 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun, 26 Apr 2026 09:38:03 +0100
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > AD5683_REGMAP and AD5693_REGMAP behave the same way in the common code,
> > and that is because they target single channel devices from the same
> > sub-family. There is no reason to separate them and it will make things
> > simpler when refactoring the chip info table.
> > 
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>  
> This one stands well on it's own, so applied to the testing branch of iio.git.
> 
> IIO is very busy at the moment, so I'm trying to pick up anything
> that is ready, including individual patches from larger series.
> 
Dropped again. I didn't read on far enough.  The fixes in this series
need to come before all this stuff so they are easier to backport.

So dropped 2-4 from my tree pending that reorganization.

> Thanks,
> 
> Jonathan

