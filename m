Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB70320CCC;
	Sat, 21 Mar 2026 19:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774121041; cv=none; b=HyAWfVt8kKYqxQN1vKiYi34Jy7dzdwu9y8IaWhsQlPydJ8KMX1urgj5ryuRelUgDaZ4UMFg6s45nydTFpql25FZF4G+H/TryPyc1AXQPGineRwNinzpSJ4VNt+1WMPb4ilb9mm5pc0e9zih7NcCmzyM2RE1GwYGzF727mjKKkk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774121041; c=relaxed/simple;
	bh=ISZZ8oBNm9qPdMpJhhI9CuZ1rwjTyS0mlHF1jgAqV68=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LnRL0mIseC79UgQAW/wEnGGP9oIQx7VSOvnHHGDV8ENgm6p/x4GfMbQpY9n6Y71qgeXUbD6aelDm+dS+DUHIP2NUtcIkBdUJMfQe9bkeR7Tm6JPUEcH9mf2qhVlZHrDMohM/sbDTy7hC4tG8uFhdr8u9AV452BXaKqvUTnp2HXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2fyJGw0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2fyJGw0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE18C19421;
	Sat, 21 Mar 2026 19:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774121041;
	bh=ISZZ8oBNm9qPdMpJhhI9CuZ1rwjTyS0mlHF1jgAqV68=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z2fyJGw03bWoXy1GZyl5EH+6WWxQJ+2J9diYh7Gl9gbkRbNE2JgrCSZNzmIuQryZa
	 M0wVTlF0bYQ7zo+Sjaql+Ijj2eibGL6y6Q/fN61Yd7XbIQG3ijORNG8TCC1J+2ClWF
	 zqaR1V95Dtx/nY6MSEHQTM8PUMOWo4N5BVYmJ0F4/+xV/evlgRtIVTrhay0qJTZ8CV
	 Rnzq+QcXIMh3EZSJ/1Cro8eqE7rvXCjejif4XK/ZwzTbkIEuF1iGaGBKM6NPuPUAza
	 am6TEhAx+aYIq/6O5SsgLlUkp5ABZUWrFudhDfP4v13VPu4dQK8Zu712Y5nnxUouMh
	 pKgBVcwRmq7og==
Date: Sat, 21 Mar 2026 19:23:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: andriy.shevchenko@intel.com, andy@kernel.org, dlechner@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 mazziesaccount@gmail.com, nuno.sa@analog.com
Subject: Re: [PATCH v5 09/14] iio: temp: fix spelling mistakes in comments
Message-ID: <20260321192352.2f231769@jic23-huawei>
In-Reply-To: <20260316090023.14691-10-i.shihao.999@gmail.com>
References: <20260316090023.14691-1-i.shihao.999@gmail.com>
	<20260316090023.14691-10-i.shihao.999@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 14:30:17 +0530
Shi Hao <i.shihao.999@gmail.com> wrote:

> Fix spelling mistakes in comments.
> 
> - catched -> caught
> - chanel -> channel
> 
> Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
Applied.

Tah

J
