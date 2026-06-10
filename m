Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEDF3B8124;
	Wed, 10 Jun 2026 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105812; cv=none; b=shr0ZqiqYNt/oFQEn4aogl8LkbXX/TKrXjqNwhDwBVCvtd87okS/4ySU6i/s1ZZ/TvBJQXMPWNxxKNhGc+XCZEclwL3WnIPtpueEL6p9qlLAO4CD5kPr/dIe8HpLDYJNYGf9uZonq/lbtzKoa8q263OoiGC+CLD7ha7zewX/7zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105812; c=relaxed/simple;
	bh=CB8MGLOFE0H4t72+PJqaTOxXMo/BO4pQNiYhjc33vwk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NVKtcdAxo08Q7cBYiY9BSc6FntwiFdGh6rehlsplFqiPrj+fars6jX75Mj9I1clE4vgaGbryegho4lxdQQkOfhBYI8cYz6a+CDoKMpyOyzauigQO8Z+NCMxdOS/8e4nAofsrm/caqaxjNss6jcTIDhwbST1VEITEdxRH7jd41Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R837Jfse; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R837Jfse"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964001F00893;
	Wed, 10 Jun 2026 15:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781105810;
	bh=VYZplOd5bRD7MJJ7rO16Sgucc2kFRJO9eO4jU6KVCas=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=R837Jfseej5FiRhuHXHg/66rFBs0siUpIn61F3zM4KvrOAzNQrM91DSECektNtPhC
	 AURPmW3iXdyxVgJP61pn1z+sxjbJb75WxX0wdCb/9lqTewJeOMT/WYzJ+rpfDJtcVf
	 HQ7AtijsNrokpziyylYJR9zOUB19TJLIoAHbMG3lVCX7Tlhjw0RsWBPicNIWzhQHmi
	 QnXvpiUHMCv+b1Sthi+pDVRx71AAQzmU/RbWzWsZkG3Do7MbQbxBXTaP42KJvfBM6n
	 mHR/jlzTtdjluIFO+VxiRpN1JmBwO+PpfXKSyn303ZTJQ9VBngvYNxqelcAIV9Sjfc
	 rL3SHS3NXRaPA==
Date: Wed, 10 Jun 2026 16:36:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Hungyu Lin <dennylin0707@gmail.com>, jagathjog1996@gmail.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: bmi323: remove unnecessary cast in
 watermark limit
Message-ID: <20260610163643.42dfc1eb@jic23-huawei>
In-Reply-To: <aigU_yoAQxKb6POn@ashevche-desk.local>
References: <20260608121558.85429-1-dennylin0707@gmail.com>
	<aigU_yoAQxKb6POn@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Jun 2026 16:28:31 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Jun 08, 2026 at 12:15:58PM +0000, Hungyu Lin wrote:
> > Remove the explicit u32 cast in the watermark limit calculation.
> > 
> > The BMI323_FIFO_FULL_IN_FRAMES macro can be used directly with
> > min() without triggering type issues.  
> 
> Right, now it looks much better.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 


Agreed. Easy to check these min conditions as there is good documentation in
minmax.h  Entry that is relevant here I think is this one.

* - Unsigned arguments can be compared against non-negative signed constants.


Applied to the testing branch of iio.git.

Thanks,

Jonathan
