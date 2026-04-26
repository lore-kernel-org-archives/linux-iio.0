Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015B419CCF5;
	Sun, 26 Apr 2026 13:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777210342; cv=none; b=eF88Gkq/6RrsLKUVXzobmPqgcvntmMZlbpDOplTR4Tb5Px8dC8gaCL10TjS3VwFqOEnM11AWcMujfr9gP0AAnGfQpPPjtKlnrz7IHSaoBYAiSkPpkR286/v+Crs3nQZUh1JCqdQkGT5WWWHIdCLpP9d1Y9Xr1x1sUUsjkUs6px8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777210342; c=relaxed/simple;
	bh=8KxLm0r2Xxxnm02HgotEwaFE8GhdWzdHz4DnO+UiqoI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oAvZcJq3rvkfeYRhTozOCe9v0Sfb0HmyUrHldojP4FtN9cywoH2brO0sFc1dcBAEHSQC2Kx+rN7S7es/urSGzSmYLKHjeJhDEsyG7xHnnv7H2dmPiBWBJeAc1yc/YrOHxrTOw5yi1KoH3YYUTx6KIO5CQKPtr7Lyqzv57wVkqIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoVxYQAi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoVxYQAi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F10C2BCAF;
	Sun, 26 Apr 2026 13:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777210341;
	bh=8KxLm0r2Xxxnm02HgotEwaFE8GhdWzdHz4DnO+UiqoI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DoVxYQAiIdlMesIEqfudl6tt1yoiAHcoGJ+2Qv+k6p+/3zc+8gRaGR0tZEkJ4Hyf1
	 KFy4IBcJvgeU1yTCbREw4um7dUv2RdVHwrjkeMz/gI4kxnElEPlZu/Lh/eBP8IuQZ0
	 5N9wVRxhVgpw9NPPjrivJ3cD0rx3SAXhjGmpNwOcrOZcvfZPLLC/6ZDi/eupXfGFk4
	 zedGaTe0LH3JnntfjEZxGWq4NzxQeVjEc+6A10xAg9AsMrKbMd+9ntSpi8P7ovIlGJ
	 WMKBuDtnfrZqJSq0H0oueO+/mVVh1A+2ii1IP+xfnphQBemRQUuyV7hnZGNRf+k+C1
	 rurGS8ihIK8gQ==
Date: Sun, 26 Apr 2026 14:32:11 +0100
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
Message-ID: <20260426143211.1d0bc12e@jic23-huawei>
In-Reply-To: <20260426-ad5686-fixes-v1-2-7c946a77794e@analog.com>
References: <20260426-ad5686-fixes-v1-0-7c946a77794e@analog.com>
	<20260426-ad5686-fixes-v1-2-7c946a77794e@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Apr 2026 09:38:03 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> AD5683_REGMAP and AD5693_REGMAP behave the same way in the common code,
> and that is because they target single channel devices from the same
> sub-family. There is no reason to separate them and it will make things
> simpler when refactoring the chip info table.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
This one stands well on it's own, so applied to the testing branch of iio.git.

IIO is very busy at the moment, so I'm trying to pick up anything
that is ready, including individual patches from larger series.

Thanks,

Jonathan
